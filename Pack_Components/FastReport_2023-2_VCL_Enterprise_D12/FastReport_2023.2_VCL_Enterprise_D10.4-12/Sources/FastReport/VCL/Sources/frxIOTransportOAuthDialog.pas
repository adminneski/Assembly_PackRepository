
{******************************************}
{                                          }
{              FastReport v6.0             }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxIOTransportOAuthDialog;

interface

{$I frx.inc}

uses
  Classes, Forms, Controls, StdCtrls, ComCtrls,
  frxClass, frxIOTransportHelpers, frxBaseTransportConnection, Buttons, ExtCtrls,
  Graphics;

type
  TfrxOAuthTransportDialog = class(TfrxBaseOAuthTransportDialog)
    OkB: TButton;
    CancelB: TButton;
    RequiredLabel: TLabel;
    RememberPropertiesCheckBox: TCheckBox;
    PageControl: TPageControl;
    GeneralTabSheet: TTabSheet;
    ClientIDEdit: TEdit;
    ClientIDLabel: TLabel;
    RemoteDirComboBox: TComboBox;
    RemoteDirLabel: TLabel;
    ProxyTabSheet: TTabSheet;
    UseProxyServerCheckBox: TCheckBox;
    ProxyPasswordLabel: TLabel;
    ProxyUserNameLabel: TLabel;
    ProxyPortLabel: TLabel;
    ProxyHostLabel: TLabel;
    ProxyPasswordEdit: TEdit;
    ProxyUserNameEdit: TEdit;
    ProxyPortComboBox: TComboBox;
    ProxyHostComboBox: TComboBox;
    ClientSecEdit: TEdit;
    ClientSecLabel: TLabel;
    SpeedButton1: TSpeedButton;
    HideIdBtn: TSpeedButton;
    HideSecretBtn: TSpeedButton;
    OpenEyeImg: TImage;
    CloseEyeImg: TImage;
    SaveTokenCB: TCheckBox;
    ClearBtn: TButton;
    procedure ClearBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OkBClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ProxyPortComboBoxKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure HideIdBtnClick(Sender: TObject);
    procedure UseProxyServerCheckBoxClick(Sender: TObject);
    procedure OpenHelpLink(Sender: TObject);
  protected
    function GetClientID: String; override;
    function GetClientSecret: String; override;
    function GetHelpLink: String; virtual; abstract;
  private
    procedure RequireIf(L: TLabel; Flag: Boolean; MR: integer = mrNone);
  public
    procedure InitControlsFromFilter(TransportFilter: TfrxInternetIOTransport); override;
    procedure InitFilterFromDialog(TransportFilter: TfrxInternetIOTransport); override;
    procedure UpdateResouces; override;
  end;

implementation

{$R *.dfm}

uses
  Windows, SysUtils, frxMapHelpers, frxRes, frxSaveFilterBrowser, frxUtils,
  frxJSON, Variants, StrUtils, ShellAPI;

procedure TfrxOAuthTransportDialog.ClearBtnClick(Sender: TObject);
begin
  IniSaveStringCrypt(ClientIDEdit.Name, '');
  IniSaveStringCrypt(ClientSecEdit.Name, '');
  IniSaveStringCrypt(frxTransportTokenName, '');
end;

{ TfrxDropboxIOTransportForm }

procedure TfrxOAuthTransportDialog.FormCreate(Sender: TObject);
begin
  Translate(Self);

  RequiredLabel.Visible := False;
  UseProxyServerCheckBox.Checked := False;
  FErrorMessage := '';
end;

procedure TfrxOAuthTransportDialog.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then
    frxResources.Help(Self);
end;

procedure TfrxOAuthTransportDialog.FormShow(Sender: TObject);
begin
  HideIdBtnClick(HideIdBtn);
  HideIdBtnClick(HideSecretBtn);
end;

function TfrxOAuthTransportDialog.GetClientID: String;
begin
  Result := ClientIDEdit.Text;
end;

