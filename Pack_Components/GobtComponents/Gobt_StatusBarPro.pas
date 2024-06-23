{------------------------------------------------------------------------------}
{                                                                              }
{  TStatusBarPro v1.80                                                         }
{  by Kambiz R. Khojasteh                                                      }
{                                                                              }
{  kambiz@delphiarea.com                                                       }
{  http://www.delphiarea.com                                                   }
{                                                                              }
{------------------------------------------------------------------------------}


unit Gobt_StatusBarPro;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ComCtrls, ImgList ;


type TImageIndex = type Integer;


type
  TGoStatusBarPro = class;

  TStatusPanelPro = class(TCollectionItem)
  private
    FText: String;
    FHint: String;
    FImageIndex: TImageIndex;
    FPopupMenu: TPopupMenu;
    FWidth: Integer;
    FMinWidth: Integer;
    FMaxWidth: Integer;
    FAutoWidth: Boolean;
    FAutoSize: Boolean;
    FCursor: TCursor;
    FColor: TColor;                                                     {RAL}
    FParentColor: Boolean;
    FAlignment: TAlignment;
    FBevel: TStatusPanelBevel;
    FFont: TFont;
    FParentFont: Boolean;
    FIndent: Integer;
    FStyle: TStatusPanelStyle;
    FName: String;
    FTag: Integer;
    FControl: TControl;                                                 {VVV}
    FUpdateNeeded: Boolean;
    FOnCLick: TNotifyEvent;
    FOnDblClick: TNotifyEvent;
    FOnContextPopup: TContextPopupEvent;
    procedure SetHint(Value: String);
    procedure SetImageIndex(Value: TImageIndex);
    procedure SetPopupMenu(Value: TPopupMenu);
    procedure SetAlignment(Value: TAlignment);
    procedure SetBevel(Value: TStatusPanelBevel);
    procedure SetStyle(Value: TStatusPanelStyle);
    procedure SetText(const Value: string);
    procedure SetWidth(Value: Integer);
    procedure SetMinWidth(Value: Integer);
    procedure SetMaxWidth(Value: Integer);
    procedure SetAutoWidth(Value: Boolean);
    procedure SetAutoSize(Value: Boolean);
    procedure SetControl(Value: TControl);                              {VVV}
    procedure SetCursor(Value: TCursor);
    procedure SetColor(Value: TColor);                                  {RAL}
    procedure SetParentColor(Value: Boolean);
    function IsColorStored: Boolean;
    procedure SetFont(Value: TFont);
    procedure SetParentFont(Value: Boolean);
    procedure FontChanged(Sender: TObject);
    function IsFontStored: Boolean;
    procedure SetIndent(Value: Integer);
  protected
    procedure DoContextPopup(MousePos: TPoint; var Handled: Boolean); dynamic;
    function GetDisplayName: string; override;
    procedure UpdateControlBounds; virtual;                                {VVV}
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure ParentColorChanged;
    procedure ParentFontChanged;
  published
    property Alignment: TAlignment read FAlignment write SetAlignment default taLeftJustify;
    property AutoSize: Boolean read FAutoSize write SetAutoSize default False;
    property AutoWidth: Boolean read FAutoWidth write SetAutoWidth default False;
    property Bevel: TStatusPanelBevel read FBevel write SetBevel default pbLowered;
    property Color: TColor read FColor write SetColor stored IsColorStored;     {RAL}
    property Control: TControl read FControl write SetControl;                  {VVV}
    property Cursor: TCursor read FCursor write SetCursor default crDefault;
    property Font: TFont read FFont write SetFont stored IsFontStored;
    property Hint: String read FHint write SetHint;
    property ImageIndex: TImageIndex read FImageIndex write SetImageIndex default -1;
    property Indent: Integer read FIndent write SetIndent default 0;
    property MaxWidth: Integer read FMaxWidth write SetMaxWidth default 10000;
    property MinWidth: Integer read FMinWidth write SetMinWidth default 0;
    property Name: String read FName write FName;
    property Tag: Integer read FTag write FTag default 0;
    property ParentColor: Boolean read FParentColor write SetParentColor default True;
    property ParentFont: Boolean read FParentFont write SetParentFont default True;
    property PopupMenu: TPopupMenu read FPopupMenu write SetPopupMenu;
    property Style: TStatusPanelStyle read FStyle write SetStyle default psText;
    property Text: string read FText write SetText;
    property Width: Integer read FWidth write SetWidth;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
    property OnContextPopup: TContextPopupEvent read FOnContextPopup write FOnContextPopup;
  end;

  TStatusPanelsPro = class(TCollection)
  private
    FStatusBar: TGoStatusBarPro;
    function GetItem(Index: Integer): TStatusPanelPro;
    procedure SetItem(Index: Integer; Value: TStatusPanelPro);
    function GetByName(const Name: String): TStatusPanelPro;
  protected
    function GetOwner: TPersistent; override;
    procedure Update(Item: TCollectionItem); override;
    property StatusBar: TGoStatusBarPro read FStatusBar;
  public
    constructor Create(StatusBar: TGoStatusBarPro);
    function Add: TStatusPanelPro;
    property ByName[const Name: String]: TStatusPanelPro read GetByName;
    property Items[Index: Integer]: TStatusPanelPro read GetItem write SetItem; default;
  end;

  TDrawPanelProEvent = procedure(StatusBar: TGoStatusBarPro;
    Panel: TStatusPanelPro; const Rect: TRect) of object;

  TGoStatusBarPro = class(TWinControl)
  private
    FPanels: TStatusPanelsPro;
    FCanvas: TCanvas;
    FCursor: TCursor;
    FSimpleText: string;
    FSimplePanel: Boolean;
    FSizeGrip: Boolean;
    FUseSystemFont: Boolean;
    FOnDrawPanel: TDrawPanelProEvent;
    FOnHint: TNotifyEvent;
    FImages: TImageList;
    FImageChangeLink: TChangeLink;
    FMousePanel: TStatusPanelPro;
    function IsFontStored: Boolean;
    procedure ImageListChange(Sender: TObject);
    procedure SetImages(Value: TImageList);
    procedure SetPanels(Value: TStatusPanelsPro);
    procedure SetSimplePanel(Value: Boolean);
    procedure UpdateSimpleText;
    procedure SetSimpleText(const Value: string);
    procedure SetSizeGrip(Value: Boolean);
    procedure SetCursor(Value: TCursor);
    procedure SyncToSystemFont;
    procedure UpdatePanelsWidth;
    procedure UpdatePanel(Index: Integer; Repaint: Boolean);
    procedure UpdatePanels(UpdateRects, UpdateText: Boolean);
    procedure CMHintShow(var Message: TCMHintShow); message CM_HINTSHOW;
    procedure CMColorChanged(var Message: TMessage); message CM_COLORCHANGED;
    procedure CMParentFontChanged(var Message: TMessage); message CM_PARENTFONTCHANGED;
    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
    procedure CMWinIniChange(var Message: TMessage); message CM_WININICHANGE;
    procedure CMSysFontChanged(var Message: TMessage); message CM_SYSFONTCHANGED;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure WMGetTextLength(var Message: TWMGetTextLength); message WM_GETTEXTLENGTH;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMNCCalcSize(var Message: TWMNCCalcSize); message WM_NCCALCSIZE;
    procedure SetUseSystemFont(const Value: Boolean);
    function FindPanelAtPos(X, Y: Integer): TStatusPanelPro;
    procedure UpdateCursor;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure ChangeScale(M, D: Integer); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    function DoHint: Boolean; virtual;
    procedure DrawPanel(Panel: TStatusPanelPro; const Rect: TRect); virtual;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X: Integer; Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X: Integer; Y: Integer); override;
    procedure Click; override;
    procedure DblClick; override;
    function GetPopupMenu: TPopupMenu; override;
    procedure DoContextPopup(MousePos: TPoint; var Handled: Boolean); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Canvas: TCanvas read FCanvas;
  published
    property Align default alBottom;
    property Color default clBtnFace;
    property Cursor read FCursor write SetCursor default crDefault;
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font stored IsFontStored;
    property Images: TImageList read FImages write SetImages;
    property Panels: TStatusPanelsPro read FPanels write SetPanels;
    property ParentColor default False;
    property ParentFont default False;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property SimplePanel: Boolean read FSimplePanel write SetSimplePanel;
    property SimpleText: string read FSimpleText write SetSimpleText;
    property SizeGrip: Boolean read FSizeGrip write SetSizeGrip default True;
    property UseSystemFont: Boolean read FUseSystemFont write SetUseSystemFont default True;
    property Visible;
    property OnClick;
    property OnContextPopup;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnHint: TNotifyEvent read FOnHint write FOnHint;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnDrawPanel: TDrawPanelProEvent read FOnDrawPanel write FOnDrawPanel;
    property OnStartDrag;
  end;

