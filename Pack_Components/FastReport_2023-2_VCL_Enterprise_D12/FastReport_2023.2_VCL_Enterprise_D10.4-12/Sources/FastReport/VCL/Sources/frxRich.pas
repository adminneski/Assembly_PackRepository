
{******************************************}
{                                          }
{             FastReport VCL               }
{         RichEdit Add-In Object           }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxRich;

interface

{$I frx.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Forms, Menus, frxClass,
  RichEdit,
  frxRichEdit,
  frxPrinter, frCore
{$IFDEF DELPHI6}
, Variants
{$ENDIF}
{$IFDEF FR_COM}
, ActiveX, AxCtrls
, ClrStream
, FastReport_TLB
{$ENDIF}
{$IFDEF DELPHI16}
 , Vcl.Controls
{$ENDIF};


{$IFDEF WIN64}
//const RichEditVersion: Integer = 3;
{$ENDIF}

type
{$IFDEF DELPHI16}
/// <summary>
///   The TfrxRichObject allows the use of thee RichText component in your
///   report. TfrxRichObject is an empty component. It is used to add the
///   frxRich.pas file to the "uses" list. The main component is TfrxRichView.
/// </summary>
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxRichObject = class(TComponent)  // fake component
  end;
{$IFDEF FR_COM}
  TfrxRichView = class(TfrxStretcheable, IfrxRichView)
{$ELSE}
  /// <summary>
  ///   The TfrxRichView component represents a RichText object. Component uses
  ///   the RX RichEdit and allows RTF 4.1 text. You can also show RTF text
  ///   contained in the DB field (you should set DataSet, DataField
  ///   properties). RTF text may contain expressions.
  /// </summary>
  TfrxRichView = class(TfrxStretcheable)
{$ENDIF}
  private
    FAllowExpressions: Boolean;
    FExpressionDelimiters: String;
    FFlowTo: TfrxRichView;
    FGapX: Extended;
    FGapY: Extended;
    FParaBreak: Boolean;
    FRichEdit: TrxRichEdit;
    FTempStream: TMemoryStream;
    FTempStream1: TMemoryStream;
    FWysiwyg: Boolean;
    FHasNextDataPart: Boolean;
    FStopSplit: Boolean;
    FLastChar: Integer;
    FFileLink: String;
    function CreateMetafile: TMetafile;
    function IsExprDelimitersStored: Boolean;
    function UsePrinterCanvas: Boolean;
    procedure ReadData(Stream: TStream);
    procedure WriteData(Stream: TStream);
  protected
    procedure DefineProperties(Filer: TFiler); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX, OffsetY: Extended); override;
    procedure AfterPrint; override;
    procedure BeforePrint; override;
    procedure GetData; override;
    procedure InitPart; override;
    function CalcHeight: Extended; override;
    function DrawPart: Extended; override;
    class function GetDescription: String; override;
    function GetComponentText: String; override;
    function HasNextDataPart(aFreeSpace: Extended): Boolean; override;
    function IsEMFExportable: Boolean; override;
    /// <summary>
    ///   Reference to internal TrxRichEdit object.
    /// </summary>
    property RichEdit: TrxRichEdit read FRichEdit;
  published
    /// <summary>
    ///   Determines if the RTF text may contain expressions.
    /// </summary>
    property AllowExpressions: Boolean read FAllowExpressions
      write FAllowExpressions default True;
    property BrushStyle;
    property Color;
    property Cursor;
    property DataField;
    property DataSet;
    property DataSetName;
    /// <summary>
    ///   Set of symbols, designating the expression. Default value is '[,]'.
    ///   You can use several symbols, for example '&lt;%,%&gt;'. The opening
    ///   and closing symbols cannot be similar, so '%,%' will not work.
    /// </summary>
    property ExpressionDelimiters: String read FExpressionDelimiters
      write FExpressionDelimiters stored IsExprDelimitersStored;
    /// <summary>
    ///   Link to the Rich object that will show the text that not fit in this
    ///   object.
    /// </summary>
    property FlowTo: TfrxRichView read FFlowTo write FFlowTo;
    property FillType;
    property Fill;
    property Frame;
    property FileLink: String read FFileLink write FFileLink;
    /// <summary>
    ///   The left indent of the text, in pixels.
    /// </summary>
    property GapX: Extended read FGapX write FGapX;
    /// <summary>
    ///   The top indent of the text, in pixels.
    /// </summary>
    property GapY: Extended read FGapY write FGapY;
    property Style;
    property TagStr;
    property URL;
    /// <summary>
    ///   Determines if the object should use the printer canvas to format the
    ///   text. A printer should be installed and ready.
    /// </summary>
    property Wysiwyg: Boolean read FWysiwyg write FWysiwyg default True;
  end;


    /// <summary>
    ///   Method copies the RichFrom to RichTo RichEdit object.
    /// </summary>
    procedure frxAssignRich(RichFrom, RichTo: TrxRichEdit);



