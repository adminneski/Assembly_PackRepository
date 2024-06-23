{*******************************************************}
{                                                       }
{                       EhLib 10.2                      }
{             DBGridEh import/export routines           }
{                                                       }
{   Copyright (c) 1998-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit DBGridEhImpExp;

interface

uses
  SysUtils, Generics.Collections,
{$IFDEF FPC}
  XMLRead, XMLWrite, xmlutils, DOM, EhLibXmlConsts,
{$ELSE}
  xmldom, XMLIntf, XMLDoc, EhLibXmlConsts,
{$ENDIF}

{$IFDEF EH_LIB_17} System.UITypes, {$ENDIF}
{$IFDEF CIL}
  EhLibVCLNET,
  System.Runtime.InteropServices, System.Reflection,
{$ELSE}
  {$IFDEF FPC}
    EhLibLCL, LCLType, LCLIntf, DBGridsEh,
    {$IFDEF FPC_CROSSP}
    {$ELSE}
       Windows,
    {$ENDIF}
  {$ELSE}
    EhLibVCL, Messages, SqlTimSt, DBGridEh, Windows,
  {$ENDIF}
{$ENDIF}
  DBAxisGridsEh, ZipFileProviderEh,
{$IFDEF MSWINDOWS}
  ComObj,
{$ELSE}
{$ENDIF}
  Classes, Graphics, Dialogs, Controls, Variants, StrUtils,
  Contnrs, Db, Clipbrd, StdCtrls,
  GridsEh, ToolCtrlsEh, XlsMemFilesEh, DBGridEhXlsMemFileExporters;

const
  TVCLDBIF_TYPE_EOF = 0;
  TVCLDBIF_TYPE_UNASSIGNED = 1;
  TVCLDBIF_TYPE_NULL = 2;
  TVCLDBIF_TYPE_INTEGER32 = 3;
  TVCLDBIF_TYPE_FLOAT64 = 4;
  TVCLDBIF_TYPE_ANSI_STRING = 5;
  TVCLDBIF_TYPE_BINARY_DATA = 6;
  TVCLDBIF_TYPE_WIDE_STRING = 7;

type
  TVarDynaTableEh = array of TVariantArrayEh;

  { TDBGridEhExport }

  TDBGridEhExport = class(TObject)
  private
    FColCellParamsEh: TColCellParamsEh;
    FDBGridEh: TCustomDBGridEh;
    FExpCols: TColumnsEhList;
    function GetFooterValue(Row, Col: Integer): String;
  protected
    FStream: TStream;
    FooterValues: TFooterValues;
    procedure CalcFooterValues; virtual;
    procedure WritePrefix; virtual;
    procedure WriteSuffix; virtual;
    procedure WriteTitle(ColumnsList: TColumnsEhList); virtual;
    procedure WriteRecord(ColumnsList: TColumnsEhList); virtual;
    procedure WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh); virtual;
    procedure WriteFooter(ColumnsList: TColumnsEhList; FooterNo: Integer); virtual;
    procedure WriteFooterCell(DataCol, Row: Integer; Column: TColumnEh; AFont: TFont;
      Background: TColor; Alignment: TAlignment; const Text: String); virtual;
    property Stream: TStream read FStream write FStream;
    property ExpCols: TColumnsEhList read FExpCols write FExpCols;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure ExportToStream(AStream: TStream; IsExportAll: Boolean); virtual;
    procedure ExportToFile(const FileName: String; IsExportAll: Boolean); virtual;
    property DBGridEh: TCustomDBGridEh read FDBGridEh write FDBGridEh;
  end;

  TDBGridEhExportClass = class of TDBGridEhExport;

  { TDBGridEhExportAsText }

  TDBGridEhExportAsText = class(TDBGridEhExport)
  private
    FirstRec: Boolean;
    FirstCell: Boolean;
    FWriteBOM: Boolean;
    FEncoding: TEncoding;
    FStringBuilder: TStringBuilder;
  protected
    procedure WritePrefix; override;
    procedure WriteSuffix; override;
    procedure WriteTitle(ColumnsList: TColumnsEhList); override;
    procedure WriteFooter(ColumnsList: TColumnsEhList; FooterNo: Integer); override;
    procedure WriteRecord(ColumnsList: TColumnsEhList); override;
    procedure WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh); override;
    procedure WriteFooterCell(DataCol, Row: Integer; Column: TColumnEh; AFont: TFont; Background: TColor; Alignment: TAlignment; const Text: String); override;

    procedure CheckFirstRec; virtual;
    procedure CheckFirstCell; virtual;
    procedure WriteString(s: String); virtual;
  public
    procedure ExportToStream(Stream: TStream; IsExportAll: Boolean); override;

    property WriteBOM: Boolean read FWriteBOM write FWriteBOM;
    property Encoding: TEncoding read FEncoding write FEncoding;
  end;

  { TDBGridEhExportAsUnicodeText }

  TDBGridEhExportAsUnicodeText = class(TDBGridEhExport)
  private
    FirstRec: Boolean;
    FirstCell: Boolean;
  protected
    procedure CheckFirstRec; virtual;
    procedure CheckFirstCell; virtual;
    procedure WritePrefix; override;
    procedure WriteSuffix; override;
    procedure WriteTitle(ColumnsList: TColumnsEhList); override;
    procedure WriteFooter(ColumnsList: TColumnsEhList; FooterNo: Integer); override;
    procedure WriteRecord(ColumnsList: TColumnsEhList); override;
    procedure WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh); override;
    procedure WriteFooterCell(DataCol, Row: Integer; Column: TColumnEh; AFont: TFont; Background: TColor; Alignment: TAlignment; const Text: String); override;
  public
    procedure ExportToStream(Stream: TStream; IsExportAll: Boolean); override;
  end;

  { TDBGridEhExportAsCSV }

  TDBGridEhExportAsCSV = class(TDBGridEhExportAsText)
  private
    FSeparator: Char;
    FQuoteChar: Char;
  protected
    procedure CheckFirstRec; override;
    procedure CheckFirstCell; override;
    procedure WriteTitle(ColumnsList: TColumnsEhList); override;
    procedure WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh); override;
    procedure WriteFooterCell(DataCol, Row: Integer; Column: TColumnEh; AFont: TFont; Background: TColor; Alignment: TAlignment; const Text: String); override;
    procedure WriteSuffix; override;

  public
    constructor Create; override;

    property Separator: Char read FSeparator write FSeparator;
    property QuoteChar: Char read FQuoteChar write FQuoteChar;
  end;

  { TDBGridEhExportAsHTML }

  TDBGridEhExportAsHTML = class(TDBGridEhExport)
  private
    function GetAlignment(Alignment: TAlignment): String;
    function GetColor(Color: TColor): String;
    procedure PutText(Font: TFont; Text: String);
    procedure Put(const Text: String);
    procedure PutL(const Text: String);

  protected
    procedure WritePrefix; override;
    procedure WriteSuffix; override;
    procedure WriteTitle(ColumnsList: TColumnsEhList); override;
    procedure WriteRecord(ColumnsList: TColumnsEhList); override;
    procedure WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh); override;
    procedure WriteFooter(ColumnsList: TColumnsEhList; FooterNo: Integer); override;
    procedure WriteFooterCell(DataCol, Row: Integer; Column: TColumnEh; AFont: TFont; Background: TColor; Alignment: TAlignment; const Text: String); override;
  end;

  { TDBGridEhExportAsRTF }

  TDBGridEhExportAsRTF = class(TDBGridEhExport)
  private
    FCacheStream: TMemoryStreamEh;
    ColorTblList: TStrings;
    FontTblList: TStrings;
    function GetFontIndex(const FontName: String): Integer;
    function GetColorIndex(Color: TColor): Integer;
    function GetAlignment(Alignment: TAlignment): String;
    function GetDataCellColor(ColumnsList: TColumnsEhList; ColIndex: Integer): TColor;
    function GetFooterCellColor(ColumnsList: TColumnsEhList; ColIndex: Integer; FooterNo: Integer): TColor;

    procedure PutText(Font: TFont; Text: String; Background: TColor);
    procedure Put(const Text: String);
    procedure PutL(const Text: String);

  protected
    function StringToRtfString(const s: String): String;

    procedure WriteCellBorder(LeftBorder, TopBorder, BottomBorder, RightBorder: Boolean);
    procedure WritePrefix; override;
    procedure WriteSuffix; override;
    procedure WriteTitle(ColumnsList: TColumnsEhList); override;
    procedure WriteRecord(ColumnsList: TColumnsEhList); override;
    procedure WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh); override;
    procedure WriteFooter(ColumnsList: TColumnsEhList; FooterNo: Integer); override;
    procedure WriteFooterCell(DataCol, Row: Integer; Column: TColumnEh; AFont: TFont; Background: TColor; Alignment: TAlignment; const Text: String); override;

  public
    procedure ExportToStream(AStream: TStream; IsExportAll: Boolean); override;
  end;

  { TDBGridEhExportAsXLS }

  TDBGridEhExportAsXLS = class(TDBGridEhExport)
  private
    FCol, FRow: Word;
    procedure WriteBlankCell;
    procedure WriteIntegerCell(const AValue: Integer);
    procedure WriteFloatCell(const AValue: Double);
    procedure WriteStringCell(const AValue: String);
    procedure IncColRow;
  protected
    procedure WritePrefix; override;
    procedure WriteSuffix; override;
    procedure WriteTitle(ColumnsList: TColumnsEhList); override;
    procedure WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh); override;
    procedure WriteFooterCell(DataCol, Row: Integer; Column: TColumnEh; AFont: TFont; Background: TColor; Alignment: TAlignment; const Text: String); override;
  public
    procedure ExportToStream(AStream: TStream; IsExportAll: Boolean); override;
  end;

  { TDBGridEhExportAsVCLDBIF }

  {Internal format for interchange between DataSet based components}
  {BIFF2 file format Excel 2.x}

  { BOF (Beginning of File)

   Byte       |  0    1    2    3    4    5    6 |  0 |  0    1    2    3 |
              -------------------------------------------------------------
   Contents   |  V |  C |  L |  D |  B |  I |  F |  1 |  X |  X |  X |  X |
              -------------------------------------------------------------
              |  Signatura                       |Vers|  Columns count    |
              |                                  |ion |                   |


    Fields Names

   Byte       |  0 |  0    1    2    3   ...   X |  0 |  0    1    2    3   ...
              ------------------------------------------------------------- ...
   Contents   |  X |  N |  a |  m |  e |  1 |  0 |  X |  N |  a |  m |  e |  2 | 0
              ------------------------------------------------------------- ...
              |Colu| Null terminated field name  |Colu| Null terminated field name
              |mn  |                             |mn  |
              |visi|                             |visi|
              |ble 1 or 0                        |ble 1 or 0

    Values

  ----------------
    Unassigned, skip value
    ftUnknown,  ftCursor, ftADT, ftArray, ftReference, ftDataSet, ftVariant,
     ftInterface, ftIDispatch,

   Byte       |  0 |
              ------
   Contents   |  1 |
              ------
              |Type|
  ----------------
    NULL

   Byte       |  0 |
              ------
   Contents   |  2 |
              ------
              |Type|
  ----------------
    INTEGER32
    ftSmallint, ftInteger, ftWord, ftBoolean, ftAutoInc

   Byte       |  0 |  0    1    2    3 |
              --------------------------
   Contents   |  3 |  X |  X |  X |  X |
              --------------------------
              |Type|  Intetger value   |
                   |   (Longint)       |
  ----------------
    FLOAT64
    ftFloat, ftCurrency, ftBCD, ftDate, ftTime, ftDateTime,

   Byte       |  0 |  0    1    2    3    4    5    6    7 |
              ----------------------------------------------
   Contents   |  4 |  X |  X |  X |  X |  X |  X |  X |  X |
              ----------------------------------------------
              |Type|  Float value (Double)                 |
  ----------------
    STRING
    ftString, ftMemo, ftFixedChar, ftLargeint, ftOraClob, ftGuid

   Byte       |  0 |  0    1    2    3 |  0    1    2   ...   N |
              ---------------------------------------------------
   Contents   |  5 |  X |  X |  X |  X |  a |  b |  c | ...   0 |
              ---------------------------------------------------
              |Type|  Size (Longint)   |  String body including |
                                       |  null terminator       |
  ----------------
    BINARY DATA
    ftBlob, ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle, ftOraBlob,
     ftBytes, ftTypedBinary, ftVarBytes, ftWideString,

   Byte       |  0 |  0    1    2    3 |  0    1    2   ...   N |
              ---------------------------------------------------
   Contents   |  6 |  X |  X |  X |  X |  a |  b |  c | ...   X |
              ---------------------------------------------------
              |Type|  Size (Longword)   |  data                  |
  ----------------
    EOF (End of File)

   Byte       |  0 |
              ------
   Contents   |  0 |
              ------
              |Type|
  }

  TVCLDBIF_BOF = packed record
    Signatura: array[0..6] of AnsiChar;
    Version: Byte;
    ColCount: Longint;
  end;

  TVCLDBIF_INTEGER32 = packed record
    AType: Byte;
    Value: Longint;
  end;

  TVCLDBIF_FLOAT64 = packed record
    AType: Byte;
    Value: Double;
  end;

  TVCLDBIF_ANSI_STRING = packed record
    AType: Byte;
    Size: Longint;
  end;

  TVCLDBIF_WIDE_STRING = packed record
    AType: Byte;
    Size: Longint;
  end;

  TVCLDBIF_BINARY_DATA = packed record
    AType: Byte;
    Size: Longint;
  end;

  TDBGridEhExportAsVCLDBIF = class(TDBGridEhExport)
  protected
    procedure WritePrefix; override;
    procedure WriteSuffix; override;
    procedure WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh); override;
  end;

  { TDBGridEhExportAsOLEXLS }

{$IFDEF CIL}
{$ELSE}
  {$IFDEF MSWINDOWS}

  TDBGridEhExportAsOLEXLSOption = (oxlsColoredEh, oxlsDataAsDisplayText,
    oxlsDataAsEditText);
  TDBGridEhExportAsOLEXLSOptions = set of TDBGridEhExportAsOLEXLSOption;

  TDBGridEhExportAsOLEXLS = class(TDBGridEhExport)
  private
    FActiveSheet: Variant;
    FCurCol: Integer;
    FCurRow: Integer;
    FDataRowCount: Integer;
    FDataRowCountMode: Boolean;
    FDefaultSizeDelta: Double;
    FExcelApp: Variant;
    FIsExportAll: Boolean;
    FOptions: TDBGridEhExportAsOLEXLSOptions;
    FTitleRows: Integer;
    FVarValues: Variant;

  protected
    procedure CalcFooterValues; override;
    procedure WritePrefix; override;
    procedure WriteSuffix; override;
    procedure WriteRecord(ColumnsList: TColumnsEhList); override;
    procedure WriteTitle(ColumnsList: TColumnsEhList); override;
    procedure WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh); override;
    procedure WriteFooter(ColumnsList: TColumnsEhList; FooterNo: Integer); override;
    procedure WriteFooterCell(DataCol, Row: Integer; Column: TColumnEh; AFont: TFont; Background: TColor; Alignment: TAlignment; const Text: String); override;
    procedure SetFontIfNeed(Range: Variant; Font: TFont);
    procedure SetFont(Range: Variant; Font: TFont);

  public
    procedure ExportToStream(AStream: TStream; IsExportAll: Boolean); override;
    procedure ExportToFile(const FileName: String; IsExportAll: Boolean); override;
    function ExportToExcel(IsExportAll: Boolean; Options: TDBGridEhExportAsOLEXLSOptions): Variant; virtual;
  end;

  {$ELSE}
  {$ENDIF} 

 { TDBGridEhExportAsXlsx }

  TDBGridEhExportAsXlsxOption = (xlsxColoredEh, xlsxDataAsDisplayText,
    xlsxDataAsEditText);
  TDBGridEhExportAsXlsxOptions = set of TDBGridEhExportAsXlsxOption;

  RStyle=record
    NumFmt: integer;
    NumFont: integer;
    NumAlignment: integer;
    NumBackColor: integer;
    NumBorder: integer;
    Vertical: boolean;
    Wrap: boolean;
  end;

/// <summary>
/// TDBGridEhExportAsXlsx class is deprecated.
/// Use TDBGridEhToXlsMemFileExporter class or procedure ExportDBGridEhToXlsMemFile.
/// </summary>
  TDBGridEhExportAsXlsx = class(TDBGridEhExport)
  private
    FBackColor: array of TColor;
    FBorder: array of Integer;
    FCurCol: Integer;
    FCurRow: Integer;
    FDataRowCount: Integer;
    FFmtNode: IXMLNode;
    FFonts: array of TFont;
    FIsExportAll: Boolean;
    FNumFmt: Integer;
    FOptions: TDBGridEhExportAsXlsxOptions;
    FRowNode: IXMLNode;
    FSeparator: char;
    FSheetMergeCount: Integer;
    FSheetMergeStr: TStringStream;
    FSheetStr: TStringStream;
    FStyles: array of RStyle;
    FXMLStyles: IXMLDocument;
    FZipFileProvider: TCustomFileZipingProviderEh;

  protected
    function SetBackColor(Color: TColor): Integer;
    function SetBorder(Border: Integer): Integer;
    function SetFont(Font: TFont): Integer;
    function SetStyle(NumFmt: Integer; Font: TFont; Alignment: Integer; BackColor: TColor; Border: Integer; Vert, Wrap: Boolean): Integer;

    procedure CalcFooterValues; override;
    procedure WritePrefix; override;
    procedure WriteSuffix; override;
    procedure WriteRecord(ColumnsList: TColumnsEhList); override;
    procedure WriteTitle(ColumnsList: TColumnsEhList); override;
    procedure WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh); override;
    procedure WriteFooter(ColumnsList: TColumnsEhList; FooterNo: Integer); override;
    procedure WriteFooterCell(DataCol, Row: Integer; Column: TColumnEh; AFont: TFont; Background: TColor; Alignment: TAlignment; const Text: String); override;

  public

    procedure ExportToFile(const FileName: String; IsExportAll: Boolean); override;
    procedure ExportToStream(AStream: TStream; IsExportAll: Boolean); override;
  end;

{$ENDIF} 

  { TDBGridEhImport }

  TDBGridEhImport = class(TObject)
  private
    FDBGridEh: TCustomDBGridEh;
    FStream: TStream;
    FImpCols: TColumnsEhList;
  protected
    Eos: Boolean;
    procedure ReadPrefix; virtual;
    procedure ReadSuffix; virtual;
    procedure ReadRecord(ColumnsList: TColumnsEhList); virtual;
    procedure ReadDataCell(Column: TColumnEh); virtual;
    property Stream: TStream read FStream write FStream;
    property ImpCols: TColumnsEhList read FImpCols write FImpCols;
  public
    constructor Create; virtual;
    procedure ImportFromStream(AStream: TStream; IsImportAll: Boolean); virtual;
    procedure ImportFromFile(const FileName: String; IsImportAll: Boolean); virtual;
    property DBGridEh: TCustomDBGridEh read FDBGridEh write FDBGridEh;
  end;

  TDBGridEhImportClass = class of TDBGridEhImport;

  { TDBGridEhImportAsText }

  TImportTextSreamState = (itssChar, itssTab, itssNewLine, itssEof);

  TDBGridEhImportAsText = class(TDBGridEhImport)
  private
    FLastChar: Char;
    FLastState: TImportTextSreamState;
    FLastString: String;
    FIgnoreAll: Boolean;
    FStringStream: TStringStream;
    function GetChar(var ch: Char): Boolean;
    function CheckState: TImportTextSreamState;
    function GetString(var Value: String): TImportTextSreamState;
  protected
    procedure ReadPrefix; override;
    procedure ReadSuffix; override;
    procedure ReadRecord(ColumnsList: TColumnsEhList); override;
    procedure ReadDataCell(Column: TColumnEh); override;
  public
    procedure ImportFromStream(AStream: TStream; IsImportAll: Boolean); override;
  end;

  { TDBGridEhImportAsUnicodeText }

  TDBGridEhImportAsUnicodeText = class(TDBGridEhImport)
  private
    FLastChar: WideChar;
    FLastState: TImportTextSreamState;
    FLastString: WideString;
    FIgnoreAll: Boolean;
    function GetChar(var ch: WideChar): Boolean;
    function CheckState: TImportTextSreamState;
    function GetString(var Value: WideString): TImportTextSreamState;
  protected
    procedure ReadPrefix; override;
    procedure ReadRecord(ColumnsList: TColumnsEhList); override;
    procedure ReadDataCell(Column: TColumnEh); override;
  public
    procedure ImportFromStream(AStream: TStream; IsImportAll: Boolean); override;
  end;

  { TDBGridEhImportAsVCLDBIF }

  TDBGridEhImportAsVCLDBIF = class(TDBGridEhImport)
  private
    Prefix: TVCLDBIF_BOF;
    FIgnoreAll: Boolean;
    LastValue: Variant;
    FieldNames: TStringList;
    UseFieldNames: Boolean;
    procedure ReadValue;
  protected
    procedure ReadPrefix; override;
    procedure ReadRecord(ColumnsList: TColumnsEhList); override;
    procedure ReadDataCell(Column: TColumnEh); override;
  public
    procedure ImportFromStream(AStream: TStream; IsImportAll: Boolean); override;
  end;

  procedure WriteDataCellToStreamAsVCLDBIFData(Stream: TStream; Column: TAxisBarEh);
  procedure WriteVCLDBIFStreamPrefix(Stream: TStream; BarList: TAxisBarsEhList);
  procedure WriteVCLDBIFStreamSuffix(Stream: TStream);

  function ReadValueFromVCLDBIFStream(Stream: TStream; var Value: Variant): Boolean;
  procedure AssignAsixBarValueFromVCLDBIFStream(var Value: Variant; AxisBar: TAxisBarEh; var IgnoreAssignError: Boolean);
  procedure ReadVCLDBIFStreamPrefix(Stream: TStream; var Prefix: TVCLDBIF_BOF; FieldList: TStringList);

type

{ TDBGridEhStringExportOptions }

  TDBGridEhStringExportOptions = class(TPersistent)
  private
    FUseFormatSettings: Boolean;
    FLineDelimiter: String;
    FCellDelimiter: String;
    FUseEditFormat: Boolean;
    FQuoteChar: Char;
    FIsExportTitle: Boolean;
    FTrailingLineDelimiter: Boolean;
{$IFDEF EH_LIB_17} 
    FFormatSettings: TFormatSettings;
{$ELSE}
    FFormatSettings: TFormatSettingsProxyEh;
{$ENDIF}
    FIsExportFooter: Boolean;
    FIsExportSelecting: Boolean;
    FExportColumns: TColumnsEhList;

    procedure SetExportColumns(const Value: TColumnsEhList);

  public
    constructor Create; virtual;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;

    property IsExportSelecting: Boolean read FIsExportSelecting write FIsExportSelecting;
    property CellDelimiter: String read FCellDelimiter write FCellDelimiter;
    property LineDelimiter: String read FLineDelimiter write FLineDelimiter;
    property TrailingLineDelimiter: Boolean read FTrailingLineDelimiter write FTrailingLineDelimiter;
    property QuoteChar: Char read FQuoteChar write FQuoteChar;
    property IsExportTitle: Boolean read FIsExportTitle write FIsExportTitle;
    property IsExportFooter: Boolean read FIsExportFooter write FIsExportFooter;
    property UseEditFormat: Boolean read FUseEditFormat write FUseEditFormat;
{$IFDEF EH_LIB_17} 
    property FormatSettings: TFormatSettings read FFormatSettings write FFormatSettings;
{$ELSE}
    property FormatSettings: TFormatSettingsProxyEh read FFormatSettings write FFormatSettings;
{$ENDIF}
    property UseFormatSettings: Boolean read FUseFormatSettings write FUseFormatSettings;
    property ExportColumns: TColumnsEhList read FExportColumns write SetExportColumns;
    //property OnFixCellText :
  end;

{ TDBGridEhTextExportOptions }

  TDBGridEhTextExportOptions = class(TDBGridEhStringExportOptions)
  private
    FEncoding: TEncoding; //Default UTF8
    FWriteBOM: Boolean;
  public
    constructor Create; override;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;

    property Encoding: TEncoding read FEncoding write FEncoding;
    property WriteBOM: Boolean read FWriteBOM write FWriteBOM;
  end;

{ TDBGridEhToStringExporter }

  TDBGridEhToStringExporter = class
  private
    FGrid: TCustomDBGridEh;
    FExportOptions: TDBGridEhStringExportOptions;
    FExpCols: TColumnsEhList;
    FooterValues: TFooterValues;
    FStringBuilder: TStringBuilder;
    FColCellParamsEh: TColCellParamsEh;
    procedure SetExportOptions(const Value: TDBGridEhStringExportOptions);
    function GetResultString: String;

  protected
    FLastLineBuffer: String;

    function CreateExportOptions: TDBGridEhStringExportOptions; virtual;
    function GetFooterValue(Row, Col: Integer): String; virtual;
    function CheckQuoteString(s: String): String; virtual;

    procedure CalcFooterValues; virtual;
    procedure PushLastLineBuffer; virtual;

    procedure WritePrefix; virtual;
    procedure WriteSuffix; virtual;
    procedure WriteRecord; virtual;
    procedure WriteTitle; virtual;
    procedure WriteFooter; virtual;
    procedure WriteFooterRow(FooterNo: Integer); virtual;
    procedure WriteString(s: String); virtual;
    procedure WriteValue(s: String); virtual;
    procedure WriteEndOfCell; virtual;
    procedure WriteEndOfLine; virtual;
    procedure WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh); virtual;
    procedure WriteFooterCell(Column: TColumnEh; const Text: String); virtual;

  public
    constructor Create; virtual;
    destructor Destroy; override;

    procedure ExportGrid; virtual;

    property Grid: TCustomDBGridEh read FGrid write FGrid;
    property ExportOptions: TDBGridEhStringExportOptions read FExportOptions write SetExportOptions;
    property ResultString: String read GetResultString;
  end;

{ TDBGridEhToTextExporter }

  TDBGridEhToTextExporter = class(TDBGridEhToStringExporter)
  private
    function GetExportOptions: TDBGridEhTextExportOptions;
    procedure SetExportOptions(const Value: TDBGridEhTextExportOptions);
  protected
    procedure WriteSuffix; override;

  public
    constructor Create; override;
    destructor Destroy; override;

    procedure ExportToStream(AStream: TStream); virtual;
    procedure ExportToFile(AFileName: String); virtual;

    property ExportOptions: TDBGridEhTextExportOptions read GetExportOptions write SetExportOptions;
  end;

{ Routines to import/export DBGridEh to/from file/stream }

procedure SaveDBGridEhToTextFile(DBGridEh: TCustomDBGridEh; const FileName: String;
  ExportOptions:  TDBGridEhTextExportOptions);

procedure WriteDBGridEhToTextStream(DBGridEh: TCustomDBGridEh; Stream: TStream;
  ExportOptions: TDBGridEhTextExportOptions);

function WriteDBGridEhToString(DBGridEh: TCustomDBGridEh;
  ExportOptions: TDBGridEhStringExportOptions): String;

procedure SaveDBGridEhToExportFile(ExportClass: TDBGridEhExportClass;
  DBGridEh: TCustomDBGridEh; const FileName: String; IsSaveAll: Boolean);
procedure WriteDBGridEhToExportStream(ExportClass: TDBGridEhExportClass;
  DBGridEh: TCustomDBGridEh; Stream: TStream; IsSaveAll: Boolean);

procedure LoadDBGridEhFromImportFile(ImportClass: TDBGridEhImportClass;
  DBGridEh: TCustomDBGridEh; const FileName: String; IsLoadToAll: Boolean);
procedure ReadDBGridEhFromImportStream(ImportClass: TDBGridEhImportClass;
  DBGridEh: TCustomDBGridEh; Stream: TStream; IsLoadToAll: Boolean);


var
  CF_VCLDBIF: Word;

var
  ExtendedVCLDBIFImpExpRowSelect: Boolean = True;
  DBGridEhImpExpCsvSeparator: Char = ';';
  DBGridEhImpExpCsvQuoteChar: Char = '"';

procedure DBGridEh_DoCutAction(DBGridEh: TCustomDBGridEh; ForWholeGrid: Boolean);
procedure DBGridEh_DoCopyAction(DBGridEh: TCustomDBGridEh; ForWholeGrid: Boolean);
procedure DBGridEh_DoPasteAction(DBGridEh: TCustomDBGridEh; ForWholeGrid: Boolean);
procedure DBGridEh_DoDeleteAction(DBGridEh: TCustomDBGridEh; ForWholeGrid: Boolean);

procedure Clipboard_PutFromStream(Format: Word; ms: TMemoryStream);
procedure Clipboard_GetToStream(Format: Word; ms: TMemoryStream);

