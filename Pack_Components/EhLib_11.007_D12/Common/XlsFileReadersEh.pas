{*******************************************************}
{                                                       }
{                      EhLib v10.2                      }
{                                                       }
{           Classes to work with Xlsx Format            }
{                                                       }
{     Copyright (c) 2020-2022 by Dmitry V. Bolshakov    }
{                                                       }
{*******************************************************}

unit XlsFileReadersEh;

{$I EhLib.Inc}

interface

uses
  SysUtils, Classes, Graphics, Dialogs, GridsEh, Controls, Types,
{$IFDEF EH_LIB_6} Variants, {$ENDIF}
{$IFDEF EH_LIB_16} System.Zip, {$ENDIF}
{$IFNDEF EH_LIB_17} GraphUtil, {$ENDIF}
{$IFDEF FPC}
  LCLIntf, EhLibXmlConsts,
  //XMLRead, DOM,
{$ELSE}
  //xmldom, XMLIntf, msxmldom, XMLDoc,
  EhLibXmlConsts,
{$ENDIF}

//  Neslib.Xml,
  XmlDocsEh,
  Forms,
{$IFDEF EH_LIB_17} System.UITypes, UIConsts, System.Contnrs, {$ENDIF}
{$IFDEF CIL}
  EhLibVCLNET,
  System.Runtime.InteropServices, System.Reflection,
{$ELSE}
  {$IFDEF FPC}
    EhLibLCL, LCLType,
  {$ELSE}
    EhLibVCL, Messages, SqlTimSt, Windows,
  {$ENDIF}
{$ENDIF}
  Printers, ZipFileProviderEh, XlsMemFilesEh,
  ComCtrls;

type
  IXMLNode = XmlDocsEh.TSimpleXmlNodeEh;

  TXlsReaderSheetsEh = class;
  TXlsFileReaderEh = class;
  TXlsReaderSheetDataEh = class;
  TXlsReaderSheetEh = class;
  TXlsReaderSheetRowEh = class;
  TXlsReaderStyleSheetEh = class;
  TXlsReaderStyleFont = class;
  TXlsReaderShareStringEh = class;

  TXlsReaderShareStringTypeEh = (shstSimpleStringEh, shstRichStringEh);

{ TXlsReaderClrSchemeItemEh }

  TXlsReaderClrSchemeItemEh = class(TCollectionItem)
  private
    FColor: TColor;
    FItemName: String;

  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    property ItemName: String read FItemName;
    property Color: TColor read FColor;

  end;

{ TXlsReaderClrSchemeEh }

  TXlsReaderClrSchemeEh = class(TCollection)
  private
    FReader: TXlsFileReaderEh;

    function GetItem(Index: Integer): TXlsReaderClrSchemeItemEh;

  public
    constructor Create(AReader: TXlsFileReaderEh);
    function Add: TXlsReaderClrSchemeItemEh;

    property Item[Index: Integer]: TXlsReaderClrSchemeItemEh read GetItem; default;
  end;

{ TXlsReaderRichStringItemEh }

  TXlsReaderRichStringItemEh = class(TCollectionItem)
  private
    FFontStyle: TXlsReaderStyleFont;
    FValue: String;

  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    property FontStyle: TXlsReaderStyleFont read FFontStyle;
    property Value: String read FValue;

  end;

{ TXlsReaderRichStringEh }

  TXlsReaderRichStringEh = class(TCollection)
  private
    FShareString: TXlsReaderShareStringEh;

    function GetItem(Index: Integer): TXlsReaderRichStringItemEh;

  public
    constructor Create(AShareString: TXlsReaderShareStringEh);
    function Add: TXlsReaderRichStringItemEh;
    function GetTextValue: String;

    property Item[Index: Integer]: TXlsReaderRichStringItemEh read GetItem; default;
  end;

{ TXlsReaderShareStringEh }

  TXlsReaderShareStringEh = class(TCollectionItem)
  private
    FStringType: TXlsReaderShareStringTypeEh;
    FSimpleValue: String;
    FRichValue: TXlsReaderRichStringEh;

  public
    destructor Destroy; override;

    property StringType: TXlsReaderShareStringTypeEh read FStringType;
    property SimpleValue: String read FSimpleValue;
    property RichValue: TXlsReaderRichStringEh read FRichValue;
  end;

{ TXlsReaderShareStringsEh }

  TXlsReaderShareStringsEh = class(TCollection)
  private
    FReader: TXlsFileReaderEh;
    function GetShString(Index: Integer): TXlsReaderShareStringEh;
  public
    constructor Create(AReader: TXlsFileReaderEh);
    function Add: TXlsReaderShareStringEh;

    property ShString[Index: Integer]: TXlsReaderShareStringEh read GetShString; default;
  end;

{ TXlsReaderMergeCellEh }

  TXlsReaderMergeCellEh = class(TCollectionItem)
  private
    FMergeRect: TRect;
  public
    property MergeRect: TRect read FMergeRect;
  end;

{ TXlsReaderMergeCellsEh }

  TXlsReaderMergeCellsEh = class(TCollection)
  private
    FSheet: TXlsReaderSheetEh;
  private
    function GetMergeCell(Index: Integer): TXlsReaderMergeCellEh;
  public
    constructor Create(ASheet: TXlsReaderSheetEh);
    function Add: TXlsReaderMergeCellEh;

    property MergeCell[Index: Integer]: TXlsReaderMergeCellEh read GetMergeCell; default;
  end;

{ TXlsReaderRelStructureItemEh }

  TXlsReaderRelStructureItemEh = class(TCollectionItem)
  private
    FFullTypeName: String;
    FId: String;
    FFileTarget: String;
    FTypeName: String;
  public
    property FileTarget: String read FFileTarget;
    property FullTypeName: String read FFullTypeName;
    property TypeName: String read FTypeName;
    property Id: String read FId;
  end;

{ TXlsReaderRelStructureEh }

  TXlsReaderRelStructureEh = class(TCollection)
  private
    FReader: TXlsFileReaderEh;
    function GetItem(Index: Integer): TXlsReaderRelStructureItemEh;
  public
    constructor Create(AReader: TXlsFileReaderEh);

    function Add: TXlsReaderRelStructureItemEh;
    function GetItemById(ATypeName: String; Id: String): TXlsReaderRelStructureItemEh;

    property Item[Index: Integer]: TXlsReaderRelStructureItemEh read GetItem; default;
  end;

{ TXlsReaderNumFormatEh }

  TXlsReaderNumFormatEh = class(TCollectionItem)
  private
    FNumFormatStr: String;
    FNumFormatId: String;
    FVCLDisplayFormat: String;
    FVarType: TVarType;
    FIsStandardNumFormat: Boolean;
  public
    property NumFormatStr: String read FNumFormatStr;
    property NumFormatId: String read FNumFormatId;
    property VCLDisplayFormat: String read FVCLDisplayFormat;
    property VarType: TVarType read FVarType;
    property IsStandardNumFormat: Boolean read FIsStandardNumFormat;
  end;

{ TXlsReaderNumFormatsEh }

  TXlsReaderNumFormatsEh = class(TCollection)
  private
    FStyleSheet: TXlsReaderStyleSheetEh;
    function GetFormat(Index: Integer): TXlsReaderNumFormatEh;
  public
    constructor Create(AStyleSheet: TXlsReaderStyleSheetEh);
    function Add: TXlsReaderNumFormatEh;
    function FormatById(AFormatId: String): TXlsReaderNumFormatEh;

    property Format[Index: Integer]: TXlsReaderNumFormatEh read GetFormat; default;
  end;

{ TXlsReaderStyleBorderEh }

  TXlsReaderStyleBorderEh = class(TCollectionItem)
  private
    FBottomBorderColor: TColor;
    FBottomBorderStyle: TXlsFileCellLineStyleEh;
    FBottomBorderStyleAssigned: Boolean;
    FDiagonalDownBorderColor: TColor;
    FDiagonalDownBorderStyle: TXlsFileCellLineStyleEh;
    FDiagonalDownBorderStyleAssigned: Boolean;
    FDiagonalUpBorderColor: TColor;
    FDiagonalUpBorderStyle: TXlsFileCellLineStyleEh;
    FDiagonalUpBorderStyleAssigned: Boolean;
    FLeftBorderColor: TColor;
    FLeftBorderStyle: TXlsFileCellLineStyleEh;
    FLeftBorderStyleAssigned: Boolean;
    FRightBorderColor: TColor;
    FRightBorderStyle: TXlsFileCellLineStyleEh;
    FRightBorderStyleAssigned: Boolean;
    FTopBorderColor: TColor;
    FTopBorderStyle: TXlsFileCellLineStyleEh;
    FTopBorderStyleAssigned: Boolean;

    procedure SetBottomBorderStyle(const Value: TXlsFileCellLineStyleEh);
    procedure SetDiagonalDownBorderStyle(const Value: TXlsFileCellLineStyleEh);
    procedure SetDiagonalUpBorderStyle(const Value: TXlsFileCellLineStyleEh);
    procedure SetLeftBorderStyle(const Value: TXlsFileCellLineStyleEh);
    procedure SetRightBorderStyle(const Value: TXlsFileCellLineStyleEh);
    procedure SetTopBorderStyle(const Value: TXlsFileCellLineStyleEh);
  public
    property BottomBorderColor: TColor read FBottomBorderColor;
    property BottomBorderStyle: TXlsFileCellLineStyleEh read FBottomBorderStyle write SetBottomBorderStyle;
    property LeftBorderColor: TColor read FLeftBorderColor;
    property LeftBorderStyle: TXlsFileCellLineStyleEh read FLeftBorderStyle write SetLeftBorderStyle;
    property RightBorderColor: TColor read FRightBorderColor;
    property RightBorderStyle: TXlsFileCellLineStyleEh read FRightBorderStyle write SetRightBorderStyle;
    property TopBorderColor: TColor read FTopBorderColor;
    property TopBorderStyle: TXlsFileCellLineStyleEh read FTopBorderStyle write SetTopBorderStyle;

    property DiagonalDownBorderColor: TColor read FDiagonalDownBorderColor;
    property DiagonalDownBorderStyle: TXlsFileCellLineStyleEh read FDiagonalDownBorderStyle write SetDiagonalDownBorderStyle;
    property DiagonalUpBorderColor: TColor read FDiagonalUpBorderColor;
    property DiagonalUpBorderStyle: TXlsFileCellLineStyleEh read FDiagonalUpBorderStyle write SetDiagonalUpBorderStyle;
  end;

{ TXlsReaderStyleBordersEh }

  TXlsReaderStyleBordersEh = class(TCollection)
  private
    FStyleSheet: TXlsReaderStyleSheetEh;
    function GetBorder(Index: Integer): TXlsReaderStyleBorderEh;
  public
    constructor Create(AStyleSheet: TXlsReaderStyleSheetEh);
    function Add: TXlsReaderStyleBorderEh;

    property Border[Index: Integer]: TXlsReaderStyleBorderEh read GetBorder; default;
  end;

{ TXlsReaderStyleFillEh }

  TXlsReaderStyleFillEh = class(TCollectionItem)
  private
    FForegroundColor: TColor;
    FBackgroundColor: TColor;
    FPatternType: TXlsFileStyleFillPatternTypeEh;
  public
    property ForegroundColor: TColor read FForegroundColor;
    property BackgroundColor: TColor read FBackgroundColor;
    property PatternType: TXlsFileStyleFillPatternTypeEh read FPatternType;
  end;

{ TXlsReaderStyleFillsEh }

  TXlsReaderStyleFillsEh = class(TCollection)
  private
    FStyleSheet: TXlsReaderStyleSheetEh;
    function GetFill(Index: Integer): TXlsReaderStyleFillEh;
  public
    constructor Create(AStyleSheet: TXlsReaderStyleSheetEh);
    function Add: TXlsReaderStyleFillEh;

    property Fill[Index: Integer]: TXlsReaderStyleFillEh read GetFill; default;
  end;

{ TXlsReaderStyleFont }

  TXlsReaderStyleFont = class(TCollectionItem)
  private
    FName: String;
    FScheme: String;
    FColor: TColor;
    FFamily: String;
    FSize: Integer;
    FStyle: TFontStyles;
  public
    property Size: Integer read FSize;
    property Color: TColor read FColor;
    property Name: String read FName;
    property Family: String read FFamily;
    property Scheme: String read FScheme;
    property Style: TFontStyles read FStyle;
  end;

{ TXlsReaderStyleFonts }

  TXlsReaderStyleFonts = class(TCollection)
  private
    FStyleSheet: TXlsReaderStyleSheetEh;
    function GetFont(Index: Integer): TXlsReaderStyleFont;
  public
    constructor Create(AStyleSheet: TXlsReaderStyleSheetEh);
    function Add: TXlsReaderStyleFont;
    function GetMaximumDigitWidth: Integer;

    property Font[Index: Integer]: TXlsReaderStyleFont read GetFont; default;
  end;

{ TXlsReaderCellFormatItemEh }

  TXlsReaderCellFormatItemEh = class(TCollectionItem)
  private
    FBorder: TXlsReaderStyleBorderEh;
    FFill: TXlsReaderStyleFillEh;
    FFont: TXlsReaderStyleFont;
    FFormat: TXlsReaderNumFormatEh;
    FHorizontalAlignment: TXlsFileCellHorzAlign;
    FIndent: Integer;
    FNumFmtId: String;
    FTextRotation: Integer;
    FVerticalAlignment: TXlsFileCellVertAlign;
    FWordWrap: Boolean;
  public
    property Border: TXlsReaderStyleBorderEh read FBorder;
    property Fill: TXlsReaderStyleFillEh read FFill;
    property Font: TXlsReaderStyleFont read FFont;
    property Format: TXlsReaderNumFormatEh read FFormat;
    property HorizontalAlignment: TXlsFileCellHorzAlign read FHorizontalAlignment;
    property Indent: Integer read FIndent;
    property NumFmtId: String read FNumFmtId;
    property TextRotation: Integer read FTextRotation;
    property VerticalAlignment: TXlsFileCellVertAlign read FVerticalAlignment;
    property WordWrap: Boolean read FWordWrap;
  end;

{ TXlsReaderCellFormatsEh }

  TXlsReaderCellFormatsEh = class(TCollection)
  private
    FStyleSheet: TXlsReaderStyleSheetEh;
    function GetFormat(Index: Integer): TXlsReaderCellFormatItemEh;
  public
    constructor Create(AStyleSheet: TXlsReaderStyleSheetEh);
    function Add: TXlsReaderCellFormatItemEh;

    property Format[Index: Integer]: TXlsReaderCellFormatItemEh read GetFormat; default;
  end;