implementation

uses
  CommCtrl , StdActns ;

const
  MaxPanelCount  = 128;
  SizeGripWidth  = 16;
  InternalIndent = 1;

{ TStatusPanelPro }

constructor TStatusPanelPro.Create(Collection: TCollection);
begin
  FFont := TFont.Create;
  FFont.OnChange := FontChanged;
  FColor := clBtnFace;
  FWidth := 50;
  FMinWidth := 0;
  FMaxWidth := 10000;
  FBevel := pbLowered;
  FImageIndex := -1;
  FParentColor := True;
  FParentFont := True;
  FCursor := crDefault;
  inherited Create(Collection);
  ParentColorChanged;
  ParentFontChanged;
end;

destructor TStatusPanelPro.Destroy;
begin
  FFont.Free;
  inherited Destroy;
end;

procedure TStatusPanelPro.Assign(Source: TPersistent);
begin
  if Source is TStatusPanel then
  begin
    Text := TStatusPanel(Source).Text;
    Width := TStatusPanel(Source).Width;
    Alignment := TStatusPanel(Source).Alignment;
    Bevel := TStatusPanel(Source).Bevel;
    // ### Luciano Cargnelutti
    // Style := TStatusPanel(Source).Style;
  end
  else if Source is TStatusPanelPro then
  begin
    Text := TStatusPanelPro(Source).Text;
    AutoSize := TStatusPanelPro(Source).AutoSize;
    AutoWidth := TStatusPanelPro(Source).AutoWidth;
    MinWidth := TStatusPanelPro(Source).MinWidth;
    MaxWidth := TStatusPanelPro(Source).MaxWidth;
    Width := TStatusPanelPro(Source).Width;
    Color := TStatusPanelPro(Source).Color;                             {RAL}
    ParentColor := TStatusPanelPro(Source).ParentColor;
    Cursor := TStatusPanelPro(Source).Cursor;
    Alignment := TStatusPanelPro(Source).Alignment;
    Bevel := TStatusPanelPro(Source).Bevel;
    Font := TStatusPanelPro(Source).Font;
    ParentFont := TStatusPanelPro(Source).ParentFont;
    Style := TStatusPanelPro(Source).Style;
    Hint := TStatusPanelPro(Source).Hint;
    ImageIndex := TStatusPanelPro(Source).ImageIndex;
    PopupMenu := TStatusPanelPro(Source).PopupMenu;
    OnClick := TStatusPanelPro(Source).OnClick;
    OnDblClick := TStatusPanelPro(Source).OnDblClick;
  end
  else
    inherited Assign(Source);
