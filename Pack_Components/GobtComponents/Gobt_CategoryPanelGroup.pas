unit Gobt_CategoryPanelGroup;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms, ExtCtrls, Graphics,
  Winapi.Messages,Dialogs;

type
  TExpandEvent = procedure(Sender: TObject) of object;

  TCategoryPanel = class(ExtCtrls.TCategoryPanel)
  private
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
  published
    { Published declarations }
    constructor Create(AOwner: TComponent); override;
  protected
    procedure DrawCollapsedPanel(ACanvas: TCanvas); override;

    procedure MyPanelExpand(Sender: TObject);
  end;

  TGoCategoryPanelGroup = class(TCategoryPanelGroup)
  private
    { Private declarations }
    FOnClick: TNotifyEvent;
    // fOnAddPanel: TOnAddPanel;
    // fPanel: TPanel;

    function  getPanelHeight(): integer;
    procedure PanelExpand2(Sender: TObject);
    procedure PanelCollapse2(Sender: TObject);
    procedure CheckPanelsHeight();
    function  getPanels: TList;
    procedure CategoryPanelGroupMouseEnter(Sender: TObject);
    // procedure onEnter(Sender: TObject);
    // procedure onResize();

  protected
    { Protected declarations }
    // procedure Click; dynamic;
    // procedure DrawCollapsedPanel(ACanvas: TCanvas); override;
    // function GetCollapsedHeight: Integer; override;
    // procedure onMouseEnter(Sender: TObject); override;
    function GetCategoryPanelClass: TCategoryPanelClass; override;
    property OnClick: TNotifyEvent read FOnClick write FOnClick;
    // property OnAddPanel: TOnAddPanel read fOnAddPanel write fOnAddPanel;

  public
    { Public declarations }

  published
    { Published declarations }
    constructor Create(AOwner: TComponent); override;
    // property Panel: TPanel read fPanel write fPanel;
    property MyPanels: TList read getPanels;

    // function xpto_():string;
  end;

  // TOnAddPanel  = procedure(Sender: TObject) of object;
  TNotifyEvent = procedure(Sender: TObject) of object;


implementation

{ TGoCategoryPanelGroup }

procedure TGoCategoryPanelGroup.CategoryPanelGroupMouseEnter
  (Sender: TObject);
var
  i: integer;
  lCount: integer;
  lPanel: TCustomCategoryPanel;
begin
  inherited;
  lCount := 0;
  // lPanel := TCustomCategoryPanel.Create(Self);
  for i := 0 to Self.Panels.Count - 1 do
  begin
    TCategoryPanel(Self.Panels[i]).Caption := IntToStr(i);
  end;

end;

procedure TGoCategoryPanelGroup.CheckPanelsHeight();
var
  i: integer;
  lCount: integer;
  lPanel: TCustomCategoryPanel;
begin
  lCount := 0;
  // lPanel := TCustomCategoryPanel.Create(Self);
  for i := 0 to Self.Panels.Count - 1 do
  begin
    // count visible panels
    if (TCustomCategoryPanel(Self.Panels[i]).Visible) then
    begin
      Inc(lCount);
      lPanel := TCustomCategoryPanel(Self.Panels[i]);
    end;
  end;
  if (lCount = 1) then
  begin
    lPanel.Expand;
    lPanel.Height := getPanelHeight();
  end;
end;

// procedure TCategoryPanelGroupRH.Click;
// begin
// if Assigned(FOnClick) then
//   FOnClick(Self);
// end;

constructor TGoCategoryPanelGroup.Create(AOwner: TComponent);
var
  i: integer;
begin
  inherited;
  // fPanel:= TPanel.Create(Self);
  // Self.onResize := onResize;

  //  Self.CollapseAll;
  //  for i := 0 to Self.Panels.Count - 1 do
  //  begin
  //    TCustomCategoryPanel(Self.Panels[i]).OnExpand := PanelExpand2;
  //    TCustomCategoryPanel(Self.Panels[i]).OnCollapse := PanelCollapse2;
  //  end;
  // TCustomCategoryPanel(Self).onControlListChanging
  // CategoryPanel1.Expand;

  CheckPanelsHeight();
  // Self.OnEnter := onEnter;

  Self.Align := alClient;
end;

function TGoCategoryPanelGroup.GetCategoryPanelClass: TCategoryPanelClass;
begin
  Result := TCategoryPanel;
end;

function TGoCategoryPanelGroup.getPanelHeight: integer;
var
  i, lCount: integer;
begin

  lCount := 0;
  for i := 0 to Self.Panels.Count - 1 do
  begin
    // count visible panels
    if (TCustomCategoryPanel(Self.Panels[i]).Visible) then
    begin
      Inc(lCount);
    end;
  end;

  if (lCount > 1) then
    Result := Self.Height - (Self.HeaderHeight * lCount) + lCount
  else
    Result := Self.Height - lCount;
end;

function TGoCategoryPanelGroup.getPanels(): TList;
begin
  Result := TList(Self.Panels);
end;

// procedure TCategoryPanelGroupRH.onEnter(Sender: TObject);
// var
// i:integer;
// begin
/// /  inherited;
// Self.CollapseAll;
// for i := 0 to Self.Panels.Count - 1 do
// begin
// TCustomCategoryPanel(Self.Panels[i]).OnExpand   := PanelExpand;
// TCustomCategoryPanel(Self.Panels[i]).OnCollapse := PanelCollapse;
// end;
//
/// /  CategoryPanel1.Expand;
//
// CheckPanelsHeight();
/// /  Self.OnEnter := onEnter;
//
// end;