{ TXlsReaderSheetCellReaderEh }

  TXlsReaderSheetCellEh = class(TCollectionItem)
  private
    FFormula: String;
    FSharedString: TXlsReaderShareStringEh;
    FStyle: TXlsReaderCellFormatItemEh;
    FTypeName: String;
    FValue: Variant;
    FVarType: TVarType;
    FXMLCell: IXMLNode;

  public

    property Formula: String read FFormula;
    property SharedString: TXlsReaderShareStringEh read FSharedString;
    property Style: TXlsReaderCellFormatItemEh read FStyle;
    property TypeName: String read FTypeName;
    property Value: Variant read FValue;
    property VarType: TVarType read FVarType;
  end;

{ TXlsReaderSheetCellsEh }

  TXlsReaderSheetCellsEh = class(TCollection)
  private
    FSheetRow: TXlsReaderSheetRowEh;
    function GetCell(Index: Integer): TXlsReaderSheetCellEh;
  public
    constructor Create(ASheetRow: TXlsReaderSheetRowEh);
    function Add: TXlsReaderSheetCellEh;

    property Cell[Index: Integer]: TXlsReaderSheetCellEh read GetCell; default;
  end;

{ TXlsReaderSheetRowEh }

  TXlsReaderSheetRowEh = class(TCollectionItem)
  private
    FCells: TXlsReaderSheetCellsEh;
    FHeight: Double;
    FHeightHasValue: Boolean;
    FXMLRow: IXMLNode;
    FVisible: Boolean;
    FCollapsed: Boolean;
    FOutlineLevel: Integer;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    property Height: Double read FHeight;
    property HeightHasValue: Boolean read FHeightHasValue;
    property Visible: Boolean read FVisible;
    property Cells: TXlsReaderSheetCellsEh read FCells;
    property OutlineLevel: Integer read FOutlineLevel;
    property Collapsed: Boolean read FCollapsed;
  end;

{ TXlsReaderSheetRowsEh }

  TXlsReaderSheetRowsEh = class(TCollection)
    FSheetData: TXlsReaderSheetDataEh;
  private
    function GetRow(Index: Integer): TXlsReaderSheetRowEh;
  public
    constructor Create(ASheetData: TXlsReaderSheetDataEh);
    function Add: TXlsReaderSheetRowEh;

    property Row[Index: Integer]: TXlsReaderSheetRowEh read GetRow; default;
  end;

{ TXlsReaderSheetColumnEh }

  TXlsReaderSheetColumnEh = class(TCollectionItem)
  private
    FCollapsed: Boolean;
    FOutlineLevel: Integer;
    FStyle: TXlsReaderCellFormatItemEh;
    FVisible: Boolean;
    FWidth: Double;
  public
    property Collapsed: Boolean read FCollapsed;
    property OutlineLevel: Integer read FOutlineLevel;
    property Style: TXlsReaderCellFormatItemEh read FStyle;
    property Visible: Boolean read FVisible;
    property Width: Double read FWidth;
  end;

{ TXlsReaderSheetColumnsEh }

  TXlsReaderSheetColumnsEh = class(TCollection)
  private
    FSheetData: TXlsReaderSheetDataEh;
    function GetCol(Index: Integer): TXlsReaderSheetColumnEh;
  public
    constructor Create(ASheetData: TXlsReaderSheetDataEh);
    function Add: TXlsReaderSheetColumnEh;

    property SheetData: TXlsReaderSheetDataEh read FSheetData;
    property Col[Index: Integer]: TXlsReaderSheetColumnEh read GetCol; default;
  end;

{ TXlsReaderSheetDataEh }

  TXlsReaderSheetDataEh = class(TPersistent)
  private
    FRowCount: Integer;
    FRows: TXlsReaderSheetRowsEh;
    FColumns: TXlsReaderSheetColumnsEh;
    FSheet: TXlsReaderSheetEh;
  public
    constructor Create(ASheet: TXlsReaderSheetEh);
    destructor Destroy; override;

    property RowCount: Integer read FRowCount;
    property Columns: TXlsReaderSheetColumnsEh read FColumns;
    property Rows: TXlsReaderSheetRowsEh read FRows;
  end;

{ TXlsxPageMarginsEh }

  TXlsReaderPageMarginsEh = class(TPersistent)
  private
    FRight: Double;
    FBottom: Double;
    FHeader: Double;
    FFooter: Double;
    FTop: Double;
    FLeft: Double;
  public
    property Footer: Double read FFooter;
    property Header: Double read FHeader;
    property Bottom: Double read FBottom;
    property Top: Double read FTop;
    property Right: Double read FRight;
    property Left: Double read FLeft;
  end;

{ TXlsReaderPageSetupEh }

  TXlsReaderPageSetupEh = class(TPersistent)
  private
    FOrientation: TPrinterOrientation;
    FFitToHeight: Integer;
    FFitToWidth: Integer;
    FScale: Integer;
    FFitToPage: Boolean;
    FVerticalCentered: Boolean;
    FHorizontalCentered: Boolean;
    FOddPageHeader: String;
    FOddPageFooter: String;
  public
    property Orientation: TPrinterOrientation read FOrientation write FOrientation;
    property FitToHeight: Integer read FFitToHeight;
    property FitToWidth: Integer read FFitToWidth;
    property Scale: Integer read FScale;
    property FitToPage: Boolean read FFitToPage;
    property HorizontalCentered: Boolean read FHorizontalCentered;
    property VerticalCentered: Boolean read FVerticalCentered;
    property OddPageHeader: String read FOddPageHeader;
    property OddPageFooter: String read FOddPageFooter;
  end;

{ TXlsReaderAutoFilterEh }

  TXlsReaderAutoFilterEh = class(TObject)
  private
    FFromCol: Integer;
    FToCol: Integer;
    FFromRow: Integer;
    FToRow: Integer;
  protected
  public
    function IsEmpty: Boolean;

    property FromCol: Integer read FFromCol write FFromCol;
    property ToCol: Integer read FToCol write FToCol;
    property FromRow: Integer read FFromRow write FFromRow;
    property ToRow: Integer read FToRow write FToRow;
  end;


{ TXlsReaderSheetEh }

  TXlsReaderSheetEh = class(TCollectionItem)
  private
    FAutoFilter: TXlsReaderAutoFilterEh;
    FName: String;
    FXMLWorkbookNode: IXMLNode;
    FXMLSheet: ISimpleXmlDocumentEh;
    FSheetData: TXlsReaderSheetDataEh;
    FDefaultRowHeight: Double;
    FDefaultColWidth: Double;
    FFileName: String;
    FRId: String;
    FDimension: TRect;
    FMergeCells: TXlsReaderMergeCellsEh;
    FPageMargins: TXlsReaderPageMarginsEh;
    FPageSetup: TXlsReaderPageSetupEh;
    FZoomScale: Integer;
    FFrozenColCount: Integer;
    FFrozenRowCount: Integer;
    FTabColor: TColor;
    FSummaryBelow: Boolean;
    FSummaryRight: Boolean;
    FOutlineLevelRow: Integer;
    function GetSheets: TXlsReaderSheetsEh;
    function GetColCount: Integer;
    function GetRowCount: Integer;
  protected
    procedure LoadSheetData;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    property AutoFilter: TXlsReaderAutoFilterEh read FAutoFilter;
    property Sheets: TXlsReaderSheetsEh read GetSheets;
    property Name: String read FName;
    property XMLWorkbookNode: IXMLNode read FXMLWorkbookNode;
    property XMLSheet: ISimpleXmlDocumentEh read FXMLSheet;
    property SheetData: TXlsReaderSheetDataEh read FSheetData;
    property RId:  String read FRId;
    property FileName: String read FFileName;
    property ColCount: Integer read GetColCount;
    property RowCount: Integer read GetRowCount;
    property MergeCells: TXlsReaderMergeCellsEh read FMergeCells;
    property PageMargins: TXlsReaderPageMarginsEh read FPageMargins;
    property PageSetup: TXlsReaderPageSetupEh read FPageSetup;
    property ZoomScale: Integer read FZoomScale;
    property FrozenColCount: Integer read FFrozenColCount;
    property FrozenRowCount: Integer read FFrozenRowCount;
    property DefaultRowHeight: Double read FDefaultRowHeight;
    property DefaultColWidth: Double read FDefaultColWidth;
    property TabColor: TColor read FTabColor;
    property SummaryBelow: Boolean read FSummaryBelow;
    property SummaryRight: Boolean read FSummaryRight;
    property OutlineLevelRow: Integer read FOutlineLevelRow;
  end;

{ TXlsReaderSheetsEh }

  TXlsReaderSheetsEh = class(TCollection)
  private
    FReader: TXlsFileReaderEh;
    function GetSheet(Sheet: Variant): TXlsReaderSheetEh;
  public
    constructor Create(AReader: TXlsFileReaderEh);

    function Add: TXlsReaderSheetEh;

    property Reader: TXlsFileReaderEh read FReader;
    property Sheet[Sheet: Variant]: TXlsReaderSheetEh read GetSheet; default;
  end;

{ TXlsReaderStyleSheetEh }

  TXlsReaderStyleSheetEh = class(TPersistent)
  private
    FFonts: TXlsReaderStyleFonts;
    FBorders: TXlsReaderStyleBordersEh;
    FCellFormats: TXlsReaderCellFormatsEh;
    FFileReader: TXlsFileReaderEh;
    FFills: TXlsReaderStyleFillsEh;
    FNumFormats: TXlsReaderNumFormatsEh;

  public
    constructor Create(FileReader: TXlsFileReaderEh);
    destructor Destroy; override;

    property FileReader: TXlsFileReaderEh read FFileReader;
    property Fonts: TXlsReaderStyleFonts read FFonts;
    property Fills: TXlsReaderStyleFillsEh read FFills;
    property CellFormats: TXlsReaderCellFormatsEh read FCellFormats;
    property NumFormats: TXlsReaderNumFormatsEh read FNumFormats;
  end;

{ TXlsFileReaderEh }

  TXlsFileReaderEh = class(TPersistent)
  private
    FZipFileProvider: TCustomFileZipingProviderEh;
    FFileList: TStringList;
    FXMLWorkbookRels: ISimpleXmlDocumentEh;
    FXMLWorkbook: ISimpleXmlDocumentEh;
    FXMLSharedStrings: ISimpleXmlDocumentEh;
    FXMLStyles: ISimpleXmlDocumentEh;
    FSheets: TXlsReaderSheetsEh;
    FSharedStrings: TXlsReaderShareStringsEh;
    FStyleSheet: TXlsReaderStyleSheetEh;
    FRelStructure: TXlsReaderRelStructureEh;
    FClrScheme: TXlsReaderClrSchemeEh;
    FIndexedColors: array of TColor;

    function GetSheets: TXlsReaderSheetsEh;
    procedure ReadFont(FontNode: IXMLNode; Font: TXlsReaderStyleFont);
  protected
    function FixFormula(FormulaStr: String): String;
  public

    constructor Create;
    destructor Destroy; override;

    function GetColorByColorAttributes(sAuto, sIndexed, sRgb, sTheme, sTint: String): TColor;
    function GetColorSchemeColorByIndex(ColorSchemeIndex: Integer): TColor;
    function GetIndexedColor(ColorIndex: Integer): TColor;

    procedure AssingReaderStyleToRange(ReaderStyle: TXlsReaderCellFormatItemEh; CellRange: IXlsFileCellsRangeEh);
    procedure ClearAll;
    procedure ReadFromFile(AFileName: String); virtual;

    procedure LoadSheetList(XlsMemFile: TXlsMemFileEh);
    procedure LoadSheet(Worksheet: TXlsWorksheetEh; SheetReader: TXlsReaderSheetEh);
    procedure WriteToXlsMemFile(XlsMemFile: TXlsMemFileEh); virtual;

    procedure ReadRelStructure;
    procedure ReadWorkbookInfo;
    procedure ReadSharedStrings;
    procedure ReadStyles;
    procedure ReadTheme;

    property Sheets: TXlsReaderSheetsEh read GetSheets;
  end;

implementation

uses XlsFileWritersEh, StrUtils;

procedure InitUnit;
begin
end;

procedure FinalizeUnit;
begin
end;

//{$IFDEF FPC}
//function CreateXMLDocumentFromStream(Stream: TStream): IXMLDocument;
//var
//  XMLDoc: TXMLDocument;
//begin
//  ReadXMLFile(XMLDoc, Stream);
//  Result := TXMLDocumentEh.Create(XMLDoc);
//end;
//{$ELSE}
function CreateXMLDocumentFromStream(Stream: TStream): ISimpleXmlDocumentEh;
begin
  //Result := NewXMLDocument;
  //Result.LoadFromStream(Stream);
  Result := TSimpleXmlDocumentEh.Create;

  Result.LoadFromStream(Stream);
end;
//{$ENDIF}

function BorderStyleNameToBorderStyle(st: String): TXlsFileCellLineStyleEh;
begin
  if st = '' then
    raise Exception.Create('BorderStyle is not assigned"')
  else if st = 'none' then
    Result := clsNoneEh
  else if st = 'thin' then
    Result := clsThinEh
  else if st = 'medium' then
    Result := clsMediumEh
  else if st = 'dashed' then
    Result := clsDashedEh
  else if st = 'dotted' then
    Result := clsDottedEh
  else if st = 'thick' then
    Result := clsThickEh
  else if st = 'double' then
    Result := clsDoubleEh
  else if st = 'hair' then
    Result := clsHairEh
  else if st = 'mediumDashed' then
    Result := clsMediumDashedEh
  else if st = 'dashDot' then
    Result := clsDashDotEh
  else if st = 'mediumDashDot' then
    Result := clsMediumDashDotEh
  else if st = 'dashDotDot' then
    Result := clsDashDotDotEh
  else if st = 'mediumDashDotDot' then
    Result := clsMediumDashDotDotEh
  else if st = 'slantDashDot' then
    Result := clsSlantDashDotEh
  else
    raise Exception.Create('Unexpected BorderStyle "' + st + '"');
end;

type
  TArgbRecEh = record
    A: Byte;
    R: Byte;
    G: Byte;
    B: Byte;
  end;