{$IFDEF CIL}
{$ELSE}

{$IFDEF MSWINDOWS}
function ExportDBGridEhToOleExcel(DBGridEh: TCustomDBGridEh;
  Options: TDBGridEhExportAsOLEXLSOptions; IsSaveAll: Boolean = True
  ): Variant;
{$ELSE}
{$ENDIF} //MSWINDOWS

/// <summary>
/// This version of the procedure is deprecated.
/// Use TDBGridEhToXlsMemFileExporter with Options parameter of TDBGridEhXlsMemFileExportOptions type
/// </summary>
procedure ExportDBGridEhToXlsx(DBGridEh: TCustomDBGridEh;
    const FileName: String;
    Options: TDBGridEhExportAsXlsxOptions; IsSaveAll: Boolean = True);  overload;

procedure ExportDBGridEhToXlsx(DBGridEh: TCustomDBGridEh; const FileName: String;
  ExportOptions: TDBGridEhXlsMemFileExportOptions); overload;

procedure ExportDBGridEhToXlsx(DBGridEh: TCustomDBGridEh; const FileName: String;
  ExportOptions: TDBGridEhXlsMemFileExportOptions; ExporterClass: TDBGridEhToXlsMemFileExporterClass); overload;
{$ENDIF} //ELSE CIL

procedure CalcMultiTitleMatrix(DBGridEh: TCustomDBGridEh; out TitleMarix: TDBGridMultiTitleExportNodeMatrixEh);
procedure FreeMultiTitleMatrix(TitleMarix: TDBGridMultiTitleExportNodeMatrixEh);

function ClipboardToVarDynaTable: TVarDynaTableEh;

implementation

uses EhLibLangConsts, Forms,
  {$IFDEF FPC}
  {$ELSE}
  DbConsts,
  {$ENDIF}
  DBGridEhGrouping, DBGridEhXMLSpreadsheetExp, XMLSpreadsheetFormatEh;

{ Routines to import/export DBGridEh to/from file/stream }

procedure WriteDBGridEhToExportStream(ExportClass: TDBGridEhExportClass;
  DBGridEh: TCustomDBGridEh; Stream: TStream; IsSaveAll: Boolean);
var
  DBGridEhExport: TDBGridEhExport;
begin
  DBGridEhExport := ExportClass.Create;
  try
    DBGridEhExport.DBGridEh := DBGridEh;
    DBGridEhExport.ExportToStream(Stream, IsSaveAll);
  finally
    DBGridEhExport.Free;
  end;
end;

procedure SaveDBGridEhToExportFile(ExportClass: TDBGridEhExportClass;
  DBGridEh: TCustomDBGridEh; const FileName: String; IsSaveAll: Boolean);
var
  DBGridEhExport: TDBGridEhExport;
begin
  DBGridEhExport := ExportClass.Create;
  try
    DBGridEhExport.DBGridEh := DBGridEh;
    DBGridEhExport.ExportToFile(FileName, IsSaveAll);
  finally
    DBGridEhExport.Free;
  end;
end;

procedure LoadDBGridEhFromImportFile(ImportClass: TDBGridEhImportClass;
  DBGridEh: TCustomDBGridEh; const FileName: String; IsLoadToAll: Boolean);
var
  DBGridEhImport: TDBGridEhImport;
begin
  DBGridEhImport := ImportClass.Create;
  try
    DBGridEhImport.DBGridEh := DBGridEh;
    DBGridEhImport.ImportFromFile(FileName, IsLoadToAll);
  finally
    DBGridEhImport.Free;
  end;
end;

procedure ReadDBGridEhFromImportStream(ImportClass: TDBGridEhImportClass;
  DBGridEh: TCustomDBGridEh; Stream: TStream; IsLoadToAll: Boolean);
var
  DBGridEhImport: TDBGridEhImport;
begin
  DBGridEhImport := ImportClass.Create;
  try
    DBGridEhImport.DBGridEh := DBGridEh;
    DBGridEhImport.ImportFromStream(Stream, IsLoadToAll);
  finally
    DBGridEhImport.Free;
  end;
end;

{$IFDEF FPC_CROSSP}
{$ELSE}
var
  CF_CSV: Word;
  CF_RICH_TEXT_FORMAT: Word;
{$ENDIF}

procedure Clipboard_PutFromStream(Format: Word; ms: TMemoryStream);
{$IFDEF FPC_CROSSP}
begin
//  if (Format = CF_Text) then
  Clipboard.AddFormat(Format, ms);
end;
{$ELSE}
var
  Data: THandle;
  DataPtr: Pointer;
  Buffer: Pointer;
begin
  Buffer := ms.Memory;
  ClipBoard.Open;
  try
    Data := GlobalAlloc(GMEM_MOVEABLE + GMEM_DDESHARE, ms.Size);
    try
      DataPtr := GlobalLock(Data);
      try
{$IFDEF CIL}
        Marshal.Copy(ms.Memory, 0, DataPtr, ms.Size);
{$ELSE}
        Move(Buffer^, DataPtr^, ms.Size);
{$ENDIF}
{$IFDEF FPC}
        SetClipboardData(Format, Data);
{$ELSE}
        ClipBoard.SetAsHandle(Format, Data);
{$ENDIF}
      finally
        GlobalUnlock(Data);
      end;
    except
      GlobalFree(Data);
      raise;
    end;
  finally
    ClipBoard.Close;
  end;
end;
{$ENDIF}

procedure Clipboard_GetToStream(Format: Word; ms: TMemoryStream);
{$IFDEF FPC_CROSSP}
begin
  Clipboard.GetFormat(Format, ms);
end;
{$ELSE}
var
  Data: THandle;
  DataPtr: Pointer;
{$IFDEF CIL}
  DataBytes: TBytes;
{$ENDIF}
begin
  ClipBoard.Open;
  try
    {$IFDEF FPC}
    Data := GetClipboardData(Format);
    {$ELSE}
    Data := ClipBoard.GetAsHandle(Format);
    {$ENDIF}
    if Data = 0 then Exit;
    DataPtr := GlobalLock(Data);
    if DataPtr = nil then Exit;
    try
{$IFDEF CIL}
      SetLength(DataBytes, GlobalSize(Data));
      Marshal.Copy(DataPtr, DataBytes, 0, GlobalSize(Data));
      ms.WriteBuffer(DataBytes, Length(DataBytes));
{$ELSE}
      ms.WriteBuffer(DataPtr^, GlobalSize(Data));
{$ENDIF}
    finally
      GlobalUnlock(Data);
    end;
  finally
    ClipBoard.Close;
  end;
end;
{$ENDIF} 

procedure DBGridEh_DoCutAction(DBGridEh: TCustomDBGridEh; ForWholeGrid: Boolean);
begin
  DBGridEh_DoCopyAction(DBGridEh, ForWholeGrid);
  DBGridEh_DoDeleteAction(DBGridEh, ForWholeGrid);
end;

procedure DBGridEh_DoDeleteAction(DBGridEh: TCustomDBGridEh; ForWholeGrid: Boolean);
var
  i: Integer;
  ColList: TColumnsEhList;
  ASelectionType: TDBGridEhSelectionType;
  gr: TCustomDBGridEh;
  ds: TDataSet;
  DelStartTime: Longword;
  DelWaitStarted: Boolean;
  SaveCursor: TCursor;

  procedure ClearColumns;
  var
    i, j: Integer;
    Field: TField;
    FDataFields: TFieldsArrEh;

    procedure ClearField;
    begin
      if Field.DataSet.CanModify then
      begin
        Field.DataSet.Edit;
        if Field.DataSet.State in [dsEdit, dsInsert] then
          Field.Clear;
      end;
    end;

  begin
    FDataFields := nil;
    for i := 0 to ColList.Count - 1 do
    begin
      if ColList[i].CanModify(False) then
      begin
        if ColList[i].LookupParams.LookupActive then
        begin
          FDataFields := GetFieldsProperty(DBGridEh.DataSource.Dataset,
            nil, ColList[i].LookupParams.KeyFieldNames);
          for j := 0 to Length(FDataFields)-1 do
          begin
            Field := FDataFields[j];
            ClearField;
          end;
        end else
        begin
          Field := ColList[i].Field;
          ClearField;
        end;
      end;
    end;
  end;

  function DeletePrompt: Boolean;
  var
    Msg: string;
  begin
    Result := True;
    if ASelectionType = gstRecordBookmarks then
      if (DBGridEh.Selection.Rows.Count > 1) then
        Msg := Format(EhLibLanguageConsts.DeleteMultipleRecordsQuestionEh, [DBGridEh.Selection.Rows.Count])
      else
      {$IFDEF FPC}
        Msg :='SDeleteRecordQuestion'
      {$ELSE}
        Msg :=SDeleteRecordQuestion
      {$ENDIF}
    else if ASelectionType = gstAll then
      Msg := EhLibLanguageConsts.DeleteAllRecordsQuestionEh
    else if ASelectionType = gstRectangle then
      Msg := EhLibLanguageConsts.ClearSelectedCells
    else
      Exit;
    Result := not (dgConfirmDelete in DBGridEh.Options) or
      (MessageDlg(Msg, mtConfirmation, mbOKCancel, 0) <> idCancel);
  end;

begin
  gr := DBGridEh;
  begin
    if ForWholeGrid
      then ASelectionType := gstAll
      else ASelectionType := gr.Selection.SelectionType;
    if (ASelectionType = gstNon) or
       (gr.DataSource = nil) or
       (gr.DataSource.Dataset = nil) or
        not DeletePrompt
    then
      Exit;
    ds := gr.DataSource.Dataset;
    begin
      gr.SaveBookmark;
      ds.DisableControls;
      try
        case ASelectionType of
          gstRecordBookmarks:
            begin
              DelWaitStarted := False;
              SaveCursor := crDefault;
              try
                ColList := gr.VisibleColumns;
                DelStartTime := GetTickCountEh;
                for i := gr.Selection.Rows.Count - 1 downto 0 do
                begin
                  ds.Bookmark := gr.Selection.Rows[I];
                  ds.Delete;
                  if not DelWaitStarted and
                     (GetTickCountEh - DelStartTime > 1000) then
                  begin
                    SaveCursor := Screen.Cursor;
                    Screen.Cursor := crHourGlass;
                    DelWaitStarted := True;
                  end;
                end;
                gr.Selection.Clear;
              finally
                if (DelWaitStarted) then
                  Screen.Cursor := SaveCursor;
              end;
            end;
          gstRectangle:
            begin
              ColList := TColumnsEhList.Create;
              try
                for i := gr.Selection.Rect.LeftCol to gr.Selection.Rect.RightCol do
                  if gr.Columns[i].Visible then
                    ColList.Add(gr.Columns[i]);
                ds.Bookmark := gr.Selection.Rect.TopRow;
                while True do
                begin
                  ClearColumns;
                  if DataSetCompareBookmarks(DBGridEh.DataSource.Dataset,
                    gr.Selection.Rect.BottomRow, ds.Bookmark) = 0 then Break;
                  ds.Next;
                  if ds.Eof then Break;
                end;
              finally
                ColList.Free;
              end;
              gr.RestoreBookmark;
            end;
          gstColumns:
            begin
              ColList := gr.Selection.Columns;
              ds.First;
              while ds.Eof = False do
              begin
                ClearColumns;
                ds.Next;
              end;
              gr.RestoreBookmark;
            end;
          gstAll:
            begin
              ColList := gr.VisibleColumns;
              ds.First;
              DelWaitStarted := False;
              SaveCursor := crDefault;
              DelStartTime := GetTickCountEh;
              try
                while ds.Eof = False do
                begin
                  ds.Delete;
                  if not DelWaitStarted and
                     (GetTickCountEh - DelStartTime > 1000) then
                  begin
                    SaveCursor := Screen.Cursor;
                    Screen.Cursor := crHourGlass;
                    DelWaitStarted := True;
                  end;
                end;
              finally
                if (DelWaitStarted) then
                  Screen.Cursor := SaveCursor;
              end;
            end;
        end;
      finally
        ds.EnableControls;
      end;
    end;
  end;
end;

procedure Clipboard_PutUnicodeFromStream(ms: TMemoryStream);
{$IFDEF FPC_CROSSP}
begin
end;
{$ELSE}
var
  Data: THandle;
  DataPtr: Pointer;
  BufSize: Integer;
  Buffer: Pointer;
begin
  Buffer := ms.Memory;
  ClipBoard.Open;
  try
    BufSize := MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, Buffer, ms.Size,
      nil, 0) * 2;
    Data := GlobalAlloc(GMEM_MOVEABLE + GMEM_DDESHARE, BufSize);
    try
      DataPtr := GlobalLock(Data);
      MultiByteToWideChar(CP_ACP, MB_PRECOMPOSED, Buffer, ms.Size, DataPtr,
        BufSize div 2);
      try
        {$IFDEF FPC}
        SetClipboardData(CF_UNICODETEXT, Data);
        {$ELSE}
        ClipBoard.SetAsHandle(CF_UNICODETEXT, Data);
        {$ENDIF}
      finally
        GlobalUnlock(Data);
      end;
    except
      GlobalFree(Data);
      raise;
    end;
  finally
    ClipBoard.Close;
  end;
end;
{$ENDIF} 

procedure SreamWriteNullAnsiStr(st: TStream);
begin
{$IFDEF CIL}
    st.WriteBuffer([0,0], 2);
{$ELSE}
  {$IFDEF FPC}
  {$ELSE}
   st.WriteBuffer(PAnsiChar('')^, 1);
  {$ENDIF}
{$ENDIF}
end;

procedure SreamWriteNullWideStr(st: TStream);
const WS: WideString = '';
begin
{$IFDEF CIL}
    st.WriteBuffer([0], 1);
{$ELSE}
    st.WriteBuffer(PWideChar(WS)^, 2);
{$ENDIF}
end;

procedure DBGridEh_DoCopyAction(DBGridEh: TCustomDBGridEh; ForWholeGrid: Boolean);
//
//begin
//end;
var
  ms: TMemoryStreamEh;
begin
  ms := nil;
  Clipboard.Open;

  DBGridEh.DataSource.Dataset.DisableControls;
  try
    ms := TMemoryStreamEh.Create;
    ms.HalfMemoryDelta := $10000;

    WriteDBGridEhToExportStream(TDBGridEhExportAsText, DBGridEh, ms, ForWholeGrid);
    SreamWriteNullAnsiStr(ms);
    Clipboard_PutFromStream(CF_TEXT, ms);
    ms.Clear;

    {$IFDEF FPC_CROSSP}
    {$ELSE}
    WriteDBGridEhToExportStream(TDBGridEhExportAsUnicodeText, DBGridEh, ms, ForWholeGrid);
    SreamWriteNullWideStr(ms);
    Clipboard_PutFromStream(CF_UNICODETEXT, ms);
    ms.Clear;

    WriteDBGridEhToExportStream(TDBGridEhExportAsCSV, DBGridEh, ms, ForWholeGrid);
    SreamWriteNullAnsiStr(ms);
    Clipboard_PutFromStream(CF_CSV, ms);
    ms.Clear;

    WriteDBGridEhToExportStream(TDBGridEhExportAsRTF, DBGridEh, ms, ForWholeGrid);
    SreamWriteNullAnsiStr(ms);
    Clipboard_PutFromStream(CF_RICH_TEXT_FORMAT, ms);
    ms.Clear;
    {$ENDIF} 

    WriteDBGridEhToExportStream(TDBGridEhExportAsVCLDBIF, DBGridEh, ms, ForWholeGrid);
    Clipboard_PutFromStream(CF_VCLDBIF, ms);
    ms.Clear;

    WriteDBGridEhToExportStream(TDBGridEhExportAsXMLSpreadsheet, DBGridEh, ms, ForWholeGrid);
    Clipboard_PutFromStream(CF_XML_Spreadsheet, ms);
    ms.Clear;

    { This version of HTML and Biff export routines does not work under MS Office

    WriteDBGridEhToExportStream(TDBGridEhExportAsHTML,DBGridEh,ms,ForWholeGrid);
    Clipboard_PutFromStream(CF_HTML_FORMAT,ms);
    ms.Clear;

    WriteDBGridEhToExportStream(TDBGridEhExportAsXLS,DBGridEh,ms,ForWholeGrid);
    Clipboard_PutFromStream(CF_BIFF,ms);
    ms.Clear;
    }

  finally
    ms.Free;
    Clipboard.Close;
    DBGridEh.DataSource.Dataset.EnableControls;
  end;
end;

procedure PasteVarDynaTableToDBGridEh(VarDynaTable: TVarDynaTableEh;
 DBGridEh: TCustomDBGridEh; ForWholeGrid: Boolean);
var
  i: Integer;
  ColList: TColumnsEhList;
  Inserting: Boolean;
  Appending: Boolean;
  gr: TCustomDBGridEh;
  ds: TDataSet;
  LineNo: Integer;
  FIgnoreAll: Boolean;

  Eos: Boolean;

  TableColIndex: Integer;
  TableRowIndex: Integer;
  TableRowCount: Integer;

  procedure ReadDataCell(Column: TColumnEh; CellValue: Variant);
  begin
    AssignAsixBarValueFromVCLDBIFStream(CellValue, Column, FIgnoreAll);
  end;

  procedure ReadRecord(ImpCols: TColumnsEhList);
  var
    i: Integer;
    CellValue: Variant;
  begin
    TableColIndex := 0;
    for i := 0 to ImpCols.Count - 1 do
    begin
      if TableColIndex >= Length(VarDynaTable[TableRowIndex]) then
        Break;
      CellValue := VarDynaTable[TableRowIndex][TableColIndex];
      ReadDataCell(ImpCols[i], CellValue);
      Inc(TableColIndex);
    end;
    Inc(TableRowIndex);
    if (TableRowIndex = TableRowCount) then
    begin
      if (gr.Selection.SelectionType = gstNon) then
        Eos := True
      else
        TableRowIndex := 0;
    end;
  end;

  procedure ReadRecordWithInsert(ImpCols: TColumnsEhList);
  begin
    while not Eos do
    begin
      if (LineNo > 0) and
         (ds.State in [dsEdit, dsInsert])
      then
        ds.Post;
      if Appending
        then ds.Append
        else ds.Insert;
      ReadRecord(ImpCols);
      if not Appending and not Eos then
        ds.Next;
      Inc(LineNo);
    end;
    if (LineNo > 1) and
       (ds.State in [dsEdit, dsInsert])
    then
      ds.Post;
  end;

begin
  Eos := False;

  TableRowCount := Length(VarDynaTable);
  TableColIndex := 0;
  TableRowIndex := 0;

  gr := DBGridEh;
  begin
    if ForWholeGrid then
    begin
      gr.Selection.Clear;
      gr.DataSource.Dataset.First;
      if gr.VisibleColumns.Count > 0 then
        gr.SelectedIndex := gr.VisibleColumns.Items[0].Index;
    end;
    ds := gr.DataSource.Dataset;
    begin
      if ds.Eof
        then Appending := True
        else Appending := False;
      if ds.State = dsInsert
        then Inserting := True
        else Inserting := False;
      if not Inserting then gr.SaveBookmark;
      ds.DisableControls;
      try
        case gr.Selection.SelectionType of
          gstRecordBookmarks:
            begin
              //ImpCols := gr.VisibleColumns;
              //ReadPrefix;
              if Inserting then
                ReadRecordWithInsert(gr.VisibleColumns)
              else
                for i := 0 to gr.Selection.Rows.Count - 1 do
                begin
                  ds.Bookmark := gr.Selection.Rows[I];
                  ReadRecord(gr.VisibleColumns);
                end;
            end;
          gstRectangle:
            begin
              ColList := TColumnsEhList.Create;
              //ImpCols := ColList;
              try
                for i := gr.Selection.Rect.LeftCol to gr.Selection.Rect.RightCol do
                  if gr.Columns[i].Visible then
                    ColList.Add(gr.Columns[i]);
                //ImpCols := ColList;
                //ReadPrefix;
                if Inserting then
                  ReadRecordWithInsert(ColList)
                else
                begin
                  ds.Bookmark := gr.Selection.Rect.TopRow;
                  while True do
                  begin
                    ReadRecord(ColList);
                    if DataSetCompareBookmarks(DBGridEh.DataSource.Dataset,
                      gr.Selection.Rect.BottomRow, ds.Bookmark) = 0 then Break;
                    ds.Next;
                    if ds.Eof then Break;
                  end;
                end;
              finally
                ColList.Free;
              end;
            end;
          gstColumns:
            begin
              //ImpCols := gr.Selection.Columns;
              //ReadPrefix;
              if Inserting then
                ReadRecordWithInsert(gr.Selection.Columns)
              else
              begin
                ds.First;
                while ds.Eof = False do
                begin
                  ReadRecord(gr.Selection.Columns);
                  ds.Next;
                end;
              end;
            end;
          gstAll:
            begin
              //ImpCols := gr.VisibleColumns;
              //ReadPrefix;
              if Inserting then
                ReadRecordWithInsert(gr.VisibleColumns)
              else
              begin
                ds.First;
                while ds.Eof = False do
                begin
                  ReadRecord(gr.VisibleColumns);
                  ds.Next;
                end;
              end;
            end;
          gstNon:
            begin
              ColList := TColumnsEhList.Create;
              try
                for i := gr.SelectedIndex to gr.Columns.Count - 1 do
                  if gr.Columns[i].Visible then ColList.Add(gr.Columns[i]);
                //ImpCols := ColList;
                //ReadPrefix;
                LineNo := 0;
                if Inserting then
                  ReadRecordWithInsert(ColList)
                else
                begin
                  gr.RestoreBookmark;
                  while True do
                  begin
                    ReadRecord(ColList);
                    if Eos then Break;
                    ds.Next;
                    Inc(LineNo);
                    if ds.Eof then Break;
                  end;
                  if (LineNo >= 1) and
                     (ds.State in [dsEdit, dsInsert])
                  then
                    ds.Post;
                  if alopAppendEh in DBGridEh.AllowedOperations then
                  begin
                    Inserting := True;
                    Appending := True;
                    ReadRecordWithInsert(ColList);
                  end;
                end;
              finally
                ColList.Free;
              end;
            end;
        end;
      finally
        if not Inserting then
          gr.RestoreBookmark;
        ds.EnableControls;
      end;
    end;
  end;
  //ReadSuffix;
end;

procedure DBGridEh_DoPasteAction(DBGridEh: TCustomDBGridEh; ForWholeGrid: Boolean);
var
 VarDynaTable: TVarDynaTableEh;
begin
  VarDynaTable := ClipboardToVarDynaTable;
  if Length(VarDynaTable) = 0 then Exit;

  PasteVarDynaTableToDBGridEh(VarDynaTable, DBGridEh, ForWholeGrid);
end;

procedure StreamWriteAnsiString(Stream: TStream; const S: AnsiString);
{$IFDEF CIL}
var
  b: TBytes;
{$ENDIF}
begin
{$IFDEF CIL}
    b := BytesOf(AnsiString(S));
    Stream.Write(b, Length(b));
{$ELSE}
    Stream.Write(PAnsiChar(S)^, Length(S));
{$ENDIF}
end;

procedure StreamWriteWideString(Stream: TStream; const S: WideString);
{$IFDEF CIL}
var
  b: TBytes;
{$ENDIF}
begin
{$IFDEF CIL}
    b := BytesOf(S);
    Stream.Write(b, Length(b));
{$ELSE}
    Stream.Write(PWideChar(S)^, Length(S)*2);
{$ENDIF}
end;

function VclBifStreamToVarDynaTable(Stream: TStream): TVarDynaTableEh;
var
  Prefix: TVCLDBIF_BOF;
  Eos: Boolean;
  LastValue: Variant;
  //FIgnoreAll: Boolean;
  VarList: TList<TVariantArrayEh>;
  RowIndex: Integer;
  ColIndex: Integer;
  I: Integer;

  procedure ReadNextValue;
  begin
    if Eos then Exit;

    if not ReadValueFromVCLDBIFStream(Stream, LastValue) then
      Eos := True;
  end;

  procedure ReadDataCell();
  var
    VarArr: TVariantArrayEh;
  begin
    Inc(ColIndex);

    if (RowIndex = -1) then
    begin
      SetLength(VarArr, Prefix.ColCount);
      VarList.Add(VarArr);
      RowIndex := 0;
    end else if (ColIndex = Prefix.ColCount) then
    begin
      SetLength(VarArr, Prefix.ColCount);
      VarList.Add(VarArr);
      Inc(RowIndex);
      ColIndex := 0;
    end;

    VarList[RowIndex][ColIndex] := LastValue;

    ReadNextValue();
  end;

begin
  ReadVCLDBIFStreamPrefix(Stream, Prefix, nil);

  ColIndex := -1;
  RowIndex := -1;
  VarList := TList<TVariantArrayEh>.Create;

  ReadNextValue;

  while not Eos do
  begin
    ReadDataCell();
  end;

  SetLength(Result, VarList.Count);

  for I := 0 to VarList.Count - 1 do
    Result[I] := VarList[I];

  VarList.Free;
end;

function TextToVarDynaTable(Text: String): TVarDynaTableEh;
var
  StrList: TStringList;
  LineList: TStringList;
  I: Integer;
  J: Integer;
begin
  StrList := TStringList.Create;
  LineList := TStringList.Create;
  LineList.Delimiter := #09; //Tab
  LineList.StrictDelimiter := True;
  try
    StrList.Text := Text;
    SetLength(Result, StrList.Count);

    for I := 0 to StrList.Count - 1 do
    begin
      LineList.DelimitedText := StrList[I];
      SetLength(Result[I], LineList.Count);
      for J := 0 to LineList.Count - 1 do
      begin
        Result[I][J] := LineList[J];
      end;
    end;
  finally
    StrList.Free;
  end;
end;

function ClipboardToVarDynaTable: TVarDynaTableEh;
var
  ms: TMemoryStream;
  Data: THandle;
  Text: String;
begin
  if Clipboard.HasFormat(CF_VCLDBIF) then
  begin
    ms := TMemoryStream.Create;
    Clipboard_GetToStream(CF_VCLDBIF, ms);
    ms.Position := 0;
    Result := VclBifStreamToVarDynaTable(ms);
    ms.Free;
  end

  {$IFDEF FPC_CROSSP}
  ;
  {$ELSE}
  else if Clipboard.HasFormat(CF_UNICODETEXT) then
  begin
    Result := TextToVarDynaTable(Clipboard.AsText);
  end
  else if Clipboard.HasFormat(CF_TEXT) then
  begin
    Clipboard.Open;
    Data := GetClipboardData(CF_TEXT);
    try
      if Data <> 0
        then Text := String(PAnsiChar(GlobalLock(Data)))
        else Text := '';
      Result := TextToVarDynaTable(Text);
    finally
      if Data <> 0 then
        GlobalUnlock(Data);
      Clipboard.Close;
    end;
  end;
  {$ENDIF} 
end;

{ TDBGridEhExport }

procedure TDBGridEhExport.ExportToFile(const FileName: String; IsExportAll: Boolean);
var
  FileStream: TFileStream;
begin
  FileStream := TFileStream.Create(FileName, fmCreate);
  try
    ExportToStream(FileStream, IsExportAll);
  finally
    FileStream.Free;
  end;
end;

procedure TDBGridEhExport.ExportToStream(AStream: TStream; IsExportAll: Boolean);
var
  i: Integer;
  ColList: TColumnsEhList;
  IsFreeColList: Boolean;
  ASelectionType: TDBGridEhSelectionType;
  gr: TCustomDBGridEh;
  ds: TDataSet;
  RestoreBookmarkIsNeed: Boolean;