end;

procedure TStatusPanelPro.ParentColorChanged;
begin
  if FParentColor and (GetOwner <> nil) then
  begin
    Color := TStatusPanelsPro(GetOwner).StatusBar.Color;
    FParentColor := True;
  end;
end;

procedure TStatusPanelPro.SetColor(Value : TColor);                     {RAL}
begin                                                                   {RAL}
 if FColor <> Value then                                                {RAL}
  begin                                                                 {RAL}
   FColor := Value;                                                     {RAL}
   FParentColor := False;
   Changed(False);                                                      {RAL}
  end;                                                                  {RAL}
end;                                                                    {RAL}

function TStatusPanelPro.IsColorStored: Boolean;
begin
  Result := not FParentColor;
end;

procedure TStatusPanelPro.SetParentColor(Value: Boolean);
begin
  if FParentColor <> Value then
  begin
    FParentColor := Value;
    if FParentColor then
      ParentColorChanged;
    Changed(False);
  end;
end;

procedure TStatusPanelPro.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TStatusPanelPro.SetParentFont(Value: Boolean);
begin
  if FParentFont <> Value then
  begin
    FParentFont := Value;
    if FParentFont then
      ParentFontChanged;
    Changed(False);
  end;
end;

procedure TStatusPanelPro.FontChanged(Sender: TObject);
begin
  FParentFont := False;
  Changed(False);
end;

function TStatusPanelPro.IsFontStored: Boolean;
begin
  Result := not ParentFont;
end;

procedure TStatusPanelPro.ParentFontChanged;
begin
  if FParentFont and (GetOwner <> nil) then
  begin
    FFont.Assign(TStatusPanelsPro(GetOwner).StatusBar.Font);
    FParentFont := True;
  end;
end;

procedure TStatusPanelPro.SetIndent(Value: Integer);
begin
  if FIndent <> Value then
  begin
    FIndent := Value;
    Changed(FAutoWidth);
  end;
end;

function TStatusPanelPro.GetDisplayName: string;
begin
  Result := Text;
  if Result = '' then
    Result := inherited GetDisplayName;
  if Name <> '' then
    Result := '<' + Name + '> ' + Result;
end;

procedure TStatusPanelPro.SetAlignment(Value: TAlignment);
begin
  if FAlignment <> Value then
  begin
    FAlignment := Value;
    Changed(False);
  end;
end;

procedure TStatusPanelPro.SetBevel(Value: TStatusPanelBevel);
begin
  if FBevel <> Value then
  begin
    FBevel := Value;
    Changed(False);
  end;
end;

procedure TStatusPanelPro.SetStyle(Value: TStatusPanelStyle);
begin
  if FStyle <> Value then
  begin
    FStyle := Value;
    Changed(False);
  end;
end;

procedure TStatusPanelPro.SetText(const Value: string);
begin
  if FText <> Value then
  begin
    FText := Value;
    Changed(FAutoWidth);
  end;
