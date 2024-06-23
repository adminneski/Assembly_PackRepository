{*******************************************************}
{                                                       }
{                      EhLib 10.2                       }
{                TPrintDBGridEh component               }
{                                                       }
{   Copyright (c) 1998-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

unit PrnDbgEh;

interface

{$I EhLib.Inc}

uses
  Messages, SysUtils, Classes, Controls, PrntsEh,
{$IFDEF FPC}
  {$IFDEF FPC_WINDOWS}
  Windows, Win32WSForms, Win32Int, Win32WSControls,
  {$ELSE}
  {$ENDIF}
  DBGridsEh, LCLType, LCLIntf, EhLibLCL,
{$ELSE}
    Windows, DBGridEh, EhLibVCL,
{$ENDIF}
{$IFDEF CIL}
  EhLibVCLNET,
  System.Text,
  System.Runtime.InteropServices,
{$ELSE}

{$ENDIF}
{$IFDEF EH_LIB_17} System.Contnrs, {$ENDIF}
  Graphics, ImgList, Forms, DB, GridsEh, DBGridEhGrouping,
  ToolCtrlsEh, PrintUtilsEh, PdfPrintersEh, StdCtrls, ComCtrls;

type
  TPrintDBGridEh = class;
  TPrintColCellParamsEh = class;

  TMeasureUnits = (MM, Inches);
  TPrintDBGridEhOption = (pghFitGridToPageWidth, pghColored, pghRowAutoStretch,
    pghFitingByColWidths, pghOptimalColWidths);
  TPrintDBGridEhOptions = set of TPrintDBGridEhOption;

  TPrintDBGridEhPrintDataCellEvent = procedure(Sender: TPrintDBGridEh;
    VPrinter: TBaseVirtualPrinter; Column: TColumnEh; const ARect: TRect;
    var Params: TPrintColCellParamsEh; var Processed: Boolean) of object;

  TPrintColCellParamsEh = class(TColCellParamsEh)
  public
    ScaleX: Double;
    ScaleY: Double;
    CalcInfoMode: Boolean;
    Stretch: Boolean;
    GridWidth: Integer;
    RealRight: Integer;
    RealLeft: Integer;
    TreeBlockScreenWidth: Integer;
  end;

  TPageParams = class(TPersistent)
  private
    FBottomMargin: Currency;
    FRightMargin: Currency;
    FLeftMargin: Currency;
    FTopMargin: Currency;

    function IsBottomMarginStored: Boolean;
    function IsLeftMarginStored: Boolean;
    function IsRightMarginStored: Boolean;
    function IsTopMarginStored: Boolean;

    procedure SetBottomMargin(const Value: Currency);
    procedure SetLeftMargin(const Value: Currency);
    procedure SetRightMargin(const Value: Currency);
    procedure SetTopMargin(const Value: Currency);

  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;

  published
    property BottomMargin: Currency read FBottomMargin write SetBottomMargin stored IsBottomMarginStored;
    property LeftMargin: Currency read FLeftMargin write SetLeftMargin stored IsLeftMarginStored;
    property RightMargin: Currency read FRightMargin write SetRightMargin stored IsRightMarginStored;
    property TopMargin: Currency read FTopMargin write SetTopMargin stored IsTopMarginStored;
  end;

  TPageColontitleLineType = (pcltNon, pcltSingleLine, pcltDoubleLine);

  TPageColontitle = class(TPersistent)
  private
    FCenterText: TStrings;
    FFont: TFont;
    FLeftText: TStrings;
    FLineType: TPageColontitleLineType;
    FRightText: TStrings;

    procedure SetCenterText(const Value: TStrings);
    procedure SetFont(const Value: TFont);
    procedure SetLeftText(const Value: TStrings);
    procedure SetLineType(const Value: TPageColontitleLineType);
    procedure SetRightText(const Value: TStrings);

  public
    constructor Create;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;

  published
    property CenterText: TStrings read FCenterText write SetCenterText;
    property Font: TFont read FFont write SetFont;
    property LeftText: TStrings read FLeftText write SetLeftText;
    property LineType: TPageColontitleLineType read FLineType write SetLineType default pcltNon;
    property RightText: TStrings read FRightText write SetRightText;
  end;

  TPrintDBGridEh = class(TComponent)
  private
    FAfterGridText: TStringsEh;
    FBeforeGridText: TStringsEh;
    FColCellParamsEh: TPrintColCellParamsEh;
    FGroupRowParams: TGroupRowParamsEh;
    FDBGridEh: TDBGridEh;
    FLastRowTexts: TStrings;
    FOptions: TPrintDBGridEhOptions;
    FPage: TPageParams;
    FPageFooter: TPageColontitle;
    FPageHeader: TPageColontitle;
    FPrintFontName: String;
    FSubstitutesNames: TStrings;
    FSubstitutesValues: TStrings;
    FTitle: TStrings;
    FUnits: TMeasureUnits;
    FVarColCellParamsEh: TColCellParamsEh;

    FOnAfterPrint: TNotifyEvent;
    FOnBeforePrint: TNotifyEvent;
    FOnPrinterSetupDialog: TNotifyEvent;
    FOnPrintDataCell: TPrintDBGridEhPrintDataCellEvent;

    function GetAfterGridText: TStringsEh;
    function GetBeforeGridText: TStringsEh;

    procedure ReadAfterGridText(Stream: TStream);
    procedure ReadBeforeGridText(Stream: TStream);
    procedure SetAfterGridText(const Value: TStringsEh);
    procedure SetBeforeGridText(const Value: TStringsEh);
    procedure SetDBGridEh(const Value: TDBGridEh);
    procedure SetOptions(const Value: TPrintDBGridEhOptions);
    procedure SetPage(const Value: TPageParams);
    procedure SetPageFooter(const Value: TPageColontitle);
    procedure SetPageHeader(const Value: TPageColontitle);
    procedure SetPrintFontName(const Value: String);
    procedure SetTitle(const Value: TStrings);
    procedure SetUnits(const Value: TMeasureUnits);
    procedure WriteAfterGridText(Stream: TStream);
    procedure WriteBeforeGridText(Stream: TStream);

  protected
    function DrawGraphicCell(Canvas: TBasePrinterCanvas; Column: TColumnEh; ARect: TRect; Background: TColor; CalcRect: Boolean; var Params: TPrintColCellParamsEh): Integer;

    procedure DefineProperties(Filer: TFiler); override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure PrinterSetupDialogPreview(Sender: TObject);
    procedure ChangeBoxOrientation(Canvas: TBasePrinterCanvas; Box: TRect; RightToLeftOrientation: Boolean);
    procedure DrawTreeArea(Canvas: TBasePrinterCanvas; ARect: TRect; var Params: TPrintColCellParamsEh);
    procedure DrawClipped(ImageList: TCustomImageList; ImageIndex: Integer; ACanvas: TBasePrinterCanvas; ARect: TRect; AClipRect: TRect; Align: TAlignment; VertAlign: TVerticalAlignment; ScaleX: Double; ScaleY: Double);

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function PrinterSetupDialog: Boolean;

    procedure Preview;
    procedure Print;
    procedure PrintTo(VPrinter: TBaseVirtualPrinter);
    procedure SetSubstitutes(ASubstitutes: array of const);

    procedure PrintToPdfFile(AFileName: String);

    function DefaultPrintDataCell(VPrinter: TBaseVirtualPrinter; Column: TColumnEh; ARect: TRect; CalcRect: Boolean; var Params: TPrintColCellParamsEh): Integer; virtual;

  published
    property AfterGridText: TStringsEh read GetAfterGridText write SetAfterGridText stored False;
    property BeforeGridText: TStringsEh read GetBeforeGridText write SetBeforeGridText stored False;
    property DBGridEh: TDBGridEh read FDBGridEh write SetDBGridEh;
    property Options: TPrintDBGridEhOptions read FOptions write SetOptions;
    property Page: TPageParams read FPage write SetPage;
    property PageFooter: TPageColontitle read FPageFooter write SetPageFooter;
    property PageHeader: TPageColontitle read FPageHeader write SetPageHeader;
    property PrintFontName: String read FPrintFontName write SetPrintFontName;
    property Title: TStrings read FTitle write SetTitle;
    property Units: TMeasureUnits read FUnits write SetUnits;

    property OnAfterPrint: TNotifyEvent read FOnAfterPrint write FOnAfterPrint;
    property OnBeforePrint: TNotifyEvent read FOnBeforePrint write FOnBeforePrint;
    property OnPrinterSetupDialog: TNotifyEvent read FOnPrinterSetupDialog write FOnPrinterSetupDialog;
    property OnPrintDataCell: TPrintDBGridEhPrintDataCellEvent read FOnPrintDataCell write FOnPrintDataCell;
  end;


implementation

uses PrnDGDlg,
{$IFDEF FPC}
  
{$ELSE}
  PrViewEh, RichEdit, ComStrs,
{$ENDIF}
  EhLibLangConsts, DBAxisGridsEh
  {$IFDEF EH_LIB_16} ,System.UITypes {$ENDIF}
   ,Variants ,Types, Themes;

type
  TDBGridEhCracker = class(TDBGridEh) end;
  TPrnRowTypeEh = (prtNowhere, prtRecordDataEh, prtGridFooterEh, prtGroupHeaderRowEh, prtGroupFooterEh);

var
  FCheckBoxWidth, FCheckBoxHeight: Integer;

procedure GetCheckSize;
begin
  FCheckBoxWidth := DefaultCheckBoxWidth;
  FCheckBoxHeight := DefaultCheckBoxHeight;
end;

function iif(Condition: Boolean; V1, V2: Integer): Integer;
begin
  if (Condition) then Result := V1 else Result := V2;
end;

function GetTextWidth(Canvas: TBasePrinterCanvas; const Text: String): Integer;
var
  ATextSize: TSize;
begin
  ATextSize := Canvas.TextExtent(Text);
  Result := ATextSize.cx;
end;

{$IFNDEF VER120} {Borland Delphi 3.0 }
type TReplaceFlags = set of (rfReplaceAll, rfIgnoreCase);
{$ENDIF}

function StringReplaceMacros(const S, OldPattern, NewPattern: string;
  Flags: TReplaceFlags; MacroChar: Char): string;
var
  SearchStr, Patt, NewStr: string;
  Offset: Integer;
begin
  if rfIgnoreCase in Flags then
  begin
    SearchStr := NlsUpperCase(S);
    Patt := NlsUpperCase(OldPattern);
  end else
  begin
    SearchStr := S;
    Patt := OldPattern;
  end;
  NewStr := S;
  Result := '';
  while SearchStr <> '' do
  begin
    Offset := AnsiPos(Patt, SearchStr);
    if Offset = 0 then
    begin
      Result := Result + NewStr;
      Break;
    end;
    if (Offset = 1) or (SearchStr[Offset - 1] <> MacroChar)
      then Result := Result + Copy(NewStr, 1, Offset - 1) + NewPattern
      else Result := Result + Copy(NewStr, 1, Offset - 1) + OldPattern;
    NewStr := Copy(NewStr, Offset + Length(OldPattern), MaxInt);
    if not (rfReplaceAll in Flags) then
    begin
      Result := Result + NewStr;
      Break;
    end;
    SearchStr := Copy(SearchStr, Offset + Length(Patt), MaxInt);
  end;
end;

function GetStingListText(sl: TStrings): String;
begin
  Result := Copy(sl.Text, 1, Length(sl.Text) - 2);
end;

{ TRichEditStrings, from VCL ComCtrls.pas }

{$IFDEF FPC}
type
  TRichEditStrings = class(TStringsEh)
  protected
    function Get(Index: Integer): string; override;
    function GetCount: Integer; override;
    procedure Put(Index: Integer; const S: string); override;
    procedure SetUpdateState(Updating: Boolean); override;
    procedure SetTextStr(const Value: string); override;
  public
    procedure Clear; override;
    procedure Delete(Index: Integer); override;
    procedure Insert(Index: Integer; const S: string); override;
  end;

  function TRichEditStrings.Get(Index: Integer): string;
  begin
    Result := '';
  end;

  function TRichEditStrings.GetCount: Integer;
  begin
    Result := 0;
  end;

  procedure TRichEditStrings.Put(Index: Integer; const S: string);
  begin
  end;

  procedure TRichEditStrings.SetUpdateState(Updating: Boolean);
  begin
  end;

  procedure TRichEditStrings.SetTextStr(const Value: string);
  begin
  end;

  procedure TRichEditStrings.Clear;
  begin
  end;

  procedure TRichEditStrings.Delete(Index: Integer);
  begin
  end;

  procedure TRichEditStrings.Insert(Index: Integer; const S: string);
  begin
  end;

{$ELSE} //FPC
const
  ReadError = $0001;
  WriteError = $0002;
  NoError = $0000;

type
  TSelection = record
    StartPos, EndPos: Integer;
  end;

  TRichEditStrings = class(TStringsEh)
  private
    FRichEdit: TRichEdit;
    FPlainText: Boolean;
    FConverter: TConversion;

    function GetRtfText: String;
    procedure EnableChange(const Value: Boolean);
  protected
    function Get(Index: Integer): string; override;
    function GetCount: Integer; override;
    procedure Put(Index: Integer; const S: string); override;
    procedure SetUpdateState(Updating: Boolean); override;
    procedure SetTextStr(const Value: string); override;

  public
    constructor Create;
    destructor Destroy; override;

    function Replace(const SearchStr, ReplaceStr: string; StartPos, Length: Integer; Options: TSearchTypes; ReplaceAll: Boolean): Integer; override;

    procedure Clear; override;
    procedure AddStrings(Strings: TStrings); override;
    procedure Delete(Index: Integer); override;
    procedure Insert(Index: Integer; const S: string); override;

{$IFDEF CIL}
    procedure LoadFromFile(const FileName: string; Encoding: System.Text.Encoding); override;
    procedure LoadFromStream(Stream: TStream; Encoding: System.Text.Encoding); override;
    procedure SaveToFile(const FileName: string; Encoding: System.Text.Encoding); override;
    procedure SaveToStream(Stream: TStream; Encoding: System.Text.Encoding); override;
{$ELSE}
  {$IFDEF EH_LIB_12}
    procedure LoadFromFile(const FileName: string; Encoding: TEncoding); override;
    procedure LoadFromStream(Stream: TStream; Encoding: TEncoding); override;
    procedure SaveToFile(const FileName: string; Encoding: TEncoding); override;
    procedure SaveToStream(Stream: TStream; Encoding: TEncoding); override;
  {$ELSE}
    procedure LoadFromFile(const FileName: string); override;
    procedure LoadFromStream(Stream: TStream); override;
    procedure SaveToFile(const FileName: string); override;
    procedure SaveToStream(Stream: TStream); override;
  {$ENDIF}
{$ENDIF}
    property PlainText: Boolean read FPlainText write FPlainText;
    property RtfText: String read GetRtfText;
  end;

constructor TRichEditStrings.Create;
begin
  inherited Create;
  FRichEdit := TRichEdit.Create(nil);
  FRichEdit.Visible := False;
  FRichEdit.ParentWindow := GetDesktopWindow;
end;

destructor TRichEditStrings.Destroy;
begin
  FreeAndNil(FConverter);
  FreeAndNil(FRichEdit);
  inherited Destroy;
end;

procedure TRichEditStrings.AddStrings(Strings: TStrings);
var
  SelChange: TNotifyEvent;
begin
  SelChange := FRichEdit.OnSelectionChange;
  FRichEdit.OnSelectionChange := nil;
  try
    inherited AddStrings(Strings);
  finally
    FRichEdit.OnSelectionChange := SelChange;
  end;
end;

function TRichEditStrings.GetCount: Integer;
begin
  Result := SendMessage(FRichEdit.Handle, EM_GETLINECOUNT, 0, 0);
  if SendMessage(FRichEdit.Handle, EM_LINELENGTH, SendMessage(FRichEdit.Handle,
    EM_LINEINDEX, Result - 1, 0), 0) = 0 then Dec(Result);
end;

function TRichEditStrings.Get(Index: Integer): string;
var
  L: Integer;
begin
  Result := '';
  L := SendGetTextMessage(FRichEdit.Handle, EM_GETLINE, Index, Result, 4096 * 2);
  if (L >= 1) and (Result[L] = #13) then
    SetLength(Result, L - 1);
end;

procedure TRichEditStrings.Put(Index: Integer; const S: string);
var
  Selection: TCharRange;
begin
  if Index >= 0 then
  begin
    Selection.cpMin := SendMessage(FRichEdit.Handle, EM_LINEINDEX, Index, 0);
    if Selection.cpMin <> -1 then
    begin
      Selection.cpMax := Selection.cpMin +
        SendMessage(FRichEdit.Handle, EM_LINELENGTH, Selection.cpMin, 0);
      SendStructMessage(FRichEdit.Handle, EM_EXSETSEL, 0, Selection);
      SendTextMessage(FRichEdit.Handle, EM_REPLACESEL, 0, S);
    end;
  end;
end;

procedure TRichEditStrings.Insert(Index: Integer; const S: string);
var
  L: Integer;
  Selection: TCharRange;
{$IFDEF CIL}
  Fmt: string;
{$ELSE}
  Fmt: PChar;
{$ENDIF}
  Str: string;
begin
  if Index >= 0 then
  begin
    Selection.cpMin := SendMessage(FRichEdit.Handle, EM_LINEINDEX, Index, 0);
    if Selection.cpMin >= 0 then
{$IFDEF CIL}
      Fmt := '%s'#13
{$ELSE}
      Fmt := '%s'#13#10
{$ENDIF}
    else
    begin
      Selection.cpMin :=
        SendMessage(FRichEdit.Handle, EM_LINEINDEX, Index - 1, 0);
      if Selection.cpMin < 0 then Exit;
      L := SendMessage(FRichEdit.Handle, EM_LINELENGTH, Selection.cpMin, 0);
      if L = 0 then Exit;
      Inc(Selection.cpMin, L);
{$IFDEF CIL}
      Fmt := #13'%s';
{$ELSE}
      Fmt := #13#10'%s';
{$ENDIF}
    end;
    Selection.cpMax := Selection.cpMin;
    SendStructMessage(FRichEdit.Handle, EM_EXSETSEL, 0, Selection);
    Str := Format(Fmt, [S]);
    SendTextMessage(FRichEdit.Handle, EM_REPLACESEL, 0, Str);
  end;
end;

procedure TRichEditStrings.Delete(Index: Integer);
const
{$IFDEF CIL}
  REStrEmpty = '';
{$ELSE}
  REStrEmpty: PChar = '';
{$ENDIF}
var
  Selection: TCharRange;
begin
  if Index < 0 then Exit;
  Selection.cpMin := SendMessage(FRichEdit.Handle, EM_LINEINDEX, Index, 0);
  if Selection.cpMin <> -1 then
  begin
    Selection.cpMax := SendMessage(FRichEdit.Handle, EM_LINEINDEX, Index + 1, 0);
    if Selection.cpMax = -1 then
      Selection.cpMax := Selection.cpMin +
        SendMessage(FRichEdit.Handle, EM_LINELENGTH, Selection.cpMin, 0);
    SendStructMessage(FRichEdit.Handle, EM_EXSETSEL, 0, Selection);
    SendTextMessage(FRichEdit.Handle, EM_REPLACESEL, 0, REStrEmpty);
  end;
end;

procedure TRichEditStrings.Clear;
begin
  FRichEdit.Clear;
end;

procedure TRichEditStrings.SetUpdateState(Updating: Boolean);
begin
  if FRichEdit.Showing then
    SendMessage(FRichEdit.Handle, WM_SETREDRAW, Ord(not Updating), 0);
  if not Updating then
  begin
    FRichEdit.Refresh;
    FRichEdit.Perform(CM_TEXTCHANGED, 0, 0);
  end;
end;

procedure TRichEditStrings.EnableChange(const Value: Boolean);
var
  EventMask: Longint;
begin
  if Value then
    EventMask := SendMessage(FRichEdit.Handle, EM_GETEVENTMASK, 0, 0) or ENM_CHANGE
  else
    EventMask := SendMessage(FRichEdit.Handle, EM_GETEVENTMASK, 0, 0) and not ENM_CHANGE;
  SendMessage(FRichEdit.Handle, EM_SETEVENTMASK, 0, EventMask);
end;

procedure TRichEditStrings.SetTextStr(const Value: string);
begin
  EnableChange(False);
  try
    inherited SetTextStr(Value);
  finally
    EnableChange(True);
  end;
end;

function TRichEditStrings.Replace(const SearchStr, ReplaceStr: string; StartPos,
  Length: Integer; Options: TSearchTypes; ReplaceAll: Boolean): Integer;
begin
  repeat
    Result := FRichEdit.FindText(SearchStr, StartPos, Length, Options);
    if Result <> -1 then
    begin
      FRichEdit.SelStart := Result;
{$IFDEF CIL}
      FRichEdit.SelLength := Borland.Delphi.System.Length(SearchStr);
{$ELSE}
      FRichEdit.SelLength := System.Length(SearchStr);
{$ENDIF}
      FRichEdit.SelText := ReplaceStr;
    end;
    if not ReplaceAll or (Result = -1) then Break;
  until False = True;
end;

function TRichEditStrings.GetRtfText: String;
var
  Stream: TStringStream;
begin
  if Count = 0 then
  begin
    Result := '';
    Exit;
  end;

  Stream := TStringStream.Create('');
  try
    SaveToStream(Stream);
    Result := Stream.DataString;
  finally
    Stream.Free;
  end;
end;

{$IFDEF CIL}

function AdjustLineBreaks(Dest: IntPtr; Source: TBytes; Start, Len: Integer): Integer;
var
  I, J: Integer;
begin
  I := Start; 
  J := 0; 
  while I < (Len - 1) do
  begin
    if (Source[I] = 10) and (Source[I + 1] = 0) then
    begin
      Marshal.WriteByte(Dest, J, 13);
      Marshal.WriteByte(Dest, J + 1, 0);
      Inc(J, 2);
      Marshal.WriteByte(Dest, J, 10);
      Marshal.WriteByte(Dest, J + 1, 0);
    end
    else
    begin
      Marshal.WriteByte(Dest, J, Source[I]);
      Marshal.WriteByte(Dest, J + 1, Source[I + 1]);
      if (Source[I] = 13) and (Source[I + 1] = 0) then
      begin
        Inc(J, 2);
        Marshal.WriteByte(Dest, J, 10);
        Marshal.WriteByte(Dest, J + 1, 0);
        if (Source[I + 2] = 10) and (Source[I + 3] = 0) then
          Inc(I, 2);
      end;
    end;
    Inc(I, 2);
    Inc(J, 2);
  end;
  Result := J;
end;

function StreamSave(dwCookie: Longint; pbBuff: IntPtr;
  cb: Longint; var pcb: Longint): Longint;
var
  StreamInfo: TRichEditStreamInfo;
  Buffer: TBytes;
  Handle: GCHandle;
begin
  Result := NoError;
  Handle := GCHandle(IntPtr(dwCookie));
  StreamInfo := TRichEditStreamInfo(Handle.Target);
  try
    pcb := 0;
    if StreamInfo.Converter <> nil then
    begin
      SetLength(Buffer, cb);
      Marshal.Copy(pbBuff, Buffer, 0, cb);
      if StreamInfo.PlainText then
      begin
        if StreamInfo.Encoding = nil then
          Buffer := Encoding.Convert(Encoding.Unicode, Encoding.Default, Buffer)
        else
        begin
          if not Encoding.Unicode.Equals(StreamInfo.Encoding) then
            Buffer := Encoding.Convert(Encoding.Unicode, StreamInfo.Encoding, Buffer);
        end;
      end;
      pcb := StreamInfo.Converter.ConvertWriteStream(StreamInfo.Stream, Buffer, Length(Buffer));
      if (pcb <> cb) and (pcb = Length(Buffer)) then
        pcb := cb; 
    end;
  except
    Result := WriteError;
  end;
end;

function StreamLoad(dwCookie: Longint; pbBuff: IntPtr;
  cb: Longint; var pcb: Longint): Longint;
var
  Buffer, Preamble: TBytes;
  StreamInfo: TRichEditStreamInfo;
  Handle: GCHandle;
  StartIndex: Integer;
begin
  Result := NoError;
  Handle := GCHandle(IntPtr(dwCookie));
  StreamInfo := TRichEditStreamInfo(Handle.Target);
  SetLength(Buffer, cb + 1);
  cb := cb div 2;
  StartIndex := 0;
  pcb := 0;
  try
    if StreamInfo.Converter <> nil then
      pcb := StreamInfo.Converter.ConvertReadStream(StreamInfo.Stream, Buffer, cb);
    if pcb > 0 then
    begin
      Buffer[pcb] := 0;
      if Buffer[pcb - 1] = 13 then
        Buffer[pcb - 1] := 0;

      if StreamInfo.PlainText then
      begin
        if StreamInfo.Encoding = nil then
        begin
          Buffer := Encoding.Convert(Encoding.Default, Encoding.Unicode, Buffer, 0, pcb);
          pcb := Length(Buffer);
        end
        else
        begin
          if not Encoding.Unicode.Equals(StreamInfo.Encoding) then
          begin
            Buffer := Encoding.Convert(StreamInfo.Encoding, Encoding.Unicode, Buffer, 0, pcb);
            pcb := Length(Buffer);
          end;
          Preamble := Encoding.Unicode.GetPreamble;
          if (pcb >= 2) and (Buffer[0] = Preamble[0]) and (Buffer[1] = Preamble[1]) then
            StartIndex := 2;
        end;
      end;
      pcb := AdjustLineBreaks(pbBuff, Buffer, StartIndex, pcb);
    end;
  except
    Result := ReadError;
  end;
end;

procedure TRichEditStrings.LoadFromStream(Stream: TStream; Encoding: System.Text.Encoding);
var
  EditStream: TEditStream;
  Position: Longint;
  TextType: Longint;
  StreamInfo: TRichEditStreamInfo;
  Converter: TConversion;
  Handle: GCHandle;
begin
  StreamInfo.Stream := Stream;
  if FConverter <> nil then
    Converter := FConverter
  else
    Converter := FRichEdit.DefaultConverter.Create;
  StreamInfo.Converter := Converter;
  StreamInfo.PlainText := PlainText;
  StreamInfo.Encoding := Encoding;
  try
    Handle := GCHandle.Alloc(TObject(StreamInfo));
    try
      EditStream.dwCookie := Longint(IntPtr(Handle));
{$IFDEF CIL}
{$ELSE}
      EditStream.pfnCallBack := StreamLoad;
{$ENDIF}
      EditStream.dwError := 0;
      Position := Stream.Position;
      if PlainText then
        TextType := SF_TEXT or SF_UNICODE
      else
        TextType := SF_RTF;
      SendGetStructMessage(FRichEdit.Handle, EM_STREAMIN, TextType, EditStream, True);
      if (TextType = SF_RTF) and (EditStream.dwError <> 0) then
      begin
        Stream.Position := Position;
        if PlainText then
          TextType := SF_RTF
        else
          TextType := SF_TEXT or SF_UNICODE;
        StreamInfo.PlainText := not PlainText;
        SendGetStructMessage(FRichEdit.Handle, EM_STREAMIN, TextType, EditStream, True);
        if EditStream.dwError <> 0 then
          raise EOutOfResources.Create(sRichEditLoadFail);
      end;
    finally
      Handle.Free;
    end;
  finally
    if FConverter = nil then Converter.Free;
  end;
end;

procedure TRichEditStrings.SaveToStream(Stream: TStream; Encoding: System.Text.Encoding);
var
  EditStream: TEditStream;
  TextType: Longint;
  StreamInfo: TRichEditStreamInfo;
  Converter: TConversion;
  Handle: GCHandle;
  Preamble: TBytes;
begin
  if FConverter <> nil then
    Converter := FConverter
  else
    Converter := FRichEdit.DefaultConverter.Create;
  StreamInfo.Stream := Stream;
  StreamInfo.Converter := Converter;
  StreamInfo.PlainText := PlainText;
  StreamInfo.Encoding := Encoding;
  try
    Handle := GCHandle.Alloc(TObject(StreamInfo));
    try
      EditStream.dwCookie := LongInt(IntPtr(Handle));
{$IFDEF CIL}
{$ELSE}
      EditStream.pfnCallBack := StreamSave;
{$ENDIF}
      EditStream.dwError := 0;
      if PlainText then
      begin
        TextType := SF_TEXT or SF_UNICODE;
        if Encoding <> nil then
        begin
          Preamble := Encoding.GetPreamble;
          if Length(Preamble) > 0 then
            Stream.WriteBuffer(Preamble, Length(Preamble));
        end;
      end
      else
        TextType := SF_RTF;
      SendGetStructMessage(FRichEdit.Handle, EM_STREAMOUT, TextType, EditStream, True);
      if EditStream.dwError <> 0 then
        raise EOutOfResources.Create(sRichEditSaveFail);
    finally
      Handle.Free;
    end;
  finally
    if FConverter = nil then Converter.Free;
  end;
end;

procedure TRichEditStrings.SaveToFile(const FileName: string; Encoding: System.Text.Encoding);
begin
  inherited LoadFromFile(FileName, Encoding);
end;

procedure TRichEditStrings.LoadFromFile(const FileName: string; Encoding: System.Text.Encoding);
begin
  inherited SaveToFile(FileName, Encoding);
end;

{$ELSE} //CIL

{$IFDEF EH_LIB_12}

const
  TextConversionFormat: TConversionFormat = (
    ConversionClass: TConversion;
    Extension: 'txt');
var
  ConversionFormatList: TList;

procedure TRichEditStrings.LoadFromFile(const FileName: string; Encoding: TEncoding);
var
  I: Integer;
  Ext: string;
  Convert, LConvert: TConversionFormat;
begin
{$IFDEF NEXTGEN}
  Ext := LowerCase(ExtractFileExt(Filename));
{$ELSE}
  Ext := WideLowerCase(ExtractFileExt(Filename));
{$ENDIF}
  System.Delete(Ext, 1, 1);

  Convert := TextConversionFormat;
  for I := 0 to ConversionFormatList.Count - 1 do
  begin
    LConvert := PConversionFormat(ConversionFormatList[I])^;
    if LConvert.Extension = Ext then
    begin
      Convert := LConvert;
      Break;
    end;
  end;

  if FConverter = nil then
    FConverter := Convert.ConversionClass.Create;
  try
    inherited LoadFromFile(FileName, Encoding);
  except
    FConverter.Free;
    FConverter := nil;
    raise;
  end;
  SendMessage(FRichEdit.Handle, EM_EXLIMITTEXT, 0, $7FFFFFF0);
end;

function ContainsPreamble(Stream: TStream; Signature: TBytes): Boolean;
var
  Buffer: TBytes;
  I, LBufLen, LSignatureLen, LPosition: Integer;
begin
  Result := True;
  LSignatureLen := Length(Signature);
  LPosition := Stream.Position;
  try
    SetLength(Buffer, LSignatureLen);
    LBufLen := Stream.Read(Buffer[0], LSignatureLen);
  finally
    Stream.Position := LPosition;
  end;

  if LBufLen = LSignatureLen then
  begin
    for I := 1 to LSignatureLen do
      if Buffer[I - 1] <> Signature [I - 1] then
      begin
        Result := False;
        Break;
      end;
  end
  else
    Result := False;
end;

function AdjustLineBreaks(Dest: PByte; Source: TBytes; Start, Len: Integer): Integer;
var
  P: PByte;
  I: Integer;
begin
  I := Start; 
  P := Dest;
  while I < (Len - 1) do
  begin
    if (Source[I] = 10) and (Source[I + 1] = 0) then
    begin
      P^ := 13;
      Inc(P);
      P^ := 0;
      Inc(P);
      P^ := 10;
      Inc(P);
      P^ := 0;
      Inc(P);
    end
    else
    begin
      P^ := Source[I];
      Inc(P);
      P^ := Source[I + 1];
      Inc(P);
      if (Source[I] = 13) and (Source[I + 1] = 0) then
      begin
        P^ := 10;
        Inc(P);
        P^ := 0;
        Inc(P);
        if (Source[I + 2] = 10) and (Source[I + 3] = 0) then
          Inc(I, 2);
      end;
    end;
    Inc(I, 2);
  end;
  if I = Len - 1 then
  begin
    P^ := Source[I];
    Inc(P);
  end;
  Result := Integer(IntPtr(P) - IntPtr(Dest));
end;

function StreamLoad(dwCookie: {$IFDEF EH_LIB_19}DWORD_PTR{$ELSE}Longint{$ENDIF};
  pbBuff: PByte; cb: Longint; var pcb: Longint): Longint; stdcall;
var
  Buffer, Preamble: TBytes;
  StreamInfo: TRichEditStreamInfo;
  StartIndex: Integer;
begin
  Result := NoError;
  StreamInfo := PRichEditStreamInfo(dwCookie)^;
  SetLength(Buffer, cb + 1);
  cb := cb div 2;
  if (cb mod 2) > 0 then
    cb := cb -1 ;
  StartIndex := 0;
  pcb := 0;
  try
    if StreamInfo.Converter <> nil then
      pcb := StreamInfo.Converter.ConvertReadStream(StreamInfo.Stream, Buffer, cb);
    if pcb > 0 then
    begin
      Buffer[pcb] := 0;
      if Buffer[pcb - 1] = 13 then
        Buffer[pcb - 1] := 0;

      if StreamInfo.PlainText then
      begin
        if StreamInfo.Encoding = nil then
        begin
          Buffer := TEncoding.Convert(TEncoding.Default, TEncoding.Unicode, Buffer, 0, pcb);
          pcb := Length(Buffer);
        end
        else
        begin
          if not TEncoding.Unicode.Equals(StreamInfo.Encoding) then
          begin
            Buffer := TEncoding.Convert(StreamInfo.Encoding, TEncoding.Unicode, Buffer, 0, pcb);
            pcb := Length(Buffer);
          end;
          Preamble := TEncoding.Unicode.GetPreamble;
          if (pcb >= 2) and (Buffer[0] = Preamble[0]) and (Buffer[1] = Preamble[1]) then
            StartIndex := 2;
        end;
      end;
      pcb := AdjustLineBreaks(pbBuff, Buffer, StartIndex, pcb);
    end;
  except
    Result := ReadError;
  end;
end;

procedure TRichEditStrings.LoadFromStream(Stream: TStream; Encoding: TEncoding);
var
  EditStream: TEditStream;
  Position: Longint;
  TextType: Longint;
  StreamInfo: TRichEditStreamInfo;
  Converter: TConversion;
begin
  if Encoding = nil then
  begin
    if ContainsPreamble(Stream, TEncoding.Unicode.GetPreamble) then
      Encoding := TEncoding.Unicode
    else
      if ContainsPreamble(Stream, TEncoding.BigEndianUnicode.GetPreamble) then
        Encoding := TEncoding.BigEndianUnicode
      else
        if ContainsPreamble(Stream, TEncoding.UTF8.GetPreamble) then
          Encoding := TEncoding.UTF8
        else
          Encoding := TEncoding.Default;
  end;

  StreamInfo.Stream := Stream;
  if FConverter <> nil then
    Converter := FConverter
  else
    Converter := FRichEdit.DefaultConverter.Create;
  StreamInfo.Converter := Converter;
  StreamInfo.PlainText := PlainText;
  StreamInfo.Encoding := Encoding;
  try
    EditStream.dwCookie := DWORD_PTR(@StreamInfo);
    EditStream.pfnCallBack := StreamLoad;
    EditStream.dwError := 0;
    Position := Stream.Position;
    if PlainText then
      TextType := SF_TEXT or SF_UNICODE
    else
      TextType := SF_RTF;
    SendGetStructMessage(FRichEdit.Handle, EM_STREAMIN, TextType, EditStream, True);

    if (TextType = SF_RTF) and (EditStream.dwError <> 0) then
    begin
      Stream.Position := Position;
      if PlainText then
        TextType := SF_RTF
      else
        TextType := SF_TEXT or SF_UNICODE;
      StreamInfo.PlainText := not PlainText;
      SendMessage(FRichEdit.Handle, EM_STREAMIN, TextType, Windows.LPARAM(@EditStream));
      if EditStream.dwError <> 0 then
        raise EOutOfResources.Create(sRichEditLoadFail);
    end;
  finally
    if FConverter = nil then
      Converter.Free;
  end;
end;

procedure TRichEditStrings.SaveToFile(const FileName: string; Encoding: TEncoding);
var
  I: Integer;
  Ext: string;
  Convert, LConvert: TConversionFormat;
begin
{$IFDEF NEXTGEN}
  Ext := ExtractFileExt(Filename);
{$ELSE}
  Ext := WideLowerCase(ExtractFileExt(Filename));
{$ENDIF}
  System.Delete(Ext, 1, 1);

  Convert := TextConversionFormat;
  for I := 0 to ConversionFormatList.Count - 1 do
  begin
    LConvert := PConversionFormat(ConversionFormatList[I])^;
    if LConvert.Extension = Ext then
    begin
      Convert := LConvert;
      Break;
    end;
  end;

  if FConverter = nil then
    FConverter := Convert.ConversionClass.Create;
  try
    inherited SaveToFile(FileName, Encoding);
  except
    FConverter.Free;
    FConverter := nil;
    raise;
  end;
end;

function StreamSave(dwCookie: {$IFDEF EH_LIB_19}DWORD_PTR{$ELSE}Longint{$ENDIF};
  pbBuff: PByte; cb: Longint; var pcb: Longint): Longint; stdcall;
var
  StreamInfo: TRichEditStreamInfo;
  Buffer: TBytes;
begin
  Result := NoError;
  StreamInfo := PRichEditStreamInfo(dwCookie)^;
  try
    pcb := 0;
    if StreamInfo.Converter <> nil then
    begin
      SetLength(Buffer, cb);
      Move(pbBuff^, Buffer[0], cb);
      if StreamInfo.PlainText then
      begin
        if StreamInfo.Encoding = nil then
          Buffer := TEncoding.Convert(TEncoding.Unicode, TEncoding.Default, Buffer)
        else
        begin
          if not TEncoding.Unicode.Equals(StreamInfo.Encoding) then
            Buffer := TEncoding.Convert(TEncoding.Unicode, StreamInfo.Encoding, Buffer);
        end;
      end;
      pcb := StreamInfo.Converter.ConvertWriteStream(StreamInfo.Stream, Buffer, Length(Buffer));
      if (pcb <> cb) and (pcb = Length(Buffer)) then
        pcb := cb; 
    end;
  except
    Result := WriteError;
  end;
end;

procedure TRichEditStrings.SaveToStream(Stream: TStream; Encoding: TEncoding);
var
  EditStream: TEditStream;
  TextType: Longint;
  StreamInfo: TRichEditStreamInfo;
  Converter: TConversion;
  Preamble: TBytes;
begin
  if FConverter <> nil then
    Converter := FConverter
  else
    Converter := FRichEdit.DefaultConverter.Create;
  StreamInfo.Stream := Stream;
  StreamInfo.Converter := Converter;
  StreamInfo.PlainText := PlainText;
  StreamInfo.Encoding := Encoding;
  try
    EditStream.dwCookie := DWORD_PTR(@StreamInfo);
    EditStream.pfnCallBack := StreamSave;
    EditStream.dwError := 0;
    if PlainText then
    begin
      TextType := SF_TEXT or SF_UNICODE;
      if Encoding <> nil then
      begin
        Preamble := Encoding.GetPreamble;
        if Length(Preamble) > 0 then
          Stream.WriteBuffer(Preamble[0], Length(Preamble));
      end;
    end
    else
      TextType := SF_RTF;
    SendGetStructMessage(FRichEdit.Handle, EM_STREAMOUT, TextType, EditStream, True);
    if EditStream.dwError <> 0 then
      raise EOutOfResources.Create(sRichEditSaveFail);
  finally
    if FConverter = nil then Converter.Free;
  end;
end;

{$ELSE}

function AdjustLineBreaks(Dest, Source: PChar): Integer; assembler;
asm
        PUSH    ESI
        PUSH    EDI
        MOV     EDI,EAX
        MOV     ESI,EDX
        MOV     EDX,EAX
        CLD
@@1:    LODSB
@@2:    OR      AL,AL
        JE      @@4
        CMP     AL,0AH
        JE      @@3
        STOSB
        CMP     AL,0DH
        JNE     @@1
        MOV     AL,0AH
        STOSB
        LODSB
        CMP     AL,0AH
        JE      @@1
        JMP     @@2
@@3:    MOV     EAX,0A0DH
        STOSW
        JMP     @@1
@@4:    STOSB
        LEA     EAX,[EDI-1]
        SUB     EAX,EDX
        POP     EDI
        POP     ESI
end;

function StreamSave(dwCookie: Longint; pbBuff: PByte;
  cb: Longint; var pcb: Longint): Longint; stdcall;
var
  StreamInfo: PRichEditStreamInfo;
begin
  Result := NoError;
  StreamInfo := PRichEditStreamInfo(Pointer(dwCookie));
  try
    pcb := 0;
    if StreamInfo^.Converter <> nil then
      pcb := StreamInfo^.Converter.ConvertWriteStream(StreamInfo^.Stream, PChar(pbBuff), cb);
  except
    Result := WriteError;
  end;
end;

function StreamLoad(dwCookie: Longint; pbBuff: PByte;
  cb: Longint; var pcb: Longint): Longint; stdcall;
var
  Buffer, pBuff: PChar;
  StreamInfo: PRichEditStreamInfo;
begin
  Result := NoError;
  StreamInfo := PRichEditStreamInfo(Pointer(dwCookie));
  Buffer := StrAlloc(cb + 1);
  try
    cb := cb div 2;
    pcb := 0;
    pBuff := Buffer + cb;
    try
      if StreamInfo^.Converter <> nil then
        pcb := StreamInfo^.Converter.ConvertReadStream(StreamInfo^.Stream, pBuff, cb);
      if pcb > 0 then
      begin
        pBuff[pcb] := #0;
        if pBuff[pcb - 1] = #13 then pBuff[pcb - 1] := #0;
        pcb := AdjustLineBreaks(Buffer, pBuff);
        Move(Buffer^, pbBuff^, pcb);
      end;
    except
      Result := ReadError;
    end;
  finally
    StrDispose(Buffer);
  end;
end;

procedure TRichEditStrings.LoadFromStream(Stream: TStream);
var
  EditStream: TEditStream;
  Position: Longint;
  TextType: Longint;
  StreamInfo: TRichEditStreamInfo;
  Converter: TConversion;
begin
  StreamInfo.Stream := Stream;
  if FConverter <> nil then Converter := FConverter
  else Converter := FRichEdit.DefaultConverter.Create;
  StreamInfo.Converter := Converter;
  try
    EditStream.dwCookie := LongInt(Pointer(@StreamInfo));
    EditStream.pfnCallBack := @StreamLoad;
    EditStream.dwError := 0;
    Position := Stream.Position;
    if PlainText
      then TextType := SF_TEXT
      else TextType := SF_RTF;
    SendMessage(FRichEdit.Handle, EM_STREAMIN, TextType, LPARAM(@EditStream));
    if (TextType = SF_RTF) and (EditStream.dwError <> 0) then
    begin
      Stream.Position := Position;
      if PlainText
        then TextType := SF_RTF
        else TextType := SF_TEXT;
      SendMessage(FRichEdit.Handle, EM_STREAMIN, TextType, LPARAM(@EditStream));
      if EditStream.dwError <> 0 then
        raise EOutOfResources.Create(sRichEditLoadFail);
    end;
  finally
    if FConverter = nil then Converter.Free;
  end;
end;

procedure TRichEditStrings.SaveToStream(Stream: TStream);
var
  EditStream: TEditStream;
  TextType: Longint;
  StreamInfo: TRichEditStreamInfo;
  Converter: TConversion;
begin
  if FConverter <> nil
    then Converter := FConverter
    else Converter := FRichEdit.DefaultConverter.Create;
  StreamInfo.Stream := Stream;
  StreamInfo.Converter := Converter;
  try
    EditStream.dwCookie := LongInt(Pointer(@StreamInfo));
    EditStream.pfnCallBack := @StreamSave;
    EditStream.dwError := 0;
    if PlainText
      then TextType := SF_TEXT
      else TextType := SF_RTF;
    SendMessage(FRichEdit.Handle, EM_STREAMOUT, TextType, LPARAM(@EditStream));
    if EditStream.dwError <> 0 then
      raise EOutOfResources.Create(sRichEditSaveFail);
  finally
    if FConverter = nil
      then Converter.Free;
  end;
end;

procedure TRichEditStrings.LoadFromFile(const FileName: string);
begin
  inherited LoadFromFile(FileName);
end;

procedure TRichEditStrings.SaveToFile(const FileName: string);
begin
  inherited SaveToFile(FileName);
end;

{$ENDIF}
{$ENDIF}

{$ENDIF} 

{ TPrintDBGridEh }

constructor TPrintDBGridEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPage := TPageParams.Create;
  FPageFooter := TPageColontitle.Create;
  FPageHeader := TPageColontitle.Create;
  FTitle := TStringList.Create;
  FColCellParamsEh := TPrintColCellParamsEh.Create;
  FGroupRowParams := TGroupRowParamsEh.Create;
end;

destructor TPrintDBGridEh.Destroy;
begin
  FreeAndNil(FColCellParamsEh);
  FreeAndNil(FGroupRowParams);
  FreeAndNil(FPage);
  FreeAndNil(FPageFooter);
  FreeAndNil(FPageHeader);
  FreeAndNil(FTitle);
  FreeAndNil(FBeforeGridText);
  FreeAndNil(FAfterGridText);
  if FSubstitutesNames <> nil then FreeAndNil(FSubstitutesNames);
  if FSubstitutesValues <> nil then FreeAndNil(FSubstitutesValues);
  inherited Destroy;
end;

procedure TPrintDBGridEh.Preview;
begin
  {$IFDEF FPC}
  // TO DO
  {$ELSE}
  if Assigned(OnPrinterSetupDialog) then
    PrinterPreview.OnPrinterSetupDialog := OnPrinterSetupDialog
  else
    PrinterPreview.OnPrinterSetupDialog := PrinterSetupDialogPreview;
  PrinterPreview.PrinterSetupOwner := Self;
  PrintTo(PrinterPreview);
  {$ENDIF}
end;

function TPrintDBGridEh.DefaultPrintDataCell(VPrinter: TBaseVirtualPrinter;
  Column: TColumnEh; ARect: TRect; CalcRect: Boolean; var Params: TPrintColCellParamsEh): Integer;
const
  CheckBoxFlags: array[TCheckBoxState] of Integer =
  (DFCS_BUTTONCHECK, DFCS_BUTTONCHECK or DFCS_CHECKED, DFCS_BUTTON3STATE or DFCS_CHECKED);
var
  ARect1: TRect;
  dr: TRect;
  VPrinter_Canvas: TBasePrinterCanvas;
  ImageHeight: Integer;
  bm: TBitmap;
  PSY2: Integer;
  Wdth: Integer;
begin
  if DBGridEh.Flat then
  begin
    PSY2 := Round(Params.ScaleY);
  end else
  begin
    PSY2 := Round(Params.ScaleY * 2);
  end;

  Result := 0;
  ImageHeight := 0;
  VPrinter_Canvas := VPrinter.Canvas;
  if (Column = DBGridEh.VisibleColumns[0]) and
     (DBGridEh.GetCellTreeElmentsAreaWidth > 0) then
  begin
    ARect1 := ARect;
    if DBGridEh.UseRightToLeftAlignment then
    begin
      ARect1.Left := Trunc(ARect1.Right - DBGridEh.GetCellTreeElmentsAreaWidth * Params.ScaleX);
      if not CalcRect then
      begin
        ChangeBoxOrientation(VPrinter_Canvas, ARect1, True);
        DrawTreeArea(VPrinter_Canvas, ARect1, Params);
        ChangeBoxOrientation(VPrinter_Canvas, ARect1, False);
      end;
      ARect.Right := Trunc(ARect1.Left + Params.ScaleX);
    end else
    begin
      ARect1.Right := Trunc(ARect1.Left + DBGridEh.GetCellTreeElmentsAreaWidth * Params.ScaleX);
      if not CalcRect then
        DrawTreeArea(VPrinter_Canvas, ARect1, Params);
      ARect.Left := Trunc(ARect1.Right + Params.ScaleX);
    end;
  end;

  if (Column.ImageList <> nil) and Column.ShowImageAndText then
  begin
    ARect1 := ARect;
    if DBGridEh.UseRightToLeftAlignment then
    begin
      Wdth := Trunc(Column.ImageList.Width * Params.ScaleY + 4 * Params.ScaleY);
      ARect1.Left := ARect1.Right - Wdth;
      ARect.Right := ARect.Right - Wdth - Trunc(Params.ScaleY);
    end else
    begin
      ARect1.Right := Trunc(ARect1.Left + Column.ImageList.Width * Params.ScaleY + 4 * Params.ScaleY);
      ARect.Left := Trunc(ARect1.Right + Params.ScaleY);
    end;
    if pghColored in Options then
      VPrinter.Canvas.Brush.Color := Column.Color;
    if CalcRect then
      ImageHeight := Trunc(Column.ImageList.Height * Params.ScaleY + 4 * Params.ScaleY)
    else
    begin
      DrawClipped(Column.ImageList, FColCellParamsEh.ImageIndex,
        VPrinter_Canvas, ARect1, ARect1, taCenter, taVerticalCenter,
        Params.ScaleX, Params.ScaleY);
    end;

    if pghColored in Options then
      VPrinter.Canvas.Brush.Color := FColCellParamsEh.Background;

  end;

  if (Column.GetBarType = ctCheckboxes) and not CalcRect and not Params.CalcInfoMode then
  begin
    dr.Left := ARect.Left + iif(ARect.Right - ARect.Left < Trunc(FCheckBoxWidth * Params.ScaleX), 0,
      (ARect.Right - ARect.Left) shr 1 - Trunc(FCheckBoxWidth * Params.ScaleX) shr 1);
    dr.Right := iif(ARect.Right - ARect.Left < Trunc(FCheckBoxWidth * Params.ScaleX), ARect.Right,
      dr.Left + Trunc(FCheckBoxWidth * Params.ScaleX));
    dr.Top := ARect.Top + iif(ARect.Bottom - ARect.Top < Trunc(FCheckBoxHeight * Params.ScaleY), 0,
      (ARect.Bottom - ARect.Top) shr 1 - Trunc(FCheckBoxHeight * Params.ScaleY) shr 1);
    dr.Bottom := iif(ARect.Bottom - ARect.Top < Trunc(FCheckBoxHeight * Params.ScaleY), ARect.Bottom,
      dr.Top + Trunc(FCheckBoxHeight * Params.ScaleY));
    PrintFrameControlEh(VPrinter_Canvas, dr, DFC_BUTTON, CheckBoxFlags[FColCellParamsEh.CheckboxState]);
  end else
  begin
    if (Column.GetBarType = ctKeyImageList) and not CalcRect then
    begin
      bm := TBitmap.Create;
      Column.ImageList.GetBitmap(FColCellParamsEh.ImageIndex, bm);

      dr := Rect(0, 0, Trunc(Column.ImageList.Height * Params.ScaleY), Trunc(Column.ImageList.Width * Params.ScaleX));
      dr.Left := ARect.Left + (ARect.Right - ARect.Left) div 2 - dr.Right div 2;
      dr.Right := dr.Right + dr.Left;
      dr.Top := ARect.Top + (ARect.Bottom - ARect.Top) div 2 - dr.Bottom div 2;
      dr.Bottom := dr.Bottom + dr.Top;

      DrawClipped(Column.ImageList, FColCellParamsEh.ImageIndex,
        VPrinter_Canvas, dr, dr, taCenter, taVerticalCenter,
        Params.ScaleX, Params.ScaleY);
      bm.Free;
    end else if DBGridEh.DrawGraphicData and (Column.GetBarType = ctGraphicData)
    then
      Result := DrawGraphicCell(VPrinter_Canvas, Column, ARect, VPrinter_Canvas.Brush.Color, CalcRect, Params)
    else
    begin
      Result := PrintTextEh(VPrinter_Canvas, ARect, 0, 0, FColCellParamsEh.Text,
        FColCellParamsEh.Alignment, Column.Layout, Params.Stretch, Column.EndEllipsis, ARect,
        CalcRect or Params.CalcInfoMode, Column.UseRightToLeftAlignment, DBGridEh.UseRightToLeftReading) + PSY2 * 2;
      if ImageHeight > Result then
        Result := ImageHeight;
    end;
  end;
end;

procedure TPrintDBGridEh.ChangeBoxOrientation(Canvas: TBasePrinterCanvas; Box: TRect; RightToLeftOrientation: Boolean);
var
  Org: TPoint;
  Ext: TPoint;
  Size: TSize;
begin
  Size.cx := Box.Right + Box.Left;
  Size.cy := Box.Bottom + Box.Top;
  if RightToLeftOrientation then
  begin
    Org := Point(Size.cx, 0);
    Ext := Point(-1, 1);
    SetMapMode(Canvas.Handle, mm_Anisotropic);
    SetWindowOrgEx(Canvas.Handle, Org.X, Org.Y, nil);
    SetViewportExtEx(Canvas.Handle, Size.cx, Size.cy, nil);
    SetWindowExtEx(Canvas.Handle, Ext.X * Size.cx, Ext.Y * Size.cy, nil);
  end else
  begin
    Org := Point(0, 0);
    Ext := Point(1, 1);
    SetMapMode(Canvas.Handle, mm_Anisotropic);
    SetWindowOrgEx(Canvas.Handle, Org.X, Org.Y, nil);
    SetViewportExtEx(Canvas.Handle, Size.cx, Size.cy, nil);
    SetWindowExtEx(Canvas.Handle, Ext.X * Size.cx, Ext.Y * Size.cy, nil);
  end;
end;

procedure TPrintDBGridEh.DrawTreeArea(Canvas: TBasePrinterCanvas; ARect: TRect; var Params: TPrintColCellParamsEh);

  procedure DrawOneTreeElement(Canvas: TBasePrinterCanvas; ARect: TRect; TreeElement: TTreeElementEh);
  begin
    Canvas.FillRect(ARect);
    PrintTreeElement(Canvas, ARect, TreeElement, False, Params.ScaleX, Params.ScaleY,
      DBGridEh.UseRightToLeftAlignment, pghColored in Options);
  end;

var
  ARect1: TRect;
  i: Integer;
  IntMemTable: IMemTableEh;
begin
  if DBGridEh.TryUseMemTableInt and
     (DBGridEh.DataSource <> nil) and
     (DBGridEh.DataSource.DataSet <> nil) and
     (DBGridEh.FooterRowCount = 0) and
      Supports(DBGridEh.DataSource.DataSet, IMemTableEh, IntMemTable)
  then
    ARect1 := ARect
  else
    Exit;

  ARect1.Right := ARect1.Left + Trunc(Params.TreeBlockScreenWidth * Params.ScaleX);
  for i := 1 to IntMemTable.GetTreeNodeLevel-1 do
  begin
    if IntMemTable.ParentHasNextSibling(i)
      then DrawOneTreeElement(Canvas, ARect1, tehVLine)
      else Canvas.FillRect(ARect1);
    ARect1.Left := ARect1.Left + Trunc(Params.TreeBlockScreenWidth * Params.ScaleX);
    ARect1.Right := ARect1.Left + Trunc(Params.TreeBlockScreenWidth * Params.ScaleX);
  end;
  if IntMemTable.GetTreeNodeHasChields then
    if IntMemTable.ParentHasNextSibling(IntMemTable.GetTreeNodeLevel)
    then
      if IntMemTable.GetTreeNodeExpanded
        then DrawOneTreeElement(Canvas, ARect1, tehMinusUpDown)
        else DrawOneTreeElement(Canvas, ARect1, tehPlusUpDown)
    else
      if IntMemTable.GetTreeNodeExpanded
        then DrawOneTreeElement(Canvas, ARect1, tehMinusUp)
        else DrawOneTreeElement(Canvas, ARect1, tehPlusUp)
  else
    if IntMemTable.ParentHasNextSibling(IntMemTable.GetTreeNodeLevel)
      then DrawOneTreeElement(Canvas, ARect1, tehCrossUpDown)
      else DrawOneTreeElement(Canvas, ARect1, tehCrossUp);
  ARect.Left := ARect1.Right;
end;

function TPrintDBGridEh.DrawGraphicCell(Canvas: TBasePrinterCanvas; Column: TColumnEh; ARect: TRect;
  Background: TColor; CalcRect: Boolean; var Params: TPrintColCellParamsEh): Integer;
var
  R: TRect;
  DrawPict: TPicture;
  //Pal: HPalette;
  Stretch: Boolean;
  Center: Boolean;
  XRatio, YRatio: Double;
begin
  DrawPict := DBGridEh.GetPictureForField(Column);
  //Pal := 0;
  try


    Result := DrawPict.Height;
    if DrawPict.Width > Column.FullWidth then
      Result := Round(Result / (DrawPict.Width / Column.FullWidth));
    Result :=  Trunc(Result * Params.ScaleY);
    if CalcRect then Exit;

    Stretch := (Trunc(DrawPict.Width * Params.ScaleY) > (ARect.Right-Arect.Left))
      or (Trunc(DrawPict.Height * Params.ScaleY) > (ARect.Bottom-Arect.Top));
    Center := True;

    if Stretch then
    begin
      XRatio := Trunc(DrawPict.Width * Params.ScaleY) / (ARect.Right-Arect.Left);
      YRatio := Trunc(DrawPict.Height * Params.ScaleY) / (ARect.Bottom-Arect.Top);
      R := ARect;
      if XRatio > YRatio then
      begin
        R.Bottom := Arect.Top + Round(Trunc(DrawPict.Height * Params.ScaleY) / XRatio);
      end else
      begin
        R.Right := ARect.Left + Round(Trunc(DrawPict.Width * Params.ScaleY) / YRatio);
      end;
    end else
    begin
      SetRect(R, ARect.Left, Arect.Top,
        ARect.Left + Trunc(DrawPict.Width  * Params.ScaleY),
        Arect.Top + Trunc(DrawPict.Height * Params.ScaleY));
    end;

    if Center then
    begin
      OffsetRect(R,
        (ARect.Right - Arect.Left - (R.Right-R.Left)) div 2,
        (ARect.Bottom - Arect.Top - (R.Bottom-R.Top)) div 2);
    end;

    Canvas.StretchDraw(R, DrawPict.Graphic);
  finally
//    if Pal <> 0 then
//      SelectPalette(Canvas.Handle, Pal, True);
    DrawPict.Free;
  end;
end;

procedure TPrintDBGridEh.DrawClipped(ImageList: TCustomImageList; ImageIndex: Integer;
  ACanvas: TBasePrinterCanvas; ARect: TRect; AClipRect: TRect;
  Align: TAlignment; VertAlign: TVerticalAlignment;
  ScaleX: Double; ScaleY: Double);
var
  ImHeight, ImWidth: Integer;
  bm: TBitmap;
  ImageRect: TRect;
begin
  if (ImageIndex < 0) or (ImageIndex >= ImageList.Count) then Exit;
  ImHeight := Trunc(ImageList.Height * ScaleY);
  ImWidth := Trunc(ImageList.Width * ScaleX);
  bm := ImListImageToBitmap(ImageList, ImageIndex);
  ImageRect := Rect(0, 0, ImWidth, ImHeight);
  ImageRect := CenteredRect(ARect, ImageRect);

  ACanvas.StretchDraw(ImageRect, bm);

  bm.Free;
end;

var
  MacroValues: array[0..5] of String = ('', '', '', '', '', '');

procedure TPrintDBGridEh.PrintTo(VPrinter: TBaseVirtualPrinter);
type
  TPolyBookmark = record
    bm: TUniBookmarkEh;
    bmi: Integer;
    InDS: Boolean;
    EOF: Boolean;
    RecNo: Integer;
    PrnRowType: TPrnRowTypeEh;
  end;
  TFooterValues = array of Currency;

var
  PrnRowHeights, ColsToPages, PrnColWIdths: array of Integer;
  GridWidth, RealRight, RealLeft, MinRowHeight: Integer;
  fPrnPhysOffSetX, fPrnPhysOffSetY: Integer;
  fPrnHorsRes, fPrnVertRes, PrnTitlEh, PenW, PrnTitleTextH: Integer;
  DataPrintRec, PrintRec: TRect;
  PrintOffset: Integer;
  fLogPelsX1, fLogPelsY1, fLogPelsX2, fLogPelsY2, fScaleX, fScaleY: Double;
  SavedBookMark: TUniBookmarkEh;
  PBm1, PBm2: TPolyBookmark;
  PSX1, PSY1, PSX2, PSY2: Integer;
  FirstPage, AWordWrap: Boolean;
  PolyPolyPoints: TPointArrayEh;
  PolyLengths: TDWORDArrayEh;
  TitleRect, FooterRect: TRect;
  PrnColumns: TColumnsEhList;
  PrnColumnWidths: array of Integer;
  FooterValues: TFooterValues;
  FSubstituted: Boolean;
  BeforeGridTextStream, AfterGridTextStream: TStream;
  CalcInfoMode: Boolean;
  PageCount: Integer;
  ACursor: TCursor;
  VPrinter_Canvas: TBasePrinterCanvas;
  DBGridEh: TDBGridEhCracker;
  MeasuringCanvas: TBasePrinterCanvas;
  TreeBlockScreenWidth: Integer;

const Macros: array[0..5] of String = ('&[Page]', '&[ShortDate]', '&[Date]',
    '&[LongDate]', '&[Time]', '&[Pages]');

  procedure CreateRenderCanvas;
  begin
    MeasuringCanvas := VPrinter.CreateMeasuringCanvas;
    VPrinter_Canvas := MeasuringCanvas;
  end;

  procedure FreeRenderCanvas;
  begin
    FreeAndNil(MeasuringCanvas);
    VPrinter_Canvas := VPrinter.Canvas;
  end;

  procedure InitMacroValues;
  begin
    MacroValues[1] := DateToStr(Now);
    MacroValues[2] := DateToStr(Now);
    MacroValues[3] := FormatDateTime(FormatSettings.LongDateFormat, Now);
    MacroValues[4] := TimeToStr(Now);
    MacroValues[5] := IntToStr(PageCount);
  end;

  function IsDataGroupingFullPass: Boolean;
  begin
    Result := DBGridEh.DataGrouping.IsGroupingWorks and
              (DBGridEh.DataGrouping.GroupDataTree.FlatVisibleCount > 0) and
              (DBGridEh.Selection.SelectionType in [gstAll, gstNon]);
  end;

  procedure GotoFirstRow;
  begin
    if IsDataGroupingFullPass then
      TDBGridEhCracker(DBGridEh).InstantReadRecordEnter(0)
    else
      DBGridEh.DataSource.DataSet.First;
  end;

  procedure SetPrnRowType(var APBm: TPolyBookmark);
  var
    FirstRowNode: TGroupDataTreeNodeEh;
  begin
    APBm.PrnRowType := prtNowhere;
    FirstRowNode := nil;
    if DBGridEh.DataGrouping.GroupDataTree.FlatVisibleCount > 0 then
      FirstRowNode := DBGridEh.DataGrouping.GroupDataTree.FlatVisibleItem[APBm.RecNo];
    if FirstRowNode <> nil then
    begin
      if FirstRowNode.NodeType = dntDataSetRecordEh then
        APBm.PrnRowType := prtRecordDataEh
      else if FirstRowNode.NodeType = dntDataGroupEh then
        APBm.PrnRowType := prtGroupHeaderRowEh
      else if FirstRowNode.NodeType = dntDataGroupFooterEh then
        APBm.PrnRowType := prtGroupFooterEh;
    end;
  end;

  procedure InitPolyBookmark(out APBm: TPolyBookmark);
  var
    idx: Integer;
  begin
    if IsDataGroupingFullPass then
    begin
      APBm.InDS := True;
      APBm.bm := NilBookmarkEh;
      APBm.bmi := -1;
      APBm.RecNo := 0;
      APBm.EOF := False;
      SetPrnRowType(APBm);
    end else if DBGridEh.DataSource.DataSet.Eof then
    begin
      APBm.InDS := False;
      APBm.bm := NilBookmarkEh;
      APBm.bmi := -1;
      if (DBGridEh.FooterRowCount = 0) then
        APBm.EOF := True
      else
      begin
        APBm.bmi := 0;
        APBm.EOF := False;
      end;
      APBm.PrnRowType := prtNowhere;
    end else
    begin
      if DBGridEh.Selection.SelectionType = gstRecordBookmarks then
      begin
        if DBGridEh.SelectedRows.Find(DBGridEh.DataSource.DataSet.Bookmark, idx) then
          APBm.bm := DBGridEh.DataSource.DataSet.Bookmark
        else
        begin
          APBm.bm := DBGridEh.SelectedRows[0];
          DBGridEh.DataSource.DataSet.Bookmark := DBGridEh.SelectedRows[0];
        end
      end else if DBGridEh.Selection.SelectionType = gstRectangle then
      begin
        APBm.bm := DBGridEh.Selection.Rect.TopRow;
        DBGridEh.DataSource.DataSet.Bookmark := DBGridEh.Selection.Rect.TopRow;
      end else
      begin
        APBm.bm := DBGridEh.DataSource.DataSet.Bookmark;
      end;
      APBm.InDS := True;
      APBm.EOF := False;
      APBm.PrnRowType := prtNowhere;
    end;
  end;

  procedure GotoPolyBookmark(var APBm: TPolyBookmark);
  begin
    if IsDataGroupingFullPass then
    begin
      TDBGridEhCracker(DBGridEh).InstantReadRecordEnter(APBm.RecNo);
    end else if (APBm.InDS = True) then
      DBGridEh.DataSource.DataSet.Bookmark := APBm.bm;
  end;

  procedure SetNextPolyBookmark(var APBm: TPolyBookmark);
  var
    idx: Integer;
  begin

    if APBm.EOF then Exit;
    APBm.PrnRowType := prtNowhere;

    if (APBm.InDS = True) then
    begin
      if IsDataGroupingFullPass then
      begin
        Inc(APBm.RecNo);
        if APBm.RecNo >= TDBGridEhCracker(DBGridEh).InstantReadRecordCount then
        begin
          APBm.RecNo := TDBGridEhCracker(DBGridEh).InstantReadRecordCount - 1;
          if (DBGridEh.FullFooterRowCount = 0) then
            APBm.EOF := True
          else begin
            APBm.bmi := 0; 
            APBm.EOF := False;
            APBm.InDS := False;
          end
        end else
        begin
          TDBGridEhCracker(DBGridEh).InstantReadRecordLeave;
          TDBGridEhCracker(DBGridEh).InstantReadRecordEnter(APBm.RecNo);
          SetPrnRowType(APBm);
        end;
      end
      else if DBGridEh.Selection.SelectionType = gstRecordBookmarks then
      begin
        if DBGridEh.SelectedRows.Find(DBGridEh.DataSource.DataSet.Bookmark, idx) then
          if idx = DBGridEh.SelectedRows.Count - 1 then
          begin
            APBm.InDS := False;
            APBm.bm := NilBookmarkEh; 
            APBm.bmi := -1;
            if (DBGridEh.FooterRowCount = 0)
              then APBm.EOF := True
            else begin
              APBm.bmi := 0; 
              APBm.EOF := False;
            end;
          end
          else
          begin
            DBGridEh.DataSource.DataSet.Bookmark := DBGridEh.SelectedRows[idx + 1];
            APBm.bm := DBGridEh.DataSource.DataSet.Bookmark;
            APBm.EOF := False;
          end
        else
        begin
          DBGridEh.DataSource.DataSet.Bookmark := DBGridEh.SelectedRows[0];
          APBm.bm := DBGridEh.DataSource.DataSet.Bookmark;
          APBm.EOF := False;
        end;
      end else if DBGridEh.Selection.SelectionType = gstRectangle then
      begin
        DBGridEh.DataSource.DataSet.Next;
        if (DataSetCompareBookmarks(
              DBGridEh.DataSource.DataSet,
              DBGridEh.Selection.Rect.BottomRow,
              DBGridEh.DataSource.DataSet.Bookmark) < 0) or
          DBGridEh.DataSource.DataSet.Eof then
        begin
          APBm.InDS := False;
          APBm.bm := NilBookmarkEh;
          APBm.bmi := -1;
          if (DBGridEh.FooterRowCount = 0) then APBm.EOF := True
          else
          begin
            APBm.bmi := 0; 
            APBm.EOF := False;
          end
        end else
        begin
          APBm.bm := DBGridEh.DataSource.DataSet.Bookmark;
          APBm.EOF := False;
        end;
      end else
      begin
        DBGridEh.DataSource.DataSet.Next;
        if DBGridEh.DataSource.DataSet.Eof then
        begin
          APBm.InDS := False;
          APBm.bm := NilBookmarkEh;
          APBm.bmi := -1;
          if (DBGridEh.FullFooterRowCount = 0) then
            APBm.EOF := True
          else
          begin
            APBm.bmi := 0; 
            APBm.EOF := False;
          end;
        end else
        begin
          APBm.bm := DBGridEh.DataSource.DataSet.Bookmark;
          APBm.EOF := False;
        end
      end
    end
    else
    begin
      if (DBGridEh.FullFooterRowCount - 1 <= APBm.bmi) then
      begin
        APBm.EOF := True;
        APBm.bmi := 0; 
        APBm.InDS := False;
      end else
      begin
        APBm.bmi := APBm.bmi + 1;
      end;
    end;
  end;

  procedure AddPolyline(const Args: array of const);
  var
    AFrom, i: Integer;
  begin
    AFrom := Length(PolyPolyPoints);
    SetLength(PolyPolyPoints, Length(PolyPolyPoints) + (Length(Args) div 2));
    i := 0;
    while i < (Length(Args) div 2) do
    begin
{$IFDEF CIL}
      PolyPolyPoints[i + AFrom] := Point(Integer(Args[i*2]), Integer(Args[i*2+1]));
{$ELSE}
      PolyPolyPoints[i + AFrom] := Point(Args[i*2].VInteger, Args[i*2+1].VInteger);
{$ENDIF}
      Inc(i);
    end;
    SetLength(PolyLengths, Length(PolyLengths) + 1);
    PolyLengths[Length(PolyLengths)-1] := (High(Args) + 1) div 2;
  end;

  procedure CalcColumnWidths;
  var
    i, w, w1, tw: Integer;
    PM: TPolyBookmark;
    NewBackgrnd: TColor;
    Text: String;
    AAlignment: TAlignment;
    ACursor: TCursor;
    ccp: TColCellParamsEh;
    Footer: TColumnFooterEh;

    function GetTitleText(Column: TColumnEh): String;
    var i: Integer;
    begin
      if DBGridEh.UseMultiTitle then
        for i := Length(Column.Title.Caption) downto 1 do
          if (Column.Title.Caption[i] = '|') and (ByteType(Column.Title.Caption, i) = mbSingleByte) then
          begin
            Result := Copy(Column.Title.Caption, i, Length(Column.Title.Caption));
            Exit;
          end;
      Result := Column.Title.Caption;
    end;

  begin
    w := 0;
    for i := 0 to PrnColumns.Count - 1 do
    begin
      SetLength(PrnColumnWidths, Length(PrnColumnWidths) + 1);
      PrnColumnWidths[Length(PrnColumnWidths)-1] :=
         (Round((PrnColumns[i].FullWidth + 1) * fScaleX));

      Inc(w, PrnColumnWidths[i]);
    end;

    if (pghOptimalColWidths in Options) then
    begin
      CreateRenderCanvas;
      for i := 0 to PrnColumns.Count - 1 do
      begin
        PrnColumnWidths[i] := 10;
        if (DBGridEh.TitleImages <> nil) and (PrnColumns[i].Title.ImageIndex <> -1) then
          tw := Trunc(DBGridEh.TitleImages.Width * fScaleX) + PSX2 * 2
        else
        begin
          VPrinter_Canvas.Font := PrnColumns[i].Title.Font;
          if (PrintFontName <> '') then VPrinter_Canvas.Font.Name := PrintFontName;
          tw := GetTextWidth(VPrinter_Canvas, GetTitleText(PrnColumns[i])) + PSX2 * 2;
        end;
        if tw > PrnColumnWidths[i] then
          PrnColumnWidths[i] := tw;
      end;
      GotoFirstRow;
      DBGridEh.DataSource.DataSet.First;
      InitPolyBookmark(PM);
      ACursor := Screen.Cursor;
      Screen.Cursor := crHourGlass;
      try
        while not PM.Eof do
        begin
          for i := 0 to PrnColumns.Count - 1 do
          begin
            if PM.InDS then 
            begin
              case PrnColumns[i].GetBarType of
                ctCheckboxes: tw := Trunc(FCheckBoxWidth * fScaleX) + PSX2 * 2;
                ctKeyImageList: tw := Trunc(PrnColumns[i].ImageList.Width * fScaleX) + PSX2 * 2;
              else
                VPrinter_Canvas.Font := PrnColumns[i].Font;
                if (PrintFontName <> '') then VPrinter_Canvas.Font.Name := PrintFontName;


                NewBackgrnd := clWhite;

                ccp := FColCellParamsEh;
                ccp.Row := -1;
                ccp.Col := -1;
                ccp.State := [];
                ccp.Font := VPrinter_Canvas.Font;
                ccp.Background := clWhite;
                ccp.Alignment := taLeftJustify;
                ccp.ImageIndex := -1;
                ccp.Text := PrnColumns[i].DisplayText;
                ccp.CheckboxState := PrnColumns[i].CheckboxState;

                if Assigned(DBGridEh.OnGetCellParams) then
                  DBGridEh.OnGetCellParams(DBGridEh, PrnColumns[i], ccp.Font, NewBackgrnd, []);

                ccp.Background := NewBackgrnd;
                PrnColumns[i].GetColCellParams(False, ccp);

                tw := GetTextWidth(VPrinter_Canvas, ccp.Text) + PSX2 * 2;
                if (PrnColumns[i].ImageList <> nil) and
                   PrnColumns[i].ShowImageAndText
                then
                  Inc(tw, Trunc(PrnColumns[i].ImageList.Width * fScaleX + 4 * fScaleX + fScaleX));
                if (PrnColumns[i] = DBGridEh.VisibleColumns[0]) and
                   (DBGridEh.GetCellTreeElmentsAreaWidth > 0)
                then
                  Inc(tw, Trunc(DBGridEh.GetCellTreeElmentsAreaWidth * fScaleX + fScaleX));
              end;
            end else
            begin 
              VPrinter_Canvas.Font := PrnColumns[i].ColumnUsedFooter(PM.bmi).Font;
              if (PrintFontName <> '') then
                VPrinter_Canvas.Font.Name := PrintFontName;
              Footer := PrnColumns[i].ColumnUsedFooter(PM.bmi);
              Text := DBGridEh.GetFooterValue(Footer, PrnColumns[i]);
              AAlignment := Footer.Alignment;
              if Assigned(DBGridEh.OnGetFooterParams) then
                DBGridEh.OnGetFooterParams(DBGridEh, PrnColumns[i].Index, PM.bmi, PrnColumns[i],
                  VPrinter_Canvas.Font, NewBackgrnd, AAlignment, [], Text);
              tw := GetTextWidth(VPrinter_Canvas, Text) + PSX2 * 2;
            end;
            if tw > PrnColumnWidths[i] then
              PrnColumnWidths[i] := tw;
          end;
          SetNextPolyBookmark(PM);
        end;
      finally
        Screen.Cursor := ACursor;
        if IsDataGroupingFullPass then
          TDBGridEhCracker(DBGridEh).InstantReadRecordLeave;
      end;
      DBGridEh.DataSource.DataSet.First;
      w := 0;
      for i := 0 to PrnColumns.Count - 1 do
        Inc(w, PrnColumnWidths[i]);
      FreeRenderCanvas;
    end;

    if ([pghFitingByColWidths, pghFitGridToPageWidth] * Options = [pghFitingByColWidths, pghFitGridToPageWidth]) and
      (w > DataPrintRec.Right - DataPrintRec.Left - PenW) then
    begin
      w1 := 0;
      for i := 0 to PrnColumns.Count - 1 do
      begin
        PrnColumnWidths[i] := MulDiv(PrnColumnWidths[i], DataPrintRec.Right - DataPrintRec.Left - PenW, w);
        Inc(w1, PrnColumnWidths[i]);
      end;
      if w1 > DataPrintRec.Right - DataPrintRec.Left - PenW then
        PrnColumnWidths[PrnColumns.Count - 1] :=
          PrnColumnWidths[PrnColumns.Count - 1] -
          w1 + (DataPrintRec.Right - DataPrintRec.Left - PenW);
    end;
  end;

  procedure CalcColsToPages;
  var curX, w: Integer;
    i: Integer;
  begin
    curX := DataPrintRec.Left + PenW;
    SetLength(PrnColWIdths, 0);
    SetLength(ColsToPages, 0);
    for i := 0 to PrnColumns.Count - 1 do
    begin
      w := PrnColumnWidths[i];
      if (w > DataPrintRec.Right - DataPrintRec.Left)
        then w := DataPrintRec.Right - DataPrintRec.Left;
      SetLength(PrnColWidths, Length(PrnColWidths) + 1);
      PrnColWidths[Length(PrnColWidths)-1] := w;
      curX := curX + w;
      if (curX > DataPrintRec.Right) and (i > 0) then
      begin
        SetLength(ColsToPages, Length(ColsToPages)+1);
        ColsToPages[Length(ColsToPages)-1] := i - 1;

        curX := DataPrintRec.Left + w + PenW;
      end;
    end;
    SetLength(ColsToPages, Length(ColsToPages)+1);
    ColsToPages[Length(ColsToPages)-1] := PrnColumns.Count - 1;
  end;

  function GetScaledRealGridWidth: Integer;
  var i: Integer;
  begin
    Result := PenW;
    if DBGridEh.RowPanel.Active then
{$IFDEF CIL}
{$ELSE}
      Result := Result + Round(TDBGridEhCracker(DBGridEh).FGridMasterCellWidth * fScaleX)
{$ENDIF}
    else
      for i := 0 to PrnColumns.Count - 1 do
      begin
        Result := Result + PrnColumnWidths[i];
      end;
  end;

  function GetPrintGridWidth: Integer;
  var
    i: Integer;
  begin
    Result := 0;
    for i := 0 to Length(PrnColWidths) - 1 do
    begin
      Result := Result + PrnColWidths[i];
    end;
  end;

  procedure CheckUseRightToLeftAlignmentForRect(var Rect: TRect);
  begin
    if DBGridEh.UseRightToLeftAlignment then
      OffsetRect(Rect, (DataPrintRec.Right + DataPrintRec.Left) - (Rect.Left + Rect.Right), 0);
  end;

  {$IFDEF WINDOWS}
  procedure SetIfNeedFitWidthMapMode;
  begin
    if GridWidth > (RealRight - RealLeft) then
    begin
      VPrinter_Canvas.SetCanvasScale(RealRight - RealLeft, GridWidth, RealRight - RealLeft, GridWidth);
    end;
  end;
  {$ELSE}
  procedure SetIfNeedFitWidthMapMode;
  begin
  end;
  {$ENDIF} 

  procedure CalcFitedDataRect;
  begin
    if (pghFitGridToPageWidth in Options) then
    begin
      GridWidth := GetScaledRealGridWidth;
      RealRight := DataPrintRec.Right; RealLeft := DataPrintRec.Left;
      SetIfNeedFitWidthMapMode;

      if GridWidth > (RealRight - RealLeft) then
      begin
        DataPrintRec.Right := MulDiv(DataPrintRec.Right, GridWidth, RealRight - RealLeft);
        DataPrintRec.Left := MulDiv(DataPrintRec.Left, GridWidth, RealRight - RealLeft);
        DataPrintRec.Top := MulDiv(DataPrintRec.Top, GridWidth, RealRight - RealLeft);
        DataPrintRec.Bottom := MulDiv(DataPrintRec.Bottom, GridWidth, RealRight - RealLeft);
      end;
    end;
  end;

  function PrintPageColontitle(ARect: TRect; IsHeader, CalcHeight: Boolean): Integer;
  var pc: TPageColontitle;
    h, lm: Integer;
    Lay: TTextLayout;

    function ExtractMacro(s: STring): String;
    var i: Integer;
    begin
      Result := s;
      MacroValues[0] := IntToStr(VPrinter.PageNumber);
      for i := 0 to High(Macros) do
        Result := StringReplaceMacros(Result, Macros[i], MacroValues[i], [rfReplaceAll, rfIgnoreCase], '&');
    end;
  begin
    Result := 0; h := 0;
    if IsHeader
      then begin pc := PageHeader; Lay := tlTop; end
      else begin pc := PageFooter; Lay := tlBottom; end;

    VPrinter_Canvas.Font := pc.Font;
    if (PrintFontName <> '') then VPrinter_Canvas.Font.Name := PrintFontName;
    if (pc.LeftText.Text <> '') then
      Result := PrintTextEh(VPrinter_Canvas, ARect, 0, 0, ExtractMacro(GetStingListText(pc.LeftText)),
        taLeftJustify, Lay, False, False, ARect, CalcHeight or CalcInfoMode,
        DBGridEh.UseRightToLeftAlignment, DBGridEh.UseRightToLeftReading);
    if (pc.CenterText.Text <> '') then
      h := PrintTextEh(VPrinter_Canvas, ARect, 0, 0, ExtractMacro(GetStingListText(pc.CenterText)),
        taCenter, Lay, False, False, ARect, CalcHeight or CalcInfoMode,
        DBGridEh.UseRightToLeftAlignment, DBGridEh.UseRightToLeftReading);
    if (Result < h) then Result := h;
    if (pc.RightText.Text <> '') then
      h := PrintTextEh(VPrinter_Canvas, ARect, 0, 0, ExtractMacro(GetStingListText(pc.RightText)),
        taRightJustify, Lay, False, False, ARect, CalcHeight or CalcInfoMode,
        DBGridEh.UseRightToLeftAlignment, DBGridEh.UseRightToLeftReading);
    if (Result < h) then Result := h;

    if Result <> 0 then Inc(Result, Trunc(fLogPelsY2 / 20));

    if (pc.LineType <> pcltNon)
      then lm := Trunc(fLogPelsY2 / 20) else lm := 0;
    if (pc.LineType = pcltDoubleLine) then
    begin
      if not CalcHeight then
        if IsHeader then
        begin
          VPrinter_Canvas.MoveTo(ARect.Left, ARect.Bottom - Trunc(fLogPelsY2 / 20));
          VPrinter_Canvas.LineTo(ARect.Right, ARect.Bottom - Trunc(fLogPelsY2 / 20));
          VPrinter_Canvas.MoveTo(ARect.Left, ARect.Bottom - Trunc(fLogPelsY2 / 20) - Trunc(fLogPelsY2 / 30));
          VPrinter_Canvas.LineTo(ARect.Right, ARect.Bottom - Trunc(fLogPelsY2 / 20) - Trunc(fLogPelsY2 / 30));
        end else
        begin
          VPrinter_Canvas.MoveTo(ARect.Left, ARect.Top + Trunc(fLogPelsY2 / 20));
          VPrinter_Canvas.LineTo(ARect.Right, ARect.Top + Trunc(fLogPelsY2 / 20));
          VPrinter_Canvas.MoveTo(ARect.Left, ARect.Top + Trunc(fLogPelsY2 / 20) + Trunc(fLogPelsY2 / 30));
          VPrinter_Canvas.LineTo(ARect.Right, ARect.Top + Trunc(fLogPelsY2 / 20) + Trunc(fLogPelsY2 / 30));
        end;
      Inc(lm, Trunc(fLogPelsY2 / 30));
    end else if (pc.LineType = pcltSingleLine) then
      if not CalcHeight then
        if IsHeader then
        begin
          VPrinter_Canvas.MoveTo(ARect.Left, ARect.Bottom - Trunc(fLogPelsY2 / 20));
          VPrinter_Canvas.LineTo(ARect.Right, ARect.Bottom - Trunc(fLogPelsY2 / 20));
        end else
        begin
          VPrinter_Canvas.MoveTo(ARect.Left, ARect.Top + Trunc(fLogPelsY2 / 20));
          VPrinter_Canvas.LineTo(ARect.Right, ARect.Top + Trunc(fLogPelsY2 / 20));
        end;
    Inc(Result, lm);
  end;

  procedure SetPen;
  const
    FlatPenStyle = PS_Geometric or PS_Solid or PS_ENDCAP_SQUARE or PS_JOIN_MITER;
  var
    LogBrush: TLOGBRUSH;
  begin
    LogBrush.lbStyle := BS_Solid;
    LogBrush.lbColor := VPrinter_Canvas.Pen.Color;
    LogBrush.lbHatch := 0;
    {$IFDEF FPC}
    VPrinter_Canvas.Pen.Reference._lclHandle := ExtCreatePen(FlatPenStyle, VPrinter_Canvas.Pen.Width, LogBrush, 0, nil);
    {$ELSE}
    VPrinter_Canvas.Pen.Handle := ExtCreatePen(FlatPenStyle, VPrinter_Canvas.Pen.Width, LogBrush, 0, nil);
    {$ENDIF}
  end;

  procedure ResetPrinterCanvas;
  begin
    VPrinter_Canvas.Pen.Width := PenW;
    VPrinter_Canvas.BRUSH.Style := bsClear;
    SetPen;
    VPrinter_Canvas.Brush.Color := clWhite;
    VPrinter_Canvas.Font := DBGridEh.Font;
    if (pghFitGridToPageWidth in Options) then
      SetIfNeedFitWidthMapMode;
  end;

  procedure VPrinter_NewPage;
  begin
    if CalcInfoMode then
    begin
      Inc(PageCount);
      ResetPrinterCanvas;
    end else
    begin
      VPrinter.NewPage;
      VPrinter_Canvas := VPrinter.Canvas;
      ResetPrinterCanvas;
      PrintPageColontitle(TitleRect, True, False);
      PrintPageColontitle(FooterRect, False, False);
    end;
  end;

  procedure CalcDeviceCaps;
  var
    Diver: Double;
  begin
    fPrnPhysOffSetX := (VPrinter.FullPageWidth - VPrinter.PageWidth) div 2;
    fPrnPhysOffSetY := (VPrinter.FullPageHeight - VPrinter.PageHeight) div 2;

    fPrnHorsRes := VPrinter.PageWidth;
    fPrnVertRes := VPrinter.PageHeight;

    fLogPelsX1 := GetDeviceCaps(DBGridEh.Canvas.Handle, LOGPIXELSX);
    fLogPelsY1 := GetDeviceCaps(DBGridEh.Canvas.Handle, LOGPIXELSY);

    if VPrinter.Printers.Count > 0 then
    begin
      {$IFDEF FPC}
      fLogPelsX2 := VPrinter.PixelsPerInchX;
      fLogPelsY2 := VPrinter.PixelsPerInchY;
      {$ELSE}
      fLogPelsX2 := VPrinter.PixelsPerInchX;
      fLogPelsY2 := VPrinter.PixelsPerInchY;
      {$ENDIF}
    end else begin
      {$IFDEF FPC}
      fLogPelsX2 := 600;
      fLogPelsY2 := 600;
      {$ELSE}
      fLogPelsX2 := DefaultPrinterPixelsPerInchX;
      fLogPelsY2 := DefaultPrinterPixelsPerInchY;
      {$ENDIF}
    end;

    if (fLogPelsX1 > fLogPelsX2) then
      fScaleX := (fLogPelsX1 / fLogPelsX2)
    else
      fScaleX := (fLogPelsX2 / fLogPelsX1);

    if (fLogPelsY1 > fLogPelsY2) then
      fScaleY := (fLogPelsY1 / fLogPelsY2)
    else
      fScaleY := (fLogPelsY2 / fLogPelsY1);

    if Units = MM then Diver := 2.54 else Diver := 1;
    DataPrintRec.Left := Round(fLogPelsX2 * Page.LeftMargin / Diver) - fPrnPhysOffSetX;
    DataPrintRec.Top := Round(fLogPelsY2 * Page.TopMargin / Diver) - fPrnPhysOffSetY;
    DataPrintRec.Right := fPrnHorsRes - Round(fLogPelsX2 * Page.RightMargin / Diver) + fPrnPhysOffSetX;
    DataPrintRec.Bottom := fPrnVertRes - Round(fLogPelsY2 * Page.BottomMargin / Diver) + fPrnPhysOffSetY;

    PSX1 := Round(fScaleX); PSX2 := Round(fScaleX * 2);

    if DBGridEh.Flat then
    begin
      PSY1 := Round(fScaleY / 2); PSY2 := Round(fScaleY)
    end else
    begin
      PSY1 := Round(fScaleY); PSY2 := Round(fScaleY * 2);
    end;

    PenW := Trunc((fLogPelsX2 + fLogPelsY2) / 200); 
    TreeBlockScreenWidth := Round(18 * DBGridEh.ScaleFactor);
  end;

  function GetFooterValue(Row, Col: Integer): String;
  var
    FmtStr: string;
    Format: TFloatFormat;
    Digits: Integer;
    v: Variant;
    Field: TField;
    Footer: TColumnFooterEh;
    inf: TIntegerField;
    bcf: TBCDField;
    fbcf: TFMTBCDField;
    ff: TFloatField;
  begin
    Result := '';
    Footer := PrnColumns[Col].ColumnUsedFooter(Row);
    case Footer.ValueType of
      fvtSum:
        begin
          if Footer.FieldName <> '' then
            Field := DBGridEh.DataSource.DataSet.FindField(Footer.FieldName)
          else
            Field := DBGridEh.DataSource.DataSet.FindField(PrnColumns[Col].FieldName);
          if Field = nil then Exit;
          v := FooterValues[Row * PrnColumns.Count + Col];
          case Field.DataType of
            ftSmallint, ftInteger, ftAutoInc, ftWord:
              if Footer.DisplayFormat <> '' then
                Result := FormatFloat(Footer.DisplayFormat, v)
              else
              begin
                inf := Field as TIntegerField;
                FmtStr := inf.DisplayFormat;
                if FmtStr = ''
                  then Result := IntToStr(Integer(v))
                  else Result := FormatFloat(FmtStr, v);
              end;
            ftBCD:
              if Footer.DisplayFormat <> '' then
                Result := FormatFloat(Footer.DisplayFormat, v)
              else
              begin
                bcf := Field as TBCDField;
                FmtStr := bcf.DisplayFormat;
                if FmtStr = '' then
                begin
                  if bcf.Currency then
                  begin
                    Format := ffCurrency;
                    Digits := FormatSettings.CurrencyDecimals;
                  end
                  else
                  begin
                    Format := ffGeneral;
                    Digits := 0;
                  end;
                  Result := CurrToStrF(v, Format, Digits);
                end else
                  Result := FormatCurr(FmtStr, v);
              end;
            ftFMTBcd:
              if Footer.DisplayFormat <> '' then
                Result := FormatFloat(Footer.DisplayFormat, v)
              else
              begin
                fbcf := Field as TFMTBCDField;
                FmtStr := fbcf.DisplayFormat;
                if FmtStr = '' then
                begin
                  if fbcf.Currency then
                  begin
                    Format := ffCurrency;
                    Digits := FormatSettings.CurrencyDecimals;
                  end
                  else
                  begin
                    Format := ffGeneral;
                    Digits := 0;
                  end;
                  Result := CurrToStrF(v, Format, Digits);
                end else
                  Result := FormatCurr(FmtStr, v);
              end;
            ftFloat, ftCurrency:
              if Footer.DisplayFormat <> '' then
                Result := FormatFloat(Footer.DisplayFormat, v)
              else
              begin
                ff := Field as TFloatField;
                FmtStr := ff.DisplayFormat;
                if FmtStr = '' then
                begin
                  if ff.Currency then
                  begin
                    Format := ffCurrency;
                    Digits := FormatSettings.CurrencyDecimals;
                  end
                  else begin
                    Format := ffGeneral;
                    Digits := 0;
                  end;
                  Result := FloatToStrF(Double(v), Format, ff.Precision, Digits);
                end else
                  Result := FormatFloat(FmtStr, v);
              end;
          end;
        end;
      fvtCount:
        if Footer.DisplayFormat <> '' then
          Result := FormatFloat(Footer.DisplayFormat, FooterValues[Row * PrnColumns.Count + Col])
        else
          Result := FloatToStr(FooterValues[Row * PrnColumns.Count + Col]);
    end;
  end;

  function CheckColumnDuplicateValues(Column: TColumnEh; DataRow: Integer; s: String): Boolean;
  var
    ABackground: TColor;
    AIndex: Integer;
    ccp: TColCellParamsEh;
  begin
    Result := False;

    Column.FillColCellParams(FVarColCellParamsEh);
    ccp := FVarColCellParamsEh;
    ccp.Col := Column.Index + DBGridEh.IndicatorOffset;
    ccp.Row := DataRow;
    ABackground := ccp.Background;
    if Assigned(DBGridEh.OnGetCellParams) then
      DBGridEh.OnGetCellParams(DBGridEh, Column, ccp.Font, ABackground, ccp.State);
    Column.GetColCellParams(False, ccp);
    AIndex := FLastRowTexts.IndexOfObject(Column);
    if (AIndex >= 0) and (FLastRowTexts[AIndex] = ccp.Text) then
      Result := True;
  end;

  function DrawCell(ACol: Integer; ARect: TRect; var APBmFrom: TPolyBookmark;
    CalcRect: Boolean; DataPageRow: Integer): Integer;
  var
    CurColumn: TColumnEh;
    NewBackgrnd: TColor;
    AAlignment: TAlignment;
    Value: String;
    ARect1: TRect;
    ABackground: TColor;
    Stretch: Boolean;
    Footer: TColumnFooterEh;
    AIndex: Integer;
    AOldText: String;
    FooterColumnItem: TGridDataGroupFooterColumnItemEh;
    FooterNode: TGroupDataTreeNodeEh;
    VarValue: Variant;
    bfi: Integer;
    ccp: TPrintColCellParamsEh;
    Processed: Boolean;
  begin
    Result := 0;
    CurColumn := PrnColumns[ACol];
    NewBackgrnd := clWhite;
    ARect1 := ARect;
    Inc(ARect.Left, PSX2); Inc(ARect.Top, PSY2);
    Dec(ARect.Right, PSX2); Dec(ARect.Bottom, PSY2);
    if CalcRect
      then Stretch := pghRowAutoStretch in Options
      else Stretch := AWordWrap;
    if DBGridEh.RowPanel.Active then
      Stretch := CurColumn.WordWrap and (CurColumn.InRowLineHeight > 1);

    if APBmFrom.InDS then
    begin
      if DBGridEh.RowPanel.Active and CalcRect then
      begin
{$IFDEF CIL}
{$ELSE}
        Result := Round(TDBGridEhCracker(DBGridEh).FGridMasterCellHeight * fScaleX);
{$ENDIF}
        Exit;
      end;

      if pghColored in Options then
        NewBackgrnd := CurColumn.Color;

      VPrinter_Canvas.Font := CurColumn.Font;
      if (PrintFontName <> '') then VPrinter_Canvas.Font.Name := PrintFontName;

      CurColumn.FillColCellParams(FColCellParamsEh);

      FColCellParamsEh.ScaleX := fScaleX;
      FColCellParamsEh.ScaleY := fScaleY;
      FColCellParamsEh.CalcInfoMode := CalcInfoMode;
      FColCellParamsEh.Stretch := Stretch;
      FColCellParamsEh.GridWidth := GridWidth;
      FColCellParamsEh.RealRight := RealRight;
      FColCellParamsEh.RealLeft := RealLeft;
      FColCellParamsEh.TreeBlockScreenWidth := TreeBlockScreenWidth;

      ccp := FColCellParamsEh;
      ccp.Font := VPrinter_Canvas.Font;
      ABackground := NewBackgrnd;
      if Assigned(DBGridEh.OnGetCellParams) then
        DBGridEh.OnGetCellParams(DBGridEh, CurColumn, ccp.Font, ABackground, ccp.State);
      ccp.Background := ABackground;

      CurColumn.GetColCellParams(False, FColCellParamsEh);
      VPrinter_Canvas.Brush.Color := FColCellParamsEh.Background;

      if not CalcRect and CurColumn.HideDuplicates then
      begin
        AOldText := FColCellParamsEh.Text;
        if (DataPageRow <> 0) and
          CheckColumnDuplicateValues(CurColumn, DataPageRow, FColCellParamsEh.Text) then
        begin
          FColCellParamsEh.Text := '';
          FColCellParamsEh.ImageIndex := -1;
        end;
        AIndex := FLastRowTexts.IndexOfObject(CurColumn);
        if (AIndex < 0)
          then FLastRowTexts.AddObject(AOldText, CurColumn)
          else FLastRowTexts[AIndex] := AOldText;
      end;

      if not CalcRect and (VPrinter_Canvas.Brush.Color <> clWhite) and not CalcInfoMode then
      begin
        VPrinter_Canvas.FillRect(ARect1);
      end;

      Processed := False;
      if Assigned(OnPrintDataCell) and (not CalcRect) then
      begin
        OnPrintDataCell(Self, VPrinter, CurColumn, ARect, FColCellParamsEh, Processed);
      end;

      if (not Processed) then
        Result := DefaultPrintDataCell(VPrinter, CurColumn, ARect, CalcRect, FColCellParamsEh);
    end else
    begin 
      if APBmFrom.bmi < 0 then Exit;
      if IsDataGroupingFullPass and
         (APBmFrom.bmi < DBGridEh.DataGrouping.Footers.VisibleItemsCount) then
      begin
        FooterNode := DBGridEh.DataGrouping.GroupDataTree.Root;
        FooterColumnItem :=
          FooterNode.FooterItems[APBmFrom.bmi].DataGroupFooter.ColumnItems[CurColumn.Index];
        if pghColored in Options then
          VPrinter_Canvas.Brush.Color := FooterColumnItem.Color;
        VPrinter_Canvas.Font := FooterColumnItem.Font;
        if (PrintFontName <> '') then
          VPrinter_Canvas.Font.Name := PrintFontName;

        VarValue := Null;
        if TDBGridEhCracker(DBGridEh).DataLink.Active then
          VarValue := FooterNode.FooterItems[APBmFrom.bmi].FooterValues[CurColumn.Index];
        Value := FooterColumnItem.ConvertToDisplayText(VarValue);

        if not (CalcRect or CalcInfoMode) and
           (pghColored in Options) then
        begin
          VPrinter_Canvas.FillRect(ARect1);
        end;

        Result := PrintTextEh(VPrinter_Canvas, ARect, 0, 0, Value,
          FooterColumnItem.Alignment, CurColumn.Layout, False, False, ARect,
          CalcRect or CalcInfoMode, CurColumn.UseRightToLeftAlignment, DBGridEh.UseRightToLeftReading) + PSY2 * 2;
      end else
      begin
        bfi := APBmFrom.bmi;
        if bfi < 0 then Exit;
        Footer := CurColumn.ColumnUsedFooter(bfi);
        AAlignment := Footer.Alignment;
        if (Footer.ValueType in [fvtSum, fvtCount]) and
           not DBGridEh.DataGrouping.Active
        then
          Value := GetFooterValue(bfi, ACol)
        else
          Value := DBGridEh.GetFooterValue(Footer, CurColumn);

        if pghColored in Options then
          NewBackgrnd := Footer.Color;
        VPrinter_Canvas.Font := Footer.Font;
        if (PrintFontName <> '') then
          VPrinter_Canvas.Font.Name := PrintFontName;

        if Assigned(DBGridEh.OnGetFooterParams) then
          DBGridEh.OnGetFooterParams(DBGridEh, CurColumn.Index, bfi,
            CurColumn, VPrinter_Canvas.Font, NewBackgrnd, AAlignment, [], Value);
        VPrinter_Canvas.Brush.Color := NewBackgrnd;

        if not CalcRect and (VPrinter_Canvas.Brush.Color <> clWhite) and not CalcInfoMode then
        begin
          VPrinter_Canvas.FillRect(ARect1);
        end;

        if not (CalcRect or CalcInfoMode) and
           (pghColored in Options) then
        begin
          VPrinter_Canvas.FillRect(ARect);
        end;


        Result := PrintTextEh(VPrinter_Canvas, ARect, 0, 0, Value,
          AAlignment, CurColumn.Layout, Stretch, Footer.EndEllipsis, ARect,
          CalcRect or CalcInfoMode, CurColumn.UseRightToLeftAlignment,
          DBGridEh.UseRightToLeftReading) + PSY2 * 2;
      end;
    end;
  end;

  function DrawGroupFooterCellData(ACol: Integer; ARect: TRect; var APBmFrom: TPolyBookmark;
    CalcRect: Boolean; DataPageRow: Integer; FooterNode: TGroupDataTreeNodeEh): Integer;
  var
    CurColumn: TColumnEh;
    Value: string;
    VarValue: Variant;
    FooterColumnItem: TGridDataGroupFooterColumnItemEh;
    ATextRect: TRect;
  begin
    ATextRect := ARect;
    Inc(ATextRect.Left, PSX2); Inc(ATextRect.Top, PSY2);
    Dec(ATextRect.Right, PSX2); Dec(ATextRect.Bottom, PSY2);
    CurColumn := PrnColumns[ACol];
    FooterColumnItem := FooterNode.DataGroupFooter.ColumnItems[CurColumn.Index];
    VarValue := FooterNode.FooterValues[CurColumn.Index];
    Value := FooterColumnItem.ConvertToDisplayText(VarValue);
    VPrinter_Canvas.Font := FooterColumnItem.Font;

    if not (CalcRect or CalcInfoMode) and
       (pghColored in Options) then
    begin
      VPrinter_Canvas.Brush.Color := FooterColumnItem.Color;
      VPrinter_Canvas.FillRect(ARect);
    end;


    Result := PrintTextEh(VPrinter_Canvas, ATextRect, 0, 0, Value,
      FooterColumnItem.Alignment, CurColumn.Layout, False, False, ATextRect,
      CalcRect or CalcInfoMode, CurColumn.UseRightToLeftAlignment, DBGridEh.UseRightToLeftReading) + PSY2 * 2;
  end;

  function DrawGroupFooterCell(ACol: Integer; ARect: TRect; var APBmFrom: TPolyBookmark;
    CalcRect: Boolean; DataPageRow: Integer): Integer;
  var
    ADrawGroupDataNode: TGroupDataTreeNodeEh;
  begin
    ADrawGroupDataNode := DBGridEh.DataGrouping.GroupDataTree.FlatVisibleItem[APBmFrom.RecNo];
    Result := DrawGroupFooterCellData(ACol, ARect, APBmFrom, CalcRect, DataPageRow, ADrawGroupDataNode);
  end;

  function DrawGroupDataCell(FromCol, ToCol: Integer; ARect: TRect;
    var APBmFrom: TPolyBookmark; CalcRect: Boolean; DataPageRow: Integer): Integer;
  var
    ADrawGroupDataNode: TGroupDataTreeNodeEh;
    FooterNode: TGroupDataTreeNodeEh;
    NextLevel: Integer;
    i: Integer;
    ARect1, BoundRect, DrawRect, r: TRect;
    TreeElement: TTreeElementEh;
    LeftBackIndent: Integer;
    Footer: TGridDataGroupFooterEh;
    GroupLevel: TGridDataGroupLevelEh;
    StopGroupRowCol: Integer;
    ACellRect: TRect;
    ARowHeight: Integer;
    AClipRect: TRect;
    ATextDrawRect: TRect;
  begin
    Result := 0;
    Footer := nil;

    if IsDataGroupingFullPass
      then ADrawGroupDataNode := DBGridEh.DataGrouping.GroupDataTree.FlatVisibleItem[APBmFrom.RecNo]
      else ADrawGroupDataNode := nil;

    if (ADrawGroupDataNode <> nil) and
       (ADrawGroupDataNode.NodeType = dntDataGroupEh) then
    begin
      LeftBackIndent := 0;
      GroupLevel := ADrawGroupDataNode.DataGroupLevel;
      if GroupLevel.FooterInGroupRow and (GroupLevel.VisibleFootersCount > 0) then
        Footer := GroupLevel.VisibleFooter[0];
      ARect1 := ARect;
      DrawRect := ARect;
      if not CalcRect then
      begin
        r := ARect1;
        CheckUseRightToLeftAlignmentForRect(r);
        AddPolyline([r.Left, r.Top,
                     r.Left, r.Bottom]);
        if FromCol > 0 then
        begin
          for i := 0 to FromCol-1 do
            Inc(LeftBackIndent, PrnColWIdths[i]);
          Dec(LeftBackIndent, Trunc((ADrawGroupDataNode.Level) * TreeBlockScreenWidth * fScaleX));
          DrawRect := ARect;
        end else
        begin
          if ADrawGroupDataNode.Level > 1 then
          begin
            ARect1.Right := ARect1.Left + Trunc((ADrawGroupDataNode.Level-1) * TreeBlockScreenWidth * fScaleX);
            if DBGridEh.DataGrouping.GroupDataTree.FlatVisibleCount - 1 > APBmFrom.RecNo
              then NextLevel := DBGridEh.DataGrouping.GroupDataTree.FlatVisibleItem[APBmFrom.RecNo+1].Level
              else NextLevel := 0;
            for i := 0 to ADrawGroupDataNode.Level - 2 do
            begin
              BoundRect := Rect(ARect1.Right-Trunc((i*TreeBlockScreenWidth)*fScaleX), ARect1.Top,
                                ARect1.Right-Trunc((i*TreeBlockScreenWidth)*fScaleX), ARect1.Bottom);
              CheckUseRightToLeftAlignmentForRect(BoundRect);
              AddPolyline([BoundRect.Left, BoundRect.Top,
                           BoundRect.Left, BoundRect.Bottom]);
              if NextLevel + i < ADrawGroupDataNode.Level then
              begin
                BoundRect := Rect(ARect1.Right-Trunc((i*TreeBlockScreenWidth)*fScaleX), ARect1.Bottom,
                                  ARect1.Right-Trunc((i*TreeBlockScreenWidth+TreeBlockScreenWidth)*fScaleX), ARect1.Bottom);
                CheckUseRightToLeftAlignmentForRect(BoundRect);
                AddPolyline([BoundRect.Left, BoundRect.Bottom,
                             BoundRect.Right, BoundRect.Bottom]);
              end;
            end;
            ARect1.Left := ARect1.Right;
          end;

          ARect1.Right := ARect1.Left + Trunc(TreeBlockScreenWidth * fScaleX);
          DrawRect := ARect;
          DrawRect.Left := ARect1.Right;
          if ADrawGroupDataNode.Expanded
            then TreeElement := tehMinus
            else TreeElement := tehPlus;

          CheckUseRightToLeftAlignmentForRect(ARect1);

          if not (CalcRect or CalcInfoMode) and
             (pghColored in Options) then
          begin
            VPrinter_Canvas.Brush.Color := CheckSysColor(ADrawGroupDataNode.DataGroupLevel.Color);
            VPrinter_Canvas.FillRect(ARect1);
          end;

          PrintTreeElement(VPrinter_Canvas, ARect1, TreeElement, True,
            fScaleX, fScaleY, DBGridEh.UseRightToLeftAlignment, pghColored in Options);
          if not ADrawGroupDataNode.Expanded then
              AddPolyline([ARect1.Left, ARect1.Bottom,
                           ARect1.Right, ARect1.Bottom]);
        end;
      end;

      StopGroupRowCol := ToCol+1;
      for i := 0 to FromCol-1 do
      begin
        if(Footer <> nil) and
          (DBGridEh.VisibleColumns[0].Index <> PrnColumns[i].Index) and
          (Footer.ColumnItems[PrnColumns[i].Index].ValueType <> gfvNonEh) then
        begin
          StopGroupRowCol := i;
          Break;
        end
      end;
      ACellRect := ARect;
      for i := FromCol to ToCol do
      begin
        ACellRect.Right :=  ACellRect.Left + PrnColWIdths[i];

        if (StopGroupRowCol <> ToCol+1) or
           ((Footer <> nil) and
            (DBGridEh.VisibleColumns[0].Index <> PrnColumns[i].Index) and
            (Footer.ColumnItems[PrnColumns[i].Index].ValueType <> gfvNonEh)) then
        begin
          if StopGroupRowCol = ToCol + 1 then
            StopGroupRowCol := i;
          FooterNode := ADrawGroupDataNode.FooterItems[0];
          ARowHeight := DrawGroupFooterCellData(i, ACellRect, APBmFrom, CalcRect, -1, FooterNode);
          if ARowHeight > Result then
            Result := ARowHeight;
          if not CalcRect then
          begin
            AddPolyline([ACellRect.Left, ACellRect.Bottom,
                         ACellRect.Right, ACellRect.Bottom]);
            if i = ToCol then
              AddPolyline([ACellRect.Right, ACellRect.Top,
                           ACellRect.Right, ACellRect.Bottom]);
          end;
        end else if i > FromCol then
          Inc(DrawRect.Right, PrnColWIdths[i]);

        ACellRect.Left := ACellRect.Right;
      end;

      if StopGroupRowCol > FromCol then
      begin
        DBGridEh.FillDataGroupRowParams(ADrawGroupDataNode, [], 0, 0, FGroupRowParams);
        VPrinter_Canvas.Font := FGroupRowParams.Font;
        CheckUseRightToLeftAlignmentForRect(DrawRect);

        if not (CalcRect or CalcInfoMode) and
           (pghColored in Options) then
        begin
          VPrinter_Canvas.Brush.Color := FGroupRowParams.Color;
          VPrinter_Canvas.FillRect(DrawRect);
        end;

        AClipRect := DrawRect;
        ATextDrawRect := DrawRect;
        ATextDrawRect.Left := ATextDrawRect.Left - LeftBackIndent;

        ARowHeight := PrintTextEh(VPrinter_Canvas, ATextDrawRect, 0, 0, FGroupRowParams.GroupRowText,
          taLeftJustify, tlTop, False, False, AClipRect,
          CalcRect or CalcInfoMode, DBGridEh.UseRightToLeftAlignment, DBGridEh.UseRightToLeftReading) + PSY2 * 2;

        if ARowHeight > Result then
          Result := ARowHeight;

        if not CalcRect then
        begin
          AddPolyline([DrawRect.Left, DrawRect.Bottom,
                       DrawRect.Right, DrawRect.Bottom]);
          AddPolyline([DrawRect.Right, DrawRect.Top,
                       DrawRect.Right, DrawRect.Bottom]);
        end;
      end;
    end;
  end;

  procedure DrawGroupDataArea(DataCol, DataRow: Integer; var APBmFrom: TPolyBookmark;
    NodeLevel: Integer; ARect: TRect);
  var
    NextLevel: Integer;
    i: Integer;
    BoundRect: TRect;
    AFillRect: TRect;
  begin
    if DBGridEh.DataGrouping.GroupDataTree.FlatVisibleCount - 1 > APBmFrom.RecNo
      then NextLevel := DBGridEh.DataGrouping.GroupDataTree.FlatVisibleItem[APBmFrom.RecNo+1].Level
      else NextLevel := 0;

    for i := 0 to NodeLevel - 2 do
    begin
      BoundRect := Rect(ARect.Left+Trunc((DBGridEh.FExtraFirstColumnWidth-i*TreeBlockScreenWidth)*fScaleX), ARect.Top,
                        ARect.Left+Trunc((DBGridEh.FExtraFirstColumnWidth-i*TreeBlockScreenWidth)*fScaleX), ARect.Bottom);
      AFillRect := Rect(ARect.Left+Trunc((DBGridEh.FExtraFirstColumnWidth-i*TreeBlockScreenWidth-TreeBlockScreenWidth)*fScaleX), ARect.Top,
                        ARect.Left+Trunc((DBGridEh.FExtraFirstColumnWidth-i*TreeBlockScreenWidth)*fScaleX), ARect.Bottom);

      CheckUseRightToLeftAlignmentForRect(BoundRect);

      if not (CalcInfoMode) and (pghColored in Options) then
      begin
        VPrinter_Canvas.Brush.Color := CheckSysColor(DBGridEh.DataGrouping.ActiveGroupLevels[NodeLevel-2-i].Color);
        VPrinter_Canvas.FillRect(AFillRect);
      end;

      AddPolyline([BoundRect.Left, BoundRect.Top,
                   BoundRect.Left, BoundRect.Bottom]);
      if NextLevel + i < NodeLevel then
      begin
        BoundRect := Rect(ARect.Left+Trunc((TDBGridEhCracker(DBGridEh).FExtraFirstColumnWidth-i*TreeBlockScreenWidth)*fScaleX), ARect.Bottom,
                          ARect.Left+Trunc((TDBGridEhCracker(DBGridEh).FExtraFirstColumnWidth-i*TreeBlockScreenWidth-TreeBlockScreenWidth)*fScaleX), ARect.Bottom);
        CheckUseRightToLeftAlignmentForRect(BoundRect);
        AddPolyline([BoundRect.Left, BoundRect.Bottom,
                     BoundRect.Right, BoundRect.Bottom]);
      end;
    end;
  end;

  procedure CalcFooterValues;
  var i, j: Integer;
    Field: TField;
    Footer: TColumnFooterEh;
  begin
    for i := 0 to DBGridEh.FooterRowCount + DBGridEh.DataGrouping.Footers.Count - 1 do
      for j := 0 to PrnColumns.Count - 1 do
      begin
        Footer := PrnColumns[j].ColumnUsedFooter(i);
        if Footer.FieldName <> ''
          then Field := DBGridEh.DataSource.DataSet.FindField(Footer.FieldName)
          else Field := DBGridEh.DataSource.DataSet.FindField(PrnColumns[j].FieldName);
        if Field = nil then Continue;
        case Footer.ValueType of
          fvtSum:
            if (Field.IsNull = False) then
              FooterValues[i * PrnColumns.Count + j] := FooterValues[i * PrnColumns.Count + j] + Field.AsFloat;
          fvtCount:
            FooterValues[i * PrnColumns.Count + j] := FooterValues[i * PrnColumns.Count + j] + 1;
        end;
      end;
  end;

  function CalcPrintRows(APBmFrom: TPolyBookmark; PrnTop, PrnBottom: Integer): TPolyBookmark;
  var
    i, rh, ch, cPos, hLimit, AStep: Integer;
    r: TRect;
  begin
    SetLength(PrnRowHeights, 0);
    GotoPolyBookmark(APBmFrom);
    try
    Result := APBmFrom;
    cPos := PrnTop;
    hLimit := PrnBottom;
    AStep := 0;
    while True do
    begin
      ch := 0;
      for i := 0 to PrnColumns.Count - 1 do
      begin
        SetRect(r, 0, 0, 0, 0);
        r.Right := PrnColWIdths[i];
        rh := 0;
        if APBmFrom.InDS and
           IsDataGroupingFullPass and
           (APBmFrom.PrnRowType in [prtGroupHeaderRowEh, prtGroupFooterEh])
        then
        begin
          if APBmFrom.PrnRowType = prtGroupHeaderRowEh then
            rh := DrawGroupDataCell(i, i, r, APBmFrom, True, 0)
          else if APBmFrom.PrnRowType = prtGroupFooterEh then
            rh := DrawGroupFooterCell(i, r, APBmFrom, True, -1);
        end else
          rh := DrawCell(i, r, APBmFrom, True, -1);
        if ch < rh then ch := rh;
      end;

      if ch < MinRowHeight then ch := MinRowHeight;
      Inc(cPos, ch);
      if ((cPos > hLimit) or APBmFrom.EOF) and (AStep <> 0) then
      begin
        Result := APBmFrom;
        Exit;
      end;
      if APBmFrom.InDS then CalcFooterValues;
      Result := APBmFrom;
      SetNextPolyBookmark(APBmFrom);
      SetLength(PrnRowHeights, Length(PrnRowHeights)+1);
      if cPos > hLimit then
        ch := ch - (cPos - hLimit);
      PrnRowHeights[Length(PrnRowHeights)-1] := ch;
      Inc(AStep);
    end;
    finally
      if IsDataGroupingFullPass then
        TDBGridEhCracker(DBGridEh).InstantReadRecordLeave;
    end;
  end;

  procedure PrintGridTitleTextHeight(FromCol, ToCol: Integer);
  var
    r: TRect;
    i, lm, rm, tm: Integer;
    ATextDrawRect: TRect;
    AClipRect: TRect;
  begin
    r := Rect(DataPrintRec.Left,
              DataPrintRec.Top - PrnTitlEh - PrnTitleTextH + PrintOffset,
              DataPrintRec.Left,
              DataPrintRec.Top - PrnTitlEh + PrintOffset);

    if DBGridEh.RowPanel.Active then
{$IFDEF CIL}
{$ELSE}
      Inc(r.Right, Round(TDBGridEhCracker(DBGridEh).FGridMasterCellWidth * fScaleX))
{$ENDIF}
    else
      for i := FromCol to ToCol do Inc(r.Right, PrnColWidths[i]);

    if (Title.Text <> '') then
    begin
      VPrinter_Canvas.Font := DBGridEh.TitleFont;
      if (PrintFontName <> '') then
        VPrinter_Canvas.Font.Name := PrintFontName;
      r := Rect(DataPrintRec.Left, DataPrintRec.Top - PrnTitlEh - PrnTitleTextH + PrintOffset, r.Right, DataPrintRec.Top - PrnTitlEh + PrintOffset);
      lm := PSX2;
      rm := PSX2;
      for i := 0 to FromCol - 1 do
        Dec(lm, PrnColWidths[i]);
      for i := ToCol + 1 to PrnColumns.Count - 1 do
        Dec(rm, PrnColWidths[i]);
      if DBGridEh.UseMultiTitle then
        tm := Round(DBGridEh.VTitleMargin * fScaleY / 2) else tm := PSY2;
      if pghColored in Options then
        VPrinter_Canvas.Brush.Color := DBGridEh.FixedColor;
      if DBGridEh.UseRightToLeftAlignment then
        OffsetRect(r, (DataPrintRec.Right + DataPrintRec.Left) - (r.Left + r.Right), 0);

      if (pghColored in Options) and not CalcInfoMode then
        VPrinter_Canvas.FillRect(r);

      ATextDrawRect := r;
      AClipRect := r;

      ATextDrawRect.Left := ATextDrawRect.Left + lm;
      ATextDrawRect.Right := ATextDrawRect.Right - rm;

      PrintTextEh(VPrinter_Canvas, ATextDrawRect, 0, tm, GetStingListText(Title),
        taCenter, tlTop, True, False, AClipRect, CalcInfoMode,
        DBGridEh.UseRightToLeftAlignment, DBGridEh.UseRightToLeftReading);
      AddPolyline([r.Left, r.Bottom, r.Left, r.Top, r.Right, r.Top, r.Right, r.Bottom]);
    end;
  end;

  procedure PrintSimpleTitle(FromCol, ToCol: Integer);
  var
    r, r1: TRect;
    i: Integer;
    s: String;
    WordWrap: Boolean;
    Layout: TTextLayout;
  begin
    r := Rect(DataPrintRec.Left, DataPrintRec.Top - PrnTitlEh + PrintOffset, DataPrintRec.Left, DataPrintRec.Top + PrintOffset);

    for i := FromCol to ToCol do
    begin
      Inc(r.Right, PrnColWidths[i]);
      VPrinter_Canvas.Font := PrnColumns[i].Title.Font;
      if (PrintFontName <> '') then
        VPrinter_Canvas.Font.Name := PrintFontName;
      if pghColored in Options then
        VPrinter_Canvas.Brush.Color := DBGridEh.FixedColor;
      if (DBGridEh.TitleImages <> nil) and
        (PrnColumns[i].Title.ImageIndex <> -1)
        then s := ''
        else s := PrnColumns[i].Title.Caption;
      r1 := r;
      if DBGridEh.UseRightToLeftAlignment then
        OffsetRect(r1, (DataPrintRec.Right + DataPrintRec.Left) - (r1.Left + r1.Right), 0);

      WordWrap := (DBGridEh.TitleHeight <> 0) or (DBGridEh.TitleLines <> 0);
      if WordWrap
        then Layout := tlCenter
        else Layout := tlTop;

      if PrnColumns[i].Title.Orientation = tohVertical then
      begin
        PrintTextVerticalEh(VPrinter_Canvas, r1, PSX2 * 2, PSY2,
          s, taLeftJustify, tlCenter, True, False, CalcInfoMode);
      end else
      begin
        if (pghColored in Options) and not CalcInfoMode then
          VPrinter_Canvas.FillRect(r1);
        PrintTextEh(VPrinter_Canvas, r1, PSX2, PSY2, s,
          PrnColumns[i].Title.Alignment, Layout, WordWrap,
          PrnColumns[i].Title.EndEllipsis, r1, CalcInfoMode,
          DBGridEh.UseRightToLeftAlignment, DBGridEh.UseRightToLeftReading);
      end;

      if (DBGridEh.TitleImages <> nil) and
         (PrnColumns[i].Title.ImageIndex <> -1) then
      begin
        DrawClipped(DBGridEh.TitleImages, PrnColumns[i].Title.ImageIndex,
          VPrinter_Canvas, r1, r1, taCenter, taVerticalCenter,
          fScaleX, fScaleY);
      end;

      AddPolyline([r1.Left, r1.Bottom, r1.Right, r1.Bottom, r1.Right, r1.Top]);
      r.Left := r.Right;
    end;
    r.Left := DataPrintRec.Left;

    r1 := r;
    if DBGridEh.UseRightToLeftAlignment then
      OffsetRect(r1, (DataPrintRec.Right + DataPrintRec.Left) - (r1.Left + r1.Right), 0);

    AddPolyline([r1.Left, r1.Bottom, r1.Left, r1.Top, r1.Right, r1.Top]);
    PrintGridTitleTextHeight(FromCol, ToCol);
  end;

  procedure PrintMultyTitle(FromCol, ToCol: Integer);
  var
    i, RightSide: Integer;
    r, r1: TRect;
    s: String;
    PLeftTop, PRightTop, PRightLow: TPoint;
    ATextRect: TRect;

    function GetColNumByVisColNum(AVisColNum: Integer): Integer;
    begin
      Result := PrnColumns[AVisColNum].Index;
    end;

    procedure PrintTitleRecurs(ANode: TDBGridMultiTitleNodeEh; ARect: TRect);
    var
      r, r1: TRect;
      s: String;
      lx, rx, xx: Integer;
      an, nn: TDBGridMultiTitleNodeEh;
      AClipRect: TRect;
      ATextDrawRect: TRect;
    begin
      if (ANode.Parent.Parent = nil) then Exit;
      s := ANode.Parent.Text;
      lx := -(ARect.Left - DataPrintRec.Left);
      r.Bottom := ARect.Top;
      r.Top := r.Bottom - ANode.Parent.HeightPrn;
      an := ANode; nn := ANode.Parent.FirstChild;
      while an <> nn do 
      begin
        Inc(lx, nn.WidthPrn);
        nn := nn.NextSibling;
      end;
      if (lx > 0) then
      begin
        r.Left := DataPrintRec.Left;
        xx := ANode.Parent.WidthPrn - lx + DataPrintRec.Left;
      end else
      begin
        r.Left := ARect.Left;
        xx := ANode.Parent.WidthPrn + ARect.Left;
        lx := 0;
      end;

      if (xx > RightSide) then
      begin
        rx := xx - RightSide;
        xx := RightSide;
      end else
      begin
        rx := 0;
      end;
      r.Right := xx;

      r1 := r;

      if DBGridEh.UseRightToLeftAlignment then
        OffsetRect(r1, (DataPrintRec.Right + DataPrintRec.Left) - (r1.Left + r1.Right), 0);

      AddPolyline([r1.Left, r1.Top, r1.Left, r1.Bottom, r1.Right, r1.Bottom]);

      if PRightTop.y > r.Top then
      begin
        PRightTop.y := r.Top;
        PLeftTop.y := PRightTop.y;
      end;

      Dec(r.Left, lx); Inc(r.Right, rx);

      VPrinter_Canvas.Font := DBGridEh.TitleFont;
      if (PrintFontName <> '') then
        VPrinter_Canvas.Font.Name := PrintFontName;
      if pghColored in Options then
        VPrinter_Canvas.Brush.Color := DBGridEh.FixedColor;

      if (pghColored in Options) and not CalcInfoMode then
        VPrinter_Canvas.FillRect(r1);

      AClipRect := r1;
      ATextDrawRect := r1;
      ATextDrawRect.Left := ATextDrawRect.Left - lx - PSX2;
      ATextDrawRect.Right := ATextDrawRect.Right + rx + PSX2;

      PrintTextEh(VPrinter_Canvas, ATextDrawRect, 0, PSY1, s,
        taCenter, tlCenter, true, False, AClipRect, CalcInfoMode,
        DBGridEh.UseRightToLeftAlignment, DBGridEh.UseRightToLeftReading);

      if (i = GetColNumByVisColNum(FromCol)) or (ANode.Parent.Parent.FirstChild = ANode.Parent) then
        PrintTitleRecurs(ANode.Parent, r);
    end;

  begin
    PRightTop.y := DataPrintRec.Top + PrintOffset;

    RightSide := DataPrintRec.Left;
    for i := GetColNumByVisColNum(FromCol) to GetColNumByVisColNum(ToCol) do begin
      Inc(RightSide, DBGridEh.LeafFieldArr[i].FLeaf.WidthPrn);
    end;

    r.Left := DataPrintRec.Left;
    for i := GetColNumByVisColNum(FromCol) to GetColNumByVisColNum(ToCol) do
    begin
      r.Bottom := DataPrintRec.Top + PrintOffset;
      r.Top := r.Bottom - DBGridEh.LeafFieldArr[i].FLeaf.HeightPrn;
      r.Right := r.Left + DBGridEh.LeafFieldArr[i].FLeaf.WidthPrn;
      s := DBGridEh.LeafFieldArr[i].FLeaf.Text;
      if (DBGridEh.TitleImages <> nil) and
        (DBGridEh.Columns[i].Title.ImageIndex <> -1)
        then s := '';

      r1 := r;
      if DBGridEh.UseRightToLeftAlignment then
        OffsetRect(r1, (DataPrintRec.Right + DataPrintRec.Left) - (r1.Left + r1.Right), 0);

      AddPolyline([r1.Left, r1.Top, r1.Left, r1.Bottom, r1.Right, r1.Bottom]);

      if i = GetColNumByVisColNum(ToCol) then
      begin
        PRightTop.x := r.Right;
        PRightLow.x := PRightTop.x;
      end;
      if PRightTop.y > r.Top then
      begin
        PRightTop.y := r.Top;
        PLeftTop.y := PRightTop.y;
      end;

      VPrinter_Canvas.Font := DBGridEh.Columns[i].Title.Font;
      if (PrintFontName <> '') then VPrinter_Canvas.Font.Name := PrintFontName;

      if pghColored in Options
        then VPrinter_Canvas.Brush.Color := DBGridEh.FixedColor
        else VPrinter_Canvas.Brush.Color := clWhite;

      if DBGridEh.Columns[i].Title.Orientation = tohVertical then
        PrintTextVerticalEh(VPrinter_Canvas, r1, PSX1 + PSX2, 0,
          s, taLeftJustify, tlCenter, True, False, CalcInfoMode)
      else
      begin
        if (pghColored in Options) and not CalcInfoMode then
          VPrinter_Canvas.FillRect(r1);

        ATextRect := r1;
        ChangeRect(ATextRect, PSX2, 0, -PSX2, 0);
        PrintTextEh(VPrinter_Canvas, ATextRect, 0, PSY1, s,
          taCenter, tlCenter, true, False, ATextRect, CalcInfoMode,
          DBGridEh.UseRightToLeftAlignment, DBGridEh.UseRightToLeftReading);
      end;

      if (DBGridEh.TitleImages <> nil) and (DBGridEh.Columns[i].Title.ImageIndex <> -1) then
      begin
        DrawClipped(DBGridEh.TitleImages, PrnColumns[i].Title.ImageIndex,
          VPrinter_Canvas, r1, r1, taCenter, taVerticalCenter,
          fScaleX, fScaleY);
      end;

      if (i = GetColNumByVisColNum(FromCol)) or
        (DBGridEh.LeafFieldArr[i].FLeaf.Parent.FirstChild = DBGridEh.LeafFieldArr[i].FLeaf) then
        PrintTitleRecurs(DBGridEh.LeafFieldArr[i].FLeaf, r);

      r.Left := r.Right;
    end;

    PLeftTop.x := DataPrintRec.Left;
    PRightLow.y := DataPrintRec.Top + PrintOffset;

    r1.Left := PLeftTop.x;
    r1.Top := PLeftTop.y;
    r1.Right := PRightLow.x;
    r1.Bottom := PRightLow.y;
    if DBGridEh.UseRightToLeftAlignment then
      OffsetRect(r1, (DataPrintRec.Right + DataPrintRec.Left) - (r1.Left + r1.Right), 0);

    AddPolyline([r1.Left, r1.Top, r1.Right, r1.Top, r1.Right, r1.Bottom]);

    PrintGridTitleTextHeight(FromCol, ToCol);

  end;

  function DrawRowsRange(var APBmFrom, APBMTo: TPolyBookmark): Integer;
  var
    pgs, FromCol, ToCol, i, j: Integer;
    ARect, ARect1, r: TRect;
    CurPBm: TPolyBookmark;
  begin
    FromCol := 0;
    Result := 0;
    for pgs := 0 to Length(ColsToPages) - 1 do
    begin
      if VPrinter.Aborted then Abort;
      if FirstPage
        then FirstPage := False
        else VPrinter_NewPage;
      SetLength(PolyPolyPoints, 0); SetLength(PolyLengths, 0);
      ToCol := ColsToPages[pgs];
      GotoPolyBookmark(APBmFrom);
      try
      CurPBm := APBmFrom;
      ARect.Top := DataPrintRec.Top + PrintOffset;
      ARect.Bottom := ARect.Top;
      j := 0;
      if DBGridEh.IsUseMultiTitle
        then PrintMultyTitle(FromCol, ToCol)
        else PrintSimpleTitle(FromCol, ToCol);
      while True do
      begin
        ARect.Left := DataPrintRec.Left; ARect.Right := ARect.Left;
        if Length(PrnRowHeights) = 0 then Break;
        Inc(ARect.Bottom, PrnRowHeights[j]);
        if CurPBm.InDS and
           IsDataGroupingFullPass and
           (CurPBm.PrnRowType = prtGroupHeaderRowEh)
        then
        begin
          Inc(ARect.Right, PrnColWIdths[FromCol]);
          DrawGroupDataCell(FromCol, ToCol, ARect, CurPBm, False, j)
        end else
          for i := FromCol to ToCol do
          begin
            Inc(ARect.Right, PrnColWIdths[i]);
            ARect1 := ARect;
            if DBGridEh.UseRightToLeftAlignment then
              OffsetRect(ARect1, (DataPrintRec.Right + DataPrintRec.Left) - (ARect.Left + ARect.Right), 0);
            if CurPBm.InDS and IsDataGroupingFullPass and (i = 0) then
            begin
              DrawGroupDataArea(FromCol, ToCol, CurPBm,
                DBGridEh.DataGrouping.GroupDataTree.FlatVisibleItem[CurPBm.RecNo].Level, ARect);
              r := ARect1;
              if DBGridEh.UseRightToLeftAlignment then
                r.Left := r.Right;
              AddPolyline([r.Left, r.Top,
                           r.Left, r.Bottom]);
              if DBGridEh.UseRightToLeftAlignment then
                ARect1.Right := ARect1.Right - Trunc(TDBGridEhCracker(DBGridEh).FExtraFirstColumnWidth*fScaleX)
              else
                ARect1.Left := ARect1.Left + Trunc(TDBGridEhCracker(DBGridEh).FExtraFirstColumnWidth*fScaleX);
            end;
            if CurPBm.InDS and
               IsDataGroupingFullPass and
               (CurPBm.PrnRowType = prtGroupFooterEh)
            then
              DrawGroupFooterCell(i, ARect1, CurPBm, False, j)
            else
              DrawCell(i, ARect1, CurPBm, False, j);
            if ((i = FromCol) and not DBGridEh.UseRightToLeftAlignment) or
              ((i = ToCol) and DBGridEh.UseRightToLeftAlignment) then
              AddPolyline([ARect1.Left, ARect1.Top, ARect1.Left, ARect1.Bottom, ARect1.Right, ARect1.Bottom, ARect1.Right, ARect1.Top])
            else
              AddPolyline([ARect1.Left, ARect1.Bottom, ARect1.Right, ARect1.Bottom, ARect1.Right, ARect1.Top]);
            ARect.Left := ARect.Right;
            if not CalcInfoMode then
              Application.ProcessMessages;
          end;
        Result := ARect.Bottom - PrintRec.Top;
        if Length(PrnRowHeights) - 1 = j then Break;

        SetNextPolyBookmark(CurPBm);
        Inc(j);
        ARect.Top := ARect.Bottom;
      end;
      finally
        if IsDataGroupingFullPass then
          TDBGridEhCracker(DBGridEh).InstantReadRecordLeave;
      end;
      if not CalcInfoMode then
        PrintPolyPolyLineEh(VPrinter_Canvas, PolyPolyPoints, PolyLengths, Length(PolyLengths));
      FromCol := ToCol + 1;
    end;
  end;

  function GetGridTitleTextHeight: Integer;
  var r: Trect;
    tm: Integer;
  begin
    if (Title.Text <> '') then
    begin
      VPrinter_Canvas.Font := DBGridEh.TitleFont;
      if (PrintFontName <> '') then
        VPrinter_Canvas.Font.Name := PrintFontName;
      r := Rect(0, 0, GetPrintGridWidth, 0);
      if DBGridEh.UseMultiTitle
        then tm := Round(DBGridEh.VTitleMargin * fScaleY / 2)
        else tm := PSY2;
      Result := PrintTextEh(VPrinter_Canvas, r, PSX2, tm,
        GetStingListText(Title), taCenter, tlCenter, True, False, r, True,
        DBGridEh.UseRightToLeftAlignment, DBGridEh.UseRightToLeftReading);
    end else
      Result := 0;
  end;

  function SetPrnChildTreeHeight(ANode: TDBGridMultiTitleNodeEh): Integer;
  var
    htLast: TDBGridMultiTitleNodeEh;
    newh, maxh, th: Integer;
    rec: TRect;
    DefaultRowHeight: Integer;
    s: String;
    TextSize: TSize;
  begin
    DefaultRowHeight := 0;
    Result := 0;

    if (ANode.FirstChild = nil) then Exit;
    htLast := ANode.FirstChild;
    if htLast.Column <> nil
      then VPrinter_Canvas.Font := htLast.Column.Title.Font
      else VPrinter_Canvas.Font := DBGridEh.TitleFont;
    if (PrintFontName <> '')
      then VPrinter_Canvas.Font.Name := PrintFontName;
    maxh := 0;
    if (htLast.FirstChild <> nil) then
      maxh := SetPrnChildTreeHeight(htLast);

    rec := Rect(0, 0, Round(htLast.WidthPrn) - Round(fScaleX * 4), DefaultRowHeight);
    s := htLast.Text;
    if s = '' then s := ' ';
    if (htLast.Column <> nil) and (TColumnEh(htLast.Column).Title.Orientation = tohVertical) then
    begin
      TextSize := VPrinter_Canvas.CalcTextSize(s, RectWidth(rec), False);
      th := TextSize.cx + Round(4 * fScaleY);
    end else
    begin
      TextSize := VPrinter_Canvas.CalcTextSize(s, RectWidth(rec), True);
      th := TextSize.cy + Round(DBGridEh.VTitleMargin * fScaleY);
    end;
    if (th > DefaultRowHeight)
      then maxh := maxh + th
      else maxh := maxh + DefaultRowHeight;

    while True do
    begin
      if (ANode.FirstChild = htLast.NextSibling) then begin break; end;
      htLast := htLast.NextSibling;
      newh := 0;
      if (htLast.FirstChild <> nil) then
        newh := SetPrnChildTreeHeight(htLast);
      rec := Rect(0, 0, Round(htLast.WidthPrn) - Round(fScaleX * 4), DefaultRowHeight);
      s := htLast.Text;
      if s = '' then s := ' ';
      if htLast.Column <> nil then
        VPrinter_Canvas.Font := htLast.Column.Title.Font;
      if (htLast.Column <> nil) and
        (TColumnEh(htLast.Column).Title.Orientation = tohVertical)
      then
      begin
        TextSize := VPrinter_Canvas.CalcTextSize(s, RectWidth(rec), False);
        th := TextSize.cx + Round(4 * fScaleY);
      end else
      begin
        TextSize := VPrinter_Canvas.CalcTextSize(s, RectWidth(rec), True);
        th := TextSize.cy + Round(DBGridEh.VTitleMargin * fScaleY);
      end;
      if (th > DefaultRowHeight)
        then newh := newh + th
        else newh := newh + DefaultRowHeight;

      if (maxh < newh) then maxh := newh;
    end;

    htLast := ANode.FirstChild;
    while ANode.FirstChild <> htLast.NextSibling do
    begin
      if (htLast.FirstChild = nil)
        then htLast.HeightPrn := maxh
        else htLast.HeightPrn := maxh - htLast.HeightPrn;
      htLast := htLast.NextSibling;
    end;
    if (htLast.FirstChild = nil)
      then htLast.HeightPrn := maxh
      else htLast.HeightPrn := maxh - htLast.HeightPrn;

    ANode.HeightPrn := maxh;
    Result := maxh;
  end;

  procedure SetPrnTreeWidth;
  var i, j: Integer;

    function SetPrnTreeWidthRecurs(AHost: TDBGridMultiTitleNodeEh): Integer;
    var
      an, nn: TDBGridMultiTitleNodeEh;
      w: Integer;
    begin
      w := 0;
      Result := AHost.WidthPrn;
      if (AHost.FirstChild = nil) then Exit;
      an := AHost.FirstChild;
      nn := an;
      while True do
      begin
        Inc(w, SetPrnTreeWidthRecurs(nn));
        nn := nn.NextSibling;
        if (nn = an) then Break;
      end;
      AHost.WidthPrn := w;
      Result := w;
    end;

  begin
    j := 0;
    for i := 0 to DBGridEh.Columns.Count - 1 do
    begin
      if PrnColumns.IndexOf(DBGridEh.Columns[i]) <> -1 then
      begin
        DBGridEh.LeafFieldArr[i].FLeaf.WidthPrn := PrnColWidths[j];
        Inc(j);
      end
      else
        DBGridEh.LeafFieldArr[i].FLeaf.WidthPrn := 0;
    end;
    SetPrnTreeWidthRecurs(DBGridEh.HeadTree.Root);
  end;

  function GetSimpleTitleHeight: Integer;
  var i, H, K, J: Integer;
    tm: TTEXTMETRIC;
    FInterlinear: Integer;
  begin
    Result := 0;
    if DBGridEh.RowPanel.Active then
    begin
{$IFDEF CIL}
{$ELSE}
      Result := Round(TDBGridEhCracker(DBGridEh).FGridMasterCellHeight * fScaleX);
{$ENDIF}
      Exit;
    end;
    for i := 0 to PrnColumns.Count - 1 do
    begin
      VPrinter_Canvas.Font := PrnColumns[i].Title.Font;
      if (PrintFontName <> '') then VPrinter_Canvas.Font.Name := PrintFontName;
      H := VPrinter_Canvas.TextHeight('Wg') + PSY2 * 2;
      if H > Result then Result := H;
    end;
    if Result = 0 then
    begin
      VPrinter_Canvas.Font := DBGridEh.TitleFont;
      if (PrintFontName <> '') then VPrinter_Canvas.Font.Name := PrintFontName;
      Result := VPrinter_Canvas.TextHeight('Wg') + PSY2 * 2;
    end;

    if (DBGridEh.TitleHeight <> 0) or (DBGridEh.TitleLines <> 0) then
    begin
      if DBGridEh.Flat then FInterlinear := PSY2 else FInterlinear := Round(4 * fScaleY);
      K := 0;
      for I := 0 to PrnColumns.Count - 1 do
      begin
        VPrinter_Canvas.Font := PrnColumns[I].Title.Font;
        J := VPrinter_Canvas.TextHeight('Wg') + Round(FInterlinear * fScaleY);
        if J > K then
        begin
          K := J;
          VPrinter_Canvas.GetTextMetrics(tm);
        end;
      end;
      if K = 0 then
      begin
        VPrinter_Canvas.Font := DBGridEh.TitleFont;
        VPrinter_Canvas.GetTextMetrics(tm);
      end;

      Result := tm.tmExternalLeading + tm.tmHeight * DBGridEh.TitleLines + PSY2 +
        Round(DBGridEh.TitleHeight * fScaleY);

      if dgRowLines in DBGridEh.Options then
        Result := Result + PSY1;
    end;

  end;

  function CalcMinRowHeight: Integer;
  var
    tm: TTextMetric;
  begin
    VPrinter_Canvas.Font := DBGridEh.Font;
    if (PrintFontName <> '') then VPrinter_Canvas.Font.Name := PrintFontName;
    VPrinter_Canvas.GetTextMetrics(tm);
    if (DBGridEh.RowHeight = 0) and (DBGridEh.RowLines = 0) then
      Result := VPrinter_Canvas.TextHeight('Wg') + PSY2 * 2
    else
      Result := (tm.tmExternalLeading + tm.tmHeight) * DBGridEh.RowLines + Round(DBGridEh.RowHeight * fScaleY);
    AWordWrap := (Result > tm.tmExternalLeading + tm.tmHeight + PSY2 * 2) or (pghRowAutoStretch in Options);
  end;

  procedure CreatePrnColumnsList;
  var i: Integer;
  begin
    PrnColumns := TColumnsEhList.Create;
    case DBGridEh.Selection.SelectionType of
      gstNon, gstAll, gstRecordBookmarks:
        for i := 0 to DBGridEh.VisibleColumns.Count - 1 do
          PrnColumns.Add(DBGridEh.VisibleColumns[i]);
      gstColumns:
        for i := 0 to DBGridEh.Selection.Columns.Count - 1 do
          PrnColumns.Add(DBGridEh.Selection.Columns[i]);
      gstRectangle:
        for i := DBGridEh.Selection.Rect.LeftCol to DBGridEh.Selection.Rect.RightCol do
          if DBGridEh.Columns[i].Visible then
            PrnColumns.Add(DBGridEh.Columns[i]);
    end;
  end;

  {$IFDEF FPC}
  procedure PrintRichText(Strings: TRichEditStrings);
  begin
  end;
  {$ELSE}
  procedure PrintRichText(Strings: TRichEditStrings);
  var
    FirstPageBlockTop: Integer;
    NextPagesBlockTop: Integer;
    BlockBottom: Integer;
    BlockLeft: Integer;
    BlockRight: Integer;
    Pages, LastPageBlockHeight: Integer;
  begin
    FirstPageBlockTop := PrintRec.Top + PrintOffset;
    NextPagesBlockTop := PrintRec.Top;
    BlockBottom := PrintRec.Bottom;
    BlockLeft := PrintRec.Left;
    BlockRight := PrintRec.Right;

    if CalcInfoMode then
    begin
      VPrinter.Canvas.MeasureRtfTextLayout(Strings.RtfText,
        FirstPageBlockTop, NextPagesBlockTop, BlockBottom, BlockLeft, BlockRight,
        Pages, LastPageBlockHeight);
      PrintOffset := LastPageBlockHeight;
    end
    else
    begin
      VPrinter.Canvas.DrawRtfText(Strings.RtfText,
        FirstPageBlockTop, NextPagesBlockTop, BlockBottom, BlockLeft, BlockRight,
        Pages, LastPageBlockHeight);
      PrintOffset := LastPageBlockHeight;
    end;
  end;
  {$ENDIF} 

  procedure SetSubstituting;
  var i: Integer;
  begin
    for i := 0 to FSubstitutesNames.Count - 1 do
    begin
      BeforeGridText.Replace(FSubstitutesNames[i], FSubstitutesValues[i], 0, -1, [], True);
      AfterGridText.Replace(FSubstitutesNames[i], FSubstitutesValues[i], 0, -1, [], True);
    end;
  end;

  function RequireTwoPass: Boolean;
  begin
    Result := Pos('&[Pages]', PageHeader.LeftText.Text) <> 0;
    if not Result then
      Result := Pos('&[Pages]', PageHeader.CenterText.Text) <> 0;
    if not Result then
      Result := Pos('&[Pages]', PageHeader.RightText.Text) <> 0;

    if not Result then
      Result := Pos('&[Pages]', PageFooter.LeftText.Text) <> 0;
    if not Result then
      Result := Pos('&[Pages]', PageFooter.CenterText.Text) <> 0;
    if not Result then
      Result := Pos('&[Pages]', PageFooter.RightText.Text) <> 0;
  end;

  procedure DrawTitleCell(Column: TColumnEh; CellRect: TRect);
  var
    s: String;
    r1: TRect;
  begin
    VPrinter_Canvas.Font := Column.Title.Font;
    if (PrintFontName <> '')
      then VPrinter_Canvas.Font.Name := PrintFontName;
    if pghColored in Options then
      VPrinter_Canvas.Brush.Color := DBGridEh.FixedColor;
    if (DBGridEh.TitleImages <> nil) and
      (Column.Title.ImageIndex <> -1)
      then s := ''
      else s := Column.Title.Caption;
    r1 := CellRect;
    if DBGridEh.UseRightToLeftAlignment then
      OffsetRect(r1, (DataPrintRec.Right + DataPrintRec.Left) - (r1.Left + r1.Right), 0);

    if Column.Title.Orientation = tohVertical then
      PrintTextVerticalEh(VPrinter_Canvas, r1, PSX2, PSY2 * 2,
        s, Column.Title.Alignment, tlBottom, True, False, CalcInfoMode)
    else
    begin
      if (pghColored in Options) and not CalcInfoMode then
        VPrinter_Canvas.FillRect(r1);

      PrintTextEh(VPrinter_Canvas, r1, PSX2, PSY2, s,
        Column.Title.Alignment, tlTop, False,
        Column.Title.EndEllipsis, r1, CalcInfoMode,
        DBGridEh.UseRightToLeftAlignment, DBGridEh.UseRightToLeftReading);
    end;

    if (DBGridEh.TitleImages <> nil) and
       (Column.Title.ImageIndex <> -1) then
    begin
      DrawClipped(DBGridEh.TitleImages, Column.Title.ImageIndex,
          VPrinter_Canvas, r1, r1, taCenter, taVerticalCenter,
          fScaleX, fScaleY);
    end;

    AddPolyline([CellRect.Left, CellRect.Bottom,
                CellRect.Right, CellRect.Bottom,
                CellRect.Right, CellRect.Top]);

  end;

  procedure PrintPanelTitle(FromPos, ToPos: Integer);
  var
    r, r1: TRect;
    i: Integer;
    CellRect: TRect;
    Col: TColumnEh;
    MasterColWidth: Integer;
  begin
{$IFDEF CIL}
{$ELSE}
    MasterColWidth := Round(TDBGridEhCracker(DBGridEh).FGridMasterCellWidth * fScaleX);
{$ENDIF}
    r := Rect(DataPrintRec.Left, DataPrintRec.Top - PrnTitlEh + PrintOffset, DataPrintRec.Left, DataPrintRec.Top + PrintOffset);

    for i := 0 to DBGridEh.Columns.Count-1 do
    begin
      Col := DBGridEh.Columns[i];
      CellRect := Rect(Col.RowPlacement.Left, Col.RowPlacement.Top,
        Col.RowPlacement.Left + Col.RowPlacement.Width,
        Col.RowPlacement.Top + Col.RowPlacement.Height);
      CellRect.Left := Round(CellRect.Left * fScaleX) + r.Left;
      CellRect.Top := Round(CellRect.Top * fScaleX) + r.Top;
      CellRect.Bottom := Round(CellRect.Bottom * fScaleX) + r.Top;
      CellRect.Right := Round(CellRect.Right * fScaleX) + r.Left;

      DrawTitleCell(Col, CellRect);

    end;

    r1 := r;
    if DBGridEh.UseRightToLeftAlignment then
      OffsetRect(r1, (DataPrintRec.Right + DataPrintRec.Left) - (r1.Left + r1.Right), 0);

    r.Right := r.Left + MasterColWidth;
{$IFDEF CIL}
{$ELSE}
    r.Bottom := r.Top + Round(TDBGridEhCracker(DBGridEh).FGridMasterCellHeight * fScaleX);
{$ENDIF}
    AddPolyline([r.Left, r.Bottom,
                 r.Left, r.Top,
                 r.Right, r.Top,
                 r.Right, r.Bottom,
                 r.Left, r.Bottom
                 ]);
    PrintGridTitleTextHeight(0, DBGridEh.Columns.Count-1);
  end;

  function DrawRowsRangePanel(var APBmFrom, APBMTo: TPolyBookmark): Integer;
  var
    i, j: Integer;
    ARect: TRect;
    CurPBm: TPolyBookmark;
    CellRect: TRect;
    Col: TColumnEh;
    TrueVar: Boolean;
  begin
    TrueVar := True;
    Result := 0;
    begin
      if VPrinter.Aborted then Abort;
      if FirstPage
        then FirstPage := False
        else VPrinter_NewPage;
      SetLength(PolyPolyPoints, 0); SetLength(PolyLengths, 0);

      GotoPolyBookmark(APBmFrom);
      try
      CurPBm := APBmFrom;
      ARect.Top := DataPrintRec.Top + PrintOffset;
      ARect.Bottom := ARect.Top;
      j := 0;

      PrintPanelTitle(0,0);

      while TrueVar do
      begin
        ARect.Left := DataPrintRec.Left;
{$IFDEF CIL}
{$ELSE}
        ARect.Right := ARect.Left + Round(TDBGridEhCracker(DBGridEh).FGridMasterCellWidth * fScaleX);
        Inc(ARect.Bottom, Round(TDBGridEhCracker(DBGridEh).FGridMasterCellHeight * fScaleX));
{$ENDIF}

        for i := 0 to DBGridEh.VisibleColumns.Count-1 do
        begin
          Col := DBGridEh.VisibleColumns[i];
          CellRect := Rect(Col.RowPlacement.Left, Col.RowPlacement.Top,
            Col.RowPlacement.Left + Col.RowPlacement.Width,
            Col.RowPlacement.Top + Col.RowPlacement.Height);
          CellRect.Left := Round(CellRect.Left * fScaleX) + ARect.Left;
          CellRect.Top := Round(CellRect.Top * fScaleX) + ARect.Top;
          CellRect.Bottom := Round(CellRect.Bottom * fScaleX) + ARect.Top;
          CellRect.Right := Round(CellRect.Right * fScaleX) + ARect.Left;

          DrawCell(i, CellRect, CurPBm, False, j);
          AddPolyline([CellRect.Left, CellRect.Bottom,
                       CellRect.Right, CellRect.Bottom,
                       CellRect.Right, CellRect.Top]);
          if CellRect.Left = ARect.Left then
            AddPolyline([CellRect.Left, CellRect.Top, CellRect.Left, CellRect.Bottom]);

          if not CalcInfoMode then
            Application.ProcessMessages;

        end;

        Result := ARect.Bottom - PrintRec.Top;
        if Length(PrnRowHeights) - 1 = j then Break;

        SetNextPolyBookmark(CurPBm);
        Inc(j);
        ARect.Top := ARect.Bottom;
      end;
      finally
        if IsDataGroupingFullPass then
          TDBGridEhCracker(DBGridEh).InstantReadRecordLeave;
      end;
      if not CalcInfoMode then
        PrintPolyPolyLineEh(VPrinter_Canvas, PolyPolyPoints, PolyLengths, Length(PolyLengths));
    end;
  end;

  procedure PrintOutInfo;
  begin
    PrintRichText(TRichEditStrings(BeforeGridText));
    if PrintOffset >= DataPrintRec.Bottom - DataPrintRec.Top then
    begin
      VPrinter_NewPage;
      PrintOffset := 0;
    end;

    InitPolyBookmark(PBm1);
    while True do
    begin
      PBm2 := CalcPrintRows(PBm1, DataPrintRec.Top + PrintOffset, DataPrintRec.Bottom);
      if DBGridEh.RowPanel.Active
        then PrintOffset := DrawRowsRangePanel(PBm1, PBm2) + PenW
        else PrintOffset := DrawRowsRange(PBm1, PBm2) + PenW;
      if (PBm2.EOF = True)
        then Break
        else PrintOffset := 0;
      PBm1 := PBm2;
    end;

    VPrinter_Canvas.Brush.Style := bsClear;
    VPrinter_Canvas.Brush.Color := clWhite;

    PrintRichText(TRichEditStrings(AfterGridText));
  end;

  procedure ClearFooterValues;
  var
    i: Integer;
  begin
    for i := 0 to Length(FooterValues)-1 do
      FooterValues[i] := 0;
  end;

begin
  FSubstituted := False;
  FooterValues := nil;
  PrnColumns := nil;
  PrnColumnWidths := nil;
  BeforeGridTextStream := nil;
  AfterGridTextStream := nil;
  MeasuringCanvas := nil;
  FVarColCellParamsEh := nil;
  FLastRowTexts := nil;
  PrintOffset := 0;
  PageCount := 1;
  CalcInfoMode := False;
  DBGridEh := TDBGridEhCracker(Self.DBGridEh);
  if not Assigned(DBGridEh) or
    not Assigned(DBGridEh.DataSource) or
    not Assigned(DBGridEh.DataSource.DataSet) or
    not DBGridEh.DataSource.DataSet.Active then Exit;

  InitMacroValues;
  ColsToPages := nil; PrnRowHeights := nil; PrnColWIdths := nil;
  PolyPolyPoints := nil; PolyLengths := nil;

  CreatePrnColumnsList;
  SetLength(PrnColumnWidths, 0);
  SetLength(FooterValues, PrnColumns.Count * (DBGridEh.FooterRowCount + DBGridEh.DataGrouping.Footers.Count));
  VPrinter.BeginDoc;
  VPrinter_Canvas := VPrinter.Canvas;
  FirstPage := True;
  SavedBookMark := DBGridEh.DataSource.DataSet.Bookmark;
  if Assigned(OnBeforePrint) then OnBeforePrint(Self);
  try
    FVarColCellParamsEh := TColCellParamsEh.Create;
    FLastRowTexts := TStringList.Create;

    if FSubstitutesNames <> nil then
    begin
      if BeforeGridText.Count > 0 then
      begin
        BeforeGridTextStream := TMemoryStream.Create;
        BeforeGridText.SaveToStream(BeforeGridTextStream);
      end;
      if AfterGridText.Count > 0 then
      begin
        AfterGridTextStream := TMemoryStream.Create;
        AfterGridText.SaveToStream(AfterGridTextStream);
      end;
      SetSubstituting;
      FSubstituted := True;
    end;

    DBGridEh.DataSource.DataSet.DisableControls;
    DBGridEh.DataSource.DataSet.First;

    VPrinter.Title := EhLibLanguageConsts.TabularInformation;
    VPrinter_Canvas.Brush.Style := bsClear;
    VPrinter_Canvas.Brush.Color := clWhite;
    VPrinter_Canvas.Font := DBGridEh.Font;
    if (PrintFontName <> '') then VPrinter_Canvas.Font.Name := PrintFontName;

    CalcDeviceCaps;
    CalcColumnWidths;
    CalcFitedDataRect;
    CalcColsToPages;
    ResetPrinterCanvas;

    TitleRect := Rect(DataPrintRec.Left, DataPrintRec.Top, DataPrintRec.Right, DataPrintRec.Top);
    Inc(TitleRect.Bottom, PrintPageColontitle(TitleRect, True, True));
    Inc(DataPrintRec.Top, TitleRect.Bottom - DataPrintRec.Top);

    FooterRect := Rect(DataPrintRec.Left, DataPrintRec.Bottom, DataPrintRec.Right, DataPrintRec.Bottom);
    Dec(FooterRect.Top, PrintPageColontitle(FooterRect, False, True));
    Dec(DataPrintRec.Bottom, FooterRect.Bottom - FooterRect.Top);


    PrintRec := DataPrintRec;
    MinRowHeight := CalcMinRowHeight;

    if DBGridEh.IsUseMultiTitle then
    begin
      SetPrnTreeWidth;
      PrnTitlEh := SetPrnChildTreeHeight(DBGridEh.HeadTree.Root);
    end else
      PrnTitlEh := GetSimpleTitleHeight;
    PrnTitleTextH := GetGridTitleTextHeight;
    Inc(DataPrintRec.Top, PrnTitlEh + PrnTitleTextH);

    if RequireTwoPass then
    begin
      CalcInfoMode := True;

      ACursor := Screen.Cursor;
      try
        Screen.Cursor := crHourGlass;
        CreateRenderCanvas;

        PrintOutInfo;

      finally
        Screen.Cursor := ACursor;
        FreeRenderCanvas;
      end;

      InitMacroValues;
      CalcInfoMode := False;
      FirstPage := True;
      PrintOffset := 0;
      DBGridEh.DataSource.DataSet.First;
      ClearFooterValues;
    end;

    PrintPageColontitle(TitleRect, True, False);
    PrintPageColontitle(FooterRect, False, False);

    PrintOutInfo;

  finally
    if Assigned(OnAfterPrint) then OnAfterPrint(Self);
    if FSubstituted then
    begin
      if BeforeGridTextStream <> nil then
      begin
        BeforeGridTextStream.Position := 0;
        BeforeGridText.LoadFromStream(BeforeGridTextStream);
        BeforeGridTextStream.Free;
      end;
      if AfterGridTextStream <> nil then
      begin
        AfterGridTextStream.Position := 0;
        AfterGridText.LoadFromStream(AfterGridTextStream);
        AfterGridTextStream.Free;
      end;
    end;
    DBGridEh.DataSource.DataSet.Bookmark := SavedBookMark;
    DBGridEh.DataSource.DataSet.EnableControls;
    VPrinter.EndDoc;
    PrnColumns.Free;
    FVarColCellParamsEh.Free;
    FLastRowTexts.Free;
    FreeRenderCanvas;
  end;
end;


procedure TPrintDBGridEh.Print;
begin
  PrintTo(VirtualPrinter);
end;

procedure TPrintDBGridEh.SetDBGridEh(const Value: TDBGridEh);
begin
  if Value <> FDBGridEh then
  begin
    FDBGridEh := Value;
    if Value <> nil then Value.FreeNotification(Self);
  end;
end;

procedure TPrintDBGridEh.SetOptions(const Value: TPrintDBGridEhOptions);
begin
  FOptions := Value;
end;

procedure TPrintDBGridEh.SetPage(const Value: TPageParams);
begin
  FPage := Value;
end;

procedure TPrintDBGridEh.SetPageFooter(const Value: TPageColontitle);
begin
  FPageFooter := Value;
end;

procedure TPrintDBGridEh.SetPageHeader(const Value: TPageColontitle);
begin
  FPageHeader := Value;
end;

procedure TPrintDBGridEh.SetPrintFontName(const Value: String);
begin
  FPrintFontName := Value;
end;

procedure TPrintDBGridEh.SetTitle(const Value: TStrings);
begin
  FTitle.Assign(Value);
end;

procedure TPrintDBGridEh.SetUnits(const Value: TMeasureUnits);
var AMul: Currency;
begin
  if Value <> FUnits then
  begin
    FUnits := Value;
    if csLoading in ComponentState then Exit;
    if Value = Inches then AMul := 1 / 2.54 else AMul := 2.54;
    Page.BottomMargin := Page.BottomMargin * AMul;
    Page.TopMargin := Page.TopMargin * AMul;
    Page.LeftMargin := Page.LeftMargin * AMul;
    Page.RightMargin := Page.RightMargin * AMul;
  end;
end;

function TPrintDBGridEh.PrinterSetupDialog: Boolean;
var
  f: TfPrnDBGridEhSetupDialog;
begin
  Result := False;
  if not Assigned(fPrnDBGridEhSetupDialog) then
    fPrnDBGridEhSetupDialog := TfPrnDBGridEhSetupDialog.Create(Application);

  f := fPrnDBGridEhSetupDialog;
  f.seUpMargin.Text := FloatToStr(Page.TopMargin);
  f.seLowMargin.Text := FloatToStr(Page.BottomMargin);
  f.seLeftMargin.Text := FloatToStr(Page.LeftMargin);
  f.seRightMargin.Text := FloatToStr(Page.RightMargin);
  f.cbFitWidthToPage.Checked := pghFitGridToPageWidth in Options;
  f.ePrintFont.Text := PrintFontName;
  f.cbAutoStretch.Checked := pghRowAutoStretch in Options;
  f.cbColored.Checked := pghColored in Options;
  if pghFitingByColWidths in Options
    then f.rgFitingType.ItemIndex := 1
    else f.rgFitingType.ItemIndex := 0;
  f.cbOptimalColWidths.Checked := pghOptimalColWidths in Options;

  if f.ShowModal = mrOk then
  begin
    Page.TopMargin := StrToFloat(f.seUpMargin.Text);
    Page.BottomMargin := StrToFloat(f.seLowMargin.Text);
    Page.LeftMargin := StrToFloat(f.seLeftMargin.Text);
    Page.RightMargin := StrToFloat(f.seRightMargin.Text);
    if f.cbFitWidthToPage.Checked
      then Options := Options + [pghFitGridToPageWidth]
      else Options := Options - [pghFitGridToPageWidth];
    PrintFontName := f.ePrintFont.Text;
    if f.cbAutoStretch.Checked
      then Options := Options + [pghRowAutoStretch]
      else Options := Options - [pghRowAutoStretch];
    if f.cbColored.Checked
      then Options := Options + [pghColored]
      else Options := Options - [pghColored];
    if f.rgFitingType.ItemIndex = 1
      then Options := Options + [pghFitingByColWidths]
      else Options := Options - [pghFitingByColWidths];
    if f.cbOptimalColWidths.Checked
      then Options := Options + [pghOptimalColWidths]
      else Options := Options - [pghOptimalColWidths];
    Result := True;
  end;
end;

procedure TPrintDBGridEh.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited Notification(AComponent, Operation);
  if (Operation = opRemove) and (AComponent = DBGridEh) then DBGridEh := nil;
end;

procedure TPrintDBGridEh.PrinterSetupDialogPreview(Sender: TObject);
begin
  if PrinterSetupDialog then
    Preview;
end;

procedure TPrintDBGridEh.SetBeforeGridText(const Value: TStringsEh);
var
  Stream: TStringStream;
begin
  Stream := TStringStream.Create('');
  try
    Value.SaveToStream(Stream);
    Stream.Position := 0;
    BeforeGridText.LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TPrintDBGridEh.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineBinaryProperty('BeforeGridText_Data', ReadBeforeGridText,
    WriteBeforeGridText, BeforeGridText.Count > 0);
  Filer.DefineBinaryProperty('AfterGridText_Data', ReadAfterGridText,
    WriteAfterGridText, AfterGridText.Count > 0);
end;

procedure TPrintDBGridEh.ReadBeforeGridText(Stream: TStream);
begin
  BeforeGridText.LoadFromStream(Stream);
end;

procedure TPrintDBGridEh.WriteBeforeGridText(Stream: TStream);
begin
  BeforeGridText.SaveToStream(Stream);
end;

procedure TPrintDBGridEh.SetAfterGridText(const Value: TStringsEh);
var
  Stream: TStringStream;
begin
  Stream := TStringStream.Create('');
  try
    Value.SaveToStream(Stream);
    Stream.Position := 0;
    AfterGridText.LoadFromStream(Stream);
  finally
    Stream.Free;
  end;
end;

procedure TPrintDBGridEh.ReadAfterGridText(Stream: TStream);
begin
  AfterGridText.LoadFromStream(Stream);
end;

procedure TPrintDBGridEh.WriteAfterGridText(Stream: TStream);
begin
  AfterGridText.SaveToStream(Stream);
end;

function TPrintDBGridEh.GetAfterGridText: TStringsEh;
begin
  if FAfterGridText = nil then
    FAfterGridText := TRichEditStrings.Create;
  Result := FAfterGridText;
end;

function TPrintDBGridEh.GetBeforeGridText: TStringsEh;
begin
  if FBeforeGridText = nil then
    FBeforeGridText := TRichEditStrings.Create;
  Result := FBeforeGridText;
end;

procedure TPrintDBGridEh.SetSubstitutes(ASubstitutes: array of const);
var i: Integer;
begin
  if FSubstitutesNames = nil then
  begin
    FSubstitutesNames := TStringList.Create;
    FSubstitutesValues := TStringList.Create;
  end;
  FSubstitutesNames.Clear;
  FSubstitutesValues.Clear;
  for i := 0 to High(ASubstitutes) div 2 do
  begin
{$IFDEF CIL}
    FSubstitutesNames.Add(String(ASubstitutes[i * 2]));
    FSubstitutesValues.Add(String(ASubstitutes[i * 2 + 1]));
{$ELSE}
    FSubstitutesNames.Add(String(ASubstitutes[i * 2].VAnsiString));
    FSubstitutesValues.Add(String(ASubstitutes[i * 2 + 1].VAnsiString));
{$ENDIF}
  end;
end;

procedure TPrintDBGridEh.PrintToPdfFile(AFileName: String);
begin
  PdfPrinter.BeginDoc(AFileName);
  PrintTo(PdfPrinter);
  PdfPrinter.EndDoc;
end;

{ TPageParams }

procedure TPageParams.Assign(Source: TPersistent);
begin
  if Source is TPageParams then
  begin
    BottomMargin := TPageParams(Source).BottomMargin;
    LeftMargin := TPageParams(Source).LeftMargin;
    RightMargin := TPageParams(Source).RightMargin;
    TopMargin := TPageParams(Source).TopMargin;
  end
  else inherited Assign(Source);
end;

constructor TPageParams.Create;
begin
  inherited Create;
  BottomMargin := 2;
  LeftMargin := 2;
  RightMargin := 2;
  TopMargin := 2;
end;

function TPageParams.IsBottomMarginStored: Boolean;
begin
  Result := (BottomMargin <> 2);
end;

function TPageParams.IsLeftMarginStored: Boolean;
begin
  Result := (LeftMargin <> 2);
end;

function TPageParams.IsRightMarginStored: Boolean;
begin
  Result := (RightMargin <> 2);
end;

function TPageParams.IsTopMarginStored: Boolean;
begin
  Result := (TopMargin <> 2);
end;

procedure TPageParams.SetBottomMargin(const Value: Currency);
begin
  FBottomMargin := Value;
end;

procedure TPageParams.SetLeftMargin(const Value: Currency);
begin
  FLeftMargin := Value;
end;

procedure TPageParams.SetRightMargin(const Value: Currency);
begin
  FRightMargin := Value;
end;

procedure TPageParams.SetTopMargin(const Value: Currency);
begin
  FTopMargin := Value;
end;

{ TPageColontitle }

procedure TPageColontitle.Assign(Source: TPersistent);
begin
  if Source is TPageColontitle then
  begin
    LeftText := TPageColontitle(Source).LeftText;
    CenterText := TPageColontitle(Source).CenterText;
    RightText := TPageColontitle(Source).RightText;
    Font := TPageColontitle(Source).Font;
    LineType := TPageColontitle(Source).LineType;
  end
  else inherited Assign(Source);
end;

constructor TPageColontitle.Create;
begin
  inherited Create;
  FFont := TFont.Create;
  FCenterText := TStringList.Create;
  FLeftText := TStringList.Create;
  FRightText := TStringList.Create;
end;

destructor TPageColontitle.Destroy;
begin
  FreeAndNil(FFont);
  FreeAndNil(FCenterText);
  FreeAndNil(FLeftText);
  FreeAndNil(FRightText);
  inherited Destroy;
end;

procedure TPageColontitle.SetCenterText(const Value: TStrings);
begin
  FCenterText.Assign(Value);
end;

procedure TPageColontitle.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure TPageColontitle.SetLeftText(const Value: TStrings);
begin
  FLeftText.Assign(Value);
end;

procedure TPageColontitle.SetLineType(const Value: TPageColontitleLineType);
begin
  FLineType := Value;
end;

procedure TPageColontitle.SetRightText(const Value: TStrings);
begin
  FRightText.Assign(Value);
end;

initialization
  GetCheckSize;
end.