begin
  Stream := AStream;
  ColList := nil;
  IsFreeColList := False;
  try
    gr := DBGridEh;
    begin
      if IsExportAll
        then ASelectionType := gstAll
        else ASelectionType := gr.Selection.SelectionType;
      ds := gr.DataSource.Dataset;
      begin
        ds.DisableControls;
        gr.SaveBookmark;
        RestoreBookmarkIsNeed := True;
        try
          case ASelectionType of
            gstNon:
              begin
                RestoreBookmarkIsNeed := False;
                if not ( (gr.DataSource <> nil) and (gr.DataSource.DataSet <> nil) and
                      not gr.DataSource.DataSet.IsEmpty )
                then
                  Exit;
                ColList := TColumnsEhList.Create;
                IsFreeColList := True;
                ColList.Add(gr.Columns[gr.SelectedIndex]);
                if ExpCols = nil then
                  ExpCols := ColList;
                WritePrefix;
                WriteRecord(ColList);
              end;
            gstRecordBookmarks:
              begin
                if ExpCols = nil then
                  ExpCols := gr.VisibleColumns;
                SetLength(FooterValues, ExpCols.Count * DBGridEh.FooterRowCount);
                WritePrefix;
                if dgTitles in gr.Options then WriteTitle(gr.VisibleColumns);
                for i := 0 to gr.Selection.Rows.Count - 1 do
                begin
                  ds.Bookmark := gr.Selection.Rows[I];
                  CalcFooterValues;
                  WriteRecord(gr.VisibleColumns);
                end;
                for i := 0 to gr.FooterRowCount - 1 do WriteFooter(gr.VisibleColumns, i);
              end;
            gstRectangle:
              begin
                ColList := TColumnsEhList.Create;
                IsFreeColList := True;
                for i := gr.Selection.Rect.LeftCol to gr.Selection.Rect.RightCol do
                  if gr.Columns[i].Visible then
                    ColList.Add(gr.Columns[i]);
                if ExpCols = nil then
                  ExpCols := ColList;
                SetLength(FooterValues, ExpCols.Count * DBGridEh.FooterRowCount);
                WritePrefix;
                if dgTitles in gr.Options then WriteTitle(ColList);
                ds.Bookmark := gr.Selection.Rect.TopRow;
                while True do
                begin
                  WriteRecord(ColList);
                  CalcFooterValues;
                  if DataSetCompareBookmarks(ds,
                      gr.Selection.Rect.BottomRow, ds.Bookmark) = 0 then Break;
                  ds.Next;
                  if ds.Eof then Break;
                end;
                for i := 0 to gr.FooterRowCount - 1 do WriteFooter(ColList, i);
              end;
            gstColumns:
              begin
                if ExpCols = nil then
                  ExpCols := gr.Selection.Columns;
                SetLength(FooterValues, ExpCols.Count * DBGridEh.FooterRowCount);
                WritePrefix;
                if dgTitles in gr.Options then WriteTitle(gr.Selection.Columns);
                ds.First;
                while ds.Eof = False do
                begin
                  WriteRecord(gr.Selection.Columns);
                  CalcFooterValues;
                  ds.Next;
                end;
                for i := 0 to gr.FooterRowCount - 1 do
                  WriteFooter(gr.Selection.Columns, i);
              end;
            gstAll:
              begin
                if ExpCols = nil then
                  ExpCols := gr.VisibleColumns;
                SetLength(FooterValues, ExpCols.Count * DBGridEh.FooterRowCount);
                WritePrefix;
                if dgTitles in gr.Options then WriteTitle(gr.VisibleColumns);
                ds.First;
                while ds.Eof = False do
                begin
                  WriteRecord(gr.VisibleColumns);
                  CalcFooterValues;
                  ds.Next;
                end;
                for i := 0 to gr.FooterRowCount - 1 do
                  WriteFooter(gr.VisibleColumns, i);
              end;
          end;
        finally
          try
            if RestoreBookmarkIsNeed then
              gr.RestoreBookmark;
          finally
            ds.EnableControls;
          end;
        end;
      end;
    end;
    WriteSuffix;
  finally
    if IsFreeColList then
      FreeAndNil(ColList);
  end;
end;

procedure TDBGridEhExport.WriteTitle(ColumnsList: TColumnsEhList);
begin
end;

procedure TDBGridEhExport.WriteRecord(ColumnsList: TColumnsEhList);
var
  i: Integer;
  AFont: TFont;
  NewBackground: TColor;
  p: TColCellParamsEh;
begin
  AFont := TFont.Create;
  try
    for i := 0 to ColumnsList.Count - 1 do
    begin
      AFont.Assign(ColumnsList[i].Font);

      p := FColCellParamsEh;
      p.Row := -1;
      p.Col := -1;
      p.State := [];
      p.Font := AFont;
      p.Background := ColumnsList[i].Color;
      NewBackground := ColumnsList[i].Color;
      p.Alignment := ColumnsList[i].Alignment;
      p.ImageIndex := ColumnsList[i].GetImageIndex;
      p.Text := ColumnsList[i].DisplayText;
      p.CheckboxState := ColumnsList[i].CheckboxState;

      if Assigned(DBGridEh.OnGetCellParams) then
        DBGridEh.OnGetCellParams(DBGridEh, ColumnsList[i], p.Font, NewBackground, p.State);
      p.Background := NewBackground;

      ColumnsList[i].GetColCellParams(False, FColCellParamsEh);

      WriteDataCell(ColumnsList[i], FColCellParamsEh);
    end;
  finally
    AFont.Free;
  end;
end;

procedure TDBGridEhExport.WriteFooter(ColumnsList: TColumnsEhList; FooterNo: Integer);
var i: Integer;
  Font: TFont;
  Background: TColor;
  State: TGridDrawState;
  Alignment: TAlignment;
  Value: String;
  Footer: TColumnFooterEh;
begin
  Font := TFont.Create;
  try
    for i := 0 to ColumnsList.Count - 1 do
    begin
      Footer := ColumnsList[i].ColumnUsedFooter(FooterNo);

      Font.Assign(Footer.Font);
      Background := Footer.Color;
      Alignment := Footer.Alignment;
      if Footer.ValueType in [fvtSum, fvtCount] then
        Value := GetFooterValue(FooterNo, i)
      else
        Value := DBGridEh.GetFooterValue(Footer, ColumnsList[i]);
      State := [];
      if Assigned(DBGridEh.OnGetFooterParams) then
        DBGridEh.OnGetFooterParams(DBGridEh, ColumnsList[i].Index, FooterNo,
          ColumnsList[i], Font, Background, Alignment, State, Value);
      WriteFooterCell(i, FooterNo, ColumnsList[i], Font, Background,
        Alignment, Value);
    end;
  finally
    Font.Free;
  end;
end;

procedure TDBGridEhExport.WritePrefix;
begin
end;

procedure TDBGridEhExport.WriteSuffix;
begin
end;

procedure TDBGridEhExport.WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh);
begin
end;

procedure TDBGridEhExport.WriteFooterCell(DataCol, Row: Integer; Column: TColumnEh;
  AFont: TFont; Background: TColor; Alignment: TAlignment; const Text: String);
begin

end;

procedure TDBGridEhExport.CalcFooterValues;
var
  i, j: Integer;
  Field: TField;
  Footer: TColumnFooterEh;
begin
  for i := 0 to DBGridEh.FooterRowCount - 1 do
    for j := 0 to ExpCols.Count - 1 do
    begin
      Footer := ExpCols[j].ColumnUsedFooter(i);
      if Footer.FieldName <> '' then
        Field := DBGridEh.DataSource.DataSet.FindField(Footer.FieldName)
      else
        Field := DBGridEh.DataSource.DataSet.FindField(ExpCols[j].FieldName);
      if Field = nil then Continue;
      case Footer.ValueType of
        fvtSum:
          if (Field.IsNull = False) then
            FooterValues[i * ExpCols.Count + j] := FooterValues[i * ExpCols.Count + j] + Field.AsFloat;
        fvtCount:
          FooterValues[i * ExpCols.Count + j] := FooterValues[i * ExpCols.Count + j] + 1;
      end;
    end;
end;

function TDBGridEhExport.GetFooterValue(Row, Col: Integer): String;
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
  Footer := ExpCols[Col].ColumnUsedFooter(Row);
  case Footer.ValueType of
    fvtSum:
      begin
        if ExpCols[Col].ColumnUsedFooter(Row).FieldName <> '' then
          Field := DBGridEh.DataSource.DataSet.FindField(ExpCols[Col].ColumnUsedFooter(Row).FieldName)
        else
          Field := DBGridEh.DataSource.DataSet.FindField(ExpCols[Col].FieldName);
        if Field = nil then Exit;
        begin
          v := FooterValues[Row * ExpCols.Count + Col];
          case Field.DataType of
            ftSmallint, ftInteger, ftAutoInc, ftWord:
              begin
                inf := Field as TIntegerField;
                if Footer.DisplayFormat <> ''
                  then FmtStr := Footer.DisplayFormat
                  else FmtStr := inf.DisplayFormat;
                if FmtStr = ''
                  then Result := IntToStr(Integer(v))
                  else Result := FormatFloat(FmtStr, v);
              end;
            ftBCD:
              begin
                bcf := Field as TBCDField;
                if Footer.DisplayFormat <> ''
                  then FmtStr := Footer.DisplayFormat
                  else FmtStr := bcf.DisplayFormat;
                if FmtStr = '' then
                begin
                  if bcf.Currency then
                  begin
                    Format := ffCurrency;
                    Digits := FormatSettings.CurrencyDecimals;
                  end else
                  begin
                    Format := ffGeneral;
                    Digits := 0;
                  end;
                  Result := CurrToStrF(v, Format, Digits);
                end else
                  Result := FormatCurr(FmtStr, v);
              end;
            ftFMTBcd:
              begin
                fbcf := Field as TFMTBCDField;
                if Footer.DisplayFormat <> ''
                  then FmtStr := Footer.DisplayFormat
                  else FmtStr := fbcf.DisplayFormat;
                if FmtStr = '' then
                begin
                  if fbcf.Currency then
                  begin
                    Format := ffCurrency;
                    Digits := FormatSettings.CurrencyDecimals;
                  end else
                  begin
                    Format := ffGeneral;
                    Digits := 0;
                  end;
                  Result := CurrToStrF(v, Format, Digits);
                end else
                  Result := FormatCurr(FmtStr, v);
              end;
            ftFloat, ftCurrency:
              begin
                ff := Field as TFloatField;
                if Footer.DisplayFormat <> ''
                  then FmtStr := Footer.DisplayFormat
                  else FmtStr := ff.DisplayFormat;
                if FmtStr = '' then
                begin
                  if ff.Currency then
                  begin
                    Format := ffCurrency;
                    Digits := FormatSettings.CurrencyDecimals;
                  end else
                  begin
                    Format := ffGeneral;
                    Digits := 0;
                  end;
                  Result := FloatToStrF(Double(v), Format, ff.Precision, Digits);
                end else
                  Result := FormatFloat(FmtStr, v);
              end;
          end;
        end;
      end;
    fvtCount:
      if Footer.DisplayFormat <> ''
        then Result := FormatFloat(Footer.DisplayFormat, FooterValues[Row * ExpCols.Count + Col])
        else Result := FloatToStr(FooterValues[Row * ExpCols.Count + Col]);
  end;
end;


constructor TDBGridEhExport.Create;
begin
  inherited Create;
  FColCellParamsEh := TColCellParamsEh.Create;
end;

destructor TDBGridEhExport.Destroy;
begin
  FreeAndNil(FColCellParamsEh);
  inherited Destroy;
end;

{ TDBGridEhExportAsText }

procedure TDBGridEhExportAsText.WriteTitle(ColumnsList: TColumnsEhList);
var
  i: Integer;
  s: String;
begin
  CheckFirstRec;
  for i := 0 to ColumnsList.Count - 1 do
  begin
    s := ColumnsList[i].Title.Caption;
    WriteString(s);
    if i <> ColumnsList.Count - 1 then
      WriteString(#09);
  end;
end;

procedure TDBGridEhExportAsText.WriteRecord(ColumnsList: TColumnsEhList);
begin
  CheckFirstRec;
  FirstCell := True;
  inherited WriteRecord(ColumnsList);
end;

procedure TDBGridEhExportAsText.WriteFooter(ColumnsList: TColumnsEhList; FooterNo: Integer);
begin
  CheckFirstRec;
  FirstCell := True;
  inherited WriteFooter(ColumnsList, FooterNo);
end;

procedure TDBGridEhExportAsText.WritePrefix;
begin
end;

procedure TDBGridEhExportAsText.WriteSuffix;
begin
end;

procedure TDBGridEhExportAsText.ExportToStream(Stream: TStream;
  IsExportAll: Boolean);
var
  Buffer, Preamble: TBytes;
  AEncoding: TEncoding;
begin
  FirstRec := True;

  FStringBuilder := TStringBuilder.Create;
  inherited ExportToStream(nil, IsExportAll);

  if (Encoding = nil) then
  {$IFDEF EH_LIB_16} //XE2
    AEncoding := TEncoding.ANSI
  {$ELSE}
    AEncoding := TEncoding.Default
  {$ENDIF}
  else
    AEncoding := Encoding;

  {$IFDEF FPC}
  Buffer := AEncoding.GetBytes(UnicodeString(FStringBuilder.ToString));
  {$ELSE}
  Buffer := AEncoding.GetBytes(FStringBuilder.ToString);
  {$ENDIF}
  if WriteBOM then
  begin
    Preamble := AEncoding.GetPreamble;
    if Length(Preamble) > 0 then
      Stream.WriteBuffer(Preamble, Length(Preamble));
  end;
  Stream.WriteBuffer(Buffer[0], Length(Buffer));

  FStringBuilder.Free;
end;

procedure TDBGridEhExportAsText.WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh);
var
  s: String;
begin
  CheckFirstCell;
  if Assigned(Column.Field) and
     (Column.Field is TNumericField) and
     Column.Grid.Center.PreferEditFormatForNumberFields
  then
    s := Column.EditText
  else
    s := FColCellParamsEh.Text;
  WriteString(s);
end;

procedure TDBGridEhExportAsText.WriteFooterCell(DataCol, Row: Integer;
  Column: TColumnEh; AFont: TFont; Background: TColor;
  Alignment: TAlignment; const Text: String);
begin
  CheckFirstCell;
  WriteString(Text);
end;

procedure TDBGridEhExportAsText.CheckFirstCell;
var
  s: String;
begin
  if FirstCell = False then
  begin
    s := #09;
    WriteString(s);
  end else
    FirstCell := False;
end;

procedure TDBGridEhExportAsText.CheckFirstRec;
var
  s: String;
begin
  if FirstRec = False then
  begin
    s := sLineBreak;
    WriteString(s);
  end else
    FirstRec := False;
end;

procedure TDBGridEhExportAsText.WriteString(s: String);
begin
  FStringBuilder.Append(s);
end;

{ TDBGridEhExportAsUnicodeText }

procedure TDBGridEhExportAsUnicodeText.WriteTitle(ColumnsList: TColumnsEhList);
var
  i: Integer;
  s: WideString;
begin
  CheckFirstRec;
  for i := 0 to ColumnsList.Count - 1 do
  begin
    s := WideString(ColumnsList[i].Title.Caption);
    if i <> ColumnsList.Count - 1 then
      s := s + #09;
    StreamWriteWideString(Stream, s);
  end;
end;

procedure TDBGridEhExportAsUnicodeText.WriteRecord(ColumnsList: TColumnsEhList);
begin
  CheckFirstRec;
  FirstCell := True;
  inherited WriteRecord(ColumnsList);
end;

procedure TDBGridEhExportAsUnicodeText.WriteFooter(ColumnsList: TColumnsEhList; FooterNo: Integer);
begin
  CheckFirstRec;
  FirstCell := True;
  inherited WriteFooter(ColumnsList, FooterNo);
end;

procedure TDBGridEhExportAsUnicodeText.WritePrefix;
begin
end;

procedure TDBGridEhExportAsUnicodeText.WriteSuffix;
begin
end;

procedure TDBGridEhExportAsUnicodeText.ExportToStream(Stream: TStream;
  IsExportAll: Boolean);
begin
  FirstRec := True;
  inherited ExportToStream(Stream, IsExportAll);
end;

procedure TDBGridEhExportAsUnicodeText.WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh);
var
  s: WideString;
begin
  CheckFirstCell;
  if Assigned(Column.Field) and
     (Column.Field is TNumericField) and
     Column.Grid.Center.PreferEditFormatForNumberFields
  then
    s := WideString(Column.EditText)
  else
    s := WideString(FColCellParamsEh.Text);
  StreamWriteWideString(Stream, s);
end;

procedure TDBGridEhExportAsUnicodeText.WriteFooterCell(DataCol, Row: Integer;
  Column: TColumnEh; AFont: TFont; Background: TColor;
  Alignment: TAlignment; const Text: String);
var
  s: WideString;
begin
  CheckFirstCell;
  s := WideString(Text);
  StreamWriteWideString(Stream, s);
end;

procedure TDBGridEhExportAsUnicodeText.CheckFirstCell;
var
  s: WideString;
begin
  if FirstCell = False then
  begin
    s := #09;
    StreamWriteWideString(Stream, s);
  end else
    FirstCell := False;
end;

procedure TDBGridEhExportAsUnicodeText.CheckFirstRec;
var
  s: WideString;
begin
  if FirstRec = False then
  begin
    s := sLineBreak;
    StreamWriteWideString(Stream, s);
  end else
    FirstRec := False;
end;

{ TDBGridEhExportAsCVS }
constructor TDBGridEhExportAsCSV.Create;
begin
  inherited Create;
  Separator := DBGridEhImpExpCsvSeparator;
  QuoteChar := DBGridEhImpExpCsvQuoteChar;
end;

procedure TDBGridEhExportAsCSV.CheckFirstRec;
var
  s: String;
begin
  if FirstRec = False then
  begin
    s := sLineBreak;
    WriteString(s);
  end else
    FirstRec := False;
end;

procedure TDBGridEhExportAsCSV.CheckFirstCell;
var
  s: String;
begin
  if (FirstCell = False) and (Separator > #0) then
  begin
    s := Separator;
    WriteString(s);
  end else
    FirstCell := False;
end;

procedure TDBGridEhExportAsCSV.WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh);
var
  s: String;
begin
  CheckFirstCell;
  if QuoteChar > #0 then
    s := AnsiQuotedStr(FColCellParamsEh.Text, Char(QuoteChar))
  else
    s := FColCellParamsEh.Text;
  WriteString(s);
end;

procedure TDBGridEhExportAsCSV.WriteFooterCell(DataCol, Row: Integer;
  Column: TColumnEh; AFont: TFont; Background: TColor;
  Alignment: TAlignment; const Text: String);
var
  s: String;
begin
  CheckFirstCell;
  if QuoteChar > #0 then
    s := AnsiQuotedStr(Text, Char(QuoteChar))
  else
    s := Text;
  WriteString(s);
end;

procedure TDBGridEhExportAsCSV.WriteTitle(ColumnsList: TColumnsEhList);
var
  i: Integer;
  s: String;
begin
  CheckFirstRec;
  for i := 0 to ColumnsList.Count - 1 do
  begin
    if QuoteChar > #0 then
      s := AnsiQuotedStr(ColumnsList[i].Title.Caption, Char(QuoteChar))
    else
      s := ColumnsList[i].Title.Caption;
    if (i <> ColumnsList.Count - 1) and (Separator > #0) then
      s := s + Separator;
    WriteString(s);
  end;
end;

procedure TDBGridEhExportAsCSV.WriteSuffix;
begin
  inherited WriteSuffix;
end;

type
  TTitleExpRec = record
    Height: Integer;
    PTLeafCol: TDBGridMultiTitleNodeEh;
  end;

  TTitleExpArr = array of TTitleExpRec;

{ Routines to convert MultiTitle in matrix (List of Lists) }

procedure CalcSpan(
  ColumnsList: TColumnsEhList; ListOfHeadTreeNodeList: TObjectList;
  Row, Col: Integer;
  var AColSpan: Integer; var ARowSpan: Integer
  );
var
  Node: TDBGridMultiTitleNodeEh;
  i, k: Integer;
begin
  AColSpan := 1; ARowSpan := 1;
  Node := TDBGridMultiTitleNodeEh(TObjectList(ListOfHeadTreeNodeList.Items[Row]).Items[Col]);
  if Node <> nil then
  begin
    for k := Row - 1 downto 0 do
      if TDBGridMultiTitleNodeEh(TObjectList(ListOfHeadTreeNodeList.Items[k]).Items[Col]) = Node
        then
      begin
        Inc(ARowSpan);
        TObjectList(ListOfHeadTreeNodeList.Items[k]).Items[Col] := nil;
      end else
        Break;

    for i := Col + 1 to ColumnsList.Count - 1 do
      if TDBGridMultiTitleNodeEh(TObjectList(ListOfHeadTreeNodeList.Items[Row]).Items[i]) = Node
        then
      begin
        Inc(AColSpan);
        TObjectList(ListOfHeadTreeNodeList.Items[Row]).Items[i] := nil;
      end else
        Break;

    for k := Row - 1 downto Row - ARowSpan + 1 do
      for i := Col + 1 to Col + AColSpan - 1 do
        TObjectList(ListOfHeadTreeNodeList.Items[k]).Items[i] := nil;
  end;
end;

procedure CreateMultiTitleMatrix(DBGridEh: TCustomDBGridEh;
  ColumnsList: TColumnsEhList;
  out FPTitleExpArr: TTitleExpArr;
  var ListOfHeadTreeNodeList: TObjectList);
var i: Integer;
  NeedNextStep: Boolean;
  MinHeight: Integer;
  FHeadTreeNodeList: TObjectList;
begin
  ListOfHeadTreeNodeList := nil;
  SetLength(FPTitleExpArr, ColumnsList.Count);
  for i := 0 to ColumnsList.Count - 1 do
  begin
    FPTitleExpArr[i].Height := DBGridEh.LeafFieldArr[ColumnsList[i].Index].FLeaf.Height;
    FPTitleExpArr[i].PTLeafCol := DBGridEh.LeafFieldArr[ColumnsList[i].Index].FLeaf;
  end;
  ListOfHeadTreeNodeList := TObjectListEh.Create;
  NeedNextStep := True;
  while True do
  begin
    MinHeight := FPTitleExpArr[0].Height;
    for i := 1 to ColumnsList.Count - 1 do
      if FPTitleExpArr[i].Height < MinHeight then
        MinHeight := FPTitleExpArr[i].Height;
    FHeadTreeNodeList := TObjectListEh.Create;
    for i := 0 to ColumnsList.Count - 1 do
    begin
      FHeadTreeNodeList.Add(FPTitleExpArr[i].PTLeafCol);
      if FPTitleExpArr[i].Height = MinHeight then
      begin
        if FPTitleExpArr[i].PTLeafCol.Parent <> nil then
        begin
          FPTitleExpArr[i].PTLeafCol := FPTitleExpArr[i].PTLeafCol.Parent;
          Inc(FPTitleExpArr[i].Height, FPTitleExpArr[i].PTLeafCol.Height);
          NeedNextStep := True;
        end;
      end;
    end;
    if not NeedNextStep then
    begin
      FreeAndNil(FHeadTreeNodeList);
      Break;
    end;
    ListOfHeadTreeNodeList.Add(FHeadTreeNodeList);
    NeedNextStep := False;
  end;
end;

{ TDBGridEhExportAsHTML }

procedure TDBGridEhExportAsHTML.Put(const Text: String);
{$IFDEF EH_LIB_12}
var
  B: RawByteString;
{$ENDIF}
begin
{$IFDEF EH_LIB_12}
  B := UTF8Encode(Text);
  Stream.Write(Pointer(B)^, Length(B));
{$ELSE}

{$IFDEF CIL}
{$ELSE}
  Stream.Write(PChar(Text)^, Length(Text) * SizeOf(Char));
{$ENDIF}

{$ENDIF}
end;

procedure TDBGridEhExportAsHTML.PutL(const Text: String);
begin
  Put(Text + sLineBreak);
end;

procedure TDBGridEhExportAsHTML.WritePrefix;
var s: String;
  CellPaddingInc: String;
begin
  PutL('<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">');
  PutL('<html>');
  PutL('<head>');
  PutL('<title>');
  PutL(DBGridEh.Name);
  PutL('</title>');
{$IFDEF EH_LIB_12}
  PutL('<meta http-equiv="Content-Type" content="text/html; charset=utf-8">');
{$ENDIF}
  PutL('</head>');

  PutL('<body>');

  s := '<table ';
  if DBGridEh.Flat then CellPaddingInc := '1' else CellPaddingInc := '2';
  if DBGridEh.Options * [dgColLines, dgRowLines] <> [] then
    if DBGridEh.Ctl3D then s := s + 'BORDER=1 CELLSPACING=0 CELLPADDING=' + CellPaddingInc
    else s := s + 'BORDER=0 CELLSPACING=1 CELLPADDING=' + CellPaddingInc
  else
    s := s + 'BORDER=0 CELLSPACING=0 CELLPADDING=' + CellPaddingInc;
  s := s + ' BGCOLOR=#' + GetColor(DBGridEh.FixedColor) + '>' + sLineBreak;
  PutL(s);
end;

procedure TDBGridEhExportAsHTML.WriteSuffix;
begin
  PutL('</table>');
  PutL('</body>');
  PutL('</html>');
end;

procedure TDBGridEhExportAsHTML.WriteTitle(ColumnsList: TColumnsEhList);
var
  i, k: Integer;
  FPTitleExpArr: TTitleExpArr;
  ListOfHeadTreeNodeList: TObjectList;
  ColSpan, RowSpan: Integer;
begin
  if ColumnsList.Count = 0 then Exit;

  if DBGridEh.IsUseMultiTitle then
  begin
    try
      CreateMultiTitleMatrix(DBGridEh, ColumnsList, FPTitleExpArr, ListOfHeadTreeNodeList);

      for k := ListOfHeadTreeNodeList.Count - 1 downto 1 do
      begin
        PutL('<TR>');
        for i := 0 to ColumnsList.Count - 1 do
        begin
          if TDBGridMultiTitleNodeEh(TObjectListEh(ListOfHeadTreeNodeList.Items[k]).Items[i]) <> nil then
          begin
            Put('  <TD ALIGN="CENTER"');
            CalcSpan(ColumnsList, ListOfHeadTreeNodeList, k, i, ColSpan, RowSpan);
            if ColSpan > 1 then
              Put(' COLSPAN = "' + IntToStr(ColSpan) + '"');
            if RowSpan > 1 then
              Put(' ROWSPAN = "' + IntToStr(RowSpan) + '"');
            Put('>');
            PutText(DBGridEh.TitleFont,
              TDBGridMultiTitleNodeEh(TObjectList(ListOfHeadTreeNodeList.Items[k]).Items[i]).Text);
            PutL('</TD>');
          end;
        end;
        PutL('</TR>');
      end;

      PutL('<TR>');
      for i := 0 to ColumnsList.Count - 1 do
      begin
        if TDBGridMultiTitleNodeEh(TObjectList(ListOfHeadTreeNodeList.Items[0]).Items[i]) <> nil then
        begin
          Put('  <TD WIDTH=' + IntToStr(ColumnsList[i].Width) + ' ALIGN="CENTER"');
          CalcSpan(ColumnsList, ListOfHeadTreeNodeList, 0, i, ColSpan, RowSpan);
          if ColSpan > 1 then
            Put(' COLSPAN = "' + IntToStr(ColSpan) + '"');
          if RowSpan > 1 then
            Put(' ROWSPAN = "' + IntToStr(RowSpan) + '"');
          Put('>');
          PutText(ColumnsList[i].Title.Font,
            TDBGridMultiTitleNodeEh(TObjectList(ListOfHeadTreeNodeList.Items[0]).Items[i]).Text);
          PutL('</TD>');
        end;
      end;
      PutL('</TR>');

    finally
      for i := 0 to ListOfHeadTreeNodeList.Count - 1 do
        FreeObjectEh(ListOfHeadTreeNodeList.Items[i]);
      FreeAndNil(ListOfHeadTreeNodeList);
    end;
  end else
  begin
    PutL('<TR>');
    for i := 0 to ColumnsList.Count - 1 do
    begin
      Put('  <TD WIDTH=' + IntToStr(ColumnsList[i].Width) +
        ' ALIGN="' + GetAlignment(ColumnsList[i].Title.Alignment) + '"' + '>');
      PutText(ColumnsList[i].Title.Font, ColumnsList[i].Title.Caption);
      PutL('</TD>');
    end;
    PutL('</TR>');
  end;
end;

procedure TDBGridEhExportAsHTML.WriteRecord(ColumnsList: TColumnsEhList);
begin
  PutL('<TR>');
  inherited;
  PutL('</TR>');
end;

procedure TDBGridEhExportAsHTML.WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh);
begin
  Put('  <TD WIDTH=' + IntToStr(Column.Width) +
    ' ALIGN="' + GetAlignment(FColCellParamsEh.Alignment) + '"' +
    ' BGCOLOR=#' + GetColor(FColCellParamsEh.Background) +
    '>');
  PutText(FColCellParamsEh.Font, FColCellParamsEh.Text);
  PutL('</TD>');
end;

function TDBGridEhExportAsHTML.GetAlignment(Alignment: TAlignment): String;
begin
  case Alignment of
    taLeftJustify: Result := 'LEFT';
    taCenter: Result := 'CENTER';
    taRightJustify: Result := 'RIGHT';
  end;
end;