const
  ColorIndexes: array[0..65] of TArgbRecEh =
    ( (A:$00; R:$00; G:$00; B:$00),  
      (A:$00; R:$FF; G:$FF; B:$FF),  
      (A:$00; R:$FF; G:$00; B:$00),  
      (A:$00; R:$00; G:$FF; B:$00),  
      (A:$00; R:$00; G:$00; B:$FF),  
      (A:$00; R:$FF; G:$FF; B:$00),  
      (A:$00; R:$FF; G:$00; B:$FF),  
      (A:$00; R:$00; G:$FF; B:$FF),  
      (A:$00; R:$00; G:$00; B:$00),
      (A:$00; R:$FF; G:$FF; B:$FF),
      (A:$00; R:$FF; G:$00; B:$00),
      (A:$00; R:$00; G:$FF; B:$00),
      (A:$00; R:$00; G:$00; B:$FF),
      (A:$00; R:$FF; G:$FF; B:$00),
      (A:$00; R:$FF; G:$00; B:$FF),
      (A:$00; R:$00; G:$FF; B:$FF),
      (A:$00; R:$80; G:$00; B:$00),
      (A:$00; R:$00; G:$80; B:$00),
      (A:$00; R:$00; G:$00; B:$80),
      (A:$00; R:$80; G:$80; B:$00),
      (A:$00; R:$80; G:$00; B:$80), 
      (A:$00; R:$00; G:$80; B:$80),
      (A:$00; R:$C0; G:$C0; B:$C0),
      (A:$00; R:$80; G:$80; B:$80),
      (A:$00; R:$99; G:$99; B:$FF),
      (A:$00; R:$99; G:$33; B:$66),
      (A:$00; R:$FF; G:$FF; B:$CC),
      (A:$00; R:$CC; G:$FF; B:$FF),
      (A:$00; R:$66; G:$00; B:$66),
      (A:$00; R:$FF; G:$80; B:$80),
      (A:$00; R:$00; G:$66; B:$CC),
      (A:$00; R:$CC; G:$CC; B:$FF),
      (A:$00; R:$00; G:$00; B:$80),
      (A:$00; R:$FF; G:$00; B:$FF),
      (A:$00; R:$FF; G:$FF; B:$00),
      (A:$00; R:$00; G:$FF; B:$FF),
      (A:$00; R:$80; G:$00; B:$80),
      (A:$00; R:$80; G:$00; B:$00),
      (A:$00; R:$00; G:$80; B:$80),
      (A:$00; R:$00; G:$00; B:$FF),
      (A:$00; R:$00; G:$CC; B:$FF),
      (A:$00; R:$CC; G:$FF; B:$FF),
      (A:$00; R:$CC; G:$FF; B:$CC),
      (A:$00; R:$FF; G:$FF; B:$99),
      (A:$00; R:$99; G:$CC; B:$FF),
      (A:$00; R:$FF; G:$99; B:$CC),
      (A:$00; R:$CC; G:$99; B:$FF),
      (A:$00; R:$FF; G:$CC; B:$99),
      (A:$00; R:$33; G:$66; B:$FF),
      (A:$00; R:$33; G:$CC; B:$CC),
      (A:$00; R:$99; G:$CC; B:$00),
      (A:$00; R:$FF; G:$CC; B:$00),
      (A:$00; R:$FF; G:$99; B:$00),
      (A:$00; R:$FF; G:$66; B:$00),
      (A:$00; R:$66; G:$66; B:$99),
      (A:$00; R:$96; G:$96; B:$96),
      (A:$00; R:$00; G:$33; B:$66),
      (A:$00; R:$33; G:$99; B:$66),
      (A:$00; R:$00; G:$33; B:$00),
      (A:$00; R:$33; G:$33; B:$00),
      (A:$00; R:$99; G:$33; B:$00),
      (A:$00; R:$99; G:$33; B:$66),
      (A:$00; R:$33; G:$33; B:$99),
      (A:$00; R:$33; G:$33; B:$33),
      (A:$00; R:$33; G:$33; B:$33), 
      (A:$00; R:$33; G:$33; B:$33) 
      );

function GetColorByIndex(ColorIndex: Integer): TColor;
begin
  if ColorIndex < 64 then
    Result := RGB(ColorIndexes[ColorIndex].R,
                  ColorIndexes[ColorIndex].G,
                  ColorIndexes[ColorIndex].B)
  else if ColorIndex = 64 then
    Result := clBlack
  else if ColorIndex = 65 then
    Result := clWhite
  else
    Result := clBlack;
end;

function RGB34HexToColor(RGB4Hex: String): TColor;
var
  StrLen: Integer;
  Buffer: TBytes;
begin
  StrLen := Length(RGB4Hex);
  HexToBinEh(RGB4Hex, Buffer, StrLen);
  if StrLen = 8 then
    Result := RGB(Buffer[1], Buffer[2], Buffer[3])
  else //StrLen = 6
    Result := RGB(Buffer[0], Buffer[1], Buffer[2]);
end;

function PatternTypeNameToPatternType(PatternTypeName: String): TXlsFileStyleFillPatternTypeEh;
begin
  if PatternTypeName = 'none' then
    Result := fptNoneEh
  else if PatternTypeName = 'solid' then
    Result := fptSolidEh
  else if PatternTypeName = 'mediumGray' then
    Result := fptMediumGrayEh
  else if PatternTypeName = 'darkGray' then
    Result := fptDarkGrayEh
  else if PatternTypeName = 'lightGray' then
    Result := fptLightGrayEh
  else if PatternTypeName = 'darkHorizontal' then
    Result := fptDarkHorizontalEh
  else if PatternTypeName = 'darkVertical' then
    Result := fptDarkVerticalEh
  else if PatternTypeName = 'darkDown' then
    Result := fptDarkDownEh
  else if PatternTypeName = 'darkUp' then
    Result := fptDarkUpEh
  else if PatternTypeName = 'darkGrid' then
    Result := fptDarkGridEh
  else if PatternTypeName = 'darkTrellis' then
    Result := fptDarkTrellisEh
  else if PatternTypeName = 'lightHorizontal' then
    Result := fptLightHorizontalEh
  else if PatternTypeName = 'lightVertical' then
    Result := fptLightVerticalEh
  else if PatternTypeName = 'lightDown' then
    Result := fptLightDownEh
  else if PatternTypeName = 'lightUp' then
    Result := fptLightUpEh
  else if PatternTypeName = 'lightGrid' then
    Result := fptLightGridEh
  else if PatternTypeName = 'lightTrellis' then
    Result := fptLightTrellisEh
  else if PatternTypeName = 'gray125' then
    Result := fptGray125Eh
  else if PatternTypeName = 'gray0625' then
    Result := fptGray0625Eh
  else
    Result := fptSolidEh;
end;

function ChangeRelativeColorLuminance(AColor: TColor; Percent: Single): TColor;
{$IFDEF EH_LIB_17}
var
  H, S, L, NL: Single;
begin
  RGBtoHSL(ColorToRGB(AColor), H, S, L);
  if Percent > 0
    then NL := L + (1-L) / 100 * Percent
    else NL := L + L / 100 * Percent;
  Result := MakeColor(HSLtoRGB(H, S, NL), 0);
end;
{$ELSE}
var
  H, S, L, NL: Word;
begin
  ColorRGBToHLS(ColorToRGB(AColor), H, L, S);
  if Percent < 0
    then NL := L - Trunc(Percent / 100 * L)
    else NL := L + Trunc(Percent / 100 * (240 - L));
  Result := ColorHLSToRGB(H, NL, S);
end;
{$ENDIF}

function XMLBooleanTextToBool(BooleanText: String; ValueIfEmpty: Boolean): Boolean;
var
  IntValue: Integer;
begin

  if (BooleanText = '') then
  begin
    Result := ValueIfEmpty;
    Exit;
  end;

  if TryStrToInt(BooleanText, IntValue) then
  begin
    if (IntValue = 1) then
      Result := True
    else if (IntValue = 0) then
      Result := False
    else
      raise Exception.Create('XMLBooleanTextToBool: Can convet "' + BooleanText + '" to boolean.');
  end else
  begin
    if (SameText(BooleanText, 'true')) then
      Result := True
    else if (SameText(BooleanText, 'false')) then
      Result := False
    else
      raise Exception.Create('XMLBooleanTextToBool: Can convet "' + BooleanText + '" to boolean.');
  end;
end;

function XmlVarToBool(VarValue: Variant; ValueIfEmpty: Boolean): Boolean;
begin
  Result := XMLBooleanTextToBool(VarToStrDef(VarValue, ''), ValueIfEmpty);
end;

{ TXlsFileReaderEh }

constructor TXlsFileReaderEh.Create;
begin
  inherited Create;

  FFileList := TStringList.Create;
  FSheets := TXlsReaderSheetsEh.Create(Self);
  FSharedStrings := TXlsReaderShareStringsEh.Create(Self);
  FStyleSheet := TXlsReaderStyleSheetEh.Create(Self);
  FRelStructure := TXlsReaderRelStructureEh.Create(Self);
  FClrScheme := TXlsReaderClrSchemeEh.Create(Self);
end;

destructor TXlsFileReaderEh.Destroy;
begin
  FreeAndNil(FZipFileProvider);
  FreeAndNil(FFileList);
  FreeAndNil(FSheets);
  FreeAndNil(FSharedStrings);
  FreeAndNil(FStyleSheet);
  FreeAndNil(FRelStructure);
  FreeAndNil(FClrScheme);

  inherited Destroy;
end;

function TXlsFileReaderEh.GetColorByColorAttributes(sAuto, sIndexed, sRgb,
  sTheme, sTint: String): TColor;
var
  smIdx: Integer;
  Buffer: TBytes;
  StrLen: Integer;
  LumChange: Single;
begin
  if sIndexed <> '' then
    Result := GetIndexedColor(StrToInt(sIndexed))
  else if sTheme <> '' then
  begin
    smIdx := StrToInt(sTheme);

    if smIdx = 0 then smIdx := 1
    else if smIdx = 1 then smIdx := 0
    else if smIdx = 2 then smIdx := 3
    else if smIdx = 3 then smIdx := 2;

    Result := GetColorSchemeColorByIndex(smIdx);
    if sTint <> '' then
    begin
      LumChange := SysStrToFloat(sTint) * 100;
      Result := ChangeRelativeColorLuminance(Result, LumChange);
    end;
  end else if sRgb <> '' then
  begin
    StrLen := Length(sRgb);
    SetLength(Buffer, StrLen div 2);
    HexToBinEh(sRgb, Buffer, StrLen);
    Result := RGB(Buffer[1], Buffer[2], Buffer[3]);
  end else
    Result := clBlack;
end;

function TXlsFileReaderEh.GetColorSchemeColorByIndex(
  ColorSchemeIndex: Integer): TColor;
begin
  Result := clBlack;
  if ColorSchemeIndex < FClrScheme.Count then
  begin
    Result := FClrScheme.Item[ColorSchemeIndex].Color;
  end else
  begin
    case ColorSchemeIndex of
      0: Result := clBlack; 
      1: Result := clWhite; 
      2: Result := RGB($1F, $49, $7D); 
      3: Result := RGB($EE, $EC, $E1); 
      4: Result := RGB($4F, $81, $BD); 
      5: Result := RGB($C0, $50, $4D); 
      6: Result := RGB($9B, $BB, $59); 
      7: Result := RGB($80, $64, $A2); 
      8: Result := RGB($4B, $AC, $C6); 
      9: Result := RGB($F7, $96, $46); 
      10: Result := RGB($00, $00, $FF); 
      11: Result := RGB($80, $00, $80); 
    end;
  end;
end;

function TXlsFileReaderEh.GetIndexedColor(ColorIndex: Integer): TColor;
begin
  if ColorIndex < 64 then
    Result := FIndexedColors[ColorIndex]
  else if ColorIndex = 64 then
    Result := clWindowText
  else if ColorIndex = 65 then
    Result := clWindow
  else
    Result := clBlack;
end;

function TXlsFileReaderEh.GetSheets: TXlsReaderSheetsEh;
begin
  Result := FSheets;
end;

procedure TXlsFileReaderEh.ClearAll;
begin
  FFileList.Clear;
  SetLength(FIndexedColors, 0);
  FXMLWorkbook := nil;
end;

procedure TXlsFileReaderEh.ReadFromFile(AFileName: String);
var
  i: Integer;
  S: String;
begin
  ClearAll;
  if ZipFileProviderClass = nil then
    raise Exception.Create('ZipFileProviderClass is not assigned');
  FZipFileProvider := ZipFileProviderClass.CreateInstance;

  try
    FZipFileProvider.ReadFile(AFileName);
    for I := 0 to FZipFileProvider.FileCount - 1 do
    begin
      S := FZipFileProvider.FileName[I];
      FFileList.Add(S);
    end;

    ReadRelStructure;
    ReadTheme;
    ReadStyles;
    ReadSharedStrings;
    ReadWorkbookInfo;

  finally
    FZipFileProvider.FinalizeZipFile;
    FreeAndNil(FZipFileProvider);
  end;
end;

procedure TXlsFileReaderEh.ReadRelStructure;

  function GetTypeName(FullTypeName: String): String;
  var
    i: Integer;
  begin
    Result := FullTypeName;

    for i := Length(FullTypeName) downto 1 do
    begin
      if FullTypeName[i] = '/' then
      begin
        Result := Copy(FullTypeName, i+1, Length(FullTypeName));
        Break;
      end;
    end;
  end;

  procedure ReadRel(RelNode: IXMLNode);
  var
    Rel: TXlsReaderRelStructureItemEh;
  begin
    Rel := FRelStructure.Add;

    Rel.FFileTarget := RelNode.Attributes['Target'];
    Rel.FFullTypeName := RelNode.Attributes['Type'];
    Rel.FTypeName := GetTypeName(Rel.FFullTypeName);
    Rel.FId := RelNode.Attributes['Id'];
  end;

  procedure ReadRelationships(RelsNode: IXMLNode);
  var
    s: String;
    i: Integer;
    Node: IXMLNode;
  begin
    for i := 0 to RelsNode.ChildNodes.Count - 1 do
    begin
      Node := RelsNode.ChildNodes[i];
      s := Node.NodeName;
      if s = 'Relationship' then
        ReadRel(Node);
    end;
  end;

var
  Stream: TStream;
  s: String;
  i: Integer;
  Node: IXMLNode;
begin
  FZipFileProvider.Read('xl/_rels/workbook.xml.rels', Stream);
  FXMLWorkbookRels := CreateXMLDocumentFromStream(Stream);

  for i := 0 to FXMLWorkbookRels.ChildNodes.Count - 1 do
  begin
    Node := FXMLWorkbookRels.ChildNodes[i];
    s := Node.NodeName;
    if s = 'Relationships' then
    begin
      ReadRelationships(Node);
      Break;
    end;
  end;
  Stream.Free;
end;

