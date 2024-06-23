{*******************************************************}
{                                                       }
{                       EhLib 11.0                      }
{                    LaFlowRichBlocksEh                 }
{                                                       }
{    Copyright (c) 2022-2022 by Dmitry V. Bolshakov     }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit LaFlowRichBlocksEh;

interface

{$SCOPEDENUMS ON}

uses
  Types, Messages, Classes, SysUtils, Variants,
{$IFDEF EH_LIB_17} System.UITypes, {$ENDIF}
{$IFDEF FPC}
  EhLibLCL, LCLType,
{$ELSE}
  EhLibVCL, Windows,
{$ENDIF}
  Generics.Collections,
  // RenderEngineEh,
  LaObjectsEh, LaControlsEh,
  ToolCtrlsEh,
  Graphics, Controls, Forms, Dialogs;

type
  TLaFlowRichBlockEh = class;

  { TFlRichBlockItemEh }

  TFlRichBlockItemEh = class(TPersistent)
  private
    FFlowRichBlock: TLaFlowRichBlockEh;
  protected
    procedure ParentChanged(); virtual;

  public
    constructor Create; overload; virtual;
    constructor Create(RichBlock: TLaFlowRichBlockEh); overload;
    destructor Destroy; override;

    property FlowRichBlock: TLaFlowRichBlockEh read FFlowRichBlock;
  end;

  TFlRichBlockItemClassEh = class of TFlRichBlockItemEh;

  TRichBlockListEh = TList<TFlRichBlockItemEh>;

  { TFlBreakableTextEh }

  TFlBreakableTextEh = class(TFlRichBlockItemEh)
  private
    FFont: TFont;
    FParentFont: Boolean;
    FText: String;
    FColor: TColor;
    FIsHyperLink: Boolean;
    FTag: NativeInt;
    function IsFontStored: Boolean;
    procedure SetFont(Value: TFont);
    procedure SetParentFont(Value: Boolean);
    procedure FontChanged(Sender: TObject);
    procedure SetText(const Value: String);
    procedure UpdateFont;

  protected
    procedure ParentChanged(); override;

  public
    constructor Create; override;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;

    function SetFontStyle(AFontStyle: TFontStyles): TFlBreakableTextEh;
    function SetFontSize(AFontSize: Integer): TFlBreakableTextEh;
    function SetFontName(AFontName: String): TFlBreakableTextEh;
    function SetFontColor(AFontColor: TColor): TFlBreakableTextEh;
    function SetColor(AColor: TColor): TFlBreakableTextEh;

  published
    property Font: TFont read FFont write SetFont stored IsFontStored;
    property ParentFont: Boolean read FParentFont write SetParentFont
      default True;
    property Text: String read FText write SetText;
    property Color: TColor read FColor write FColor;
    property IsHyperLink: Boolean read FIsHyperLink write FIsHyperLink;
    property Tag: NativeInt read FTag write FTag default 0;
  end;

  { TFlLineBreakEh }

  TFlLineBreakEh = class(TFlRichBlockItemEh)

  end;

  TLaFlowRenderTextItem = class(TObject)
    ItemPos: TPoint;
    ItemSize: TSize;
    FontBaseLine: Integer;
    TopIndent: Integer;
    TextItem: TFlBreakableTextEh;
    TextSectorStart: Integer;
    TextSectorLen: Integer;
  end;

  { TLaFlowRenderTextLine }

  TLaFlowRenderTextLine = class(TObject)
    LineSize: TSize;
    BaseLine: Integer;
    LineItems: TList<TLaFlowRenderTextItem>;

  public
    constructor Create;
    destructor Destroy; override;
  end;

  { TLaFlowRichBlockEh }

  TLaFlowRichBlockEh = class(TLaControlEh)
  private
    FItems: TRichBlockListEh;
    // FItemsRenderList: TList<TLaFlowRenderTextItem>;
    FLinesRenderList: TList<TLaFlowRenderTextLine>;
    FMouseInControl: Boolean;
    FMouseOverItem: TFlRichBlockItemEh;
    FOnHyperLinkClick: TNotifyEvent;
    FWordWrap: Boolean;
    function GetItems(Index: Integer): TFlRichBlockItemEh;
    function GetItemsCount: Integer;
    function GetSelfObject: TLaFlowRichBlockEh;
    procedure SetMouseOverItem(const Value: TFlRichBlockItemEh);
    procedure ClearLinesItemsRenderList;

  protected
    procedure DrawClientWithFlowItems(ARect: TRect; ACanvas: TCanvas);
    procedure MouseEnter; override;
    procedure MouseLeave; override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;
    procedure ClearItems;
    function DoQueryLayoutClientArea(QuerySize: TSize; ACanvas: TCanvas): TSize; override;
    function DoPerformLayoutClientArea(ClientRect: TRect; ACanvas: TCanvas): TSize; override;
    procedure DrawClientForeground(ARect: TRect; ACanvas: TCanvas); override;

    function AddItem(AItem: TFlRichBlockItemEh): TFlRichBlockItemEh;
    function GetBlockItemAtPos(Pos: TPoint): TFlRichBlockItemEh;

    property WordWrap: Boolean read FWordWrap write FWordWrap;
    property ItemsCount: Integer read GetItemsCount;
    property Items[Index: Integer]: TFlRichBlockItemEh read GetItems; default;
    //property SelfObject: TLaFlowRichBlockEh read GetSelfObject;
    property RefSelf: TLaFlowRichBlockEh read GetSelfObject;
    property MouseOverItem: TFlRichBlockItemEh read FMouseOverItem write SetMouseOverItem;

    property OnHyperLinkClick: TNotifyEvent read FOnHyperLinkClick write FOnHyperLinkClick;

  published
    // property Text: String read FText write SetText;
    // property Font: TFont read FFont write SetFont stored IsFontStored;
    // property ParentFont: Boolean read FParentFont write SetParentFont default True;
  end;