procedure TDBGridEhExportAsHTML.PutText(Font: TFont; Text: String);
var s: String;
begin
  s := '<FONT STYLE="font-family: ' + Font.Name;
  s := s + '; font-size: ' + IntToStr(GetFontSize(Font));
  s := s + 'pt; color: #' + GetColor(Font.Color) + '">';

  if (fsBold in Font.Style) then s := s + '<B>';
  if (fsItalic in Font.Style) then s := S + '<I>';
  if (fsUnderline in Font.Style) then s := s + '<U>';
  if (fsStrikeOut in Font.Style) then s := s + '<STRIKE>';

  Text := StringReplace(Text, '&', '&amp', [rfReplaceAll]);
  Text := StringReplace(Text, '<', '&lt', [rfReplaceAll]);
  Text := StringReplace(Text, '>', '&gt', [rfReplaceAll]);
  Text := StringReplace(Text, '"', '&quot', [rfReplaceAll]);

  if Text <> '' then
    s := s + Text
  else
    s := s + '&nbsp';

  if (fsBold in Font.Style) then s := s + '</B>';
  if (fsItalic in Font.Style) then s := S + '</I>';
  if (fsUnderline in Font.Style) then s := s + '</U>';
  if (fsStrikeOut in Font.Style) then s := s + '</STRIKE>';
  s := s + '</FONT>';

  Put(s);
end;

function TDBGridEhExportAsHTML.GetColor(Color: TColor): String;
var s: String;
begin
  if Color = clNone then
    s := '000000'
  else
    s := IntToHex(ColorToRGB(Color), 6);
  Result := Copy(s, 5, 2) + Copy(s, 3, 2) + Copy(s, 1, 2);
end;

procedure TDBGridEhExportAsHTML.WriteFooter(ColumnsList: TColumnsEhList;
  FooterNo: Integer);
begin
  PutL('<TR>');
  inherited;
  PutL('</TR>');
end;

procedure TDBGridEhExportAsHTML.WriteFooterCell(DataCol, Row: Integer;
  Column: TColumnEh; AFont: TFont; Background: TColor;
  Alignment: TAlignment; const Text: String);
var
  Footer: TColumnFooterEh;
begin
  Footer := Column.ColumnUsedFooter(Row);
  Put('  <TD WIDTH=' + IntToStr(Column.Width) +
    ' ALIGN="' + GetAlignment(Footer.Alignment) + '"' +
    ' BGCOLOR=#' + GetColor(Background) +
    '>');
  PutText(AFont, Text);
  PutL('</TD>');
end;

{ TDBGridEhExportAsRTF }

procedure TDBGridEhExportAsRTF.ExportToStream(AStream: TStream; IsExportAll: Boolean);
var
  i: Integer;
begin
  FCacheStream := TMemoryStreamEh.Create;
  FCacheStream.HalfMemoryDelta := $10000;
  ColorTblList := TStringList.Create;
  FontTblList := TStringList.Create;
  try
    GetColorIndex(clBlack);
    GetColorIndex(clWhite);
    GetColorIndex(clBtnFace);

    inherited ExportToStream(FCacheStream, IsExportAll);

    Stream := AStream;

    PutL('{\rtf0\ansi');

    Put('{\colortbl');
    for i := 0 to ColorTblList.Count - 1 do
      Put('\red' + Trim(Copy(ColorTblList[i], 1, 3)) +
        '\green' + Trim(Copy(ColorTblList[i], 4, 3)) +
        '\blue' + Trim(Copy(ColorTblList[i], 7, 3)) + ';');
    PutL('}');

    Put('{\fonttbl');
    for i := 0 to FontTblList.Count - 1 do
      Put('\f' + IntToStr(i) + '\fnil ' + FontTblList[i] + ';');
    PutL('}');
    FCacheStream.SaveToStream(Stream);
  finally
    FCacheStream.Free;
    ColorTblList.Free;
    FontTblList.Free;
  end;
end;

procedure TDBGridEhExportAsRTF.Put(const Text: String);
begin
  StreamWriteAnsiString(Stream, AnsiString(Text));
end;

procedure TDBGridEhExportAsRTF.PutL(const Text: String);
begin
  Put(Text + sLineBreak);
end;

procedure TDBGridEhExportAsRTF.PutText(Font: TFont; Text: String; Background: TColor);
var
  s: String;
begin

  s := '\fs' + IntToStr(GetFontSize(Font) * 2);
  if (fsBold in Font.Style) then s := s + '\b';
  if (fsItalic in Font.Style) then s := s + '\i';
  if (fsStrikeOut in Font.Style) then s := s + '\strike';
  if (fsUnderline in Font.Style) then s := s + '\ul';
  s := s + '\f' + IntToStr(GetFontIndex(Font.Name));
  s := s + '\cf' + IntToStr(GetColorIndex(Font.Color));
  s := s + '\cb' + IntToStr(GetColorIndex(Background));
  Put(s + ' ');
  Text := StringToRtfString(Text);
  Put(Text);
end;

function TDBGridEhExportAsRTF.GetAlignment(Alignment: TAlignment): String;
begin
  case Alignment of
    taLeftJustify: Result := '\ql';
    taCenter: Result := '\qc';
    taRightJustify: Result := '\qr';
  end;
end;

function TDBGridEhExportAsRTF.GetFontIndex(const FontName: String): Integer;
begin
  Result := FontTblList.IndexOf(FontName);
  if Result = -1 then
    Result := FontTblList.Add(FontName);
end;

function TDBGridEhExportAsRTF.GetColorIndex(Color: TColor): Integer;
var
  RGBColor: Longint;
  s: String;
begin
  RGBColor := ColorToRGB(Color);
  s := Format('%3d%3d%3d', [GetRValue(RGBColor), GetGValue(RGBColor), GetBValue(RGBColor)]);
  Result := ColorTblList.IndexOf(s);
  if Result = -1 then
    Result := ColorTblList.Add(s);
end;

procedure TDBGridEhExportAsRTF.WritePrefix;
begin
end;

procedure TDBGridEhExportAsRTF.WriteSuffix;
begin
  Put('}');
end;

procedure TDBGridEhExportAsRTF.WriteTitle(ColumnsList: TColumnsEhList);
var
  fLogPelsX: Integer;
  i, w, k: Integer;
  FPTitleExpArr: TTitleExpArr;
  ListOfHeadTreeNodeList: TObjectList;
  ColSpan, RowSpan: Integer;
  Text: String;
  LeftBorder, TopBorder, BottomBorder, RightBorder: Boolean;
  ExclLeftBorders, ExclTopBorders, ExclBottomBorders, ExclRightBorders: TStringList;
  Space: String;

  procedure AddExclBorders(Col, Row, ColSpan, RowSpan: Integer);
  var i, k: Integer;
  begin
    for i := Col to Col + ColSpan - 1 do
      for k := Row downto Row - RowSpan + 1 do
      begin
        if i <> Col then
          ExclLeftBorders.Add(Format('%3d%3d', [i, k]));
        if i <> Col + ColSpan - 1 then
          ExclRightBorders.Add(Format('%3d%3d', [i, k]));
        if k <> Row then
          ExclTopBorders.Add(Format('%3d%3d', [i, k]));
        if k <> Row - RowSpan + 1 then
          ExclBottomBorders.Add(Format('%3d%3d', [i, k]));
      end;
  end;

  procedure CalcBorders(Col, Row: Integer);
  begin
    LeftBorder := True; TopBorder := True;
    BottomBorder := True; RightBorder := True;
    if ExclLeftBorders.IndexOf(Format('%3d%3d', [Col, Row])) <> -1 then
      LeftBorder := False;
    if ExclRightBorders.IndexOf(Format('%3d%3d', [Col, Row])) <> -1 then
      RightBorder := False;
    if ExclTopBorders.IndexOf(Format('%3d%3d', [Col, Row])) <> -1 then
      TopBorder := False;
    if ExclBottomBorders.IndexOf(Format('%3d%3d', [Col, Row])) <> -1 then
      BottomBorder := False;
  end;
begin
  fLogPelsX := GetDeviceCaps(DBGridEh.Canvas.Handle, LOGPIXELSX);

  if DBGridEh.IsUseMultiTitle then
  begin
    Space := IntToStr(Abs(Trunc(DBGridEh.VTitleMargin / 2 / fLogPelsX * 1440 - 20)));
    ExclLeftBorders := nil; ExclTopBorders := nil;
    ExclBottomBorders := nil; ExclRightBorders := nil;
    try
      CreateMultiTitleMatrix(DBGridEh, ColumnsList, FPTitleExpArr, ListOfHeadTreeNodeList);

      ExclLeftBorders := TStringList.Create;
      ExclTopBorders := TStringList.Create;
      ExclBottomBorders := TStringList.Create;
      ExclRightBorders := TStringList.Create;

      for k := ListOfHeadTreeNodeList.Count - 1 downto 1 do
      begin
        Put('\trowd');
        PutL('\trgaph40');

        w := 0;
        for i := 0 to ColumnsList.Count - 1 do
        begin
          CalcSpan(ColumnsList, ListOfHeadTreeNodeList, k, i, ColSpan, RowSpan);
          AddExclBorders(i, k, ColSpan, RowSpan);
          CalcBorders(i, k);

          WriteCellBorder(LeftBorder, TopBorder, BottomBorder, RightBorder);
          Inc(w, Trunc(ColumnsList[i].Width / fLogPelsX * 1440)); 
          Put('\clshdng10000\clcfpat' + IntToStr(GetColorIndex((DBGridEh.FixedColor))));
          PutL('\cellx' + IntToStr(w));
        end;

        PutL('{\trrh0');

        for i := 0 to ColumnsList.Count - 1 do
        begin
          if TDBGridMultiTitleNodeEh(TObjectList(ListOfHeadTreeNodeList.Items[k]).Items[i]) <> nil then
          begin
            Text := TDBGridMultiTitleNodeEh(TObjectList(ListOfHeadTreeNodeList.Items[k]).Items[i]).Text;
            Put('\pard\intbl{' + GetAlignment(taCenter) + '\sb' + Space + '\sa' + Space);
          end else
          begin
            Text := '';
            Put('\pard\intbl{' + GetAlignment(taCenter));
          end;

          PutText(DBGridEh.TitleFont, Text, DBGridEh.FixedColor);
          PutL('\cell}');
        end;
        PutL('\pard\intbl\row}');
      end;

      Put('\trowd');
      PutL('\trgaph40');

      w := 0;
      for i := 0 to ColumnsList.Count - 1 do
      begin
        CalcSpan(ColumnsList, ListOfHeadTreeNodeList, 0, i, ColSpan, RowSpan);
        AddExclBorders(i, 0, ColSpan, RowSpan);
        CalcBorders(i, 0);

        WriteCellBorder(LeftBorder, TopBorder, BottomBorder, RightBorder);

        Inc(w, Trunc(ColumnsList[i].Width / fLogPelsX * 1440)); 
        Put('\clshdng10000\clcfpat' + IntToStr(GetColorIndex((ColumnsList[i].Title.Color))));
        PutL('\cellx' + IntToStr(w));
      end;

      PutL('{\trrh0');

      for i := 0 to ColumnsList.Count - 1 do
      begin
        if TDBGridMultiTitleNodeEh(TObjectList(ListOfHeadTreeNodeList.Items[0]).Items[i]) <> nil then
        begin
          Text := TDBGridMultiTitleNodeEh(TObjectList(ListOfHeadTreeNodeList.Items[0]).Items[i]).Text;
          Put('\pard\intbl{' + GetAlignment(taCenter) + '\sb' + Space + '\sa' + Space);
        end else
        begin
          Text := '';
          Put('\pard\intbl{' + GetAlignment(taCenter));
        end;
        CalcSpan(ColumnsList, ListOfHeadTreeNodeList, 0, i, ColSpan, RowSpan);

        PutText(ColumnsList[i].Title.Font, Text, ColumnsList[i].Title.Color);
        PutL('\cell}');

      end;
      PutL('\pard\intbl\row}');

    finally
      for i := 0 to ListOfHeadTreeNodeList.Count - 1 do
        FreeObjectEh(ListOfHeadTreeNodeList.Items[i]);
      FreeAndNil(ListOfHeadTreeNodeList);

      FreeAndNil(ExclLeftBorders);
      FreeAndNil(ExclTopBorders);
      FreeAndNil(ExclBottomBorders);
      FreeAndNil(ExclRightBorders);
    end;
  end else
  begin
    Put('\trowd');
    PutL('\trgaph40');

    w := 0;
    for i := 0 to ColumnsList.Count - 1 do
    begin
      WriteCellBorder(True, True, True, True);
      Inc(w, Trunc(ColumnsList[i].Width / fLogPelsX * 1440)); 
      Put('\clshdng10000\clcfpat' + IntToStr(GetColorIndex((ColumnsList[i].Title.Color))));
      PutL('\cellx' + IntToStr(w));
    end;

    PutL('{\trrh0');

    for i := 0 to ColumnsList.Count - 1 do
    begin
      if DBGridEh.Flat then Space := '12' else Space := '24';
      Put('\pard\intbl{' + GetAlignment(ColumnsList[i].Title.Alignment) + '\sb' + Space + '\sa' + Space);
      PutText(ColumnsList[i].Title.Font, ColumnsList[i].Title.Caption, ColumnsList[i].Title.Color);
      PutL('\cell}');
    end;

    PutL('\pard\intbl\row}');
  end;
end;

procedure TDBGridEhExportAsRTF.WriteRecord(ColumnsList: TColumnsEhList);
var
  fLogPelsX: Integer;
  i, w: Integer;
begin
  Put('\trowd');
  PutL('\trgaph40');

  fLogPelsX := GetDeviceCaps(DBGridEh.Canvas.Handle, LOGPIXELSX);

  w := 0;
  for i := 0 to ColumnsList.Count - 1 do
  begin
    WriteCellBorder(True, True, True, True);
    Inc(w, Trunc(ColumnsList[i].Width / fLogPelsX * 1440)); 
    Put('\clshdng10000\clcfpat' + IntToStr(GetColorIndex(GetDataCellColor(ColumnsList, i))));
    PutL('\cellx' + IntToStr(w));
  end;

  PutL('{\trrh0');

  inherited WriteRecord(ColumnsList);

  PutL('\pard\intbl\row}');
end;

function TDBGridEhExportAsRTF.StringToRtfString(const s: String): String;
var
  i: Integer;
{$IFDEF EH_LIB_12}
begin
  Result := '';
  for i := 1 to Length(S) do
  begin
    if Integer(s[i]) <= $7F then
      Result := Result + s[i]
    else
      Result := Result + '\u' + IntToStr(Integer(s[i])) + '?';
  end;
{$ELSE}
  ws: WideString;
begin
  Result := '';
  ws := WideString(s);
  for i := 1 to Length(ws) do
  begin
    if Integer(s[i]) <= $7F then
      Result := Result + s[i]
    else
      Result := Result + '\u' + IntToStr(Integer(ws[i])) + '?';
  end;
{$ENDIF}
end;

procedure TDBGridEhExportAsRTF.WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh);
var
  Space: String;
  Text: String;
begin
  if DBGridEh.Flat then Space := '12' else Space := '24';
  Text := StringReplace(FColCellParamsEh.Text,'\','\\', [rfReplaceAll, rfIgnoreCase]);
  Put('\pard\intbl{' + GetAlignment(FColCellParamsEh.Alignment) + '\sb' + Space + '\sa' + Space);
  PutText(FColCellParamsEh.Font, Text, FColCellParamsEh.Background);
  PutL('\cell}');
end;

procedure TDBGridEhExportAsRTF.WriteCellBorder(LeftBorder, TopBorder, BottomBorder, RightBorder: Boolean);
begin
  if LeftBorder then
  begin
    Put('\clbrdrl');
    Put('\brdrs');
    PutL('\brdrcf0');
  end;

  if TopBorder then
  begin
    Put('\clbrdrt');
    Put('\brdrs');
    PutL('\brdrcf0');
  end;

  if BottomBorder then
  begin
    Put('\clbrdrb');
    Put('\brdrs');
    PutL('\brdrcf0');
  end;

  if RightBorder then
  begin
    Put('\clbrdrr');
    Put('\brdrs');
    PutL('\brdrcf0');
  end;
end;

procedure TDBGridEhExportAsRTF.WriteFooter(ColumnsList: TColumnsEhList;
  FooterNo: Integer);
var
  fLogPelsX: Integer;
  i, w: Integer;
begin
  Put('\trowd');
  PutL('\trgaph40');

  fLogPelsX := GetDeviceCaps(DBGridEh.Canvas.Handle, LOGPIXELSX);

  w := 0;
  for i := 0 to ColumnsList.Count - 1 do
  begin
    WriteCellBorder(True, True, True, True);
    Inc(w, Trunc(ColumnsList[i].Width / fLogPelsX * 1440)); 
    Put('\clshdng10000\clcfpat' +
      IntToStr(GetColorIndex(GetFooterCellColor(ColumnsList, i, FooterNo))));
    PutL('\cellx' + IntToStr(w));
  end;

  PutL('{\trrh0'); 

  inherited WriteFooter(ColumnsList, FooterNo);

  PutL('\pard\intbl\row}');
end;

procedure TDBGridEhExportAsRTF.WriteFooterCell(DataCol, Row: Integer;
  Column: TColumnEh; AFont: TFont; Background: TColor;
  Alignment: TAlignment; const Text: String);
var
  Space: String;
begin
  if DBGridEh.Flat then Space := '12' else Space := '24';
  Put('\pard\intbl{' + GetAlignment(Alignment) + '\sb' + Space + '\sa' + Space);
  PutText(AFont, Text, Background);
  PutL('\cell}');
end;

function TDBGridEhExportAsRTF.GetDataCellColor(ColumnsList: TColumnsEhList;
  ColIndex: Integer): TColor;
var Font: TFont;
  State: TGridDrawState;
begin
  Font := TFont.Create;
  try
    Font.Assign(ColumnsList[ColIndex].Font);
    Result := ColumnsList[ColIndex].Color;
    State := [];
    if Assigned(DBGridEh.OnGetCellParams) then
      DBGridEh.OnGetCellParams(DBGridEh, ColumnsList[ColIndex], Font, Result, State);
  finally
    Font.Free;
  end;
end;

function TDBGridEhExportAsRTF.GetFooterCellColor(
  ColumnsList: TColumnsEhList; ColIndex: Integer; FooterNo: Integer): TColor;
var
  Font: TFont;
  State: TGridDrawState;
  Alignment: TAlignment;
  Value: String;
  Footer: TColumnFooterEh;
begin
  Font := TFont.Create;
  try
    Footer := ColumnsList[ColIndex].ColumnUsedFooter(FooterNo);
    Font.Assign(Footer.Font);
    Result := Footer.Color;
    Alignment := Footer.Alignment;
    if Footer.ValueType in [fvtSum, fvtCount] then
      Value := GetFooterValue(FooterNo, ColIndex)
    else
      Value := DBGridEh.GetFooterValue(Footer, ColumnsList[ColIndex]);
    State := [];
    if Assigned(DBGridEh.OnGetFooterParams) then
      DBGridEh.OnGetFooterParams(DBGridEh, ColumnsList[ColIndex].Index, FooterNo,
        ColumnsList[ColIndex], Font, Result, Alignment, State, Value);
  finally
    Font.Free;
  end;
end;

{ TDBGridEhExportAsXLS }

procedure StreamWriteWordArray(Stream: TStream; wr: array of Word);
var
  i: Integer;
begin
  for i := 0 to Length(wr)-1 do
{$IFDEF CIL}
    Stream.Write(wr[i]);
{$ELSE}
    Stream.Write(wr[i], SizeOf(wr[i]));
{$ENDIF}
end;

var
  CXlsBof: array[0..5] of Word = ($809, 8, 0, $10, 0, 0);
  CXlsEof: array[0..1] of Word = ($0A, 00);
  CXlsLabel: array[0..5] of Word = ($204, 0, 0, 0, 0, 0);
  CXlsNumber: array[0..4] of Word = ($203, 14, 0, 0, 0);
  CXlsBlank: array[0..4] of Word = ($201, 6, 0, 0, $17);


procedure TDBGridEhExportAsXLS.WriteBlankCell;
begin
  CXlsBlank[2] := FRow;
  CXlsBlank[3] := FCol;
  StreamWriteWordArray(Stream, CXlsBlank);
  IncColRow;
end;

procedure TDBGridEhExportAsXLS.WriteFloatCell(const AValue: Double);
begin
  CXlsNumber[2] := FRow;
  CXlsNumber[3] := FCol;
  StreamWriteWordArray(Stream, CXlsNumber);
  Stream.WriteBuffer(AValue, 8);
  IncColRow;
end;

procedure TDBGridEhExportAsXLS.WriteIntegerCell(const AValue: Integer);
begin
  WriteFloatCell(AValue);
end;

procedure TDBGridEhExportAsXLS.WriteStringCell(const AValue: string);
var
  L: Word;
  Val255: String;
begin
  Val255 := AValue;
  if Length(Val255) > 255 then
    Val255 := Copy(Val255, 1, 255);
  L := Length(AnsiString(Val255));
  CXlsLabel[1] := 8 + L;
  CXlsLabel[2] := FRow;
  CXlsLabel[3] := FCol;
  CXlsLabel[5] := L;
  StreamWriteWordArray(Stream, CXlsLabel);
  StreamWriteAnsiString(Stream, AnsiString(Val255));
  IncColRow;
end;

procedure TDBGridEhExportAsXLS.WritePrefix;
begin
  StreamWriteWordArray(Stream, CXlsBof);
end;

procedure TDBGridEhExportAsXLS.WriteSuffix;
begin
  StreamWriteWordArray(Stream, CXlsEof);
end;

procedure TDBGridEhExportAsXLS.WriteTitle(ColumnsList: TColumnsEhList);
var i: Integer;
begin
  for i := 0 to ColumnsList.Count - 1 do
  begin
    WriteStringCell(ColumnsList[i].Title.Caption);
  end;
end;

procedure TDBGridEhExportAsXLS.WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh);
begin
  if Column.Field = nil then
    WriteBlankCell
  else if Column.GetBarType = ctKeyPickList then
    WriteStringCell(FColCellParamsEh.Text)
  else if Column.Field.IsNull then
    WriteBlankCell
  else
    case Column.Field.DataType of
      ftSmallint, ftInteger, ftWord, ftAutoInc, ftBytes:
        WriteIntegerCell(Column.Field.AsInteger);
      ftFloat, ftCurrency, ftBCD
      , ftFMTBcd
      {$IFDEF EH_LIB_13}, ftSingle{$ENDIF}:
        WriteFloatCell(Column.Field.AsFloat);
    else
      WriteStringCell(FColCellParamsEh.Text);
    end;
end;

procedure TDBGridEhExportAsXLS.WriteFooterCell(DataCol, Row: Integer;
  Column: TColumnEh; AFont: TFont; Background: TColor;
  Alignment: TAlignment; const Text: String);
begin
  if Column.ColumnUsedFooter(Row).ValueType in [fvtSum, fvtCount] then
    WriteFloatCell(FooterValues[Row * ExpCols.Count + DataCol])
  else
    WriteStringCell(Text);
end;

procedure TDBGridEhExportAsXLS.ExportToStream(AStream: TStream;
  IsExportAll: Boolean);
begin
  FCol := 0;
  FRow := 0;
  inherited ExportToStream(AStream, IsExportAll);
end;

procedure TDBGridEhExportAsXLS.IncColRow;
begin
  if FCol = ExpCols.Count - 1 then
  begin
    Inc(FRow);
    FCol := 0;
  end else
    Inc(FCol);
end;

{ TDBGridEhExportAsVCLDBIF }

{$IFDEF CIL}
procedure StreamWriteStruct(Stream: TStream; AStruct: TObject; ASize: Integer);
var
  b: TBytes;
  Mem: IntPtr;
begin
  Mem := Marshal.AllocHGlobal(Marshal.SizeOf(AStruct));
  try
    Marshal.StructureToPtr(AStruct, Mem, False);
    SetLength(b, Marshal.SizeOf(AStruct));
    Marshal.Copy(Mem, b, 0, Length(b));
    Stream.Write(b, Length(b));
  finally
    Marshal.FreeHGlobal(Mem);
  end;
end;
{$ELSE}
procedure StreamWriteStruct(Stream: TStream; var AStruct; ASize: Integer);
begin
  Stream.WriteBuffer(AStruct, ASize);
end;
{$ENDIF}

var
  VCLDBIF_BOF: TVCLDBIF_BOF = (Signatura: ('V', 'C', 'L', 'D', 'B', 'I', 'F'); Version: 1; ColCount: 0);

procedure WriteDataCellToVCLDBIFStreamAsWideString(Stream: TStream; const AValue: WideString);
var
  StringValue: TVCLDBIF_WIDE_STRING;
begin
  StringValue.AType := TVCLDBIF_TYPE_WIDE_STRING;
  StringValue.Size := Length(AValue)*2;

  StreamWriteStruct(Stream, StringValue, SizeOf(StringValue));
  StreamWriteWideString(Stream, AValue);
end;

procedure WriteDataCellToVCLDBIFStreamAsAnsiString(Stream: TStream; const AValue: AnsiString);
var
  StringValue: TVCLDBIF_ANSI_STRING;
begin
  StringValue.AType := TVCLDBIF_TYPE_ANSI_STRING;
  StringValue.Size := Length(AValue);

  StreamWriteStruct(Stream, StringValue, SizeOf(StringValue));
  StreamWriteAnsiString(Stream, AValue);
end;

procedure WriteDataCellToVCLDBIFStreamAsUnassigned(Stream: TStream);
var
  b: Byte;
begin
  b := TVCLDBIF_TYPE_UNASSIGNED;
  Stream.WriteBuffer(b, SizeOf(Byte));
end;

procedure WriteDataCellToVCLDBIFStreamAsNull(Stream: TStream);
var
  b: Byte;
begin
  b := TVCLDBIF_TYPE_NULL;
  Stream.WriteBuffer(b, SizeOf(Byte));
end;

procedure WriteDataCellToVCLDBIFStreamAsBinaryData(Stream: TStream; const AValue: AnsiString);
var
  BinaryValue: TVCLDBIF_BINARY_DATA;
begin
  BinaryValue.AType := TVCLDBIF_TYPE_BINARY_DATA;
  BinaryValue.Size := Length(AValue);

  StreamWriteStruct(Stream, BinaryValue, SizeOf(BinaryValue));
  StreamWriteAnsiString(Stream, AValue);
end;

procedure WriteDataCellToVCLDBIFStreamAsFloat(Stream: TStream; AValue: Double);
var
  FloatValue: TVCLDBIF_FLOAT64;
begin
  FloatValue.AType := TVCLDBIF_TYPE_FLOAT64;
  FloatValue.Value := AValue;

  StreamWriteStruct(Stream, FloatValue, SizeOf(FloatValue));
end;

procedure WriteDataCellToVCLDBIFStreamAsInteger(Stream: TStream; AValue: Integer);
var
  IntValue: TVCLDBIF_INTEGER32;
begin
  IntValue.AType := TVCLDBIF_TYPE_INTEGER32;
  IntValue.Value := AValue;
  StreamWriteStruct(Stream, IntValue, SizeOf(IntValue));
end;

procedure WriteDataCellToStreamAsVCLDBIFData(Stream: TStream; Column: TAxisBarEh);
var
  Field: TField;
  FDataFields: TFieldsArrEh;
  StrList: TStringList;
  i: Integer;
begin
  FDataFields := nil;
  if Column.LookupParams.LookupActive then
  begin
    FDataFields := GetFieldsProperty(Column.Grid.DataSource.DataSet, nil, Column.LookupParams.KeyFieldNames);
    StrList := TStringList.Create;
    try
      for i := 0 to Length(FDataFields)-1 do
        StrList.Add(FDataFields[i].AsString);
      WriteDataCellToVCLDBIFStreamAsWideString(Stream, WideString(StrList.CommaText));
    finally
      FreeAndNil(StrList);
    end;
  end else
  begin
    Field := Column.Field;
    if Field = nil then
      WriteDataCellToVCLDBIFStreamAsUnassigned(Stream)
    else if Field.IsNull then
      WriteDataCellToVCLDBIFStreamAsNull(Stream)
    else
      case Field.DataType of
        ftSmallint, ftInteger, ftWord, ftAutoInc
{$IFDEF EH_LIB_12}, ftShortint, ftByte {$ENDIF}
          :WriteDataCellToVCLDBIFStreamAsInteger(Stream, Field.AsInteger);

        ftFloat, ftCurrency, ftBCD, ftDate, ftTime, ftDateTime
        , ftTimeStamp, ftFMTBcd
{$IFDEF EH_LIB_13}, ftSingle{$ENDIF}
          :WriteDataCellToVCLDBIFStreamAsFloat(Stream, Field.AsFloat);

        ftString, ftBoolean, ftFixedChar, ftMemo, ftLargeint, ftGuid, ftOraClob
{$IFDEF EH_LIB_10}, ftOraTimeStamp, ftOraInterval {$ENDIF}
{$IFDEF EH_LIB_12}, ftLongWord , ftExtended {$ENDIF}
{$IFDEF EH_LIB_12}
  {$IFDEF NEXTGEN}
         :WriteDataCellToVCLDBIFStreamAsAnsiString(Stream, AnsiString(Field.AsString));
  {$ELSE}
         :WriteDataCellToVCLDBIFStreamAsAnsiString(Stream, Field.AsAnsiString);
  {$ENDIF}
{$ELSE}
          :WriteDataCellToVCLDBIFStreamAsAnsiString(Stream, Field.AsString);
{$ENDIF}

        ftBlob, ftGraphic, ftFmtMemo, ftParadoxOle, ftDBaseOle,
        ftOraBlob,
        ftBytes, ftTypedBinary, ftVarBytes
{$IFDEF EH_LIB_12}
  {$IFDEF NEXTGEN}
          :WriteDataCellToVCLDBIFStreamAsBinaryData(Stream, AnsiString(Field.AsString));
  {$ELSE}
          :WriteDataCellToVCLDBIFStreamAsBinaryData(Stream, Field.AsAnsiString);
  {$ENDIF}
{$ELSE}
          :WriteDataCellToVCLDBIFStreamAsBinaryData(Stream, Field.AsString);
{$ENDIF}
        ftWideString
{$IFDEF EH_LIB_10}, ftFixedWideChar , ftWideMemo {$ENDIF}
{$IFDEF EH_LIB_12}
          :WriteDataCellToVCLDBIFStreamAsWideString(Stream, Field.AsWideString);
{$ELSE}
          :WriteDataCellToVCLDBIFStreamAsWideString(Stream, TWideStringField(Field).Value);
{$ENDIF}
      else
        WriteDataCellToVCLDBIFStreamAsUnassigned(Stream);
      end;
  end;