end;

procedure TStatusPanelPro.SetWidth(Value: Integer);
begin
  if not (FAutoSize or FAutoWidth) then
  begin
    if Value < FMinWidth then
      Value := FMinWidth
    else if Value > FMaxWidth then
      Value := FMaxWidth;
    if FWidth <> Value then
    begin
      FWidth := Value;
      Changed(True);
    end;
  end;
end;

procedure TStatusPanelPro.SetMinWidth(Value: Integer);
begin
  if FMinWidth <> Value then
  begin
    FMinWidth := Value;
    if not FAutoSize and (FWidth < FMinWidth) then
    begin
      FWidth := MinWidth;
      Changed(True);
    end
    else if FAutoWidth then
      Changed(True);
  end;
end;

procedure TStatusPanelPro.SetMaxWidth(Value: Integer);
begin
  if FMaxWidth <> Value then
  begin
    FMaxWidth := Value;
    if not FAutoSize and (FWidth > FMaxWidth) then
    begin
      FWidth := MaxWidth;
      Changed(True);
    end
    else if FAutoWidth then
      Changed(True);
  end;
end;

procedure TStatusPanelPro.SetAutoWidth(Value: Boolean);
begin
  if FAutoWidth <> Value then
  begin
    FAutoWidth := Value;
    if FAutoWidth then
    begin
      FAutoSize := False;
      Changed(True);
    end;
  end;
end;

procedure TStatusPanelPro.SetAutoSize(Value: Boolean);
begin
  if FAutoSize <> Value then
  begin
    FAutoSize := Value;
    if FAutoSize then
    begin
      FAutoWidth := False;
      Changed(True);
    end
    else if FWidth < FMinWidth then
    begin
      FWidth := FMinWidth;
      Changed(True);
    end
    else if FWidth > FMaxWidth then
    begin
      FWidth := FMaxWidth;
      Changed(True);
    end
  end;
end;

procedure TStatusPanelPro.SetHint(Value: String);
begin
  if FHint <> Value then
  begin
    FHint := Value;
    Changed(False);
  end;
end;

procedure TStatusPanelPro.SetImageIndex(Value: TImageIndex);
begin
  if FImageIndex <> Value then
  begin
    FImageIndex := Value;
    Changed(FAutoWidth);
  end;
end;

procedure TStatusPanelPro.DoContextPopup(MousePos: TPoint;
  var Handled: Boolean);
begin
  if Assigned(FOnContextPopup) then
    FOnContextPopup(Self, MousePos, Handled);
end;

procedure TStatusPanelPro.SetPopupMenu(Value: TPopupMenu);
begin
  if FPopupMenu <> Value then
  begin
    FPopupMenu := Value;
    if (GetOwner <> nil) and (FPopupMenu <> nil) then
      FPopupMenu.FreeNotification(TStatusPanelsPro(GetOwner).StatusBar);
  end;
end;

procedure TStatusPanelPro.SetCursor(Value: TCursor);
begin
  if FCursor <> Value then
  begin
    FCursor := Value;
    if GetOwner <> nil then
      TStatusPanelsPro(GetOwner).StatusBar.UpdateCursor;
  end;
end;

procedure TStatusPanelPro.SetControl(Value: TControl);
var
  I: Integer;
begin
  if FControl <> Value then
  begin
    FControl := Value;
    if (GetOwner <> nil) and (FControl <> nil) then
    begin
      with TStatusPanelsPro(GetOwner) do
      begin
        for I := Count - 1 downto 0 do
          if (Items[I].Control = Value) and (Index <> I) then
            Items[I].Control := nil;
        FControl.FreeNotification(StatusBar);
        FControl.Parent := StatusBar;
      end;
      UpdateControlBounds;
    end;
  end;
end;

procedure TStatusPanelPro.UpdateControlBounds;
var
  SB: TGoStatusBarPro;
  Borders: array[0..2] of Integer;
  Rect: TRect;
begin
  if Assigned(FControl) and (GetOwner <> nil) then
  begin
    SetRect(Rect, 0, 0, 0, 0);
    SB := TStatusPanelsPro(GetOwner).StatusBar;
    if not SB.SimplePanel then
    begin
      SB.Perform(SB_GETRECT, Index, Integer(@Rect));
      FillChar(Borders[0], SizeOf(Borders), 0);
      SB.Perform(SB_GETBORDERS, 0, Integer(@Borders[0]));
      InflateRect(Rect, -Borders[2] div 2, -Borders[1] div 2);
    end;
    if FControl is TWinControl then // Workaround Delphi bug!!!
      SetWindowPos(TWinControl(FControl).Handle, 0, Rect.Left, Rect.Top,
        Rect.Right - Rect.Left, Rect.Bottom - Rect.Top, SWP_NOZORDER)
    else
      FControl.BoundsRect := Rect;
  end;