function TfrxOAuthTransportDialog.GetClientSecret: String;
begin
  Result := ClientSecEdit.Text;
end;

procedure TfrxOAuthTransportDialog.HideIdBtnClick(Sender: TObject);
  procedure HideText(IsShowed: Boolean);
  var
    ch: Char;
  begin
    if IsShowed then
      ch := #0
    else
      ch := '*';
    if Sender = HideIdBtn then
      ClientIDEdit.PasswordChar := ch
    else
     ClientSecEdit.PasswordChar := ch;
  end;
begin
  HideText(TSpeedButton(Sender).Down);
  if TSpeedButton(Sender).Down then
    TSpeedButton(Sender).Glyph.Assign(OpenEyeImg.Picture.Graphic)
  else
    TSpeedButton(Sender).Glyph.Assign(CloseEyeImg.Picture.Graphic);
end;

procedure TfrxOAuthTransportDialog.InitControlsFromFilter(
  TransportFilter: TfrxInternetIOTransport);
var
  aFilter: TfrxHTTPIOTransport;
  s: String;
begin
  inherited;
  aFilter := TfrxHTTPIOTransport(TransportFilter);
  RememberPropertiesCheckBox.Visible := aFilter.UseIniFile;
  if aFilter.UseIniFile then
  begin
    ClientIDEdit.Text := IniLoadStringCrypt(ClientIDEdit.Name);
    if ClientIDEdit.Text = '' then // try old method
      IniLoadEdit(ClientIDEdit);
    ClientSecEdit.Text := IniLoadStringCrypt(ClientSecEdit.Name);
    if ClientSecEdit.Text = '' then // try old method
      IniLoadEdit(ClientSecEdit);
    s := aFilter.AccessToken;
    try
      aFilter.AccessToken := IniLoadStringCrypt(frxTransportTokenName);
      if aFilter.AccessToken <> '' then
        aFilter.TestToken;
    finally
      if aFilter.AccessToken = '' then
      begin
        aFilter.AccessToken := s;
        IniSaveStringCrypt(frxTransportTokenName, aFilter.AccessToken);
      end;
    end;
    IniLoadComboBoxWithItems(RemoteDirComboBox);
    aFilter.ClientID := ClientIDEdit.Text;
    aFilter.ClientSecret := ClientSecEdit.Text;
    IniLoadCheckBox(UseProxyServerCheckBox);
    IniLoadComboBoxWithItems(ProxyHostComboBox);
    IniLoadComboBoxWithItems(ProxyPortComboBox);
    IniLoadEdit(ProxyUserNameEdit);
    IniLoadEdit(ProxyPasswordEdit);
  end
  else
  begin
    ClientIDEdit.Text := TfrxHTTPIOTransport(TransportFilter).ClientID;
    ClientSecEdit.Text := aFilter.ClientSecret;
    RemoteDirComboBox.Text := aFilter.RemoteDir;
    UseProxyServerCheckBox.Checked := aFilter.UseProxyServer;
    ProxyHostComboBox.Text := aFilter.ProxyHost;
    ProxyPortComboBox.Text := IntToStr(aFilter.ProxyPort);
    ProxyUserNameEdit.Text := aFilter.ProxyUserName;
    ProxyPasswordEdit.Text := aFilter.ProxyPassword;
  end;
  aFilter.AssignOriginalSharedProperties;
end;

procedure TfrxOAuthTransportDialog.InitFilterFromDialog(
  TransportFilter: TfrxInternetIOTransport);
var
  aFilter: TfrxHTTPIOTransport;
