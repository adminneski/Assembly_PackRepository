unit frxSignatureErrorDialog;

interface

{$I frx.inc}

uses
{$IFNDEF FPC}
  Windows, Messages,
{$ELSE}
  LCLType, LCLIntf, LCLProc, LazHelper, ColorBox,
{$ENDIF}
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, frxCtrls, frxBaseForm, frxPDFSignature, frxHelpers
{$IFDEF FPC}
  , EditBtn
{$ENDIF};

type
  TfrxSignatureErrorDialog = class(TfrxBaseForm)
    btnOk: TButton;
    btnCancel: TButton;
    cbSaveLog: TCheckBox;
    lblDescription: TLabel;
    btnIgnore: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FDebugLog: TLogList;

    function IsHaveLog: Boolean;
    function IsGetLogFileName(out FileName: TFileName): boolean;
  public
    procedure UpdateResouces; override;

    property DebugLog: TLogList write FDebugLog;
  end;

function SignatureErrorDialog(Signature: TfrxPDFSignature;
  Buttons: TMsgDlgButtons): TModalResult;

implementation

{$IFNDEF FPC}
{$R *.dfm}
{$ELSE}
{$R *.lfm}
{$ENDIF}

uses
  frxUtils, frxRes, frxMapHelpers
  {$IfNDef NONWINFPC}
  , ShlObj
  {$EndIf}
  ;

{ SignatureErrorDialog }

function ErrorDescription(SignatureStatus: TSignatureSatus): string;
begin
  case SignatureStatus of
    ssWrongPassword:           Result := frxResources.Get('WrongPassword');
    ssUnknownHashAlgorithm:    Result := frxResources.Get('UnknownHashAlgorithm');
    ssUnknownChipherAlgorithm: Result := frxResources.Get('UnknownChipherAlgorithm');
    ssInvalidASN1file:         Result := frxResources.Get('InvalidASN1File');
    ssCantParseCertificate:    Result := frxResources.Get('CantParseCertificate');
    ssPrepareSignError:        Result := frxResources.Get('PrepareSignError');
    ssSignDigestError:         Result := frxResources.Get('SignDigestError');
    ssCertificateNotFound:     Result := frxResources.Get('CertificateNotFound');
    else
      Result := 'Unknown Signature Error';
  end;
end;

function SignatureErrorDialog(Signature: TfrxPDFSignature;
  Buttons: TMsgDlgButtons): TModalResult;
var
  SED: TfrxSignatureErrorDialog;
begin
  SED := TfrxSignatureErrorDialog.Create(nil);
  try
    SED.lblDescription.Caption := ErrorDescription(Signature.Status);

    SED.DebugLog := Signature.DebugLog;
    SED.cbSaveLog.Visible := SED.IsHaveLog;

    SED.btnOk.Visible := mbOK in Buttons;
    SED.btnCancel.Visible := mbCancel in Buttons;
    SED.btnIgnore.Visible := mbIgnore in Buttons;

    Result := SED.ShowModal;
  finally
    SED.Free;
  end;

end;

{ TfrxSignatureErrorDialog }

procedure TfrxSignatureErrorDialog.FormClose(Sender: TObject; var Action: TCloseAction);
var
  FileName: TFileName;
begin
  if cbSaveLog.Checked and IsGetLogFileName(FileName) then
    FDebugLog.SaveAppend(FileName);
end;

procedure TfrxSignatureErrorDialog.FormCreate(Sender: TObject);
begin
  FDebugLog := nil;
end;

function GetSpecialPath(CSIDL: word): string;
var
  s:  string;
begin
  s := '';
  {$IfDef MSWINDOWS}
    {$IfNDef FPC}
  SetLength(s, MAX_PATH);
  if not SHGetSpecialFolderPath(0, PChar(s), CSIDL, True) then
    s := '';
    {$EndIf}
  {$EndIf}
  Result := PChar(s);
end;

function TfrxSignatureErrorDialog.IsGetLogFileName(out FileName: TFileName): boolean;
const
  MyDocuments = $5; // CSIDL_PERSONAL
var
  SaveDialog: TSaveDialog;
begin
  SaveDialog := TSaveDialog.Create(nil);
  try
    SaveDialog.InitialDir := GetSpecialPath(MyDocuments);
    SaveDialog.FileName := 'FRLog.txt';
    SaveDialog.DefaultExt := '.txt';
    Result := SaveDialog.Execute;
    if Result then
      FileName := SaveDialog.FileName;
  finally
    SaveDialog.Free;
  end;
end;

function TfrxSignatureErrorDialog.IsHaveLog: Boolean;
begin
  Result := Assigned(FDebugLog) and (Trim(FDebugLog.Text) <> '');
end;

procedure TfrxSignatureErrorDialog.UpdateResouces;
begin
  inherited;
  Translate(Self); // TODO : Move to base class
end;

end.