end;

{ TStatusPanelsPro }

constructor TStatusPanelsPro.Create(StatusBar: TGoStatusBarPro);
begin
  inherited Create(TStatusPanelPro);
  FStatusBar := StatusBar;
end;

function TStatusPanelsPro.Add: TStatusPanelPro;
begin
  Result := TStatusPanelPro(inherited Add);
end;

function TStatusPanelsPro.GetItem(Index: Integer): TStatusPanelPro;
begin
  Result := TStatusPanelPro(inherited GetItem(Index));
end;

function TStatusPanelsPro.GetByName(const Name: String): TStatusPanelPro;
var
  I: Integer;
begin
  Result := nil;
  for I := 0 to Count - 1 do
    if Items[I].Name = Name then
    begin
      Result := Items[I];
      Exit;
    end;

end;

function TStatusPanelsPro.GetOwner: TPersistent;
begin
  Result := FStatusBar;
end;

procedure TStatusPanelsPro.SetItem(Index: Integer; Value: TStatusPanelPro);
begin
  inherited SetItem(Index, Value);
end;

procedure TStatusPanelsPro.Update(Item: TCollectionItem);
begin
  if Item <> nil then
    FStatusBar.UpdatePanel(Item.Index, False)
  else
    FStatusBar.UpdatePanels(True, False);
end;

{ TGoStatusBarPro }

constructor TGoStatusBarPro.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPanels := TStatusPanelsPro.Create(Self);
  FImageChangeLink := TChangeLink.Create;
  FImageChangeLink.OnChange := ImageListChange;
  FCanvas := TControlCanvas.Create;
  TControlCanvas(FCanvas).Control := Self;
  ControlStyle := [csCaptureMouse, csClickEvents, csDoubleClicks, csOpaque, csAcceptsControls];
  Color := clBtnFace;
  Height := 19;
  Align := alBottom;
  FSizeGrip := True;
  ParentFont := False;
  FUseSystemFont := True;
  SyncToSystemFont;
end;

destructor TGoStatusBarPro.Destroy;
begin
  Images := nil;
  FImageChangeLink.Free;
  FCanvas.Free;
  FPanels.Free;
  FPanels := nil;
  inherited Destroy;
end;

procedure TGoStatusBarPro.CreateParams(var Params: TCreateParams);
const
  GripStyles: array[Boolean] of DWORD = (CCS_TOP, SBARS_SIZEGRIP);
begin
  InitCommonControl(ICC_BAR_CLASSES);
  inherited CreateParams(Params);
  CreateSubClass(Params, STATUSCLASSNAME);
  with Params do
  begin
    Style := Style or GripStyles[FSizeGrip and
      (Parent is  TForm ) and
      (TForm(Parent).BorderStyle
       in [bsSizeable, bsSizeToolWin])];
    WindowClass.style := WindowClass.style and not CS_HREDRAW;
  end;
end;

procedure TGoStatusBarPro.CreateWnd;
begin
  inherited CreateWnd;
  SendMessage(Handle, SB_SETBKCOLOR, 0, ColorToRGB(Color));
  UpdatePanels(True, False);
  if FSimpleText <> '' then
    SendMessage(Handle, SB_SETTEXT, 255, Integer(PChar(FSimpleText)));
  if FSimplePanel then
    SendMessage(Handle, SB_SIMPLE, 1, 0);
  UpdateCursor;
end;

function TGoStatusBarPro.DoHint: Boolean;
begin
  if Assigned(FOnHint) then
  begin
    FOnHint(Self);
    Result := True;
  end
  else
    Result := False;
end;

procedure TGoStatusBarPro.DrawPanel(Panel: TStatusPanelPro; const Rect: TRect);
var
  X, Y: Integer;
  ImageWidth: Integer;
  Alignment: TAlignment;
  RightSideImage: Boolean;
