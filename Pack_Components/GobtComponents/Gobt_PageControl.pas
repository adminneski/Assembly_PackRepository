unit Gobt_PageControl;
interface

uses
  Windows, Messages, Classes, CommCtrl, ComCtrls, Controls, Graphics, Dialogs,
  SysUtils;

type
  TGoPageControl = class(TPageControl)
  private
    FOnDrawTab: TDrawTabEvent;
    procedure TCMAdjustRect(var Msg: TMessage); message TCM_ADJUSTRECT;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure DrawTabSheet(TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property OnDrawTab: TDrawTabEvent read FOnDrawTab write FOnDrawTab;
  end;

implementation

{ TPageControl1 }

constructor TGoPageControl.Create(AOwner: TComponent);
begin
  inherited;
//  ParentBackground := false;
  Font.Name := 'Arial';
end;

procedure TGoPageControl.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
//  Params.Style := Params.Style or TCS_OWNERDRAWFIXED;
end;

destructor TGoPageControl.Destroy;
begin
  inherited Destroy;
end;

procedure TGoPageControl.DrawTabSheet(TabIndex: Integer; const Rect: TRect;
  Active: Boolean);
var
  Caption: string;
  TabRect: TRect;
begin
  Caption := Tabs[TabIndex];
  TabRect := Rect;
  with Canvas do
  begin
    if Pages[TabIndex].Highlighted then
    begin
      Brush.Color := clHighlight;
      Font.Color := clWhite;
    end
    else
    begin
      Brush.Color := TColor($00EBEBEB); // Cor do PageControl
      Font.Color := clBlack;            // con das Fontes
    end;
    FillRect(Rect);
    OffsetRect(TabRect, 0, 1);
    if not OwnerDraw then
    begin
      DrawText(Handle, PChar(Caption), Length(Caption), TabRect, DT_CENTER or
        DT_SINGLELINE or DT_VCENTER);
    end;
  end;
end;

procedure TGoPageControl.TCMAdjustRect(var Msg: TMessage);
begin
  if Msg.WParam = 0 then
    InflateRect(PRect(Msg.LParam)^, 5, 6)
  else
    InflateRect(PRect(Msg.LParam)^, -5, -6);
end;

procedure TGoPageControl.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  RedrawWindow(Handle, nil, 0, RDW_INVALIDATE or RDW_ERASE);
end;

procedure TGoPageControl.WndProc(var Message: TMessage);
begin
  inherited WndProc(Message);

  if (Message.Msg = CN_DRAWITEM) then
  begin
    with PDrawItemStruct(Message.LParam)^ do
    begin
      DrawTabSheet(itemID, rcItem, itemState and ODS_SELECTED <> 0);
    end;
  end;

end;

end.