implementation

uses
  frxRichRTTI,
{$IFNDEF NO_EDITORS}
  frxRichEditor, frxRichInPlaceEditor,
{$ENDIF}
  frxUtils, frxDsgnIntf, frxRes, StrUtils
{$IFNDEF NO_CRITICAL_SECTION}
  , SyncObjs
{$ENDIF};

{$IFNDEF NO_CRITICAL_SECTION}
var
  frxCSRich: TCriticalSection;
{$ENDIF}

procedure frxAssignRich(RichFrom, RichTo: TrxRichEdit);
var
  st: TMemoryStream;
begin
  st := TMemoryStream.Create;
  try
    RichFrom.Lines.SaveToStream(st);
    st.Position := 0;
    RichTo.Lines.LoadFromStream(st);
  finally
    st.Free;
  end;
end;


{ TfrxRichView }

constructor TfrxRichView.Create(AOwner: TComponent);
begin
  inherited;
{$IFNDEF NO_CRITICAL_SECTION}
  frxCSRich.Enter;
  try
{$ENDIF}
    FRichEdit := TrxRichEdit.Create(nil);
    FRichEdit.Parent := frxParentForm;
    SendMessage(frxParentForm.Handle, WM_CREATEHANDLE, frInteger(FRichEdit), 0);
    FRichEdit.AutoURLDetect := False;

  { make rich transparent }
    SetWindowLong(FRichEdit.Handle, GWL_EXSTYLE,
    GetWindowLong(FRichEdit.Handle, GWL_EXSTYLE) or WS_EX_TRANSPARENT);
{$IFNDEF NO_CRITICAL_SECTION}
  finally
    frxCSRich.Leave;
  end;
{$ENDIF}
  FTempStream := TMemoryStream.Create;
  FTempStream1 := TMemoryStream.Create;

  FAllowExpressions := True;
  FExpressionDelimiters := '[,]';
  FGapX := 2;
  FGapY := 1;
  FWysiwyg := True;
  FHasNextDataPart := True;
  FLastChar := 0;
end;

destructor TfrxRichView.Destroy;
begin
{$IFNDEF NO_CRITICAL_SECTION}
  frxCSRich.Enter;
  try
{$ENDIF}
    SendMessage(frxParentForm.Handle, WM_DESTROYHANDLE, frInteger(FRichEdit), 0);
    FRichEdit.Free;
{$IFNDEF NO_CRITICAL_SECTION}
  finally
    frxCSRich.Leave;
  end;
{$ENDIF}
  FTempStream.Free;
  FTempStream1.Free;
  inherited;
end;

class function TfrxRichView.GetDescription: String;
begin
  Result := frxResources.Get('obRich');
end;

function TfrxRichView.IsExprDelimitersStored: Boolean;
begin
  Result := FExpressionDelimiters <> '[,]';
end;

procedure TfrxRichView.DefineProperties(Filer: TFiler);
begin
  inherited;
  Filer.DefineBinaryProperty('RichEdit', ReadData, WriteData, True);
end;

procedure TfrxRichView.ReadData(Stream: TStream);
begin
  FRichEdit.Lines.LoadFromStream(Stream);
end;

procedure TfrxRichView.WriteData(Stream: TStream);
begin
  FRichEdit.Lines.SaveToStream(Stream);
end;

procedure TfrxRichView.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = FFlowTo) then
    FFlowTo := nil;
end;

function TfrxRichView.UsePrinterCanvas: Boolean;
begin
  Result := frxPrinters.HasPhysicalPrinters and FWysiwyg;
end;

function TfrxRichView.CreateMetafile: TMetafile;
var
  Range: TFormatRange;
  EMFCanvas: TMetafileCanvas;
  PrinterHandle: TfrHandle;
  aScaleX, aScaleY: Extended;