begin
  aFilter := TfrxHTTPIOTransport(TransportFilter);
  aFilter.ClientID := ClientIDEdit.Text;
  aFilter.RemoteDir := RemoteDirComboBox.Text;

  aFilter.UseProxyServer := UseProxyServerCheckBox.Checked;
  aFilter.ProxyHost := ProxyHostComboBox.Text;
  aFilter.ProxyPort := StrToIntDef(ProxyPortComboBox.Text, aFilter.DefaultProxyPort);
  aFilter.ProxyUserName := ProxyUserNameEdit.Text;
  aFilter.ProxyPassword := ProxyPasswordEdit.Text;
  if aFilter.UseIniFile then
  begin
    IniSaveComboBoxItem(RemoteDirComboBox);
    IniSaveComboBoxItem(ProxyHostComboBox);
    IniSaveComboBoxItem(ProxyPortComboBox);

    if RememberPropertiesCheckBox.Checked then
    begin
      //IniSaveEdit(ClientIDEdit);
      //IniSaveEdit(ClientSecEdit);
      IniSaveStringCrypt(ClientIDEdit.Name, ClientIDEdit.Text);
      IniSaveStringCrypt(ClientSecEdit.Name, ClientSecEdit.Text);
      IniSaveComboBox(RemoteDirComboBox);
      IniSaveCheckBox(UseProxyServerCheckBox);
      IniSaveComboBox(ProxyHostComboBox);
      IniSaveComboBox(ProxyPortComboBox);
      IniSaveEdit(ProxyUserNameEdit);
      IniSaveEdit(ProxyPasswordEdit);
    end;
    { handles separate from RememberPropertiesCheckBox}
    if SaveTokenCB.Checked then
      IniSaveStringCrypt(frxTransportTokenName, aFilter.AccessToken);
  end;
  inherited;
end;

procedure TfrxOAuthTransportDialog.OkBClick(Sender: TObject);
var
  ClientIDRequired, ProxyHostRequired: Boolean;
begin
  ClearLabelsFontStyle(Self);

  RequireIf(RequiredLabel, True, mrOK);

  ClientIDRequired := ClientIDEdit.Text = '';
  RequireIf(ClientIDLabel, ClientIDRequired);

  ProxyHostRequired := (UseProxyServerCheckBox.Checked)
                   and (ProxyHostComboBox.Text = '');
  RequireIf(ProxyHostLabel, ProxyHostRequired);

  if ClientIDRequired then
    PageControl.ActivePage := GeneralTabSheet
  else if ProxyHostRequired then
    PageControl.ActivePage := ProxyTabSheet;

  RequiredLabel.Visible := ModalResult = mrNone;
  FFilter.TestToken;
  if (ModalResult = mrOK) and not GetTokenDialog then
  begin
    if FErrorMessage <> '' then
      frxErrorMsg(FErrorMessage);
    ModalResult := mrNone;
  end;
end;

procedure TfrxOAuthTransportDialog.OpenHelpLink(Sender: TObject);
begin
  ShellExecute(0, 'open', @GetHelpLink[1], nil, nil, SW_NORMAL)
end;

procedure TfrxOAuthTransportDialog.ProxyPortComboBoxKeyPress(Sender: TObject;
  var Key: Char);
begin
  case Key of
    '0' .. '9': ;
    #8: ;
  else
    Key := #0;
  end;
end;

procedure TfrxOAuthTransportDialog.RequireIf(L: TLabel; Flag: Boolean;
  MR: integer = mrNone);
begin
  if Flag then
  begin
    L.Font.Style := [fsBold];
    L.Font.Color := clRed;
    ModalResult := MR;
  end;
end;

procedure TfrxOAuthTransportDialog.UpdateResouces;
begin
  inherited;
  HideIdBtn.Hint := frxGet(6496);
  HideSecretBtn.Hint := frxGet(6496);
  SpeedButton1.Hint := frxGet(6497);
  TranslateControlsByTag(Self);
end;

procedure TfrxOAuthTransportDialog.UseProxyServerCheckBoxClick(Sender: TObject);
var
  bEnabled: Boolean;
begin
  bEnabled := UseProxyServerCheckBox.Checked;
  ProxyPasswordEdit.Enabled := bEnabled;
  ProxyUserNameEdit.Enabled := bEnabled;
  ProxyPortComboBox.Enabled := bEnabled;
  ProxyHostComboBox.Enabled := bEnabled;
end;

end.
