{*******************************************************}
{                                                       }
{                        EhLib 10.2                     }
{                                                       }
{                DataSetImpExpEh components             }
{                                                       }
{    Copyright (c) 2015-2022 by Dmitry V. Bolshakov     }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit DataSetImpExpEh;

interface

uses
  SysUtils, Classes, Graphics, Dialogs,
  {$IFDEF CIL}
    EhLibVCLNET,
    System.Text,
    System.Runtime.InteropServices,
  {$ELSE}
    {$IFDEF FPC}
    EhLibLCL,
    {$ELSE}
    EhLibVCL, Windows,
    {$ENDIF}
  {$ENDIF}
  Variants, ToolCtrlsEh, Db;

type

  TFieldsMapItemEh = class;
  TExportFieldsMapItemEh = class;
  TImportFieldsMapItemEh = class;
  TFieldsMapCollectionEh = class;
  TDataSetTextExporterEh = class;
  TDataSetTextImporterEh = class;

{ TFieldsMapItemEh }

  TFieldsMapItemEh = class(TCollectionItem)
  private
    FDataSetFieldName: String;
    FFileFieldName: String;
    FFileFieldPos: Integer;
    FFileFieldLen: Integer;
    FField: TField;
    FFieldSize: Integer;
    function GetCollection: TFieldsMapCollectionEh;

  protected
    function GetDisplayName: string; override;

  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;

    property Field: TField read FField write FField;
    property FieldSize: Integer read FFieldSize;
    property Collection: TFieldsMapCollectionEh read GetCollection;
  published
    property DataSetFieldName: String read FDataSetFieldName write FDataSetFieldName;
    property FileFieldName: String read FFileFieldName write FFileFieldName;
    property FileFieldPos: Integer read FFileFieldPos write FFileFieldPos default -1;
    property FileFieldLen: Integer read FFileFieldLen write FFileFieldLen default 0;
  end;

{ TExportFieldsMapItemEh }

  TFormatExportTextEventEh = procedure(Sender: TDataSetTextExporterEh;
                                       FieldsMapItem: TExportFieldsMapItemEh;
                                       var Value: String;
                                       var Processed: Boolean) of object;

  TExportFieldsMapItemEh = class(TFieldsMapItemEh)
  private
    FOnFormatExportValue: TFormatExportTextEventEh;
  published
    property OnFormatExportValue: TFormatExportTextEventEh read FOnFormatExportValue write FOnFormatExportValue;
  end;

{ TImportFieldsMapItemEh }

  TParseImportValueEventEh = procedure(Sender: TDataSetTextImporterEh;
                                       FieldsMapItem: TImportFieldsMapItemEh;
                                       const SourceValue: String;
                                       var TargetValue: Variant;
                                       var Processed: Boolean) of object;
  TWriteFieldValueEventEh = procedure(Sender: TDataSetTextImporterEh;
                                       FieldsMapItem: TImportFieldsMapItemEh;
                                       Value: Variant;
                                       var Processed: Boolean) of object;

  TImportFieldsMapItemEh = class(TFieldsMapItemEh)
  private
    FSourceValue: String;
    FTargetValue: Variant;

    FOnParseImportValue: TParseImportValueEventEh;
    FOnWriteFieldValue: TWriteFieldValueEventEh;

    procedure SetOnParseImportValue(const Value: TParseImportValueEventEh);
    procedure SetOnWriteFieldValue(const Value: TWriteFieldValueEventEh);
  public
    constructor Create(Collection: TCollection); override;
    procedure Assign(Source: TPersistent); override;

    property SourceValue: String read FSourceValue write FSourceValue;
    property TargetValue: Variant read FTargetValue write FTargetValue;
  published

    property OnParseImportValue: TParseImportValueEventEh read FOnParseImportValue write SetOnParseImportValue;
    property OnWriteFieldValue: TWriteFieldValueEventEh read FOnWriteFieldValue write SetOnWriteFieldValue;
  end;

{ TFieldsMapCollectionEh }

  TFieldsMapCollectionEh = class(TCollection, IDefaultItemsCollectionEh)
  private
    function GetItem(Index: Integer): TFieldsMapItemEh;
    procedure SetItem(Index: Integer; Value: TFieldsMapItemEh);

  protected
    {IInterface}
  {$IFDEF FPC}
    function QueryInterface(constref IID: TGUID; out Obj): HResult; virtual; {$IFDEF MSWINDOWS}stdcall {$ELSE}CDECL{$ENDIF};
    function _AddRef: Integer; {$IFDEF MSWINDOWS}stdcall {$ELSE}CDECL{$ENDIF};
    function _Release: Integer; {$IFDEF MSWINDOWS}stdcall {$ELSE}CDECL{$ENDIF};
  {$ELSE}
    function QueryInterface(const IID: TGUID; out Obj): HResult; virtual; stdcall;
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;
  {$ENDIF}

    {IDefaultItemsCollectionEh}
    function CanAddDefaultItems: Boolean;
    procedure AddAllItems(DeleteExisting: Boolean);

  protected
    FOwner: TPersistent;
    function GetOwner: TPersistent; override;
    function GetDataSetFields: TFields;

  public
    constructor Create(AOwner: TPersistent; ItemClass: TCollectionItemClass);
    destructor Destroy; override;
    function Add: TFieldsMapItemEh;
    function ItemByDataSetFieldName(const DataSetFieldName: String): TFieldsMapItemEh;
    function ItemByFileFieldName(const FileFieldName: String): TFieldsMapItemEh;

    property Item[Index: Integer]: TFieldsMapItemEh read GetItem write SetItem; default;
  end;

{ TExportFieldsMapCollectionEh }

  TExportFieldsMapCollectionEh = class (TFieldsMapCollectionEh)
  private
    function GetItem(Index: Integer): TExportFieldsMapItemEh;
    procedure SetItem(Index: Integer; Value: TExportFieldsMapItemEh);

  public
    function Add: TExportFieldsMapItemEh;

    property Item[Index: Integer]: TExportFieldsMapItemEh read GetItem write SetItem; default;
  end;

{ TDataSetTextExporterEh }

