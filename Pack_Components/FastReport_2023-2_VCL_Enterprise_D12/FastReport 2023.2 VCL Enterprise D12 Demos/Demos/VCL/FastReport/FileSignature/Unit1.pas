unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    SignByCryptoAPIButton: TButton;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    GroupBox1: TGroupBox;
    MessageLabel: TLabel;
    SignatureLabel: TLabel;
    MessageButton: TButton;
    SignatureButton: TButton;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    SubjectEdit: TEdit;
    IssuerEdit: TEdit;
    PasswordEdit: TEdit;
    DateFormatEdit: TEdit;
    NotBeforeEdit: TEdit;
    NotAfterEdit: TEdit;
    Label6: TLabel;
    GroupBox3: TGroupBox;
    DetachedCheckBox: TCheckBox;
    ChainCheckBox: TCheckBox;
    OnlyGOSTCheckBox: TCheckBox;
    DebugLogCheckBox: TCheckBox;
    DebugLogMemo: TMemo;
    IgnoreCaseCheckBox: TCheckBox;
    PFXButton: TButton;
    PFXLabel: TLabel;
    PFXCheckBox: TCheckBox;
    TimeStampGroupBox: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label7: TLabel;
    TSAServerEdit: TEdit;
    BESRadioButton: TRadioButton;
    TRadioButton: TRadioButton;
    XLongTime1RadioButton: TRadioButton;
    SignByCryptoAPIAndCryptoProSDKButton: TButton;
    SignByCryptoProSDKButton: TButton;
    procedure SignByCryptoAPIButtonClick(Sender: TObject);
    procedure MessageButtonClick(Sender: TObject);
    procedure SignatureButtonClick(Sender: TObject);
    procedure PFXButtonClick(Sender: TObject);
    procedure BESRadioButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  frxFileSignature, frxFileSignatureErrorDialog, frxCades;

function IsEqualFiles(const File1, File2: TFileName): Boolean;
var
  ms1, ms2: TMemoryStream;
begin
  ms1 := TMemoryStream.Create;
  try
    ms1.LoadFromFile(File1);
    ms2 := TMemoryStream.Create;
    try
      ms2.LoadFromFile(File2);
      Result := (ms1.Size = ms2.Size) and
                CompareMem(ms1.Memory, ms2.Memory, ms1.Size);
    finally
      ms2.Free;
    end;
  finally
    ms1.Free;
  end
end;

procedure TForm1.SignByCryptoAPIButtonClick(Sender: TObject);
var
  Lookup: TCertificateStoreLookup;
  FS: TfrxFileSignature;
  FSO: Integer;
  SignatureType: WORD;
begin
  Lookup := TCertificateStoreLookup.Create;
  Lookup.IgnoreCase := Self.IgnoreCaseCheckBox.Checked;
  Lookup.Issuer := IssuerEdit.Text;
  Lookup.NotBefore := NotBeforeEdit.Text;
  Lookup.NotAfter := NotAfterEdit.Text;
  Lookup.Subject := SubjectEdit.Text;
  Lookup.DateFormat := DateFormatEdit.Text;
  Lookup.CertificatePath := PFXLabel.Caption;

  FSO := FileSignatureOptions(
    DetachedCheckBox.Checked,
    ChainCheckBox.Checked,
    OnlyGOSTCheckBox.Checked,
    DebugLogCheckBox.Checked,
    PFXCheckBox.Checked);

  if      BESRadioButton.Checked then
    SignatureType := CADES_BES
  else if TRadioButton.Checked then
    SignatureType := CADES_T
  else // XLongTime1RadioButton.Checked
    SignatureType := CADES_X_LONG_TYPE_1;

  FS := TfrxFileSignature.Create(
    Lookup,
    MessageLabel.Caption,
    SignatureLabel.Caption,
    AnsiString(PasswordEdit.Text),
    FSO,
    SignatureType,
    TSAServerEdit.Text);

// If you have a 64-bit application, you need to install
// the 64-bit CryptoPro EDS Runtime (https://www.cryptopro.ru/downloads)
// and connect the 64-bit cades.dll here
//   FS.SetCryptoProSDKPath('C:\Windows\WinSxS\Fusion\amd64_cryptopro.pki.cades_a6d31b994cfcddc4_none_6e142348064635f4\2.0\2.0.14271.0\cades.dll');
// In your case, the path may be different.

  if      Sender = SignByCryptoAPIButton then
    FS.SignByCryptoAPI
  else if Sender = SignByCryptoProSDKButton then
    FS.SignByCryptoProSDK
  else if Sender = SignByCryptoAPIAndCryptoProSDKButton then
    FS.SignByCryptoAPIStampByCryptoProSDK
    ;

  DebugLogMemo.Clear;
  if FS.DebugLog <> nil then
    DebugLogMemo.Lines.AddStrings(FS.DebugLog);

  if FS.Status <> ssOK then
    FileSignatureErrorDialog(FS, [mbOK])
  else
    ShowMessage('Success');

  FS.Free;
  Lookup.Free;
end;

procedure TForm1.PFXButtonClick(Sender: TObject);
begin
  OpenDialog1.Filter := 'All Supported Certificates|*.pfx;*.p12';
  if OpenDialog1.Execute then
    PFXLabel.Caption := OpenDialog1.FileName;
end;

procedure TForm1.BESRadioButtonClick(Sender: TObject);
begin
  TimeStampGroupBox.Visible := Sender <> BESRadioButton;
end;

procedure TForm1.MessageButtonClick(Sender: TObject);
begin
  OpenDialog1.Filter := 'Any file|*.*';
  if OpenDialog1.Execute then
    MessageLabel.Caption := OpenDialog1.FileName;
end;

procedure TForm1.SignatureButtonClick(Sender: TObject);
begin
  SaveDialog1.Filter := 'Any file|*.*';
  if SaveDialog1.Execute then
    SignatureLabel.Caption := SaveDialog1.FileName;
end;

end.