begin
  if (Panel.Style = psOwnerDraw) and Assigned(FOnDrawPanel) then
    FOnDrawPanel(Self, Panel, Rect)
  else
  begin
    // Changes alignment according to BiDiMode
    Alignment := Panel.Alignment;
    RightSideImage := (Alignment = taRightJustify);
    // Determines image's width
    if (FImages <> nil) and (Panel.ImageIndex >= 0) and
       (Panel.ImageIndex < FImages.Count) then
      ImageWidth := FImages.Width
    else
      ImageWidth := 0;
    // Determines X position
    case Alignment of
      taLeftJustify: X := Rect.Left + InternalIndent + Panel.Indent;
      taRightJustify: X := Rect.Right - ImageWidth - InternalIndent - Panel.Indent;
    else
      X := Rect.Left + ((Rect.Right - Rect.Left) -
          (ImageWidth + FCanvas.TextWidth(Panel.Text))) div 2;
    end;
    FCanvas.Brush.Color := Panel.Color; {RAL: Put here so colors can be seen in design mode}
    FCanvas.FillRect(Rect);
    // Draws image
    if ImageWidth > 0 then
    begin
      Y := Rect.Top + ((Rect.Bottom - Rect.Top) - FImages.Height) div 2;
      FImages.Draw(FCanvas, X, Y, Panel.ImageIndex);
      if RightSideImage then
        Dec(X, 2 * InternalIndent)
      else
        Inc(X, FImages.Width + 2 * InternalIndent);
    end;
    // Draws text
    if Panel.Text <> '' then
    begin
      FCanvas.Font.Assign(Panel.Font);
      if RightSideImage then
        Dec(X, FCanvas.TextWidth(Panel.Text));
      Y := Rect.Top + ((Rect.Bottom - Rect.Top) - FCanvas.TextHeight('H')) div 2;

      FCanvas.TextOut(X, Y, Panel.Text);
    end;
  end;
end;

procedure TGoStatusBarPro.SetImages(Value: TImageList);
begin
  if FImages <> Value then
  begin
    if FImages <> nil then
      FImages.UnRegisterChanges(FImageChangeLink);
    FImages := Value;
    if FImages <> nil then
    begin
      FImages.RegisterChanges(FImageChangeLink);
      FImages.FreeNotification(Self);
    end;
    ImageListChange(nil);
  end;
end;