end;

procedure WriteVCLDBIFStreamPrefix(Stream: TStream; BarList: TAxisBarsEhList);
var
  i: Integer;
  b: Byte;
begin
  VCLDBIF_BOF.ColCount := BarList.Count; 
  StreamWriteStruct(Stream, VCLDBIF_BOF, SizeOf(VCLDBIF_BOF));
  for i := 0 to BarList.Count - 1 do
  begin
    if BarList[i].Visible then b := 1 else b := 0;
    Stream.WriteBuffer(b, SizeOf(Byte));
    SreamWriteNullAnsiStr(Stream);
  end;
end;

procedure WriteVCLDBIFStreamSuffix(Stream: TStream);
var
  b: Byte;
begin
  b := TVCLDBIF_TYPE_EOF;
  Stream.WriteBuffer(b, SizeOf(Byte));
end;

procedure TDBGridEhExportAsVCLDBIF.WritePrefix;
begin
  WriteVCLDBIFStreamPrefix(Stream, ExpCols);
end;

procedure TDBGridEhExportAsVCLDBIF.WriteSuffix;
begin
  WriteVCLDBIFStreamSuffix(Stream);
end;

procedure TDBGridEhExportAsVCLDBIF.WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh);
begin
  WriteDataCellToStreamAsVCLDBIFData(Stream, Column);
end;

function StreamReadAnsiString(Stream: TStream; out S: AnsiString; Count: Longint): Longint;
{$IFDEF CIL}
var
  b: TBytes;
{$ENDIF}
begin
{$IFDEF CIL}
    Result := Stream.Read(b, Count);
    S := StringOf(b);
{$ELSE}
    SetString(S, nil, Count);
    if Count = 0 then
    begin
      Result := 0;
      S := '';
    end else
      Result := Stream.Read(S[1], Count);
{$ENDIF}
end;

function StreamReadWideString(Stream: TStream; out S: WideString; Size: Longint): Longint;
{$IFDEF CIL}
var
  b: TBytes;
{$ENDIF}
begin
{$IFDEF CIL}
    Result := Stream.Read(b, Size);
    S := StringOf(b);
{$ELSE}
    SetString(S, nil, Size div 2);
    if Size = 0 then
    begin
      Result := 0;
      S := '';
    end else
      Result := Stream.Read(S[1], Size);
{$ENDIF}
end;

{$IFDEF CIL}
function StreamReadStruct(Stream: TStream; AStruct: TObject; ASize: Integer): Longint;
var
  b: TBytes;
  Mem: IntPtr;
begin
  Mem := Marshal.AllocHGlobal(Marshal.SizeOf(AStruct));
  try
    Result := Stream.Read(b, Marshal.SizeOf(AStruct));
{ TODO : To do finish }
    Marshal.StructureToPtr(AStruct, Mem, False);
    SetLength(b, Marshal.SizeOf(AStruct));
    Marshal.Copy(Mem, b, 0, Length(b));
  finally
    Marshal.FreeHGlobal(Mem);
  end;
end;

{$ELSE}

function StreamReadStruct(Stream: TStream; var AStruct; ASize: Integer): Longint;
begin
  Result := Stream.Read(AStruct, ASize);
end;

{$ENDIF}

{ TDBGridEhImport }

constructor TDBGridEhImport.Create;
begin
  inherited Create;
end;

procedure TDBGridEhImport.ImportFromFile(const FileName: String; IsImportAll: Boolean);
var FileStream: TFileStream;
begin
  FileStream := TFileStream.Create(FileName, fmOpenRead);
  try
    ImportFromStream(FileStream, IsImportAll);
  finally
    FileStream.Free;
  end;
end;

procedure TDBGridEhImport.ImportFromStream(AStream: TStream; IsImportAll: Boolean);
var
  i: Integer;
  ColList: TColumnsEhList;
  Inserting: Boolean;
  Appending: Boolean;
  gr: TCustomDBGridEh;
  ds: TDataSet;
  LineNo: Integer;

  procedure DoInserting;
  begin
    while not Eos do
    begin
      if (LineNo > 0) and
         (ds.State in [dsEdit, dsInsert])
      then
        ds.Post;
      if Appending
        then ds.Append
        else ds.Insert;
      ReadRecord(ImpCols);
      if not Appending and not Eos then
        ds.Next;
      Inc(LineNo);
    end;
    if (LineNo > 1) and
       (ds.State in [dsEdit, dsInsert])
    then
      ds.Post;
  end;

begin
  Stream := AStream;
  Eos := False;
  gr := DBGridEh;
  begin
    if IsImportAll then
    begin
      gr.Selection.Clear;
      gr.DataSource.Dataset.First;
      if gr.VisibleColumns.Count > 0 then
        gr.SelectedIndex := gr.VisibleColumns.Items[0].Index;
    end;
    ds := gr.DataSource.Dataset;
    begin
      if ds.Eof
        then Appending := True
        else Appending := False;
      if ds.State = dsInsert
        then Inserting := True
        else Inserting := False;
      if not Inserting then gr.SaveBookmark;
      ds.DisableControls;
      try
        case gr.Selection.SelectionType of
          gstRecordBookmarks:
            begin
              ImpCols := gr.VisibleColumns;
              ReadPrefix;
              if Inserting then
                DoInserting
              else
                for i := 0 to gr.Selection.Rows.Count - 1 do
                begin
                  ds.Bookmark := gr.Selection.Rows[I];
                  ReadRecord(gr.VisibleColumns);
                end;
            end;
          gstRectangle:
            begin
              ColList := TColumnsEhList.Create;
              try
                for i := gr.Selection.Rect.LeftCol to gr.Selection.Rect.RightCol do
                  if gr.Columns[i].Visible then
                    ColList.Add(gr.Columns[i]);
                ImpCols := ColList;
                ReadPrefix;
                if Inserting then
                  DoInserting
                else
                begin
                  ds.Bookmark := gr.Selection.Rect.TopRow;
                  while True do
                  begin
                    ReadRecord(ColList);
                    if DataSetCompareBookmarks(DBGridEh.DataSource.Dataset,
                      gr.Selection.Rect.BottomRow, ds.Bookmark) = 0 then Break;
                    ds.Next;
                    if ds.Eof then Break;
                  end;
                end;
              finally
                ColList.Free;
              end;
            end;
          gstColumns:
            begin
              ImpCols := gr.Selection.Columns;
              ReadPrefix;
              if Inserting then
                DoInserting
              else
              begin
                ds.First;
                while ds.Eof = False do
                begin
                  ReadRecord(gr.Selection.Columns);
                  ds.Next;
                end;
              end;
            end;
          gstAll:
            begin
              ImpCols := gr.VisibleColumns;
              ReadPrefix;
              if Inserting then
                DoInserting
              else
              begin
                ds.First;
                while ds.Eof = False do
                begin
                  ReadRecord(gr.VisibleColumns);
                  ds.Next;
                end;
              end;
            end;
          gstNon:
            begin
              ColList := TColumnsEhList.Create;
              try
                for i := gr.SelectedIndex to gr.Columns.Count - 1 do
                  if gr.Columns[i].Visible then ColList.Add(gr.Columns[i]);
                ImpCols := ColList;
                ReadPrefix;
                LineNo := 0;
                if Inserting then
                  DoInserting
                else
                begin
                  gr.RestoreBookmark;
                  while True do
                  begin
                    ReadRecord(ColList);
                    if Eos then Break;
                    ds.Next;
                    Inc(LineNo);
                    if ds.Eof then Break;
                  end;
                  if (LineNo >= 1) and
                     (ds.State in [dsEdit, dsInsert])
                  then
                    ds.Post;
                  if alopAppendEh in DBGridEh.AllowedOperations then
                  begin
                    Inserting := True;
                    Appending := True;
                    DoInserting;
                  end;
                end;
              finally
                ColList.Free;
              end;
            end;
        end;
      finally
        if not Inserting then
          gr.RestoreBookmark;
        ds.EnableControls;
      end;
    end;
  end;
  ReadSuffix;
end;

procedure TDBGridEhImport.ReadPrefix;
begin
end;

procedure TDBGridEhImport.ReadRecord(ColumnsList: TColumnsEhList);
var
  i: Integer;
begin
  for i := 0 to ColumnsList.Count - 1 do
    ReadDataCell(ColumnsList[i]);
end;

procedure TDBGridEhImport.ReadDataCell(Column: TColumnEh);
begin
end;

procedure TDBGridEhImport.ReadSuffix;
begin
end;

{ TDBGridEhImportAsText }

