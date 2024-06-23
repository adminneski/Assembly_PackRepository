unit Gobt_WebLabel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ShellAPI, Registry;

const
  crURLCursor = 8888;
  defURL = 'http://www.neski.com.br';
  defMailto = 'neski@neski.com.br';
  pref_http = 'http://';
  pref_mailto = 'mailto:';

type

  TWebLabelType = (Auto, Passive, Link);
  TWebLabelLinkType = (http, mailto);

  TGoWebLabel = class(TCustomLabel)
  private
    FURL: String;
    FURLCaption: TCaption;
    FShowPrefix: Boolean;
    FCaptionChanged: Boolean;
    FLabelType: TWebLabelType;
    FLinkType: TWebLabelLinkType;
    FLinkAble: Boolean;
    FURLAsHint: Boolean;
    procedure SetURL(Value: String);
    procedure SetShowPrefix(Value: Boolean);
    procedure SetLabelType(Value: TWebLabelType);
    procedure SetLinkType(Value: TWebLabelLinkType);
    procedure SetURLCaption(Value: TCaption);
    function GetCaption: TCaption;
    procedure SetCaption(Value: TCaption);
    procedure SetURLAsHint(Value: Boolean);
    function GetApplicationPathFromExt(const Ext: String): String;
  protected
    procedure CheckLinkAble;
    procedure SetViewFont;
    procedure SetTheCaption;
    procedure UpdateHint;
    procedure Click; override;
  public
    constructor Create(AOwner: TComponent); override;
    property LinkAble: Boolean read FLinkAble;
    property URLCaption: TCaption read FURLCaption;
  published
    property Anchors;
    property Align;
    property Alignment;
    property AutoSize;
    property ShowHint;
    property Transparent;
    property Color;
    property Enabled;
    property Font;
    property ParentShowHint;
    property PopupMenu;
    property Visible;
    property WordWrap;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    // published declarations
    property Caption read GetCaption write SetCaption;
    property URL: String read FURL write SetURL;
    property URLAsHint: Boolean read FURLAsHint write SetURLAsHint;
    property ShowPrefix: Boolean read FShowPrefix write SetShowPrefix;
    property LabelType: TWebLabelType read FLabelType write SetLabelType;
    property LinkType: TWebLabelLinkType read FLinkType write SetLinkType;
  end;


implementation

uses MAPI;


constructor TGoWebLabel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  CheckLinkAble;
  ShowAccelChar := False;
  // Set web page, and update the caption
  SetURL(defURL);
  // Set the font used for view
  SetViewFont;
  // Use the Hint property as full URL notify
  FURLAsHint := True;
end;


procedure TGoWebLabel.SetViewFont;
begin
  if FLabelType = Link then begin
    Font.Color := clBlue;
    Font.Style := Font.Style + [fsUnderline];
    if not (csDesigning in ComponentState) then
      Cursor := crHandPoint;
  end else if FLinkAble and (FLabelType = Auto) then begin
    Font.Color := clBlue;
    Font.Style := Font.Style + [fsUnderline];
    if not (csDesigning in ComponentState) then
      Cursor := crHandPoint;
  end else begin
    Font.Color := clGray;
    Font.Style := Font.Style - [fsUnderline];
    if not (csDesigning in ComponentState) then
      Cursor := crDefault;
  end;
end;


procedure TGoWebLabel.SetURL(Value: String);
var
  S: String;
begin
  if FURL <> Value then begin
    if Pos('@', Value) <> 0 then
      FLinkType := mailto;
    if Pos('/', Value) <> 0 then
      FLinkType := http;
    S := LowerCase(Copy(Value, 1, 7));
    if (S = pref_mailto) or (S = pref_http) then
      FURL := Copy(Value, 8, Length(Value))
    else
      FURL := Value;
    SetTheCaption;
  end;
end;


procedure TGoWebLabel.SetShowPrefix(Value: Boolean);
begin
  if Value <> FShowPrefix then begin
    FShowPrefix := Value;
    SetTheCaption;
  end;
end;


procedure TGoWebLabel.SetLabelType(Value: TWebLabelType);
begin
  if Value <> FLabelType then begin
    FLabelType := Value;
    SetViewFont;
  end;
end;


procedure TGoWebLabel.SetLinkType(Value: TWebLabelLinkType);
begin
  if FLinkType <> Value then begin
    FLinkType := Value;
    CheckLinkAble;
    case FLinkType of
      mailto:
        if FURL = defURL then FURL := defMailto;
      http:
        if FURL = defMailto then FURL := defURL;
    end;
    SetTheCaption;
  end;
end;


procedure TGoWebLabel.CheckLinkAble;
var
  AModule: HModule;
begin
  case FLinkType of
    http:
      FLinkAble := (GetApplicationPathFromExt('.html') <> '') and
        (GetApplicationPathFromExt('.htm') <> '');
    mailto:
      begin
        AModule := LoadLibrary(PChar(MAPIDLL));
        FLinkAble := AModule > 32;
        if FLinkAble then FreeLibrary(AModule);
      end;
  end;
end;


procedure TGoWebLabel.SetTheCaption;
begin
  if FShowPrefix then begin
    case FLinkType of
      http:
        SetURLCaption(pref_http + FURL);
      mailto:
        SetURLCaption(pref_mailto + FURL);
    end;
  end else
    SetURLCaption(FURL);
end;


procedure TGoWebLabel.Click;
var
  Param: String;
begin
  inherited Click;
  if (FLabelType = Link) or (FLinkAble and (FLabelType = Auto)) then begin
    case FLinkType of
      http:
        Param := pref_http + URL;
      mailto:
        Param := pref_mailto + URL;
    end;
    ShellExecute(Application.Handle, 'open', PChar(Param), nil, pChar('C:\WINDOWS\SYSTEM32\'), SW_SHOWNORMAL);
  end;
end;


function TGoWebLabel.GetCaption: TCaption;
begin
  Result := inherited Caption;
end;


procedure TGoWebLabel.SetCaption(Value: TCaption);
begin
  FCaptionChanged := True;
  inherited Caption := Value;
end;


procedure TGoWebLabel.SetURLCaption(Value: TCaption);
begin
  if not FCaptionChanged then
    inherited Caption := Value;
  FURLCaption := Value;
  UpdateHint;
end;


procedure TGoWebLabel.SetURLAsHint(Value: Boolean);
begin
  if FURLAsHint <> Value then begin
    FURLAsHint := Value;
    UpdateHint;
  end;
end;


procedure TGoWebLabel.UpdateHint;
begin
  if URLAsHint then
    inherited Hint := URLCaption
  else
    inherited Hint := '';
end;


function TGoWebLabel.GetApplicationPathFromExt(const Ext: String): String;
var
  S: string;
  r: TRegistry;
begin
  Result := '';
//  with TRegistry.Create do
  r := TRegistry.Create;
//  try
  r.RootKey := HKEY_CLASSES_ROOT;
  if r.OpenKey('\' + Ext, False) then begin
    S := r.ReadString('');
    if S <> '' then begin
      if r.OpenKey('\' + S + '\shell\open\command', False) then
//       begin
        S := r.ReadString('');
//        if S <> '' then Result := S;
//      end;
    end else begin
      if r.OpenKey('\' + Ext + '\shell\open\command', False) then
//       begin
        S := r.ReadString('');
//        if S <> '' then Result := S;
//      end;
    end;
  end;
//  finally
  r.Free;
  if S <> '' then Result := S;
//  end;
end;


end.
