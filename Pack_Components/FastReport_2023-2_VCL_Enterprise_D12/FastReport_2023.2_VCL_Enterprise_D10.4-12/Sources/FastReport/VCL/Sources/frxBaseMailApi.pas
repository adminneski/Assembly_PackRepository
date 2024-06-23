
{******************************************}
{                                          }
{              FastReport v6.0             }
{              frxBaseGoogleApi            }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxBaseMailApi;

interface

{$I frx.inc}

uses
  Classes, Forms, Controls, StdCtrls, ComCtrls, Dialogs,
  frxIOTransportHelpers, frxBaseTransportConnection, frxIOTransportOAuthDialog,
  frxBaseForm, frxIOTransportIntDialog, frxBaseTransportDialogForm;

type
  TfrxBaseMailIOTransportForm = class(TfrxBaseTransportDialogForm)
    ReqLB: TLabel;
    AddressE: TEdit;
    AddressLB: TLabel;
    MessageLB: TLabel;
    MessageM: TMemo;
    SubjectE: TEdit;
    SubjectLB: TLabel;
    FileLB: TLabel;
    FileE: TEdit;
    OkB: TButton;
    CancelB: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OkBClick(Sender: TObject);
  protected
    procedure FormCloseAct;
    function GetFileName: String; override;
    procedure SetFileName(const Value: String); override;
    procedure SetDialogMode(const Value: TfrxIOInternetDialogMode); override;
  public
    procedure UpdateResouces; override;
  end;

  TMailOpenForm = class(TfrxIOTransportDialogIntForm)
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TfrxLabel = class
  protected
    FId: String;
    FName: String;
  public
    constructor Create;
    property Id: String read FId write FId;
    property Name: String read FName write FName;
  end;

  TfrxMessage = class
  protected
    FId: String;
    FName: String;
  public
    constructor Create;
    property Id: String read FId write FId;
    property Name: String read FName write FName;
  end;

  TfrxMessageStack = class
  protected
    FfrxLabel: TfrxLabel;
    FfrxMessage: TfrxMessage;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Push(Id, Name: String);
    procedure Pop;
    property frxLabel: TfrxLabel read FfrxLabel write FfrxLabel;
    property frxMessage: TfrxMessage read FfrxMessage write FfrxMessage;
  end;

{$IFDEF DELPHI16}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxBaseMailIOTransport = class(TfrxHTTPIOTransport)
  private
    FAddress, FSubject: String;
    FMessageText: TStringList;
  protected
    FfrxMessageStack: TfrxMessageStack;

    procedure ChangeDirUP; override;
    procedure DialogDirCreate(Name: String; DirItems: TStrings); override;
    procedure DialogDirChange(Name, Id: String; DirItems: TStrings); override;
    procedure DialogDirDelete(Name, Id: String; DirItems: TStrings); override;
    procedure DialogFileDelete(Name, Id: String; DirItems: TStrings); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function TransportPostDialogClass(DM: TfrxIOInternetDialogMode): TfrxBaseFormClass; override;

    property Address: String read FAddress write FAddress;
    property Subject: String read FSubject write FSubject;
    property MessageText: TStringList read FMessageText;
  end;

  function LoadStringFromStream(Stream: TStream): String;
  function FormatMailName(Subject, Date, id: String): String;

implementation

uses
  Windows, SysUtils, Graphics,
  frxMapHelpers, frxRes, frxSaveFilterBrowser, frxUtils,
  frxJSON;

{$R *.dfm}

{ TfrxBaseMailIOTransportForm }

procedure TfrxBaseMailIOTransportForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FormCloseAct;
end;

procedure TfrxBaseMailIOTransportForm.FormCreate(Sender: TObject);
begin
  if UseRightToLeftAlignment then
    FlipChildren(True);
end;

procedure TfrxBaseMailIOTransportForm.FormCloseAct;
var
  DialTrans: TfrxBaseMailIOTransport;
begin
  DialTrans := TfrxBaseMailIOTransport(FIOTransport);
  DialTrans.Address := AddressE.Text;
  DialTrans.Subject := SubjectE.Text;
  DialTrans.MessageText.Assign(MessageM.Lines);
end;

function TfrxBaseMailIOTransportForm.GetFileName: String;
begin
  Result := FileE.Text;
end;