procedure TXlsFileReaderEh.ReadWorkbookInfo;

  procedure ReadSheets(SheetsNode: IXMLNode);
  var
    s: String;
    i: Integer;
    Node: IXMLNode;
    Sheet: TXlsReaderSheetEh;
  begin
    for i := 0 to SheetsNode.ChildNodes.Count - 1 do
    begin
      Node := SheetsNode.ChildNodes[i];
      s := Node.Attributes['name'];
      Sheet := Sheets.Add;
      Sheet.FXMLWorkbookNode := Node;
      Sheet.FName := s;
      Sheet.FRId := Node.Attributes['r:id'];
      Sheet.FFileName := FRelStructure.GetItemById('worksheet', Sheet.FRId).FileTarget;
      Sheet.LoadSheetData;
    end;
  end;

  procedure ReadWorkBook(WorkBookNode: IXMLNode);
  var
    s: String;
    i: Integer;
    Node: IXMLNode;
  begin
    for i := 0 to WorkBookNode.ChildNodes.Count - 1 do
    begin
      Node := WorkBookNode.ChildNodes[i];
      s := Node.NodeName;
      if s = 'sheets' then
      begin
        ReadSheets(Node);
        Break;
      end;
    end;
  end;

var
  Stream: TStream;
  s: String;
  i: Integer;
  Node: IXMLNode;
begin
  FZipFileProvider.Read('xl/workbook.xml', Stream);
  FXMLWorkbook := CreateXMLDocumentFromStream(Stream);

  for i := 0 to FXMLWorkbook.ChildNodes.Count - 1 do
  begin
    Node := FXMLWorkbook.ChildNodes[i];
    s := Node.NodeName;
    if s = 'workbook' then
    begin
      ReadWorkBook(Node);
      Break;
    end;
  end;
  Stream.Free;
end;

procedure TXlsFileReaderEh.ReadSharedStrings;

  procedure ReadRichStrItem(StrNode: IXMLNode; rsi: TXlsReaderRichStringItemEh);
  var
    s: String;
    i: Integer;
    Node: IXMLNode;
  begin
    for i := 0 to StrNode.ChildNodes.Count - 1 do
    begin
      Node := StrNode.ChildNodes[i];
      s := Node.NodeName;
      if s = 'rPr' then
      begin
        rsi.FFontStyle := TXlsReaderStyleFont.Create(nil);
        ReadFont(Node, rsi.FFontStyle);
      end else if s = 't' then
      begin
        rsi.FValue := VarToStr(Node.NodeValue);
      end;
    end;
  end;

  procedure ReadStr(StrNode: IXMLNode; shs: TXlsReaderShareStringEh);
  var
    s: String;
    i: Integer;
    Node: IXMLNode;
    rsi: TXlsReaderRichStringItemEh;
  begin
    for i := 0 to StrNode.ChildNodes.Count - 1 do
    begin
      Node := StrNode.ChildNodes[i];
      s := Node.NodeName;
      if s = 't' then
      begin
        shs.FStringType := shstSimpleStringEh;
        shs.FSimpleValue := VarToStr(Node.NodeValue);
        Break;
      end else if s = 'r' then
      begin
        if shs.FRichValue = nil then
        begin
          shs.FStringType := shstRichStringEh;
          shs.FRichValue := TXlsReaderRichStringEh.Create(shs);
        end;
        rsi := shs.FRichValue.Add;
        ReadRichStrItem(Node, rsi);
      end;
    end;
  end;

  procedure ReadStrings(StringsNode: IXMLNode);
  var
    s: String;
    i: Integer;
    Node: IXMLNode;
    shs: TXlsReaderShareStringEh;
  begin
    for i := 0 to StringsNode.ChildNodes.Count - 1 do
    begin
      Node := StringsNode.ChildNodes[i];
      s := Node.NodeName;
      if s = 'si' then
      begin
        shs := FSharedStrings.Add;
        ReadStr(Node, shs);
      end;
    end;
  end;

var
  Stream: TStream;
  s: String;
  i: Integer;
  Node: IXMLNode;
begin
  if FZipFileProvider.IndexOf('xl/sharedStrings.xml') < 0 then
    Exit;
  FZipFileProvider.Read('xl/sharedStrings.xml', Stream);
  FXMLSharedStrings := CreateXMLDocumentFromStream(Stream);

  for i := 0 to FXMLSharedStrings.ChildNodes.Count - 1 do
  begin
    Node := FXMLSharedStrings.ChildNodes[i];
    s := Node.NodeName;
    if s = 'sst' then
    begin
      ReadStrings(Node);
      Break;
    end;
  end;
  Stream.Free;
end;

procedure TXlsFileReaderEh.ReadFont(FontNode: IXMLNode; Font: TXlsReaderStyleFont);
var
  s: String;
  i: Integer;
  Node: IXMLNode;
  sAuto, sIndexed, sRgb, sTheme, sTint: String;
begin

  for i := 0 to FontNode.ChildNodes.Count - 1 do
  begin
    Node := FontNode.ChildNodes[i];
    s := Node.NodeName;
    if s = 'sz' then
    begin
      Font.FSize := Round(SysStrToFloat(Node.Attributes['val']));
    end else if s = 'color' then
    begin
      sAuto := VarToStr(Node.Attributes['auto']);
      sIndexed := VarToStr(Node.Attributes['indexed']);
      sRgb := VarToStr(Node.Attributes['rgb']);
      sTheme := VarToStr(Node.Attributes['theme']);
      sTint := VarToStr(Node.Attributes['tint']);
      Font.FColor := GetColorByColorAttributes(sAuto, sIndexed, sRgb, sTheme, sTint);
    end else if (s = 'name') or ( s = 'rFont') then
    begin
      Font.FName := Node.Attributes['val'];
    end else if s = 'family' then
    begin
      Font.FFamily := Node.Attributes['val'];
    end else if s = 'scheme' then
    begin
      Font.FScheme := Node.Attributes['val'];
    end else if s = 'b' then
    begin
      Font.FStyle := Font.FStyle + [fsBold];
    end else if s = 'i' then
    begin
      Font.FStyle := Font.FStyle + [fsItalic];
    end else if s = 'u' then
    begin
      Font.FStyle := Font.FStyle + [fsUnderline];
    end
  end;
end;

procedure TXlsFileReaderEh.ReadStyles;

  function VCLNumFormatToDataType(VCLNumFormat: String): TVarType;
  begin
    if (Pos('d', VCLNumFormat) > 0) or
       (Pos('m', VCLNumFormat) > 0) or
       (Pos('y', VCLNumFormat) > 0) or
       (Pos('h', VCLNumFormat) > 0) or
       (Pos('n', VCLNumFormat) > 0) or
       (Pos('s', VCLNumFormat) > 0)
    then
      Result := varDate
    else
      Result := varDouble;
  end;

  function AddStandardNumFormat(NumFormatId: String): TXlsReaderNumFormatEh;
  begin
    Result := FStyleSheet.NumFormats.FormatById(NumFormatId);
    if Result = nil then
    begin
      Result := FStyleSheet.NumFormats.Add;

      Result.FNumFormatStr := '';
      Result.FNumFormatId := NumFormatId;
      Result.FVCLDisplayFormat := XlsxNumFormatToVCLFormat(Result.NumFormatId, Result.FNumFormatStr);
      Result.FVarType := VCLNumFormatToDataType(Result.FVCLDisplayFormat);
      Result.FIsStandardNumFormat := True;
    end;
  end;

  procedure ReadNumFormat(NumFmtNode: IXMLNode);
  var
    NumFmt: TXlsReaderNumFormatEh;
    istr: String;
  begin
    istr := NumFmtNode.Attributes['numFmtId'];
    NumFmt := FStyleSheet.NumFormats.FormatById(istr);
    if NumFmt = nil then
      NumFmt := FStyleSheet.NumFormats.Add;

    NumFmt.FNumFormatStr := NumFmtNode.Attributes['formatCode'];
    NumFmt.FNumFormatId := istr;
    NumFmt.FVCLDisplayFormat := XlsxNumFormatToVCLFormat(NumFmt.NumFormatId, NumFmt.FNumFormatStr);
    NumFmt.FVarType := VCLNumFormatToDataType(NumFmt.FVCLDisplayFormat);
    NumFmt.FIsStandardNumFormat := False;
  end;

  procedure ReadNumFormats(NumFormatsNode: IXMLNode);
  var
    s: String;
    i: Integer;
    Node: IXMLNode;
  begin
    for i := 0 to NumFormatsNode.ChildNodes.Count - 1 do
    begin
      Node := NumFormatsNode.ChildNodes[i];
      s := Node.NodeName;
      if s = 'numFmt' then
        ReadNumFormat(Node);
    end;
  end;

  procedure ReadFill(FillNode: IXMLNode);
  var
    s, pt: String;
    i, pti: Integer;
    Node, ColorNode: IXMLNode;
    Fill: TXlsReaderStyleFillEh;
    sAuto, sIndexed, sRgb, sTheme, sTint: String;
  begin
    Fill := FStyleSheet.FFills.Add;
    for i := 0 to FillNode.ChildNodes.Count - 1 do
    begin
      Node := FillNode.ChildNodes[i];
      s := Node.NodeName;
      if s = 'patternFill' then
      begin
        pt := Node.Attributes['patternType'];
        Fill.FPatternType := PatternTypeNameToPatternType(pt);
        Fill.FForegroundColor := clNone;
        Fill.FBackgroundColor := clNone;

        for pti := 0 to Node.ChildNodes.Count - 1 do
        begin
          ColorNode := Node.ChildNodes[pti];
          if ColorNode.NodeName = 'fgColor' then
          begin
            sAuto := VarToStr(ColorNode.Attributes['auto']);
            sIndexed := VarToStr(ColorNode.Attributes['indexed']);
            sRgb := VarToStr(ColorNode.Attributes['rgb']);
            sTheme := VarToStr(ColorNode.Attributes['theme']);
            sTint := VarToStr(ColorNode.Attributes['tint']);
            Fill.FForegroundColor := GetColorByColorAttributes(sAuto, sIndexed, sRgb, sTheme, sTint);
          end else if ColorNode.NodeName = 'bgColor' then
          begin
            sAuto := VarToStr(ColorNode.Attributes['auto']);
            sIndexed := VarToStr(ColorNode.Attributes['indexed']);
            sRgb := VarToStr(ColorNode.Attributes['rgb']);
            sTheme := VarToStr(ColorNode.Attributes['theme']);
            sTint := VarToStr(ColorNode.Attributes['tint']);
            Fill.FBackgroundColor := GetColorByColorAttributes(sAuto, sIndexed, sRgb, sTheme, sTint);
          end;
        end;
      end;
    end;
  end;

  procedure ReadFills(FillsNode: IXMLNode);
  var
    s: String;
    i: Integer;
    Node: IXMLNode;
  begin
    for i := 0 to FillsNode.ChildNodes.Count - 1 do
    begin
      Node := FillsNode.ChildNodes[i];
      s := Node.NodeName;
      if s = 'fill' then
        ReadFill(Node);
    end;
  end;

  function GetLineColor(BorderSubNode: IXMLNode): TColor;
  var
    s: String;
    sAuto, sIndexed, sRgb, sTheme, sTint: String;
    i: Integer;
    Node: IXMLNode;
  begin
    Result := clNone;
    for i := 0 to BorderSubNode.ChildNodes.Count - 1 do
    begin
      Node := BorderSubNode.ChildNodes[i];
      s := Node.NodeName;
      if s = 'color' then
      begin
        sAuto := VarToStr(Node.Attributes['auto']);
        sIndexed := VarToStr(Node.Attributes['indexed']);
        sRgb := VarToStr(Node.Attributes['rgb']);
        sTheme := VarToStr(Node.Attributes['theme']);
        sTint := VarToStr(Node.Attributes['tint']);
        Result := GetColorByColorAttributes(sAuto, sIndexed, sRgb, sTheme, sTint);
      end;
    end;
  end;

  procedure ReadBorder(BorderNode: IXMLNode);
  var
    s, st: String;
    i: Integer;
    Node: IXMLNode;
    Border: TXlsReaderStyleBorderEh;
    UseDiagonalUp: Boolean;
    UseDiagonalDown: Boolean;
    BorderStyle: TXlsFileCellLineStyleEh;
    BorderColor: TColor;
    v: Variant;
  begin
    Border := FStyleSheet.FBorders.Add;
    for i := 0 to BorderNode.ChildNodes.Count - 1 do
    begin
      Node := BorderNode.ChildNodes[i];
      s := Node.NodeName;
      if s = 'left' then
      begin
        st := VarToStr(Node.Attributes['style']);
        if st <> '' then
          Border.LeftBorderStyle := BorderStyleNameToBorderStyle(st);
        Border.FLeftBorderColor := GetLineColor(Node);
      end else if s = 'right' then
      begin
        st := VarToStr(Node.Attributes['style']);
        if st <> '' then
          Border.RightBorderStyle := BorderStyleNameToBorderStyle(st);
        Border.FRightBorderColor := GetLineColor(Node);
      end else if s = 'top' then
      begin
        st := VarToStr(Node.Attributes['style']);
        if st <> '' then
          Border.TopBorderStyle := BorderStyleNameToBorderStyle(st);
        Border.FTopBorderColor := GetLineColor(Node);
      end else if s = 'bottom' then
      begin
        st := VarToStr(Node.Attributes['style']);
        if st <> '' then
          Border.BottomBorderStyle := BorderStyleNameToBorderStyle(st);
        Border.FBottomBorderColor := GetLineColor(Node);
      end else if s = 'diagonal' then
      begin
        v := BorderNode.Attributes['diagonalUp'];
        UseDiagonalUp := XmlVarToBool(v, false);

        v := BorderNode.Attributes['diagonalDown'];
        UseDiagonalDown := XmlVarToBool(v, false);

        st := VarToStr(Node.Attributes['style']);
        if st <> '' then
        begin
          BorderStyle := BorderStyleNameToBorderStyle(st);
          BorderColor := GetLineColor(Node);

          if (UseDiagonalUp) then
          begin
            Border.DiagonalUpBorderStyle := BorderStyle;
            Border.FDiagonalUpBorderColor := BorderColor;
          end;

          if (UseDiagonalDown) then
          begin
            Border.DiagonalDownBorderStyle := BorderStyle;
            Border.FDiagonalDownBorderColor := BorderColor;
          end;
        end;
      end;
    end;
  end;

  procedure ReadBorders(BordersNode: IXMLNode);
  var
    s: String;
    i: Integer;
    Node: IXMLNode;
  begin
    for i := 0 to BordersNode.ChildNodes.Count - 1 do
    begin
      Node := BordersNode.ChildNodes[i];
      s := Node.NodeName;
      if s = 'border' then
        ReadBorder(Node);
    end;
  end;

  procedure ReadCellFormat(CellFormatNode: IXMLNode);
  var
    CellFormat: TXlsReaderCellFormatItemEh;
    v: Variant;
    i: Integer;
    Node: IXMLNode;
    s: String;
  begin
    CellFormat := FStyleSheet.FCellFormats.Add;

    v := CellFormatNode.Attributes['numFmtId'];
    if not VarIsNull(v) then
    begin
      CellFormat.FFormat := FStyleSheet.NumFormats.FormatById(v);
      if CellFormat.FFormat = nil then
      begin
        CellFormat.FFormat := AddStandardNumFormat(VarToStr(v));
      end;
    end;

    v := CellFormatNode.Attributes['fontId'];
    if not VarIsNull(v) then
      CellFormat.FFont := FStyleSheet.FFonts[v]
    else
      CellFormat.FFont := FStyleSheet.FFonts[0];

    v := CellFormatNode.Attributes['borderId'];
    if not VarIsNull(v) then
      CellFormat.FBorder := FStyleSheet.FBorders[v]
    else
      CellFormat.FBorder := FStyleSheet.FBorders[0];

    v := CellFormatNode.Attributes['fillId'];
    if not VarIsNull(v) then
      CellFormat.FFill := FStyleSheet.FFills[v]
    else
      CellFormat.FFill := FStyleSheet.FFills[0];

    CellFormat.FVerticalAlignment := cvaBottomEh;
    CellFormat.FHorizontalAlignment := chaUnassignedEh;
    for i := 0 to CellFormatNode.ChildNodes.Count - 1 do
    begin
      Node := CellFormatNode.ChildNodes[i];
      s := Node.NodeName;
      if s = 'alignment' then
      begin
        v := Node.Attributes['vertical'];
        if not VarIsNull(v) then
        begin
          if v = 'center' then
            CellFormat.FVerticalAlignment := cvaCenterEh
          else if v = 'bottom' then
            CellFormat.FVerticalAlignment := cvaBottomEh
          else if v = 'top' then
            CellFormat.FVerticalAlignment := cvaTopEh
          else
            CellFormat.FVerticalAlignment := cvaBottomEh;
        end else
          CellFormat.FVerticalAlignment := cvaBottomEh;

        v := Node.Attributes['horizontal'];
        if not VarIsNull(v) then
        begin
          if v = 'center' then
            CellFormat.FHorizontalAlignment := chaCenterEh
          else if v = 'general' then
            CellFormat.FHorizontalAlignment := chaUnassignedEh
          else if v = 'left' then
            CellFormat.FHorizontalAlignment := chaLeftEh
          else if v = 'right' then
            CellFormat.FHorizontalAlignment := chaRightEh
          else
            CellFormat.FHorizontalAlignment := chaUnassignedEh;
        end else
          CellFormat.FHorizontalAlignment := chaUnassignedEh;

        v := Node.Attributes['indent'];
        if not VarIsNull(v) and (v <> '') then
          CellFormat.FIndent := StrToInt(v);

        v := Node.Attributes['textRotation'];
        if not VarIsNull(v) and (v <> '') then
          CellFormat.FTextRotation := StrToInt(v);

        v := Node.Attributes['wrapText'];
        if not VarIsNull(v) and (v <> '') then
          CellFormat.FWordWrap := True;
      end;
    end;

  end;

  procedure ReadCellFormats(CellFormatsNode: IXMLNode);
  var
    s: String;
    i: Integer;
    Node: IXMLNode;
  begin
    for i := 0 to CellFormatsNode.ChildNodes.Count - 1 do
    begin
      Node := CellFormatsNode.ChildNodes[i];
      s := Node.NodeName;
      if s = 'xf' then
        ReadCellFormat(Node);
    end;
  end;

  procedure ReadFonts(FontsNode: IXMLNode);
  var
    s: String;
    i: Integer;
    Node: IXMLNode;
    Font: TXlsReaderStyleFont;
  begin
    for i := 0 to FontsNode.ChildNodes.Count - 1 do
    begin
      Node := FontsNode.ChildNodes[i];
      s := Node.NodeName;
      if s = 'font' then
      begin
        Font := FStyleSheet.FFonts.Add;
        ReadFont(Node, Font);
      end;
    end;
  end;

  procedure ReadIndexedColor(MastNode: IXMLNode);
  var
    s, RGBs: String;
    i, j: Integer;
    Node1, Node2: IXMLNode;
  begin
    for i := 0 to MastNode.ChildNodes.Count - 1 do
    begin
      Node1 := MastNode.ChildNodes[i];
      s := Node1.NodeName;
      if s = 'indexedColors' then
      begin
        SetLength(FIndexedColors, Node1.ChildNodes.Count);
        for j := 0 to Node1.ChildNodes.Count-1 do
        begin
          Node2 := Node1.ChildNodes[j];
          s := Node2.NodeName;
          if s = 'rgbColor' then
          begin
            RGBs := Node2.Attributes['rgb'];
            if RGBs <> '' then
              FIndexedColors[j] := RGB34HexToColor(RGBs);
          end;
        end;
      end;
    end;
  end;

  procedure SetDefaultIndexedColors;
  var
    i: Integer;
  begin
    SetLength(FIndexedColors, Length(ColorIndexes));
    for i := 0 to Length(ColorIndexes) - 1 do
      FIndexedColors[i] := GetColorByIndex(i);
  end;

  procedure ReadStyleSheet(StyleNode: IXMLNode);
  var
    s: String;
    i: Integer;
    Node: IXMLNode;
  begin
    for i := 0 to StyleNode.ChildNodes.Count - 1 do
    begin
      Node := StyleNode.ChildNodes[i];
      s := Node.NodeName;
      if s = 'colors' then
        ReadIndexedColor(Node);
    end;
    if Length(FIndexedColors) = 0 then
      SetDefaultIndexedColors;

    for i := 0 to StyleNode.ChildNodes.Count - 1 do
    begin
      Node := StyleNode.ChildNodes[i];
      s := Node.NodeName;
      if s = 'numFmts' then
      begin
        ReadNumFormats(Node);
      end else if s = 'fonts' then
      begin
        ReadFonts(Node);
      end else if s = 'fills' then
      begin
        ReadFills(Node);
      end else if s = 'borders' then
      begin
        ReadBorders(Node);
      end else if s = 'cellStyleXfs' then
      begin

      end else if s = 'cellXfs' then
      begin
        ReadCellFormats(Node);
      end else if s = 'cellStyles' then
      begin

      end else if s = 'dxfs' then
      begin

      end else if s = 'tableStyles' then
      begin

      end else if s = 'extLst' then
      begin

      end
    end;
  end;

