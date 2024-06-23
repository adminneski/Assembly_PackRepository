
{******************************************}
{                                          }
{             FastReport VCL               }
{             Object Inspector             }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxInsp;

interface

{$I frx.inc}

uses
  {$IFNDEF FPC}
  Windows, Messages,
  {$ELSE}
  LResources, LCLType, LMessages, LazHelper, LCLProc, LCLIntf,
  {$ENDIF}
  {$IFDEF UseTabset} Tabs,{$ENDIF}
  {$IFDEF DELPHI16} System.UITypes, {$ENDIF}
  Types, SysUtils, Classes, Graphics, Controls, Forms, Variants,
  Dialogs, ExtCtrls, StdCtrls, Buttons, frxDsgnIntf, frxPopupForm,
  frxClass, Menus, ComCtrls, frxBaseForm, frxCtrls, frxDock, frTypes;

type
  { TfrxObjectInspector }

  TfrxObjectInspector = class(TfrxDockForm)
    ObjectsCB: TComboBox;
    PopupMenu1: TPopupMenu;
    N11: TMenuItem;
    N21: TMenuItem;
    N31: TMenuItem;
    BackPanel: TPanel;
    Box: TScrollBox;
    PB: TPaintBox;
    Edit1: TEdit;
    EditPanel: TPanel;
    EditBtn: TSpeedButton;
    ComboPanel: TPanel;
    ComboBtn: TSpeedButton;
    HintPanel: TScrollBox;
    Splitter1: TSplitter;
    PropL: TLabel;
    DescrL: TLabel;
    N41: TMenuItem;
    N51: TMenuItem;
    N61: TMenuItem;
    LInstruction: TLabel;
    procedure PBPaint(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure PBMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PBMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PBMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure EditBtnClick(Sender: TObject);
    procedure ComboBtnClick(Sender: TObject);
    procedure Edit1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ObjectsCBClick(Sender: TObject);
    procedure ObjectsCBDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure PBDblClick(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormEndDock(Sender, Target: TObject; X, Y: Integer);
    procedure ComboBtnMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure TabChange(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure N31Click(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ObjectsCBDropDown(Sender: TObject);
  private
    { Private declarations }
    FDesigner: TfrxCustomDesigner;
    FDisableDblClick: Boolean;
    FDisableUpdate: Boolean;
    FDown: Boolean;
    FEventList: TfrxPropertyList;
    FHintWindow: THintWindow;
    FItemIndex: Integer;
    FLastPosition: String;
    FList: TfrxPropertyList;
    FPopupForm: TfrxPopupForm;
    FPopupLB: TListBox;
    FPopupLBVisible: Boolean;
    FPropertyList: TfrxPropertyList;
    FPanel: TPanel;
    FRowHeight: Integer;
    FSelectedObjects: TfrxSelectedObjectsList;
    FSplitterPos: Integer;
{$IFDEF UseTabset}
    FTabs: TTabSet;
{$ELSE}
    FTabs: TTabControl;
{$ENDIF}
    {$IFNDEF FPC}
    FTempBMP: TBitmap;
    {$ENDIF}
    FTempList: TfrxSelectedObjectsList;
    FTickCount: UInt;
    FUpdatingObjectsCB: Boolean;
    FUpdatingPB: Boolean;
    FOnSelectionChanged: TNotifyEvent;
    FOnModify: TNotifyEvent;
    FComboBtnGlyph: TBitmap;
    FEditBtnGlyph: TBitmap;
    FFilter: String;
    FFilterEdit: TfrxFilterEdit;
    FFileterMinWidth: Integer;
    FFileterMaxWidth: Integer;
    FColor: TColor;
    FSavedPositions: TStringList;
    FSavePosLocked: Boolean;
    FMaxSavedPos: Integer;
    FFavorPress: Boolean;
    FIsFavorZone: Boolean;
    FFavorites: TStringList;
    FFullList, FFavoritesList: TfrxPropertyList;
    function Count: Integer;
    function GetItem(Index: Integer): TfrxPropertyItem;
    function GetName(Index: Integer): String;
    function GetOffset(Index: Integer): Integer;
    function GetType(Index: Integer): TfrxPropertyAttributes;
    function GetValue(Index: Integer): String;
    procedure AdjustControls;
    procedure CMMouseLeave(var Msg: TMessage); message CM_MouseLeave;
    procedure DrawOneLine({$IFDEF FPC}ACanvas: TCanvas;{$ENDIF}
      i: Integer; Selected: Boolean);
    procedure DoModify;
    procedure SetObjects(Value: TList);
    procedure SetItemIndex(Value: Integer);
    procedure SetSelectedObjects(Value: TfrxSelectedObjectsList);
    procedure SetValue(Index: Integer; Value: String);
    procedure LBClick(Sender: TObject);
    procedure FilterChange(Sender: TObject);
    function GetSplitter1Pos: Integer;
    procedure SetSplitter1Pos(const Value: Integer);
    procedure SetFilter(const Value: String);
    procedure SetFileterMaxWidth(const Value: Integer);
    procedure SetFileterMinWidth(const Value: Integer);
    procedure PBOnDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure PBOnDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure RestorePosition;
    procedure SavePosition;
    procedure SetFavoritesActive(const Value: Boolean);
    function GetFavoritesActive: Boolean;
    procedure RebildFavorites;
    procedure PBRePaint;
    function FindProp(PropertyList: TfrxPropertyList; FullName: String): Integer;
  protected
    procedure LoadFormPreferences(PreferencesStorage: TObject; DefPreferencesStorage: TObject); override;
    procedure SaveFormPreferences(PreferencesStorage: TObject; DefPreferencesStorage: TObject); override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure DisableUpdate;
    procedure EnableUpdate;
    procedure Inspect(AObjects: array of TPersistent);
    procedure SetColor(Color: TColor);
    procedure UpdateProperties;
    procedure UpdateFormPPI(aNewPPI: Integer); override;
    procedure SetActiveProperty(const PropName: String);
    property Objects: TList write SetObjects;
    property ItemIndex: Integer read FItemIndex write SetItemIndex;
    property Filter: String read FFilter write SetFilter;
    property FileterMinWidth: Integer read FFileterMinWidth write SetFileterMinWidth;
    property FileterMaxWidth: Integer read FFileterMaxWidth write SetFileterMaxWidth;
    property FavoritesAcrive: Boolean read GetFavoritesActive write SetFavoritesActive;
    property SelectedObjects: TfrxSelectedObjectsList read FSelectedObjects write SetSelectedObjects;
    property SplitterPos: Integer read FSplitterPos write FSplitterPos;
    property Splitter1Pos: Integer read GetSplitter1Pos write SetSplitter1Pos;
    property OnModify: TNotifyEvent read FOnModify write FOnModify;
    property OnSelectionChanged: TNotifyEvent read FOnSelectionChanged write FOnSelectionChanged;
  end;

  const FavorButt = ssCtrl;

implementation
{$IFDEF FPC}
{$R *.lfm}
{$ELSE}
{$R *.DFM}
{$ENDIF}

uses
  typinfo, {$IFDEF LCLGTK2} frxDesgn, {$ENDIF} IniFiles,
  frGraphics, frxUtils, frxRes;


type
  TInspPanel = class(TPanel)
  protected
    procedure WMEraseBackground(var Message: TMessage); message WM_ERASEBKGND;
    procedure Paint; override;
  end;

  THackWinControl = class(TWinControl);


{ TInspPanel }

procedure TInspPanel.WMEraseBackground(var Message: TMessage);
begin
// empty method
end;

procedure TInspPanel.Paint;
begin
// empty method
end;


{ TfrxObjectInspector }

constructor TfrxObjectInspector.Create(AOwner: TComponent);
begin
  if not (AOwner is TfrxCustomDesigner) then
    raise Exception.Create('The Owner of the object inspector should be TfrxCustomDesigner');
  inherited Create(AOwner);
  FSavedPositions := TStringList.Create;
  FItemIndex := -1;
  FMaxSavedPos := 20;
  FFileterMinWidth := 60;
  FFileterMaxWidth := 200;
  {$IFNDEF FPC}
  FTempBMP := TBitmap.Create;
  {$ENDIF}
  FTempList := TfrxSelectedObjectsList.Create;
  FDesigner := TfrxCustomDesigner(AOwner);
  FHintWindow := THintWindow.Create(Self);
  FHintWindow.Color := clInfoBk;
  FColor := clWindow;
  FPanel := TInspPanel.Create(Self);
  with FPanel do
  begin
    Parent := Box;
    BevelInner := bvNone;
    BevelOuter := bvNone;
  end;
  PB.Parent := FPanel;
  PB.OnDragDrop := PBOnDragDrop;
  PB.OnDragOver := PBOnDragOver;
  ComboPanel.Parent := FPanel;
  EditPanel.Parent := FPanel;
  Edit1.Parent := FPanel;
{$IFDEF UseTabset}
  Box.BevelKind := bkFlat;
  HintPanel.BevelKind := bkFlat;
{$ELSE}
  Box.BorderStyle := bsSingle;
  HintPanel.BorderStyle := bsSingle;
{$IFDEF DELPHI7}
  Box.ControlStyle := Box.ControlStyle + [csNeedsBorderPaint];
  HintPanel.ControlStyle := HintPanel.ControlStyle + [csNeedsBorderPaint];
{$ENDIF}
{$ENDIF}

{$IFDEF UseTabset}
  FTabs := TTabSet.Create(Self);
  FTabs.OnClick := TabChange;
  FTabs.ShrinkToFit := True;
  FTabs.Style := tsSoftTabs;
  FTabs.TabPosition := tpTop;
{$ELSE}
  FTabs := TTabControl.Create(Self);
  FTabs.OnChange := TabChange;
{$ENDIF}
  FTabs.Parent := Self;
  FFilterEdit := TfrxFilterEdit.Create(Self);
  FFilterEdit.OnFilterChanged := FilterChange;
  FFilterEdit.Parent := FTabs;
  FTabs.SendToBack;
  FTabs.Tabs.Add(frxResources.Get('oiProp'));
  FTabs.Tabs.Add(frxResources.Get('oiEvent'));
  FTabs.Tabs.Add(frxResources.Get('oiFavorites'));
  FTabs.TabIndex := 0;
  FSplitterPos := PB.Width div 2;
  AutoScroll := False;
{$IFNDEF DELPHI22}
  FormResize(nil);
{$ENDIF}
  Caption := frxGet(2000);
  LInstruction.Alignment := taCenter;
  LInstruction.Caption := frxResources.Get('oiFavIns');
  FFavorPress := False;
  FFavorites := TStringList.Create();
  FFavorites.Delimiter := '/';
  FFavorites.Sorted := True;
end;

destructor TfrxObjectInspector.Destroy;
begin
  FFavorites.Free;
  {$IFNDEF FPC}
  FTempBMP.Free;
  {$ENDIF}
  FTempList.Free;
  if FPropertyList <> nil then
    FPropertyList.Free;
  if FEventList <> nil then
    FEventList.Free;
  if FFullList <> nil then
    FFullList.Free;
  if FFavoritesList <> nil then
    FFavoritesList.Free;
  if Assigned(FComboBtnGlyph) then
    FreeAndNil(FComboBtnGlyph);
  if Assigned(FEditBtnGlyph) then
    FreeAndNil(FEditBtnGlyph);
  FreeAndNil(FSavedPositions);
  inherited;
end;

procedure TfrxObjectInspector.UpdateProperties;
begin
  SetSelectedObjects(FSelectedObjects);
end;


procedure TfrxObjectInspector.UpdateFormPPI(aNewPPI: Integer);
var
  r: TRect;
  ImgList: TImageList;

  procedure ClearBitmap(aBitmap: TBitmap);
  begin
    aBitmap.Width := 0;
    aBitmap.Height := 0;
  end;

begin
  if aNewPPI > frx_DefaultPPI then
  begin
    if FComboBtnGlyph = nil then
    begin
      FComboBtnGlyph := TBitmap.Create;
      FComboBtnGlyph.Assign(ComboBtn.Glyph);
    end;
    if FEditBtnGlyph = nil then
    begin
      FEditBtnGlyph := TBitmap.Create;
      FEditBtnGlyph.Assign(EditBtn.Glyph);
    end;
    ComboBtn.Glyph.Width := Round(12 * aNewPPI / frx_DefaultPPI);
    ComboBtn.Glyph.Height := Round(12 * aNewPPI / frx_DefaultPPI);
    r := Rect(0, 0, ComboBtn.Glyph.Width, ComboBtn.Glyph.Height);
    ComboBtn.Glyph.Canvas.Lock;
    ComboBtn.Glyph.Canvas.Brush.Color := clBtnFace;
    ComboBtn.Glyph.Canvas.FillRect(r);
    frxDrawArrow(ComboBtn.Glyph.Canvas, r, clBlack);
    ComboBtn.Glyph.Canvas.Unlock;
    ScaleBitmap(EditBtn.Glyph, aNewPPI);
  end
  else if aNewPPI = frx_DefaultPPI then
  begin
    if Assigned(FComboBtnGlyph) then
      ComboBtn.Glyph.Assign(FComboBtnGlyph);
    if Assigned(FEditBtnGlyph) then
      EditBtn.Glyph.Assign(FEditBtnGlyph);
  end;
  FRowHeight := Canvas.TextHeight('Wg') + {$IFDEF NONWINFPC}6{$ELSE}3{$ENDIF};
  with Box.VertScrollBar do
  begin
    Increment := FRowHeight;
    Tracking := True;
  end;
  ObjectsCB.ItemHeight := Round(16 * aNewPPI / frx_DefaultPPI);
  ImgList := frxImages.MainButtonImages;
  ClearBitmap(FFilterEdit.BitmapActive);
  ClearBitmap(FFilterEdit.BitmapUnactive);
  frxDrawIcon(ImgList, FFilterEdit.BitmapActive, 121, FFilterEdit.FilterColor);
  frxDrawIcon(ImgList, FFilterEdit.BitmapUnactive, 122, FFilterEdit.FilterColor);

  FormResize(nil);
  FSplitterPos := PB.Width div 2;
end;

procedure TfrxObjectInspector.Inspect(AObjects: array of TPersistent);
var
  i: Integer;
begin
  FTempList.Clear;
  FTempList.ClearInspectorList;
  for i := Low(AObjects) to High(AObjects) do
    FTempList.Add(AObjects[i]);
  Objects := FTempList;
  SelectedObjects := FTempList;
end;

procedure TfrxObjectInspector.ObjectsCBDropDown(Sender: TObject);
var
  Index: Integer;
begin
  ObjectsCB.Items.BeginUpdate;
  Index := ObjectsCB.Items.IndexOfObject(nil);
  if Index <> -1 then
    ObjectsCB.Items.Delete(Index);
  ObjectsCB.Items.EndUpdate;
end;

function TfrxObjectInspector.GetSplitter1Pos: Integer;
begin
  Result := HintPanel.Height;
end;

procedure TfrxObjectInspector.SetSplitter1Pos(const Value: Integer);
begin
  HintPanel.Height := Value;
end;

procedure TfrxObjectInspector.DisableUpdate;
begin
  FDisableUpdate := True;
end;

procedure TfrxObjectInspector.EnableUpdate;
begin
  FDisableUpdate := False;
end;

procedure TfrxObjectInspector.SaveFormPreferences(PreferencesStorage: TObject; DefPreferencesStorage: TObject);
var
  Ini: TCustomIniFile;
  lName: String;
  lScale: Single;
begin
  inherited;
  if not(PreferencesStorage is TCustomIniFile) then Exit;
  Ini :=  TCustomIniFile(PreferencesStorage);
  lScale := CurrentFormPPI / frx_DefaultPPI;
  lName := GetFormSectionName;
  Ini.WriteInteger(lName, 'SplitPos', Round(SplitterPos / lScale));
  Ini.WriteInteger(lName, 'Split1Pos', Round(Splitter1Pos / lScale));
  Ini.WriteString(lName, 'Favorites', FFavorites.DelimitedText);
end;

procedure TfrxObjectInspector.SavePosition;

  function EnumProperties(p: TfrxPropertyList; var Index: Integer): String;
  var
    i: Integer;
  begin
    Result := '';
    for i := 0 to p.Count - 1 do
    begin
      Dec(Index);
      if Index < 0 then
      begin
        Result := p[i].Editor.GetName;
        break;
      end;
      if (p[i].SubProperty <> nil) and p[i].Expanded then
        Result := p[i].Editor.GetName + '.' + EnumProperties(p[i].SubProperty, Index);
      if Index < 0 then
        break;
    end;
  end;

var
  i, n: Integer;
begin
  n := -1;
  if FSelectedObjects.Count = 0 then Exit;
    for i := 0 to FSavedPositions.Count - 1 do
      if TObject(FSelectedObjects[0]).ClassType = TClass(FSavedPositions.Objects[i]) then
        n := i;
  i := ItemIndex;
  FLastPosition := EnumProperties(FPropertyList, i);
  if n > -1 then
    FSavedPositions[n] := FLastPosition
  else
  begin
    if FMaxSavedPos < FSavedPositions.Count then
      FSavedPositions.Delete(0);
    FSavedPositions.AddObject(FLastPosition, TObject(TObject(FSelectedObjects[0]).ClassType));
  end;
end;

procedure TfrxObjectInspector.SetFavoritesActive(const Value: Boolean);
var
  Repaint: Boolean;
begin
  Repaint := Value <> FFavorPress;
  FFavorPress := Value;
  if Repaint then
    PBRePaint;
end;

function TfrxObjectInspector.GetFavoritesActive: Boolean;
begin
  Result := FFavorPress and (FTabs.TabIndex <> 1);
end;

procedure TfrxObjectInspector.RebildFavorites;
var
  i, j: Integer;
  p: TfrxPropertyItem;
begin
  while 0 < FFavoritesList.Count do
  begin
    p := FFavoritesList[0];
    p.Collection := FFullList;
  end;
  for i := 0 to FFavorites.Count - 1 do
    for j := 0 to FFullList.Count - 1 do
      if (FFullList[j].Editor.GetName = FFavorites[i]) then
      begin
        FFullList[j].Collection := FFavoritesList;
        break;
      end;
end;

procedure TfrxObjectInspector.PBRePaint;
begin
 {$IFDEF FPC}
  PB.Repaint;
 {$ELSE}
  PBPaint(nil);
 {$ENDIF}
end;

procedure TfrxObjectInspector.SetActiveProperty(const PropName: String);
var
  i: Integer;
begin
  if FSelectedObjects.Count = 0 then Exit;
  i := FindProp(FPropertyList, PropName);
  if i <> -1 then
    SetItemIndex(i);
end;

procedure TfrxObjectInspector.SetColor(Color: TColor);
var
  ImgList: TImageList;
  procedure ClearBitmap(aBitmap: TBitmap);
  begin
    aBitmap.Width := 0;
    aBitmap.Height := 0;
  end;

begin
  ObjectsCB.Color := Color;
  Box.Color := Color;
  HintPanel.Color := Color;
  Edit1.Color := Color;
  FFilterEdit.FilterColor := Color;
  ClearBitmap(FFilterEdit.BitmapActive);
  ClearBitmap(FFilterEdit.BitmapUnactive);
  ImgList := frxImages.MainButtonImages;
  frxDrawIcon(ImgList, FFilterEdit.BitmapActive, 121, Color);
  frxDrawIcon(ImgList, FFilterEdit.BitmapUnactive, 122, Color);
  FColor := Color;
  PB.Repaint;
end;

procedure TfrxObjectInspector.SetFileterMaxWidth(const Value: Integer);
begin
  FFileterMaxWidth := Value;
  FormResize(nil);
end;

procedure TfrxObjectInspector.SetFileterMinWidth(const Value: Integer);
begin
  FFileterMinWidth := Value;
  FormResize(nil);
end;

procedure TfrxObjectInspector.SetFilter(const Value: String);
begin
  FFilter := Value;
  UpdateProperties;
end;

procedure TfrxObjectInspector.SetObjects(Value: TList);
var
  i: Integer;
  s: String;
begin
  ObjectsCB.Items.Clear;
  for i := 0 to Value.Count - 1 do
  begin
    if TObject(Value[i]) is TComponent then
      s := TComponent(Value[i]).Name + ': ' + TComponent(Value[i]).ClassName else
      s := '';
    ObjectsCB.Items.AddObject(s, Value[i]);
  end;
  ObjectsCB.Items.AddObject(FDesigner.Report.Name + ': ' + TComponent(FDesigner.Report).ClassName, FDesigner.Report);
end;

procedure TfrxObjectInspector.SetSelectedObjects(Value: TfrxSelectedObjectsList);
var
  s: String;
  aList: TList;

  procedure CreateLists;
  var
    i: Integer;
    p: TfrxPropertyItem;
    s: String;
  begin
    if FPropertyList <> nil then
      FPropertyList.Free;
    if FEventList <> nil then
      FEventList.Free;
    if FFullList <> nil then
      FreeAndNil(FFullList);
    if FFavoritesList <> nil then
      FreeAndNil(FFavoritesList);
    FEventList := nil;
    FPropertyList := frxCreatePropertyList(Value.InspSelectedObjects, FDesigner, FFilter);
    if (FPropertyList <> nil) then
    begin
      FFullList := frxCreatePropertyList(Value.InspSelectedObjects, FDesigner, FFilter);
      FFavoritesList := TfrxPropertyList.Create(FDesigner);
      RebildFavorites;
    end;
    if FPropertyList <> nil then
    begin
      FEventList := TfrxPropertyList.Create(FDesigner);

      i := 0;
      while i < FPropertyList.Count do
      begin
        p := FPropertyList[i];
        s := String(p.Editor.PropInfo.PropType^.Name);
        if (Pos('Tfrx', s) = 1) and (Pos('Event', s) = Length(s) - 4) then
          p.Collection := FEventList else
          Inc(i);
      end;
    end;

    case (FTabs.TabIndex) of
      0: FList := FPropertyList;
      1: FList := FEventList;
      2: FList := FFavoritesList;
    end;
  end;

begin
  FSelectedObjects := Value;
  aList := FSelectedObjects.InspSelectedObjects;
  CreateLists;

  FUpdatingObjectsCB := True;
  if aList.Count = 1 then
  begin
    ObjectsCB.ItemIndex := ObjectsCB.Items.IndexOfObject(aList[0]);
    if ObjectsCB.ItemIndex = -1 then
    begin
      if TObject(aList[0]) is TComponent then
        s := TComponent(aList[0]).Name  + ': ' +
          TComponent(aList[0]).ClassName;
      if TComponent(aList[0]) is TfrxComponent then
      begin
        ObjectsCB.Items.AddObject(s, aList[0]);
        ObjectsCB.ItemIndex := ObjectsCB.Items.IndexOfObject(aList[0]);
      end
      else if s <> '' then
        ObjectsCB.ItemIndex := ObjectsCB.Items.Add(s);
    end;
  end
  else
    ObjectsCB.ItemIndex := -1;
  FUpdatingObjectsCB := False;

  FItemIndex := -1;
  FormResize(nil);
//  if Count > 0 then
//  begin
//    for i := 0 to Count - 1 do
//      if GetName(i) = FLastPosition then
//      begin
//        ItemIndex := i;
//        Exit;
//      end;
//    s := FLastPosition;
//    ItemIndex := 0;
//    FLastPosition := s;
//  end;
  RestorePosition;
end;

function TfrxObjectInspector.Count: Integer;

  function EnumProperties(p: TfrxPropertyList): Integer;
  var
    i: Integer;
  begin
    Result := 0;
    for i := 0 to p.Count - 1 do
    begin
      Inc(Result);
      if (p[i].SubProperty <> nil) and p[i].Expanded then
        Inc(Result, EnumProperties(p[i].SubProperty));
    end;
  end;

begin
  if FList <> nil then
    Result := EnumProperties(FList) else
    Result := 0;
end;

function TfrxObjectInspector.GetItem(Index: Integer): TfrxPropertyItem;

  function EnumProperties(p: TfrxPropertyList; var Index: Integer): TfrxPropertyItem;
  var
    i: Integer;
  begin
    Result := nil;
    for i := 0 to p.Count - 1 do
    begin
      Dec(Index);
      if Index < 0 then
      begin
        Result := p[i];
        break;
      end;
      if (p[i].SubProperty <> nil) and p[i].Expanded then
        Result := EnumProperties(p[i].SubProperty, Index);
      if Index < 0 then
        break;
    end;
  end;

begin
  if (Index >= 0) and (Index < Count) then
    Result := EnumProperties(FList, Index) else
    Result := nil;
end;

function TfrxObjectInspector.GetOffset(Index: Integer): Integer;
var
  p: TfrxPropertyList;
begin
  Result := 0;
  p := TfrxPropertyList(GetItem(Index).Collection);
  while p.Parent <> nil do
  begin
    Inc(Result);
    p := p.Parent;
  end;
end;

function TfrxObjectInspector.GetName(Index: Integer): String;
begin
  Result := GetItem(Index).Editor.GetName;
end;

function TfrxObjectInspector.GetType(Index: Integer): TfrxPropertyAttributes;
begin
  Result := GetItem(Index).Editor.GetAttributes;
end;

function TfrxObjectInspector.GetValue(Index: Integer): String;
begin
  Result := GetItem(Index).Editor.Value;
end;

procedure TfrxObjectInspector.DoModify;
var
  i: Integer;
  aList: TList;
begin
// {$IFDEF LCLGTK2}
// if Assigned(FDesigner.Report.Designer) then
// if TfrxDesignerForm(FDesigner.Report.Designer).LockSelectionChanged then
// begin
//   TfrxDesignerForm(FDesigner.Report.Designer).LockSelectionChanged := False;
//   Exit;
// end;
// {$ENDIF}

  aList := FSelectedObjects.InspSelectedObjects;
  if aList.Count = 1 then
  begin
    i := ObjectsCB.Items.IndexOfObject(aList[0]);
    if i <> -1 then
    begin
      if TObject(aList[0]) is TComponent then
        ObjectsCB.Items.Strings[i] := TComponent(aList[0]).Name + ': ' +
          TComponent(aList[0]).ClassName;
      ObjectsCB.ItemIndex := ObjectsCB.Items.IndexOfObject(aList[0]);
    end;
  end;

  if Assigned(FOnModify) then
    FOnModify(Self);
end;

procedure TfrxObjectInspector.SetItemIndex(Value: Integer);
var
  p: TfrxPropertyItem;
  s: String;
begin
  PropL.Caption := '';
  DescrL.Caption := '';
  if Value > Count - 1 then
    Value := Count - 1;
  if Value < 0 then
    Value := -1;

  Edit1.Visible := Count > 0;
  if Count = 0 then Exit;

  if FItemIndex <> -1 then
    if Edit1.Modified then
    begin
      Edit1.Modified := False;
      SetValue(FItemIndex, Edit1.Text);
    end;
  FItemIndex := Value;

  if FItemIndex <> -1 then
  begin
    //FLastPosition := GetName(FItemIndex);
    p := GetItem(FItemIndex);
    s := GetName(FItemIndex);
    PropL.Caption := s;
    if TfrxPropertyList(p.Collection).Component <> nil then
    begin
      s := 'prop' + s + '.' + TfrxPropertyList(p.Collection).Component.ClassName;
      if frxResources.Get(s) = s then
        s := frxResources.Get('prop' + GetName(FItemIndex)) else
        s := frxResources.Get(s);
      DescrL.Caption := s;
    end;
  end;

  AdjustControls;
  if not FSavePosLocked then
    SavePosition;
end;

procedure TfrxObjectInspector.SetValue(Index: Integer; Value: String);
begin
  try
    GetItem(Index).Editor.Value := Value;
    DoModify;
    PBRePaint;
  except
    on E: Exception do
    begin
      frxErrorMsg(E.Message);
      Edit1.Text := GetItem(Index).Editor.Value;
    end;
  end;
end;

procedure TfrxObjectInspector.AdjustControls;
var
  PropType: TfrxPropertyAttributes;
  y, ww: Integer;
begin
  if (csDocking in ControlState) or FDisableUpdate then Exit;
  if FItemIndex = -1 then
  begin
    EditPanel.Visible := False;
    ComboPanel.Visible := False;
    Edit1.Visible := False;
    FUpdatingPB := False;
    PBRePaint;
    Exit;
  end;

  FUpdatingPB := True;
  PropType := GetType(FItemIndex);

  EditPanel.Visible := paDialog in PropType;
  ComboPanel.Visible := paValueList in PropType;
  Edit1.ReadOnly := paReadOnly in PropType;

  ww := PB.Width - FSplitterPos - 2;
  y := FItemIndex * FRowHeight{$IFDEF NONWINFPC}-3{$ELSE}+1{$ENDIF};
  if EditPanel.Visible then
  begin
    EditPanel.SetBounds(PB.Width - FRowHeight, y - 1, FRowHeight, FRowHeight - 1);
    EditBtn.SetBounds(0, 0, EditPanel.Width, EditPanel.Height);
    Dec(ww, FRowHeight);
  end;
  if ComboPanel.Visible then
  begin
    ComboPanel.SetBounds(PB.Width - FRowHeight, y - 1, FRowHeight, FRowHeight - 1);
    ComboBtn.SetBounds(0, 0, ComboPanel.Width, ComboPanel.Height);
    Dec(ww, FRowHeight);
  end;

  Edit1.Text := GetValue(FItemIndex);
  Edit1.Modified := False;
  Edit1.SetBounds(FSplitterPos + 2, y, ww, FRowHeight - 2);
  Edit1.SelectAll;

  if y + FRowHeight > Box.VertScrollBar.Position + Box.ClientHeight then
    Box.VertScrollBar.Position := y - Box.ClientHeight + FRowHeight;
  if y < Box.VertScrollBar.Position then
    Box.VertScrollBar.Position := y - 1;

  FUpdatingPB := False;
  PBRePaint;
end;

procedure TfrxObjectInspector.DrawOneLine({$IFDEF FPC}ACanvas: TCanvas;{$ENDIF}
    i: Integer; Selected: Boolean);
var
  R: TRect;
  s: String;
  p: TfrxPropertyItem;
  offs, add: Integer;
  lScale: Single;

  procedure LineInternal(x, y, dx, dy: Integer);
  begin
    {$IFDEF FPC}
    ACanvas.MoveTo(x, y);
    ACanvas.LineTo(x + dx, y + dy);
    {$ELSE}
    FTempBMP.Canvas.MoveTo(x, y);
    FTempBMP.Canvas.LineTo(x + dx, y + dy);
    {$ENDIF}
  end;

  const DefaultSquareSide = 9;
  procedure DrawProperty;
  var
    x, y, y1, idx, w, SquareSide: Integer;
    InnerRect: TRect;
  begin
    x := offs + GetOffset(i) * Round(12 * lScale);
    y := 1 + i * FRowHeight;
    y1 := y + Round(FRowHeight - DefaultSquareSide * lScale) div 2 - 1 ;

    {$IFDEF FPC}
    with ACanvas do
    {$ELSE}
    with FTempBMP.Canvas do
    {$ENDIF}
    begin
      Pen.Color := clGray;
      Brush.Color := clWhite;
      w := 1;
      if (FavoritesAcrive) then
      begin
        x := x - offs;
        SquareSide := Round(9 * lScale);
        InnerRect := Rect(x + 1 + add mod 2, y1 + add mod 2, x + 1 + SquareSide - add div 2, y1 + SquareSide - add div 2);
        if add > 1 then
        begin
          w := add;
          Inc(InnerRect.Right);
          Inc(InnerRect.Bottom);
        end;
        if (s[1] = '+') or (s[1] = '-') then
          s := Copy(s, 2, 255);
        if (x = 0) then
        begin
          Pen.Width := w;
          Rectangle(x + 1 - add div 2, y1  - add div 2, x + SquareSide + 1 + add , y1 + SquareSide + add);

          Pen.Width := 1;
          if (FFavorites.IndexOf(s) <> -1) then
          begin
            Brush.Color := clBlack;
            FillRect(Rect(x + 1 - add div 2 + (w * 2 - add div 2), y1  - add div 2 + (w * 2 - add div 2), x + SquareSide + 1 + add - w * 2, y1 + SquareSide + add - w * 2));
          end;
        end;
        Pen.Width := 1;
        Inc(x, 2 + SquareSide + Round(2 * lScale));
      end
      else
      if offs < Round(12 * lScale) then
      begin
        SquareSide := Round(9 * lScale);
        InnerRect := Rect(x + 1 + add mod 2, y1 + add mod 2, x + 1 + SquareSide - add div 2, y1 + SquareSide - add div 2);
        if add > 1 then
        begin
          w := add;
          Inc(InnerRect.Right);
          Inc(InnerRect.Bottom);
        end;
        Pen.Width := w;
        Rectangle(x + 1 - add div 2, y1  - add div 2, x + SquareSide + 1 + add , y1 + SquareSide + add);

        Pen.Width := 1;
        for idx := 0 to w - 1 do
        begin
          LineInternal(InnerRect.Left + 2, y1 + SquareSide div 2 - (add div 2) + add mod 2 + idx, (InnerRect.Right - InnerRect.Left) - 4, 0);
          if s[1] = '+' then
            LineInternal(x + SquareSide div 2 + 1 - (add div 2) + add mod 2 + idx, InnerRect.Top + 2, 0, (InnerRect.Bottom - InnerRect.Top)  - 4 );
        end;
        s := Copy(s, 2, 255);
        Pen.Width := 1;
        Inc(x, 2 + SquareSide + Round(2 * lScale));
      end;

      Brush.Style := bsClear;
      if ((s = 'Name') or (s = 'Width') or (s = 'Height') or (s = 'Left') or (s = 'Top'))
        and (GetOffset(i) = 0) then
        Font.Style := [fsBold];
      TextRect(R, x, y, s);
    end;
  end;

  function IsDefault(i: Integer): Boolean;
  var
    Obj: TObject;
    PropInfo: PPropInfo;
    val: Integer;
    PropItem: TfrxPropertyItem;
  begin
    Result := False;
    PropItem := GetItem(i);
    if PropItem = nil then Exit;
    Obj := PropItem.Editor.Component;
    if (Obj = nil) then
      Exit;
    PropInfo := GetPropInfo(Obj, PropItem.Editor.GetName);
    if PropInfo = nil then Exit;
    case PropInfo.PropType^.Kind of
      tkInteger{$IFDEF FPC}, tkInt64{$ENDIF}
               {$IFDEF DELPHI12}, tkInt64{$ENDIF},
               tkSet, tkEnumeration{$IFDEF FPC}, tkBool{$ENDIF}:
      begin
        if PropInfo.Default = Integer($80000000) then
        begin
          Result := False;
          Exit;
        end;
        val := GetOrdProp(Obj, PropItem.Editor.GetName);
        Result := val <> PropInfo.Default;
      end;
    end;
  end;

begin
  if Count > 0 then
  {$IFDEF FPC}
  with ACanvas do
  {$ELSE}
  with FTempBMP.Canvas do
  {$ENDIF}
  begin
    Pen.Color := clBtnShadow;
    Font.Assign(Self.Font);
    R := Rect(0, i * FRowHeight, FSplitterPos, i * FRowHeight + FRowHeight - 1);
    add := 0;
    lScale := CurrentFormPPI / frx_DefaultPPI;
    if lScale > 1 then
      add := Round(lScale);

    p := GetItem(i);
    s := GetName(i);
    if p.SubProperty <> nil then
    begin
      offs := Round(lScale - 1);
      if p.Expanded then
        s := '-' + s else
        s := '+' + s;
    end
    else
      offs := Round(13 * lScale);

    p.Editor.ItemHeight := FRowHeight;

    if Selected then
    begin
      Pen.Color := clBtnFace;
      LineInternal(0, FRowHeight + -1 + i * FRowHeight, PB.Width, 0);
      Brush.Color := clBtnFace;
      FillRect(R);
      DrawProperty;
    end
    else
    begin
      Pen.Color := clBtnFace;
      LineInternal(0, FRowHeight + -1 + i * FRowHeight, PB.Width, 0);
      Pen.Color := clBtnFace;
      LineInternal(FSplitterPos - 1, 0 + i * FRowHeight, 0, FRowHeight);
      DrawProperty;
      Font.Color := clNavy;
      if (IsDefault(i)) then
        Font.Style := Font.Style + [fsBold];
      if paOwnerDraw in p.Editor.GetAttributes then
        p.Editor.OnDrawItem({$IFNDEF FPC}FTempBMP.Canvas{$ELSE}ACanvas{$ENDIF},
          Rect(FSplitterPos + 2, 1 + i * FRowHeight, Width, 1 + (i + 1) * FRowHeight))
      else
        TextOut(FSplitterPos + 2, 1 + i * FRowHeight, GetValue(i));
      Font.Style := Font.Style - [fsBold];
    end;
  end;
end;


{ Form events }

procedure TfrxObjectInspector.FormShow(Sender: TObject);
begin
  AdjustControls;
end;

{$IFDEF UseTabset}
type
  THackTabSet = class(TTabSet);
{$ENDIF}
procedure TfrxObjectInspector.FormResize(Sender: TObject);
  function GetTabsWidth: Integer;
  var
{$IFNDEF UseTabset}
    i: Integer;
{$ENDIF}
    r: TRect;
  begin
{$IFDEF UseTabset}
    Result := 4;
    r := FTabs.MinClientRect(FTabs.Tabs.Count, false);
    Inc(Result, r.Right + 4);
{$ELSE}
    Result := 4;
    for i := 0 to FTabs.Tabs.Count - 1 do
    begin
{$IFDEF FPC}
      if FTabs.Tabs is TTabControlNoteBookStrings then
        r := TTabControlNoteBookStrings(FTabs.Tabs).NoteBook.TabRect(i)
      else
{$ENDIF}
      r := FTabs.TabRect(i);
      Inc(Result, r.Right - r.Left);
    end;
{$ENDIF}
  end;

var
  h, lWidth: Integer;
begin
  if (FTabs = nil) or (FFilterEdit = nil) then Exit;
{$IFDEF FPC}
  FTabs.Font.Height := -11;
  FTabs.Height := Abs(FTabs.Font.Height) + 8;
{$ELSE}
  FTabs.Font.Height := Round(-11 * CurrentFormPPI / frx_DefaultPPI);
  FTabs.Height := Abs(FTabs.Font.Height) + Round(8 * CurrentFormPPI / frx_DefaultPPI);
{$ENDIF}
  h := FTabs.Height + 4;
  if h < frxImages.MainButtonImages.Height then
    h := frxImages.MainButtonImages.Height + 4;
  FTabs.TabHeight := h;
  FTabs.SetBounds(0, ObjectsCB.Top + ObjectsCB.Height + 4, ClientWidth, h);
{$IFDEF UseTabset}
  // calculates tabs width
  if FTabs.HandleAllocated then
    THackTabSet(FTabs).Paint;
{$ENDIF}
  lWidth := FTabs.Width - GetTabsWidth;
  if lWidth > FFileterMaxWidth then
    lWidth := FFileterMaxWidth
  else if lWidth < FFileterMinWidth then
    FFilterEdit.Visible := False;
  if not FFilterEdit.Visible and (lWidth > FFileterMinWidth) then
    FFilterEdit.Visible := True;
  h := FTabs.Height;
  FFilterEdit.SetBounds(FTabs.Width - lWidth - 1, 1, lWidth, h - 3);
{$IFDEF UseTabset}
  BackPanel.Top := FTabs.Top + FTabs.Height - 1;
{$ELSE}
  BackPanel.Top := FTabs.Top + FTabs.Height - 2;
{$ENDIF}
  BackPanel.Width := ClientWidth;
  BackPanel.Height := ClientHeight - BackPanel.Top;
  ObjectsCB.Width := ClientWidth;

  FPanel.Height := Count * FRowHeight;
  FPanel.Width := Box.ClientWidth;
  AdjustControls;
end;

procedure TfrxObjectInspector.FormEndDock(Sender, Target: TObject; X, Y: Integer);
begin
  FormResize(nil);
end;

procedure TfrxObjectInspector.TabChange(Sender: TObject);
begin
  if FDesigner.IsPreviewDesigner then
    if (FTabs.TabIndex = 1) then
      FTabs.TabIndex := 0;

  case (FTabs.TabIndex) of
    0: FList := FPropertyList;
    1:
{$IFNDEF FR_VER_BASIC}
    FList := FEventList;
{$ELSE}
    FTabs.TabIndex := 0;
{$ENDIF}
    2: FList := FFavoritesList;
  end;
  FItemIndex := -1;
  FormResize(nil);
end;

procedure TfrxObjectInspector.N11Click(Sender: TObject);
begin
  if Edit1.Visible and Edit1.Focused then
    Edit1.CutToClipboard
  else if FFilterEdit.EditControl.Focused then
    FFilterEdit.EditControl.CutToClipboard;
end;

procedure TfrxObjectInspector.N21Click(Sender: TObject);
begin
  if Edit1.Visible and Edit1.Focused then
    Edit1.PasteFromClipboard
  else if FFilterEdit.EditControl.Focused then
    FFilterEdit.EditControl.PasteFromClipboard;
end;

procedure TfrxObjectInspector.N31Click(Sender: TObject);
begin
  if Edit1.Visible and Edit1.Focused then
    Edit1.CopyToClipboard
  else if FFilterEdit.EditControl.Focused then
    FFilterEdit.EditControl.CopyToClipboard;
end;

procedure TfrxObjectInspector.FilterChange(Sender: TObject);
begin
  SetFilter(FFilterEdit.EditControl.Text);
end;

function TfrxObjectInspector.FindProp(PropertyList: TfrxPropertyList;
  FullName: String): Integer;
var
  i: Integer;
  PropName: String;
begin
  Result := 0;
  i := Pos('.', FullName);
  if i > 0 then
  begin
    PropName := Copy(FullName, 1, i - 1);
    FullName := Copy(FullName, i + 1, Length(FullName) - i);
  end
  else
  begin
    PropName := FullName;
    FullName := '';
  end;
  for i := 0 to PropertyList.Count - 1 do
  begin
    PropertyList[i].Expanded := False;
    if SameText(PropertyList[i].Editor.GetName, PropName) then
    begin
      PropertyList[i].Expanded := True;
      Result := i;
      if (FullName <> '') and Assigned(PropertyList[i].SubProperty) then
        Result := Result + FindProp(PropertyList[i].SubProperty, FullName) + 1;
      break;
    end;
  end;
end;


procedure TfrxObjectInspector.FormDeactivate(Sender: TObject);
begin
  if FDisableUpdate then Exit;
  SetItemIndex(FItemIndex);
  FavoritesAcrive := False;
end;


{ PB events }

procedure TfrxObjectInspector.PBPaint(Sender: TObject);
var
  i: Integer;
  r: TRect;
begin
  if FUpdatingPB then Exit;
  {$IFNDEF FPC}
  r := PB.BoundsRect;
  FTempBMP.Width := PB.Width;
  FTempBMP.Height := PB.Height;
  with FTempBMP.Canvas do
  begin
    Brush.Color := Box.Color;
    FillRect(r);
  end;

  if not FDisableUpdate then
  begin
    for i := 0 to Count - 1 do
      if i <> ItemIndex then
        DrawOneLine(i, False);
    if FItemIndex <> -1 then
      DrawOneLine(ItemIndex, True);
  end;

  PB.Canvas.Draw(0, 0, FTempBMP);
  {$ELSE}
  // better use this one
  with PB do
  begin
    r := BoundsRect;
    Canvas.Brush.Color := Box.Brush.Color;
    Canvas.Brush.Style:=bsSolid;
    Canvas.FillRect(r);
    if not FDisableUpdate then
    begin
      for i := 0 to Count - 1 do
        if i <> ItemIndex then
          DrawOneLine(Canvas,i, False);
      if FItemIndex <> -1 then
        DrawOneLine(Canvas,ItemIndex, True);
   end;
  end;
  {$ENDIF}
  LInstruction.Visible := (FTabs.TabIndex = 2) and (Count = 0)
end;

procedure TfrxObjectInspector.RestorePosition;
var
  i: Integer;
  pName: String;
begin
  if FSelectedObjects.Count = 0 then Exit;
  pName := FLastPosition;
  for i := 0 to FSavedPositions.Count - 1 do
    if TObject(FSelectedObjects[0]).ClassType = TClass(FSavedPositions.Objects[i]) then
      pName := FSavedPositions[i];
  if pName = '' then Exit;
  FSavePosLocked := True;
  try
    i := -1;
    if FLastPosition <> pName then
      i := FindProp(FPropertyList, FLastPosition);
    { check saved }
    if i = -1 then
      i := FindProp(FPropertyList, pName);
    SetItemIndex(i);
    FormResize(nil);
  finally
    FSavePosLocked := False;
  end;
end;

procedure TfrxObjectInspector.PBMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  p: TfrxPropertyItem;
  n, fn, x1: Integer;
  lScale: Single;
begin
  FDisableDblClick := False;
  if Count = 0 then Exit;
  lScale := CurrentFormPPI / frx_DefaultPPI;
  if PB.Cursor = crHSplit then
    FDown := True
  else
  begin
    n := Y div FRowHeight;

    if (X > FSplitterPos) and (X < FSplitterPos + Round(15 * lScale)) and
       (n >= 0) and (n < Count) then
    begin
      p := GetItem(n);
      if p.Editor.ClassName = 'TfrxBooleanProperty' then
      begin
        p.Editor.Edit;
        DoModify;
        PBRePaint;
        Exit;
      end;
    end;

    if (FavoritesAcrive) then
    begin
      x1 := Round(GetOffset(n) * 12 * lScale);
      if (X > x1) and (X < x1 + Round(13 + lScale)) then
      begin
        fn := FFavorites.IndexOf(GetName(n));
        if not(fn <> -1) then
          FFavorites.Add(GetName(n))
        else
          FFavorites.Delete(fn);
        RebildFavorites;
        TabChange(Self);
        AdjustControls;
        PBRePaint;
        Exit;
      end
    end;

    ItemIndex := n;
    Edit1.SetFocus;
    FTickCount := GetTickCount;

    p := GetItem(ItemIndex);
    x1 := Round(GetOffset(ItemIndex) * 12 * lScale);
    if (X > x1) and (X < x1 + Round(13 + lScale)) and (p.SubProperty <> nil) then
    begin
      p.Expanded := not p.Expanded;
      FormResize(nil);
      FDisableDblClick := True;
    end;
  end;
end;

procedure TfrxObjectInspector.PBMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FDown := False;
end;

procedure TfrxObjectInspector.PBOnDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  n: Integer;
  p: TfrxPropertyItem;
begin
  if not Assigned(FDesigner) then Exit;
    n := Y div FRowHeight;
    ItemIndex := n;
    p := GetItem(ItemIndex);
    if p.Editor.PropInfo^.PropType^.Kind in [tkString, tkLString, tkWString{$IFDEF DEL12ORFPC}, tkUString{$ENDIF}
          {$IFDEF FPC}, tkAString{$ENDIF}] then
    begin
      SetValue(n, FDesigner.GetDataSelectedAsExp);
      AdjustControls;
    end;
end;

procedure TfrxObjectInspector.PBOnDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept := Assigned(FDesigner) and (FDesigner.IsDataTree(Source));
end;

procedure TfrxObjectInspector.PBMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  n, OffsetX, MaxWidth: Integer;
  s: String;
  HideHint: Boolean;

  procedure ShowHint(const s: String; x, y: Integer);
  var
    HintRect: TRect;
    p: TPoint;
  begin
    p := PB.ClientToScreen(Point(x - 2, y - 2));
    HintRect := FHintWindow.CalcHintRect(1000, s, nil);
    OffsetRect(HintRect, p.X, p.Y);
    FHintWindow.ActivateHint(HintRect, s);
    HideHint := False;
  end;

begin
  HideHint := True;
  FIsFavorZone := (X > 0) and (X < FSplitterPos);
  SetFavoritesActive(FIsFavorZone and (ssCtrl in Shift));
  if not FDown then
  begin
    if (X > FSplitterPos - 4) and (X < FSplitterPos + 2) then
      PB.Cursor := crHSplit
    else
    begin
      PB.Cursor := crDefault;

      { hint window }
      n := Y div FRowHeight;
      if (X > 12) and (n >= 0) and (n < Count) then
      begin
        if X <= FSplitterPos - 4 then
        begin
          OffsetX := (GetOffset(n) + 1) * 12;
          s := GetName(n);
          MaxWidth := FSplitterPos - OffsetX;
        end
        else
        begin
          OffsetX := FSplitterPos + 1;
          s := GetValue(n);
          MaxWidth := PB.ClientWidth - FSplitterPos;
          if n = ItemIndex then
            MaxWidth := 1000;
        end;

        if PB.Canvas.TextWidth(s) > MaxWidth then
          ShowHint(s, OffsetX, n * FRowHeight);
      end;
    end;
  end
  else
  begin
    if (x > 30) and (x < PB.ClientWidth - 30) then
      FSplitterPos := X;
    AdjustControls;
  end;

  if HideHint then
    FHintWindow.ReleaseHandle;
end;

procedure TfrxObjectInspector.PBDblClick(Sender: TObject);
var
  p: TfrxPropertyItem;
begin
  if (Count = 0) or FDisableDblClick then Exit;

  p := GetItem(ItemIndex);
  if (p <> nil) and (p.SubProperty <> nil) then
  begin
    p.Expanded := not p.Expanded;
    FormResize(nil);
  end;
end;


{ Edit1 events }

procedure TfrxObjectInspector.Edit1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if GetTickCount - FTickCount < GetDoubleClickTime then
    EditBtnClick(nil);
end;

procedure TfrxObjectInspector.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i: Integer;
begin
  if Count = 0 then Exit;
  if Key = vk_Escape then
  begin
    {$IFDEF FPC}
    Edit1.Undo;
    {$ELSE}
    Edit1.Perform(EM_UNDO, 0, 0);
    {$ENDIF}
    Edit1.Modified := False;
  end;
  if Key = vk_Up then
  begin
    if ItemIndex > 0 then
      ItemIndex := ItemIndex - 1;
    Key := 0;
  end
  else if Key = vk_Down then
  begin
    if ItemIndex < Count - 1 then
      ItemIndex := ItemIndex + 1;
    Key := 0;
  end
  else if Key = vk_Prior then
  begin
    i := Box.Height div FRowHeight;
    i := ItemIndex - i;
    if i < 0 then
      i := 0;
    ItemIndex := i;
    Key := 0;
  end
  else if Key = vk_Next then
  begin
    i := Box.Height div FRowHeight;
    i := ItemIndex + i;
    ItemIndex := i;
    Key := 0;
  end;
end;

procedure TfrxObjectInspector.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    if paDialog in GetType(ItemIndex) then
      EditBtnClick(nil)
    else
      if Edit1.Modified then
      begin
        Edit1.Modified := False;
        SetValue(ItemIndex, Edit1.Text);
      end;
    Edit1.SelectAll;
    Key := #0;
  end;
end;


{ EditBtn and ComboBtn events }

procedure TfrxObjectInspector.EditBtnClick(Sender: TObject);
begin
  if GetItem(ItemIndex).Editor.Edit then
  begin
    ItemIndex := FItemIndex;
    DoModify;
  end;
end;

procedure TfrxObjectInspector.ComboBtnMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FPopupLBVisible := GetTickCount - frxPopupFormCloseTime < 100;
end;

procedure TfrxObjectInspector.ComboBtnClick(Sender: TObject);
var
  i, wItems, nItems, pWidth, pHeight: Integer;
  p: TPoint;
  CurrMonitor: TMonitor;
begin
  if FPopupLBVisible then
    Edit1.SetFocus
  else
  begin
    FPopupForm := TfrxPopupForm.Create(Self);
    FPopupLB := TListBox.Create(FPopupForm);
    with FPopupLB do
    begin
      Parent := FPopupForm;
      Color := FColor;
{$IFNDEF FPC}
      Ctl3D := False;
{$ENDIF}
      Align := alClient;
      if paOwnerDraw in GetItem(FItemIndex).Editor.GetAttributes then
        Style := lbOwnerDrawFixed;
      OnClick := LBClick;
      OnDrawItem := GetItem(FItemIndex).Editor.OnDrawLBItem;
      GetItem(FItemIndex).Editor.GetValues;
      Items.Assign(GetItem(FItemIndex).Editor.Values);
{$IFDEF NONWINFPC}
      pHeight := FPopupForm.Canvas.TextHeight('Wg') + 6;
{$ELSE}
      pHeight := FPopupForm.Canvas.TextHeight('Wg') + 3;
{$ENDIF}
      pWidth := Round((PB.Width - FSplitterPos) / (CurrentFormPPI / FPopupForm.CurrentFormPPI));
      ItemHeight := pHeight;
      if Items.Count > 0 then
      begin
        ItemIndex := Items.IndexOf(GetValue(FItemIndex));
        wItems := 0;
        for i := 0 to Items.Count - 1 do
        begin
          if Canvas.TextWidth(Items[i]) > wItems then
            wItems := Canvas.TextWidth(Items[i]);
        end;

        Inc(wItems, 8);
        if paOwnerDraw in GetItem(FItemIndex).Editor.GetAttributes then
          Inc(wItems, GetItem(FItemIndex).Editor.GetExtraLBSize);
        nItems := Items.Count;
        if nItems > 8 then
        begin
          nItems := 8;
          Inc(wItems, GetSystemMetrics(SM_CXVSCROLL));
        end;

{$IFDEF NONWINFPC}
        pHeight := 20;
{$ELSE}
        pHeight := ItemHeight + 2;
{$ENDIF}

        p := Edit1.ClientToScreen(Point(0, Edit1.Height));
        if wItems < pWidth then
          FPopupForm.SetBounds(p.X - 3, p.Y,
                             pWidth + 1, nItems * pHeight)
        else
          FPopupForm.SetBounds(p.X + (pWidth - wItems) - 2, p.Y,
                             wItems, nItems * pHeight);
        if (FPopupForm.Left < 0) and (Abs(FPopupForm.Left) < FPopupForm.Width) then
          FPopupForm.Left := 0;

        pHeight := Screen.Height;
        CurrMonitor := Screen.MonitorFromWindow(FPopupForm.Handle);
        if CurrMonitor <> nil then
          pHeight := CurrMonitor.Top + CurrMonitor.Height;
        if FPopupForm.Top + FPopupForm.Height > pHeight then
          FPopupForm.Top := pHeight - FPopupForm.Height;
        FDisableUpdate := True;
        FPopupForm.Show;
        FDisableUpdate := False;
      end;
    end;
  end;
end;

procedure TfrxObjectInspector.LBClick(Sender: TObject);
begin
  Edit1.Text := FPopupLB.Items[FPopupLB.ItemIndex];
  SetValue(ItemIndex, Edit1.Text);
  FPopupForm.Hide;
  Edit1.SetFocus;
  Edit1.SelectAll;
end;


procedure TfrxObjectInspector.LoadFormPreferences(PreferencesStorage: TObject; DefPreferencesStorage: TObject);
var
  Ini: TCustomIniFile;
  lName: String;
begin
  inherited;
  if not(PreferencesStorage is TCustomIniFile) then Exit;
  Ini :=  TCustomIniFile(PreferencesStorage);
  lName := GetFormSectionName;

  SplitterPos := Round(Ini.ReadInteger(lName,
    'SplitPos', Width div 2) * CurrentFormPPI /
    frx_DefaultPPI);
  if SplitterPos > Width - 10 then
    SplitterPos := Width div 2;
  Splitter1Pos := Round(Ini.ReadInteger(lName,
    'Split1Pos', 65) * CurrentFormPPI / frx_DefaultPPI);
  if Splitter1Pos < 10 then
    Splitter1Pos := 65;
  FFavorites.DelimitedText := Ini.ReadString(lName, 'Favorites', '');
end;

{ ObjectsCB events }

procedure TfrxObjectInspector.ObjectsCBClick(Sender: TObject);
begin
  if FUpdatingObjectsCB then Exit;
  FSelectedObjects.Clear;
  if ObjectsCB.ItemIndex <> -1 then
    if ObjectsCB.Items.Objects[ObjectsCB.ItemIndex] is TfrxComponent then
      FSelectedObjects.Add(ObjectsCB.Items.Objects[ObjectsCB.ItemIndex]);
  SetSelectedObjects(FSelectedObjects);
  if Edit1.Visible then
    Edit1.SetFocus;
  if Assigned(FOnSelectionChanged) then
    FOnSelectionChanged(Self);
end;

procedure TfrxObjectInspector.ObjectsCBDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  if FDisableUpdate then exit;
  with ObjectsCB.Canvas do
  begin
    FillRect(Rect);
    if Index <> -1 then
      TextOut(Rect.Left + 2, Rect.Top + 1, ObjectsCB.Items[Index]);
  end;
end;


{ Mouse wheel }

procedure TfrxObjectInspector.FormMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  with Box.VertScrollBar do
    Position := Position + FRowHeight;
end;

procedure TfrxObjectInspector.FormMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  with Box.VertScrollBar do
    Position := Position - FRowHeight;
end;

procedure TfrxObjectInspector.CMMouseLeave(var Msg: TMessage);
begin
  FHintWindow.ReleaseHandle;
  inherited;
end;

procedure TfrxObjectInspector.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FavoritesAcrive := FavorButt in Shift;
  if Assigned(FDesigner.OnKeyDown) then
    FDesigner.OnKeyDown(Sender, Key, Shift);
end;

procedure TfrxObjectInspector.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  FavoritesAcrive := FavorButt in Shift;
  if Assigned(FDesigner.OnKeyUp) then
    FDesigner.OnKeyUp(Sender, Key, Shift);
end;

end.