//  BottomOffset :Integer;
begin
{$IFNDEF NO_CRITICAL_SECTION}
  frxCSRich.Enter;
{$ENDIF}
  try
    if UsePrinterCanvas then
      PrinterHandle := frxPrinters.Printer.Canvas.Handle
    else
      PrinterHandle := GetDC(0);
  finally
{$IFNDEF NO_CRITICAL_SECTION}
    frxCSRich.Leave;
{$ENDIF}
  end;
  FillChar(Range, SizeOf(TFormatRange), 0);

  Range.rc := Rect(Round(GapX * 1440 / 96), Round(GapY * 1440 / 96),
    Round((Width - GapX) * 1440 / 96), Round((Height - GapY) * 1440 / 96));
  Range.rcPage := Range.rc;

  Result := TMetafile.Create;
{$IFNDEF NO_CRITICAL_SECTION}
  frxCSRich.Enter;
{$ENDIF}
  try
    GetDisplayScale(PrinterHandle, UsePrinterCanvas, aScaleX, aScaleY);
  finally
{$IFNDEF NO_CRITICAL_SECTION}
    frxCSRich.Leave;
{$ENDIF}
  end;
  Result.Width := Round(Width * aScaleX);
  Result.Height := Round(Height * aScaleY);
{$IFNDEF NO_CRITICAL_SECTION}
  frxCSRich.Enter;
{$ENDIF}
  EMFCanvas := TMetafileCanvas.Create(Result, PrinterHandle);

  EMFCanvas.Lock;
  try
    Range.hdc := EMFCanvas.Handle;
    Range.hdcTarget := Range.hdc;

    (* code to process all Rich edit page,
      at this moment engine split big RTF by page tag
      so this code is nessasary only for very small RTF wit pages
      therefore i have commented it.
      Delete in futer if none will ask it

      chrg.cpMax := RichEdit.GetTextLen;
      chrg.cpMin:= 0;
      BottomOffset := 0;
      { process all pages in RichEdit, maybe it contain /PAGE tag}
      repeat
      with rc do
      begin
      FRichEdit.Perform(EM_FORMATRANGE, 0, frInteger(@Range));
      if Bottom > rcPage.Bottom then break;
      chrg.cpMin := FRichEdit.Perform(EM_FORMATRANGE, 1, frInteger(@Range));
      Top := Top + Bottom - BottomOffset;
      BottomOffset := Bottom;
      Bottom := rcPage.Bottom - Bottom;
      end;
      until (chrg.cpMin >= chrg.cpMax) or (Height <= Round(BottomOffset / (1440.0 / 96)) + 2 * GapY  + 1 );
    *)
    Range.chrg.cpMax := -1;
    Range.chrg.cpMin := 0;
    FRichEdit.SendSynchMessage(EM_FORMATRANGE, 1, frInteger(@Range), True);

    if not UsePrinterCanvas then
      ReleaseDC(0, PrinterHandle);

    FRichEdit.SendSynchMessage(EM_FORMATRANGE, 0, 0, True);
  finally
    EMFCanvas.Unlock;
    EMFCanvas.Free;
{$IFNDEF NO_CRITICAL_SECTION}
    frxCSRich.Leave;
{$ENDIF}
  end;
end;

procedure TfrxRichView.Draw(Canvas: TCanvas; ScaleX, ScaleY, OffsetX,
  OffsetY: Extended);
var
  EMF: TMetafile;
begin
  if Height < 0 then Height := Height * (-1);
  BeginDraw(Canvas, ScaleX, ScaleY, OffsetX, OffsetY);
  DrawBackground;
  EMF := CreateMetafile;
  try
    Canvas.StretchDraw(Rect(FX, FY, FX1, FY1), EMF);
  finally
    EMF.Free;
  end;

  if not FObjAsMetafile then
    begin
      DrawFrameEdges;
      DrawFrame;
    end;
end;

procedure TfrxRichView.BeforePrint;
begin
  inherited;
  FTempStream.Position := 0;
{$IFNDEF NO_CRITICAL_SECTION}
  frxCSRich.Enter;
  try
{$ENDIF}
    FRichEdit.Lines.SaveToStream(FTempStream);
{$IFNDEF NO_CRITICAL_SECTION}
  finally
    frxCSRich.Leave;
  end;
{$ENDIF}
end;