function CheckURLConvertToFlowRichItems(AText: String;
  LaFlowRichBlock: TLaFlowRichBlockEh; ForceConvert: Boolean): Boolean;

implementation

function CheckURLConvertToFlowRichItemsForStartTexts(AText: String;
  LaFlowRichBlock: TLaFlowRichBlockEh; ForceConvert: Boolean; StartTexts: array of String): Boolean;

  function CheckWordStart(AText: String; APos: Integer): Boolean;
  var
    Ch: Char;
  begin
    Result := False;
    if APos = 1 then
      Exit(True)
    else
    begin
      Ch := AText[APos - 1];
      if (Ch = ' ') or (Ch = #13) or (Ch = #10) then
        Exit(True);
    end;
  end;

  function CheckWordFinish(const AText: String; APos: Integer): Boolean;
  var
    Ch: Char;
  begin
    Result := False;
    if APos >= Length(AText) - 1 then
      Exit(True)
    else
    begin
      Ch := AText[APos + 1];
      if (Ch = ' ') or (Ch = #13) or (Ch = #10) then
        Exit(True);
    end;
  end;

  function StartsText(const ASubText, AText: string; ATextStartIndex: Integer): Boolean;
  var
    ATextStart: PChar;
  begin
    if ASubText = '' then
      Result := True
    else
    begin
      if (Length(AText) - ATextStartIndex >= Length(ASubText)) then
      begin
        //ATextStart := PChar(Pointer(NativeInt(Pointer(AText)) + ATextStartIndex - 1));
        ATextStart := PChar(AText);
        ATextStart := ATextStart + ATextStartIndex - 1;
        Result := AnsiStrLIComp(PChar(ASubText), ATextStart, Length(ASubText)) = 0;
      end
      else
        Result := False;
    end;
  end;

  procedure CreateRefLink(const AText: String; APos, ALen: Integer; var LastCheckedPos: Integer);
  var
    SimpleTextItem: TFlBreakableTextEh;
    ASubText: String;
    ALinkSubText: String;
  begin
    ASubText := Copy(AText, LastCheckedPos, APos - LastCheckedPos);
    if (ASubText <> '') then
    begin
      SimpleTextItem := TFlBreakableTextEh.Create;
      SimpleTextItem.Text := ASubText;
      LaFlowRichBlock.AddItem(SimpleTextItem);
    end;

    ALinkSubText := Copy(AText, APos, ALen);
    if (ALinkSubText <> '') then
    begin
      SimpleTextItem := TFlBreakableTextEh.Create;
      SimpleTextItem.Text := ALinkSubText;
      SimpleTextItem.IsHyperLink := True;
      SimpleTextItem.Font.Color := clHotLight;
      LaFlowRichBlock.AddItem(SimpleTextItem);
    end;

    LastCheckedPos := APos + ALen;
  end;

  procedure CreateLastText(var LastCheckedPos: Integer);
  begin
    CreateRefLink(AText, Length(AText), 0, LastCheckedPos);
  end;

  function TextStartAtPos(AText: String; AStartPos: Integer; FindText: String): Boolean;
  var
    ATextLen: Integer;
    AFindTextLen: Integer;
    I: Integer;
    Chk: Boolean;
  begin
    ATextLen := Length(AText);
    AFindTextLen := Length(FindText);
    if AFindTextLen > ATextLen - AStartPos + 1 then
      Exit(False);

    for I := 0 to AFindTextLen - 1 do
    begin
      Chk := AText[AStartPos + I] = FindText[1 + I];
      if Chk = False then
        Exit(False);
    end;

    Result := True;
  end;

var
  I, J: Integer;
  LastPos: Integer;
  Chj: Char;
//  Chi: Char;
  ContainsDot: Boolean;
  LastChar: Char;
  LastCheckedPos: Integer;
  KI: Integer;
  StartText: String;
//  StartTextLength: Integer;
  StartTextIdx: Integer;
  StartRefPos: Integer;
begin
  Result := False;
  LaFlowRichBlock.ClearItems;
  ContainsDot := False;
  LastCheckedPos := 1;
  I := 1;
  while I <= Length(AText) do
  //for I := 1 to Length(AText) do
  begin
//    Chi := AText[I];

    StartTextIdx := -1;
    for KI := 0 to Length(StartTexts) - 1 do
    begin
      StartText := StartTexts[KI];
      if (TextStartAtPos(AText, I, StartText) = True) then
      begin
        StartTextIdx := KI;
        Break;
      end;
    end;

    if (StartTextIdx >= 0) and
       CheckWordStart(AText, I) then
    begin
      LastChar := #0;
      LastPos := I;
      StartRefPos := I;
      I := I + Length(StartTexts[StartTextIdx]) - 1;
      for J := I + 1 to Length(AText) do
      begin
        Chj := AText[J];
        if (CharInSetEh(Chj, ['a'..'z', 'A'..'Z', '0'..'9', '-', '.', '_', '~', '/']) = True) then
        begin
          LastPos := J;
          LastChar := Chj;
          if Chj = '.' then
            ContainsDot := True;
          Result := True;
        end else
        begin
          Break;
        end;
      end;

      if ContainsDot and
         (LastChar <> '.') and
         CheckWordFinish(AText, LastPos) then
      begin
        CreateRefLink(AText, StartRefPos, LastPos - StartRefPos + 1, LastCheckedPos);
        I := LastPos + 1;
      end;
    end;
    Inc(I);
  end;

  if (LastCheckedPos > 1) or (ForceConvert = True) then
  begin
    CreateLastText(LastCheckedPos);
  end;
end;

function CheckURLConvertToFlowRichItems(AText: String;
  LaFlowRichBlock: TLaFlowRichBlockEh; ForceConvert: Boolean): Boolean;
begin
  Result := CheckURLConvertToFlowRichItemsForStartTexts(AText,  LaFlowRichBlock,
    ForceConvert, ['www.', 'WWW.', 'http://', 'HTTP://', 'https://', 'HTTPS://']);
end;

{ TLaFlowRichBlockEh }

function TLaFlowRichBlockEh.AddItem(AItem: TFlRichBlockItemEh)
  : TFlRichBlockItemEh;
begin
  FItems.Add(AItem);
  AItem.FFlowRichBlock := Self;
  AItem.ParentChanged();
  Result := AItem;
end;

procedure TLaFlowRichBlockEh.Assign(Source: TPersistent);
var
  SrcRTBlock: TLaFlowRichBlockEh;
  SrcRTBlockItem: TFlRichBlockItemEh;
  I: Integer;
  NewItem: TFlRichBlockItemEh;
begin
  inherited Assign(Source);

  if (Source is TLaFlowRichBlockEh) then
  begin
    SrcRTBlock := TLaFlowRichBlockEh(Source);
    OnHyperLinkClick := SrcRTBlock.OnHyperLinkClick;
    WordWrap := SrcRTBlock.WordWrap;

    for I := 0 to SrcRTBlock.ItemsCount - 1 do
    begin
      SrcRTBlockItem := SrcRTBlock.Items[I];
      NewItem := TFlRichBlockItemClassEh(SrcRTBlockItem.ClassType).Create;
      NewItem.Assign(SrcRTBlockItem);
      AddItem(NewItem);
    end;
  end;
end;

procedure TLaFlowRichBlockEh.ClearItems;
var
  I: Integer;
  Item: TFlRichBlockItemEh;
begin
  // DeleteChildren;
  while FItems.Count > 0 do
  begin
    I := FItems.Count - 1;
    Item := FItems[I];
    FItems.Delete(I);
    // Item.FParent := nil;
    // Item.SetRoot(nil);
    Item.Free;
  end;
end;

constructor TLaFlowRichBlockEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FItems := TRichBlockListEh.Create;
  FLinesRenderList := TList<TLaFlowRenderTextLine>.Create;
end;

destructor TLaFlowRichBlockEh.Destroy;
begin
  ClearItems;
  FreeAndNil(FItems);
  ClearLinesItemsRenderList;
  FreeAndNil(FLinesRenderList);
  inherited Destroy;
end;

function TLaFlowRichBlockEh.GetItems(Index: Integer): TFlRichBlockItemEh;
begin
  Result := FItems[Index];
end;

function TLaFlowRichBlockEh.GetItemsCount: Integer;
begin
  Result := FItems.Count;
end;

function TLaFlowRichBlockEh.GetSelfObject: TLaFlowRichBlockEh;
begin
  Result := Self;
end;

procedure TLaFlowRichBlockEh.MouseEnter;
begin
  inherited MouseEnter;
  FMouseInControl := True;
end;

procedure TLaFlowRichBlockEh.MouseLeave;
begin
  inherited MouseLeave;
  FMouseInControl := False;
  MouseOverItem := nil;
end;

procedure TLaFlowRichBlockEh.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  LI, PI: Integer;
  ARect: TRect;
  NewMouseOverItem: TFlRichBlockItemEh;
  LineRenLine: TLaFlowRenderTextLine;
  RenItem: TLaFlowRenderTextItem;
begin
  inherited MouseMove(Shift, X, Y);

  NewMouseOverItem := nil;
  for LI := 0 to FLinesRenderList.Count - 1 do
  begin
    LineRenLine := FLinesRenderList[LI];
    for PI := 0 to LineRenLine.LineItems.Count - 1 do
    begin
      RenItem := LineRenLine.LineItems[PI];
      ARect.TopLeft := RenItem.ItemPos;
      ARect.Right := ARect.Left + RenItem.ItemSize.cx;
      ARect.Bottom := ARect.Top + RenItem.ItemSize.cy;

      if RenItem.TextItem.IsHyperLink and RectContains(ARect, Classes.Point(X, Y)) then
      begin
        NewMouseOverItem := RenItem.TextItem;
        Break;
      end;
    end;
  end;

  MouseOverItem := NewMouseOverItem;
end;

procedure TLaFlowRichBlockEh.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  BlockItem: TFlRichBlockItemEh;
  TextBlockItem: TFlBreakableTextEh;
begin
  inherited MouseDown(Button, Shift, X, Y);
  BlockItem := GetBlockItemAtPos(Classes.Point(X, Y));
  if (BlockItem <> nil) then
  begin
    if (BlockItem is TFlBreakableTextEh) then
    begin
      TextBlockItem := TFlBreakableTextEh(BlockItem);
      if (TextBlockItem.IsHyperLink = True) and Assigned(OnHyperLinkClick) then
        OnHyperLinkClick(TextBlockItem);
    end;
  end;
end;

function TLaFlowRichBlockEh.GetBlockItemAtPos(Pos: TPoint): TFlRichBlockItemEh;
var
  LI, PI: Integer;
  ARect: TRect;
  // NewMouseOverItem: TFlRichBlockItemEh;
  LineRenLine: TLaFlowRenderTextLine;
  RenItem: TLaFlowRenderTextItem;
begin
  Result := nil;

  for LI := 0 to FLinesRenderList.Count - 1 do
  begin
    LineRenLine := FLinesRenderList[LI];
    for PI := 0 to LineRenLine.LineItems.Count - 1 do
    begin
      RenItem := LineRenLine.LineItems[PI];
      ARect.TopLeft := RenItem.ItemPos;
      ARect.Right := ARect.Left + RenItem.ItemSize.cx;
      ARect.Bottom := ARect.Top + RenItem.ItemSize.cy;

      if RenItem.TextItem.IsHyperLink and RectContains(ARect, Pos) then
      begin
        Result := RenItem.TextItem;
        Break;
      end;
    end;
  end;
end;

procedure TLaFlowRichBlockEh.SetMouseOverItem(const Value: TFlRichBlockItemEh);
begin
  if FMouseOverItem <> Value then
  begin
    FMouseOverItem := Value;

    if (FMouseOverItem <> nil) then
      Screen.Cursor := crHandPoint
    else
      Screen.Cursor := crDefault;

    Invalidate;
  end;
end;

function TLaFlowRichBlockEh.DoQueryLayoutClientArea(QuerySize: TSize;
  ACanvas: TCanvas): TSize;
var
  TextSize: TSize;
  I: Integer;
  Item: TFlRichBlockItemEh;
  TextItem: TFlBreakableTextEh;
  TextItemSize: TSize;
  FirstLineMarging: Integer;
  ItemLines: TWrappedLinesInfoEh;
  CurLineHeight: Integer;
  CurLineWidth: Integer;
begin
  // ACanvas.Font := Font;
  // Result := ACanvas.TextExtent(Text);
  Result := CreateSize(0, 0);
  FirstLineMarging := 0;
  CurLineHeight := 0;
  CurLineWidth := 0;

  if (WordWrap) then
  begin
    for I := 0 to ItemsCount - 1 do
    begin
      Item := Items[I];
      TextItem := Item as TFlBreakableTextEh;
      if (TextItem <> nil) then
      begin
        ACanvas.Font := TextItem.Font;
        ItemLines := MeasureTextInLinesEh(ACanvas, QuerySize.cx, TextItem.Text,
          True, TextItemSize, FirstLineMarging);
        // TextSize := ACanvas.TextExtent(TextItem.Text);
        if (Length(ItemLines) = 1) then
        begin
          if (CurLineHeight < ItemLines[0].phi) then
            CurLineHeight := ItemLines[0].phi;
          Result.cx := Result.cx + ItemLines[0].pwi;
          FirstLineMarging := ItemLines[0].pwi;
        end;

        // if (Result.cy < TextSize.cy) then
        // Result.cy := TextSize.cy;
        // Result.cx := Result.cx + TextSize.cx;
        // FirstLineMarging := ItemLines[Length(ItemLines) - 1].pwi;
      end;
    end;

    Result.cy := Result.cy + CurLineHeight;
    if (Result.cx < CurLineWidth) then
      Result.cx := CurLineWidth;
  end
  else
  begin
    for I := 0 to ItemsCount - 1 do
    begin
      Item := Items[I];
      TextItem := Item as TFlBreakableTextEh;
      if (TextItem <> nil) then
      begin
        ACanvas.Font := TextItem.Font;
        TextSize := ACanvas.TextExtent(TextItem.Text);
        if (Result.cy < TextSize.cy) then
          Result.cy := TextSize.cy;
        Result.cx := Result.cx + TextSize.cx;
      end;
    end;
  end;
end;

function TLaFlowRichBlockEh.DoPerformLayoutClientArea(ClientRect: TRect;
  ACanvas: TCanvas): TSize;
var
  I, LI, RI: Integer;
  BlockItem: TFlRichBlockItemEh;
  TextItem: TFlBreakableTextEh;
  // RTextData: TLaFlowRenderTextItem;
  // MaxFontBaseLine: Integer;
  // MaxFontSize: Integer;
  Pos: TPoint;

  RenLine: TLaFlowRenderTextLine;
  RenItem: TLaFlowRenderTextItem;
  PerformWidth: Integer;
  TextItemSize: TSize;
  FirstLineMarging: Integer;
  ItemLines: TWrappedLinesInfoEh;
  MTI: Integer;
  BlockFullWidth: Integer;
  BlockFullHeight: Integer;
  // LineWidth: Integer;

  function GetFontBaseLine(AFont: TFont): Integer;
  var
    tm: TTextMetric;
  begin
    ACanvas.Font := AFont;
    GetTextMetricsEh(ACanvas, tm);
    Result := tm.tmAscent;
  end;

begin
  // ACanvas.Font := Font;

  PerformWidth := RectWidth(ClientRect);
  BlockFullWidth := 0;
  BlockFullHeight := 0;
  // MaxFontBaseLine := 0;
  // MaxFontSize := 0;
  Pos := Point(0, 0);
  FirstLineMarging := 0;
  ClearLinesItemsRenderList;

  if WordWrap = True then
  begin
    RenLine := TLaFlowRenderTextLine.Create;

    for I := 0 to ItemsCount - 1 do
    begin
      BlockItem := Items[I];
      TextItem := BlockItem as TFlBreakableTextEh;
      if (TextItem <> nil) then
      begin
        ACanvas.Font := TextItem.Font;

        ItemLines := MeasureTextInLinesEh(ACanvas, PerformWidth, TextItem.Text,
          True, TextItemSize, FirstLineMarging);

        for MTI := 0 to Length(ItemLines) - 1 do
        begin
          if (MTI > 0) then
          begin
            if (RenLine.LineSize.cx > BlockFullWidth) then
              BlockFullWidth := RenLine.LineSize.cx;
            BlockFullHeight := BlockFullHeight + RenLine.LineSize.cy;
            Pos.X := 0;
            Pos.Y := BlockFullHeight;
            FirstLineMarging := 0;

            FLinesRenderList.Add(RenLine);
            RenLine := TLaFlowRenderTextLine.Create;
          end;

          RenItem := TLaFlowRenderTextItem.Create;
          RenItem.ItemPos := Pos;
          RenItem.ItemSize.cx := ItemLines[MTI].pwi;
          RenItem.ItemSize.cy := ItemLines[MTI].phi;
          RenItem.FontBaseLine := GetFontBaseLine(TextItem.Font);
          if RenItem.FontBaseLine > RenLine.BaseLine then
            RenLine.BaseLine := RenItem.FontBaseLine;
          if (RenItem.ItemSize.cy > RenLine.LineSize.cy) then
            RenLine.LineSize.cy := RenItem.ItemSize.cy;
          RenItem.TopIndent := 0;
          RenItem.TextItem := TextItem;
          RenItem.TextSectorStart := ItemLines[MTI].st;
          RenItem.TextSectorLen := ItemLines[MTI].le;

          RenLine.LineItems.Add(RenItem);

          Pos.X := Pos.X + RenItem.ItemSize.cx;
          RenLine.LineSize.cx := RenLine.LineSize.cx + RenItem.ItemSize.cx;
        end;

        FirstLineMarging := FirstLineMarging + ItemLines[Length(ItemLines) - 1].pwi;

        // RenItem.ItemSize := ACanvas.TextExtent(TextItem.Text);
      end;
    end;

    if (RenLine.LineSize.cx > BlockFullWidth) then
      BlockFullWidth := RenLine.LineSize.cx;
    BlockFullHeight := BlockFullHeight + RenLine.LineSize.cy;
    FLinesRenderList.Add(RenLine);
  end
  else
  begin
    RenLine := TLaFlowRenderTextLine.Create;

    for I := 0 to ItemsCount - 1 do
    begin
      BlockItem := Items[I];
      TextItem := BlockItem as TFlBreakableTextEh;
      if (TextItem <> nil) then
      begin
        ACanvas.Font := TextItem.Font;
        RenItem := TLaFlowRenderTextItem.Create;
        RenItem.ItemPos := Pos;
        RenItem.ItemSize := ACanvas.TextExtent(TextItem.Text);
        RenItem.FontBaseLine := GetFontBaseLine(TextItem.Font);
        if RenItem.FontBaseLine > RenLine.BaseLine then
          RenLine.BaseLine := RenItem.FontBaseLine;
        if (RenItem.ItemSize.cy > RenLine.LineSize.cy) then
          RenLine.LineSize.cy := RenItem.ItemSize.cy;
        RenItem.TopIndent := 0;
        RenItem.TextItem := TextItem;
        RenItem.TextSectorStart := 0;
        RenItem.TextSectorLen := Length(TextItem.Text);

        RenLine.LineItems.Add(RenItem);
        Pos.X := Pos.X + RenItem.ItemSize.cx;
      end;
    end;

    RenLine.LineSize.cx := Pos.X;
    // RenLine.LineSize.cy := MaxFontSize;
    // RenLine.BaseLine := MaxFontBaseLine;
    FLinesRenderList.Add(RenLine);

    BlockFullWidth := RenLine.LineSize.cx;
    BlockFullHeight := RenLine.LineSize.cy;
  end;

  for LI := 0 to FLinesRenderList.Count - 1 do
  begin
    RenLine := FLinesRenderList[LI];

    for RI := 0 to RenLine.LineItems.Count - 1 do
    begin
      RenItem := RenLine.LineItems[RI];
      if (RenItem.FontBaseLine < RenLine.BaseLine) then
        RenItem.TopIndent := RenLine.BaseLine - RenItem.FontBaseLine;
    end;
  end;

  Result.cx := BlockFullWidth;
  Result.cy := BlockFullHeight;
end;

procedure TLaFlowRichBlockEh.DrawClientWithFlowItems(ARect: TRect;
  ACanvas: TCanvas);
var
  LI, RI: Integer;
  TextItem: TFlBreakableTextEh;
  TextSize: TSize;
  Pos: TPoint;
  ATextRect: TRect;
  MaxFontSize: Integer;
  TopIndent: Integer;

  RenLine: TLaFlowRenderTextLine;
  RenItem: TLaFlowRenderTextItem;
  ADrawText: String;
begin
  Pos.X := ARect.Left;
  Pos.Y := ARect.Top;

  MaxFontSize := 0;

  for LI := 0 to FLinesRenderList.Count - 1 do
  begin
    RenLine := FLinesRenderList[LI];

    for RI := 0 to RenLine.LineItems.Count - 1 do
    begin
      RenItem := RenLine.LineItems[RI];
      TextItem := RenItem.TextItem;
      if (TextItem <> nil) then
      begin
        TextSize := RenItem.ItemSize;
        TopIndent := RenItem.TopIndent + Pos.Y;
        ATextRect := Rect(Pos.X, TopIndent, Pos.X + TextSize.cx, MaxFontSize);

        if (TextItem.Color <> clNone) then
        begin
          ACanvas.Brush.Color := TextItem.Color;
          ACanvas.FillRect(ATextRect);
        end;

        ACanvas.Font := TextItem.Font;
        if (RenItem.TextItem = FMouseOverItem) then
          ACanvas.Font.Style := ACanvas.Font.Style + [TFontStyle.fsUnderline];

        ADrawText := Copy(TextItem.Text, RenItem.TextSectorStart + 1, RenItem.TextSectorLen);

        ACanvas.TextOut(ATextRect.Left, ATextRect.Top, ADrawText);
        Pos.X := Pos.X + TextSize.cx;
      end;
    end;

    Pos.Y := Pos.Y + RenLine.LineSize.cy;
    Pos.X := 0;
  end;
end;

procedure TLaFlowRichBlockEh.DrawClientForeground(ARect: TRect;
  ACanvas: TCanvas);
begin
  // if (Text <> '')
  // then DrawClientWithText(ARect, ACanvas)
  // else DrawClientWithFlowItems(ARect, ACanvas)
  DrawClientWithFlowItems(ARect, ACanvas);
end;

procedure TLaFlowRichBlockEh.ClearLinesItemsRenderList;
var
  LI, PI: Integer;
  RenLine: TLaFlowRenderTextLine;
  RenItem: TLaFlowRenderTextItem;
begin
  for LI := 0 to FLinesRenderList.Count - 1 do
  begin
    RenLine := FLinesRenderList[LI];
    for PI := 0 to RenLine.LineItems.Count - 1 do
    begin
      RenItem := RenLine.LineItems[PI];
      RenItem.Free;
      RenLine.LineItems[PI] := nil;
    end;
    RenLine.LineItems.Clear;
    RenLine.Free;
    FLinesRenderList[LI] := nil;
  end;
  FLinesRenderList.Clear;
end;

// procedure TLaFlowRichBlockEh.FontChanged(Sender: TObject);
// begin
// FParentFont := False;
// end;

// function TLaFlowRichBlockEh.IsFontStored: Boolean;
// begin
// Result := not ParentFont;
// end;
//
// procedure TLaFlowRichBlockEh.SetFont(Value: TFont);
// begin
// FFont.Assign(Value);
// end;
//
// procedure TLaFlowRichBlockEh.SetParentFont(Value: Boolean);
// begin
// if FParentFont <> Value then
// begin
// FParentFont := Value;
/// /    if (FParent <> nil) and not (csReading in ComponentState) then
/// /      Perform(CM_PARENTFONTCHANGED, 0, 0);
// end;
// end;

// procedure TLaFlowRichBlockEh.SetText(const Value: String);
// begin
// if (FText <> Value) then
// begin
// if (ItemsCount > 0) then
// raise Exception.Create('FlowRichBlock can'' assign Text when RichBlockItems is not empty');
// FText := Value;
// end;
// end;

{ TFlRichBlockItemEh }

constructor TFlRichBlockItemEh.Create;
begin
end;

constructor TFlRichBlockItemEh.Create(RichBlock: TLaFlowRichBlockEh);
begin
  Create;
  RichBlock.AddItem(Self);
end;

destructor TFlRichBlockItemEh.Destroy;
begin
  inherited Destroy;
end;

procedure TFlRichBlockItemEh.ParentChanged;
begin
end;

{ TFlBreakableTextEh }

procedure TFlBreakableTextEh.Assign(Source: TPersistent);
var
  SrcFlText: TFlBreakableTextEh;
begin
  if (Source is TFlBreakableTextEh) then
  begin
    SrcFlText := TFlBreakableTextEh(Source);
    if (not SrcFlText.ParentFont) then
      Font := SrcFlText.Font;
    Text := SrcFlText.Text;
    Color := SrcFlText.Color;
    IsHyperLink := SrcFlText.IsHyperLink;
    Tag := SrcFlText.Tag;
  end;
end;

constructor TFlBreakableTextEh.Create;
begin
  inherited Create;
  FFont := TFont.Create;
  FFont.OnChange := FontChanged;
  FColor := clNone;
end;

// constructor TFlBreakableTextEh.Create(AText: String);
// begin
// Create;
// Text := AText;
// Color := clNone;
// end;
//
// constructor TFlBreakableTextEh.Create(AText, AFontName: String;
// AFontSize: Integer; AFontStyles: TFontStyles; ABackColor: TColor);
// begin
// Create;
// Text := AText;
// if (AFontName <> '') then
// Font.Name := AFontName;
// if (AFontSize <> -1) then
// Font.Size := AFontSize;
// Font.Style := AFontStyles;
// Color := ABackColor;
// end;
//
// constructor TFlBreakableTextEh.Create(AText: String; AFontStyles: TFontStyles);
// begin
// Create;
// Text := AText;
// Font.Style := AFontStyles;
// Color := clNone;
// end;

destructor TFlBreakableTextEh.Destroy;
begin
  FreeAndNil(FFont);
  inherited Destroy;
end;

procedure TFlBreakableTextEh.FontChanged(Sender: TObject);
begin
  FParentFont := False;
end;

function TFlBreakableTextEh.IsFontStored: Boolean;
begin
  Result := not ParentFont;
end;

procedure TFlBreakableTextEh.SetFont(Value: TFont);
begin
  FFont.Assign(Value);
end;

function TFlBreakableTextEh.SetFontColor(AFontColor: TColor)
  : TFlBreakableTextEh;
begin
  Font.Color := AFontColor;
  Result := Self;
end;

function TFlBreakableTextEh.SetColor(AColor: TColor): TFlBreakableTextEh;
begin
  FColor := AColor;
  Result := Self;
end;

function TFlBreakableTextEh.SetFontName(AFontName: String): TFlBreakableTextEh;
begin
  Font.Name := AFontName;
  Result := Self;
end;

function TFlBreakableTextEh.SetFontSize(AFontSize: Integer): TFlBreakableTextEh;
begin
  Font.Size := AFontSize;
  Result := Self;
end;

function TFlBreakableTextEh.SetFontStyle(AFontStyle: TFontStyles)
  : TFlBreakableTextEh;
begin
  Font.Style := AFontStyle;
  Result := Self;
end;

procedure TFlBreakableTextEh.SetParentFont(Value: Boolean);
begin
  if FParentFont <> Value then
  begin
    FParentFont := Value;
    UpdateFont;
    // if (FParent <> nil) and not (csReading in ComponentState) then
    // Perform(CM_PARENTFONTCHANGED, 0, 0);
  end;
end;

procedure TFlBreakableTextEh.SetText(const Value: String);
begin
  FText := Value;
end;

procedure TFlBreakableTextEh.UpdateFont;
begin
  if (FFlowRichBlock <> nil) and (ParentFont = True) then
    Font := FFlowRichBlock.Font;
end;

procedure TFlBreakableTextEh.ParentChanged;
begin
  inherited ParentChanged;
  UpdateFont;
end;

{ TLaFlowRenderTextLine }

constructor TLaFlowRenderTextLine.Create;
begin
  inherited Create;
  LineItems := TList<TLaFlowRenderTextItem>.Create;
end;

destructor TLaFlowRenderTextLine.Destroy;
var
  I: Integer;
begin
  for I := 0 to LineItems.Count - 1 do
    LineItems[I].Free;
  FreeAndNil(LineItems);

  inherited Destroy;
end;

end.