function TDBGridEhImportAsText.CheckState: TImportTextSreamState;
begin
  if GetChar(FLastChar) then
  begin
    if FLastChar = #09 then
      if (FLastState in [itssNewLine, itssTab]) then
      begin
        FLastChar := #00;
        Result := itssChar;
        if Stream.Position >= SizeOf(AnsiChar) then
          Stream.Position := Stream.Position - SizeOf(AnsiChar);
      end else
        Result := itssTab
    else if FLastChar = #13 then
    begin
      if GetChar(FLastChar) and (FLastChar = #10) then
        if (FLastState in [itssNewLine, itssTab]) then
        begin
          FLastChar := #00;
          Result := itssChar;
          if Stream.Position >= SizeOf(AnsiChar)*2 then
            Stream.Position := Stream.Position - SizeOf(AnsiChar) * 2;
        end else
          Result := itssNewLine
      else
        raise Exception.Create('TDBGridEhImportAsText.CheckState: ' + EhLibLanguageConsts.InvalidTextFormat);
    end else if FLastChar = #00 then
    begin
      Result := itssEof;
      Eos := True;
    end else
      Result := itssChar;
  end else
  begin
    Result := itssEof;
    Eos := True;
  end;
  FLastState := Result;
end;

function TDBGridEhImportAsText.GetChar(var ch: Char): Boolean;
begin
  Result := False;
  if FStringStream.Position = FStringStream.Size-1 then Exit;
  ch := FStringStream.ReadString(1)[1];
  Result := True;
end;

function TDBGridEhImportAsText.GetString(var Value: String): TImportTextSreamState;
begin
  Value := '';
  if FLastState = itssChar then
    Value := FLastChar;
  repeat
    Result := CheckState;
    if not (Result = itssChar) then Break;
    Value := Value + FLastChar;
  until False = True;
end;

procedure TDBGridEhImportAsText.ImportFromStream(AStream: TStream;
  IsImportAll: Boolean);
begin
  FIgnoreAll := False;
  inherited ImportFromStream(AStream, IsImportAll);
end;

procedure TDBGridEhImportAsText.ReadPrefix;
var
  StringAsAnsi: AnsiString;
begin
  SetLength(StringAsAnsi, Stream.Size - Stream.Position + 1);
  Stream.Read(StringAsAnsi, Stream.Size - Stream.Position);
  FStringStream := TStringStream.Create(String(StringAsAnsi));

  FLastState := itssNewLine;
  CheckState;
end;

procedure TDBGridEhImportAsText.ReadSuffix;
begin
  FreeAndNil(FStringStream);
end;

procedure TDBGridEhImportAsText.ReadDataCell(Column: TColumnEh);
var
  ModalResult: Word;
  Field: TField;
  idx: Integer;
begin
  if Column.CanModify(False) then
  begin
    if Column.Field.FieldKind = fkLookUp then
    begin
      if Column.Field.KeyFields <> ''
      then Field := Column.Field
      else Exit;
    end else
      Field := Column.Field;
    if Field.DataSet.CanModify then
    begin
      Field.DataSet.Edit;
      if Field.DataSet.State in [dsEdit, dsInsert] then
      try
        if Column.Field.FieldKind = fkLookUp then
        begin
          if Column.Field.LookupDataSet.Locate(Column.Field.LookupResultField,
            FLastString, [loCaseInsensitive, loPartialKey])
          then
            Column.SetValueAsVariant(
              Column.Field.LookupDataSet[Column.Field.LookupKeyFields]);
        end
        else if Column.GetBarType = ctKeyPickList then
        begin
          idx := Column.PickList.IndexOf(String(FLastString));
          if (idx <> -1) then
            Column.SetValueAsText(Column.KeyList.Strings[idx])
          else
            Column.SetValueAsText('');
        end else
          Column.SetValueAsText(
            Column.GetAcceptableEditText(String(FLastString)));
      except
        on E: Exception do
        begin
          if not FIgnoreAll then
          begin
            ModalResult := MessageDlg(EhLibLanguageConsts.ErrorDuringInsertValue + #10 +
              E.Message + #10 + #10 + EhLibLanguageConsts.IgnoreError, mtError, [mbYes, mbNo, mbAll], 0);
            case ModalResult of
              mrNo: Abort;
              mrAll: FIgnoreAll := True;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TDBGridEhImportAsText.ReadRecord(ColumnsList: TColumnsEhList);
var
  i: Integer;
begin
  if FLastState = itssEof then Exit;
  i := 0;
  if FLastState = itssChar then
  begin
    GetString(FLastString);
    if i < ColumnsList.Count then ReadDataCell(ColumnsList[i]);
    Inc(i);
  end;
  while not (FLastState in [itssNewLine, itssEof]) do
  begin
    GetString(FLastString);
    if i < ColumnsList.Count then ReadDataCell(ColumnsList[i]);
    Inc(i);
  end;
  CheckState;
end;

{ TDBGridEhImportAsUnicodeText }

function TDBGridEhImportAsUnicodeText.CheckState: TImportTextSreamState;
begin
  if GetChar(FLastChar) then
  begin
    if FLastChar = #09 then
      if (FLastState in [itssNewLine,itssTab]) then
      begin
        FLastChar := #00;
        Result := itssChar;
        if Stream.Position >= SizeOf(WideChar) then
          Stream.Position := Stream.Position - SizeOf(WideChar);
      end else
        Result := itssTab
    else if FLastChar = #13 then
    begin
      if GetChar(FLastChar) and (FLastChar = #10) then
        if (FLastState in [itssNewLine,itssTab]) then
        begin
          FLastChar := #00;
          Result := itssChar;
          if Stream.Position >= SizeOf(WideChar)*2 then
            Stream.Position := Stream.Position - SizeOf(WideChar) * 2;
        end else
          Result := itssNewLine
      else
        raise Exception.Create('TDBGridEhImportAsUnicodeText.CheckState: ' + EhLibLanguageConsts.InvalidTextFormat);
    end else if FLastChar = #00 then
    begin
      Result := itssEof;
      Eos := True;
    end else
      Result := itssChar;
  end else
  begin
    Result := itssEof;
    Eos := True;
  end;
  FLastState := Result;
end;

function TDBGridEhImportAsUnicodeText.GetChar(var ch: WideChar): Boolean;
var
  Count: Longint;
begin
  Result := False;
  if Stream.Position = Stream.Size-1 then Exit;
  Count := Stream.Read(ch, SizeOf(WideChar));
  if Count = SizeOf(WideChar) then Result := True;
end;

function TDBGridEhImportAsUnicodeText.GetString(var Value: WideString): TImportTextSreamState;
begin
  Value := '';
  if FLastState = itssChar then
    Value := FLastChar;
  repeat
    Result := CheckState;
    if not (Result = itssChar) then Break;
    Value := Value + FLastChar;
  until False = True;
end;

procedure TDBGridEhImportAsUnicodeText.ImportFromStream(AStream: TStream;
  IsImportAll: Boolean);
begin
  FIgnoreAll := False;
  inherited ImportFromStream(AStream, IsImportAll);
end;

procedure TDBGridEhImportAsUnicodeText.ReadPrefix;
begin
  FLastState := itssNewLine;
  CheckState;
end;

procedure TDBGridEhImportAsUnicodeText.ReadDataCell(Column: TColumnEh);
var
  ModalResult: Word;
  Field: TField;
  idx: Integer;
begin
  if Column.CanModify(False) then
  begin
    if Column.Field.FieldKind = fkLookUp then
    begin
      if Column.Field.KeyFields <> '' then
        Field := Column.Field
      else
        Exit;
    end else
      Field := Column.Field;
    if Field.DataSet.CanModify then
    begin
      Field.DataSet.Edit;
      if Field.DataSet.State in [dsEdit, dsInsert] then
      try
        if Column.Field.FieldKind = fkLookUp then
        begin
          if Column.Field.LookupDataSet.Locate(Column.Field.LookupResultField,
            FLastString, [loCaseInsensitive, loPartialKey])
          then
            Column.SetValueAsVariant(
              Column.Field.LookupDataSet[Column.Field.LookupKeyFields])
        end
        else if Column.GetBarType = ctKeyPickList then
        begin
          idx := Column.PickList.IndexOf(String(FLastString));
          if (idx <> -1) then
            Column.SetValueAsText(Column.KeyList.Strings[idx])
          else
            Column.SetValueAsText('');
        end else
          Column.SetValueAsText(
            Column.GetAcceptableEditText(String(FLastString)));
      except
        on E: Exception do
        begin
          if not FIgnoreAll then
          begin
            ModalResult := MessageDlg(EhLibLanguageConsts.ErrorDuringInsertValue + #10 +
              E.Message + #10 + #10 + EhLibLanguageConsts.IgnoreError, mtError, [mbYes, mbNo, mbAll], 0);
            case ModalResult of
              mrNo: Abort;
              mrAll: FIgnoreAll := True;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TDBGridEhImportAsUnicodeText.ReadRecord(ColumnsList: TColumnsEhList);
var
  i: Integer;
begin
  if FLastState = itssEof then Exit;
  i := 0;
  if FLastState = itssChar then
  begin
    GetString(FLastString);
    if i < ColumnsList.Count then ReadDataCell(ColumnsList[i]);
    Inc(i);
  end;
  while not (FLastState in [itssNewLine, itssEof]) do
  begin
    GetString(FLastString);
    if i < ColumnsList.Count then ReadDataCell(ColumnsList[i]);
    Inc(i);
  end;
  CheckState;
end;

{ TDBGridEhImportAsVCLDBIF }

procedure ReadVCLDBIFStreamPrefix(Stream: TStream; var Prefix: TVCLDBIF_BOF; FieldList: TStringList);
var
  Count: Longint;
  i: Integer;
  b: Byte;
  ch: AnsiChar;
  FieldName: String;
begin
  Count := StreamReadStruct(Stream, Prefix, SizeOf(TVCLDBIF_BOF));
  if Count < SizeOf(TVCLDBIF_BOF) then
    raise Exception.Create('TDBGridEhImportAsVCLDBIF.ReadPrefix: ' + EhLibLanguageConsts.InvalidVCLDBIFFormat);
  if Prefix.Signatura <> 'VCLDBIF' then
    raise Exception.Create('TDBGridEhImportAsVCLDBIF.ReadPrefix: ' + EhLibLanguageConsts.InvalidVCLDBIFFormat);
  for i := 0 to Prefix.ColCount - 1 do
  begin
    Count := Stream.Read(b, SizeOf(Byte));
    if Count < SizeOf(Byte) then
      raise Exception.Create('TDBGridEhImportAsVCLDBIF.ReadPrefix: ' + EhLibLanguageConsts.InvalidVCLDBIFFormat);
    FieldName := '';
    while True do
    begin
      Count := Stream.Read(ch, SizeOf(AnsiChar));
      if Count < SizeOf(Byte) then
        raise Exception.Create('TDBGridEhImportAsVCLDBIF.ReadPrefix: ' + EhLibLanguageConsts.InvalidVCLDBIFFormat);
      if ch <> #0
        then FieldName := FieldName + String(ch)
        else Break;
    end;
    if (FieldList <> nil) then
      FieldList.AddObject(FieldName, TObject(b));
  end;
end;

function ReadValueFromVCLDBIFStream(Stream: TStream; var Value: Variant): Boolean;
var
  AType: Byte;
  Count: Longint;
  LongintValue: Longint;
  DoubleValue: Double;
  StringSize: Longint;
  AnsiStringValue: AnsiString;
  WideStringValue: WideString;
begin
  Result := True;
  Count := Stream.Read(AType, SizeOf(Byte));
  if Count < SizeOf(Byte) then
    raise Exception.Create('TDBGridEhImportAsVCLDBIF.ReadPrefix: ' + EhLibLanguageConsts.InvalidVCLDBIFFormat);
  Value := Unassigned;
  case AType of
    TVCLDBIF_TYPE_EOF:
      Result := False;
    TVCLDBIF_TYPE_NULL:
      Value := Null;
    TVCLDBIF_TYPE_INTEGER32:
      begin
        Count := Stream.Read(LongintValue, SizeOf(Longint));
        if Count < SizeOf(Longint) then
          raise Exception.Create('TDBGridEhImportAsVCLDBIF.ReadPrefix: ' + EhLibLanguageConsts.InvalidVCLDBIFFormat);
        Value := LongintValue;
      end;
    TVCLDBIF_TYPE_FLOAT64:
      begin
        Count := Stream.Read(DoubleValue, SizeOf(Double));
        if Count < SizeOf(Double) then
          raise Exception.Create('TDBGridEhImportAsVCLDBIF.ReadPrefix: ' + EhLibLanguageConsts.InvalidVCLDBIFFormat);
        Value := DoubleValue;
      end;
    TVCLDBIF_TYPE_ANSI_STRING, TVCLDBIF_TYPE_BINARY_DATA:
      begin
        Count := Stream.Read(StringSize, SizeOf(Longint));
        if Count < SizeOf(Longint) then
          raise Exception.Create('TDBGridEhImportAsVCLDBIF.ReadPrefix: ' + EhLibLanguageConsts.InvalidVCLDBIFFormat);
        Count := StreamReadAnsiString(Stream, AnsiStringValue, StringSize);
        if Count < StringSize then
          raise Exception.Create('TDBGridEhImportAsVCLDBIF.ReadPrefix: ' + EhLibLanguageConsts.InvalidVCLDBIFFormat);
        Value := AnsiStringValue;
      end;
    TVCLDBIF_TYPE_WIDE_STRING:
      begin
        Count := Stream.Read(StringSize, SizeOf(Longint));
        if Count < SizeOf(Longint) then
          raise Exception.Create('TDBGridEhImportAsVCLDBIF.ReadPrefix: ' + EhLibLanguageConsts.InvalidVCLDBIFFormat);
        Count := StreamReadWideString(Stream, WideStringValue, StringSize);
        if Count < StringSize then
          raise Exception.Create('TDBGridEhImportAsVCLDBIF.ReadPrefix: ' + EhLibLanguageConsts.InvalidVCLDBIFFormat);
        Value := WideStringValue;
      end;
  else
    raise Exception.Create('ReadValueFromVCLDBIFStream: Unixpected value type: ' + IntToStr(AType));
  end;
end;

procedure AssignAsixBarValueFromVCLDBIFStream(var Value: Variant; AxisBar: TAxisBarEh; var IgnoreAssignError: Boolean);
var
  ModalResult: Word;
  Field: TField;
  FDataFields: TFieldsArrEh;
  StrList: TStringList;
  i: Integer;

  procedure SetValue(SetAsString: Boolean);
  begin
    if Field.DataSet.CanModify then
    begin
      Field.DataSet.Edit;
      if Field.DataSet.State in [dsEdit, dsInsert] then
      try
        if SetAsString then
          AxisBar.SetValueAsText(VarToStr(Value))
        else if (Field is TNumericField) and (VarToStr(Value) = '') then
          AxisBar.SetValueAsVariant(Null)
        else
          AxisBar.SetValueAsVariant(Value);
      except
        on E: Exception do
        begin
          if not IgnoreAssignError then
          begin
            ModalResult := MessageDlg(EhLibLanguageConsts.ErrorDuringInsertValue + #10 + E.Message + #10 + #10 +
              EhLibLanguageConsts.IgnoreError, mtError, [mbYes, mbNo, mbAll], 0);
            case ModalResult of
              mrNo: Abort;
              mrAll: IgnoreAssignError := True;
            end;
          end;
        end;
      end;
    end;
  end;

begin
  FDataFields := nil;
  if not VarIsEmpty(Value) and Assigned(AxisBar) then
  begin
    if AxisBar.CanModify(False) then
    begin
      if AxisBar.LookupParams.LookupActive then
      begin
        FDataFields := GetFieldsProperty(
          AxisBar.Grid.DataSource.DataSet, nil, AxisBar.LookupParams.KeyFieldNames);
        StrList := TStringList.Create;
        try
          StrList.CommaText := String(Value);
          for i := 0 to Length(FDataFields)-1 do
          begin
            Field := FDataFields[i];
            Value := StrList[i];
            SetValue(False);
          end;
        finally
          FreeAndNil(StrList);
        end;
      end else
      begin
        Field := AxisBar.Field;
        SetValue(False);
      end;
    end;
  end;
end;

procedure TDBGridEhImportAsVCLDBIF.ReadPrefix;
var
  i: Integer;
begin
  ReadVCLDBIFStreamPrefix(Stream, Prefix, FieldNames);

  for i := 0 to FieldNames.Count-1 do
    if FieldNames[i] <> '' then
      UseFieldNames := True;

  ReadValue;
end;

procedure TDBGridEhImportAsVCLDBIF.ReadDataCell(Column: TColumnEh);
begin
  AssignAsixBarValueFromVCLDBIFStream(LastValue, Column, FIgnoreAll);
  ReadValue;
end;

procedure TDBGridEhImportAsVCLDBIF.ReadRecord(ColumnsList: TColumnsEhList);
var
  i: Integer;
begin
  for i := 0 to Prefix.ColCount - 1 do
  begin
    if i < ColumnsList.Count
      then ReadDataCell(ColumnsList[i])
      else ReadDataCell(nil);
  end;
end;

procedure TDBGridEhImportAsVCLDBIF.ImportFromStream(AStream: TStream;
  IsImportAll: Boolean);
begin
  FIgnoreAll := False;
  UseFieldNames := False;
  FieldNames := TStringList.Create;
  try
    inherited ImportFromStream(AStream, IsImportAll);
  finally
    FieldNames.Free;
  end;
end;

procedure TDBGridEhImportAsVCLDBIF.ReadValue;
begin
  if Eos then Exit;

  if not ReadValueFromVCLDBIFStream(Stream, LastValue) then
    Eos := True;
end;

{ TDBGridEhExportAsOLEXLS }

{$IFDEF CIL}
{$ELSE}

{$IFDEF MSWINDOWS}
var
  XLSAlignment: array[TAlignment] of Integer = (2, 4, 3);

procedure TDBGridEhExportAsOLEXLS.ExportToStream(AStream: TStream; IsExportAll: Boolean);
begin
  FIsExportAll := IsExportAll;
  ExportToExcel(IsExportAll, []);
end;

procedure TDBGridEhExportAsOLEXLS.ExportToFile(const FileName: String; IsExportAll: Boolean);
begin
  FIsExportAll := IsExportAll;
  ExportToExcel(IsExportAll, []);
  FExcelApp.DefaultFilePath := GetCurrentDir;
  FExcelApp.ActiveWorkbook.SaveAs(FileName);
end;

procedure TDBGridEhExportAsOLEXLS.CalcFooterValues;
begin
  if FDataRowCountMode then Exit;
  inherited CalcFooterValues;
end;

function TDBGridEhExportAsOLEXLS.ExportToExcel(IsExportAll: Boolean; Options: TDBGridEhExportAsOLEXLSOptions): Variant;
begin
  FOptions := Options;
  FIsExportAll := IsExportAll;
  inherited ExportToStream(nil, IsExportAll);
  Result := FExcelApp;
end;

procedure TDBGridEhExportAsOLEXLS.WriteRecord(ColumnsList: TColumnsEhList);
begin
  if FDataRowCountMode then
  begin
    Inc(FDataRowCount);
  end else
  begin
    FCurCol := 1;
    inherited WriteRecord(ColumnsList);
    Inc(FCurRow);
  end;
end;

procedure TDBGridEhExportAsOLEXLS.WriteDataCell(Column: TColumnEh;
  FColCellParamsEh: TColCellParamsEh);
var
  OleVarValue: OleVariant;
begin
  if Column.Checkboxes then
    if FColCellParamsEh.CheckboxState = cbChecked
      then FVarValues[FCurRow-1-FTitleRows, FCurCol-1] := 'X'
      else FVarValues[FCurRow-1-FTitleRows, FCurCol-1] := ''
  else if (Column.Field <> nil) and (Column.Field.FieldKind = fkLookup) then
    FVarValues[FCurRow-1-FTitleRows, FCurCol-1] := Column.Field.AsString
  else if (Column.Field <> nil) then
  begin
    if oxlsDataAsEditText in FOptions then
      OleVarValue := Column.Field.Text
    else if oxlsDataAsDisplayText in FOptions then
      OleVarValue := FColCellParamsEh.Text
    else if (Column.Field.DataType in [ftDate, ftDateTime]) and 
            (not Column.Field.IsNull) and                       
            (Column.Field.AsDateTime < EncodeDate(1900, 1, 1)) then
       OleVarValue := FColCellParamsEh.Text
    else
    begin
      if Column.Field.DataType in [ftBCD, ftFMTBcd] then
      begin
        if not Column.Field.IsNull then
          OleVarValue := Column.Field.AsFloat
        else
          OleVarValue := Null;
      end else
        OleVarValue := Column.Field.Value;
    end;

{    AType := VarType(OleVarValue);
    AType1 := VarType(Column.Field.Value);
    if VarType(Column.Field.Value) = VarSQLTimeStamp then
    begin
      OleVarValue := Column.Field.AsDateTime;
      TimeStamp := DateTimeToSQLTimeStamp(Column.Field.AsDateTime);
      TimeStamp1 := DateTimeToSQLTimeStamp(OleVarValue);
    end;}
    FVarValues[FCurRow-1-FTitleRows, FCurCol-1] := OleVarValue;
  end else
    FVarValues[FCurRow-1-FTitleRows, FCurCol-1] := FColCellParamsEh.Text;

  if (oxlsColoredEh in FOptions) and
     (FColCellParamsEh.Background <> TDBGridEh(DBGridEh).Color) then
  begin
    FActiveSheet.Cells.Item[FCurRow, FCurCol].Interior.Color := ColorToRGB(FColCellParamsEh.Background);
  end;

  Inc(FCurCol);
end;

procedure TDBGridEhExportAsOLEXLS.WriteSuffix;
var
  TopLeft: String;
  BottomRight: Variant;
  i: Integer;
  ARange: Variant;
begin
  if FDataRowCountMode then Exit;

  if (FCurCol = 0) and (FDataRowCount = 0) then
    Exit;

  for i := 0 to ExpCols.Count - 1 do
  begin
    ARange := FActiveSheet.Range[FActiveSheet.Cells.Item[FTitleRows+1, i+1],
                                FActiveSheet.Cells.Item[FTitleRows+FDataRowCount, i+1]];
    if (ExpCols[i].Field = nil) or
       (ExpCols[i].Field.DataType in [ftString, ftMemo, ftFmtMemo, ftWideString])
    then
       ARange.NumberFormat := AnsiString('@');
    if ExpCols[i].Checkboxes then
      ARange.HorizontalAlignment := XLSAlignment[taCenter]
    else
      ARange.HorizontalAlignment := XLSAlignment[ExpCols[i].Alignment];
    SetFontIfNeed(ARange, ExpCols[i].Font);
  end;

  TopLeft := 'A'+IntToStr(FTitleRows+1);
  BottomRight := FActiveSheet.Cells.Item[FTitleRows+FDataRowCount, FCurCol-1];
  ARange := FActiveSheet.Range[TopLeft, BottomRight];
  ARange.Value := FVarValues;

  ARange := FActiveSheet.Range[TopLeft, BottomRight];
  ARange.Value := FVarValues;
  SetFont(ARange, DBGridEh.Font);

  FActiveSheet.Range[TopLeft, BottomRight].Borders[9].LineStyle:=1;
  FActiveSheet.Range[TopLeft, BottomRight].Borders[10].LineStyle:=1;

  if DBGridEh.FooterRowCount > 0 then
  begin
    TopLeft := 'A'+IntToStr(FTitleRows+FDataRowCount+1);
    BottomRight := FActiveSheet.Cells.Item[FTitleRows+FDataRowCount+DBGridEh.FooterRowCount, FCurCol-1];
    FActiveSheet.Range[TopLeft, BottomRight].Borders[9].LineStyle:=1;
    FActiveSheet.Range[TopLeft, BottomRight].Borders[10].LineStyle:=1;
  end;

  FExcelApp.Visible := True;
end;

procedure TDBGridEhExportAsOLEXLS.WritePrefix;
var
  Workbook: Variant;
begin
  if FDataRowCountMode then Exit;
  FExcelApp := CreateOleObject('Excel.Application');

  FExcelApp.Application.EnableEvents := False;
  if DBGridEhDebugDraw then
    FExcelApp.Visible := True;
  Workbook := FExcelApp.WorkBooks.Add;
  FActiveSheet := Workbook.ActiveSheet;
  FCurRow := 1;
  FDataRowCount := 0;

  FDataRowCountMode := True;
  inherited ExportToStream(Stream, FIsExportAll);
  FDataRowCountMode := False;
  FDefaultSizeDelta := FActiveSheet.Range['A1', 'A1'].Font.Size / GetFontSize(DBGridEh.Font);

  if FDataRowCount > 0 then
    FVarValues := VarArrayCreate([0, FDataRowCount-1, 0, ExpCols.Count-1], varVariant);
end;

procedure TDBGridEhExportAsOLEXLS.WriteTitle(ColumnsList: TColumnsEhList);
var
  i, k: Integer;
  FPTitleExpArr: TTitleExpArr;
  ListOfHeadTreeNodeList: TObjectList;
  ColSpan, RowSpan: Integer;
  xf: Double;
  ColumnWidth: Double;
begin
  if FDataRowCountMode then Exit;
  if ColumnsList.Count = 0 then Exit;

  if DBGridEh.IsUseMultiTitle then
  begin
    for i := 0 to ColumnsList.Count - 1 do
    begin
      xf := FActiveSheet.Columns[1+i].ColumnWidth / FActiveSheet.Columns[1+i].Width;
      ColumnWidth := ColumnsList[i].Width * xf;
      FActiveSheet.Columns[1+i].ColumnWidth := ColumnWidth;
    end;

    try
      CreateMultiTitleMatrix(DBGridEh, ColumnsList, FPTitleExpArr, ListOfHeadTreeNodeList);

      for k := ListOfHeadTreeNodeList.Count - 1 downto 0 do
      begin
        for i := 0 to ColumnsList.Count - 1 do
        begin
          if TDBGridMultiTitleNodeEh(TObjectList(ListOfHeadTreeNodeList.Items[k]).Items[i]) <> nil then
          begin
            CalcSpan(ColumnsList, ListOfHeadTreeNodeList, k, i, ColSpan, RowSpan);
            if k - RowSpan = -1 then
            begin
              FActiveSheet.Range[FActiveSheet.Cells[FCurRow, 1+i], FActiveSheet.Cells[FCurRow+RowSpan-1, 1+i+ColSpan-1]].Select;
              FExcelApp.Selection.MergeCells := True;

              FActiveSheet.Cells[FCurRow, 1+i].NumberFormat := String('@');
              FActiveSheet.Cells(FCurRow, 1+i) := TDBGridMultiTitleNodeEh(TObjectList(ListOfHeadTreeNodeList.Items[k]).Items[i]).Text;
              FActiveSheet.Cells[FCurRow, 1+i].HorizontalAlignment := XLSAlignment[ColumnsList[i].Title.Alignment];
              FActiveSheet.Cells[FCurRow, 1+i].WrapText := True;
              SetFontIfNeed(FActiveSheet.Cells[FCurRow, 1+i], ColumnsList[i].Title.Font);
              if ColumnsList[i].Title.Orientation = tohVertical then
                //FActiveSheet.Cells[FCurRow, 1+i].Orientation := $FFFFEFB5;
                FActiveSheet.Cells[FCurRow, 1+i].Orientation := 90;

            end else
            begin
              FActiveSheet.Range[FActiveSheet.Cells[FCurRow, 1+i], FActiveSheet.Cells[FCurRow+RowSpan-1, 1+i+ColSpan-1]].Select;
              FExcelApp.Selection.MergeCells:=True;
              FActiveSheet.Cells(FCurRow, 1+i) := TDBGridMultiTitleNodeEh(TObjectList(ListOfHeadTreeNodeList.Items[k]).Items[i]).Text;
              FActiveSheet.Cells[FCurRow, 1+i].HorizontalAlignment := XLSAlignment[taCenter];
              FActiveSheet.Cells[FCurRow, 1+i].WrapText := True;
              SetFontIfNeed(FActiveSheet.Cells[FCurRow, 1+i], DBGridEh.TitleFont);
            end;
          end;
        end;
        Inc(FCurRow);
      end;

      FTitleRows := FCurRow-1;

    finally
      for i := 0 to ListOfHeadTreeNodeList.Count - 1 do
        FreeObjectEh(ListOfHeadTreeNodeList.Items[i]);
      FreeAndNil(ListOfHeadTreeNodeList);
    end;
    FActiveSheet.Cells[1,1].Activate;

  end else
  begin
    for i := 0 to ColumnsList.Count - 1 do
    begin
      xf := FActiveSheet.Columns[1+i].ColumnWidth / FActiveSheet.Columns[1+i].Width;
{$IFDEF CPUX64}
      FActiveSheet.Columns[1+i].ColumnWidth := Round(ColumnsList[i].Width * xf); 
{$ELSE}
      FActiveSheet.Columns[1+i].ColumnWidth := ColumnsList[i].Width * xf;
{$ENDIF}
      FActiveSheet.Cells[FCurRow, 1+i].NumberFormat := String('@');
      FActiveSheet.Cells(FCurRow, 1+i) := ColumnsList[i].Title.Caption;
      FActiveSheet.Cells[FCurRow, 1+i].HorizontalAlignment := XLSAlignment[ColumnsList[i].Title.Alignment];
      SetFontIfNeed(FActiveSheet.Cells[FCurRow, 1+i], ColumnsList[i].Title.Font);
      if ColumnsList[i].Title.Orientation = tohVertical then
      begin
        FActiveSheet.Cells[FCurRow, 1+i].Orientation := 90;
        FActiveSheet.Cells[FCurRow, 1+i].HorizontalAlignment := XLSAlignment[taCenter];
      end;
    end;
    Inc(FCurRow);
    FTitleRows := 1;
  end;
  FActiveSheet.Range[FActiveSheet.Cells[1, 1], FActiveSheet.Cells[FTitleRows, ColumnsList.Count]].Borders.LineStyle:=1;
end;

procedure TDBGridEhExportAsOLEXLS.WriteFooter(ColumnsList: TColumnsEhList;
  FooterNo: Integer);
begin
  if FDataRowCountMode then Exit;
  FCurCol := 1;
  inherited WriteFooter(ColumnsList, FooterNo);
  Inc(FCurRow);
end;

procedure TDBGridEhExportAsOLEXLS.WriteFooterCell(DataCol, Row: Integer;
  Column: TColumnEh; AFont: TFont; Background: TColor;
  Alignment: TAlignment; const Text: String);
var
  Footer: TColumnFooterEh;
  ACell: Variant;
begin
  Footer := Column.ColumnUsedFooter(Row);
  FActiveSheet.Cells(FCurRow, FCurCol) := Text;
  ACell := FActiveSheet.Cells[FCurRow, FCurCol];
  ACell.HorizontalAlignment := XLSAlignment[Footer.Alignment];
  SetFontIfNeed(FActiveSheet.Cells[FCurRow, FCurCol], AFont);
  Inc(FCurCol);
end;

procedure TDBGridEhExportAsOLEXLS.SetFontIfNeed(Range: Variant; Font: TFont);
begin
  if (DBGridEh.Font.Style <> Font.Style) or
     (DBGridEh.Font.Color <> Font.Color) or
     (GetFontSize(DBGridEh.Font) <> GetFontSize(Font)) then
    SetFont(Range, Font);
end;

procedure TDBGridEhExportAsOLEXLS.SetFont(Range: Variant; Font: TFont);
begin
  if fsBold in Font.Style then
    Range.Font.Bold := True;
  if fsItalic in Font.Style then
    Range.Font.Italic := True;
  if fsUnderline in Font.Style then
    Range.Font.Underline := $00000002;
  if fsStrikeOut in Font.Style then
    Range.Font.Strikethrough := True;
  Range.Font.Color := ColorToRGB(Font.Color);
  Range.Font.Size := Integer(Round(GetFontSize(Font) * FDefaultSizeDelta));
end;

function ExportDBGridEhToOleExcel(DBGridEh: TCustomDBGridEh;
  Options: TDBGridEhExportAsOLEXLSOptions; IsSaveAll: Boolean = True
  ): Variant;
var
  OLEXLS: TDBGridEhExportAsOLEXLS;
begin
  OLEXLS := TDBGridEhExportAsOLEXLS.Create;
  try
    OLEXLS.DBGridEh := DBGridEh;
    Result := OLEXLS.ExportToExcel(IsSaveAll, Options);
  finally
    OLEXLS.Free;
  end;
end;
{$ELSE}
{$ENDIF}


{ TDBGridEhExportAsXlsx }

const sTestLineBreak = ' ';
const sShortTestLineBreak = '';

function StrToXMLValue(const s: String): String;
begin
  Result := s;
  Result := StringReplace(Result, #0, ' ', [rfReplaceAll]);
  Result := StringReplace(Result,   '&', '&amp;',[rfReplaceAll]);
  Result := StringReplace(Result, '<', '&lt;',[rfReplaceAll]);
  Result := StringReplace(Result, '>', '&gt;',[rfReplaceAll]);
end;

procedure InitXMLDocument(var XML: IXMLDocument);
begin
  XML.Options := XML.Options-[doNamespaceDecl];
  XML.Encoding := 'UTF-8';
  XML.StandAlone := 'yes';
end;

procedure ToTheme(var Stream: TStream);
{$IFDEF FPC}
var
  XML: TXMLDocument;
  SS: TStringStream;
begin
  SS := TStringStream.Create(SThemeEh);
  ReadXMLFile(XML, SS);
  SS.Free;
  XML.SetHeaderData(xmlVersion10, 'UTF-8');
  WriteXMLFile(XML, Stream);
end;
{$ELSE}
var
  Xml: IXMLDocument;
begin
  Xml := NewXMLDocument;
  Xml.LoadFromXML(SThemeEh);
  InitXMLDocument(Xml);
  Xml.SaveToStream(Stream);
end;
{$ENDIF}

procedure ToRels(var Stream: TStream);
const
  st = 'http://schemas.openxmlformats.org/package/2006/relationships';
  ArrId: array [1 .. 3] of string = ('rId3', 'rId2', 'rId1');
  ArrType: array [1 .. 3] of string =
    ('http://schemas.openxmlformats.org/officeDocument/2006/relationships/extended-properties',
     'http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties',
     'http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument');
  ArrTarget: array [1 .. 3] of string = (
    'docProps/app.xml',
    'docProps/core.xml',
    'xl/workbook.xml');
var
  i: Integer;
  Xml: IXMLDocument;
  Root: IXMLNode;
begin
  Xml := NewXMLDocument;

  InitXMLDocument(Xml);
  Xml.AddChild('Relationships').Attributes['xmlns'] := st;
  for i := 1 to 3 do
  begin
    Root := Xml.CreateElement('Relationship', st);
    Root.Attributes['Id'] := ArrId[i];
    Root.Attributes['Type'] := ArrType[i];
    Root.Attributes['Target'] := ArrTarget[i];
    Xml.DocumentElement.ChildNodes.Add(Root);
  end;
  Xml.SaveToStream(Stream);
end;

procedure ToRelsWorkbook(var Stream: TStream);
const
  st = 'http://schemas.openxmlformats.org/package/2006/relationships';
  ArrId: array [1 .. 3] of string = ('rId3', 'rId2', 'rId1');
  ArrType: array [1 .. 3] of string =
    ('http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles',
    'http://schemas.openxmlformats.org/officeDocument/2006/relationships/theme',
    'http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet');
  ArrTarget: array [1 .. 3] of string = ('styles.xml', 'theme/theme1.xml',
    'worksheets/sheet1.xml');
var
  i: Integer;
  Xml: IXMLDocument;
  Root: IXMLNode;
begin
  Xml := NewXMLDocument;

  InitXMLDocument(Xml);
  Xml.AddChild('Relationships').Attributes['xmlns'] := st;
  for i := 1 to 3 do
  begin
    Root := Xml.CreateElement('Relationship', st);
    Root.Attributes['Id'] := ArrId[i];
    Root.Attributes['Type'] := ArrType[i];
    Root.Attributes['Target'] := ArrTarget[i];
    Xml.DocumentElement.ChildNodes.Add(Root);
  end;
  Xml.SaveToStream(Stream);
end;

procedure ToApp(var Stream: TStream);
const
  st = 'http://schemas.openxmlformats.org/officeDocument/2006/extended-properties';
  ArrElement: array [1 .. 8] of string = ('Application', 'DocSecurity', 'ScaleCrop',
    'Company', 'LinksUpToDate', 'SharedDoc', 'HyperlinksChanged', 'AppVersion');
  ArrText: array [1 .. 8] of string = ('Microsoft Excel', '0', 'false',
    '', 'false', 'false', 'false', '14.0300');
var
  i: Integer;
  Xml: IXMLDocument;
  Root, Node: IXMLNode;
begin
  Xml := NewXMLDocument;
  InitXMLDocument(Xml);
  Root := Xml.AddChild('Properties');
  Root.Attributes['xmlns'] := st;
  Root.Attributes['xmlns:vt'] := 'http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes';

  for i := 1 to 8 do
  begin
    Root := Xml.CreateElement(ArrElement[i], st);
    Root.Text := ArrText[i];
    Xml.DocumentElement.ChildNodes.Add(Root);
  end;

  Root := Xml.CreateElement('HeadingPairs', st);
  Node := Root.AddChild('vt:vector');
  Node.Attributes['size'] := 2;
  Node.Attributes['baseType'] := 'variant';
  Node.AddChild('vt:variant').AddChild('vt:lpstr').Text := 'Sheets';
  Node.AddChild('vt:variant').AddChild('vt:i4').Text := '1';
  Xml.DocumentElement.ChildNodes.Add(Root);

  Root := Xml.CreateElement('TitlesOfParts', st);
  Node := Root.AddChild('vt:vector');
  Node.Attributes['size'] := 1;
  Node.Attributes['baseType'] := 'lpstr';
  Node.AddChild('vt:lpstr').Text := 'Sheet1';
  Xml.DocumentElement.ChildNodes.Add(Root);

  Xml.SaveToStream(Stream);
end;

procedure ToCore(var Stream: TStream);
const
  st = 'http://schemas.openxmlformats.org/package/2006/metadata/core-properties';
  ArrAttribut: array [1 .. 5] of string = ('xmlns:cp', 'xmlns:dc',
    'xmlns:dcterms', 'xmlns:dcmitype', 'xmlns:xsi');
  ArrTextAttribut: array [1 .. 5] of string = (st,
    'http://purl.org/dc/elements/1.1/', 'http://purl.org/dc/terms/',
    'http://purl.org/dc/dcmitype/',
    'http://www.w3.org/2001/XMLSchema-instance');
  ArrCreator: array [1 .. 3] of string = ('dc:creator', 'cp:lastModifiedBy',
    'dcterms:created');
var
  i: Integer;
  Xml: IXMLDocument;
  Root: IXMLNode;
begin
  Xml := NewXMLDocument;
  InitXMLDocument(Xml);
  Root := Xml.AddChild('cp:coreProperties');
  for i := 1 to 5 do
    Root.Attributes[ArrAttribut[i]] := ArrTextAttribut[i];

  for i := 1 to 3 do
  begin
    Root := Xml.CreateElement(ArrCreator[i], '');
    if i < 3 then
      Root.Text := 'EhLib'
    else
      Root.Text := FormatDateTime('yyyy-mm-dd', Date) + 'T' +
        FormatDateTime('hh:mm:ss', Time) + 'Z';
    Xml.DocumentElement.ChildNodes.Add(Root);
  end;
  Root.Attributes['xsi:type'] := 'dcterms:W3CDTF';

  Xml.SaveToStream(Stream);
end;

procedure ToSheet(var Xml: IXMLDocument);
const
  st = 'http://schemas.openxmlformats.org/spreadsheetml/2006/main';
  ArrAttributes: array [1 .. 5] of string = (st,
    'http://schemas.openxmlformats.org/officeDocument/2006/relationships',
    'http://schemas.openxmlformats.org/markup-compatibility/2006', 'x14ac',
    'http://schemas.microsoft.com/office/spreadsheetml/2009/9/ac');
  ArrNameAttributes: array [1 .. 5] of string = ('xmlns', 'xmlns:r', 'xmlns:mc',
    'mc:Ignorable', 'xmlns:x14ac');
var
  i: Integer;
  Root, Node: IXMLNode;
begin
  Xml := NewXMLDocument;
  InitXMLDocument(Xml);
  Root := Xml.AddChild('worksheet');
  for i := 1 to 5 do
    Root.Attributes[ArrNameAttributes[i]] := ArrAttributes[i];

  Root := Xml.CreateElement('dimension', st);
  Root.Attributes['ref'] := 'A1';
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('sheetViews', st);
  Node := Root.AddChild('sheetView');
  Node.Attributes['tabSelected'] := '1';
  Node.Attributes['workbookViewId'] := '0';
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('sheetFormatPr', st);
  Root.Attributes['defaultRowHeight'] := '15';
  Root.Attributes['x14ac:dyDescent'] := '0.25';
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('cols', st);
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('sheetData', st);
  Xml.DocumentElement.ChildNodes.Add(Root);
end;

procedure ToSheetStrSm(Stream: TStringStream);
begin
  Stream.WriteString('<?xml version="1.0" encoding="UTF-8" standalone="yes"?>');
  Stream.WriteString(sLineBreak);
  Stream.WriteString('<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main"');
  Stream.WriteString(sTestLineBreak);
  Stream.WriteString('  xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"');
  Stream.WriteString(sTestLineBreak);
  Stream.WriteString('  xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"');
  Stream.WriteString(sTestLineBreak);
  Stream.WriteString('  mc:Ignorable="x14ac"');
  Stream.WriteString(sTestLineBreak);
  Stream.WriteString('  xmlns:x14ac="http://schemas.microsoft.com/office/spreadsheetml/2009/9/ac">');
  Stream.WriteString(sShortTestLineBreak);

  Stream.WriteString('<dimension ref="A1"/>');
  Stream.WriteString(sShortTestLineBreak);

  Stream.WriteString('<sheetViews>');
  Stream.WriteString(sShortTestLineBreak);
  Stream.WriteString('<sheetView tabSelected="1" workbookViewId="0"/>');
  Stream.WriteString(sShortTestLineBreak);
  Stream.WriteString('</sheetViews>');
  Stream.WriteString(sShortTestLineBreak);

  Stream.WriteString('<sheetFormatPr defaultRowHeight="15" x14ac:dyDescent="0.25"/>');
  Stream.WriteString(sShortTestLineBreak);
end;

procedure ToWorkbook(var Stream: TStream);
const
  st = 'http://schemas.openxmlformats.org/spreadsheetml/2006/main';
  ArrAttributes: array [1 .. 11] of string = ('xl', '5', '5', '9303', '480',
    '120', '27795', '12585', 'Sheet1', '1', 'rId1');
  ArrNameAttributes: array [1 .. 11] of string = ('appName', 'lastEdited',
    'lowestEdited', 'rupBuild', 'xWindow', 'yWindow', 'windowWidth',
    'windowHeight', 'name', 'sheetId', 'r:id');
var
  i: Integer;
  Xml: IXMLDocument;
  Root, Node: IXMLNode;
begin
  Xml := NewXMLDocument;
  InitXMLDocument(Xml);
  Root := Xml.AddChild('workbook');
  Root.Attributes['xmlns'] := st;
  Root.Attributes['xmlns:r'] :=
    'http://schemas.openxmlformats.org/officeDocument/2006/relationships';

  Root := Xml.CreateElement('fileVersion', st);
  for i := 1 to 4 do
    Root.Attributes[ArrNameAttributes[i]] := ArrAttributes[i];
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('workbookPr', st);
  Root.Attributes['defaultThemeVersion'] := '124226';
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('bookViews', st);
  Node := Root.AddChild('workbookView');
  for i := 5 to 8 do
    Node.Attributes[ArrNameAttributes[i]] := ArrAttributes[i];
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('sheets', st);
  Node := Root.AddChild('sheet');
  for i := 9 to 11 do
    Node.Attributes[ArrNameAttributes[i]] := ArrAttributes[i];
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('calcPr', st);
  Root.Attributes['calcId'] := '145621';
  Xml.DocumentElement.ChildNodes.Add(Root);

  Xml.SaveToStream(Stream);
end;

procedure ToStyles(var Xml: IXMLDocument);
const
  st = 'http://schemas.openxmlformats.org/spreadsheetml/2006/main';
  ArrAttributes: array [1 .. 25] of string = (st,
    'http://schemas.openxmlformats.org/markup-compatibility/2006', 'x14ac',
    'http://schemas.microsoft.com/office/spreadsheetml/2009/9/ac', '11', '1',
    'Calibri', '2', '204', 'minor', '0', '0', '0', '0', '0', '0', '0', '0', '0',
    'Normal', '0', '0', '0', 'TableStyleMedium2', 'PivotStyleLight16');
  ArrNameAttributes: array [1 .. 25] of string = ('xmlns', 'xmlns:mc',
    'mc:Ignorable', 'xmlns:x14ac', 'val', 'theme', 'val', 'val', 'val', 'val',
    'numFmtId', 'fontId', 'fillId', 'borderId', 'numFmtId', 'fontId', 'fillId',
    'borderId', 'xfId', 'name', 'xfId', 'builtinId', 'count',
    'defaultTableStyle', 'defaultPivotStyle');
  ArrChild: array [5 .. 15] of string = ('sz', 'color', 'name', 'family',
    'charset', 'scheme', 'left', 'right', 'top', 'bottom', 'diagonal');
var
  i: Integer;
  Root, Node: IXMLNode;
begin
  Xml := NewXMLDocument;
  InitXMLDocument(Xml);
  Root := Xml.AddChild('styleSheet');
  for i := 1 to 1 do
    Root.Attributes[ArrNameAttributes[i]] := ArrAttributes[i];

  Root := Xml.CreateElement('fonts', st);
  Root.Attributes['count'] := '1';
  Node := Root.AddChild('font');
  for i := 5 to 10 do
    Node.AddChild(ArrChild[i]).Attributes[ArrNameAttributes[i]] := ArrAttributes[i];
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('fills', st);
  Root.Attributes['count'] := '2';
  Root.AddChild('fill').AddChild('patternFill').Attributes['patternType'] := 'none';
  Root.AddChild('fill').AddChild('patternFill').Attributes['patternType'] := 'gray125';
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('borders', st);
  Root.Attributes['count'] := '1';
  Node := Root.AddChild('border');
  for i := 11 to 15 do
    Node.AddChild(ArrChild[i]);
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('cellStyleXfs', st);
  Root.Attributes['count'] := '1';
  Node := Root.AddChild('xf');
  for i := 11 to 14 do
    Node.Attributes[ArrNameAttributes[i]] := ArrAttributes[i];
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('cellXfs', st);
  Root.Attributes['count'] := '1';
  Node := Root.AddChild('xf');
  for i := 15 to 19 do
    Node.Attributes[ArrNameAttributes[i]] := ArrAttributes[i];
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('cellStyles', st);
  Root.Attributes['count'] := '1';
  Node := Root.AddChild('cellStyle');
  for i := 20 to 22 do
    Node.Attributes[ArrNameAttributes[i]] := ArrAttributes[i];
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('dxfs', st);
  Root.Attributes['count'] := '0';
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('tableStyles', st);
  for i := 23 to 25 do
    Root.Attributes[ArrNameAttributes[i]] := ArrAttributes[i];
  Xml.DocumentElement.ChildNodes.Add(Root);
  Root := Xml.CreateElement('extLst', st);
  Node := Root.AddChild('ext');
  Node.Attributes['uri'] := '{EB79DEF2-80B8-43e5-95BD-54CBDDF9020C}';
  Node.Attributes['xmlns:x14'] := 'http://schemas.microsoft.com/office/spreadsheetml/2009/9/main';
  Node.AddChild('x14:slicerStyles').Attributes['defaultSlicerStyle'] := 'SlicerStyleLight1';
  Xml.DocumentElement.ChildNodes.Add(Root);
end;

procedure ToContentTypes(var Stream: TStream);
const
  st = 'http://schemas.openxmlformats.org/package/2006/content-types';
  ArrExtension: array [1 .. 8] of string = ('rels', 'xml', '/xl/workbook.xml',
    '/xl/worksheets/sheet1.xml', '/xl/theme/theme1.xml', '/xl/styles.xml',
    '/docProps/core.xml', '/docProps/app.xml');
  ArrContent: array [1 .. 8] of string =
    ('application/vnd.openxmlformats-package.relationships+xml',
    'application/xml',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml',
    'application/vnd.openxmlformats-officedocument.theme+xml',
    'application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml',
    'application/vnd.openxmlformats-package.core-properties+xml',
    'application/vnd.openxmlformats-officedocument.extended-properties+xml');
var
  i: Integer;
  Xml: IXMLDocument;
  Root: IXMLNode;
begin
  Xml := NewXMLDocument;
  InitXMLDocument(Xml);
  Root := Xml.AddChild('Types');
  Root.Attributes['xmlns'] := st;

  for i := 1 to 2 do
  begin
    Root := Xml.CreateElement('Default', st);
    Root.Attributes['Extension'] := ArrExtension[i];
    Root.Attributes['ContentType'] := ArrContent[i];
    Xml.DocumentElement.ChildNodes.Add(Root);
  end;

  for i := 3 to 8 do
  begin
    Root := Xml.CreateElement('Override', st);
    Root.Attributes['PartName'] := ArrExtension[i];
    Root.Attributes['ContentType'] := ArrContent[i];
    Xml.DocumentElement.ChildNodes.Add(Root);
  end;

  Xml.SaveToStream(Stream);
end;

procedure TDBGridEhExportAsXlsx.ExportToStream(AStream: TStream; IsExportAll: Boolean);
var
  InternalStream: TStream;
begin
  FIsExportAll := IsExportAll;
  if ZipFileProviderClass = nil then
    raise Exception.Create('ZipFileProviderClass is not assigned');
  FZipFileProvider := ZipFileProviderClass.CreateInstance;
  try
    InternalStream := FZipFileProvider.InitZipFileWriting('');
    inherited ExportToStream(InternalStream, IsExportAll);
  finally
    FZipFileProvider.FinalizeZipFile(AStream);
    FreeAndNil(FZipFileProvider);
  end;
end;

procedure TDBGridEhExportAsXlsx.ExportToFile(const FileName: String; IsExportAll: Boolean);
var
  AStream: TStream;
begin
  FIsExportAll := IsExportAll;
  if ZipFileProviderClass = nil then
    raise Exception.Create('ZipFileProviderClass is not assigned');
  FZipFileProvider := ZipFileProviderClass.CreateInstance;
  try
    AStream := FZipFileProvider.InitZipFileWriting(FileName);
    inherited ExportToStream(AStream, IsExportAll);
  finally
    FZipFileProvider.FinalizeZipFile;
    FreeAndNil(FZipFileProvider);
  end;
end;

procedure TDBGridEhExportAsXlsx.CalcFooterValues;
begin
  inherited CalcFooterValues;
end;

procedure TDBGridEhExportAsXlsx.WriteRecord(ColumnsList: TColumnsEhList);
var
  n: Integer;
begin
  FCurCol := 1;

  n := FExpCols.Count;

  FSheetStr.WriteString('<row r="' + IntToStr(FCurRow)+'"');
  FSheetStr.WriteString(' spans="1:' + IntToStr(n)+'"');
  FSheetStr.WriteString(' x14ac:dyDescent="0.25">');

  inherited WriteRecord(ColumnsList);

  FSheetStr.WriteString('</row>');
  Inc(FCurRow);
end;

const
  ZE_STR_ARRAY: array [0..25] of char = (
  'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N',
  'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z');

function ZEGetA1byCol(ColNum: Integer; StartZero: Boolean = True): string;
var
  t, n: Integer;
  S: string;
begin
  t := ColNum;
  if (not StartZero) then
    Dec(t);
  Result := '';
  S := '';
  while t >= 0 do
  begin
    n := t mod 26;
    t := (t div 26) - 1;
    S := S + ZE_STR_ARRAY[n];
  end;
  for t := Length(S) downto 1 do
    Result := Result + S[t];
end;

function IsNumber(const st: String): Boolean;
var
  b: Boolean;
  i, n: Integer;
begin
  b := True;
  n := Length(st);
  for i := 1 to n do
    if not CharInSetEh(st[i], ['#', '0', ',', '.']) then
      b := False;
  Result := b;
end;

function ColorToHex(Acolor: TColor): String;
begin
  Result :=
    IntToHex(GetRValue(ColorToRGB(AColor)), 2) +
    IntToHex(GetGValue(ColorToRGB(AColor)), 2) +
    IntToHex(GetBValue(ColorToRGB(AColor)), 2);
end;

procedure TDBGridEhExportAsXlsx.WriteDataCell(Column: TColumnEh;
  FColCellParamsEh: TColCellParamsEh);
var
  t, f: Boolean;
  temp, b, NumFmt: Integer;
  Data: Variant;
  Color: TColor;
  Val, rAtr, tAtr: String;
begin
  Val := '';
  tAtr := '';
  rAtr := ZEGetA1byCol(FCurCol - 1) + IntToStr(FCurRow);

  NumFmt := 0;
  b := 0;
  if Column.Grid.GridLineParams.DataHorzLines then
    b := b + 1;
  if Column.Grid.GridLineParams.DataVertLines then
    b := b + 2;

  if dghAutoFitRowHeight in Column.Grid.OptionsEh
    then t := True
    else t := False;

  if xlsxColoredEh in FOptions
    then Color := FColCellParamsEh.Background
    else Color := TDBGridEh(DBGridEh).Color;

  if Column.LookupParams.LookupActive then
  begin
    tAtr := 'str';
    Val := FColCellParamsEh.Text;
  end else if Column.Field = nil then
    Val := ''
  else if Column.GetBarType = ctKeyPickList then
  begin
    tAtr := 'str';
    Val := FColCellParamsEh.Text;
  end
  else if Column.Field.IsNull then
    Val := ''
  else
  begin
    if xlsxDataAsEditText in FOptions then
    begin
      Data := Column.Field.Text;
      tAtr := 'str';
    end
    else if xlsxDataAsDisplayText in FOptions then
    begin
      Data := FColCellParamsEh.Text;
      tAtr := 'str';
    end
    else if (Column.Field.DataType in [ftDate, ftDateTime])
    then
    begin
      Data := FColCellParamsEh.Text;
      tAtr := 'str';
    end
    else
    begin
      if Column.Field.DataType in
        [ftBlob, ftGraphic, ftParadoxOle, ftDBaseOle, ftOraBlob,
         ftBytes, ftTypedBinary, ftVarBytes]
      then
        Data := ''
      else
        Data := Column.Field.Value;
      f := False;
      if (Column.Field.DataType in
             [ftSmallint, ftInteger, ftWord, ftAutoInc, ftBytes, ftFloat, ftCurrency,
              ftBCD, ftFMTBcd{$IFDEF EH_LIB_13}, ftSingle{$ENDIF}]) and
         (Column.DisplayFormat <> '')
      then
        if IsNumber(Column.DisplayFormat) then
        begin
          NumFmt := FNumFmt;
          Inc(FNumFmt);
        end
        else
          f := True;
      if f or not ( Column.Field.DataType in [ftSmallint, ftInteger, ftWord, ftAutoInc,
                                              ftBytes, ftFloat, ftCurrency, ftBCD, ftFMTBcd
                                              {$IFDEF EH_LIB_13}, ftSingle{$ENDIF}])
      then
        tAtr := 'str';
    end;

    Val := SysVarToStr(Data);
  end;

  temp := SetStyle(NumFmt, FColCellParamsEh.Font, Integer(FColCellParamsEh.Alignment), Color, b, False, t);

  FSheetStr.WriteString('<c ');
    FSheetStr.WriteString('r="'+ rAtr +'"');
    if tAtr <> '' then
      FSheetStr.WriteString(' t="'+ tAtr +'"');
    if temp > 0 then
      FSheetStr.WriteString(' s="'+ IntToStr(temp) +'"');
    FSheetStr.WriteString('>');

    FSheetStr.WriteString('<v>'+StrToXMLValue(Val)+'</v>');
  FSheetStr.WriteString('</c>');

  Inc(FCurCol);
end;

procedure TDBGridEhExportAsXlsx.WriteSuffix;
var
  i, n: Integer;
  Res: TStream;
  Color: TColor;
  Root, Node, Node2: IXMLNode;
  {$IFDEF EH_LIB_12}
  {$ELSE}
  s: String;
  {$ENDIF}
begin
  FRowNode := nil;

  if (FCurCol = 0) and (FDataRowCount = 0) then
  begin
    FreeAndNil(FSheetStr);
    FreeAndNil(FSheetMergeStr);
    Exit;
  end;

  FSheetStr.WriteString('</sheetData>');
  if FSheetMergeCount > 0 then
  begin
    FSheetStr.WriteString('<mergeCells count="'+IntToStr(FSheetMergeCount)+'">');
    FSheetStr.WriteString(FSheetMergeStr.DataString);
    FSheetStr.WriteString('</mergeCells>');
  end;
  FSheetStr.WriteString('<pageMargins left="0.7" right="0.7" top="0.75" bottom="0.75" header="0.3" footer="0.3"/>');
  FSheetStr.WriteString('</worksheet>');
  FSheetStr.WriteString(sShortTestLineBreak);

  {$IFDEF EH_LIB_12}
  {$ELSE}
  s  := AnsiToUtf8(FSheetStr.DataString);
  FSheetStr.Size := 0;
  FSheetStr.WriteString(s);
  {$ENDIF}

  FSheetStr.Seek(System.Longint(0), soFromBeginning);

  FZipFileProvider.AddFile(FSheetStr, 'xl/worksheets/sheet1.xml');

  if FNumFmt > 164 then
    FXMLStyles.DocumentElement.ChildNodes.Insert(0, FFmtNode);

  n := Length(FFonts);
  Root := FXMLStyles.DocumentElement.ChildNodes.FindNode('fonts');
  Root.Attributes['count'] := n;
  FFonts[0].Free;
  for i := 1 to n - 1 do
  begin
    Node := Root.AddChild('font');
    if fsBold in FFonts[i].Style then
      Node.AddChild('b');
    if fsItalic in FFonts[i].Style then
      Node.AddChild('i');
    if fsUnderline in FFonts[i].Style then
      Node.AddChild('u');
    if fsStrikeOut in FFonts[i].Style then
      Node.AddChild('strike');
    Node.AddChild('sz').Attributes['val'] := GetFontSize(FFonts[i]);
    Node.AddChild('color').Attributes['rgb'] := 'FF' + ColorToHex(FFonts[i].Color);
    Node.AddChild('name').Attributes['val'] := FFonts[i].Name;
    Node.AddChild('family').Attributes['val'] := 2;
    Node.AddChild('charset').Attributes['val'] := 204;
    FFonts[i].Free;
  end;
  SetLength(FFonts, 0);

  n := Length(FBackColor);
  Root := FXMLStyles.DocumentElement.ChildNodes.FindNode('fills');
  Root.Attributes['count'] := n;
  for i := 2 to n - 1 do
  begin
    Node := Root.AddChild('fill').AddChild('patternFill');
    Node.Attributes['patternType'] := 'solid';
    Node.AddChild('fgColor').Attributes['rgb'] := 'FF' + ColorToHex(FBackColor[i]);
    Node.AddChild('bgColor').Attributes['index'] := 0;
  end;
  SetLength(FBackColor, 0);

  n := Length(FBorder);
  Root := FXMLStyles.DocumentElement.ChildNodes.FindNode('borders');
  Root.Attributes['count'] := n;
  for i := 1 to n - 1 do
  begin
    Node := Root.AddChild('border');
    if FBorder[i] div 2 = 1 then
    begin
      Color := DBGridEh.GridLineParams.DataVertColor;
      Node2 := Node.AddChild('left');
      Node2.Attributes['style'] := 'thin';
      Node2.AddChild('color').Attributes['rgb'] := 'FF' + ColorToHex(Color);
      Node2 := Node.AddChild('right');
      Node2.Attributes['style'] := 'thin';
      Node2.AddChild('color').Attributes['rgb'] := 'FF' + ColorToHex(Color);
    end;
    if FBorder[i] mod 2 = 1 then
    begin
      Color := DBGridEh.GridLineParams.DataHorzColor;
      Node2 := Node.AddChild('top');
      Node2.Attributes['style'] := 'thin';
      Node2.AddChild('color').Attributes['rgb'] := 'FF' + ColorToHex(Color);
      Node2 := Node.AddChild('bottom');
      Node2.Attributes['style'] := 'thin';
      Node2.AddChild('color').Attributes['rgb'] := 'FF' + ColorToHex(Color);
    end;
  end;
  SetLength(FBorder, 0);

  n := Length(FStyles);
  Root := FXMLStyles.DocumentElement.ChildNodes.FindNode('cellXfs');
  Root.Attributes['count'] := n;
  for i := 1 to n - 1 do
  begin
    Node := Root.AddChild('xf');
    Node.Attributes['numFmtId'] := FStyles[i].NumFmt;
    Node.Attributes['fontId'] := FStyles[i].NumFont;
    Node.Attributes['fillId'] := FStyles[i].NumBackColor;
    Node.Attributes['borderId'] := FStyles[i].NumBorder;
    Node.Attributes['xfId'] := 0;
    Node.Attributes['applyFont'] := 1;
    Node.Attributes['applyAlignment'] := 1;
    Node.Attributes['applyFill'] := 1;
    Node.Attributes['applyBorder'] := 1;
    Node2 := Node.AddChild('alignment');

    case FStyles[i].NumAlignment of
      0: Node2.Attributes['horizontal'] := 'left';
      1: Node2.Attributes['horizontal'] := 'right';
      2: Node2.Attributes['horizontal'] := 'center';
    end;
    if FStyles[i].Vertical then
      Node2.Attributes['textRotation'] := 90;
    if FStyles[i].Wrap then
      Node2.Attributes['wrapText'] := 1;
  end;
  SetLength(FStyles, 0);

  Res := TMemoryStream.Create;
  FXMLStyles.SaveToStream(Res);
  Res.Seek(System.Longint(0), soFromBeginning);
  FZipFileProvider.AddFile(Res, 'xl/styles.xml');
  Res.Free;

  FreeAndNil(FSheetStr);
  FreeAndNil(FSheetMergeStr);

  FormatSettings.DecimalSeparator := FSeparator;
end;

procedure TDBGridEhExportAsXlsx.WritePrefix;
const
  Resours: array [1 .. 7] of procedure(var Stream: TStream) =
    (ToTheme, ToRels, ToApp, ToCore, ToRelsWorkbook, ToWorkbook, ToContentTypes);
  ResoursFile: array [1 .. 7] of string = ('xl/theme/theme1.xml', '_rels/.rels',
  'docProps/app.xml', 'docProps/core.xml', 'xl/_rels/workbook.xml.rels',
  'xl/workbook.xml', '[Content_Types].xml');
var
  i: Integer;
  Res: TStream;
begin
  FSeparator := FormatSettings.DecimalSeparator;
  if not(xlsxDataAsEditText in FOptions) and
    not(xlsxDataAsDisplayText in FOptions)
  then
    FormatSettings.DecimalSeparator := '.';

  for i := 1 to 7 do
  begin
    Res := TMemoryStream.Create;
    Resours[i](Res);
    Res.Seek(System.Longint(0), soFromBeginning);
    FZipFileProvider.AddFile(Res, ResoursFile[i]);
    Res.Free;
  end;

  FSheetStr := TStringStream.Create(''{$IFDEF EH_LIB_13} ,TEncoding.UTF8 {$ENDIF});
  FSheetMergeStr := TStringStream.Create(''{$IFDEF EH_LIB_13} ,TEncoding.UTF8 {$ENDIF});
  ToSheetStrSm(FSheetStr);

  FSheetStr.WriteString('<cols>');
  for i := 0 to FExpCols.Count - 1 do
  begin
    FSheetStr.WriteString('<col ');
    FSheetStr.WriteString('min="'+IntToStr(i + 1)+'"');
    FSheetStr.WriteString(' max="'+IntToStr(i + 1)+'"');
    FSheetStr.WriteString(' width="'+FloatToStr(FExpCols[i].Width / 7)+'"');
    FSheetStr.WriteString(' customWidth="'+IntToStr(1)+'"');
    FSheetStr.WriteString('/>');
  end;
  FSheetStr.WriteString('</cols>');
  FSheetStr.WriteString('<sheetData>');

  SetLength(FFonts, 1);
  FFonts[0] := TFont.Create;
  FFonts[0].Name := 'Calibri';
  FFonts[0].Size := 11;
  SetLength(FBackColor, 2);
  FBackColor[0] := 0;
  FBackColor[1] := 0;
  SetLength(FBorder, 1);
  FBorder[0] := 0;
  SetLength(FStyles, 1);
  FStyles[0].NumFmt := 0;
  FStyles[0].NumFont := 0;
  FStyles[0].NumAlignment := 0;
  FStyles[0].NumBackColor := 0;
  FStyles[0].NumBorder := 0;
  FStyles[0].Vertical := False;
  FStyles[0].Wrap := False;

  ToStyles(FXMLStyles);
  FNumFmt := 164;
  FFmtNode := FXMLStyles.CreateElement('numFmts',
    'http://schemas.openxmlformats.org/spreadsheetml/2006/main');

  FCurRow := 1;
end;

procedure TDBGridEhExportAsXlsx.WriteTitle(ColumnsList: TColumnsEhList);
var
  i, k: Integer;
  t, w: Boolean;
  temp, b: Integer;
  FPTitleExpArr: TTitleExpArr;
  ListOfHeadTreeNodeList: TObjectList;
  ColSpan, RowSpan: Integer;
  Color: TColor;
  Val, rAtr, sAtr: String;
  SRange: String;
  TitleNode: TDBGridMultiTitleNodeEh;
begin
  if ColumnsList.Count = 0 then
    Exit;

  if DBGridEh.IsUseMultiTitle then
  begin
    try
      FSheetMergeCount := 0;
      CreateMultiTitleMatrix(DBGridEh, ColumnsList, FPTitleExpArr, ListOfHeadTreeNodeList);

      for k := ListOfHeadTreeNodeList.Count - 1 downto 0 do
      begin
        FSheetStr.WriteString('<row r="' + IntToStr(FCurRow) +'"');
        FSheetStr.WriteString(' spans="1:' + IntToStr(ColumnsList.Count) +'"');
        FSheetStr.WriteString(' x14ac:dyDescent="0.25">');

        for i := 0 to ColumnsList.Count - 1 do
        begin
          TitleNode := TDBGridMultiTitleNodeEh(TObjectList(ListOfHeadTreeNodeList.Items[k]).Items[i]);

          if (xlsxColoredEh in FOptions) then
          begin
            if (TitleNode <> nil) and (TitleNode.Column = nil) then
              Color := DBGridEh.TitleParams.Color
            else
              Color := ColumnsList[i].Title.Color;
          end else
            Color := TDBGridEh(DBGridEh).Color;

          rAtr := ZEGetA1byCol(i) + IntToStr(FCurRow);
          if TitleNode <> nil then
          begin
            CalcSpan(ColumnsList, ListOfHeadTreeNodeList, k, i,
              ColSpan, RowSpan);

            b := 0;
            if DBGridEh.TitleParams.HorzLines then
              b := b + 1;
            if DBGridEh.TitleParams.VertLines then
              b := b + 2;
            if dghAutoFitRowHeight in ColumnsList[i].Grid.OptionsEh then
              t := True
            else
              t := False;
            if (FCurRow <> FCurRow + RowSpan - 1) or (i <> i + ColSpan - 1) then
            begin
              Inc(FSheetMergeCount);
              SRange :=
                ZEGetA1byCol(i) + IntToStr(FCurRow) + ':' +
                ZEGetA1byCol(i + ColSpan - 1) + IntToStr(FCurRow + RowSpan - 1);
              FSheetMergeStr.WriteString('<mergeCell ref="'+SRange+'"/>');
            end;

            if TitleNode.Column = nil then
            begin
              temp := SetStyle(0, DBGridEh.TitleFont,
                Integer(DBGridEh.ColumnDefValues.Title.Alignment), Color, b, False, t);
            end else if k - RowSpan = -1 then
            begin
              if ColumnsList[i].Title.Orientation = tohVertical then
                w := True
              else
                w := False;
              temp := SetStyle(0, ColumnsList[i].Title.Font,
                Integer(ColumnsList[i].Title.Alignment), Color, b, w, t)
            end
            else
            begin
              temp := SetStyle(0, ColumnsList[i].Title.Font,
                Integer(ColumnsList[i].Title.Alignment), Color, b, False, t);
            end;

            Val := TitleNode.Text;

            if temp > 0
              then sAtr := IntToStr(temp)
              else sAtr := '';
          end
          else
          begin
            Val := '';
            sAtr := '1';
            rAtr := '';
          end;

          FSheetStr.WriteString('<c ');
            if rAtr <> '' then
              FSheetStr.WriteString('r="'+ rAtr +'"');
            if Val <> '' then
              FSheetStr.WriteString(' t="str"');
            if sAtr <> '' then
              FSheetStr.WriteString(' s="'+ sAtr +'"');
            FSheetStr.WriteString('>');
            if Val <> '' then
              FSheetStr.WriteString('<v>'+StrToXMLValue(Val)+'</v>');
          FSheetStr.WriteString('</c>');
        end;

        FSheetStr.WriteString('</row>');
        Inc(FCurRow);
      end;

    finally
      for i := 0 to ListOfHeadTreeNodeList.Count - 1 do
        FreeObjectEh(ListOfHeadTreeNodeList.Items[i]);
      FreeAndNil(ListOfHeadTreeNodeList);
    end;
  end else
  begin
    FSheetStr.WriteString('<row r="' + IntToStr(FCurRow)+'"');
    FSheetStr.WriteString(' spans="1:' + IntToStr(ColumnsList.Count)+'"');
    FSheetStr.WriteString(' x14ac:dyDescent="0.25">');

    for i := 0 to ColumnsList.Count - 1 do
    begin
      if (xlsxColoredEh in FOptions) then
        Color := ColumnsList[i].Title.Color
      else
        Color := TDBGridEh(DBGridEh).Color;

      b := 0;
      if DBGridEh.TitleParams.HorzLines then
        b := b + 1;
      if DBGridEh.TitleParams.VertLines then
        b := b + 2;
      if dghAutoFitRowHeight in ColumnsList[i].Grid.OptionsEh
        then t := True
        else t := False;
      if ColumnsList[i].Title.Orientation = tohVertical
        then w := True
        else w := False;
      temp := SetStyle(0, ColumnsList[i].Title.Font, Integer(ColumnsList[i].Title.Alignment),
                       Color, b, w, t);
      FSheetStr.WriteString('<c ');
        FSheetStr.WriteString('r="'+ZEGetA1byCol(i) + '1"');
        if temp > 0 then
          FSheetStr.WriteString(' s="' + IntToStr(temp) + '"');
        FSheetStr.WriteString(' t="str">');

        FSheetStr.WriteString('<v>'+StrToXMLValue(ColumnsList[i].Title.Caption)+'</v>');
      FSheetStr.WriteString('</c>');
    end;

    FSheetStr.WriteString('</row>');

    Inc(FCurRow);
  end;
end;

procedure TDBGridEhExportAsXlsx.WriteFooter(ColumnsList: TColumnsEhList;
  FooterNo: Integer);
begin
  FCurCol := 1;

  FSheetStr.WriteString('<row r="' + IntToStr(FCurRow)+'"');
  FSheetStr.WriteString(' spans="1:' + IntToStr(ColumnsList.Count)+'"');
  FSheetStr.WriteString(' x14ac:dyDescent="0.25">');

  inherited WriteFooter(ColumnsList, FooterNo);
  FSheetStr.WriteString('</row>');

  Inc(FCurRow);
end;

procedure TDBGridEhExportAsXlsx.WriteFooterCell(DataCol, Row: Integer;
  Column: TColumnEh; AFont: TFont; Background: TColor; Alignment: TAlignment;
  const Text: String);
var
  t: Boolean;
  temp: Integer;
  Footer: TColumnFooterEh;
  Color: TColor;
  Val, rAtr, tAtr: String;
begin
  Footer := Column.ColumnUsedFooter(Row);
  rAtr := '';
  tAtr := '';
  Val := '';

  rAtr := ZEGetA1byCol(FCurCol - 1) + IntToStr(FCurRow);
  if dghAutoFitRowHeight in Column.Grid.OptionsEh
    then t := True
    else t := False;
  if (xlsxColoredEh in FOptions)
    then Color := Footer.Color
    else Color := TDBGridEh(DBGridEh).Color;

  temp := SetStyle(0, AFont, Integer(Alignment), Color, 3, False, t);
  case Footer.ValueType of
    fvtNon:
      Val := '';
    fvtAvg, fvtCount, fvtSum, fvtFieldValue:
      begin
        if not IsNumber(Text) then
          tAtr := 'str';
        Val := Text;
      end;
    fvtStaticText:
      begin
        tAtr := 'str';
        Val := Text;
      end;
  end;

  FSheetStr.WriteString('<c ');
    FSheetStr.WriteString('r="'+ rAtr +'"');
    if tAtr <> '' then
      FSheetStr.WriteString(' t="'+ tAtr +'"');
    if temp > 0 then
      FSheetStr.WriteString(' s="'+ IntToStr(temp) +'"');
    FSheetStr.WriteString('>');

    FSheetStr.WriteString('<v>'+StrToXMLValue(Val)+'</v>');
  FSheetStr.WriteString('</c>');

  Inc(FCurCol);
end;

function TDBGridEhExportAsXlsx.SetStyle(NumFmt: Integer; Font: TFont;
  Alignment: Integer; BackColor: TColor; Border: Integer;
  Vert, Wrap: Boolean): Integer;
var
  i, n, NFont, NBackColor, NBorder: Integer;
begin
  i := 0;
  n := Length(FStyles);
  NFont := SetFont(Font);
  NBackColor := SetBackColor(BackColor);
  NBorder := SetBorder(Border);
  while (i < Length(FStyles)) and
        ( (NumFmt <> FStyles[i].NumFmt) or
          (NFont <> FStyles[i].NumFont) or
          (Alignment <> FStyles[i].NumAlignment) or
          (NBackColor <> FStyles[i].NumBackColor) or
          (NBorder <> FStyles[i].NumBorder) or
          (Vert <> FStyles[i].Vertical) or
          (Wrap <> FStyles[i].Wrap))
  do
    Inc(i);
  if i = n then
  begin
    SetLength(FStyles, n + 1);
    FStyles[n].NumFmt := NumFmt;
    FStyles[n].NumFont := NFont;
    FStyles[n].NumAlignment := Alignment;
    FStyles[n].NumBackColor := NBackColor;
    FStyles[n].NumBorder := NBorder;
    FStyles[n].Vertical := Vert;
    FStyles[n].Wrap := Wrap;
  end;
  Result := i;
end;

function TDBGridEhExportAsXlsx.SetFont(Font: TFont): Integer;
var
  i, n: Integer;
begin
  i := 0;
  n := Length(FFonts);
  while (i < n) and
        ( (Font.Name <> FFonts[i].Name) or
          (GetFontSize(Font) <> GetFontSize(FFonts[i])) or
          (Font.Color <> FFonts[i].Color) or
          (Font.Style <> FFonts[i].Style)
        )
  do
    Inc(i);

  if i = n then
  begin
    SetLength(FFonts, n + 1);
    FFonts[n] := TFont.Create;
    FFonts[n].Name := Font.Name;
    FFonts[n].Size := GetFontSize(Font);
    FFonts[n].Color := Font.Color;
    FFonts[n].Style := Font.Style;
  end;
  Result := i;
end;

function TDBGridEhExportAsXlsx.SetBackColor(Color: TColor): Integer;
var
  i, n: Integer;
begin
  i := 0;
  n := Length(FBackColor);
  while (i < Length(FBackColor)) and (Color <> FBackColor[i]) do
    Inc(i);
  if i = n then
  begin
    SetLength(FBackColor, n + 1);
    FBackColor[n] := Color;
  end;
  Result := i;
end;

function TDBGridEhExportAsXlsx.SetBorder(Border: Integer): Integer;
var
  i, n: Integer;
begin
  i := 0;
  n := Length(FBorder);
  while (i < Length(FBorder)) and (Border <> FBorder[i]) do
    Inc(i);
  if i = n then
  begin
    SetLength(FBorder, n + 1);
    FBorder[n] := Border;
  end;
  Result := i;
end;

type
  TDBGridEhToXlsMemFileExporterDataAsDisplayText = class(TDBGridEhToXlsMemFileExporter)
  protected
    function GetGridCellValue(Column: TColumnEh; AColCellParams: TColCellParamsEh): Variant; override;
  end;

function TDBGridEhToXlsMemFileExporterDataAsDisplayText.GetGridCellValue(
  Column: TColumnEh; AColCellParams: TColCellParamsEh): Variant;
begin
  Result := AColCellParams.Text;
end;

type
  TDBGridEhToXlsMemFileExporterDataAsEditText = class(TDBGridEhToXlsMemFileExporter)
  protected
    function GetGridCellValue(Column: TColumnEh; AColCellParams: TColCellParamsEh): Variant; override;
  end;

function TDBGridEhToXlsMemFileExporterDataAsEditText.GetGridCellValue(
  Column: TColumnEh; AColCellParams: TColCellParamsEh): Variant;
begin
  if (Column.Field <> nil) then
    Result := Column.Field.Text
  else
    Result := inherited GetGridCellValue(Column, AColCellParams);
end;

procedure ExportDBGridEhToXlsx(DBGridEh: TCustomDBGridEh;
  const FileName: String; Options: TDBGridEhExportAsXlsxOptions;
  IsSaveAll: Boolean = True);
var
  ExportOptions: TDBGridEhXlsMemFileExportOptions;
  ExporterClass: TDBGridEhToXlsMemFileExporterClass;
begin
  ExporterClass := nil;
  ExportOptions := TDBGridEhXlsMemFileExportOptions.Create;
  if IsSaveAll
    then ExportOptions.IsExportSelecting := False
    else ExportOptions.IsExportSelecting := True;

  if xlsxColoredEh in Options
    then ExportOptions.IsExportFillColor := True
    else ExportOptions.IsExportFillColor := False;

  if xlsxDataAsDisplayText in Options then
  begin
    ExporterClass := TDBGridEhToXlsMemFileExporterDataAsDisplayText;
    ExportOptions.IsExportDisplayFormat := False;
  end;

  if xlsxDataAsEditText in Options then
  begin
    ExporterClass := TDBGridEhToXlsMemFileExporterDataAsEditText;
    ExportOptions.IsExportDisplayFormat := False;
  end;

  ExportDBGridEhToXlsx(DBGridEh, FileName, ExportOptions, ExporterClass);
  ExportOptions.Free;
end;

procedure ExportDBGridEhToXlsx(DBGridEh: TCustomDBGridEh; const FileName: String;
  ExportOptions: TDBGridEhXlsMemFileExportOptions);
begin
  ExportDBGridEhToXlsx(DBGridEh, FileName, ExportOptions, TDBGridEhToXlsMemFileExporterClass(nil));
end;

procedure ExportDBGridEhToXlsx(DBGridEh: TCustomDBGridEh; const FileName: String;
  ExportOptions: TDBGridEhXlsMemFileExportOptions; ExporterClass: TDBGridEhToXlsMemFileExporterClass);
var
  XlsFile: TXlsMemFileEh;
begin
  XlsFile := TXlsMemFileEh.Create;
  ExportDBGridEhToXlsMemFile(DBGridEh, XlsFile, ExportOptions, ExporterClass);
  XlsFile.SaveToFile(FileName);
  XlsFile.Free;
end;


{$ENDIF} 

procedure CalcMultiTitleMatrix(DBGridEh: TCustomDBGridEh; out TitleMarix: TDBGridMultiTitleExportNodeMatrixEh);
var
  ColumnsList: TColumnsEhList;
  FPTitleExpArr: TTitleExpArr;
  ListOfHeadTreeNodeList: TObjectList;
  k, i: Integer;
  ColSpan, RowSpan: Integer;
begin
  ColumnsList := TColumnsEhList.Create;

  for i := 0 to DBGridEh.VisibleColumns.Count - 1 do
    ColumnsList.Add(DBGridEh.VisibleColumns[i]);

  CreateMultiTitleMatrix(DBGridEh, ColumnsList, FPTitleExpArr, ListOfHeadTreeNodeList);

  SetLength(TitleMarix, ColumnsList.Count);

  for i := 0 to ColumnsList.Count - 1 do
  begin
    SetLength(TitleMarix[i], ListOfHeadTreeNodeList.Count);
  end;

  try
    for k := ListOfHeadTreeNodeList.Count - 1 downto 0 do
    begin
      for i := 0 to ColumnsList.Count - 1 do
      begin
        if TDBGridMultiTitleNodeEh(TObjectList(ListOfHeadTreeNodeList.Items[k]).Items[i]) <> nil then
        begin
          CalcSpan(ColumnsList, ListOfHeadTreeNodeList, k, i, ColSpan, RowSpan);
          if k - RowSpan = -1 then
          begin
             TitleMarix[i, ListOfHeadTreeNodeList.Count - k - 1] := TDBGridMultiTitleExportNodeEh.Create;
             TitleMarix[i, ListOfHeadTreeNodeList.Count - k - 1].Text := TDBGridMultiTitleNodeEh(TObjectList(ListOfHeadTreeNodeList.Items[k]).Items[i]).Text;
             TitleMarix[i, ListOfHeadTreeNodeList.Count - k - 1].MergeColCount := ColSpan - 1;
             TitleMarix[i, ListOfHeadTreeNodeList.Count - k - 1].MergeRowCount := RowSpan - 1;
             TitleMarix[i, ListOfHeadTreeNodeList.Count - k - 1].Column := ColumnsList[i];
          end else
          begin
             TitleMarix[i, ListOfHeadTreeNodeList.Count - k - 1] := TDBGridMultiTitleExportNodeEh.Create;
             TitleMarix[i, ListOfHeadTreeNodeList.Count - k - 1].Text := TDBGridMultiTitleNodeEh(TObjectList(ListOfHeadTreeNodeList.Items[k]).Items[i]).Text;
             TitleMarix[i, ListOfHeadTreeNodeList.Count - k - 1].MergeColCount := ColSpan - 1;
             TitleMarix[i, ListOfHeadTreeNodeList.Count - k - 1].MergeRowCount := RowSpan - 1;
          end;
        end;
      end;
    end;

  finally
    for i := 0 to ListOfHeadTreeNodeList.Count - 1 do
      FreeObjectEh(ListOfHeadTreeNodeList.Items[i]);
    FreeAndNil(ListOfHeadTreeNodeList);
    FreeAndNil(ColumnsList);
  end;
end;

procedure FreeMultiTitleMatrix(TitleMarix: TDBGridMultiTitleExportNodeMatrixEh);
var
  ic, ir: Integer;
begin
  for ic := 0 to Length(TitleMarix) - 1 do
  begin
    for ir := 0 to Length(TitleMarix[ic]) - 1 do
    begin
      if (TitleMarix[ic, ir] <> nil) then
      begin
        TitleMarix[ic, ir].Free;
        TitleMarix[ic, ir] := nil;
      end;
    end;
  end;
end;

procedure SaveDBGridEhToTextFile(DBGridEh: TCustomDBGridEh; const FileName: String;
  ExportOptions: TDBGridEhTextExportOptions);
var
  Exporter: TDBGridEhToTextExporter;
begin
  Exporter := TDBGridEhToTextExporter.Create;

  Exporter.Grid := DBGridEh;
  if ExportOptions <> nil then
    Exporter.ExportOptions := ExportOptions;

  Exporter.ExportToFile(FileName);

  Exporter.Free;
end;

procedure WriteDBGridEhToTextStream(DBGridEh: TCustomDBGridEh; Stream: TStream;
  ExportOptions: TDBGridEhTextExportOptions);
var
  Exporter: TDBGridEhToTextExporter;
begin
  Exporter := TDBGridEhToTextExporter.Create;

  Exporter.Grid := DBGridEh;
  if ExportOptions <> nil then
    Exporter.ExportOptions := ExportOptions;

  Exporter.ExportToStream(Stream);

  Exporter.Free;
end;

function WriteDBGridEhToString(DBGridEh: TCustomDBGridEh;
  ExportOptions: TDBGridEhStringExportOptions): String;
var
  Exporter: TDBGridEhToStringExporter;
begin
  Exporter := TDBGridEhToStringExporter.Create;

  Exporter.Grid := DBGridEh;
  if ExportOptions <> nil then
    Exporter.ExportOptions := ExportOptions;

  Exporter.ExportGrid;
  Result := Exporter.ResultString;

  Exporter.Free;
end;

{ TDBGridEhStringExportOptions }

constructor TDBGridEhStringExportOptions.Create;
begin
{$IFDEF EH_LIB_17} 
  FFormatSettings := SysUtils.FormatSettings;
{$ELSE}
  {$IFDEF FPC}
  FFormatSettings := EhLibLCL.FormatSettings;
  {$ELSE}
  FFormatSettings := EhLibVCL.FormatSettings;
  {$ENDIF}
{$ENDIF}
  FUseFormatSettings := False;
  FLineDelimiter := sLineBreak;
  FTrailingLineDelimiter := True;
  FCellDelimiter := #9; //Tab
  FUseEditFormat := False;
  FQuoteChar := '"';
  FIsExportTitle := True;
  FIsExportFooter := True;
  FIsExportSelecting := False;
  FExportColumns := TColumnsEhList.Create;
end;

destructor TDBGridEhStringExportOptions.Destroy;
begin
  FreeAndNil(FExportColumns);
  inherited Destroy;
end;

procedure TDBGridEhStringExportOptions.Assign(Source: TPersistent);
var
  SrcOp: TDBGridEhStringExportOptions;
begin
  if not (Source is TDBGridEhStringExportOptions) then Exit;

  SrcOp := TDBGridEhStringExportOptions(Source);

  UseFormatSettings := SrcOp.UseFormatSettings;
  LineDelimiter := SrcOp.LineDelimiter;
  CellDelimiter := SrcOp.CellDelimiter;
  UseEditFormat := SrcOp.UseEditFormat;
  QuoteChar := SrcOp.QuoteChar;
  IsExportTitle := SrcOp.IsExportTitle;
  TrailingLineDelimiter := SrcOp.TrailingLineDelimiter;
  FormatSettings := SrcOp.FormatSettings;
  IsExportFooter := SrcOp.IsExportFooter;
  IsExportSelecting := SrcOp.IsExportSelecting;
  ExportColumns := SrcOp.ExportColumns;
end;

procedure TDBGridEhStringExportOptions.SetExportColumns(const Value: TColumnsEhList);
begin
  FExportColumns.Assign(Value);
end;

{ TDBGridEhTextExportOptions }

constructor TDBGridEhTextExportOptions.Create;
begin
  inherited Create;
{$IFDEF EH_LIB_12}
  Encoding := TEncoding.UTF8;
{$ELSE}
  Encoding := TEncoding.ANSI;
{$ENDIF}
  WriteBOM := True;
end;

destructor TDBGridEhTextExportOptions.Destroy;
begin
  inherited Destroy;
end;

procedure TDBGridEhTextExportOptions.Assign(Source: TPersistent);
var
  SrcOp: TDBGridEhTextExportOptions;
begin
  inherited Assign(Source);

  if not (Source is TDBGridEhTextExportOptions) then Exit;

  SrcOp := TDBGridEhTextExportOptions(Source);
  Encoding := SrcOp.Encoding;
  WriteBOM := SrcOp.WriteBOM;
end;

{ TDBGridEhToTextExporter }

constructor TDBGridEhToStringExporter.Create;
begin
  FStringBuilder := TStringBuilder.Create;
  FColCellParamsEh := TColCellParamsEh.Create;
  FExpCols := TColumnsEhList.Create;
  FExportOptions := CreateExportOptions;
end;

destructor TDBGridEhToStringExporter.Destroy;
begin
  FreeAndNil(FExportOptions);
  FreeAndNil(FStringBuilder);
  FreeAndNil(FColCellParamsEh);
  FreeAndNil(FExpCols);
  inherited Destroy;
end;

function TDBGridEhToStringExporter.CreateExportOptions: TDBGridEhStringExportOptions;
begin
  Result := TDBGridEhTextExportOptions.Create;
end;

function TDBGridEhToStringExporter.GetResultString: String;
begin
  Result := FStringBuilder.ToString;
end;

procedure TDBGridEhToStringExporter.ExportGrid;
var
  i: Integer;
  ASelectionType: TDBGridEhSelectionType;
  ds: TDataSet;
  RestoreBookmarkIsNeed: Boolean;
begin
{$IFDEF EH_LIB_12}
  FStringBuilder.Length := 0; 
{$ELSE}
  FStringBuilder.Clear;
{$ENDIF}

  if (ExportOptions.ExportColumns.Count > 0)
    then FExpCols.Assign(ExportOptions.ExportColumns)
    else FExpCols.Clear;

  if ExportOptions.IsExportSelecting
    then ASelectionType := Grid.Selection.SelectionType
    else ASelectionType := gstAll;
  ds := Grid.DataSource.Dataset;

  ds.DisableControls;
  Grid.SaveBookmark;
  RestoreBookmarkIsNeed := True;
  try
    case ASelectionType of
      gstNon:
        begin
          RestoreBookmarkIsNeed := False;
          if not ( (Grid.DataSource <> nil) and (Grid.DataSource.DataSet <> nil) and
                not Grid.DataSource.DataSet.IsEmpty )
          then
            Exit;
          if FExpCols.Count = 0 then
            FExpCols.Add(Grid.Columns[Grid.SelectedIndex]);
          WritePrefix;
          WriteRecord;
        end;
      gstRecordBookmarks:
        begin
          if FExpCols.Count = 0 then
            FExpCols.Assign(Grid.VisibleColumns);
          SetLength(FooterValues, FExpCols.Count * Grid.FooterRowCount);
          WritePrefix;
          if (dgTitles in Grid.Options) and ExportOptions.IsExportTitle then
            WriteTitle;
          for i := 0 to Grid.Selection.Rows.Count - 1 do
          begin
            ds.Bookmark := Grid.Selection.Rows[I];
            CalcFooterValues;
            WriteRecord;
          end;
          WriteFooter;
        end;
      gstRectangle:
        begin
          if FExpCols.Count = 0 then
          begin
            for i := Grid.Selection.Rect.LeftCol to Grid.Selection.Rect.RightCol do
            begin
              if Grid.Columns[i].Visible then
                FExpCols.Add(Grid.Columns[i]);
            end;
          end;
          SetLength(FooterValues, FExpCols.Count * Grid.FooterRowCount);
          WritePrefix;
          if (dgTitles in Grid.Options) and ExportOptions.IsExportTitle then
            WriteTitle;
          ds.Bookmark := Grid.Selection.Rect.TopRow;
          while True do
          begin
            WriteRecord;
            CalcFooterValues;
            if DataSetCompareBookmarks(ds,
                Grid.Selection.Rect.BottomRow, ds.Bookmark) = 0 then Break;
            ds.Next;
            if ds.Eof then Break;
          end;
          WriteFooter;
        end;
      gstColumns:
        begin
          if FExpCols.Count = 0 then
            FExpCols.Assign(Grid.Selection.Columns);
          SetLength(FooterValues, FExpCols.Count * Grid.FooterRowCount);
          WritePrefix;
          if (dgTitles in Grid.Options) and ExportOptions.IsExportTitle then
            WriteTitle;
          ds.First;
          while ds.Eof = False do
          begin
            WriteRecord;
            CalcFooterValues;
            ds.Next;
          end;
          WriteFooter;
        end;
      gstAll:
        begin
          if FExpCols.Count = 0 then
            FExpCols.Assign(Grid.VisibleColumns);
          SetLength(FooterValues, FExpCols.Count * Grid.FooterRowCount);
          WritePrefix;
          if (dgTitles in Grid.Options) and ExportOptions.IsExportTitle then
            WriteTitle;
          ds.First;
          while ds.Eof = False do
          begin
            WriteRecord;
            CalcFooterValues;
            ds.Next;
          end;
          WriteFooter;
        end;
    end;

  finally
    try
      if RestoreBookmarkIsNeed then
        Grid.RestoreBookmark;
    finally
      ds.EnableControls;
    end;
  end;

  if ExportOptions.TrailingLineDelimiter then
    PushLastLineBuffer;
  WriteSuffix;
end;

procedure TDBGridEhToStringExporter.SetExportOptions(const Value: TDBGridEhStringExportOptions);
begin
  FExportOptions.Assign(Value);
end;

procedure TDBGridEhToStringExporter.WriteValue(s: String);
begin
  s := CheckQuoteString(s);
  WriteString(s);
end;

procedure TDBGridEhToStringExporter.WriteString(s: String);
begin
  FStringBuilder.Append(s);
end;

procedure TDBGridEhToStringExporter.PushLastLineBuffer;
begin
  if (FLastLineBuffer <> '') then
  begin
    WriteString(FLastLineBuffer);
    FLastLineBuffer := '';
  end;
end;

function TDBGridEhToStringExporter.CheckQuoteString(s: String): String;
var
  NeedQuotation: Boolean;
begin
  if ExportOptions.QuoteChar = #0 then
  begin
    Result := s;
  end else
  begin
    NeedQuotation := False;
    if AnsiContainsText(s, ExportOptions.QuoteChar) then
      NeedQuotation := True
    else if AnsiContainsText(s, ExportOptions.CellDelimiter) then
      NeedQuotation := True;

    if (NeedQuotation)
      then Result := AnsiQuotedStr(s, ExportOptions.QuoteChar)
      else Result := s;
  end;
end;

procedure TDBGridEhToStringExporter.WritePrefix;
begin

end;

procedure TDBGridEhToStringExporter.WriteTitle;
var
  i: Integer;
  s: String;
begin
  PushLastLineBuffer;
  for i := 0 to FExpCols.Count - 1 do
  begin
    s := FExpCols[i].Title.Caption;
    WriteValue(s);
    if i <> FExpCols.Count - 1 then
      WriteEndOfCell;
  end;
  WriteEndOfLine;
end;

procedure TDBGridEhToStringExporter.WriteRecord;
var
  i: Integer;
  AFont: TFont;
  NewBackground: TColor;
  p: TColCellParamsEh;
  Column: TColumnEh;
begin
  PushLastLineBuffer;

  AFont := TFont.Create;
  try
    for i := 0 to FExpCols.Count - 1 do
    begin
      Column := FExpCols[i];
      AFont.Assign(Column.Font);

      p := FColCellParamsEh;
      p.Row := -1;
      p.Col := -1;
      p.State := [];
      p.Font := AFont;
      p.Background := Column.Color;
      NewBackground := Column.Color;
      p.Alignment := Column.Alignment;
      p.ImageIndex := Column.GetImageIndex;
      p.Text := Column.DisplayText;
      p.CheckboxState := Column.CheckboxState;

      if Assigned(Grid.OnGetCellParams) then
        Grid.OnGetCellParams(Grid, Column, p.Font, NewBackground, p.State);
      p.Background := NewBackground;

      Column.GetColCellParams(False, FColCellParamsEh);

      WriteDataCell(Column, FColCellParamsEh);
      if i <> FExpCols.Count - 1 then
        WriteEndOfCell;
    end;
    WriteEndOfLine;
  finally
    AFont.Free;
  end;
end;

procedure TDBGridEhToStringExporter.WriteDataCell(Column: TColumnEh; FColCellParamsEh: TColCellParamsEh);
var
  s: String;
begin
  if ExportOptions.UseEditFormat
    then s := Column.EditText
    else s := FColCellParamsEh.Text;
  WriteValue(s);
end;

procedure TDBGridEhToStringExporter.WriteEndOfCell;
begin
  if (ExportOptions.CellDelimiter <> '') then
    WriteString(ExportOptions.CellDelimiter);
end;

procedure TDBGridEhToStringExporter.WriteEndOfLine;
begin
  if (ExportOptions.LineDelimiter <> '') then
  begin
    if (ExportOptions.TrailingLineDelimiter)
      then WriteString(ExportOptions.LineDelimiter)
      else FLastLineBuffer := ExportOptions.LineDelimiter;
  end;
end;

function TDBGridEhToStringExporter.GetFooterValue(Row, Col: Integer): String;
var
  FmtStr: string;
  Format: TFloatFormat;
  Digits: Integer;
  FooterValue: Variant;
  Field: TField;
  Footer: TColumnFooterEh;
  inf: TIntegerField;
  bcf: TBCDField;
  fbcf: TFMTBCDField;
  ff: TFloatField;
begin
  Result := '';
  FooterValue := FooterValues[Row * FExpCols.Count + Col];
  if VarIsEmpty(FooterValue) or VarIsNull(FooterValue) then Exit;

  if (ExportOptions.UseEditFormat) then
  begin
    Result := VarToStr(FooterValue);
    Exit;
  end;

  Footer := FExpCols[Col].ColumnUsedFooter(Row);
  case Footer.ValueType of
    fvtSum:
      begin
        if FExpCols[Col].ColumnUsedFooter(Row).FieldName <> '' then
          Field := Grid.DataSource.DataSet.FindField(FExpCols[Col].ColumnUsedFooter(Row).FieldName)
        else
          Field := Grid.DataSource.DataSet.FindField(FExpCols[Col].FieldName);
        if Field = nil then Exit;
        begin
          case Field.DataType of
            ftSmallint, ftInteger, ftAutoInc, ftWord:
              begin
                inf := Field as TIntegerField;
                if Footer.DisplayFormat <> ''
                  then FmtStr := Footer.DisplayFormat
                  else FmtStr := inf.DisplayFormat;
                if FmtStr = ''
                  then Result := IntToStr(Integer(FooterValue))
                  else Result := FormatFloat(FmtStr, FooterValue);
              end;
            ftBCD:
              begin
                bcf := Field as TBCDField;
                if Footer.DisplayFormat <> ''
                  then FmtStr := Footer.DisplayFormat
                  else FmtStr := bcf.DisplayFormat;
                if FmtStr = '' then
                begin
                  if bcf.Currency then
                  begin
                    Format := ffCurrency;
                    Digits := FormatSettings.CurrencyDecimals;
                  end else
                  begin
                    Format := ffGeneral;
                    Digits := 0;
                  end;
                  Result := CurrToStrF(FooterValue, Format, Digits);
                end else
                  Result := FormatCurr(FmtStr, FooterValue);
              end;
            ftFMTBcd:
              begin
                fbcf := Field as TFMTBCDField;
                if Footer.DisplayFormat <> ''
                  then FmtStr := Footer.DisplayFormat
                  else FmtStr := fbcf.DisplayFormat;
                if FmtStr = '' then
                begin
                  if fbcf.Currency then
                  begin
                    Format := ffCurrency;
                    Digits := FormatSettings.CurrencyDecimals;
                  end else
                  begin
                    Format := ffGeneral;
                    Digits := 0;
                  end;
                  Result := CurrToStrF(FooterValue, Format, Digits);
                end else
                  Result := FormatCurr(FmtStr, FooterValue);
              end;
            ftFloat, ftCurrency:
              begin
                ff := Field as TFloatField;
                if Footer.DisplayFormat <> ''
                  then FmtStr := Footer.DisplayFormat
                  else FmtStr := ff.DisplayFormat;
                if FmtStr = '' then
                begin
                  if ff.Currency then
                  begin
                    Format := ffCurrency;
                    Digits := FormatSettings.CurrencyDecimals;
                  end else
                  begin
                    Format := ffGeneral;
                    Digits := 0;
                  end;
                  Result := FloatToStrF(Double(FooterValue), Format, ff.Precision, Digits);
                end else
                  Result := FormatFloat(FmtStr, FooterValue);
              end;
          end;
        end;
      end;
    fvtCount:
      if Footer.DisplayFormat <> ''
        then Result := FormatFloat(Footer.DisplayFormat, FooterValue)
        else Result := FloatToStr(FooterValue);
  end;
end;

procedure TDBGridEhToStringExporter.CalcFooterValues;
var
  i, j: Integer;
  Field: TField;
  Footer: TColumnFooterEh;
begin
  for i := 0 to Grid.FooterRowCount - 1 do
  begin
    for j := 0 to FExpCols.Count - 1 do
    begin
      Footer := FExpCols[j].ColumnUsedFooter(i);
      if Footer.FieldName <> '' then
        Field := Grid.DataSource.DataSet.FindField(Footer.FieldName)
      else
        Field := Grid.DataSource.DataSet.FindField(FExpCols[j].FieldName);
      if Field = nil then Continue;
      case Footer.ValueType of
        fvtSum:
          if (Field.IsNull = False) then
            FooterValues[i * FExpCols.Count + j] := FooterValues[i * FExpCols.Count + j] + Field.AsFloat;
        fvtCount:
          FooterValues[i * FExpCols.Count + j] := FooterValues[i * FExpCols.Count + j] + 1;
      end;
    end;
  end;
end;

procedure TDBGridEhToStringExporter.WriteFooter;
var
  i: Integer;
begin
  if not ExportOptions.IsExportFooter then Exit;
  for i := 0 to Grid.FooterRowCount - 1 do
    WriteFooterRow(i);
end;

procedure TDBGridEhToStringExporter.WriteFooterRow(FooterNo: Integer);
var
  i: Integer;
  Font: TFont;
  Background: TColor;
  State: TGridDrawState;
  Alignment: TAlignment;
  Value: String;
  Column: TColumnEh;
  Footer: TColumnFooterEh;
begin
  PushLastLineBuffer;

  Font := TFont.Create;
  try
    for i := 0 to FExpCols.Count - 1 do
    begin
      Column := FExpCols[i];
      Footer := Column.ColumnUsedFooter(FooterNo);
      Font.Assign(Footer.Font);
      Background := Footer.Color;
      Alignment := Footer.Alignment;
      if Footer.ValueType in [fvtSum, fvtCount] then
        Value := GetFooterValue(FooterNo, i)
      else
        Value := Grid.GetFooterValue(Footer, Column);
      State := [];
      if Assigned(Grid.OnGetFooterParams) then
        Grid.OnGetFooterParams(Grid, Column.Index, FooterNo,
          Column, Font, Background, Alignment, State, Value);
      WriteFooterCell(Column, Value);
      if i <> FExpCols.Count - 1 then
        WriteEndOfCell;
    end;
    WriteEndOfLine;
  finally
    Font.Free;
  end;
end;

procedure TDBGridEhToStringExporter.WriteFooterCell(Column: TColumnEh; const Text: String);
begin
  WriteValue(Text);
end;

procedure TDBGridEhToStringExporter.WriteSuffix;
begin

end;

{ TDBGridEhToTextExporter }

constructor TDBGridEhToTextExporter.Create;
begin
  inherited Create;
end;

destructor TDBGridEhToTextExporter.Destroy;
begin
  inherited Destroy;
end;

procedure TDBGridEhToTextExporter.ExportToFile(AFileName: String);
var
  FileStream: TFileStream;
begin
  FileStream := TFileStream.Create(AFileName, fmCreate);
  try
    ExportToStream(FileStream);
  finally
    FileStream.Free;
  end;
end;

procedure TDBGridEhToTextExporter.ExportToStream(AStream: TStream);
var
  Buffer, Preamble: TBytes;
begin
  ExportGrid;

  {$IFDEF FPC}
  Buffer := ExportOptions.Encoding.GetBytes(UnicodeString(FStringBuilder.ToString));
  {$ELSE}
  Buffer := ExportOptions.Encoding.GetBytes(FStringBuilder.ToString);
  {$ENDIF}
  if ExportOptions.WriteBOM then
  begin
    Preamble := ExportOptions.Encoding.GetPreamble;
    if Length(Preamble) > 0 then
      AStream.WriteBuffer(Preamble, Length(Preamble));
  end;
  AStream.WriteBuffer(Buffer[0], Length(Buffer));
end;

function TDBGridEhToTextExporter.GetExportOptions: TDBGridEhTextExportOptions;
begin
  Result := TDBGridEhTextExportOptions(inherited ExportOptions);
end;

procedure TDBGridEhToTextExporter.SetExportOptions(
  const Value: TDBGridEhTextExportOptions);
begin
  inherited ExportOptions := Value;
end;

procedure TDBGridEhToTextExporter.WriteSuffix;
begin
  inherited WriteSuffix;
end;

{ Global routines }

procedure InitUnit;
begin
  CF_VCLDBIF := RegisterClipboardFormat('VCLDBIF');
  {$IFDEF FPC_CROSSP}
  {$ELSE}
  CF_CSV := RegisterClipboardFormat('Csv');
  CF_RICH_TEXT_FORMAT := RegisterClipboardFormat('Rich Text Format');
  {$ENDIF}
end;

procedure FinalizeUnit;
begin
end;

initialization
  InitUnit;
finalization
  FinalizeUnit;
end.