procedure TfrxRichView.AfterPrint;
begin
  FTempStream.Position := 0;
{$IFNDEF NO_CRITICAL_SECTION}
  frxCSRich.Enter;
  try
{$ENDIF}
    FRichEdit.Lines.LoadFromStream(FTempStream);
{$IFNDEF NO_CRITICAL_SECTION}
  finally
    frxCSRich.Leave;
  end;
{$ENDIF}
  inherited;
end;

procedure TfrxRichView.GetData;
const
  RTFHeader = '{\rtf';
  URTFHeader = '{urtf';
type
  tag_settextex = record
    flags: DWORD;
    codepage: UINT;
  end;
var
  ss: TStringStream;
  i, j, TextLen, sStart, sLen: Integer;
  s1, s2, dc1, dc2: String;
  SetText: tag_settextex;
  cf: TCharFormat2A;
{$IFDEF DELPHI12}
  AnsiStr: AnsiString;
{$ENDIF}

  function GetSpecial(const s: String; Pos: Integer): Integer;
  var
    i: Integer;
  begin
    Result := 0;
    for i := 1 to Pos do
{$IFDEF DELPHI12}
      if CharInSet(s[i], [#10, #13]) then
{$ELSE}
      if s[i] in [#10, #13] then
{$ENDIF}
        Inc(Result);
  end;

  { this function search expression broken by new line}
  { [                                                 }
  {  IIF(1>2,'oh',                                    }
  {  'OK')                                            }
  {  ]                                                }
  { EM_FINDTEXTEX coldn't search text with new line   }
  function SearchForText(const s: String; StartPos: Integer): Boolean;
  var
    i, sPos, sLen, SelStart, SelEnd: Integer;
    sText: String;
    Sel: TCharRange;
  begin
    sLen := Length(s);
    SelStart := -1;
    sPos := 1;
    for i := 1 to sLen do
{$IFDEF DELPHI12}
      if CharInSet(s[i], [#10, #13]) then
{$ELSE}
      if s[i] in [#10, #13] then
{$ENDIF}
      begin
        if (sPos = i) and (i <> 2) then
        begin
          sPos := i + 1;
          continue;
        end;
        sText := Copy(s, sPos, i - sPos);
        Result := (FRichEdit.FindText(sText, StartPos - 1 - GetSpecial(FRichEdit.Text, StartPos) div 2, -1, [stSetSelection]) > 0);
        if not Result then Exit;

        Sel := FRichEdit.GetSelection;
        if sPos = 1 then
          SelStart := Sel.cpMin;
        Inc(StartPos, Sel.cpMax - Sel.cpMin);
        sPos := i + 1;
      end;
    if SelStart = -1 then
      Result := (FRichEdit.FindText(s, StartPos - 1 - GetSpecial(FRichEdit.Text, StartPos) div 2, -1, [stSetSelection]) >= 0)
    else
    begin
      Result := (FRichEdit.FindText(Copy(s, sPos, Length(s) - (sPos - 1)), StartPos - 1 - GetSpecial(FRichEdit.Text, StartPos) div 2, -1, [stSetSelection]) > 0);
      Sel := FRichEdit.GetSelection;
      SelEnd := Sel.cpMax;
      FRichEdit.SetSelection(SelStart, SelEnd, False);
    end;
  end;

begin
  inherited;
  if FFileLink <> '' then
  begin
    s1 := FFileLink;
    if Pos('[', s1) <> 0 then
      ExpandVariables(s1);
    if FileExists(s1) then
      FRichEdit.Lines.LoadFromFile(s1);
  end
  else if IsDataField then
  begin
    if DataSet.IsBlobField(DataField) then
    begin
      ss := TStringStream.Create('');
      DataSet.AssignBlobTo(DataField, ss)
    end
    else
      ss := TStringStream.Create(VarToStr(DataSet.Value[DataField]));
    try
{$IFNDEF NO_CRITICAL_SECTION}
      frxCSRich.Enter;
      try
{$ENDIF}
        FRichEdit.Lines.LoadFromStream(ss);
{$IFNDEF NO_CRITICAL_SECTION}
      finally
        frxCSRich.Leave;
      end;
{$ENDIF}
    finally
      ss.Free;
    end;
  end;

  if FAllowExpressions then
  begin
    dc1 := FExpressionDelimiters;
    dc2 := Copy(dc1, Pos(',', dc1) + 1, 255);
    dc1 := Copy(dc1, 1, Pos(',', dc1) - 1);
    TextLen := 0;
    with FRichEdit do
    try
      Lines.BeginUpdate;
      i := Pos(dc1, Text);
      while i > 0 do
      begin
{$IFDEF DELPHI12}
        s1 := frxGetBrackedVariableW(Text, dc1, dc2, i, j);
{$ELSE}
        s1 := frxGetBrackedVariable(Text, dc1, dc2, i, j);
{$ENDIF}
        // win8.1 old detection of expression doesn't work anymore
        // search it by using control, maybe litle slower , but works
        // temprary solution - TODO search expressions in RAW rtf
        if IsWin8 then
        begin
          if not SearchForText(dc1 + s1 + dc2, i) then
            raise Exception.Create('Could not search for expression in RichText.');
        end
        else
          SelStart := i - 1 - GetSpecial(Text, i) div 2;

        s2 := VarToStr(Report.Calc(s1));
        if IsWin8 then
          i := i + Length(s2)
        else
        begin
          SelLength := j - i + 1;
          TextLen := Length(Text) - SelLength;
        end;


        if (Copy(s2, 1, 5) = RTFHeader) or (Copy(s2, 1, 6) = URTFHeader) then
        begin
{$IFDEF DELPHI12}
          AnsiStr := AnsiString(s2);
{$ENDIF}
          if RichEditVersion = 4 then
          begin
            SetText.flags := 2;//ST_SELECTION
{$IFDEF DELPHI12}
            SetText.codepage := 1200;
{$ELSE}
            SetText.codepage := CP_ACP;
{$ENDIF}
             sStart := SelStart;
             sLen :=  FRichEdit.SendSynchMessage(WM_USER + 97 {EM_SETTEXTEX}, frInteger(@SetText),
                frInteger({$IFDEF DELPHI12}PAnsiChar(AnsiStr){$ELSE}PChar(s2){$ENDIF}));

             if IsWin8 then
               begin
                 if not IsWin10 then
                   begin
                     cf.cbSize := sizeof(TCharFormat2A);
                     cf.dwMask := CFM_CHARSET;
                     FRichEdit.SendSynchMessage(EM_GETCHARFORMAT,  SCF_SELECTION, frInteger(@cf));
                     cf.dwMask := CFM_CHARSET;
                     SelStart := sStart;
                     SelLength := sLen;
                     FRichEdit.SendSynchMessage(EM_SETCHARFORMAT,  SCF_SELECTION, frInteger(@cf));
                   end;
                 i := i - (Length(s2) - sLen) ;
               end;

              { empty line workraround }
              SelStart := SelStart + SelLength  - 1;
              SelLength := 1;
              if (SelText = #13) then
                SelText := '';
          end
          else
            FRichEdit.SendSynchMessage(EM_REPLACESEL, frInteger(True),
                frInteger({$IFDEF DELPHI12}PAnsiChar(AnsiStr){$ELSE}PChar(s2){$ENDIF}));// rich text workground

        end else
        begin
{$IFDEF DELPHI12}
          //AnsiStr := AnsiString(s2);
{$ENDIF}
          if RichEditVersion = 4 then
          begin
            SetText.flags := 2;//ST_SELECTION
{$IFDEF DELPHI12}
            SetText.codepage := 1200;
            //SetText.codepage := CP_ACP;
{$ELSE}
            SetText.codepage := CP_ACP;
{$ENDIF}
            FRichEdit.SendSynchMessage(WM_USER + 97 {EM_SETTEXTEX}, frInteger(@SetText),
                frInteger({$IFDEF DELPHI12}s2{$ELSE}PChar(s2){$ENDIF}));
              { empty line workraround }
              if SelLength > 0 then
              begin
                SelStart := SelStart + SelLength  - 1;
                SelLength := 1;
                if (SelText = #13) then
                  SelText := '';
              end;
          end
          else
            SelText := s2;
        end;
        if IsWin8 then
          i := PosEx(dc1, Text, i)
        else
          i := PosEx(dc1, Text, i + Length(Text) - TextLen);
      end;
    finally
      Lines.EndUpdate;
    end;
  end;

  if FFlowTo <> nil then
  begin
    InitPart;
    DrawPart;
    FTempStream1.Position := 0;
{$IFNDEF NO_CRITICAL_SECTION}
    frxCSRich.Enter;
    try
{$ENDIF}
    FlowTo.RichEdit.Lines.LoadFromStream(FTempStream1);
{$IFNDEF NO_CRITICAL_SECTION}
  finally
    frxCSRich.Leave;
  end;
{$ENDIF}
    FFlowTo.AllowExpressions := False;
  end;
end;

function TfrxRichView.CalcHeight: Extended;
var
  Range: TFormatRange;
  chrgRange: TCharRange;
  rcBottom: Integer;
begin
  FillChar(Range, SizeOf(TFormatRange), 0);
  Result := 0;
{$IFNDEF NO_CRITICAL_SECTION}
  frxCSRich.Enter;
  try
{$ENDIF}
    with Range do
    begin
      rc := Rect(0, 0, Round((Width - GapX * 2) * 1440 / 96),
        Round(1000000 * 1440.0 / 96));
      rcPage := rc;

      if UsePrinterCanvas then
        hdc := frxPrinters.Printer.Canvas.Handle
      else
        hdc := GetDC(0);
      hdcTarget := hdc;
      chrgRange.cpMax := RichEdit.GetTextLen;

      chrg.cpMax := -1;
      chrg.cpMin := 0;
      rcBottom := 0;
      { process all pages in RichEdit, maybe it contain /PAGE tag }
      // FRichEdit.Perform(EM_SETSEL, -1, -1);
      repeat
        rc := rcPage;
        chrg.cpMin := FRichEdit.SendSynchMessage(EM_FORMATRANGE, 0, frInteger(@Range), True);
        rcBottom := rcBottom + rc.Bottom;
      until (chrg.cpMin >= chrgRange.cpMax);

      if chrgRange.cpMax = 0 then
        Result := 0
      else
        Result := Result + Round(rcBottom / (1440.0 / 96)) + 2 * GapY + 2;

      if not UsePrinterCanvas then
        ReleaseDC(0, hdc);
    end;
    FRichEdit.SendSynchMessage(EM_FORMATRANGE, 0, 0, True);
{$IFNDEF NO_CRITICAL_SECTION}
  finally
    frxCSRich.Leave;
  end;
{$ENDIF}
end;

function TfrxRichView.DrawPart: Extended;
var
  Range: TFormatRange;
  LastChar: Integer;
begin
  { text can't fit }
  if (Round((Height - GapY * 2)) <= 0)then
  begin
    Result := Height;
    FHasNextDataPart := True;
    Exit;
  end;
{$IFNDEF NO_CRITICAL_SECTION}
  frxCSRich.Enter;
  try
{$ENDIF}
    { get remained part of text }
      FTempStream1.Position := 0;
      FRichEdit.Lines.LoadFromStream(FTempStream1);
      if FParaBreak then
        with FRichEdit.Paragraph do
        begin
          FirstIndent := FirstIndent + LeftIndent;
          FRichEdit.Paragraph.LeftIndent := 0;
        end;
      { calculate the last visible char }
      FillChar(Range, SizeOf(TFormatRange), 0);

      with Range do
      begin
        rc := Rect(0, 0, Round((Width - GapX * 2) * 1440 / 96),
          Round((Height - GapY * 2) * 1440 / 96));
        rcPage := rc;
        if UsePrinterCanvas then
          hdc := frxPrinters.Printer.Canvas.Handle
        else
          hdc := GetDC(0);
        hdcTarget := hdc;

        FRichEdit.SendSynchMessage(EM_SETSEL, WPARAM(-1), LPARAM(-1), True);
        // need for RE 4.1 and tables
        chrg.cpMin := 0;
        chrg.cpMax := -1;

        { RTF4.1 trying to place data, if data doesn't fit decrease line index and try again }
        { need for tables and object in richedit }
        repeat
          LastChar := FRichEdit.SendSynchMessage(EM_FORMATRANGE, 0, frInteger(@Range), True);
          if (LastChar = -1) then
            break; // can't be split
          if chrg.cpMax <> -1 then
            LastChar := chrg.cpMax;
          chrg.cpMax := FRichEdit.LineFromChar(LastChar - 1) - 1;
          if chrg.cpMax <= 0 then
            break;
          chrg.cpMax := FRichEdit.GetLineIndex(chrg.cpMax);

        until ((rcPage.Bottom - rc.Bottom >= 0) or (chrg.cpMax = LastChar));

        Result := Round((rcPage.Bottom - rc.Bottom) / (1440.0 / 96));
        if Result > 0 then
          Result := Result + GapY * 2 + 2;

        if not UsePrinterCanvas then
          ReleaseDC(0, hdc);

        FRichEdit.SendSynchMessage(EM_FORMATRANGE, 0, 0, True);
      end;

      { text can't fit }
      try
        if (Result < 0) then
        begin
          Result := Height;
          if FLastChar = LastChar then
          begin
            FHasNextDataPart := False;
            FStopSplit := True;
          end;
          exit;
        end;
      finally
        FLastChar := LastChar;
      end;

      { copy the outbounds text to the temp stream }
      try
        if LastChar > 1 then
        begin
          FRichEdit.SelStart := LastChar - 1;
          FRichEdit.SelLength := 1;
          FParaBreak := FRichEdit.SelText <> #13;
        end;

        FRichEdit.SelStart := LastChar;
        FRichEdit.SelLength := RichEdit.GetTextLen - LastChar + 1;

        if FRichEdit.SelLength <= 1 then
        begin
          Result := 0;
          FHasNextDataPart := False;
        end
        else
          FHasNextDataPart := True;

        FTempStream1.Clear;
        FRichEdit.StreamMode := [smSelection];
        if FHasNextDataPart then
          FRichEdit.Lines.SaveToStream(FTempStream1);
        FRichEdit.SelText := '';
      finally
        FRichEdit.StreamMode := [];
        { bug fix when the last line hides }
        FRichEdit.Paragraph.SpaceAfter := 0;
        FRichEdit.Paragraph.SpaceBefore := 0;
        FRichEdit.SendSynchMessage(EM_SETSEL, WPARAM(-1), LPARAM(-1));
      end;
{$IFNDEF NO_CRITICAL_SECTION}
    finally
      frxCSRich.Leave;
    end;
{$ENDIF}
 end;

procedure TfrxRichView.InitPart;
begin
  FTempStream1.Clear;
{$IFNDEF NO_CRITICAL_SECTION}
  frxCSRich.Enter;
  try
{$ENDIF}
    FRichEdit.Lines.SaveToStream(FTempStream1);
{$IFNDEF NO_CRITICAL_SECTION}
  finally
    frxCSRich.Leave;
  end;
{$ENDIF}
  FParaBreak := False;
  FHasNextDataPart := True;
  FStopSplit := False;
  FLastChar := 0;
end;

function TfrxRichView.GetComponentText: String;
var
  FTStream: TMemoryStream;
{$IFDEF DELPHI12}
  TempStr: AnsiString;
{$ENDIF}
begin
  if PlainText then
  begin
    FTStream := TMemoryStream.Create;
    try
      FTempStream.Clear;
      FRichEdit.Lines.SaveToStream(FTStream);
      FRichEdit.PlainText := True;
      FRichEdit.Lines.SaveToStream(FTempStream);
{$IFDEF DELPHI12}
      SetLength(TempStr, FTempStream.Size);
      FTempStream.Position := 0;
      FTempStream.Read(TempStr[1], FTempStream.Size);
      Result := String(TempStr);
{$ELSE}
      SetLength(Result, FTempStream.Size);
      FTempStream.Position := 0;
      FTempStream.Read(Result[1], FTempStream.Size);
{$ENDIF}
      FRichEdit.PlainText := False;
      FTStream.Position := 0;
      FRichEdit.Lines.LoadFromStream(FTStream);
    finally
      FTStream.Free;
    end;
  end
  else
  begin
    FTempStream.Clear;
    FRichEdit.Lines.SaveToStream(FTempStream);
{$IFDEF DELPHI12}
    SetLength(TempStr, FTempStream.Size);
    FTempStream.Position := 0;
    FTempStream.Read(TempStr[1], FTempStream.Size);
    Result := String(TempStr);
{$ELSE}
    SetLength(Result, FTempStream.Size);
    FTempStream.Position := 0;
    FTempStream.Read(Result[1], FTempStream.Size);
{$ENDIF}
  end;
end;

function TfrxRichView.HasNextDataPart(aFreeSpace: Extended): Boolean;
begin
  Result := FHasNextDataPart and (StretchMode <> smDontStretch) or
    (Inherited HasNextDataPart(aFreeSpace) and not FStopSplit {and (StretchMode = smDontStretch)});
end;

function TfrxRichView.IsEMFExportable: Boolean;
begin
  Result := AllowVectorExport;
end;

{$IFDEF FR_COM}
function TfrxRichView.LoadViewFromStream(const Stream: IUnknown): HResult; stdcall;
var
  ComStream: IStream;
  OleStream: TOleStream;

  NetStream:  _Stream;
  ClrStream: TClrStream;
begin
  try
    Result := Stream.QueryInterface(IStream, ComStream);
    if Result = S_OK then
    begin
      OleStream := TOleStream.Create(ComStream);
      ReadData(OleStream);
      OleStream.Free;
      ComStream := nil;
    end
    else
    begin
      Result := Stream.QueryInterface(_Stream, NetStream);
      if Result = S_OK then
      begin
        ClrStream := TClrStream.Create(NetStream);
        ReadData(ClrStream);
        ClrStream.Free;
        NetStream._Release();
      end;
    end;
  except
    Result := E_FAIL;
  end;
end;

function TfrxRichView.SaveViewToStream(const Stream: IUnknown): HResult; stdcall;
var
  ComStream:  IStream;
  OleStream: TOleStream;

  NetStream:  _Stream;
  ClrStream: TClrStream;
begin
  try
    Result := Stream.QueryInterface(IStream, ComStream);
    if Result = S_OK then
    begin
      OleStream := TOleStream.Create(ComStream);
      WriteData(OleStream);
      OleStream.Free;
      ComStream := nil;
    end
    else
    begin
      Result := Stream.QueryInterface(_Stream, NetStream);
      if Result = S_OK then
      begin
        ClrStream := TClrStream.Create(NetStream);
        WriteData(ClrStream);
        ClrStream.Free;
        NetStream._Release();
      end;
    end;
  except
    Result := E_FAIL;
  end;
end;

function TfrxRichView.Get_RichAlign(out Value: frxHAlign): HResult; stdcall;
begin
   Result := S_OK;
   Value := frxHAlign(FRichEdit.Paragraph.Alignment);
end;

function TfrxRichView.Set_RichAlign(Value: frxHAlign): HResult; stdcall;
begin
  Result := S_OK;
  FRichEdit.SelectAll;
  case Value of
  hAlignLeft:     FRichEdit.Paragraph.Alignment := paLeftJustify;
  hAlignRight:    FRichEdit.Paragraph.Alignment := paRightJustify;
  hAlignCenter:   FRichEdit.Paragraph.Alignment := paCenter;
  hAlignBlock:    FRichEdit.Paragraph.Alignment := paJustify;
  else Result := E_FAIL;
  end;
end;

function TfrxRichView.Get_WYSIWIG(out Value: WordBool): HResult; stdcall;
begin
  Value := FWysiwyg;
  Result := S_OK;
end;

function TfrxRichView.Set_WYSIWIG(Value: WordBool): HResult; stdcall;
begin
  FWysiwyg := Value;
  Result := S_OK;
end;

function TfrxRichView.Get_AllowExpressions(out Value: WordBool): HResult; stdcall;
begin
  Value := FAllowExpressions;
  Result := S_OK;
end;

function TfrxRichView.Set_AllowExpressions(Value: WordBool): HResult; stdcall;
begin
  FAllowExpressions := Value;
  Result := S_OK;
end;
{$ENDIF}

initialization
{$IFDEF DELPHI16}
  StartClassGroup(TControl);
  ActivateClassGroup(TControl);
  GroupDescendentsWith(TfrxRichObject, TControl);
{$ENDIF}
  frxObjects.RegisterObject1(TfrxRichView, nil, '', '', 0, 26);
{$IFNDEF NO_CRITICAL_SECTION}
  frxCSRich := TCriticalSection.Create;
{$ENDIF}

finalization
  frxObjects.UnRegister(TfrxRichView);
{$IFNDEF NO_CRITICAL_SECTION}
  frxCSRich.Free;
{$ENDIF}


end.