procedure TfrxBaseMailIOTransportForm.OkBClick(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to ComponentCount - 1 do
    if Components[i] is TLabel then
      (Components[i] as TLabel).Font.Style := [];
  if AddressE.Text = '' then
  begin
    AddressLB.Font.Style := [fsBold];
    ModalResult := mrNone;
  end;
  if SubjectE.Text = '' then
  begin
    SubjectLB.Font.Style := [fsBold];
    ModalResult := mrNone;
  end;
  if FileE.Text = '' then
  begin
    FileLB.Font.Style := [fsBold];
    ModalResult := mrNone;
  end;
  ReqLB.Visible := ModalResult = mrNone;
end;

procedure TfrxBaseMailIOTransportForm.SetFileName(const Value: String);
begin
  FileE.Text := Value;
end;

procedure TfrxBaseMailIOTransportForm.SetDialogMode(const Value: TfrxIOInternetDialogMode);
begin
  inherited;
  case FDialogMode of
    idmOpen: Caption := GetStr('IOOpenFile');
    idmDir: Caption := GetStr('IOSelectDir');
  end;
  FileLB.Visible := FDialogMode = idmSave;
  FileE.Visible := FDialogMode = idmSave;
 end;

procedure TfrxBaseMailIOTransportForm.UpdateResouces;
begin
  inherited;
  Caption := frxGet(8900);
  OkB.Caption := frxGet(1);
  CancelB.Caption := frxGet(2);
  AddressLB.Caption := frxGet(8904);
  SubjectLB.Caption := frxGet(8922);
  MessageLB.Caption := frxGet(8913);
  FileLB.Caption := frxGet(8723);
  ReqLB.Caption := frxGet(8918);
  AddressE.Hint := frxResources.Get('expMailAddr');
end;

{ TMailOpenForm }

constructor TMailOpenForm.Create(AOwner: TComponent);
begin
  inherited;
  DeleteButton.Visible := False;
  DeleteButton.Enabled := False;
  CreateDirectoryButton.Visible := False;
  CreateDirectoryButton.Enabled := False;
end;

{ TfrxLabel }

constructor TfrxLabel.Create;
begin
  FId := '';
  FName := '';
end;

{ TfrxMessage }

constructor TfrxMessage.Create;
begin
  FId := '';
  FName := '';
end;

{ TfrxMessageStack }

constructor TfrxMessageStack.Create;
begin
  FfrxLabel := TfrxLabel.Create;
  FfrxMessage := TfrxMessage.Create;
end;

destructor TfrxMessageStack.Destroy;
begin
  FfrxLabel.Free;
  FfrxMessage.Free;
  inherited;
end;

procedure TfrxMessageStack.Push(Id, Name: String);
begin
  if (frxLabel.Id = '') then
  begin
    frxLabel.Id := Id;
    frxLabel.Name := Name;
  end
  else
  begin
    frxMessage.Id := Id;
    frxMessage.Name := Name;
  end;
end;

procedure TfrxMessageStack.Pop;
begin
  if (frxMessage.Id <> '') then
  begin
    frxMessage.Id := '';
    frxMessage.Name := '';
  end
  else
  begin
    frxLabel.Id := '';
    frxLabel.Name := '';
  end;
end;

{ TfrxBaseMailIOTransport }

procedure TfrxBaseMailIOTransport.ChangeDirUP;
begin
  FfrxMessageStack.Pop;
end;

procedure TfrxBaseMailIOTransport.DialogDirCreate(Name: String; DirItems: TStrings);
begin
end;

procedure TfrxBaseMailIOTransport.DialogDirChange(Name, Id: String;
  DirItems: TStrings);
begin
  if Name = '..' then
    FfrxMessageStack.Pop
  else
    FfrxMessageStack.Push(Id, Name);
  GetDirItems(DirItems);
end;

procedure TfrxBaseMailIOTransport.DialogDirDelete(Name, Id: String; DirItems: TStrings);
begin
end;

procedure TfrxBaseMailIOTransport.DialogFileDelete(Name, Id: String; DirItems: TStrings);
begin
end;

constructor TfrxBaseMailIOTransport.Create(AOwner: TComponent);
begin
  inherited;
  FMessageText := TStringList.Create;
  FfrxMessageStack := TfrxMessageStack.Create;
end;

destructor TfrxBaseMailIOTransport.Destroy;
begin
  FfrxMessageStack.Free;
  FMessageText.Free;
  inherited;
end;

class function TfrxBaseMailIOTransport.TransportPostDialogClass(DM: TfrxIOInternetDialogMode): TfrxBaseFormClass;
begin
  case (DM) of
    idmOpen: Result := TMailOpenForm;
    idmDir, idmSave: Result := TfrxBaseMailIOTransportForm;
    else raise Exception.Create('Error 807: undefined mode');
  end;
end;

{ Support }

function LoadStringFromStream(Stream: TStream): String;
var
  tmp: TStringList;
begin
  tmp := TStringList.Create;
  tmp.LoadFromStream(Stream);
  Result := tmp.Text;
  FreeAndNil(tmp);
end;

function FormatMailName(Subject, Date, id: String): String;
begin
  Result := '"' + Subject + '" - "' + Date + '" - ' + id;
end;

end.