{$IFDEF EH_LIB_12}
  {$IFDEF EH_LIB_16}
  TExportImportEncodingEh = (eieAutoEh, eieUTF7Eh, eieUTF8Eh, eieUnicodeEh,
    eieBigEndianUnicodeEh, eieANSIEh, eieASCIIEh);
  {$ELSE}
  TExportImportEncodingEh = (eieAutoEh, eieUTF7Eh, eieUTF8Eh, eieUnicodeEh);
  {$ENDIF}
{$ELSE}
  TExportImportEncodingEh = (eieAutoEh, eieANSIEh);
{$ENDIF}

  TValueSeparationStyleEh = (vssFixedPositionAndSizeEh, vssDelimiterSeparatedEh);
  TValueExceedsSizeLimitActionEh = (vesTruncEh, vesRaiseExceptionEh);

  TTruncateTitleFieldEventEh = procedure(Exporter: TDataSetTextExporterEh; var StrValue: String; FieldSize: Integer) of object;
  TTruncateDataFieldEventEh = procedure(Exporter: TDataSetTextExporterEh; Field: TField; var StrValue: String; FieldSize: Integer) of object;
  TDataSetTextExporterExportLineEventEh = procedure(Exporter: TDataSetTextExporterEh; StreamWriter: TStreamWriter) of object;
  TGetFieldSizeEventEh = procedure(Sender: TComponent; Field: TField; var FieldSize: Integer) of object;

  TImportFormatsEh = class(TPersistent)
  private
    FDecimalSeparator: Char;
    FDateFormat: String;
    FDateSeparator: Char;
    FTimeFormat: String;
    FTimeSeparator: Char;
  protected
    function IsDateFormatStored: Boolean; virtual;
    function IsTimeFormatStored: Boolean; virtual;
    function DefaultDateFormat: String; virtual;
    function DefaultTimeFormat: String; virtual;
  public
    constructor Create; virtual;
    procedure Assign(Source: TPersistent); override;
  published
    property DecimalSeparator: Char read FDecimalSeparator write FDecimalSeparator default '.';
    property DateSeparator: Char read FDateSeparator write FDateSeparator default '/';
    property DateFormat: String read FDateFormat write FDateFormat stored IsDateFormatStored; 
    property TimeSeparator: Char read FTimeSeparator write FTimeSeparator default ':';
    property TimeFormat: String read FTimeFormat write FTimeFormat stored IsTimeFormatStored; 
  end;

  TExportFormatsEh = class(TImportFormatsEh)
  private
    FDateTimeFormat: String;
  protected
    function IsDateTimeFormatStored: Boolean; virtual;
    function DefaultDateTimeFormat: String; virtual;
  public
    constructor Create; override;
    procedure Assign(Source: TPersistent); override;
  published
    property DateTimeFormat: String read FDateTimeFormat write FDateTimeFormat stored IsTimeFormatStored; 
  end;

  TDataSetTextExporterEh = class(TComponent)
  private
    FDataSet: TDataSet;
    FEncoding: TExportImportEncodingEh;
    FStreamWriter: TStreamWriter;
    FValueDelimiter: Char;
    FLineBreak: String;
    FQuoteChar: Char;
    FIsExportFieldNames: Boolean;
    FExportValueAsDisplayText: Boolean;
    FExportFormats: TExportFormatsEh;
    FValueSeparationStyle: TValueSeparationStyleEh;
    FFieldsMap: TExportFieldsMapCollectionEh;
    FInternalFieldsMap: TExportFieldsMapCollectionEh;
    FIgnoreErrors: Boolean;
    FPosInLine: Integer;
    FExportRecordsCount: Integer;
    FValueExceedsSizeLimitAction: TValueExceedsSizeLimitActionEh;

    FOnStartExport: TNotifyEvent;
    FOnFinishExport: TNotifyEvent;
    FOnExportTitle: TDataSetTextExporterExportLineEventEh;
    FOnExportRecord: TDataSetTextExporterExportLineEventEh;
    FOnTruncateTitleField: TTruncateTitleFieldEventEh;
    FOnTruncateDataField: TTruncateDataFieldEventEh;
    FOnGetFieldSize: TGetFieldSizeEventEh;
    FOnFormatExportValue: TFormatExportTextEventEh;

    function TruncateAndAlignCell(Item: TExportFieldsMapItemEh; const CellValue: String; IsCaption: Boolean): String;
    function GetActiveFieldsMap: TExportFieldsMapCollectionEh;

    procedure SetFieldsMap(Value: TExportFieldsMapCollectionEh);
    procedure SetExportFormats(Value: TExportFormatsEh);
  protected

    procedure StartExport; virtual;
    procedure FinishExport; virtual;
    procedure ExportTitle; virtual;
    procedure ExportRecord; virtual;
    procedure CalculateFieldSize(FieldsMapItem: TExportFieldsMapItemEh); virtual;
    procedure SeparateValue(IsLastInRecord: Boolean); virtual;
    function QuoteValue(const Value: String): String; virtual;
  public

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure ExportToFile(const AFileName: String; AppendToFile: Boolean = False);
    procedure ExportToStream(AStream: TStream);

    function DefaultFormatExportValue(FieldsMapItem: TExportFieldsMapItemEh): String;
    function ActualLineBreak: String; virtual;

    procedure DefaultExportTitle(StreamWriter: TStreamWriter);
    procedure DefaultExportRecord(StreamWriter: TStreamWriter);
    procedure WriteEndOfLine(StreamWriter: TStreamWriter);
    procedure WriteValueSeparator(StreamWriter: TStreamWriter);
    procedure ExportTitleCell(StreamWriter: TStreamWriter; Item: TExportFieldsMapItemEh);
    procedure ExportRecordCell(StreamWriter: TStreamWriter; Item: TExportFieldsMapItemEh);

    property ActiveFieldsMap: TExportFieldsMapCollectionEh read GetActiveFieldsMap;
    property LineBreak: String read FLineBreak write FLineBreak; 
  published

    property DataSet: TDataSet read FDataSet write FDataSet;
    property Encoding: TExportImportEncodingEh read FEncoding write FEncoding default eieAutoEh;
    property ValueDelimiter: Char read FValueDelimiter write FValueDelimiter default ';';
    property QuoteChar: Char read FQuoteChar write FQuoteChar default '"';
    property ValueSeparationStyle: TValueSeparationStyleEh read FValueSeparationStyle write FValueSeparationStyle default vssDelimiterSeparatedEh;
    property FieldsMap: TExportFieldsMapCollectionEh read FFieldsMap write SetFieldsMap;
    property IsExportFieldNames: Boolean read FIsExportFieldNames write FIsExportFieldNames default True;
    property ExportValueAsDisplayText: Boolean read FExportValueAsDisplayText write FExportValueAsDisplayText default False;
    property ExportFormats: TExportFormatsEh read FExportFormats write SetExportFormats;
    property ValueExceedsSizeLimitAction: TValueExceedsSizeLimitActionEh read FValueExceedsSizeLimitAction write FValueExceedsSizeLimitAction default vesTruncEh;
    property ExportRecordsCount: Integer read FExportRecordsCount write FExportRecordsCount default -1;

    property OnStartExport: TNotifyEvent read FOnStartExport write FOnStartExport;
    property OnFinishExport: TNotifyEvent read FOnFinishExport write FOnFinishExport;
    property OnExportTitle: TDataSetTextExporterExportLineEventEh read FOnExportTitle write FOnExportTitle;
    property OnExportRecord: TDataSetTextExporterExportLineEventEh read FOnExportRecord write FOnExportRecord;
    property OnTruncateTitleField: TTruncateTitleFieldEventEh read FOnTruncateTitleField write FOnTruncateTitleField;
    property OnTruncateDataField: TTruncateDataFieldEventEh read FOnTruncateDataField write FOnTruncateDataField;
    property OnGetFieldSize: TGetFieldSizeEventEh read FOnGetFieldSize write FOnGetFieldSize;
    property OnFormatExportValue: TFormatExportTextEventEh read FOnFormatExportValue write FOnFormatExportValue;
  end;

{ TImportFieldsMapCollectionEh }

  TImportFieldsMapCollectionEh = class (TFieldsMapCollectionEh)
  private
    function GetItem(Index: Integer): TImportFieldsMapItemEh;
    procedure SetItem(Index: Integer; Value: TImportFieldsMapItemEh);

  public
    function Add: TImportFieldsMapItemEh;
    function ItemByDataSetFieldName(const DataSetFieldName: String): TImportFieldsMapItemEh;
    function ItemByFileFieldName(const FileFieldName: String): TImportFieldsMapItemEh;

    property Item[Index: Integer]: TImportFieldsMapItemEh read GetItem write SetItem; default;
  end;

{ TDataSetTextImporterEh }

  TUnknownFieldEventEh = procedure(Importer: TDataSetTextImporterEh; FieldName: String; var SkipField: Boolean) of object;
  TDataSetTextImporterImportLineEventEh = procedure(Importer: TDataSetTextImporterEh; StreamReader: TStreamReader) of object;
  TParseLineImportEventEh = procedure(Importer: TDataSetTextImporterEh; var LineStr: String; ParsedValues: TStringList) of object;
  TParseImportValueErrorEventEh = procedure(Importer: TDataSetTextImporterEh; ErrorMessage: String; FieldDataType: TFieldType; var Value: String; var TryParse: Boolean) of object;
  TDataSetTextImporterEventEh = procedure(Importer: TDataSetTextImporterEh) of object;

  TDataSetTextImporterEh = class(TComponent)
  private
    FDataSet: TDataSet;
    FEncoding: TExportImportEncodingEh;
    FFieldsMap: TImportFieldsMapCollectionEh;
    FFieldsMapToImportFields: Array of Integer;
    FImportFormats: TImportFormatsEh;
    FImportRecordsCount: Integer;
    FInternalFieldsMap: TImportFieldsMapCollectionEh;
    FIsFirstLineFieldNames: Boolean;
    FLineBreak: String;
    FLineBreakAutoDetect: Boolean;
    FProcessLine: String;
    FProcessLineIndex: Integer;
    FQuoteChar: Char;
    FStreamReader: TStreamReader;
    FValueDelimiter: Char;
    FValueSeparationStyle: TValueSeparationStyleEh;

    FOnFinishImport: TNotifyEvent;
    FOnGetFieldSize: TGetFieldSizeEventEh;
    FOnImportTitle: TDataSetTextImporterImportLineEventEh;
    FOnMakeRecordReady: TDataSetTextImporterEventEh;
    FOnParseImportValue: TParseImportValueEventEh;
    FOnParseImportValueError: TParseImportValueErrorEventEh;
    FOnParseLine: TParseLineImportEventEh;
    FOnParseValues: TDataSetTextImporterEventEh;
    FOnStartImport: TNotifyEvent;
    FOnUnknownFieldName: TUnknownFieldEventEh;
    FOnWriteFieldValue: TWriteFieldValueEventEh;
    FOnWriteRecord: TDataSetTextImporterEventEh;

    function GetActiveFieldsMap: TImportFieldsMapCollectionEh;

    procedure SetFieldsMap(Value: TImportFieldsMapCollectionEh);
    procedure SetImportFormats(Value: TImportFormatsEh);

  protected
    function ReadLine: String; virtual;

    procedure StartImport; virtual;
    procedure FinishImport; virtual;
    procedure ImportTitle; virtual;
    procedure CalculateFieldSize(FieldsMapItem: TImportFieldsMapItemEh); virtual;
    procedure ProcessLineStr(const LineStr: String); virtual;

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function ActualLineBreak: String; virtual;

    procedure DefaultImportTitle;
    procedure DefaultMakeRecordReady;
    procedure DefaultParseImportValue(Item: TImportFieldsMapItemEh);
    procedure DefaultParseLine(const Line: String; Values: TStringList); virtual;
    procedure DefaultParseValues;
    procedure DefaultProcessLine(const LineStr: String);
    procedure DefaultWriteRecordValues;
    procedure DefaultWriteRecord;
    procedure ImportFromFile(const AFileName: String);
    procedure ImportFromStream(AStream: TStream);
    procedure ImportRecordCell(Item: TImportFieldsMapItemEh); virtual;
    procedure MakeRecordReady;
    procedure MapValues(ParsedValues: TStringList);
    procedure ParseLine(const Line: String; Values: TStringList);
    procedure ParseValues;
    procedure PostRecord;
    procedure WriteRecordValues;
    procedure WriteRecord; virtual;

    property ActiveFieldsMap: TImportFieldsMapCollectionEh read GetActiveFieldsMap;
    property ProcessLineIndex: Integer read FProcessLineIndex;
    property ProcessLine: String read FProcessLine;
    property LineBreak: String read FLineBreak write FLineBreak; 

  published
    property DataSet: TDataSet read FDataSet write FDataSet;
    property Encoding: TExportImportEncodingEh read FEncoding write FEncoding default eieAutoEh;
    property LineBreakAutoDetect: Boolean read FLineBreakAutoDetect write FLineBreakAutoDetect default False;
    property ValueDelimiter: Char read FValueDelimiter write FValueDelimiter default ';';
    property QuoteChar: Char read FQuoteChar write FQuoteChar default '"';
    property ValueSeparationStyle: TValueSeparationStyleEh read FValueSeparationStyle write FValueSeparationStyle default vssDelimiterSeparatedEh;
    property FieldsMap: TImportFieldsMapCollectionEh read FFieldsMap write SetFieldsMap;
    property IsFirstLineFieldNames: Boolean read FIsFirstLineFieldNames write FIsFirstLineFieldNames default True;
    property ImportFormats: TImportFormatsEh read FImportFormats write SetImportFormats;
    property ImportRecordsCount: Integer read FImportRecordsCount write FImportRecordsCount default -1;

    property OnStartImport: TNotifyEvent read FOnStartImport write FOnStartImport;
    property OnFinishImport: TNotifyEvent read FOnFinishImport write FOnFinishImport;
    property OnParseLine: TParseLineImportEventEh read FOnParseLine write FOnParseLine;
    property OnImportTitle: TDataSetTextImporterImportLineEventEh read FOnImportTitle write FOnImportTitle;
    property OnUnknownFieldName: TUnknownFieldEventEh read FOnUnknownFieldName write FOnUnknownFieldName;
    property OnGetFieldSize: TGetFieldSizeEventEh read FOnGetFieldSize write FOnGetFieldSize;
    property OnParseImportValue: TParseImportValueEventEh read FOnParseImportValue write FOnParseImportValue;
    property OnParseImportValueError: TParseImportValueErrorEventEh read FOnParseImportValueError write FOnParseImportValueError;
    property OnWriteFieldValue: TWriteFieldValueEventEh read FOnWriteFieldValue write FOnWriteFieldValue;
    property OnMakeRecordReady: TDataSetTextImporterEventEh read FOnMakeRecordReady write FOnMakeRecordReady;
    property OnWriteRecord: TDataSetTextImporterEventEh read FOnWriteRecord write FOnWriteRecord;
    property OnParseValues: TDataSetTextImporterEventEh read FOnParseValues write FOnParseValues;
  end;