var
  Stream: TStream;
  s: String;
  i: Integer;
  Node: IXMLNode;
begin
  FZipFileProvider.Read('xl/styles.xml', Stream);
  FXMLStyles := CreateXMLDocumentFromStream(Stream);

  for i := 0 to FXMLStyles.ChildNodes.Count - 1 do
  begin
    Node := FXMLStyles.ChildNodes[i];
    s := Node.NodeName;
    if s = 'styleSheet' then
    begin
      ReadStyleSheet(Node);
      Break;
    end;
  end;
  Stream.Free;
end;

procedure TXlsFileReaderEh.ReadTheme;

  procedure ReadClrSchemeItem(MastNode: IXMLNode);
  var
    s: String;
    i: Integer;
    Node: IXMLNode;
    Item: TXlsReaderClrSchemeItemEh;
    AVal: String;
  begin
    for i := 0 to MastNode.ChildNodes.Count - 1 do
    begin
      Node := MastNode.ChildNodes[i];
      s := Node.NodeName;
      if (s = 'a:sysClr') or (s = 'a:srgbClr') then
      begin
        Item := FClrScheme.Add;
        Item.FItemName := MastNode.NodeName;
        AVal := VarToStr(Node.Attributes['val']);
        if AVal = 'windowText' then
          Item.FColor := clWindowText
        else if AVal = 'window' then
          Item.FColor := clWindow
        else
        begin
          Item.FColor := RGB34HexToColor(AVal);
        end;
      end;
    end;
  end;

  procedure ReadClrScheme(MastNode: IXMLNode);
  var
    i: Integer;
    Node: IXMLNode;
  begin
    for i := 0 to MastNode.ChildNodes.Count - 1 do
    begin
      Node := MastNode.ChildNodes[i];
      ReadClrSchemeItem(Node);
    end;
  end;

  procedure ReadThemeElements(MastNode: IXMLNode);
  var
    s: String;
    i: Integer;
    Node: IXMLNode;
  begin
    for i := 0 to MastNode.ChildNodes.Count - 1 do
    begin
      Node := MastNode.ChildNodes[i];
      s := Node.NodeName;
      if s = 'a:clrScheme' then
      begin
        ReadClrScheme(Node);
        Break;
      end
    end;
  end;

  procedure ReadATheme(MastNode: IXMLNode);
  var
    s: String;
    i: Integer;
    Node: IXMLNode;
  begin
    for i := 0 to MastNode.ChildNodes.Count - 1 do
    begin
      Node := MastNode.ChildNodes[i];
      s := Node.NodeName;
      if s = 'a:themeElements' then
      begin
        ReadThemeElements(Node);
        Break;
      end
    end;
  end;

var
  Stream: TStream;
  s: String;
  i: Integer;
  Node: IXMLNode;
  thname: String;
  RelStructureItem: TXlsReaderRelStructureItemEh;
begin
  RelStructureItem := FRelStructure.GetItemById('theme', '');
  if (RelStructureItem = nil) then Exit;

  thname := RelStructureItem.FileTarget;
  FZipFileProvider.Read('xl/'+thname, Stream);
  FXMLStyles := CreateXMLDocumentFromStream(Stream);

  for i := 0 to FXMLStyles.ChildNodes.Count - 1 do
  begin
    Node := FXMLStyles.ChildNodes[i];
    s := Node.NodeName;
    if s = 'a:theme' then
    begin
      ReadATheme(Node);
      Break;
    end;
  end;
  Stream.Free;
end;

procedure TXlsFileReaderEh.WriteToXlsMemFile(XlsMemFile: TXlsMemFileEh);
var
  i: Integer;
begin
  XlsMemFile.Clear;

  LoadSheetList(XlsMemFile);

  for i := 0 to FSheets.Count - 1 do
    LoadSheet(XlsMemFile.Workbook.Worksheets[i], FSheets[i]);
end;

procedure TXlsFileReaderEh.LoadSheetList(XlsMemFile: TXlsMemFileEh);
var
  i: Integer;
begin
  for i := 0 to FSheets.Count - 1 do
    XlsMemFile.Workbook.AddWorksheet(FSheets[i].Name);
end;