procedure TGoStatusBarPro.ImageListChange(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to Panels.Count-1 do
    if Panels[I].AutoWidth and (Panels[I].ImageIndex >= 0) then
    begin
      UpdatePanels(True, False);
      Exit;
    end;
  Invalidate;
end;

procedure TGoStatusBarPro.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  I: Integer;
begin
  inherited Notification(AComponent, Operation);
  if Operation = opRemove then
  begin
    if AComponent = FImages then
      Images := nil
    else if Assigned(Panels) then
    begin
      if AComponent is TPopupMenu then
      begin
        for I := 0 to Panels.Count-1 do
          if Panels[I].PopupMenu = AComponent then
            Panels[I].PopupMenu := nil;
      end
      else if AComponent is TControl then
      begin
        for I := 0 to Panels.Count-1 do
          if Panels[I].Control = AComponent then
            Panels[I].Control := nil;
      end;
    end;
  end;
end;

procedure TGoStatusBarPro.SetPanels(Value: TStatusPanelsPro);
begin
  FPanels.Assign(Value);
end;

procedure TGoStatusBarPro.SetSimplePanel(Value: Boolean);
var
  I: Integer;
begin
  if FSimplePanel <> Value then
  begin
    FSimplePanel := Value;
    if HandleAllocated then
    begin
      SendMessage(Handle, SB_SIMPLE, Ord(FSimplePanel), 0);
      for I := 0 to Panels.Count - 1 do
        Panels[I].UpdateControlBounds;
    end;
  end;
end;

procedure TGoStatusBarPro.SetCursor(Value: TCursor);
begin
  if FCursor <> Value then
  begin
    FCursor := Value;
    UpdateCursor;
  end;
end;


procedure TGoStatusBarPro.UpdateSimpleText;
const
  RTLReading: array[Boolean] of Longint = (0, SBT_RTLREADING);
begin
  if HandleAllocated then
    SendMessage(Handle, SB_SETTEXT, 255,Integer(PChar(FSimpleText)));
end;

procedure TGoStatusBarPro.SetSimpleText(const Value: string);
begin
  if FSimpleText <> Value then
  begin
    FSimpleText := Value;
    UpdateSimpleText;
  end;
end;

procedure TGoStatusBarPro.SetSizeGrip(Value: Boolean);
begin
  if FSizeGrip <> Value then
  begin
    FSizeGrip := Value;
    RecreateWnd;
  end;
end;

procedure TGoStatusBarPro.SyncToSystemFont;
var
  NonClientMetrics: TNonClientMetrics;
begin
  if FUseSystemFont then
  begin
    NonClientMetrics.cbSize := sizeof(NonClientMetrics);
    if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
      Font.Handle := CreateFontIndirect(NonClientMetrics.lfStatusFont)
  end;

end;

procedure TGoStatusBarPro.UpdatePanel(Index: Integer; Repaint: Boolean);
var
  Flags: Integer;
  S: string;
  PanelRect: TRect;
begin
  if HandleAllocated then
    with Panels[Index] do
    begin
      if not Repaint then
      begin
        FUpdateNeeded := True;
        SendMessage(Handle, SB_GETRECT, Index, Integer(@PanelRect));
        InvalidateRect(Handle, @PanelRect, True);
      end
      else if FUpdateNeeded then
      begin
        FUpdateNeeded := False;
        Flags := 0;
        case Bevel of
          pbNone: Flags := SBT_NOBORDERS;
          pbRaised: Flags := SBT_POPOUT;
        end;

        {if Style = psOwnerDraw then} Flags := Flags or SBT_OWNERDRAW;
        S := Text;
        case Alignment of
          taCenter: Insert(#9, S, 1);
          taRightJustify: Insert(#9#9, S, 1);
        end;
        SendMessage(Handle, SB_SETTEXT, Index or Flags, Integer(PChar(S)));
        UpdateControlBounds;
      end;
    end;
end;

procedure TGoStatusBarPro.UpdatePanels(UpdateRects, UpdateText: Boolean);
var
  I, Count, PanelPos: Integer;
  PanelEdges: array[0..MaxPanelCount - 1] of Integer;
begin
  Count := Panels.Count;
  if HandleAllocated then
  begin
    if UpdateRects then
    begin
      if Count > MaxPanelCount then
        Count := MaxPanelCount;
      if Count = 0 then
      begin
        PanelEdges[0] := -1;
        SendMessage(Handle, SB_SETPARTS, 1, Integer(@PanelEdges));
        SendMessage(Handle, SB_SETTEXT, 0, 0);
      end
      else
      begin
        UpdatePanelsWidth;
        PanelPos := 0;
        for I := 0 to Count - 2 do
        begin
          Inc(PanelPos, Panels[I].Width);
          PanelEdges[I] := PanelPos;
        end;
        PanelEdges[Count - 1] := -1;
        SendMessage(Handle, SB_SETPARTS, Count, Integer(@PanelEdges));
      end;
    end;
    for I := 0 to Count - 1 do
      UpdatePanel(I, UpdateText);
  end;
end;

procedure TGoStatusBarPro.UpdatePanelsWidth;
var
  I, Count: Integer;
  FreeWidth: Integer;
  AutoSizeCount, AutoSizeWidth: Integer;
begin
  Count := Panels.Count;
  if Count > MaxPanelCount then
    Count := MaxPanelCount;
  AutoSizeCount := 0;
  FreeWidth := ClientWidth;
  if SizeGrip then
    Dec(FreeWidth, SizeGripWidth);
  for I := 0 to Count - 1 do
    with Panels[I] do
      if AutoSize then
        Inc(AutoSizeCount)
      else
      begin
        if AutoWidth then
        begin
          Canvas.Font.Assign(Font);
          FWidth := Canvas.TextWidth(Text) + 2 * (Indent + InternalIndent);
          if (FImages <> nil) and (ImageIndex >= 0) and (ImageIndex < FImages.Count) then
            Inc(FWidth, FImages.Width + 2 * InternalIndent);
          if FWidth < MinWidth then
            FWidth := MinWidth
          else if FWidth > MaxWidth then
            FWidth := MaxWidth;
        end;
        Dec(FreeWidth, Width);
      end;
  if AutoSizeCount > 0 then
  begin
    AutoSizeWidth := FreeWidth div AutoSizeCount;
    if AutoSizeWidth < 0 then
      AutoSizeWidth := 0;
    for I := 0 to Count - 1 do
      with Panels[I] do
        if AutoSize then
           FWidth := AutoSizeWidth;
  end;
end;

procedure TGoStatusBarPro.CMWinIniChange(var Message: TMessage);
begin
  inherited;
  if (Message.WParam = 0) or (Message.WParam = SPI_SETNONCLIENTMETRICS) then
    SyncToSystemFont;
end;

procedure TGoStatusBarPro.CNDrawItem(var Message: TWMDrawItem);
var
  SaveIndex: Integer;
begin
  with Message.DrawItemStruct^ do
  begin
    SaveIndex := SaveDC(hDC);
    FCanvas.Lock;
    try
      FCanvas.Handle := hDC;
      FCanvas.Font := Font;
      FCanvas.Brush.Color := Color;
      FCanvas.Brush.Style := bsSolid;
      if SizeGrip and (itemID + 1 = DWORD(Panels.Count)) then
        Dec(rcItem.Right, SizeGripWidth);
      DrawPanel(Panels[itemID], rcItem);
    finally
      FCanvas.Handle := 0;
      FCanvas.Unlock;
      RestoreDC(hDC, SaveIndex);
    end;
  end;
  Message.Result := 1;
end;

procedure TGoStatusBarPro.WMGetTextLength(var Message: TWMGetTextLength);
begin
  Message.Result := Length(FSimpleText);
end;

procedure TGoStatusBarPro.WMPaint(var Message: TWMPaint);
begin
  UpdatePanels(False, True);
  inherited;
end;

procedure TGoStatusBarPro.WMSize(var Message: TWMSize);
begin
  { Eat WM_SIZE message to prevent alignment by the control }
  UpdatePanels(True, False);
  Repaint;
end;

procedure TGoStatusBarPro.WMNCCalcSize(var Message: TWMNCCalcSize);
begin
  inherited;
  if Message.CalcValidRects then
    Message.Result := Message.Result or WVR_REDRAW;
end;

procedure TGoStatusBarPro.CMHintShow(var Message: TCMHintShow);
begin
  inherited;
  if Assigned(FMousePanel) and (FMousePanel.Hint <> '') then
    Message.HintInfo^.HintStr := FMousePanel.Hint
  else
    Message.HintInfo^.HintStr := Hint;
end;

function TGoStatusBarPro.FindPanelAtPos(X, Y: Integer): TStatusPanelPro;
var
  Index: Integer;
  PanelRect: TRect;
  Pt: TPoint;
begin
  Result := nil;
  Pt.X := X;
  Pt.Y := Y;
  for Index := 0 to FPanels.Count-1 do
  begin
    if (SendMessage(Handle, SB_GETRECT, Index, Integer(@PanelRect)) <> 0) and
       PtInRect(PanelRect, Pt) then
    begin
      Result := FPanels[Index];
      Break;
    end;
  end;
end;

procedure TGoStatusBarPro.UpdateCursor;
begin
  if Assigned(FMousePanel) and (FMousePanel.Cursor <> crDefault) then
    inherited Cursor := FMousePanel.Cursor
  else
    inherited Cursor := FCursor;
end;

procedure TGoStatusBarPro.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X: Integer; Y: Integer);
begin
  FMousePanel := FindPanelAtPos(X, Y);
  inherited;
end;

procedure TGoStatusBarPro.MouseMove(Shift: TShiftState; X: Integer; Y: Integer);
var
  OldPanel: TStatusPanelPro;
begin
  OldPanel := FMousePanel;
  FMousePanel := FindPanelAtPos(X, Y);
  if OldPanel <> FMousePanel then
  begin
    if ShowHint then
      Application.CancelHint;
    UpdateCursor;
  end;
  inherited;
end;

procedure TGoStatusBarPro.Click;
begin
  if Assigned(FMousePanel) and Assigned(FMousePanel.OnClick) then
    FMousePanel.OnClick(FMousePanel)
  else if Assigned(OnClick) then
    OnClick(Self);
end;

procedure TGoStatusBarPro.DblClick;
begin
  if Assigned(FMousePanel) and Assigned(FMousePanel.OnDblClick) then
    FMousePanel.OnDblClick(FMousePanel)
  else if Assigned(OnDblClick) then
    OnDblClick(Self);
end;

function TGoStatusBarPro.GetPopupMenu: TPopupMenu;
begin
  if Assigned(FMousePanel) and Assigned(FMousePanel.PopupMenu) then
  begin
    Result := FMousePanel.PopupMenu;
  end
  else
    Result := PopupMenu;
end;

procedure TGoStatusBarPro.DoContextPopup(MousePos: TPoint; var Handled: Boolean);
begin
  if Assigned(FMousePanel) then
    FMousePanel.DoContextPopup(MousePos, Handled);
  if not Handled then
    inherited DoContextPopup(MousePos, Handled);
end;

function TGoStatusBarPro.IsFontStored: Boolean;
begin
  Result := not FUseSystemFont and not ParentFont and not DesktopFont;
end;

procedure TGoStatusBarPro.SetUseSystemFont(const Value: Boolean);
begin
  if FUseSystemFont <> Value then
  begin
    FUseSystemFont := Value;
    if Value then
    begin
      if ParentFont then ParentFont := False;
      SyncToSystemFont;
    end;
  end;
end;

procedure TGoStatusBarPro.CMParentFontChanged(var Message: TMessage);
var
  I: Integer;
begin
  inherited;
  if FUseSystemFont and ParentFont then
    FUseSystemFont := False;
  for I := 0 to Panels.Count - 1 do
    if Panels[I].ParentFont then
      Panels[I].ParentFontChanged;
end;

procedure TGoStatusBarPro.CMColorChanged(var Message: TMessage);
var
  I: Integer;
begin
  inherited;
  if HandleAllocated then
    SendMessage(Handle, SB_SETBKCOLOR, 0, ColorToRGB(Color));
  for I := 0 to Panels.Count - 1 do
    if Panels[I].ParentColor then
      Panels[I].ParentColorChanged;
end;

procedure TGoStatusBarPro.CMSysColorChange(var Message: TMessage);
begin
  inherited;
  RecreateWnd;
end;

procedure TGoStatusBarPro.CMSysFontChanged(var Message: TMessage);
begin
  inherited;
  SyncToSystemFont;
end;

procedure TGoStatusBarPro.ChangeScale(M, D: Integer);
begin
  if FUseSystemFont then  // status bar size based on system font size
    ScalingFlags := [sfTop];
  inherited;
end;

end.