var
{$IFDEF EH_LIB_12}
  DefaultExportEncoding: TExportImportEncodingEh = eieUTF8Eh;
{$ELSE}
  DefaultExportEncoding: TExportImportEncodingEh = eieANSIEh;
{$ENDIF}
  DefaultImportExportLineBreak: String = sLineBreak;

implementation

uses
  StrUtils,
  {$IFDEF EH_LIB_17}
    System.Contnrs,
  {$ENDIF}
  EhLibXmlConsts, EhLibLangConsts;

type
  TTextImportParserState = (tipsChar, tipsDelimiter, tipsQuote, tipsNewLine);

{ TDataSetTextExporter }

constructor TDataSetTextExporterEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFieldsMap := TExportFieldsMapCollectionEh.Create(Self, TExportFieldsMapItemEh);
  FInternalFieldsMap := TExportFieldsMapCollectionEh.Create(Self, TExportFieldsMapItemEh);
  FExportFormats := TExportFormatsEh.Create;

  FEncoding := eieAutoEh;
  FValueDelimiter := ';';
  FLineBreak := '';
  FQuoteChar := '"';
  FValueSeparationStyle := vssDelimiterSeparatedEh;
  FIsExportFieldNames := True;
  FExportValueAsDisplayText := False;
  FValueExceedsSizeLimitAction := vesTruncEh;
  FExportRecordsCount := -1;
end;

destructor TDataSetTextExporterEh.Destroy;
begin
  FreeAndNil(FFieldsMap);
  FreeAndNil(FInternalFieldsMap);
  FreeAndNil(FExportFormats);
  inherited Destroy;
end;

procedure TDataSetTextExporterEh.ExportToFile(const AFileName: String; AppendToFile: Boolean = False);
var
  FStream: TFileStream;
begin
  if FileExists(AFileName) and AppendToFile then
  begin
    FStream := TFileStream.Create(AFileName, fmOpenReadWrite);
    FStream.Seek(System.Longint(0), soFromEnd);
  end
  else
    FStream := TFileStream.Create(AFileName, fmCreate);

  try
    ExportToStream(FStream);
  finally
    FStream.Free;
  end;
end;

procedure TDataSetTextExporterEh.ExportToStream(AStream: TStream);
var
  RecCount: Integer;
  Bookmark: TUniBookmarkEh;
  StreamEncoding: TEncoding;
begin
  case FEncoding of
{$IFDEF EH_LIB_12}
  {$IFDEF EH_LIB_16}
    eieANSIEh: StreamEncoding := TEncoding.ANSI;
    eieASCIIEh: StreamEncoding := TEncoding.ASCII;
    eieBigEndianUnicodeEh: StreamEncoding := TEncoding.BigEndianUnicode;
    eieAutoEh: StreamEncoding := TEncoding.Default;
  {$ENDIF}
    eieUTF7Eh: StreamEncoding := TEncoding.UTF7;
    eieUTF8Eh: StreamEncoding := TEncoding.UTF8;
    eieUnicodeEh: StreamEncoding := TEncoding.Unicode;
{$ELSE}
    eieANSIEh: StreamEncoding := TEncoding.ANSI;
{$ENDIF}
    else
      StreamEncoding := TEncoding.Default;
  end;
  FIgnoreErrors := False;
  FStreamWriter := TStreamWriter.Create(AStream, StreamEncoding);
  try
    Bookmark := DataSet.Bookmark;
    DataSet.DisableControls;
    try
      StartExport;

      if IsExportFieldNames then
        ExportTitle;

      RecCount := 0;
      while not DataSet.Eof do
      begin
        if (ExportRecordsCount <> -1) and (ExportRecordsCount >= RecCount) then Exit;
        ExportRecord;
        DataSet.Next;
        Inc(RecCount);
      end;

      FinishExport;
    finally
      DataSet.Bookmark := Bookmark;
      DataSet.EnableControls;
    end;
  finally
    FreeAndNil(FStreamWriter);
  end;
end;

function TDataSetTextExporterEh.GetActiveFieldsMap: TExportFieldsMapCollectionEh;
begin
  if FFieldsMap.Count = 0
    then Result := FInternalFieldsMap
    else Result := FFieldsMap;
end;

procedure TDataSetTextExporterEh.SetFieldsMap(Value: TExportFieldsMapCollectionEh);
begin
  FFieldsMap.Assign(Value);
end;

procedure TDataSetTextExporterEh.SetExportFormats(Value: TExportFormatsEh);
begin
  FExportFormats.Assign(Value);
end;

function TDataSetTextExporterEh.QuoteValue(const Value: String): String;
begin
  Result := Value;
  if QuoteChar > #0 then
  begin
    Result := StringReplace(Result, QuoteChar, QuoteChar + '' + QuoteChar, [rfReplaceAll]);
    if (Pos(' ', Result) > 0)
       or (Pos(QuoteChar, Result) > 0)
       or (Pos(ValueDelimiter, Result) > 0)
       or (Pos(ActualLineBreak, Result) > 0)
    then
      Result := QuoteChar + Result + QuoteChar;
  end;
end;

function TDataSetTextExporterEh.ActualLineBreak: String;
begin
  if LineBreak <> ''
    then Result := LineBreak
    else Result := DefaultImportExportLineBreak;
end;

procedure TDataSetTextExporterEh.CalculateFieldSize(
  FieldsMapItem: TExportFieldsMapItemEh);
begin
  if FieldsMapItem.FileFieldLen > 0 then
    FieldsMapItem.FFieldSize := FieldsMapItem.FileFieldLen
  else if Assigned(FieldsMapItem.Field) then
  begin
    if Assigned(OnGetFieldSize) then
      OnGetFieldSize(Self, FieldsMapItem.Field, FieldsMapItem.FFieldSize)
    else
      if FieldsMapItem.Field.DisplayWidth = 0 then
        raise Exception.Create(Format('Can''t get column width for field: ''%s''',
          [FieldsMapItem.Field.FieldName]))
      else
        FieldsMapItem.FFieldSize := FieldsMapItem.Field.DisplayWidth;
  end
  else
    FieldsMapItem.FFieldSize := 0;
end;