function TXlsFileReaderEh.FixFormula(FormulaStr: String): String;
begin
  if (Pos('''', FormulaStr) <> 0) then
    //Extrmal reference in the formula is not supported
    Result := ''
  else
    Result := FormulaStr;
end;

procedure TXlsFileReaderEh.LoadSheet(Worksheet: TXlsWorksheetEh; SheetReader: TXlsReaderSheetEh);

  procedure ReadRichText(XlsFileCell: TXlsFileCellEh; CellReader: TXlsReaderSheetCellEh);
  begin
    XlsFileCell.Value := CellReader.SharedString.RichValue.GetTextValue;
  end;

  procedure ReadRowGrouping(RowsReader: TXlsReaderSheetRowsEh);
  begin
    if (SheetReader.OutlineLevelRow = 0) then Exit;
  end;

var
  row, col: Integer;
  RowsReader: TXlsReaderSheetRowsEh;
  CellReader: TXlsReaderSheetCellEh;
  Merges: TXlsReaderMergeCellsEh;
  mr: TRect;
  FileCellRange: IXlsFileCellsRangeEh;
  ReaderRow: TXlsReaderSheetRowEh;
  XlsCol: TXlsFileColumnEh;
  ColReader: TXlsReaderSheetColumnEh;
begin
  Worksheet.ZoomScale := SheetReader.ZoomScale;
  Worksheet.DefaultColWidth := SheetReader.DefaultColWidth;
  Worksheet.DefaultRowHeight := SheetReader.DefaultRowHeight;

  if not SheetReader.AutoFilter.IsEmpty then
  begin
    Worksheet.AutoFilterRange.FromCol := SheetReader.AutoFilter.FromCol;
    Worksheet.AutoFilterRange.ToCol := SheetReader.AutoFilter.ToCol;
    Worksheet.AutoFilterRange.FromRow := SheetReader.AutoFilter.FromRow;
    Worksheet.AutoFilterRange.ToRow := SheetReader.AutoFilter.ToRow;
  end;

  for col := 0 to SheetReader.SheetData.Columns.Count - 1 do
  begin
    XlsCol := Worksheet.Columns[col];
    ColReader := SheetReader.SheetData.Columns[col];

    XlsCol.Width := ColReader.Width;
    XlsCol.Visible := ColReader.Visible;
    XlsCol.OutlineLevel := ColReader.OutlineLevel;
    XlsCol.OutlineNodeCollapsed := ColReader.Collapsed;
    if (ColReader.Style <> nil) then
    begin
      FileCellRange := Worksheet.Columns.GetColumnsRange([col]);
      AssingReaderStyleToRange(ColReader.Style, FileCellRange);
      FileCellRange.ApplyChages;
    end;
  end;

  for row := 0 to SheetReader.SheetData.Rows.Count - 1 do
  begin
    ReaderRow := SheetReader.SheetData.Rows[row];
    if (ReaderRow.HeightHasValue) then
      Worksheet.Rows[row].Height := ReaderRow.Height;
    Worksheet.Rows[row].Visible := ReaderRow.Visible;
    Worksheet.Rows[row].OutlineLevel := ReaderRow.OutlineLevel;
    Worksheet.Rows[row].OutlineNodeCollapsed := ReaderRow.Collapsed;
  end;

  Worksheet.OutlineRowsSummaryBelow := SheetReader.SummaryBelow;
  Worksheet.OutlineColsSummaryRight := SheetReader.SummaryRight;

  RowsReader := SheetReader.SheetData.Rows;
  for row := 0 to RowsReader.Count - 1 do
  begin

    for col := 0 to RowsReader[row].Cells.Count - 1 do
    begin
      CellReader := RowsReader[row].Cells[col];
      FileCellRange := Worksheet.GetCellsRange(col, row, col, row);
      if CellReader.Style <> nil then
      begin

        FileCellRange.Font.Size := CellReader.Style.Font.Size;
        FileCellRange.Font.Name := CellReader.Style.Font.Name;
        FileCellRange.Font.Color := CellReader.Style.Font.Color;
        FileCellRange.Font.IsBold := fsBold in CellReader.Style.Font.Style;
        FileCellRange.Font.IsItalic := fsItalic in CellReader.Style.Font.Style;
        FileCellRange.Font.IsUnderline := fsUnderline in CellReader.Style.Font.Style;

        FileCellRange.Fill.Color := CellReader.Style.Fill.ForegroundColor;
        FileCellRange.Fill.PatternColor := CellReader.Style.Fill.BackgroundColor;
        FileCellRange.Fill.PatternType := CellReader.Style.Fill.PatternType;

        FileCellRange.VertAlign := CellReader.Style.VerticalAlignment;
        FileCellRange.HorzAlign := CellReader.Style.HorizontalAlignment;

        if CellReader.Style.Format <> nil then
        begin
          if (CellReader.Style.Format.IsStandardNumFormat) then
          begin
            FileCellRange.NumberFormat := '[' + CellReader.Style.Format.NumFormatId + ']';
          end else
          begin
            FileCellRange.NumberFormat := CellReader.Style.Format.NumFormatStr;
          end;
        end;

        
        if CellReader.Style.Border.FTopBorderStyleAssigned then
        begin
          FileCellRange.Border.Top.Style := CellReader.Style.Border.TopBorderStyle;
          FileCellRange.Border.Top.Color := CellReader.Style.Border.TopBorderColor;
        end;

        
        if CellReader.Style.Border.FBottomBorderStyleAssigned then
        begin
          FileCellRange.Border.Bottom.Style := CellReader.Style.Border.BottomBorderStyle;
          FileCellRange.Border.Bottom.Color := CellReader.Style.Border.BottomBorderColor;
        end;

        
        if CellReader.Style.Border.FLeftBorderStyleAssigned then
        begin
          FileCellRange.Border.Left.Style := CellReader.Style.Border.LeftBorderStyle;
          FileCellRange.Border.Left.Color := CellReader.Style.Border.LeftBorderColor;
        end;

        
        if CellReader.Style.Border.FRightBorderStyleAssigned then
        begin
          FileCellRange.Border.Right.Style := CellReader.Style.Border.RightBorderStyle;
          FileCellRange.Border.Right.Color := CellReader.Style.Border.RightBorderColor;
        end;

        
        if CellReader.Style.Border.FDiagonalDownBorderStyleAssigned then
        begin
          FileCellRange.Border.DiagonalDown.Style := CellReader.Style.Border.DiagonalDownBorderStyle;
          FileCellRange.Border.DiagonalDown.Color := CellReader.Style.Border.DiagonalDownBorderColor;
        end;

        
        if CellReader.Style.Border.FDiagonalUpBorderStyleAssigned then
        begin
          FileCellRange.Border.DiagonalUp.Style := CellReader.Style.Border.DiagonalUpBorderStyle;
          FileCellRange.Border.DiagonalUp.Color := CellReader.Style.Border.DiagonalUpBorderColor;
        end;

        FileCellRange.WrapText := CellReader.Style.WordWrap;
        FileCellRange.Indent := CellReader.Style.Indent;

        if CellReader.Style.TextRotation = 255 then
        begin
          FileCellRange.CharsFlowDirection := chfdVerticalEh;
        end else
        begin
          FileCellRange.Rotation := CellReader.Style.TextRotation;
        end;

        FileCellRange.ApplyChages;
      end else
      begin
        
      end;

      if
{$IFDEF EH_LIB_12}
         (CellReader.VarType = varUString) and
{$ENDIF}
         (CellReader.SharedString <> nil) and
         (CellReader.SharedString.StringType = shstRichStringEh)
      then
      begin
        
        ReadRichText(Worksheet.Cells[col, row], CellReader)
      end
      else if not VarIsNull(CellReader.Value) and
              not VarIsEmpty(CellReader.Value) then
      begin
        Worksheet.Cells[col, row].Value := CellReader.Value;
      end;

      if (CellReader.Formula <> '') then
        Worksheet.Cells[col, row].Formula := FixFormula(CellReader.Formula);
    end;
  end;

  Merges := SheetReader.MergeCells;
  for row := 0 to Merges.Count - 1 do
  begin
    mr := Merges[row].MergeRect;
    Worksheet.MergeCell(mr.Left, mr.Top, mr.Right - mr.Left + 1, mr.Bottom - mr.Top + 1);
  end;

  Worksheet.FrozenColCount := SheetReader.FrozenColCount;
  Worksheet.FrozenRowCount := SheetReader.FrozenRowCount;
  if SheetReader.TabColor <> clNone then
    Worksheet.TabColor := SheetReader.TabColor;

  Worksheet.PrintParams.PageMargins.Left := SheetReader.PageMargins.Left;
  Worksheet.PrintParams.PageMargins.Top := SheetReader.PageMargins.Top;
  Worksheet.PrintParams.PageMargins.Right := SheetReader.PageMargins.Right;
  Worksheet.PrintParams.PageMargins.Bottom := SheetReader.PageMargins.Bottom;
  Worksheet.PrintParams.PageMargins.Header := SheetReader.PageMargins.Header;
  Worksheet.PrintParams.PageMargins.Footer := SheetReader.PageMargins.Footer;

  if SheetReader.PageSetup.Scale <> 0 then
    Worksheet.PrintParams.Scale := SheetReader.PageSetup.Scale;

  Worksheet.PrintParams.FitToPagesWide := SheetReader.PageSetup.FitToWidth;
  Worksheet.PrintParams.FitToPagesTall := SheetReader.PageSetup.FitToHeight;
  if (SheetReader.PageSetup.FitToPage)
    then Worksheet.PrintParams.ScalingMode := fpsmFitToPagesEh
    else Worksheet.PrintParams.ScalingMode := fpsmAdjustToScaleEh;

  Worksheet.PrintParams.Orientation := SheetReader.PageSetup.Orientation;
  Worksheet.PrintParams.VerticalCentered := SheetReader.PageSetup.VerticalCentered;
  Worksheet.PrintParams.HorizontalCentered := SheetReader.PageSetup.HorizontalCentered;
  Worksheet.PrintParams.PageHeader :=  SheetReader.PageSetup.OddPageHeader;
  Worksheet.PrintParams.PageFooter :=  SheetReader.PageSetup.OddPageFooter;
end;

procedure TXlsFileReaderEh.AssingReaderStyleToRange(ReaderStyle: TXlsReaderCellFormatItemEh;
  CellRange: IXlsFileCellsRangeEh);
begin
  CellRange.Font.Size := ReaderStyle.Font.Size;
  CellRange.Font.Name := ReaderStyle.Font.Name;
  CellRange.Font.Color := ReaderStyle.Font.Color;
  CellRange.Font.IsBold := fsBold in ReaderStyle.Font.Style;
  CellRange.Font.IsItalic := fsItalic in ReaderStyle.Font.Style;
  CellRange.Font.IsUnderline := fsUnderline in ReaderStyle.Font.Style;

  CellRange.Fill.Color := ReaderStyle.Fill.ForegroundColor;
  CellRange.Fill.PatternColor := ReaderStyle.Fill.BackgroundColor;
  CellRange.Fill.PatternType := ReaderStyle.Fill.PatternType;

  CellRange.VertAlign := ReaderStyle.VerticalAlignment;
  CellRange.HorzAlign := ReaderStyle.HorizontalAlignment;

  if ReaderStyle.Format <> nil then
  begin
    if (ReaderStyle.Format.IsStandardNumFormat) then
    begin
      CellRange.NumberFormat := '[' + ReaderStyle.Format.NumFormatId + ']';
    end else
    begin
      CellRange.NumberFormat := ReaderStyle.Format.NumFormatStr;
    end;
  end;

  
  if ReaderStyle.Border.FTopBorderStyleAssigned then
  begin
    CellRange.Border.Top.Style := ReaderStyle.Border.TopBorderStyle;
    CellRange.Border.Top.Color := ReaderStyle.Border.TopBorderColor;
  end;

  
  if ReaderStyle.Border.FBottomBorderStyleAssigned then
  begin
    CellRange.Border.Bottom.Style := ReaderStyle.Border.BottomBorderStyle;
    CellRange.Border.Bottom.Color := ReaderStyle.Border.BottomBorderColor;
  end;

  
  if ReaderStyle.Border.FLeftBorderStyleAssigned then
  begin
    CellRange.Border.Left.Style := ReaderStyle.Border.LeftBorderStyle;
    CellRange.Border.Left.Color := ReaderStyle.Border.LeftBorderColor;
  end;

  
  if ReaderStyle.Border.FRightBorderStyleAssigned then
  begin
    CellRange.Border.Right.Style := ReaderStyle.Border.RightBorderStyle;
    CellRange.Border.Right.Color := ReaderStyle.Border.RightBorderColor;
  end;

  
  if ReaderStyle.Border.FDiagonalDownBorderStyleAssigned then
  begin
    CellRange.Border.DiagonalDown.Style := ReaderStyle.Border.DiagonalDownBorderStyle;
    CellRange.Border.DiagonalDown.Color := ReaderStyle.Border.DiagonalDownBorderColor;
  end;

  
  if ReaderStyle.Border.FDiagonalUpBorderStyleAssigned then
  begin
    CellRange.Border.DiagonalUp.Style := ReaderStyle.Border.DiagonalUpBorderStyle;
    CellRange.Border.DiagonalUp.Color := ReaderStyle.Border.DiagonalUpBorderColor;
  end;

  CellRange.WrapText := ReaderStyle.WordWrap;
  CellRange.Indent := ReaderStyle.Indent;

  if ReaderStyle.TextRotation = 255 then
  begin
    CellRange.CharsFlowDirection := chfdVerticalEh;
  end else
  begin
    CellRange.Rotation := ReaderStyle.TextRotation;
  end;
end;

{ TXlsReaderSheetsEh }

function TXlsReaderSheetsEh.Add: TXlsReaderSheetEh;
begin
  Result := TXlsReaderSheetEh(inherited Add);
end;

constructor TXlsReaderSheetsEh.Create(AReader: TXlsFileReaderEh);
begin
  inherited Create(TXlsReaderSheetEh);
  FReader := AReader;
end;

function TXlsReaderSheetsEh.GetSheet(Sheet: Variant): TXlsReaderSheetEh;
begin
  Result := TXlsReaderSheetEh(Items[Sheet]);
end;

{ TXlsReaderSheetEh }

constructor TXlsReaderSheetEh.Create(Collection: TCollection);
begin
  FTabColor := clNone;
  FSheetData := TXlsReaderSheetDataEh.Create(Self);
  FMergeCells := TXlsReaderMergeCellsEh.Create(Self);
  FPageMargins := TXlsReaderPageMarginsEh.Create;
  FPageSetup := TXlsReaderPageSetupEh.Create;
  FAutoFilter := TXlsReaderAutoFilterEh.Create;
  FSummaryBelow := True;
  FSummaryRight := True;
  inherited Create(Collection);
end;

destructor TXlsReaderSheetEh.Destroy;
begin
  FreeAndNil(FAutoFilter);
  FreeAndNil(FSheetData);
  FreeAndNil(FMergeCells);
  FreeAndNil(FPageMargins);
  FreeAndNil(FPageSetup);
  inherited Destroy;
end;

function TXlsReaderSheetEh.GetSheets: TXlsReaderSheetsEh;
begin
  Result := TXlsReaderSheetsEh(Collection);
end;

function TXlsReaderSheetEh.GetColCount: Integer;
begin
  Result := FDimension.Right + 1;
end;

function TXlsReaderSheetEh.GetRowCount: Integer;
begin
  Result := FDimension.Bottom + 1;
end;

procedure TXlsReaderSheetEh.LoadSheetData;

  procedure ReadPrintOptions(PrintOptionsNode: IXMLNode);
  var
    v: Variant;
  begin
    v := PrintOptionsNode.Attributes['horizontalCentered'];
    FPageSetup.FHorizontalCentered := XmlVarToBool(v, false);

    v := PrintOptionsNode.Attributes['verticalCentered'];
    FPageSetup.FVerticalCentered := XmlVarToBool(v, false);
  end;

  procedure ReadPageMargins(MarginsCell: IXMLNode);
  var
    s: String;
  begin
    s := VarToStr(MarginsCell.Attributes['footer']);
    if s <> '' then
      FPageMargins.FFooter := StrToFloat(s);

    s := VarToStr(MarginsCell.Attributes['header']);
    if s <> '' then
      FPageMargins.FHeader := StrToFloat(s);

    s := VarToStr(MarginsCell.Attributes['bottom']);
    if s <> '' then
      FPageMargins.FBottom := StrToFloat(s);

    s := VarToStr(MarginsCell.Attributes['top']);
    if s <> '' then
      FPageMargins.FTop := StrToFloat(s);

    s := VarToStr(MarginsCell.Attributes['right']);
    if s <> '' then
      FPageMargins.FRight := StrToFloat(s);

    s := VarToStr(MarginsCell.Attributes['left']);
    if s <> '' then
      FPageMargins.FLeft := StrToFloat(s);
  end;

  procedure ReadPageSetup(PageSetupCell: IXMLNode);
  var
    s: String;
  begin
    s := VarToStr(PageSetupCell.Attributes['orientation']);
    if s = 'landscape'
      then FPageSetup.Orientation := poLandscape
      else FPageSetup.Orientation := poPortrait;

    s := VarToStr(PageSetupCell.Attributes['fitToHeight']);
    if s <> '' then
      FPageSetup.FFitToHeight := StrToInt(s);

    s := VarToStr(PageSetupCell.Attributes['fitToWidth']);
    if s <> '' then
      FPageSetup.FFitToWidth := StrToInt(s);

    s := VarToStr(PageSetupCell.Attributes['scale']);
    if s <> '' then
      FPageSetup.FScale := StrToInt(s);
  end;

  procedure ReadHeaderFooter(HeaderFooterNode: IXMLNode);
  var
    s: String;
    i: Integer;
    Node: IXMLNode;
  begin
    for i := 0 to HeaderFooterNode.ChildNodes.Count - 1 do
    begin
      Node := HeaderFooterNode.ChildNodes[i];
      s := Node.NodeName;
      if s = 'oddHeader' then
        FPageSetup.FOddPageHeader := VarToStr(Node.NodeValue)
      else if (s = 'oddFooter') then
        FPageSetup.FOddPageFooter := VarToStr(Node.NodeValue);
    end;
  end;

  procedure ReadPageSetUpPr(PageSetUpPrCell: IXMLNode);
  var
    v: String;
  begin
    v := PageSetUpPrCell.Attributes['fitToPage'];
    FPageSetup.FFitToPage := XmlVarToBool(v, false);
  end;

  procedure ReadTabColor(TabColorNode: IXMLNode);
  var
    sAuto, sIndexed, sRgb, sTheme, sTint: String;
  begin
    sAuto := VarToStr(TabColorNode.Attributes['auto']);
    sIndexed := VarToStr(TabColorNode.Attributes['indexed']);
    sRgb := VarToStr(TabColorNode.Attributes['rgb']);
    sTheme := VarToStr(TabColorNode.Attributes['theme']);
    sTint := VarToStr(TabColorNode.Attributes['tint']);
    FTabColor := Sheets.Reader.GetColorByColorAttributes(sAuto, sIndexed, sRgb, sTheme, sTint);
  end;

  procedure ReadOutlinePr(OutlinePrNode: IXMLNode);
  var
    sSummaryBelow: String;
    sSummaryRight: String;
  begin
    sSummaryBelow := VarToStr(OutlinePrNode.Attributes['summaryBelow']);
    if (sSummaryBelow = '0')
      then FSummaryBelow := False
      else FSummaryBelow := True;

    sSummaryRight := VarToStr(OutlinePrNode.Attributes['summaryRight']);
    if (sSummaryRight = '0')
      then FSummaryRight := False
      else FSummaryRight := True;
  end;

  procedure ReadSheetPr(SheetPrCell: IXMLNode);
  var
    s: String;
    i: Integer;
    Node: IXMLNode;
  begin
    for i := 0 to SheetPrCell.ChildNodes.Count - 1 do
    begin
      Node := SheetPrCell.ChildNodes[i];
      s := Node.NodeName;
      if s = 'pageSetUpPr' then
        ReadPageSetUpPr(Node)
      else if (s = 'tabColor') then
        ReadTabColor(Node)
      else if (s = 'outlinePr') then
        ReadOutlinePr(Node);
    end;
  end;

  procedure ReadMergeCell(MergeCell: IXMLNode);
  var
    s: String;
    AMergeCell: TXlsReaderMergeCellEh;
  begin
    AMergeCell := MergeCells.Add;
    s := MergeCell.Attributes['ref'];
    AMergeCell.FMergeRect := ZEA1RectToRect(s);
  end;

  procedure ReadMergeCells(MergeCellsNode: IXMLNode);
  var
    s: String;
    i: Integer;
    Node: IXMLNode;
  begin
    for i := 0 to MergeCellsNode.ChildNodes.Count - 1 do
    begin
      Node := MergeCellsNode.ChildNodes[i];
      s := Node.NodeName;
      if s = 'mergeCell' then
        ReadMergeCell(Node);
    end;
  end;

  procedure ReadDimension(DimensionNode: IXMLNode);
  var
    s: String;
  begin
    s := DimensionNode.Attributes['ref'];
    FDimension := ZEA1RectToRect(s);
  end;

  procedure ReadSheetViews(SheetViews: IXMLNode);

    procedure ReadPaneData(Pane: IXMLNode);
    var
      state: String;
      xSplitStr, ySplitStr: String;
    begin
      state := VarToStr(Pane.Attributes['state']);
      if (state = 'frozen') or (state = 'frozenSplit') then
      begin
        xSplitStr := VarToStr(Pane.Attributes['xSplit']);
        if (xSplitStr <> '') then
          FFrozenColCount := StrToInt(xSplitStr);

        ySplitStr := VarToStr(Pane.Attributes['ySplit']);
        if (ySplitStr <> '') then
          FFrozenRowCount := StrToInt(ySplitStr);
      end;
    end;

  var
    SheetView: IXMLNode;
    s: String;
    i: Integer;
    Node: IXMLNode;
  begin
    if SheetViews.ChildNodes.Count > 0 then
    begin
      SheetView := SheetViews.ChildNodes[0];
      s := VarToStr(SheetView.Attributes['zoomScale']);
      if (s <> '')
        then FZoomScale := Trunc(SysStrToFloat(s))
        else FZoomScale := 100;

      for i := 0 to SheetView.ChildNodes.Count - 1 do
      begin
        Node := SheetView.ChildNodes[i];
        s := Node.NodeName;

        if s = 'pane' then
        begin
          ReadPaneData(Node);
        end;

      end;
    end;
  end;

  procedure ReadAutoFilter(AutoFilterNode: IXMLNode);
  var
    s: String;
    FilterRect: TRect;
  begin
    s := AutoFilterNode.Attributes['ref'];
    if (s <> '') then
    begin
      FilterRect := ZEA1RectToRect(s);
      AutoFilter.FromCol := FilterRect.Left;
      AutoFilter.ToCol := FilterRect.Right;
      AutoFilter.FromRow := FilterRect.Top;
      AutoFilter.ToRow := FilterRect.Bottom;
    end;
  end;

  procedure ReadCell(Row: TXlsReaderSheetRowEh; CellNode: IXMLNode);
  var
    Cell: TXlsReaderSheetCellEh;
    i: Integer;
    Node: IXMLNode;
    s: String;
    stlNo: String;
    v: Variant;
  begin
    Cell := Row.Cells.Add;
    Cell.FXMLCell := CellNode;
    if CellNode <> nil  then
    begin
      Cell.FTypeName := VarToStr(CellNode.Attributes['t']);
      Cell.FVarType := XlsxCellTypeNameToVaType(Cell.FTypeName);
      stlNo := VarToStr(CellNode.Attributes['s']);
      if stlNo = '' then
        Cell.FStyle := Sheets.Reader.FStyleSheet.FCellFormats[0]
      else
        Cell.FStyle := Sheets.Reader.FStyleSheet.FCellFormats[StrToInt(stlNo)];
      for i := 0 to CellNode.ChildNodes.Count - 1 do
      begin
        Node := CellNode.ChildNodes[i];
        s := Node.NodeName;
        if s = 'v' then
        begin
          v := Node.NodeValue;
          if (Cell.FVarType = varDouble) then
          begin
            if (not VarIsNull(v)) and (VarToStr(v) <> '') then
              Cell.FValue := SysStrToFloat(v)
          end else if Cell.FTypeName = 's' then
          begin
            Cell.FSharedString := Sheets.Reader.FSharedStrings[StrToInt(v)];
            Cell.FValue := Sheets.Reader.FSharedStrings[StrToInt(v)].SimpleValue;
          end
          else
          begin
            Cell.FValue := VarToStr(v);
          end;
        end
        else if s = 'f' then
        begin
          v := Node.NodeValue;
          Cell.FFormula := VarToStr(v);
        end;
      end;
      if not VarIsEmpty(Cell.FValue) then
        VarCast(Cell.FValue, Cell.FValue, Cell.FVarType);
    end else
    begin
    end;

    if (Cell.FVarType = varDouble) and
       (Cell.FStyle <> nil) and
       (Cell.FStyle.Format <> nil) and
       (Cell.FStyle.Format.VCLDisplayFormat <> '')
    then
      Cell.FVarType := Cell.FStyle.Format.VarType;
  end;

  procedure FinishCreateRows;
  var
    i, j: Integer;
    Row: TXlsReaderSheetRowEh;
  begin
    if SheetData.Rows.Count < RowCount then
    begin
      for i := SheetData.Rows.Count to RowCount - 1 do
      begin
        Row := SheetData.Rows.Add;
        for j := 0 to ColCount - 1 do
          ReadCell(Row, nil);
      end;
    end;
  end;

  procedure ReadRow(RowNode: IXMLNode);
  var
    v: Variant;
    i: Integer;
    cIdx: Integer;
    Node: IXMLNode;
    Row: TXlsReaderSheetRowEh;
    e: Extended;
    s: String;
    cNum: Integer;
    bv: Boolean;
  begin
    Row := SheetData.Rows.Add;
    Row.FXMLRow := RowNode;
    if RowNode <> nil then
    begin
      v := RowNode.Attributes['ht'];
      if not VarIsNull(v) and (v <> '') then
      begin
        e := SysStrToFloat(VarToStr(v));
        Row.FHeight := e;
        Row.FHeightHasValue := True;
      end;

      v := RowNode.Attributes['hidden'];
      bv := XmlVarToBool(v, false);
      Row.FVisible := not bv;

      v := RowNode.Attributes['outlineLevel'];
      if not VarIsNull(v) and (v <> '') then
        Row.FOutlineLevel := StrToInt(VarToStr(v));

      v := RowNode.Attributes['collapsed'];
      Row.FCollapsed := XmlVarToBool(v, false);
    end;

    cNum := 0;
    if RowNode <> nil then
    begin
      for i := 0 to RowNode.ChildNodes.Count - 1 do
      begin
        Node := RowNode.ChildNodes[i];
        s := Node.NodeName;
        if s = 'c' then
        begin
          cIdx := ZEGetColByA1(Node.Attributes['r']);
          while cNum < cIdx do
          begin
            ReadCell(Row, nil);
            Inc(cNum);
          end;
          ReadCell(Row, Node);
          Inc(cNum);
        end;
      end;
    end;
    for i := Row.Cells.Count to ColCount - 1 do
      ReadCell(Row, nil);
  end;

  procedure ReadCol(ColNode: IXMLNode);
  var
    ws, sts: String;
    i: Integer;
    FromIdx, ToIdx: Integer;
    ACol: TXlsReaderSheetColumnEh;
    e: Extended;
    AStyle: TXlsReaderCellFormatItemEh;
    hiddenStr: String;
    Hidden: Boolean;
    v: Variant;
    OutlineLevel: Integer;
    Collapsed: Boolean;
  begin
    FromIdx := StrToInt(ColNode.Attributes['min']);

    if (FromIdx > 1) and (SheetData.Columns.Count + 1 < FromIdx) then
    begin
      for i := SheetData.Columns.Count + 1 to FromIdx - 1 do
      begin
        ACol := SheetData.Columns.Add;
        ACol.FWidth := -1;
        ACol.FStyle := nil;
        ACol.FVisible := True;
      end;
    end;

    ToIdx := StrToInt(ColNode.Attributes['max']) - FromIdx;

    ws := VarToStr(ColNode.Attributes['width']);
    e := SysStrToFloat(ws);

    hiddenStr := VarToStr(ColNode.Attributes['hidden']);
    Hidden := XmlVarToBool(hiddenStr, false);

    v := ColNode.Attributes['outlineLevel'];
    if not VarIsNull(v) and (v <> '')
      then OutlineLevel := StrToInt(VarToStr(v))
      else OutlineLevel := 0;

    v := ColNode.Attributes['collapsed'];
    Collapsed := XmlVarToBool(v, false);

    sts := VarToStr(ColNode.Attributes['style']);
    if sts <> ''
      then AStyle := Sheets.Reader.FStyleSheet.FCellFormats[StrToInt(sts)]
      else AStyle := nil;

    for i := 0 to ToIdx do
    begin
      ACol := SheetData.Columns.Add;
      ACol.FWidth := e - 0.7109375; 
      ACol.FStyle := AStyle;
      ACol.FVisible := not Hidden;
      ACol.FOutlineLevel := OutlineLevel;
      ACol.FCollapsed := Collapsed;
    end;
  end;

  procedure ReadSheetData(SheetDataNode: IXMLNode);
  var
    s: String;
    i, k, r: Integer;
    Node: IXMLNode;
  begin
    k := 1;
    for i := 0 to SheetDataNode.ChildNodes.Count - 1 do
    begin
      Node := SheetDataNode.ChildNodes[i];
      s := Node.NodeName;
      if s = 'row' then
      begin
        r := StrToInt(Node.Attributes['r']);
        while k < r do
        begin
          ReadRow(nil);
          k := k + 1;
        end;
        ReadRow(Node);
        k := k + 1;
      end;
    end;
    SheetData.FRowCount := SheetData.Rows.Count;
  end;

  procedure FinishCreateColumns;
  var
    i: Integer;
    ACol: TXlsReaderSheetColumnEh;
  begin
    if SheetData.Columns.Count < ColCount then
    begin
      for i := SheetData.Columns.Count to ColCount - 1 do
      begin
        ACol := SheetData.Columns.Add;
        ACol.FWidth := -1;
        ACol.FVisible := True;
      end;
    end;

    for i := 0 to SheetData.Columns.Count - 1 do
    begin
      if (SheetData.Columns[i].Width = -1) then
        SheetData.Columns[i].FWidth := SheetData.FSheet.DefaultColWidth;
    end;

  end;

  procedure ReadCols(ColsNode: IXMLNode);
  var
    s: String;
    i: Integer;
    Node: IXMLNode;
  begin
    for i := 0 to ColsNode.ChildNodes.Count - 1 do
    begin
      Node := ColsNode.ChildNodes[i];
      s := Node.NodeName;
      if s = 'col' then
        ReadCol(Node);
    end;

    FinishCreateColumns;
  end;

  procedure ReadSheetFormatPr(SheetFormatPrNode: IXMLNode);
  var
    v: Variant;
  begin
    v := SheetFormatPrNode.Attributes['defaultRowHeight'];
    if VarIsNull(v) or (v = '') then
      FDefaultRowHeight := 15
    else
      FDefaultRowHeight := SysStrToFloat(VarToStr(v));

    v := SheetFormatPrNode.Attributes['defaultColWidth'];
    if VarIsNull(v) or (v = '') then
      FDefaultColWidth := 8.43
    else
      FDefaultColWidth := SysStrToFloat(VarToStr(v)) - 0.7109375;

    v := SheetFormatPrNode.Attributes['outlineLevelRow'];
    if not VarIsNull(v) and (v <> '') then
      FOutlineLevelRow := StrToInt(VarToStr(v));
  end;

  procedure ReadWorksheet(Worksheet: IXMLNode);
  var
    s: String;
    i: Integer;
    Node: IXMLNode;
  begin
    for i := 0 to Worksheet.ChildNodes.Count - 1 do
    begin
      Node := Worksheet.ChildNodes[i];
      s := Node.NodeName;
      if s = 'sheetData' then
      begin
        FinishCreateColumns;
        ReadSheetData(Node);
      end else if s = 'cols' then
        ReadCols(Node)
      else if s = 'sheetFormatPr' then
        ReadSheetFormatPr(Node)
      else if s = 'dimension' then
        ReadDimension(Node)
      else if s = 'sheetViews' then
        ReadSheetViews(Node)
      else if s = 'mergeCells' then
        ReadMergeCells(Node)
      else if s = 'printOptions' then
        ReadPrintOptions(Node)
      else if s = 'pageMargins' then
        ReadPageMargins(Node)
      else if s = 'pageSetup' then
        ReadPageSetup(Node)
      else if s = 'headerFooter' then
        ReadHeaderFooter(Node)
      else if s = 'pageSetUpPr' then
        ReadPageSetUpPr(Node)
      else if s = 'autoFilter' then
        ReadAutoFilter(Node)
      else if s = 'sheetPr' then
        ReadSheetPr(Node);
    end;
    FinishCreateColumns;
    FinishCreateRows;
  end;

var
  Stream: TStream;
  s: String;
  i: Integer;
  Node: IXMLNode;
  OldDecSep: Char;
begin
  OldDecSep := FormatSettings.DecimalSeparator;
  FormatSettings.DecimalSeparator := '.';
  try

  Sheets.Reader.FZipFileProvider.Read('xl/'+FileName, Stream);
  FXMLSheet := CreateXMLDocumentFromStream(Stream);

  for I := 0 to FXMLSheet.ChildNodes.Count - 1 do
  begin
    Node := FXMLSheet.ChildNodes[i];
    s := Node.NodeName;
    if s = 'worksheet' then
    begin
      ReadWorksheet(Node);
      Break;
    end;
  end;

  finally
    FormatSettings.DecimalSeparator := OldDecSep;
  end;
  Stream.Free;
end;

{ TXlsReaderSheetColumnsEh }

constructor TXlsReaderSheetColumnsEh.Create(ASheetData: TXlsReaderSheetDataEh);
begin
  inherited Create(TXlsReaderSheetColumnEh);
  FSheetData := ASheetData;
end;

function TXlsReaderSheetColumnsEh.Add: TXlsReaderSheetColumnEh;
begin
  Result := TXlsReaderSheetColumnEh(inherited Add);
end;

function TXlsReaderSheetColumnsEh.GetCol(Index: Integer): TXlsReaderSheetColumnEh;
begin
  Result := TXlsReaderSheetColumnEh(Items[Index]);
end;

{ TXlsReaderSheetDataEh }

constructor TXlsReaderSheetDataEh.Create(ASheet: TXlsReaderSheetEh);
begin
  inherited Create;

  FRows := TXlsReaderSheetRowsEh.Create(Self);
  FColumns := TXlsReaderSheetColumnsEh.Create(Self);
  FSheet := ASheet;
end;

destructor TXlsReaderSheetDataEh.Destroy;
begin
  FreeAndNil(FRows);
  FreeAndNil(FColumns);

  inherited Destroy;
end;

{ TXlsReaderAutoFilterEh }

function TXlsReaderAutoFilterEh.IsEmpty: Boolean;
begin
  if (FFromCol = 0) and
     (FToCol = 0) and
     (FFromRow = 0) and
     (FToRow = 0)
  then
    Result := True
  else
    Result := False;
end;

{ TXlsReaderSheetRowsEh }

function TXlsReaderSheetRowsEh.Add: TXlsReaderSheetRowEh;
begin
  Result := TXlsReaderSheetRowEh(inherited Add);
end;

constructor TXlsReaderSheetRowsEh.Create(ASheetData: TXlsReaderSheetDataEh);
begin
  inherited Create(TXlsReaderSheetRowEh);
  FSheetData := ASheetData;
end;

function TXlsReaderSheetRowsEh.GetRow(Index: Integer): TXlsReaderSheetRowEh;
begin
  Result := TXlsReaderSheetRowEh(Items[Index]);
end;

{ TXlsxSheetTXlsReaderSheetCellsEh }

constructor TXlsReaderSheetCellsEh.Create(ASheetRow: TXlsReaderSheetRowEh);
begin
  inherited Create(TXlsReaderSheetCellEh);
  FSheetRow := ASheetRow;
end;

function TXlsReaderSheetCellsEh.Add: TXlsReaderSheetCellEh;
begin
  Result := TXlsReaderSheetCellEh(inherited Add);
end;

function TXlsReaderSheetCellsEh.GetCell(Index: Integer): TXlsReaderSheetCellEh;
begin
  Result := TXlsReaderSheetCellEh(Items[Index]);
end;

{ TXlsReaderSheetRowEh }

constructor TXlsReaderSheetRowEh.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FCells := TXlsReaderSheetCellsEh.Create(Self);
  FHeightHasValue := False;
  FVisible := True;
end;

destructor TXlsReaderSheetRowEh.Destroy;
begin
  FCells.Free;
  inherited Destroy;
end;

{ TXlsReaderStyleSheetEh }

constructor TXlsReaderStyleSheetEh.Create;
begin
  inherited Create;
  FFonts := TXlsReaderStyleFonts.Create(Self);
  FCellFormats := TXlsReaderCellFormatsEh.Create(Self);
  FBorders :=  TXlsReaderStyleBordersEh.Create(Self);
  FFills := TXlsReaderStyleFillsEh.Create(Self);
  FNumFormats := TXlsReaderNumFormatsEh.Create(Self);
end;

destructor TXlsReaderStyleSheetEh.Destroy;
begin
  FreeAndNil(FFonts);
  FreeAndNil(FCellFormats);
  FreeAndNil(FBorders);
  FreeAndNil(FFills);
  FreeAndNil(FNumFormats);
  inherited;
end;

{ TXlsReaderStyleFonts }

constructor TXlsReaderStyleFonts.Create(AStyleSheet: TXlsReaderStyleSheetEh);
begin
  inherited Create(TXlsReaderStyleFont);
  FStyleSheet := AStyleSheet;
end;

function TXlsReaderStyleFonts.Add: TXlsReaderStyleFont;
begin
  Result := TXlsReaderStyleFont(inherited Add);
end;

function TXlsReaderStyleFonts.GetFont(Index: Integer): TXlsReaderStyleFont;
begin
  Result := TXlsReaderStyleFont(Items[Index]);
end;

function TXlsReaderStyleFonts.GetMaximumDigitWidth: Integer;
var
  Canvas: TCanvas;
begin
  Canvas := TCanvas.Create;
  try
    Canvas.Handle := GetDC(0);
    if Count > 0 then
    begin
      Canvas.Font.Name := Font[0].Name;
      Canvas.Font.Size := Font[0].Size;
    end;
    Result := Canvas.TextWidth('0');
    ReleaseDC(0, Canvas.Handle);
    Canvas.Handle := 0;
  finally
    Canvas.Free;
  end;
end;

{ TXlsReaderCellFormatsEh }

constructor TXlsReaderCellFormatsEh.Create(AStyleSheet: TXlsReaderStyleSheetEh);
begin
  inherited Create(TXlsReaderCellFormatItemEh);
  FStyleSheet := AStyleSheet;
end;

function TXlsReaderCellFormatsEh.Add: TXlsReaderCellFormatItemEh;
begin
  Result := TXlsReaderCellFormatItemEh(inherited Add);
end;

function TXlsReaderCellFormatsEh.GetFormat(Index: Integer): TXlsReaderCellFormatItemEh;
begin
  Result := TXlsReaderCellFormatItemEh(Items[Index]);
end;

{ TXlsReaderStyleBordersEh }

constructor TXlsReaderStyleBordersEh.Create(AStyleSheet: TXlsReaderStyleSheetEh);
begin
  inherited Create(TXlsReaderStyleBorderEh);
  FStyleSheet := AStyleSheet;
end;

function TXlsReaderStyleBordersEh.Add: TXlsReaderStyleBorderEh;
begin
  Result := TXlsReaderStyleBorderEh(inherited Add);
  Result.FLeftBorderStyleAssigned := False;
  Result.FRightBorderStyleAssigned := False;
  Result.FTopBorderStyleAssigned := False;
  Result.FBottomBorderStyleAssigned := False;
  Result.FDiagonalDownBorderStyleAssigned := False;
  Result.FDiagonalUpBorderStyleAssigned := False;
end;

function TXlsReaderStyleBordersEh.GetBorder(Index: Integer): TXlsReaderStyleBorderEh;
begin
  Result := TXlsReaderStyleBorderEh(Items[Index]);
end;

{ TXlsReaderRelStructureEh }

constructor TXlsReaderRelStructureEh.Create(AReader: TXlsFileReaderEh);
begin
  inherited Create(TXlsReaderRelStructureItemEh);
  FReader := AReader;
end;

function TXlsReaderRelStructureEh.Add: TXlsReaderRelStructureItemEh;
begin
  Result := TXlsReaderRelStructureItemEh(inherited Add);
end;

function TXlsReaderRelStructureEh.GetItem(Index: Integer): TXlsReaderRelStructureItemEh;
begin
  Result := TXlsReaderRelStructureItemEh(Items[Index]);
end;

function TXlsReaderRelStructureEh.GetItemById(ATypeName, Id: String): TXlsReaderRelStructureItemEh;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if ATypeName <> '' then
    begin
      if Id = '' then
      begin
        if Item[i].TypeName = ATypeName then
        begin
          Result := Item[i];
          Break;
        end;
      end else if (Item[i].TypeName = ATypeName) and (Item[i].Id = Id) then
      begin
        Result := Item[i];
        Break;
      end
    end else
    begin
      if Item[i].Id = Id then
      begin
        Result := Item[i];
        Break;
      end
    end;
end;

{ TXlsReaderMergeCellsEh }

function TXlsReaderMergeCellsEh.Add: TXlsReaderMergeCellEh;
begin
  Result := TXlsReaderMergeCellEh(inherited Add);
end;

constructor TXlsReaderMergeCellsEh.Create(ASheet: TXlsReaderSheetEh);
begin
  inherited Create(TXlsReaderMergeCellEh);
  FSheet := ASheet;
end;

function TXlsReaderMergeCellsEh.GetMergeCell(Index: Integer): TXlsReaderMergeCellEh;
begin
  Result := TXlsReaderMergeCellEh(Items[Index]);
end;

{ TXlsReaderStyleFillsEh }

constructor TXlsReaderStyleFillsEh.Create(AStyleSheet: TXlsReaderStyleSheetEh);
begin
  inherited Create(TXlsReaderStyleFillEh);
  FStyleSheet := AStyleSheet;
end;

function TXlsReaderStyleFillsEh.Add: TXlsReaderStyleFillEh;
begin
  Result := TXlsReaderStyleFillEh(inherited Add);
end;

function TXlsReaderStyleFillsEh.GetFill(Index: Integer): TXlsReaderStyleFillEh;
begin
  Result := TXlsReaderStyleFillEh(Items[Index]);
end;

{ TXlsReaderNumFormatsEh }

constructor TXlsReaderNumFormatsEh.Create(AStyleSheet: TXlsReaderStyleSheetEh);
begin
  inherited Create(TXlsReaderNumFormatEh);
  FStyleSheet := AStyleSheet;
end;

function TXlsReaderNumFormatsEh.FormatById(AFormatId: String): TXlsReaderNumFormatEh;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
  begin
    if Format[i].NumFormatId = AFormatId then
    begin
      Result := Format[i];
      Break;
    end;
  end;
end;

function TXlsReaderNumFormatsEh.Add: TXlsReaderNumFormatEh;
begin
  Result := TXlsReaderNumFormatEh(inherited Add);
end;

function TXlsReaderNumFormatsEh.GetFormat(Index: Integer): TXlsReaderNumFormatEh;
begin
  Result := TXlsReaderNumFormatEh(Items[Index]);
end;

{ TXlsReaderShareStringsEh }

constructor TXlsReaderShareStringsEh.Create(AReader: TXlsFileReaderEh);
begin
  inherited Create(TXlsReaderShareStringEh);
  FReader := AReader;
end;

function TXlsReaderShareStringsEh.Add: TXlsReaderShareStringEh;
begin
  Result := TXlsReaderShareStringEh(inherited Add);
end;

function TXlsReaderShareStringsEh.GetShString(Index: Integer): TXlsReaderShareStringEh;
begin
  Result := TXlsReaderShareStringEh(Items[Index]);
end;

{ TXlsReaderShareStringEh }

destructor TXlsReaderShareStringEh.Destroy;
begin
  FreeAndNil(FRichValue);
  inherited Destroy;
end;

{ TXlsReaderRichStringEh }

constructor TXlsReaderRichStringEh.Create(AShareString: TXlsReaderShareStringEh);
begin
  inherited Create(TXlsReaderRichStringItemEh);
  FShareString := AShareString;
end;

function TXlsReaderRichStringEh.Add: TXlsReaderRichStringItemEh;
begin
  Result := TXlsReaderRichStringItemEh(inherited Add);
end;

function TXlsReaderRichStringEh.GetItem(Index: Integer): TXlsReaderRichStringItemEh;
begin
  Result := TXlsReaderRichStringItemEh(Items[Index]);
end;

function TXlsReaderRichStringEh.GetTextValue: String;
var
  i: Integer;
begin
  Result := '';
  for i := 0 to Count - 1 do
    Result := Result + Item[i].Value;
end;

{ TXlsReaderRichStringItemEh }

constructor TXlsReaderRichStringItemEh.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TXlsReaderRichStringItemEh.Destroy;
begin
  FreeAndNil(FFontStyle);
  inherited Destroy;
end;

{ TXlsReaderClrSchemeItemEh }

constructor TXlsReaderClrSchemeItemEh.Create(Collection: TCollection);
begin
  inherited Create(Collection);
end;

destructor TXlsReaderClrSchemeItemEh.Destroy;
begin
  inherited Destroy;
end;

{ TXlsReaderClrSchemeEh }

constructor TXlsReaderClrSchemeEh.Create(AReader: TXlsFileReaderEh);
begin
  inherited Create(TXlsReaderClrSchemeItemEh);
  FReader := AReader;
end;

function TXlsReaderClrSchemeEh.Add: TXlsReaderClrSchemeItemEh;
begin
  Result := TXlsReaderClrSchemeItemEh(inherited Add);
end;

function TXlsReaderClrSchemeEh.GetItem(Index: Integer): TXlsReaderClrSchemeItemEh;
begin
  Result := TXlsReaderClrSchemeItemEh(inherited Items[Index]);
end;

{ TXlsReaderStyleBorderEh }

procedure TXlsReaderStyleBorderEh.SetBottomBorderStyle(
  const Value: TXlsFileCellLineStyleEh);
begin
  FBottomBorderStyle := Value;
  FBottomBorderStyleAssigned := True;
end;

procedure TXlsReaderStyleBorderEh.SetDiagonalDownBorderStyle(
  const Value: TXlsFileCellLineStyleEh);
begin
  FDiagonalDownBorderStyle := Value;
  FDiagonalDownBorderStyleAssigned := True;
end;

procedure TXlsReaderStyleBorderEh.SetDiagonalUpBorderStyle(
  const Value: TXlsFileCellLineStyleEh);
begin
  FDiagonalUpBorderStyle := Value;
  FDiagonalUpBorderStyleAssigned := True;
end;

procedure TXlsReaderStyleBorderEh.SetLeftBorderStyle(
  const Value: TXlsFileCellLineStyleEh);
begin
  FLeftBorderStyle := Value;
  FLeftBorderStyleAssigned := True;
end;

procedure TXlsReaderStyleBorderEh.SetRightBorderStyle(
  const Value: TXlsFileCellLineStyleEh);
begin
  FRightBorderStyle := Value;
  FRightBorderStyleAssigned := True;
end;

procedure TXlsReaderStyleBorderEh.SetTopBorderStyle(
  const Value: TXlsFileCellLineStyleEh);
begin
  FTopBorderStyle := Value;
  FTopBorderStyleAssigned := True;
end;

initialization
  InitUnit;
finalization
  FinalizeUnit;
end.