// procedure TCategoryPanelGroupRH.onResize();
// var
// i, lCount, lPos: integer;
// begin
//
// lCount := 0;
// lPos := -1;
// for i := 0 to Self.Panels.Count - 1 do
// begin
// // count visible panels
// if (TCustomCategoryPanel(Self.Panels[i]).Visible) then
// begin
// Inc(lCount);
// if ( not TCustomCategoryPanel(Self.Panels[i]).Collapsed ) then
// lPos := i;
// end;
// end;
//
// if (lCount > 0) then
// begin
/// /    showmessage( inttostr(lPos) );
// if (lCount = 1) then
// PanelExpand(Self.Panels[0])
// else
// PanelExpand(Self.Panels[lPos]);
// end;
// end;

procedure TGoCategoryPanelGroup.PanelCollapse2(Sender: TObject);
begin
  // TCategoryPanel(Sender).Caption := 'Collapsed';
  // Exit;

  CheckPanelsHeight();
end;

procedure TGoCategoryPanelGroup.PanelExpand2(Sender: TObject);
var
  i: integer;
  lCount: integer;
begin
  // TCategoryPanel(Sender).Caption := 'Expanded';
  // Exit;

  lCount := 0;
  for i := 0 to Self.Panels.Count - 1 do
  begin
    // count visible panels
    if (TCategoryPanel(Self.Panels[i]).Visible) then
    begin
      Inc(lCount);
      TCategoryPanel(Self.Panels[i]).Caption := 'visible';
    end;
    // Collapse other panels
    if (Self.Panels[i] <> Sender) then
      TCategoryPanel(Self.Panels[i]).Collapse;
  end;
  // if (lCount > 1) then
  // TCategoryPanel(Sender).Height := Self.Height - (Self.HeaderHeight * lCount) + lCount
  // else
  // TCategoryPanel(Sender).Height := Self.Height - lCount;
  TCategoryPanel(Sender).Height := 100;
  Self.Realign; // refresh...

end;

// class function TCategoryPanelGroupRH.ToString(GUID: TGUID): String;
// begin
// Result := GuidToString(Guid);
// end;

// function TCategoryPanelGroupRH.xpto_: string;
// begin
// Result := fXpto;
// end;

// { TCategoryPanelGroupHelper }
/// /
// procedure TCategoryPanelGroupHelper.RemovePanel_(Panel: TCustomCategoryPanel);
// begin
// Self.RemovePanel(Panel);
// end;

{ TCategoryPanel }

constructor TCategoryPanel.Create(AOwner: TComponent);
begin
  inherited;
 //Self.OnExpand := MyPanelExpand;
end;

procedure TCategoryPanel.DrawCollapsedPanel(ACanvas: TCanvas);
var
  LRect: TRect;
begin
  LRect := ClientRect;
  LRect.Top := HeaderHeight;
  LRect.Bottom := GetCollapsedHeight;

  ACanvas.Brush.Color := clGray; // Color;
  ACanvas.FillRect(LRect);
end;

procedure TCategoryPanel.MyPanelExpand(Sender: TObject);
var
  i: integer;
  lCount: integer;
begin
  // if (csDesigning in ComponentState) then
  // Exit;

  TCategoryPanel(Sender).Caption := TCategoryPanel(Sender)
    .Caption + '[' + IntToStr(TCustomCategoryPanelGroup
      (TCategoryPanel(Sender).Parent).Panels.Count) + ']';

  lCount := 0;
  for i := 0 to TCustomCategoryPanelGroup(TCategoryPanel(Sender).Parent)
    .Panels.Count - 1 do
  begin
    // count visible panels
    if (TCategoryPanel(TCustomCategoryPanelGroup(TCategoryPanel(Sender).Parent)
          .Panels[i]).Visible) then
    begin
      Inc(lCount);
    end;
    // Collapse other panels
    if (TCustomCategoryPanelGroup(TCategoryPanel(Sender).Parent)
        .Panels[i] <> TCategoryPanel(Sender)) then
      TCategoryPanel(TCustomCategoryPanelGroup(TCategoryPanel(Sender).Parent)
          .Panels[i]).Collapse;
  end;
  if (lCount > 1) then
  begin
    TCategoryPanel(Sender).Height := TCustomCategoryPanelGroup
      (TCategoryPanel(Sender).Parent).Height -
      (TCustomCategoryPanelGroup(TCategoryPanel(Sender).Parent)
        .HeaderHeight * lCount) + lCount;
    // TCategoryPanel(Sender).Caption := TCategoryPanel(Sender).Caption + '(>1)';
  end
  else
  begin
    TCategoryPanel(Sender).Height := TCustomCategoryPanelGroup
      (TCategoryPanel(Sender).Parent).Height - lCount;
    // TCategoryPanel(Sender).Caption := TCategoryPanel(Sender).Caption + '(=1)';
  end;
  TCategoryPanel(Sender).Caption := TCategoryPanel(Sender)
    .Caption + '(' + IntToStr(TCategoryPanel(Sender).Height) + ')';
  TCustomCategoryPanelGroup(TCustomCategoryPanel(Sender).Parent).Realign;
  // refresh...

end;


procedure TCategoryPanel.WMSetFocus(var Message: TWMSetFocus);
begin
//  Showmessage(Self.Name);
end;

end.