procedure TDataSetTextExporterEh.SeparateValue(IsLastInRecord: Boolean);
begin
  if (not IsLastInRecord) and
     (ValueSeparationStyle = vssDelimiterSeparatedEh) and
     (ValueDelimiter <> #0)
  then
    WriteValueSeparator(FStreamWriter);
end;

function TDataSetTextExporterEh.TruncateAndAlignCell(
  Item: TExportFieldsMapItemEh; const CellValue: String; IsCaption: Boolean): String;
var
  CellType: String;
begin
  if Length(CellValue) > Item.FieldSize then
  begin
    Result := CellValue;
    if IsCaption then
    begin
      CellType := 'caption';
      if Assigned(OnTruncateTitleField) then
        OnTruncateTitleField(Self, Result, Item.FieldSize);
    end
    else
    begin
      CellType := 'value';
      if Assigned(OnTruncateDataField) then
        OnTruncateDataField(Self, Item.Field, Result, Item.FieldSize);
    end;

    if Length(CellValue) > Item.FieldSize then
    begin
      if ValueExceedsSizeLimitAction = vesTruncEh then
        System.Delete(Result, Item.FieldSize + 1, Length(Result))
      else
        raise Exception.Create(Format(
          'Field %s ''%s'' exceeds length limit of %d symbol(s).',
            [CellType, Result, Item.FieldSize]));
    end;
  end
  else
    Result := Format('%-' + IntToStr(Item.FieldSize) + 's', [CellValue]);

  FStreamWriter.Write(DupeString(' ', Item.FileFieldPos - FPosInLine));
  FPosInLine := Item.FileFieldPos;
end;

procedure TDataSetTextExporterEh.ExportTitleCell(StreamWriter: TStreamWriter; Item: TExportFieldsMapItemEh);
var
  FieldName: String;
begin
  if Item.FileFieldName <> '' then
    FieldName := Item.FileFieldName
  else
    FieldName := Item.DataSetFieldName;

  if ValueSeparationStyle = vssFixedPositionAndSizeEh then
    FieldName := TruncateAndAlignCell(Item, FieldName, True)
  else
    FieldName := QuoteValue(FieldName);
  StreamWriter.Write(FieldName);
end;

function StreamToHexString(AStream: TStream): String;
var
  Buffer: TBytes;
begin
  SetLength(Buffer, AStream.Size);
  SetLength(Result, AStream.Size*2);
  AStream.Read(Buffer, AStream.Size);
  BinToHexEh(Buffer, Result, AStream.Size);
end;

function TDataSetTextExporterEh.DefaultFormatExportValue(
  FieldsMapItem: TExportFieldsMapItemEh): String;
var
  BlobData: TStream;
  SaveDateSeparator: Char;
  SaveTimeSeparator: Char;
begin
  if FieldsMapItem.Field.IsNull then
    Result := ''
  else
  if (FieldsMapItem.Field.DataType = ftDateTime)
     and (Length(ExportFormats.DateTimeFormat) > 0)
  then
  begin
    SaveDateSeparator := FormatSettings.DateSeparator;
    SaveTimeSeparator := FormatSettings.TimeSeparator;
    try
      FormatSettings.DateSeparator := ExportFormats.DateSeparator;
      FormatSettings.TimeSeparator := ExportFormats.TimeSeparator;
      Result := FormatDateTime(ExportFormats.DateTimeFormat, FieldsMapItem.Field.AsDateTime);
    finally
      FormatSettings.DateSeparator := SaveDateSeparator;
      FormatSettings.TimeSeparator := SaveTimeSeparator;
    end;
  end
  else
  if (FieldsMapItem.Field.DataType = ftDate) and (Length(ExportFormats.DateFormat) > 0) then
  begin
    SaveDateSeparator := FormatSettings.DateSeparator;
    try
      FormatSettings.DateSeparator := ExportFormats.DateSeparator;
      Result := FormatDateTime(ExportFormats.DateFormat, FieldsMapItem.Field.AsDateTime);
    finally
      FormatSettings.DateSeparator := SaveDateSeparator;
    end;
  end
  else
  if (FieldsMapItem.Field.DataType = ftTime) and (Length(ExportFormats.TimeFormat) > 0) then
  begin
    SaveTimeSeparator := FormatSettings.TimeSeparator;
    try
      FormatSettings.TimeSeparator := ExportFormats.TimeSeparator;
      Result := FormatDateTime(ExportFormats.TimeFormat, FieldsMapItem.Field.AsDateTime);
    finally
      FormatSettings.TimeSeparator := SaveTimeSeparator;
    end;
  end
  else
  if FieldsMapItem.Field.DataType in [ftBlob, ftGraphic] then
  begin
    BlobData := DataSet.CreateBlobStream(FieldsMapItem.Field, bmRead);
    try
      BlobData.Seek(System.Longint(0), soFromBeginning);
      Result := StreamToHexString(BlobData);
    finally
      BlobData.Free;
    end;
  end
  else
  if ExportValueAsDisplayText then
  begin
    Result := FieldsMapItem.Field.DisplayText;
  end
  else
  begin
    Result := FieldsMapItem.Field.AsString;
    if FieldsMapItem.Field.DataType in [ftFloat, ftCurrency, ftBCD{$IFDEF EH_LIB_13},ftSingle{$ENDIF}] then
    begin
      Result := ReplaceStr(Result,
                  FormatSettings.DecimalSeparator,
                  ExportFormats.DecimalSeparator);
    end;
  end;
end;

procedure TDataSetTextExporterEh.ExportRecordCell(StreamWriter: TStreamWriter;
  Item: TExportFieldsMapItemEh);
var
  StrValue: String;
  Processed: Boolean;
begin
  StrValue  := '';
  Processed := False;
  if (Item <> nil) and Assigned(Item.OnFormatExportValue) then
    Item.OnFormatExportValue(Self, Item, StrValue, Processed);

  if not Processed and Assigned(OnFormatExportValue) then
    OnFormatExportValue(Self, Item, StrValue, Processed);

  if not Processed then
    StrValue := DefaultFormatExportValue(Item);

  if ValueSeparationStyle = vssFixedPositionAndSizeEh then
    StrValue := TruncateAndAlignCell(Item, StrValue, False)
  else
    StrValue := QuoteValue(StrValue);
  StreamWriter.Write(StrValue);
end;

procedure TDataSetTextExporterEh.StartExport;
var
  i: Integer;
  FieldPosInLine: Integer;
  fmi: TExportFieldsMapItemEh;
begin
  if FieldsMap.Count = 0 then
  begin
    FInternalFieldsMap.Clear;
    for i := 0 to DataSet.Fields.Count-1 do
    begin
      fmi := FInternalFieldsMap.Add;
      fmi.DataSetFieldName := DataSet.Fields[i].FieldName;
      fmi.Field := DataSet.Fields[i];
    end;
  end else
    for i := 0 to FieldsMap.Count-1 do
      FieldsMap[i].Field := DataSet.FindField(FieldsMap[i].DataSetFieldName);

  if ValueSeparationStyle = vssFixedPositionAndSizeEh then
  begin
    FieldPosInLine := 0;
    for i := 0 to ActiveFieldsMap.Count-1 do
    begin
      fmi := ActiveFieldsMap[i];
      if fmi.FileFieldPos >= 0 then
      begin
        if fmi.FileFieldPos < FieldPosInLine then
          raise Exception.Create(
            Format('Field ''%s'' has small FileFieldPos value which cause ' +
             'overlapping of previous values during export of fields.',
               [fmi.DataSetFieldName]))
        else
          FieldPosInLine := fmi.FileFieldPos;
      end;
      CalculateFieldSize(fmi);
      Inc(FieldPosInLine, fmi.FieldSize);
    end;
  end;
  if Assigned(OnStartExport) then
    OnStartExport(Self);
end;

procedure TDataSetTextExporterEh.FinishExport;
begin
  if Assigned(OnFinishExport) then
    OnFinishExport(Self);
end;

procedure TDataSetTextExporterEh.WriteEndOfLine(StreamWriter: TStreamWriter);
begin
  StreamWriter.Write(ActualLineBreak);
end;

procedure TDataSetTextExporterEh.WriteValueSeparator(StreamWriter: TStreamWriter);
begin
  StreamWriter.Write(ValueDelimiter);
end;

procedure TDataSetTextExporterEh.DefaultExportTitle(StreamWriter: TStreamWriter);
var
  i: Integer;
begin
  FPosInLine := 0;

  for i := 0 to ActiveFieldsMap.Count-1 do
  begin
    ExportTitleCell(StreamWriter, ActiveFieldsMap[i]);
    SeparateValue(i = ActiveFieldsMap.Count-1);
    if ValueSeparationStyle = vssFixedPositionAndSizeEh then
    begin
      if ActiveFieldsMap[i].FileFieldPos >= 0 then
        FPosInLine := ActiveFieldsMap[i].FileFieldPos;
      Inc(FPosInLine, ActiveFieldsMap[i].FieldSize);
    end;
  end;

  WriteEndOfLine(StreamWriter);
end;

procedure TDataSetTextExporterEh.ExportTitle;
begin
  if Assigned(OnExportTitle) then
    OnExportTitle(Self, FStreamWriter)
  else
    DefaultExportTitle(FStreamWriter);
end;

procedure TDataSetTextExporterEh.DefaultExportRecord(StreamWriter: TStreamWriter);
var
  i: Integer;
begin
  FPosInLine := 0;
  for i := 0 to ActiveFieldsMap.Count-1 do
  begin
    ExportRecordCell(StreamWriter, ActiveFieldsMap[i]);
    SeparateValue(i = ActiveFieldsMap.Count-1);
    if ValueSeparationStyle = vssFixedPositionAndSizeEh then
    begin
      if ActiveFieldsMap[i].FileFieldPos >= 0 then
        FPosInLine := ActiveFieldsMap[i].FileFieldPos;
      Inc(FPosInLine, ActiveFieldsMap[i].FieldSize);
    end;
  end;
  WriteEndOfLine(StreamWriter);
end;

procedure TDataSetTextExporterEh.ExportRecord;
begin
  if Assigned(OnExportRecord) then
    OnExportRecord(Self, FStreamWriter)
  else
    DefaultExportRecord(FStreamWriter);
end;

{ TDataSetTextImporter }

constructor TDataSetTextImporterEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFieldsMap := TImportFieldsMapCollectionEh.Create(Self, TImportFieldsMapItemEh);
  FInternalFieldsMap := TImportFieldsMapCollectionEh.Create(Self, TImportFieldsMapItemEh);
  FImportFormats := TImportFormatsEh.Create;

  FEncoding := eieAutoEh;
  FValueDelimiter := ';';
  FLineBreak := '';
  FLineBreakAutoDetect := False;
  FQuoteChar := '"';
  FValueSeparationStyle := vssDelimiterSeparatedEh;
  FIsFirstLineFieldNames := True;
  FImportRecordsCount := -1;
end;

destructor TDataSetTextImporterEh.Destroy;
begin
  FreeAndNil(FFieldsMap);
  FreeAndNil(FInternalFieldsMap);
  FreeAndNil(FImportFormats);
  inherited Destroy;
end;

procedure TDataSetTextImporterEh.ImportFromFile(const AFileName: String);
var
  FileStream: TFileStream;
begin
  FileStream := TFileStream.Create(AFileName, fmOpenRead);
  try
    ImportFromStream(FileStream);
  finally
    FileStream.Free;
  end;
end;

procedure TDataSetTextImporterEh.ImportFromStream(AStream: TStream);
var
  RecCount: Integer;
  StreamEncoding: TEncoding;
begin
  case FEncoding of
{$IFDEF EH_LIB_12}
  {$IFDEF EH_LIB_16}
    eieANSIEh: StreamEncoding := TEncoding.ANSI;
    eieASCIIEh: StreamEncoding := TEncoding.ASCII;
    eieBigEndianUnicodeEh: StreamEncoding := TEncoding.BigEndianUnicode;
    eieAutoEh: StreamEncoding := TEncoding.Default;
  {$ENDIF}
    eieUTF7Eh: StreamEncoding := TEncoding.UTF7;
    eieUTF8Eh: StreamEncoding := TEncoding.UTF8;
    eieUnicodeEh: StreamEncoding := TEncoding.Unicode;
{$ELSE}
    eieANSIEh: StreamEncoding := TEncoding.ANSI;
{$ENDIF}
    else
      StreamEncoding := TEncoding.Default;
  end;
  FStreamReader := TStreamReader.Create(AStream, StreamEncoding, True);
  try
    StartImport;

    if IsFirstLineFieldNames then
      ImportTitle;

    Dataset.DisableControls;
    try
      RecCount := 0;
      while not FStreamReader.EndOfStream do
      begin
        if (ImportRecordsCount <> -1) and (ImportRecordsCount >= RecCount) then Exit;

        FProcessLine := ReadLine;
        ProcessLineStr(ProcessLine);
        WriteRecord;
        Inc(RecCount);
      end;
    finally
      SetLength(FFieldsMapToImportFields, 0);
      Dataset.EnableControls;
    end;
    FinishImport;
  finally
    FStreamReader.Free();
  end;
end;

function TDataSetTextImporterEh.GetActiveFieldsMap: TImportFieldsMapCollectionEh;
begin
  if (FInternalFieldsMap.Count > 0) or (FFieldsMap.Count = 0)
    then Result := FInternalFieldsMap
    else Result := FFieldsMap;
end;

procedure TDataSetTextImporterEh.SetFieldsMap(Value: TImportFieldsMapCollectionEh);
begin
  FFieldsMap.Assign(Value);
end;

procedure TDataSetTextImporterEh.SetImportFormats(Value: TImportFormatsEh);
begin
  FImportFormats.Assign(Value);
end;

function TDataSetTextImporterEh.ActualLineBreak: String;
begin
  if LineBreak <> ''
    then Result := LineBreak
    else Result := DefaultImportExportLineBreak;
end;

function TDataSetTextImporterEh.ReadLine: String;
var
  Symbol: Char;
  LineBreakCmpPos: Integer;
  IsQuotedString: Boolean;
  LineBreakSeq: String;
  ParseState: TTextImportParserState;
begin
  LineBreakCmpPos := 1;
  LineBreakSeq    := ActualLineBreak;
  IsQuotedString  := False;
  Result          := '';

  ParseState := tipsNewLine;
  while True do
  begin
    Symbol := Chr(FStreamReader.Read());

{$IFDEF EH_LIB_12}
    if Symbol = #$FFFF then
{$ELSE}
    if Symbol = #$FF then
{$ENDIF}
      Break;

    if (Symbol = FQuoteChar) and (ValueSeparationStyle = vssDelimiterSeparatedEh) then
    begin
      LineBreakCmpPos := 1;
      if ParseState = tipsQuote then
        ParseState := tipsChar
      else
        ParseState := tipsQuote;
      Result := Result + Symbol;
      Continue;
    end;

    if ParseState = tipsQuote then
      IsQuotedString := not IsQuotedString;

    if (not IsQuotedString) and
       ( (LineBreakAutoDetect and (CharInSetEh(Symbol, [#10, #13]))) or
         ( (LineBreakCmpPos <= Length(LineBreakSeq)) and
           (Symbol = LineBreakSeq[LineBreakCmpPos])
         )
       )
    then
    begin
      ParseState := tipsNewLine;

      if LineBreakAutoDetect then
      begin
        { Shift position in stream to one symbol ahead if new line is detected
          and it is in Windows notation (#13#10) }
        if (Symbol = #13) and (Chr(FStreamReader.Peek()) = #10) then
          FStreamReader.Read();
        Break;
      end
      else if LineBreakCmpPos = Length(LineBreakSeq) then
      begin
        System.Delete(Result, Length(Result), Length(LineBreakSeq) - 1);
        Break;
      end;

      Result := Result + Symbol;
      Inc(LineBreakCmpPos);
      Continue;
    end;

    Result  := Result + Symbol;
    ParseState := tipsChar;
    LineBreakCmpPos := 1;
  end;

  Inc(FProcessLineIndex);
end;

procedure TDataSetTextImporterEh.ProcessLineStr(const LineStr: String);
var
  i: Integer;
begin
  for i := 0 to ActiveFieldsMap.Count - 1 do
  begin
    ActiveFieldsMap[i].FSourceValue := '';
    ActiveFieldsMap[i].FTargetValue := Null;
  end;

  DefaultProcessLine(LineStr);
end;

procedure TDataSetTextImporterEh.DefaultProcessLine(const LineStr: String);
var
  ParsedValues: TStringList;
begin
  ParsedValues := TStringList.Create;
  try
    ParseLine(LineStr, ParsedValues);
    MapValues(ParsedValues);
    ParseValues;
  finally
    ParsedValues.Free;
  end;
end;

procedure TDataSetTextImporterEh.ParseLine(const Line: String; Values: TStringList);
var
  ALine: String;
begin
  if Assigned(FOnParseLine) then
  begin
    ALine := Line;
    FOnParseLine(Self, ALine, Values)
  end else
    DefaultParseLine(Line, Values);
end;

procedure TDataSetTextImporterEh.DefaultParseLine(const Line: String; Values: TStringList);
var
  IsQuotedString: Boolean;
  LinePos: Integer;
  ParseState: TTextImportParserState;
  Value: String;
  ValuePos: Integer;
  ValueLen: Integer;
  FieldPosInLine: Integer;

  function GetValueLen(ValuePos: Integer; FieldPosInLine: Integer): Integer;
  begin
    if (ValueSeparationStyle = vssFixedPositionAndSizeEh) and
       (ValuePos < ActiveFieldsMap.Count)
    then
    begin
      Result := ActiveFieldsMap[ValuePos].FieldSize;
      if (ActiveFieldsMap[ValuePos].FileFieldPos >= 0) and
         (FieldPosInLine <> ActiveFieldsMap[ValuePos].FileFieldPos)
      then
        Inc(Result, ActiveFieldsMap[ValuePos].FileFieldPos - FieldPosInLine);
    end
    else
      Result := -1;
  end;
begin
  if Length(Line) = 0 then
  begin
    Values.Clear;
    Exit;
  end;

  ParseState := tipsChar;
  IsQuotedString  := False;
  LinePos := 0;
  Value := '';
  ValuePos := 0;
  FieldPosInLine := 0;
  ValueLen := GetValueLen(ValuePos, FieldPosInLine);
  while LinePos < Length(Line) do
  begin
    if ValueSeparationStyle = vssFixedPositionAndSizeEh then
    begin
      if ValueLen = -1 then
      begin
        Value := Copy(Line, LinePos + 1, Length(Line) - LinePos);
        LinePos := Length(Line);
      end
      else
      begin
        Value := Copy(Line, LinePos + 1, ValueLen);
        Inc(LinePos, ValueLen);
      end;
      Values.Add(Trim(Value));
      Value := '';
      Inc(ValuePos);
      ValueLen := GetValueLen(ValuePos, LinePos);
      Continue;
    end;

    Inc(LinePos);
    if (Line[LinePos] = FQuoteChar) and
       (ValueSeparationStyle = vssDelimiterSeparatedEh)
    then
    begin
      if ParseState = tipsQuote then
      begin
        Value := Value + Line[LinePos];
        ParseState := tipsChar;
      end
      else
        ParseState := tipsQuote;
      Continue;
    end;

    if ParseState = tipsQuote then
      IsQuotedString := not IsQuotedString;

    if (Line[LinePos] = ValueDelimiter) and
       (not IsQuotedString) and
       (ValueSeparationStyle = vssDelimiterSeparatedEh)
    then
    begin
      ParseState := tipsDelimiter;
      if Value = FQuoteChar then Value := '';
      Values.Add(Value);
      Value := '';
      Continue;
    end;

    Value := Value + Line[LinePos];
    ParseState := tipsChar;

    if (Length(Value) = ValueLen) and
       (ValueSeparationStyle = vssFixedPositionAndSizeEh)
    then
    begin
      Values.Add(Trim(Value));
      Value := '';
      Inc(ValuePos);
      Inc(FieldPosInLine, ValueLen + 1);
      ValueLen := GetValueLen(ValuePos, FieldPosInLine);
    end;
  end;
  if (Length(Value) > 0) or (ParseState = tipsDelimiter) then
  begin
    if Value = FQuoteChar then Value := '';
    Values.Add(Value);
  end;
end;

procedure TDataSetTextImporterEh.MapValues(ParsedValues: TStringList);
var
  i: Integer;
  index: Integer;
begin
  for i := 0 to ParsedValues.Count - 1 do
  begin
    if (High(FFieldsMapToImportFields) > -1) and (i < High(FFieldsMapToImportFields))
      then index := FFieldsMapToImportFields[i]
      else index := i;
    if (index >= 0) and (index < ActiveFieldsMap.Count) then
      ActiveFieldsMap[index].FSourceValue := ParsedValues[i];
  end;
end;

procedure TDataSetTextImporterEh.ParseValues;
begin
  if Assigned(OnParseValues)
    then OnParseValues(Self)
    else DefaultParseValues;
end;

procedure TDataSetTextImporterEh.DefaultParseValues;
var
  i: Integer;
begin
  for i := 0 to ActiveFieldsMap.Count - 1 do
    ImportRecordCell(ActiveFieldsMap[i]);
end;

procedure TDataSetTextImporterEh.WriteRecord;
begin
  if Assigned(OnWriteRecord)
    then OnWriteRecord(Self)
    else DefaultWriteRecord;
end;

procedure TDataSetTextImporterEh.DefaultWriteRecord;
begin
  MakeRecordReady;
  WriteRecordValues;
  PostRecord;
end;

procedure TDataSetTextImporterEh.MakeRecordReady;
begin
  if Assigned(OnMakeRecordReady)
    then OnMakeRecordReady(Self)
    else DefaultMakeRecordReady;
end;

procedure TDataSetTextImporterEh.DefaultMakeRecordReady;
begin
  DataSet.Append;
end;

procedure TDataSetTextImporterEh.WriteRecordValues;
begin
  DefaultWriteRecordValues;
end;

procedure TDataSetTextImporterEh.DefaultWriteRecordValues;
var
  i: Integer;
  Processed: Boolean;
begin
  for i := 0 to ActiveFieldsMap.Count - 1 do
  begin
    if Assigned(ActiveFieldsMap[i].Field) then
    begin
      Processed := False;
      if Assigned(ActiveFieldsMap[i].OnWriteFieldValue) then
        ActiveFieldsMap[i].OnWriteFieldValue(Self,
                                             ActiveFieldsMap[i],
                                             ActiveFieldsMap[i].TargetValue,
                                             Processed);
      if not Processed and Assigned(OnWriteFieldValue) then
        OnWriteFieldValue(Self,
                          ActiveFieldsMap[i],
                          ActiveFieldsMap[i].TargetValue,
                          Processed);
      if not Processed and (ActiveFieldsMap[i].Field <> nil) then
        ActiveFieldsMap[i].Field.AsVariant := ActiveFieldsMap[i].TargetValue;
    end;
  end;
end;

procedure TDataSetTextImporterEh.PostRecord;
begin
  DataSet.Post;
end;

procedure TDataSetTextImporterEh.CalculateFieldSize(
  FieldsMapItem: TImportFieldsMapItemEh);
begin
  if FieldsMapItem.FileFieldLen > 0 then
    FieldsMapItem.FFieldSize := FieldsMapItem.FileFieldLen
  else if Assigned(FieldsMapItem.Field) then
  begin
    if Assigned(OnGetFieldSize) then
      OnGetFieldSize(Self, FieldsMapItem.Field, FieldsMapItem.FFieldSize)
    else
      if FieldsMapItem.Field.DisplayWidth = 0 then
        raise Exception.Create(Format('Can''t get column width for field: ''%s''',
          [FieldsMapItem.Field.FieldName]))
      else
        FieldsMapItem.FFieldSize := FieldsMapItem.Field.DisplayWidth;
  end
  else
    FieldsMapItem.FFieldSize := 0;
end;

procedure TDataSetTextImporterEh.StartImport;
var
  i, j: Integer;
  FieldPosInLine: Integer;
  fmi: TImportFieldsMapItemEh;
begin
  FProcessLineIndex := -1;
  SetLength(FFieldsMapToImportFields, 0);
  if (FieldsMap.Count = 0) and (ValueSeparationStyle = vssFixedPositionAndSizeEh) then
    raise Exception.Create('FieldsMap should be defined before import');

  FInternalFieldsMap.Clear;

  if FieldsMap.Count > 0 then
  begin
    FieldPosInLine := 0;
    for i := 0 to FieldsMap.Count-1 do
    begin
      FieldsMap[i].Field := DataSet.FindField(FieldsMap[i].DataSetFieldName);
      if ValueSeparationStyle = vssFixedPositionAndSizeEh then
      begin
        for j := i+1 to FieldsMap.Count-1 do
          if FieldsMap[i].FileFieldName = FieldsMap[j].FileFieldName then
            raise Exception.Create(
              Format('FieldMap has two identical FileFieldName ''%s'' in different positions.',
                 [FieldsMap[i].FileFieldName]));

        CalculateFieldSize(FieldsMap[i]);
        if FieldsMap[i].FileFieldPos >= 0 then
        begin
          if FieldsMap[i].FileFieldPos < FieldPosInLine then
            raise Exception.Create(
              Format('Field ''%s'' has small FileFieldPos value which cause ' +
               'overlapping of previous values during export of fields.',
                 [FieldsMap[i].DataSetFieldName]))
          else
            FieldPosInLine := FieldsMap[i].FileFieldPos;
        end;
        Inc(FieldPosInLine, FieldsMap[i].FieldSize);
      end;
    end;
  end
  else if not IsFirstLineFieldNames then
    for i := 0 to DataSet.Fields.Count-1 do
    begin
      fmi := FInternalFieldsMap.Add;
      fmi.DataSetFieldName := DataSet.Fields[i].FieldName;
      fmi.Field            := DataSet.Fields[i];
    end;
  if Assigned(OnStartImport) then
    OnStartImport(Self);
end;

procedure TDataSetTextImporterEh.FinishImport;
begin
  if Assigned(OnFinishImport) then
    OnFinishImport(Self);
end;

procedure TDataSetTextImporterEh.ImportTitle;
begin
  if Assigned(OnImportTitle) then
    OnImportTitle(Self, FStreamReader)
  else
    DefaultImportTitle;
end;

procedure TDataSetTextImporterEh.DefaultImportTitle;
var
  Value: String;
  dsField: TField;
  SkipField: Boolean;
  fmi: TImportFieldsMapItemEh;
  i: Integer;
  j: Integer;
  ParsedValues: TStringList;
begin
  if FStreamReader.EndOfStream then
    Exit;

  Value := ReadLine;
  ParsedValues := TStringList.Create;
  try
    if Assigned(FOnParseLine) then
      FOnParseLine(Self, Value, ParsedValues)
    else
      DefaultParseLine(Value, ParsedValues);

    if ValueSeparationStyle = vssDelimiterSeparatedEh then
      SetLength(FFieldsMapToImportFields, ParsedValues.Count);

    for i := 0 to ParsedValues.Count - 1 do
    begin
      if ValueSeparationStyle = vssFixedPositionAndSizeEh then
      begin
        SkipField := True;

        if (i < ActiveFieldsMap.Count) and
           (ActiveFieldsMap[i].FileFieldName <> ParsedValues[i])
        then
          SkipField := False
        else if (i >= ActiveFieldsMap.Count) and Assigned(OnUnknownFieldName) then
          OnUnknownFieldName(Self, ParsedValues[i], SkipField);

        if not SkipField then
          raise Exception.Create('Unknown field name ''' + ParsedValues[i] + '''.');
      end else
      begin
        FFieldsMapToImportFields[i] := -1;
        if FieldsMap.Count > 0 then
        begin
          for j := 0 to FieldsMap.Count-1 do
            if FieldsMap[j].FileFieldName = ParsedValues[i] then
            begin
              FFieldsMapToImportFields[i] := j;
              Break;
            end;
        end else
        begin
          dsField := DataSet.FindField(ParsedValues[i]);

          if not Assigned(dsField) then
          begin
            SkipField := True;
            if Assigned(OnUnknownFieldName) then
              OnUnknownFieldName(Self, ParsedValues[i], SkipField);
            if not SkipField then
              raise Exception.Create('Unknown field name ''' + ParsedValues[i] + '''.');
          end else
          begin
            fmi := FInternalFieldsMap.Add;
            fmi.Field := dsField;
            fmi.FileFieldName := ParsedValues[i];
            fmi.DataSetFieldName := dsField.FieldName;
            FFieldsMapToImportFields[i] := FInternalFieldsMap.Count - 1;
          end;
        end;
      end;
    end;

    if ActiveFieldsMap.Count > ParsedValues.Count then
      raise Exception.Create('File contains less number of fields than expected by FieldMap.');
  finally
    FreeAndNil(ParsedValues);
  end;
end;

procedure TDataSetTextImporterEh.ImportRecordCell(Item: TImportFieldsMapItemEh);
var
  Processed: Boolean;
begin
  if not DataSet.CanModify then Exit;

  Processed := False;
  if (Item <> nil) and Assigned(Item.OnParseImportValue) then
    Item.OnParseImportValue(Self, Item, Item.SourceValue, Item.FTargetValue, Processed);

  if not Processed and Assigned(OnParseImportValue) then
    OnParseImportValue(Self, Item, Item.SourceValue, Item.FTargetValue, Processed);

  if not Processed then
    DefaultParseImportValue(Item);
end;

function HexStringToVariant(const HexString: String): Variant;
var
  PData: Pointer;
  Buffer: TBytes;
begin
  if Length(HexString) > 0 then
  begin
    HexToBinEh(HexString, Buffer, Length(HexString));
    Result := VarArrayCreate([0, Length(Buffer)], varByte);
    PData := VarArrayLock(Result);
    try
      Move(Buffer[0], PData^, Length(Buffer));
    finally
      VarArrayUnlock(Result);
    end;
  end
  else
    Result := Null;
end;

procedure TDataSetTextImporterEh.DefaultParseImportValue(Item: TImportFieldsMapItemEh);
var
  SaveDateSeparator: Char;
  SaveTimeSeparator: Char;
  SaveShortDateFormat: String;
  SaveShortTimeFormat: String;
  TryToParse: Boolean;
begin
  if (Item.Field <> nil) and (Item.Field.DataType = ftDateTime) then
  begin
    if (Length(ImportFormats.DateFormat) > 0) and
       (Length(ImportFormats.TimeFormat) > 0) and
       (Item.SourceValue > '')
    then
    begin
      SaveDateSeparator   := FormatSettings.DateSeparator;
      SaveTimeSeparator   := FormatSettings.TimeSeparator;
      SaveShortDateFormat := FormatSettings.ShortDateFormat;
      SaveShortTimeFormat := FormatSettings.ShortTimeFormat;

      FormatSettings.DateSeparator   := ImportFormats.DateSeparator;
      FormatSettings.TimeSeparator   := ImportFormats.TimeSeparator;
      FormatSettings.ShortDateFormat := ImportFormats.DateFormat;
      FormatSettings.ShortTimeFormat := ImportFormats.TimeFormat;

      try
        while True do
        begin
          try
            if Item.SourceValue <> '' then
              Item.TargetValue := StrToDateTime(Item.SourceValue)
            else
              Item.TargetValue := Null;
            Break;
          except
            on E: Exception do
            begin
              TryToParse := False;
              if Assigned(OnParseImportValueError) then
                OnParseImportValueError(Self, E.Message, Item.Field.DataType, Item.FSourceValue, TryToParse);
              if not TryToParse then
                raise;
            end;
          end;
        end;
      finally
        FormatSettings.DateSeparator   := SaveDateSeparator;
        FormatSettings.TimeSeparator   := SaveTimeSeparator;
        FormatSettings.ShortDateFormat := SaveShortDateFormat;
        FormatSettings.ShortTimeFormat := SaveShortTimeFormat;
      end;
    end;
  end
  else if (Item.Field <> nil) and (Item.Field.DataType = ftDate) then
  begin
    if (Length(ImportFormats.DateFormat) > 0) and (Item.SourceValue > '')
    then
    begin
      SaveDateSeparator   := FormatSettings.DateSeparator;
      SaveShortDateFormat := FormatSettings.ShortDateFormat;
      FormatSettings.DateSeparator   := ImportFormats.DateSeparator;
      FormatSettings.ShortDateFormat := ImportFormats.DateFormat;

      try
        while True do
        begin
          try
            if Item.SourceValue <> '' then
              Item.TargetValue := StrToDateTime(Item.SourceValue)
            else
              Item.TargetValue := Null;
            Break;
          except
            on E: Exception do
            begin
              TryToParse := False;
              if Assigned(OnParseImportValueError) then
                OnParseImportValueError(Self, E.Message, Item.Field.DataType, Item.FSourceValue, TryToParse);
              if not TryToParse then
                raise;
            end;
          end;
        end;
      finally
        FormatSettings.DateSeparator   := SaveDateSeparator;
        FormatSettings.ShortDateFormat := SaveShortDateFormat;
      end;
    end;
  end
  else if (Item.Field <> nil) and (Item.Field.DataType = ftTime) then
  begin
    if (Length(ImportFormats.TimeFormat) > 0) and (Item.SourceValue > '')
    then
    begin
      SaveTimeSeparator   := FormatSettings.TimeSeparator;
      SaveShortTimeFormat := FormatSettings.ShortTimeFormat;
      FormatSettings.TimeSeparator   := ImportFormats.TimeSeparator;
      FormatSettings.ShortTimeFormat := ImportFormats.TimeFormat;

      try
        while True do
        begin
          try
            if Item.SourceValue <> '' then
              Item.TargetValue := StrToDateTime(Item.SourceValue)
            else
              Item.TargetValue := Null;
            Break;
          except
            on E: Exception do
            begin
              TryToParse := False;
              if Assigned(OnParseImportValueError) then
                OnParseImportValueError(Self, E.Message, Item.Field.DataType, Item.FSourceValue, TryToParse);
              if not TryToParse then
                raise;
            end;
          end;
        end;
      finally
        FormatSettings.TimeSeparator   := SaveTimeSeparator;
        FormatSettings.ShortTimeFormat := SaveShortTimeFormat;
      end;
    end;
  end
  else if (Item.Field <> nil) and (Item.Field.DataType in [ftBlob, ftGraphic]) then
  begin
    while True do
    begin
      try
        if Item.SourceValue <> '' then
          Item.TargetValue := HexStringToVariant(Item.SourceValue)
        else
          Item.TargetValue := Null;
        Break;
      except
        on E: Exception do
        begin
          TryToParse := False;
          if Assigned(OnParseImportValueError) then
            OnParseImportValueError(Self, E.Message, Item.Field.DataType, Item.FSourceValue, TryToParse);
          if not TryToParse then
            raise;
        end;
      end;
    end;
  end
  else if (Item.Field <> nil) and (Item.Field.DataType in [ftFloat, ftCurrency, ftBCD]) then
  begin
    while True do
    begin
      try
        if Item.SourceValue <> '' then
          Item.TargetValue := StrToFloat(ReplaceStr(Item.SourceValue,
                                         ImportFormats.DecimalSeparator,
                                         FormatSettings.DecimalSeparator))
        else
          Item.TargetValue := Null;
        Break;
      except
        on E: Exception do
        begin
          TryToParse := False;
          if Assigned(OnParseImportValueError) then
            OnParseImportValueError(Self, E.Message, Item.Field.DataType, Item.FSourceValue, TryToParse);
          if not TryToParse then
            raise;
        end;
      end;
    end;
  end
  else if (Item.Field <> nil) and
    (Item.Field.DataType in [ftSmallint, ftInteger, ftWord, ftLargeint
                             {$IFDEF EH_LIB_12}, ftLongWord, ftShortint{$ENDIF}]) then
  begin
    while True do
    begin
      try
        if Item.SourceValue <> '' then
        begin
          if Item.Field.DataType =  ftLargeint then
            Item.TargetValue := StrToInt64(Item.SourceValue)
          else
            Item.TargetValue := StrToInt(Item.SourceValue);
        end else
          Item.TargetValue := Null;
        Break;
      except
        on E: Exception do
        begin
          TryToParse := False;
          if Assigned(OnParseImportValueError) then
            OnParseImportValueError(Self, E.Message, Item.Field.DataType, Item.FSourceValue, TryToParse);
          if not TryToParse then
            raise;
        end;
      end;
    end;
  end
  else if Item.SourceValue <> '' then
    Item.TargetValue := Item.SourceValue;
end;

{ TFieldsMapItem }

procedure TFieldsMapItemEh.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
end;

constructor TFieldsMapItemEh.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FFileFieldPos := -1;
  FileFieldLen := 0;
end;

function TFieldsMapItemEh.GetCollection: TFieldsMapCollectionEh;
begin
  Result := TFieldsMapCollectionEh(inherited Collection);
end;

function TFieldsMapItemEh.GetDisplayName: string;
var
  FromItem, ToItem: String;
begin
  if (Collection.Owner is TDataSetTextExporterEh) then
  begin
    FromItem := DataSetFieldName;
    ToItem := FileFieldName;
  end else if (Collection.Owner is TDataSetTextImporterEh) then
  begin
    FromItem := FileFieldName;
    ToItem := DataSetFieldName;
  end;
  Result := FromItem + ' -> ' + ToItem;
end;

{ TImportFieldsMapItemEh }

constructor TImportFieldsMapItemEh.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FSourceValue := '';
  FTargetValue := '';
end;

procedure TImportFieldsMapItemEh.SetOnParseImportValue(
  const Value: TParseImportValueEventEh);
begin
  FOnParseImportValue := Value;
end;

procedure TImportFieldsMapItemEh.SetOnWriteFieldValue(
  const Value: TWriteFieldValueEventEh);
begin
  FOnWriteFieldValue := Value;
end;

procedure TImportFieldsMapItemEh.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
end;

{ TImportFieldsMapCollectionEh }

function TImportFieldsMapCollectionEh.Add: TImportFieldsMapItemEh;
begin
  Result := TImportFieldsMapItemEh(inherited Add);
end;

function TImportFieldsMapCollectionEh.GetItem(
  Index: Integer): TImportFieldsMapItemEh;
begin
  Result := TImportFieldsMapItemEh(inherited Items[Index]);
end;

function TImportFieldsMapCollectionEh.ItemByDataSetFieldName(
  const DataSetFieldName: String): TImportFieldsMapItemEh;
begin
  Result := TImportFieldsMapItemEh(inherited ItemByDataSetFieldName(DataSetFieldName));
end;

function TImportFieldsMapCollectionEh.ItemByFileFieldName(
  const FileFieldName: String): TImportFieldsMapItemEh;
begin
  Result := TImportFieldsMapItemEh(inherited ItemByFileFieldName(FileFieldName));
end;

procedure TImportFieldsMapCollectionEh.SetItem(Index: Integer;
  Value: TImportFieldsMapItemEh);
begin
  inherited Items[Index] := Value;
end;

{ TFieldsMapCollection }

constructor TFieldsMapCollectionEh.Create(AOwner: TPersistent;
  ItemClass: TCollectionItemClass);
begin
  inherited Create(ItemClass);
  FOwner := AOwner;
end;

destructor TFieldsMapCollectionEh.Destroy;
begin
  inherited Destroy;
end;

function TFieldsMapCollectionEh.Add: TFieldsMapItemEh;
begin
  Result := TFieldsMapItemEh(inherited Add);
end;

function TFieldsMapCollectionEh.GetOwner: TPersistent;
begin
  Result := FOwner;
end;

function TFieldsMapCollectionEh.ItemByDataSetFieldName(
  const DataSetFieldName: String): TFieldsMapItemEh;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count-1 do
    if Item[i].DataSetFieldName = DataSetFieldName then
    begin
      Result := Item[i];
      Exit;
    end;
end;

function TFieldsMapCollectionEh.ItemByFileFieldName(
  const FileFieldName: String): TFieldsMapItemEh;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count-1 do
    if Item[i].FileFieldName = FileFieldName then
    begin
      Result := Item[i];
      Exit;
    end;
end;

function TFieldsMapCollectionEh.GetItem(Index: Integer): TFieldsMapItemEh;
begin
  Result := TFieldsMapItemEh(inherited Items[Index]);
end;

procedure TFieldsMapCollectionEh.SetItem(Index: Integer; Value: TFieldsMapItemEh);
begin
  inherited Items[Index] := Value;
end;

{$IFDEF FPC}
function TFieldsMapCollectionEh.QueryInterface(constref IID: TGUID;
  out Obj): HResult;
{$ELSE}
function TFieldsMapCollectionEh.QueryInterface(const IID: TGUID;
  out Obj): HResult;
{$ENDIF}
begin
  if GetInterface(IID, Obj)
    then Result := 0
    else Result := E_NOINTERFACE;
end;

function TFieldsMapCollectionEh._AddRef: Integer;
begin
  Result := -1;
end;

function TFieldsMapCollectionEh._Release: Integer;
begin
  Result := -1;
end;

function TFieldsMapCollectionEh.GetDataSetFields: TFields;
begin
  if (Owner is TDataSetTextExporterEh) and (TDataSetTextExporterEh(Owner).DataSet <> nil) then
    Result := TDataSetTextExporterEh(Owner).DataSet.Fields
  else if (Owner is TDataSetTextImporterEh) and (TDataSetTextImporterEh(Owner).DataSet <> nil) then
    Result := TDataSetTextImporterEh(Owner).DataSet.Fields
  else
    Result := nil;
end;

procedure TFieldsMapCollectionEh.AddAllItems(DeleteExisting: Boolean);
var
  Fields: TFields;
  i: Integer;
  fmi: TFieldsMapItemEh;
begin
  BeginUpdate;
  try
    if DeleteExisting then
      Clear;
    Fields := GetDataSetFields;
    for i := 0 to Fields.Count-1 do
    begin
      fmi := Add;
      fmi.DataSetFieldName := Fields[i].FieldName;
      fmi.FileFieldName := Fields[i].FieldName;
    end;
  finally
    EndUpdate;
  end;
end;

function TFieldsMapCollectionEh.CanAddDefaultItems: Boolean;
begin
  if (Owner is TDataSetTextExporterEh) then
    Result := (TDataSetTextExporterEh(Owner).DataSet <> nil) and (TDataSetTextExporterEh(Owner).DataSet.FieldCount > 0)
  else if (Owner is TDataSetTextImporterEh) then
    Result := (TDataSetTextImporterEh(Owner).DataSet <> nil) and (TDataSetTextImporterEh(Owner).DataSet.FieldCount > 0)
  else
    Result := False;
end;

{ TExportFieldsMapCollectionEh }

function TExportFieldsMapCollectionEh.Add: TExportFieldsMapItemEh;
begin
  Result := TExportFieldsMapItemEh(inherited Add);
end;

function TExportFieldsMapCollectionEh.GetItem(Index: Integer): TExportFieldsMapItemEh;
begin
  Result := TExportFieldsMapItemEh(inherited Items[Index]);
end;

procedure TExportFieldsMapCollectionEh.SetItem(Index: Integer; Value: TExportFieldsMapItemEh);
begin
  inherited Items[Index] := Value;
end;

{ TImportFormatsEh }

constructor TImportFormatsEh.Create;
begin
  inherited Create;
  FDecimalSeparator := '.';
  FDateSeparator := '-';
  FDateFormat := 'YYYY/MM/DD';
  FTimeSeparator := ':';
  FTimeFormat := 'HH:NN:SS';
end;

function TImportFormatsEh.DefaultDateFormat: String;
begin
  Result := 'YYYY/MM/DD';
end;

function TImportFormatsEh.DefaultTimeFormat: String;
begin
  Result := 'HH:NN:SS';
end;

function TImportFormatsEh.IsDateFormatStored: Boolean;
begin
  Result := (DateFormat <> DefaultDateFormat);
end;

function TImportFormatsEh.IsTimeFormatStored: Boolean;
begin
  Result := (TimeFormat <> DefaultTimeFormat);
end;

procedure TImportFormatsEh.Assign(Source: TPersistent);
begin
  if Source is TImportFormatsEh then
  begin
    FDecimalSeparator  := TImportFormatsEh(Source).DecimalSeparator;
    FDateFormat        := TImportFormatsEh(Source).DateFormat;
    FDateSeparator     := TImportFormatsEh(Source).DateSeparator;
    FTimeFormat        := TImportFormatsEh(Source).TimeFormat;
    FTimeSeparator     := TImportFormatsEh(Source).TimeSeparator;
  end else
    inherited Assign(Source);
end;

{ TExportFormatsEh }

constructor TExportFormatsEh.Create;
begin
  FDateTimeFormat := 'YYYY/MM/DD"T"HH:NN:SS';
  inherited Create;
end;

function TExportFormatsEh.DefaultDateTimeFormat: String;
begin
  Result := 'YYYY/MM/DD"T"HH:NN:SS';
end;

function TExportFormatsEh.IsDateTimeFormatStored: Boolean;
begin
  Result := (DateTimeFormat <> DefaultDateTimeFormat);
end;

procedure TExportFormatsEh.Assign(Source: TPersistent);
begin
  if Source is TExportFormatsEh then
  begin
    FDateTimeFormat := TExportFormatsEh(Source).DateTimeFormat;
  end;
  inherited Assign(Source);
end;

procedure InitUnit;
begin
end;

procedure FinalizeUnit;
begin
end;

initialization
  InitUnit;
finalization
  FinalizeUnit;
end.
