{*******************************************************}
{                                                       }
{                      EhLib 10.2                       }
{                                                       }
{           Classes to work w ith Xlsx Format           }
{                                                       }
{     Copyright (c) 2020-2022 by Dmitry V. Bolshakov    }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit XlsMemFilesEh;

interface

uses
  SysUtils, Variants, Classes, Graphics, Types, Printers,
  {$IFDEF FPC}
    EhLibLCL,
  {$ELSE}
    EhLibVCL, SqlTimSt,
  {$ENDIF}
  Contnrs, Controls, Forms, Dialogs;

type
  TXlsWorkbookEh = class;
  TXlsWorksheetEh = class;
  TXlsFileColumnEh = class;
  TXlsFileColumnsEh = class;
  TXlsFileRowEh = class;
  TXlsFileRowsEh = class;
  TXlsFileCellEh = class;
  TXlsFileWorksheetDimensionEh = class;
  TXlsFileStylesEh = class;
  TXlsFileCellsRangeEh = class;
  TXlsFileCellsRangeLinesEh = class;
  TXlsFileWorksheetCellsRectEh = class;
  TXlsFileWorksheetPrintParamsEh = class;
  TXlsFileWorksheetPrintPageMarginsEh = class;
  TXlsFileCellStyle = class;
  IXlsFileCellsRangeEh = interface;

  TXlsFileCellLineStyleEh = (clsNoneEh, clsThinEh, clsMediumEh, clsThickEh, clsDoubleEh,
    clsDashDotEh, clsDashDotDotEh, clsDashedEh, clsDottedEh, clsHairEh,
    clsMediumDashDotEh, clsMediumDashDotDotEh, clsMediumDashedEh, clsSlantDashDotEh);
  TXlsFileCellHorzAlign = (chaUnassignedEh, chaLeftEh, chaRightEh, chaCenterEh);
  TXlsFileCellVertAlign = (cvaUnassignedEh, cvaTopEh, cvaBottomEh, cvaCenterEh);
  TXlsFileCharsFlowDirectionEh = (chfdHorizontalEh, chfdVerticalEh);

  TXlsFilePrintScalingModeEh = (fpsmAdjustToScaleEh, fpsmFitToPagesEh);

{ TXlsFileEh }

  TXlsMemFileEh = class(TObject)
  private
    FWorkbook: TXlsWorkbookEh;
    function GetWorkbook: TXlsWorkbookEh;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Clear;
    procedure SaveToFile(FileName: String);
    procedure LoadFromFile(FileName: String);

    property Workbook: TXlsWorkbookEh read GetWorkbook;
  end;

{ TXlsWorkbookEh }

  TXlsWorkbookEh = class(TObject)
  private
    FWorkSheets: TObjectListEh;
    FStyles: TXlsFileStylesEh;

    function GetWorksheet(WorksheetId: Variant): TXlsWorksheetEh;
    function GetWorksheetCount: Integer;
    function GetStyles: TXlsFileStylesEh;
  protected
    procedure RenameWorksheet(Worksheet: TXlsWorksheetEh; NewName: string);

  public
    constructor Create;
    destructor Destroy; override;

    function AddWorksheet(WorksheetName: string): TXlsWorksheetEh;
    function FindWorksheet(WorksheetName: string): TXlsWorksheetEh;

    procedure MoveWorksheet(FromIndex, ToIndex: Integer);
    procedure RemoveWorksheet(WorksheetEh: TXlsWorksheetEh);

    property Worksheets[WorksheetId: Variant]: TXlsWorksheetEh read GetWorksheet;
    property WorksheetCount: Integer read GetWorksheetCount;

    property Styles: TXlsFileStylesEh read GetStyles;
  end;

{ TXlsWorksheetEh }

  TXlsWorksheetEh = class(TObject)
  private
    FName: String;
    FWorkbook: TXlsWorkbookEh;
    FColumns:  TXlsFileColumnsEh;
    FCells: array of array of TXlsFileCellEh;
    FDimension: TXlsFileWorksheetDimensionEh;
    FFrozenColCount: Integer;
    FFrozenRowCount: Integer;
    FAutoFilterRange: TXlsFileWorksheetCellsRectEh;
    FRows: TXlsFileRowsEh;
    FZoomScale: Integer;
    FDefaultRowHeight: Double;
    FDefaultColWidth: Double;
    FPrintParams: TXlsFileWorksheetPrintParamsEh;
    FTabColor: TColor;
    FOutlineRowsSummaryBelow: Boolean;
    FOutlineColsSummaryRight: Boolean;
    function GetName: String;
    procedure SetName(const Value: String);
    function GetColumns: TXlsFileColumnsEh;
    function GetCell(Col, Row: Integer): TXlsFileCellEh;
    function GetCellDataExists(Col, Row: Integer): Boolean;
    function GetRows: TXlsFileRowsEh;
  public
    constructor Create(AWorkbook: TXlsWorkbookEh);
    destructor Destroy; override;

    function GetCellsRange(FromCol, FromRow, ToCol, ToRow: Integer): IXlsFileCellsRangeEh;
    function GetOutlineLevelForRows: Integer;

    procedure MergeCell(Col, Row, ColCount, RowCount: Integer);
    procedure UnmergerCell(Col, Row: Integer);

    property AutoFilterRange: TXlsFileWorksheetCellsRectEh read FAutoFilterRange write FAutoFilterRange;
    property CellDataExists[Col, Row: Integer]: Boolean read GetCellDataExists;
    property Cells[Col, Row: Integer]: TXlsFileCellEh read GetCell;
    property Columns: TXlsFileColumnsEh read GetColumns;
    property DefaultColWidth: Double read FDefaultColWidth write FDefaultColWidth; 
    property DefaultRowHeight: Double read FDefaultRowHeight write FDefaultRowHeight; 
    property Dimension: TXlsFileWorksheetDimensionEh read FDimension;
    property FrozenColCount: Integer read FFrozenColCount write FFrozenColCount;
    property FrozenRowCount: Integer read FFrozenRowCount write FFrozenRowCount;
    property Name: String read GetName write SetName;
    property OutlineRowsSummaryBelow: Boolean read FOutlineRowsSummaryBelow write FOutlineRowsSummaryBelow default True;
    property OutlineColsSummaryRight: Boolean read FOutlineColsSummaryRight write FOutlineColsSummaryRight default True;
    property PrintParams: TXlsFileWorksheetPrintParamsEh read FPrintParams;
    property Rows: TXlsFileRowsEh read GetRows;
    property TabColor: TColor read FTabColor write FTabColor;
    property ZoomScale: Integer read FZoomScale write FZoomScale;
  end;

{ TXlsFileColumns }

  TXlsFileColumnsEh = class(TObject)
  private
    FColumns: TObjectListEh;
    FWorksheet: TXlsWorksheetEh;
    function GetColumn(ColumnIndex: Integer): TXlsFileColumnEh;
    function GetCurrentCount: Integer;
  public
    constructor Create(AWorksheet: TXlsWorksheetEh);
    destructor Destroy; override;

    function ScreenToXlsWidth(ScreenWidth: Integer): Double;
    function ColumnIsCreated(ColumnIndex: Integer): Boolean;
    function GetColumnsRange(const ColumnIndexes: array of Integer): IXlsFileCellsRangeEh;

    property Column[ColumnIndex: Integer]: TXlsFileColumnEh read GetColumn; default;
    property CurrentCount: Integer read GetCurrentCount;
  end;

{ TXlsFileColumn }

  TXlsFileColumnEh = class(TObject)
  private
    FOutlineLevel: Integer;
    FOutlineNodeCollapsed: Boolean;
    FVisible: Boolean;
    FWidth: Double;
    FStyle: TXlsFileCellStyle;

    function GetStyle: TXlsFileCellStyle;
    function GetVisible: Boolean;
    function GetWidth: Double;

    procedure SetVisible(const Value: Boolean);
    procedure SetWidth(const Value: Double);
  public
    constructor Create;
    destructor Destroy; override;

    property OutlineLevel: Integer read FOutlineLevel write FOutlineLevel;
    property OutlineNodeCollapsed: Boolean read FOutlineNodeCollapsed write FOutlineNodeCollapsed;
    property Width: Double read GetWidth write SetWidth;
    property Visible: Boolean read GetVisible write SetVisible;
    property Style: TXlsFileCellStyle read GetStyle;
  end;

{ TXlsFileRowsEh }

  TXlsFileRowsEh = class(TObject)
  private
    FRows: TObjectListEh;
    FWorksheet: TXlsWorksheetEh;
    function GetRow(RowIndex: Integer): TXlsFileRowEh;
    function GetCount: Integer;
  public
    constructor Create(AWorksheet: TXlsWorksheetEh);
    destructor Destroy; override;

    function ScreenToXlsHeight(ScreenHeight: Integer): Double;
    function RowIsCreated(RowIndex: Integer): Boolean;

    property Row[RowIndex: Integer]: TXlsFileRowEh read GetRow; default;
    property Count: Integer read GetCount;
  end;

{ TXlsFileRowEh }

  TXlsFileRowEh = class(TObject)
  private
    FHeight: Double;
    FHeightHasValue: Boolean;
    FVisible: Boolean;
    FOutlineNodeCollapsed: Boolean;
    FOutlineLevel: Integer;

    function GetHeight: Double;
    function GetHeightHasValue: Boolean;
    function GetVisible: Boolean;

    procedure SetHeight(const Value: Double);
    procedure SetHeightHasValue(const Value: Boolean);
    procedure SetVisible(const Value: Boolean);
  public
    constructor Create;
    destructor Destroy; override;

    property Height: Double read GetHeight write SetHeight;
    property HeightHasValue: Boolean read GetHeightHasValue write SetHeightHasValue;
    property Visible: Boolean read GetVisible write SetVisible;
    property OutlineLevel: Integer read FOutlineLevel write FOutlineLevel;
    property OutlineNodeCollapsed: Boolean read FOutlineNodeCollapsed write FOutlineNodeCollapsed;
  end;

{ TXlsFileStyleFont }

  TXlsFileStyleFont = class(TObject)
  private
    FName: String;
    FIsUnderline: Boolean;
    FColor: TColor;
    FIsItalic: Boolean;
    FIsBold: Boolean;
    FSize: Integer;
    FIndex: Integer;
  public
    property Name: String read FName write FName;
    property Size: Integer read FSize write FSize;
    property Color: TColor read FColor write FColor;
    property IsBold: Boolean read FIsBold write FIsBold;
    property IsItalic: Boolean read FIsItalic write FIsItalic;
    property IsUnderline: Boolean read FIsUnderline write FIsUnderline;
    property Index: Integer read FIndex;
  end;

  TXlsFileStyleFillPatternTypeEh = (
    fptNoneEh,
    fptSolidEh,
    fptMediumGrayEh,
    fptDarkGrayEh,
    fptLightGrayEh,
    fptDarkHorizontalEh,
    fptDarkVerticalEh,
    fptDarkDownEh,
    fptDarkUpEh,
    fptDarkGridEh,
    fptDarkTrellisEh,
    fptLightHorizontalEh,
    fptLightVerticalEh,
    fptLightDownEh,
    fptLightUpEh,
    fptLightGridEh,
    fptLightTrellisEh,
    fptGray125Eh,
    fptGray0625Eh);


{ TXlsFileStyleFill }

  TXlsFileStyleFill = class(TObject)
  private
    FColor: TColor;
    FPatternType: TXlsFileStyleFillPatternTypeEh;
    FIndex: Integer;
    FPatternColor: TColor;
  public
    property Color: TColor read FColor write FColor;
    property PatternColor: TColor read FPatternColor write FPatternColor;
    property PatternType: TXlsFileStyleFillPatternTypeEh read FPatternType;
    property Index: Integer read FIndex;
  end;

{ TXlsFileStyleLineEh }

  TXlsFileStyleLineEh = class(TObject)
  private
    FColor: TColor;
    FStyle: TXlsFileCellLineStyleEh;

  public
    property Color: TColor read FColor write FColor;
    property Style: TXlsFileCellLineStyleEh read FStyle write FStyle;
  end;

{ TXlsFileStyleLinesEh }

  TXlsFileStyleLinesEh = class(TObject)
  private
    FBottom: TXlsFileStyleLineEh;
    FDiagonalDown: TXlsFileStyleLineEh;
    FDiagonalUp: TXlsFileStyleLineEh;
    FIndex: Integer;
    FLeft: TXlsFileStyleLineEh;
    FRight: TXlsFileStyleLineEh;
    FTop: TXlsFileStyleLineEh;

  public
    constructor Create();
    destructor Destroy; override;

    property Left: TXlsFileStyleLineEh read FLeft;
    property Right: TXlsFileStyleLineEh read FRight;
    property Top: TXlsFileStyleLineEh read FTop;
    property Bottom: TXlsFileStyleLineEh read FBottom;
    property DiagonalDown: TXlsFileStyleLineEh read FDiagonalDown;
    property DiagonalUp: TXlsFileStyleLineEh read FDiagonalUp;

    property Index: Integer read FIndex;
  end;

{ TXlsFileStyleLineEh }

  TXlsFileStyleNumberFormatEh = class(TObject)
  private
    FFormatId: Integer;
    FFormatStr: String;
    FIsStandardFormat: Boolean;

  public
    property FormatStr: String read FFormatStr write FFormatStr;
    property FormatId: Integer read FFormatId write FFormatId;
    property IsStandardFormat: Boolean read FIsStandardFormat write FIsStandardFormat;
  end;

{ TXlsFileCellStyle }

  TXlsFileCellStyle = class(TObject)
  private
    FBorder: TXlsFileStyleLinesEh;
    FCharsFlowDirection: TXlsFileCharsFlowDirectionEh;
    FFill: TXlsFileStyleFill;
    FFont: TXlsFileStyleFont;
    FHorzAlign: TXlsFileCellHorzAlign;
    FIndent: Integer;
    FIndex: Integer;
    FNumberFormat: TXlsFileStyleNumberFormatEh;
    FRotation: Integer;
    FVertAlign: TXlsFileCellVertAlign;
    FWrapText: Boolean;
  public
    property Border: TXlsFileStyleLinesEh read FBorder;
    property CharsFlowDirection: TXlsFileCharsFlowDirectionEh read FCharsFlowDirection;
    property Fill: TXlsFileStyleFill read FFill;
    property Font: TXlsFileStyleFont read FFont;
    property HorzAlign: TXlsFileCellHorzAlign read FHorzAlign;
    property Indent: Integer read FIndent;
    property Index: Integer read FIndex;
    property NumberFormat: TXlsFileStyleNumberFormatEh read FNumberFormat;
    property Rotation: Integer read FRotation; //Degrees
    property VertAlign: TXlsFileCellVertAlign read FVertAlign;
    property WrapText: Boolean read FWrapText;
  end;

{ TXlsFileStyles }

  TXlsFileStylesEh = class(TObject)
  private
    FCellStyles: TObjectListEh;
    FFonts: TObjectListEh;
    FFills: TObjectListEh;
    FBorders: TObjectListEh;
    FNumberFormats: TObjectListEh;

    function GetCellStyle(Index: Integer): TXlsFileCellStyle;
    function GetFill(Index: Integer): TXlsFileStyleFill;
    function GetFont(Index: Integer): TXlsFileStyleFont;
    function GetFontCount: Integer;
    function GetFillCount: Integer;
    function GetCellStyleCount: Integer;
    function GetBorder(Index: Integer): TXlsFileStyleLinesEh;
    function GetBorderCount: Integer;
    function GetNumberFormat(Index: Integer): TXlsFileStyleNumberFormatEh;
    function GetNumberFormatCount: Integer;
  public
    constructor Create;
    destructor Destroy; override;

    function GetOrCreateNumberFormat(FormatStr: String): TXlsFileStyleNumberFormatEh;
    function GetOrCreateFont(FontName: String; FontSize: Integer; FontColor: TColor; FontIsBold: Boolean; FontIsItalic: Boolean; FontIsUnderline: Boolean): TXlsFileStyleFont;
    function GetOrCreateFill(FillColor: TColor; FillPatternColor: TColor; FillPatternType: TXlsFileStyleFillPatternTypeEh): TXlsFileStyleFill;
    function GetOrCreateBorder(LeftLineColor: TColor; LeftLineStyle: TXlsFileCellLineStyleEh; RightLineColor: TColor; RightLineStyle: TXlsFileCellLineStyleEh; TopLineColor: TColor; TopLineStyle: TXlsFileCellLineStyleEh; BottomLineColor: TColor; BottomLineStyle: TXlsFileCellLineStyleEh; DiagonalDownLineColor: TColor; DiagonalDownLineStyle: TXlsFileCellLineStyleEh; DiagonalUpLineColor: TColor; DiagonalUpLineStyle: TXlsFileCellLineStyleEh): TXlsFileStyleLinesEh;
    function GetOrCreateCellStyle(ANumberFormat: TXlsFileStyleNumberFormatEh; AFont: TXlsFileStyleFont; AFill: TXlsFileStyleFill; ABorder: TXlsFileStyleLinesEh; AHorzAlign: TXlsFileCellHorzAlign; AVertAlign: TXlsFileCellVertAlign; AWrapText: Boolean; ARotation: Integer; AIndent: Integer; ACharsFlowDirection: TXlsFileCharsFlowDirectionEh): TXlsFileCellStyle;

    property CellStyle[Index: Integer]: TXlsFileCellStyle read GetCellStyle;
    property Font[Index: Integer]: TXlsFileStyleFont read GetFont;
    property Fill[Index: Integer]: TXlsFileStyleFill read GetFill;
    property Border[Index: Integer]: TXlsFileStyleLinesEh read GetBorder;
    property NumberFormat[Index: Integer]: TXlsFileStyleNumberFormatEh read GetNumberFormat;

    property FontCount: Integer read GetFontCount;
    property FillCount: Integer read GetFillCount;
    property BorderCount: Integer read GetBorderCount;
    property CellStyleCount: Integer read GetCellStyleCount;
    property NumberFormatCount: Integer read GetNumberFormatCount;
  end;

{ TXlsFileCellMergeRangeEh }

  TXlsFileCellMergeRangeEh = class(TObject)
  private
    FColCount: Integer;
    FRowCount: Integer;
  public
    constructor Create;

    property ColCount: Integer read FColCount;
    property RowCount: Integer read FRowCount;
  end;

  TCellValueType = (cvtEmpty, cvtBoolean, cvtDate, cvtError, cvtInlineStr, cvtNumber,
    cvtSharedString, cvtString);

{ TXlsFileColumn }

  TXlsFileCellEh = class(TObject)
  private
    FValue: Variant;
    FStyle: TXlsFileCellStyle;
    FMergeRange: TXlsFileCellMergeRangeEh;
    FWorksheet: TXlsWorksheetEh;
    FFormula: String;

    function GetStyle: TXlsFileCellStyle;
    function GetValue: Variant;
    function GetValueType: TCellValueType;
    procedure SetValue(const Value: Variant);
    procedure SetValueType(const Value: TCellValueType);


  public
    constructor Create(AWorksheet: TXlsWorksheetEh);
    destructor Destroy; override;

    function ToCompatibleValue(const Value: Variant): Variant; virtual;

    property ValueType: TCellValueType read GetValueType write SetValueType;
    property Value: Variant read GetValue write SetValue;
    property Formula: String read FFormula write FFormula;
    property Style: TXlsFileCellStyle read GetStyle;
    property MergeRange: TXlsFileCellMergeRangeEh read FMergeRange;
  end;

{ TXlsFileWorksheetCellsRectEh }

  TXlsFileWorksheetCellsRectEh = class(TObject)
  private
    FFromCol: Integer;
    FToCol: Integer;
    FFromRow: Integer;
    FToRow: Integer;
    FWorksheet: TXlsWorksheetEh;

  protected
  public
    constructor Create(Worksheet: TXlsWorksheetEh);
    destructor Destroy; override;

    procedure Clear;
    function IsEmpty: Boolean;

    property FromCol: Integer read FFromCol write FFromCol;
    property ToCol: Integer read FToCol write FToCol;
    property FromRow: Integer read FFromRow write FFromRow;
    property ToRow: Integer read FToRow write FToRow;
  end;

{ TXlsFileWorksheetDimensionEh }

  TXlsFileWorksheetDimensionEh = class(TObject)
  private
    FFromCol: Integer;
    FToCol: Integer;
    FFromRow: Integer;
    FToRow: Integer;
    FWorksheet: TXlsWorksheetEh;

    function GetFromCol: Integer;
    function GetFromRow: Integer;
    function GetToCol: Integer;
    function GetToRow: Integer;
  protected
    procedure Update;
  public
    constructor Create(Worksheet: TXlsWorksheetEh);
    destructor Destroy; override;

    property FromCol: Integer read GetFromCol;
    property ToCol: Integer read GetToCol;
    property FromRow: Integer read GetFromRow;
    property ToRow: Integer read GetToRow;
  end;

{ TXlsFileWorksheetPrintParamsEh }

  TXlsFileWorksheetPrintParamsEh = class(TPersistent)
  private
    FWorksheet: TXlsWorksheetEh;
    FPageMargins: TXlsFileWorksheetPrintPageMarginsEh;
    FScale: Integer;
    FScalingMode: TXlsFilePrintScalingModeEh;
    FFitToPagesTall: Integer;
    FFitToPagesWide: Integer;
    FOrientation: TPrinterOrientation;
    FVerticalCentered: Boolean;
    FHorizontalCentered: Boolean;
    FPageHeader: String;
    FPageFooter: String;
    procedure SetPageMargins(const Value: TXlsFileWorksheetPrintPageMarginsEh);

  public
    constructor Create(AWorksheet: TXlsWorksheetEh);
    destructor Destroy; override;

    property PageMargins: TXlsFileWorksheetPrintPageMarginsEh read FPageMargins write SetPageMargins;
    property Scale: Integer read FScale write FScale default 100;
    property FitToPagesWide: Integer read FFitToPagesWide write FFitToPagesWide default 0;
    property FitToPagesTall: Integer read FFitToPagesTall write FFitToPagesTall default 0;
    property ScalingMode: TXlsFilePrintScalingModeEh read FScalingMode write FScalingMode default fpsmAdjustToScaleEh;
    property Orientation: TPrinterOrientation read FOrientation write FOrientation;
    property HorizontalCentered: Boolean read FHorizontalCentered write FHorizontalCentered;
    property VerticalCentered: Boolean read FVerticalCentered write FVerticalCentered;
    property PageHeader: String read FPageHeader write FPageHeader;
    property PageFooter: String read FPageFooter write FPageFooter;
  end;

{ TXlsFileWorksheetPrintPageMarginsEh }

  TXlsFileWorksheetPrintPageMarginsEh = class(TPersistent)
  private
    FRight: Double;
    FHeader: Double;
    FBottom: Double;
    FFooter: Double;
    FTop: Double;
    FLeft: Double;
  public
    constructor Create;
    destructor Destroy; override;

    property Left: Double read FLeft write FLeft;
    property Right: Double read FRight write FRight;
    property Top: Double read FTop write FTop;
    property Bottom: Double read FBottom write FBottom;

    property Header: Double read FHeader write FHeader;
    property Footer: Double read FFooter write FFooter;
  end;

{ TXlsFileCellsRangeFontEh }

  TXlsFileCellsRangeFontEh = class(TObject)
  private
    FName: String;
    FNameChanged: Boolean;
    FIsUnderline: Boolean;
    FIsUnderlineChanged: Boolean;
    FColor: TColor;
    FColorChanged: Boolean;
    FIsItalic: Boolean;
    FIsItalicChanged: Boolean;
    FIsBold: Boolean;
    FIsBoldChanged: Boolean;
    FSize: Integer;
    FSizeChanged: Boolean;

    procedure SetColor(const Value: TColor);
    procedure SetIsBold(const Value: Boolean);
    procedure SetIsItalic(const Value: Boolean);
    procedure SetIsUnderline(const Value: Boolean);
    procedure SetName(const Value: String);
    procedure SetSize(const Value: Integer);

  public
    function HasChanges: Boolean;

    property Name: String read FName write SetName;
    property Size: Integer read FSize write SetSize;
    property Color: TColor read FColor write SetColor;
    property IsBold: Boolean read FIsBold write SetIsBold;
    property IsItalic: Boolean read FIsItalic write SetIsItalic;
    property IsUnderline: Boolean read FIsUnderline write SetIsUnderline;
  end;

{ TXlsFileCellsRangeFillEh }

  TXlsFileCellsRangeFillEh = class(TObject)
  private
    FColor: TColor;
    FColorChanged: Boolean;
    FPatternColor: TColor;
    FPatternColorChanged: Boolean;
    FPatternType: TXlsFileStyleFillPatternTypeEh;
    FPatternTypeChanged: Boolean;

    procedure SetColor(const Value: TColor);
    procedure SetPatternColor(const Value: TColor);
    procedure SetPatternType(const Value: TXlsFileStyleFillPatternTypeEh);

  public
    function HasChanges: Boolean;

    property Color: TColor read FColor write SetColor;
    property PatternColor: TColor read FPatternColor write SetPatternColor;
    property PatternType: TXlsFileStyleFillPatternTypeEh read FPatternType write SetPatternType;
  end;

{ TXlsFileCellsRangeLineEh }

  TXlsFileCellsRangeLineEh = class(TObject)
  private
    FColor: TColor;
    FColorChanged: Boolean;
    FStyle: TXlsFileCellLineStyleEh;
    FStyleChanged: Boolean;

    procedure SetColor(const Value: TColor);
    procedure SetStyle(const Value: TXlsFileCellLineStyleEh);

  public
    constructor Create;

    function HasChanges: Boolean;

    property Color: TColor read FColor write SetColor;
    property Style: TXlsFileCellLineStyleEh read FStyle write SetStyle;
  end;

{ TXlsFileCellsRangeLinesEh }

  TXlsFileCellsRangeLinesEh = class(TObject)
  private
    FRight: TXlsFileCellsRangeLineEh;
    FBottom: TXlsFileCellsRangeLineEh;
    FTop: TXlsFileCellsRangeLineEh;
    FLeft: TXlsFileCellsRangeLineEh;
    FDiagonalDown: TXlsFileCellsRangeLineEh;
    FDiagonalUp: TXlsFileCellsRangeLineEh;
    FInsideVertical: TXlsFileCellsRangeLineEh;
    FInsideHorizontal: TXlsFileCellsRangeLineEh;

  protected
    procedure Normalize;

  public
    constructor Create();
    destructor Destroy; override;

    function HasChanges: Boolean;

    property Left: TXlsFileCellsRangeLineEh read FLeft;
    property Right: TXlsFileCellsRangeLineEh read FRight;
    property Top: TXlsFileCellsRangeLineEh read FTop;
    property Bottom: TXlsFileCellsRangeLineEh read FBottom;
    property DiagonalDown: TXlsFileCellsRangeLineEh read FDiagonalDown;
    property DiagonalUp: TXlsFileCellsRangeLineEh read FDiagonalUp;
    property InsideVertical: TXlsFileCellsRangeLineEh read FInsideVertical;
    property InsideHorizontal: TXlsFileCellsRangeLineEh read FInsideHorizontal;
  end;

  IXlsFileCellsRangeEh = interface
    function GetBorder: TXlsFileCellsRangeLinesEh;
    function GetCharsFlowDirection: TXlsFileCharsFlowDirectionEh;
    function GetFill: TXlsFileCellsRangeFillEh;
    function GetFont: TXlsFileCellsRangeFontEh;
    function GetHorzAlign: TXlsFileCellHorzAlign;
    function GetIndent: Integer;
    function GetNumberFormat: String;
    function GetRotation: Integer;
    function GetVertAlign: TXlsFileCellVertAlign;
    function GetWrapText: Boolean;

    procedure SetHorzAlign(const Value: TXlsFileCellHorzAlign);
    procedure SetIndent(const Value: Integer);
    procedure SetNumberFormat(const Value: String);
    procedure SetRotation(const Value: Integer);
    procedure SetVertAlign(const Value: TXlsFileCellVertAlign);
    procedure SetWrapText(const Value: Boolean);
    procedure SetCharsFlowDirection(const Value: TXlsFileCharsFlowDirectionEh);

    procedure ApplyChages;

    property Font: TXlsFileCellsRangeFontEh read GetFont;
    property Fill: TXlsFileCellsRangeFillEh read GetFill;
    property Border: TXlsFileCellsRangeLinesEh read GetBorder;

    property HorzAlign: TXlsFileCellHorzAlign read GetHorzAlign write SetHorzAlign;
    property VertAlign: TXlsFileCellVertAlign read GetVertAlign write SetVertAlign;
    property WrapText: Boolean read GetWrapText write SetWrapText;
    property Rotation: Integer read GetRotation write SetRotation; //Degrees
    property Indent: Integer read GetIndent write SetIndent;
    property CharsFlowDirection: TXlsFileCharsFlowDirectionEh read GetCharsFlowDirection write SetCharsFlowDirection;

    property NumberFormat: String read GetNumberFormat write SetNumberFormat;
  end;


{ TXlsFileBaseFormatingRangeEh }

  TXlsFileBaseFormatingRangeEh = class(TInterfacedObject, IXlsFileCellsRangeEh)
  private
    FBorder: TXlsFileCellsRangeLinesEh;
    FCharsFlowDirection: TXlsFileCharsFlowDirectionEh;
    FCharsFlowDirectionChanged: Boolean;
    FFill: TXlsFileCellsRangeFillEh;
    FFont: TXlsFileCellsRangeFontEh;
    FHorzAlign: TXlsFileCellHorzAlign;
    FHorzAlignChanged: Boolean;
    FIndent: Integer;
    FIndentChanged: Boolean;
    FNumberFormat: String;
    FNumberFormatChanged: Boolean;
    FRotation: Integer;
    FRotationChanged: Boolean;
    FVertAlign: TXlsFileCellVertAlign;
    FVertAlignChanged: Boolean;
    FWorksheet: TXlsWorksheetEh;
    FWrapText: Boolean;
    FWrapTextChanged: Boolean;

    function GetBorder: TXlsFileCellsRangeLinesEh;
    function GetCharsFlowDirection: TXlsFileCharsFlowDirectionEh;
    function GetFill: TXlsFileCellsRangeFillEh;
    function GetFont: TXlsFileCellsRangeFontEh;
    function GetHorzAlign: TXlsFileCellHorzAlign;
    function GetIndent: Integer;
    function GetNewStyle(NewNumberFormat: TXlsFileStyleNumberFormatEh; NewFont: TXlsFileStyleFont; NewFill: TXlsFileStyleFill; NewBorder: TXlsFileStyleLinesEh; AHorzAlign: TXlsFileCellHorzAlign; AVertAlign: TXlsFileCellVertAlign; AWrapText: Boolean; ARotation: Integer; AIndent: Integer; ACharsFlowDirection: TXlsFileCharsFlowDirectionEh): TXlsFileCellStyle;
    function GetNumberFormat: String;
    function GetRotation: Integer;
    function GetVertAlign: TXlsFileCellVertAlign;
    function GetWrapText: Boolean;

    procedure SetCharsFlowDirection(const Value: TXlsFileCharsFlowDirectionEh);
    procedure SetHorzAlign(const Value: TXlsFileCellHorzAlign);
    procedure SetIndent(const Value: Integer);
    procedure SetNumberFormat(const Value: String);
    procedure SetRotation(const Value: Integer);
    procedure SetVertAlign(const Value: TXlsFileCellVertAlign);
    procedure SetWrapText(const Value: Boolean);

  public
    constructor Create(Worksheet: TXlsWorksheetEh);
    destructor Destroy; override;

    procedure ApplyChages; virtual;

    property Font: TXlsFileCellsRangeFontEh read GetFont;
    property Fill: TXlsFileCellsRangeFillEh read GetFill;
    property Border: TXlsFileCellsRangeLinesEh read GetBorder;

    property CharsFlowDirection: TXlsFileCharsFlowDirectionEh read GetCharsFlowDirection write SetCharsFlowDirection;
    property HorzAlign: TXlsFileCellHorzAlign read GetHorzAlign write SetHorzAlign;
    property VertAlign: TXlsFileCellVertAlign read GetVertAlign write SetVertAlign;
    property WrapText: Boolean read GetWrapText write SetWrapText;
    property Rotation: Integer read GetRotation write SetRotation; //Degrees
    property Indent: Integer read GetIndent write SetIndent;

    property NumberFormat: String read GetNumberFormat write SetNumberFormat;
  end;


{ TXlsFileCellsRangeEh }

  TXlsFileCellsRangeEh = class(TXlsFileBaseFormatingRangeEh)
  private
    FFromCol: Integer;
    FFromRow: Integer;
    FToCol: Integer;
    FToRow: Integer;

    function GetFromCol: Integer;
    function GetFromRow: Integer;
    function GetToCol: Integer;
    function GetToRow: Integer;

    function GetNewBorder(Cell: TXlsFileCellEh; UseLeftOutsideBorder, UseRightOutsideBorder, UseTopOutsideBorder, UseBottomOutsideBorder: Boolean): TXlsFileStyleLinesEh;
    function GetNewFill(Cell: TXlsFileCellEh): TXlsFileStyleFill;
    function GetNewFont(Cell: TXlsFileCellEh): TXlsFileStyleFont;
    function GetNewNumberFormat(Cell: TXlsFileCellEh): TXlsFileStyleNumberFormatEh;

  protected
    procedure UpdateStyleFromChangedRange(Cell: TXlsFileCellEh; ACol, ARow: Integer);

  public
    constructor Create(Worksheet: TXlsWorksheetEh);
    destructor Destroy; override;

    procedure ApplyChages; override;

    property FromCol: Integer read GetFromCol;
    property ToCol: Integer read GetToCol;
    property FromRow: Integer read GetFromRow;
    property ToRow: Integer read GetToRow;
  end;

  TXlsFileColumnsRangeEh = class(TXlsFileBaseFormatingRangeEh)
  private
    FColumnIndexes: TIntegerDynArray;

    function GetNewBorder(AColumn: TXlsFileColumnEh): TXlsFileStyleLinesEh;
    function GetNewFill(AColumn: TXlsFileColumnEh): TXlsFileStyleFill;
    function GetNewFont(AColumn: TXlsFileColumnEh): TXlsFileStyleFont;
    function GetNewNumberFormat(AColumn: TXlsFileColumnEh): TXlsFileStyleNumberFormatEh;

    procedure UpdateStyleFromChangedRange(Column: TXlsFileColumnEh);
    procedure UpdateCellStylesFromColumnStyle(ColumnIndex: Integer; Column: TXlsFileColumnEh);

  public
    constructor Create(Worksheet: TXlsWorksheetEh; const ColumnIndexes: array of Integer);
    destructor Destroy; override;

    procedure ApplyChages; override;
  end;

function AlignmentToXlsFileCellHorzAlign(Alignment: TAlignment): TXlsFileCellHorzAlign;
function XlsAZTo19Pos(XlsAZPos: String): String;
function Xls19ToAZPos(Xls19Pos: String): String;
function VCLDisplayFormatToXlsNumFormat(const VCLDisplayFormat: String): String;

implementation

uses XlsFileWritersEh, XlsFileReadersEh;

function XlsAZTo19Pos(XlsAZPos: String): String;
begin
  Result := IntToStr(ZEGetColByA1(XlsAZPos, False));
end;

function Xls19ToAZPos(Xls19Pos: String): String;
begin
  Result := ZEGetA1ByCol(StrToInt(Xls19Pos), False);
end;

function VCLDateTimeDisplayFormatToXlsNumFormat(const VCLDisplayFormat: String): String;
begin
  Result := StringReplace(VCLDisplayFormat, 'n', 'm', [rfReplaceAll, rfIgnoreCase]);
end;

function VCLNumberDisplayFormatToXlsNumFormat(const VCLDisplayFormat: String): String;
var
  sLen: Integer;
  s: String;
  c: Char;
  ci: Integer;
  LastChar: Char;
  ForQuotesStr: String;
begin
  s := VCLDisplayFormat;
  sLen := Length(s);
  ci := 1;
  Result := '';
  lastChar := #0;

  while (ci <= sLen) do
  begin
    if (ci > 1) then
      lastChar := s[ci-1];
    c := s[ci];
    case c of
      '"':
      begin
        Result := Result + c;
        Inc(ci);
        while (ci <= sLen) and (s[ci] <> '"') do
        begin
          Result := Result + s[ci];
          Inc(ci);
        end;
        if ci > sLen then
          Exit;
        Result := Result + s[ci];
      end;

      '''':
      begin
        Result := Result + '"';
        Inc(ci);
        while (ci <= sLen) and (s[ci] <> '''') do
        begin
          if (s[ci] = '"') then
            Result := Result + '"\""';
          Inc(ci);
        end;
        if ci > sLen then
          Exit;
        Result := Result + '"';
      end;

      ';':
      begin
        Result := Result + s[ci];
        Inc(ci);
      end;

    else
      if (CharInSetEh(c, ['#', '0', '.', ',', '-'])) then
      begin
        if (c = ',') and (lastChar <> '#') then
          Result := Result + '#,'
        else
          Result := Result + s[ci];
        Inc(ci);
      end else
      begin
        ForQuotesStr := '';

        while (ci <= sLen) and not CharInSetEh(s[ci], ['#', '0', '.', ',', ';', '''', '"']) do
        begin
          ForQuotesStr := ForQuotesStr + s[ci];
          Inc(ci);
        end;

        if (Length(ForQuotesStr) = 1) then
          Result := Result + '\' + ForQuotesStr
        else
          Result := Result + '"' + ForQuotesStr + '"';
      end;
    end;
  end;
end;

function VCLDisplayFormatToXlsNumFormat(const VCLDisplayFormat: String): String;
var
  MaskIsDateTime: Boolean;

  function IsDateTimeMask(const VCLDisplayFormat: String): Boolean;
  var
    sLen: Integer;
    s: String;
    c: Char;
    ci: Integer;
  begin
    s := VCLDisplayFormat;
    sLen := Length(s);
    ci := 1;

    while (ci <= sLen) do
    begin
      c := s[ci];
      case c of
        '"':
        begin
          Inc(ci);
          while (ci <= sLen) and (s[ci] <> '"') do
            Inc(ci);
          if ci <= sLen then
            Inc(ci);
        end;

        '''':
        begin
          Inc(ci);
          while (ci <= sLen) and (s[ci] <> '''') do
            Inc(ci);
          if ci <= sLen then
            Inc(ci);
        end;
      end;

      if (CharInSetEh(c, ['0', '#']))
      then
      begin
        Result := False;
        Exit;
      end else
      begin
        Inc(ci);
      end;
    end;

    Result := True;
  end;

begin
  MaskIsDateTime := IsDateTimeMask(VCLDisplayFormat);
  if MaskIsDateTime then
    Result := VCLDateTimeDisplayFormatToXlsNumFormat(VCLDisplayFormat)
  else
    Result := VCLNumberDisplayFormatToXlsNumFormat(VCLDisplayFormat);
end;

function AlignmentToXlsFileCellHorzAlign(Alignment: TAlignment): TXlsFileCellHorzAlign;
begin
 if Alignment = taLeftJustify then
   Result := chaLeftEh
 else if Alignment = taRightJustify then
   Result := chaRightEh
 else if Alignment = taCenter then
   Result := chaCenterEh
 else
  Result := chaUnassignedEh;
end;

{ TXlsFileEh }

constructor TXlsMemFileEh.Create;
begin
  FWorkbook := TXlsWorkbookEh.Create;
end;

destructor TXlsMemFileEh.Destroy;
begin
  FreeAndNil(FWorkbook);
  inherited Destroy;
end;

function TXlsMemFileEh.GetWorkbook: TXlsWorkbookEh;
begin
  Result := FWorkbook;
end;

procedure TXlsMemFileEh.SaveToFile(FileName: String);
var
  FileWriter: TXlsxFileWriterEh;
begin
  FileWriter := TXlsxFileWriterEh.Create(Self);
  FileWriter.WritetToFile(FileName);
  FileWriter.Free;
end;

procedure TXlsMemFileEh.LoadFromFile(FileName: String);
var
  FileReader: TXlsFileReaderEh;
begin
  FileReader := TXlsFileReaderEh.Create();
  FileReader.ReadFromFile(FileName);
  FileReader.WriteToXlsMemFile(Self);
  FileReader.Free;
end;

procedure TXlsMemFileEh.Clear;
begin
  while Workbook.WorksheetCount > 0 do
  begin
    Workbook.Worksheets[Workbook.WorksheetCount-1].Free;
  end;
end;

{ TXlsWorkbookEh }

constructor TXlsWorkbookEh.Create;
begin
  FWorkSheets := TObjectListEh.Create;
  FStyles := TXlsFileStylesEh.Create;

  AddWorksheet('Sheet1');
end;

destructor TXlsWorkbookEh.Destroy;
begin
  while WorksheetCount > 0 do
  begin
    FWorksheets[WorksheetCount-1].Free;
  end;

  FreeAndNil(FWorkSheets);
  FreeAndNil(FStyles);
  inherited Destroy;
end;

function TXlsWorkbookEh.AddWorksheet(WorksheetName: string): TXlsWorksheetEh;
begin
  Result := TXlsWorksheetEh.Create(Self);
  Result.Name := WorksheetName;
  FWorkSheets.Add(Result);
end;

function TXlsWorkbookEh.FindWorksheet(WorksheetName: string): TXlsWorksheetEh;
var
  i: Integer;
begin
  for i := 0 to FWorkSheets.Count - 1 do
  begin
    if TXlsWorksheetEh(FWorkSheets[i]).Name = WorksheetName then
    begin
      Result := TXlsWorksheetEh(FWorkSheets[i]);
      Exit;
    end;
  end;
  Result := nil;
end;

function TXlsWorkbookEh.GetStyles: TXlsFileStylesEh;
begin
  Result := FStyles;
end;

function TXlsWorkbookEh.GetWorksheetCount: Integer;
begin
  Result := FWorkSheets.Count;
end;

procedure TXlsWorkbookEh.MoveWorksheet(FromIndex, ToIndex: Integer);
begin
  FWorkSheets.Move(FromIndex, ToIndex);
end;

procedure TXlsWorkbookEh.RemoveWorksheet(WorksheetEh: TXlsWorksheetEh);
begin
  FWorkSheets.Remove(WorksheetEh);
  if WorksheetEh.FWorkbook = Self then
    WorksheetEh.FWorkbook := nil;
end;

procedure TXlsWorkbookEh.RenameWorksheet(Worksheet: TXlsWorksheetEh;
  NewName: string);
begin
  if (FindWorksheet(NewName) <> nil) then
    raise Exception.Create('Worksheet ''' + NewName + ''' already exists');
  Worksheet.FName := NewName;
end;

function TXlsWorkbookEh.GetWorksheet(WorksheetId: Variant): TXlsWorksheetEh;
var
  wsIndex: Integer;
begin
  if (VarIsStr(WorksheetId)) then
    Result := FindWorksheet(VarToStr(WorksheetId))
  else
  begin
    wsIndex := WorksheetId;
    Result := TXlsWorksheetEh(FWorkSheets[wsIndex]);
  end;
end;

{ TXlsWorksheet }

constructor TXlsWorksheetEh.Create(AWorkbook: TXlsWorkbookEh);
begin
  FWorkbook := AWorkbook;
  FColumns := TXlsFileColumnsEh.Create(Self);
  FRows := TXlsFileRowsEh.Create(Self);
  FDimension := TXlsFileWorksheetDimensionEh.Create(Self);
  FAutoFilterRange := TXlsFileWorksheetCellsRectEh.Create(Self);
  FPrintParams := TXlsFileWorksheetPrintParamsEh.Create(Self);
  FZoomScale := 100;
  FDefaultColWidth := 8.43;
  FDefaultRowHeight := 15;
  FTabColor := clNone;
  FOutlineRowsSummaryBelow := True;
  FOutlineColsSummaryRight := True;
end;

destructor TXlsWorksheetEh.Destroy;
var
  ic, ir: Integer;
begin
  FreeAndNil(FColumns);
  FreeAndNil(FRows);
  FreeAndNil(FDimension);
  FreeAndNil(FAutoFilterRange);
  FreeAndNil(FPrintParams);

  for ic := 0 to Length(FCells) - 1 do
  begin
    for ir := 0 to Length(FCells[ic]) - 1 do
    begin
      if (FCells[ic, ir] <> nil) then
      begin
        FCells[ic, ir].Free;
        FCells[ic, ir] := nil;
      end;
    end;
  end;

  if (FWorkbook <> nil) then
    FWorkbook.RemoveWorksheet(Self);

  inherited Destroy;
end;

function TXlsWorksheetEh.GetCell(Col, Row: Integer): TXlsFileCellEh;
var
  DimChanged: Boolean;
begin
  DimChanged := False;

  if Length(FCells) <= Col then
  begin
    SetLength(FCells, Col + 1);
    DimChanged := True;
  end;

  if Length(FCells[Col]) <= Row then
  begin
    SetLength(FCells[Col], Row + 1);
    DimChanged := True;
  end;

  if (FCells[Col, Row] = nil) then
  begin
    FCells[Col, Row] := TXlsFileCellEh.Create(Self);

    if Columns.ColumnIsCreated(Col) and
       (Columns[Col].Style <> nil)
    then
      FCells[Col, Row].FStyle := Columns[Col].Style
    else
      FCells[Col, Row].FStyle := FWorkbook.Styles.CellStyle[0];
  end;

  if (DimChanged) then
    FDimension.Update;

  Result := FCells[Col, Row];
end;

function TXlsWorksheetEh.GetCellDataExists(Col, Row: Integer): Boolean;
begin
  if (Col < Length(FCells)) and
     (Row < Length(FCells[Col])) and
     (FCells[Col, Row] <> nil)
  then
    Result := True
  else
    Result := False;
end;

function TXlsWorksheetEh.GetCellsRange(FromCol, FromRow, ToCol,
  ToRow: Integer): IXlsFileCellsRangeEh;
var
  Range: TXlsFileCellsRangeEh;
begin
  Range := TXlsFileCellsRangeEh.Create(Self);
  Range.FFromCol := FromCol;
  Range.FFromRow := FromRow;
  Range.FToCol := ToCol;
  Range.FToRow := ToRow;
  Result := Range;
end;

function TXlsWorksheetEh.GetColumns: TXlsFileColumnsEh;
begin
  Result := FColumns;
end;

function TXlsWorksheetEh.GetRows: TXlsFileRowsEh;
begin
  Result := FRows;
end;

function TXlsWorksheetEh.GetName: String;
begin
  Result := FName;
end;

procedure TXlsWorksheetEh.SetName(const Value: String);
begin
  if (Name <> Value) then
  begin
    FWorkbook.RenameWorksheet(Self, Value);
  end;
end;

procedure TXlsWorksheetEh.MergeCell(Col, Row, ColCount, RowCount: Integer);
var
  ic, ir: Integer;
  Cell, iCell: TXlsFileCellEh;
begin
  if (ColCount < 0) then
    raise Exception.Create('TXlsWorksheetEh.MergeCell: ColCount < 0');
  if (RowCount < 0) then
    raise Exception.Create('TXlsWorksheetEh.MergeCell: RowCount < 0');

  if (ColCount = 0) then ColCount := 1;
  if (RowCount = 0) then RowCount := 1;

  Cell := Cells[Col, Row];
  if (Cell.MergeRange.ColCount > 1) or
     (Cell.MergeRange.RowCount > 1) then
  begin
    UnmergerCell(Col, Row);
  end;

  for ic := Col to Col + ColCount - 1 do
  begin
    for ir := Row to Row + RowCount - 1 do
    begin
      iCell := Cells[ic, ir]; 
      if (ic = Col) and (ir = Row) then
      begin
        iCell.MergeRange.FColCount := ColCount;
        iCell.MergeRange.FRowCount := RowCount;
      end else
      begin
        FCells[ic, ir].Value := Unassigned;
        FCells[ic, ir].Formula := '';
      end;
    end;
  end;
end;

procedure TXlsWorksheetEh.UnmergerCell(Col, Row: Integer);
var
  ic, ir: Integer;
  Cell: TXlsFileCellEh;
begin
  if not CellDataExists[Col, Row] then Exit;
  Cell := Cells[Col, Row];
  if (Cell.MergeRange.ColCount = 0) and (Cell.MergeRange.RowCount = 0) then Exit;

  for ic := Col to Col + Cell.MergeRange.ColCount do
  begin
    for ir := Row to Row + Cell.MergeRange.RowCount do
    begin
      if (ic = Col) and (ir = Row) then
      begin
        FCells[ic, ir].MergeRange.FColCount := 0;
        FCells[ic, ir].MergeRange.FRowCount := 0;
      end else
      begin
        FCells[ic, ir] := nil;
      end;
    end;
  end;
end;

function TXlsWorksheetEh.GetOutlineLevelForRows: Integer;
var
  r: Integer;
  Row: TXlsFileRowEh;
begin
  Result := 0;
  for r := 0 to Rows.Count-1 do
  begin
    Row := Rows[r];
    if (Row.OutlineLevel > Result) then
      Result := Row.OutlineLevel;
  end;
end;

{ TXlsFileColumn }

constructor TXlsFileColumnEh.Create;
begin
  FWidth := 8.43;
  FVisible := True;
end;

destructor TXlsFileColumnEh.Destroy;
begin
  inherited Destroy;
end;

function TXlsFileColumnEh.GetVisible: Boolean;
begin
  Result := FVisible
end;

procedure TXlsFileColumnEh.SetVisible(const Value: Boolean);
begin
  FVisible := Value;
end;

function TXlsFileColumnEh.GetWidth: Double;
begin
  Result := FWidth;
end;

procedure TXlsFileColumnEh.SetWidth(const Value: Double);
begin
  FWidth := Value;
end;

function TXlsFileColumnEh.GetStyle: TXlsFileCellStyle;
begin
  Result := FStyle;
end;

{ TXlsFileColumns }

constructor TXlsFileColumnsEh.Create(AWorksheet: TXlsWorksheetEh);
begin
  FColumns := TObjectListEh.Create;
  FWorksheet := AWorksheet;
end;

destructor TXlsFileColumnsEh.Destroy;
var
  i: Integer;
begin
  for i := 0 to FColumns.Count-1 do
  begin
    FColumns[i].Free;
    FColumns[i] := nil;
  end;

  FreeAndNil(FColumns);

  inherited Destroy;
end;

function TXlsFileColumnsEh.GetColumn(ColumnIndex: Integer): TXlsFileColumnEh;
begin
  if (ColumnIndex >= FColumns.Count) then
    FColumns.Count := ColumnIndex + 1;

  if (FColumns[ColumnIndex] = nil) then
    FColumns[ColumnIndex] := TXlsFileColumnEh.Create;

  Result := TXlsFileColumnEh(FColumns[ColumnIndex]);
end;

//function TXlsFileColumnsEh.GetColumnsRange(
//  const ColumnIndexes: TIntegerDynArray): IXlsFileCellsRangeEh;
function TXlsFileColumnsEh.GetColumnsRange(
  const ColumnIndexes: array of Integer): IXlsFileCellsRangeEh;
begin
  Result := TXlsFileColumnsRangeEh.Create(FWorksheet, ColumnIndexes);
end;

function TXlsFileColumnsEh.GetCurrentCount: Integer;
begin
  Result := FColumns.Count;
end;

function TXlsFileColumnsEh.ColumnIsCreated(ColumnIndex: Integer): Boolean;
begin
  if (ColumnIndex < FColumns.Count) and (FColumns[ColumnIndex] <> nil) then
    Result := True
  else
    Result := False;
end;

function TXlsFileColumnsEh.ScreenToXlsWidth(ScreenWidth: Integer): Double;
begin
  Result := ScreenWidth / 7;
end;

{ TXlsFileRowsEh }

constructor TXlsFileRowsEh.Create(AWorksheet: TXlsWorksheetEh);
begin
  FRows := TObjectListEh.Create;
  FWorksheet := AWorksheet;
end;

destructor TXlsFileRowsEh.Destroy;
var
  i: Integer;
begin
  for i := 0 to FRows.Count-1 do
  begin
    FRows[i].Free;
    FRows[i] := nil;
  end;

  FreeAndNil(FRows);

  inherited Destroy;
end;

function TXlsFileRowsEh.GetRow(RowIndex: Integer): TXlsFileRowEh;
begin
  if (RowIndex >= FRows.Count) then
  begin
    FRows.Count := RowIndex + 1;
    FWorksheet.Dimension.Update;
  end;

  if (FRows[RowIndex] = nil) then
    FRows[RowIndex] := TXlsFileRowEh.Create;

  Result := TXlsFileRowEh(FRows[RowIndex]);
end;

function TXlsFileRowsEh.GetCount: Integer;
begin
  Result := FRows.Count;
end;

function TXlsFileRowsEh.RowIsCreated(RowIndex: Integer): Boolean;
begin
  if (RowIndex < FRows.Count) and (FRows[RowIndex] <> nil) then
    Result := True
  else
    Result := False;
end;

function TXlsFileRowsEh.ScreenToXlsHeight(ScreenHeight: Integer): Double;
begin
  Result := 1.0 * ScreenHeight / Screen.PixelsPerInch * 72;
end;

{ TXlsFileRowEh }

constructor TXlsFileRowEh.Create;
begin
  FHeight := 0;
  FVisible := True;
end;

destructor TXlsFileRowEh.Destroy;
begin
  inherited Destroy;
end;

function TXlsFileRowEh.GetVisible: Boolean;
begin
  Result := FVisible
end;

procedure TXlsFileRowEh.SetVisible(const Value: Boolean);
begin
  FVisible := Value;
end;

function TXlsFileRowEh.GetHeight: Double;
begin
  Result := FHeight;
end;

procedure TXlsFileRowEh.SetHeight(const Value: Double);
begin
  FHeight := Value;
  FHeightHasValue := True;
end;

function TXlsFileRowEh.GetHeightHasValue: Boolean;
begin
  Result := FHeightHasValue;
end;

procedure TXlsFileRowEh.SetHeightHasValue(const Value: Boolean);
begin
  if (Value = False) then
    Height := 0;
  FHeightHasValue := Value;
end;

{ TXlsFileCellMergeRangeEh }

constructor TXlsFileCellMergeRangeEh.Create;
begin
  FColCount := 1; 
  FRowCount := 1; 
end;

{ TXlsFileCell }

constructor TXlsFileCellEh.Create(AWorksheet: TXlsWorksheetEh);
begin
  FWorksheet := AWorksheet;
  FMergeRange := TXlsFileCellMergeRangeEh.Create;
end;

destructor TXlsFileCellEh.Destroy;
begin
  FreeAndNil(FMergeRange);
  inherited Destroy;
end;

function TXlsFileCellEh.GetStyle: TXlsFileCellStyle;
begin
  Result := FStyle;
end;

function TXlsFileCellEh.GetValue: Variant;
begin
  Result := FValue;
end;

procedure TXlsFileCellEh.SetValue(const Value: Variant);
var
  AVarType: TVarType;
  NewNumberFormat: TXlsFileStyleNumberFormatEh;
  NewStyle: TXlsFileCellStyle;
begin
  FValue := ToCompatibleValue(Value);
  AVarType := VarType(FValue);
  if (AVarType = varDate) and (Style.NumberFormat.FormatId = 0) then
  begin
    NewNumberFormat := FWorksheet.FWorkbook.Styles.GetOrCreateNumberFormat('dd/mm/yyyy;@');
    NewStyle := FWorksheet.FWorkbook.Styles.GetOrCreateCellStyle(
                   NewNumberFormat,
                   Style.Font,
                   Style.Fill,
                   Style.Border,
                   Style.HorzAlign,
                   Style.VertAlign,
                   Style.WrapText,
                   Style.Rotation,
                   Style.Indent,
                   Style.CharsFlowDirection);

    FStyle := NewStyle;
  end;
end;

function TXlsFileCellEh.GetValueType: TCellValueType;
var
  AVarType: TVarType;
begin
  AVarType := VarType(FValue);

  if AVarType in [varEmpty, varNull] then
    Result := cvtEmpty
  else
  begin
    if (AVarType = varDate) and (FValue < EncodeDate(1900, 1, 1)) then
    begin 
      Result := cvtDate;
    end
    else if VarIsNumeric(FValue) then
    begin
      Result := cvtNumber
    end else
    begin
      Result := cvtString;
    end;
  end;
end;

procedure TXlsFileCellEh.SetValueType(const Value: TCellValueType);
begin
end;

function TXlsFileCellEh.ToCompatibleValue(const Value: Variant): Variant;
begin
  {$IFDEF FPC}
  Result := Value;
  {$ELSE}
  if VarType(Value) = VarSQLTimeStamp then
    VarCast(Result, Value, varDate)
  else
    Result := Value;
  {$ENDIF}
end;

{ TXlsFileWorksheetDimensionEh }

constructor TXlsFileWorksheetDimensionEh.Create(Worksheet: TXlsWorksheetEh);
begin
  FWorksheet := Worksheet;
  FFromCol := -1;
  FFromRow := -1;
  FToCol := -1;
  FToRow := -1;
end;

destructor TXlsFileWorksheetDimensionEh.Destroy;
begin
  inherited Destroy;
end;

function TXlsFileWorksheetDimensionEh.GetFromCol: Integer;
begin
  Result := FFromCol;
end;

function TXlsFileWorksheetDimensionEh.GetFromRow: Integer;
begin
  Result := FFromRow;
end;

function TXlsFileWorksheetDimensionEh.GetToCol: Integer;
begin
  Result := FToCol;
end;

function TXlsFileWorksheetDimensionEh.GetToRow: Integer;
begin
  Result := FToRow;
end;

procedure TXlsFileWorksheetDimensionEh.Update;
var
  ic, maxToRow: Integer;
begin
  maxToRow := FWorksheet.Rows.Count - 1;

  for ic := 0 to Length(FWorksheet.FCells)-1 do
  begin
    if Length(FWorksheet.FCells[ic]) - 1 > maxToRow then
      maxToRow := Length(FWorksheet.FCells[ic]) - 1;
  end;

  if (maxToRow >= 0) then
  begin
    FFromCol := 0;
    FFromRow := 0;
    FToCol := Length(FWorksheet.FCells) - 1;
    if FToCol < 0 then FToCol := 0;
    FToRow := maxToRow;
    if FToRow < 0 then FToRow := 0;
  end else
  begin
    FFromCol := -1;
    FFromRow := -1;
    FToCol := -1;
    FToRow := -1;
  end;
end;

{ TXlsFileStyles }

constructor TXlsFileStylesEh.Create;
begin
  FNumberFormats := TObjectListEh.Create;
  GetOrCreateNumberFormat('');

  FFonts := TObjectListEh.Create;
  GetOrCreateFont('Calibri', 11, clNone, False, False, False);

  FFills := TObjectListEh.Create;
  GetOrCreateFill(clNone, clNone, fptNoneEh);
  GetOrCreateFill(clNone, clNone, fptGray125Eh);

  FBorders := TObjectListEh.Create;
  GetOrCreateBorder(clNone, clsNoneEh,
                    clNone, clsNoneEh,
                    clNone, clsNoneEh,
                    clNone, clsNoneEh,
                    clNone, clsNoneEh,
                    clNone, clsNoneEh);

  FCellStyles := TObjectListEh.Create;
  GetOrCreateCellStyle(NumberFormat[0], Font[0], Fill[0], Border[0],
    chaUnassignedEh, cvaUnassignedEh, False, 0, 0, chfdHorizontalEh);
end;

destructor TXlsFileStylesEh.Destroy;
var
  i: Integer;
begin
  for i := 0 to FCellStyles.Count-1 do
    FCellStyles[i].Free;
  FreeAndNil(FCellStyles);

  for i := 0 to FFonts.Count-1 do
    FFonts[i].Free;
  FreeAndNil(FFonts);

  for i := 0 to FFills.Count-1 do
    FFills[i].Free;
  FreeAndNil(FFills);

  for i := 0 to FBorders.Count-1 do
    FBorders[i].Free;
  FreeAndNil(FBorders);

  for i := 0 to FNumberFormats.Count-1 do
    FNumberFormats[i].Free;
  FreeAndNil(FNumberFormats);

  inherited Destroy;
end;

function TXlsFileStylesEh.GetBorder(Index: Integer): TXlsFileStyleLinesEh;
begin
  Result := TXlsFileStyleLinesEh(FBorders[Index]);
end;

function TXlsFileStylesEh.GetBorderCount: Integer;
begin
  Result := FBorders.Count;
end;

function TXlsFileStylesEh.GetCellStyle(Index: Integer): TXlsFileCellStyle;
begin
  Result := TXlsFileCellStyle(FCellStyles[Index]);
end;

function TXlsFileStylesEh.GetCellStyleCount: Integer;
begin
  Result := FCellStyles.Count;
end;

function TXlsFileStylesEh.GetFill(Index: Integer): TXlsFileStyleFill;
begin
  Result := TXlsFileStyleFill(FFills[Index]);
end;

function TXlsFileStylesEh.GetFillCount: Integer;
begin
  Result := FFills.Count;
end;

function TXlsFileStylesEh.GetFont(Index: Integer): TXlsFileStyleFont;
begin
  Result := TXlsFileStyleFont(FFonts[Index]);
end;

function TXlsFileStylesEh.GetFontCount: Integer;
begin
  Result := FFonts.Count;
end;

function TXlsFileStylesEh.GetNumberFormat(Index: Integer): TXlsFileStyleNumberFormatEh;
begin
  Result := TXlsFileStyleNumberFormatEh(FNumberFormats[Index]);
end;

function TXlsFileStylesEh.GetNumberFormatCount: Integer;
begin
  Result := FNumberFormats.Count;
end;

function TXlsFileStylesEh.GetOrCreateFont(FontName: String; FontSize: Integer;
  FontColor: TColor; FontIsBold, FontIsItalic,
  FontIsUnderline: Boolean): TXlsFileStyleFont;
var
  i: Integer;
  iFnt: TXlsFileStyleFont;
begin
  for i := 0 to FFonts.Count-1 do
  begin
    iFnt := Font[i];
    if (SameText(iFnt.Name, FontName)) and
       (iFnt.Size = FontSize) and
       (iFnt.Color = FontColor) and
       (iFnt.IsBold = FontIsBold) and
       (iFnt.IsItalic = FontIsItalic) and
       (iFnt.IsUnderline = FontIsUnderline)
    then
    begin
      Result := iFnt;
      Exit;
    end;
  end;

  Result := TXlsFileStyleFont.Create;
  Result.Name := FontName;
  Result.Size := FontSize;
  Result.Color := FontColor;
  Result.IsBold := FontIsBold;
  Result.IsItalic := FontIsItalic;
  Result.IsUnderline := FontIsUnderline;
  Result.FIndex := FFonts.Count;

  FFonts.Add(Result);
end;

function TXlsFileStylesEh.GetOrCreateNumberFormat(FormatStr: String): TXlsFileStyleNumberFormatEh;
var
  i: Integer;
  iNf: TXlsFileStyleNumberFormatEh;
  FormatId: Integer;

  function CheckGetFormatIdFromFormatString(FormatStr: String): Integer;
  var
    ch0, ch1: String;
    StrNum: String;
    Num: Integer;
  begin
    Result := -1;
    ch0 := Copy(FormatStr, 1, 1);
    ch1 := Copy(FormatStr, Length(FormatStr), 1);
    if (ch0 = '[') and (ch1 = ']') then
    begin
      StrNum := Copy(FormatStr, 2, Length(FormatStr) - 2);
      if (TryStrToInt(StrNum, Num)) then
      begin
        Result := Num;
      end;
    end;
  end;
begin
  for i := 0 to FNumberFormats.Count-1 do
  begin
    iNf:= NumberFormat[i];
    if (iNf.FormatStr = FormatStr) then
    begin
      Result := iNf;
      Exit;
    end;
  end;

  Result := TXlsFileStyleNumberFormatEh.Create;
  Result.FormatStr := FormatStr;
  if (FormatStr <> '')
    then FormatId := CheckGetFormatIdFromFormatString(FormatStr)
    else FormatId := 0;
  if (FormatId >= 0)
    then Result.FormatId := FormatId
    else Result.FormatId := FNumberFormats.Count + 163;

  if (Result.FormatId <= 163) then
    Result.IsStandardFormat := True;

  FNumberFormats.Add(Result);
end;

function TXlsFileStylesEh.GetOrCreateFill(FillColor: TColor;
  FillPatternColor: TColor; FillPatternType: TXlsFileStyleFillPatternTypeEh): TXlsFileStyleFill;
var
  i: Integer;
  iFl: TXlsFileStyleFill;
begin
  for i := 0 to FFills.Count-1 do
  begin
    iFl := Fill[i];
    if (iFl.Color = FillColor) and
       (iFl.PatternColor = FillPatternColor) and
       (iFl.PatternType = FillPatternType)
    then
    begin
      Result := iFl;
      Exit;
    end;
  end;

  Result := TXlsFileStyleFill.Create;
  Result.Color := FillColor;
  Result.PatternColor := FillPatternColor;
  Result.FPatternType := FillPatternType;
  Result.FIndex := FFills.Count;

  FFills.Add(Result);
end;

function TXlsFileStylesEh.GetOrCreateBorder(
  LeftLineColor: TColor; LeftLineStyle: TXlsFileCellLineStyleEh;
  RightLineColor: TColor; RightLineStyle: TXlsFileCellLineStyleEh;
  TopLineColor: TColor; TopLineStyle: TXlsFileCellLineStyleEh;
  BottomLineColor: TColor; BottomLineStyle: TXlsFileCellLineStyleEh;
  DiagonalDownLineColor: TColor; DiagonalDownLineStyle: TXlsFileCellLineStyleEh;
  DiagonalUpLineColor: TColor; DiagonalUpLineStyle: TXlsFileCellLineStyleEh
  ): TXlsFileStyleLinesEh;
var
  i: Integer;
  iFnt: TXlsFileStyleLinesEh;
begin
  if LeftLineStyle = clsNoneEh then
    LeftLineColor := clNone;
  if RightLineStyle = clsNoneEh then
    RightLineColor := clNone;
  if TopLineStyle = clsNoneEh then
    TopLineColor := clNone;
  if BottomLineStyle = clsNoneEh then
    BottomLineColor := clNone;
  if DiagonalDownLineStyle = clsNoneEh then
    DiagonalDownLineColor := clNone;
  if DiagonalUpLineStyle = clsNoneEh then
    DiagonalUpLineColor := clNone;

  if (DiagonalDownLineColor <> clNone) and
     (DiagonalUpLineColor <> clNone) and
     (DiagonalDownLineColor <> DiagonalUpLineColor)
  then
    raise Exception.Create('TXlsFileStylesEh.GetOrCreateBorder: DiagonalDownLineColor <> DiagonalUpLineColor.');

  if (DiagonalDownLineStyle <> clsNoneEh) and
     (DiagonalUpLineStyle <> clsNoneEh) and
     (DiagonalDownLineStyle <> DiagonalUpLineStyle)
  then
    raise Exception.Create('TXlsFileStylesEh.GetOrCreateBorder: DiagonalDownLineStyle <> DiagonalUpLineStyle.');

  for i := 0 to FBorders.Count-1 do
  begin
    iFnt := Border[i];
    if (iFnt.Left.Color = LeftLineColor) and
       (iFnt.Left.Style = LeftLineStyle) and
       (iFnt.Right.Color = RightLineColor) and
       (iFnt.Right.Style = RightLineStyle) and
       (iFnt.Top.Color = TopLineColor) and
       (iFnt.Top.Style = TopLineStyle) and
       (iFnt.Bottom.Color = BottomLineColor) and
       (iFnt.Bottom.Style = BottomLineStyle) and
       (iFnt.DiagonalDown.Color = DiagonalDownLineColor) and
       (iFnt.DiagonalDown.Style = DiagonalDownLineStyle)and
       (iFnt.DiagonalUp.Color = DiagonalUpLineColor) and
       (iFnt.DiagonalUp.Style = DiagonalUpLineStyle)
    then
    begin
      Result := iFnt;
      Exit;
    end;
  end;

  Result := TXlsFileStyleLinesEh.Create;

  Result.Left.Color := LeftLineColor;
  Result.Left.Style := LeftLineStyle;
  Result.Right.Color := RightLineColor;
  Result.Right.Style := RightLineStyle;
  Result.Top.Color := TopLineColor;
  Result.Top.Style := TopLineStyle;
  Result.Bottom.Color := BottomLineColor;
  Result.Bottom.Style := BottomLineStyle;

  Result.DiagonalDown.Color := DiagonalDownLineColor;
  Result.DiagonalDown.Style := DiagonalDownLineStyle;
  Result.DiagonalUp.Color := DiagonalUpLineColor;
  Result.DiagonalUp.Style := DiagonalUpLineStyle;

  Result.FIndex := FBorders.Count;

  FBorders.Add(Result);
end;

function TXlsFileStylesEh.GetOrCreateCellStyle(
  ANumberFormat: TXlsFileStyleNumberFormatEh;
  AFont: TXlsFileStyleFont;
  AFill: TXlsFileStyleFill; ABorder: TXlsFileStyleLinesEh;
  AHorzAlign: TXlsFileCellHorzAlign; AVertAlign: TXlsFileCellVertAlign;
  AWrapText: Boolean; ARotation: Integer; AIndent: Integer;
  ACharsFlowDirection: TXlsFileCharsFlowDirectionEh): TXlsFileCellStyle;
var
  i: Integer;
  iStl: TXlsFileCellStyle;
begin
  for i := 0 to FCellStyles.Count-1 do
  begin
    iStl := CellStyle[i];
    if (iStl.NumberFormat = ANumberFormat) and
       (iStl.Font = AFont) and
       (iStl.Fill = AFill) and
       (iStl.Border = ABorder) and
       (iStl.HorzAlign = AHorzAlign) and
       (iStl.VertAlign = AVertAlign) and
       (iStl.WrapText = AWrapText) and
       (iStl.Rotation = ARotation) and
       (iStl.Indent = AIndent) and
       (iStl.CharsFlowDirection = ACharsFlowDirection)
    then
    begin
      Result := iStl;
      Exit;
    end;
  end;

  Result := TXlsFileCellStyle.Create;
  Result.FNumberFormat := ANumberFormat;
  Result.FFont := AFont;
  Result.FFill := AFill;
  Result.FBorder := ABorder;
  Result.FIndex := FCellStyles.Count;
  Result.FHorzAlign := AHorzAlign;
  Result.FVertAlign := AVertAlign;
  Result.FWrapText := AWrapText;
  Result.FRotation := ARotation;
  Result.FIndent := AIndent;
  Result.FCharsFlowDirection := ACharsFlowDirection;

  FCellStyles.Add(Result);
end;

{ TXlsFileBaseFormatingRangeEh }

constructor TXlsFileBaseFormatingRangeEh.Create(Worksheet: TXlsWorksheetEh);
begin
  inherited Create;

  FFont := TXlsFileCellsRangeFontEh.Create;
  FFill := TXlsFileCellsRangeFillEh.Create;
  FBorder := TXlsFileCellsRangeLinesEh.Create;
  FWorksheet := Worksheet;
end;

destructor TXlsFileBaseFormatingRangeEh.Destroy;
begin
  FreeAndNil(FFont);
  FreeAndNil(FFill);
  FreeAndNil(FBorder);
  
  inherited Destroy;
end;

procedure TXlsFileBaseFormatingRangeEh.ApplyChages;
begin
  raise Exception.Create('Method TXlsFileBaseFormatingRangeEh.ApplyChages is not implemented');
end;

function TXlsFileBaseFormatingRangeEh.GetBorder: TXlsFileCellsRangeLinesEh;
begin
  Result := FBorder;
end;

function TXlsFileBaseFormatingRangeEh.GetFill: TXlsFileCellsRangeFillEh;
begin
  Result := FFill;
end;

function TXlsFileBaseFormatingRangeEh.GetFont: TXlsFileCellsRangeFontEh;
begin
  Result := FFont;
end;

function TXlsFileBaseFormatingRangeEh.GetHorzAlign: TXlsFileCellHorzAlign;
begin
  Result := FHorzAlign;
end;

procedure TXlsFileBaseFormatingRangeEh.SetHorzAlign(const Value: TXlsFileCellHorzAlign);
begin
  FHorzAlign := Value;
  FHorzAlignChanged := True;
end;

function TXlsFileBaseFormatingRangeEh.GetVertAlign: TXlsFileCellVertAlign;
begin
  Result := FVertAlign;
end;

procedure TXlsFileBaseFormatingRangeEh.SetVertAlign(const Value: TXlsFileCellVertAlign);
begin
  FVertAlign := Value;
  FVertAlignChanged := True;
end;

function TXlsFileBaseFormatingRangeEh.GetWrapText: Boolean;
begin
  Result := FWrapText;
end;

procedure TXlsFileBaseFormatingRangeEh.SetWrapText(const Value: Boolean);
begin
  FWrapText := Value;
  FWrapTextChanged := True;
end;

function TXlsFileBaseFormatingRangeEh.GetRotation: Integer;
begin
  Result := FRotation;
end;

procedure TXlsFileBaseFormatingRangeEh.SetRotation(const Value: Integer);
begin
  if (Value < -90) or (Value > 180) then
    raise Exception.Create('SetRotation.Value is ' + IntToStr(Value) + '. Value must be >= -90 and =< 180.');

  FRotation := Value;
  if FRotation > 90 then
    FRotation := 90 - FRotation;
  FRotationChanged := True;

  if (FRotation <> 0 ) then
    CharsFlowDirection := chfdHorizontalEh;
end;

function TXlsFileBaseFormatingRangeEh.GetNumberFormat: String;
begin
  Result := FNumberFormat;
end;

procedure TXlsFileBaseFormatingRangeEh.SetNumberFormat(const Value: String);
begin
  FNumberFormat := Value;
  FNumberFormatChanged := True;
end;

function TXlsFileBaseFormatingRangeEh.GetIndent: Integer;
begin
  Result := FIndent;
end;

procedure TXlsFileBaseFormatingRangeEh.SetIndent(const Value: Integer);
begin
  FIndent := Value;
  FIndentChanged := True;
end;

function TXlsFileBaseFormatingRangeEh.GetCharsFlowDirection: TXlsFileCharsFlowDirectionEh;
begin
  Result := FCharsFlowDirection;
end;

procedure TXlsFileBaseFormatingRangeEh.SetCharsFlowDirection(
  const Value: TXlsFileCharsFlowDirectionEh);
begin
  FCharsFlowDirection := Value;
  FCharsFlowDirectionChanged := True;
  if (FCharsFlowDirection = chfdVerticalEh) then
    Rotation := 0;
end;

function TXlsFileBaseFormatingRangeEh.GetNewStyle(NewNumberFormat: TXlsFileStyleNumberFormatEh;
  NewFont: TXlsFileStyleFont;
  NewFill: TXlsFileStyleFill; NewBorder: TXlsFileStyleLinesEh;
  AHorzAlign: TXlsFileCellHorzAlign; AVertAlign: TXlsFileCellVertAlign;
  AWrapText: Boolean; ARotation: Integer; AIndent: Integer;
  ACharsFlowDirection: TXlsFileCharsFlowDirectionEh): TXlsFileCellStyle;
begin
  Result := FWorksheet.FWorkbook.Styles.
    GetOrCreateCellStyle(NewNumberFormat, NewFont, NewFill, NewBorder,
      AHorzAlign, AVertAlign, AWrapText, ARotation, AIndent, ACharsFlowDirection);
end;

{ TXlsFileCellsRangeFontEh }

function TXlsFileCellsRangeFontEh.HasChanges: Boolean;
begin
  Result := FNameChanged or
            FIsUnderlineChanged or
            FColorChanged or
            FIsItalicChanged or
            FIsBoldChanged or
            FSizeChanged;
end;

procedure TXlsFileCellsRangeFontEh.SetColor(const Value: TColor);
begin
  FColor := Value;
  FColorChanged := True;
end;

procedure TXlsFileCellsRangeFontEh.SetIsBold(const Value: Boolean);
begin
  FIsBold := Value;
  FIsBoldChanged := True;
end;

procedure TXlsFileCellsRangeFontEh.SetIsItalic(const Value: Boolean);
begin
  FIsItalic := Value;
  FIsItalicChanged := True;
end;

procedure TXlsFileCellsRangeFontEh.SetIsUnderline(const Value: Boolean);
begin
  FIsUnderline := Value;
  FIsUnderlineChanged := True;
end;

procedure TXlsFileCellsRangeFontEh.SetName(const Value: String);
begin
  FName := Value;
  FNameChanged := True;
end;

procedure TXlsFileCellsRangeFontEh.SetSize(const Value: Integer);
begin
  FSize := Value;
  FSizeChanged := True;
end;

{ TXlsFileCellsRangeFillEh }

function TXlsFileCellsRangeFillEh.HasChanges: Boolean;
begin
  Result := FColorChanged;
end;

procedure TXlsFileCellsRangeFillEh.SetColor(const Value: TColor);
begin
  FColor := Value;
  if (FColor <> 0) and (PatternType = fptNoneEh) then
    PatternType := fptSolidEh;
  FColorChanged := True;
end;

procedure TXlsFileCellsRangeFillEh.SetPatternColor(const Value: TColor);
begin
  FPatternColor := Value;
  FPatternColorChanged := True;
end;

procedure TXlsFileCellsRangeFillEh.SetPatternType(
  const Value: TXlsFileStyleFillPatternTypeEh);
begin
  FPatternType := Value;
  FPatternTypeChanged := True;
end;

{ TXlsFileCellsRangeLineEh }

constructor TXlsFileCellsRangeLineEh.Create;
begin
  FColor := clNone;
end;

function TXlsFileCellsRangeLineEh.HasChanges: Boolean;
begin
  Result := FColorChanged or FStyleChanged;
end;

procedure TXlsFileCellsRangeLineEh.SetColor(const Value: TColor);
begin
  FColor := Value;
  if (FStyle = clsNoneEh) then
    Style := clsThinEh;

  FColorChanged := True;
end;

procedure TXlsFileCellsRangeLineEh.SetStyle(const Value: TXlsFileCellLineStyleEh);
begin
  FStyle := Value;
  if (Color = clNone) then
    Color := clBlack;

  FStyleChanged := True;
end;

{ TXlsFileCellsRangeLinesEh }

constructor TXlsFileCellsRangeLinesEh.Create;
begin
  FLeft := TXlsFileCellsRangeLineEh.Create;
  FRight := TXlsFileCellsRangeLineEh.Create;
  FTop := TXlsFileCellsRangeLineEh.Create;
  FBottom := TXlsFileCellsRangeLineEh.Create;
  FDiagonalDown := TXlsFileCellsRangeLineEh.Create;
  FDiagonalUp := TXlsFileCellsRangeLineEh.Create;
  FInsideVertical := TXlsFileCellsRangeLineEh.Create;
  FInsideHorizontal := TXlsFileCellsRangeLineEh.Create;
end;

destructor TXlsFileCellsRangeLinesEh.Destroy;
begin
  FreeAndNil(FLeft);
  FreeAndNil(FRight);
  FreeAndNil(FTop);
  FreeAndNil(FBottom);
  FreeAndNil(FDiagonalDown);
  FreeAndNil(FDiagonalUp);
  FreeAndNil(FInsideVertical);
  FreeAndNil(FInsideHorizontal);
  inherited Destroy;
end;

function TXlsFileCellsRangeLinesEh.HasChanges: Boolean;
begin
  Result := Left.HasChanges or
            Right.HasChanges or
            Top.HasChanges or
            Bottom.HasChanges or
            DiagonalDown.HasChanges or
            DiagonalUp.HasChanges or
            InsideVertical.HasChanges or
            InsideHorizontal.HasChanges;
end;

procedure TXlsFileCellsRangeLinesEh.Normalize;
begin
  if (DiagonalDown.Style <> clsNoneEh) and
     (DiagonalUp.Style <> clsNoneEh) and
     (DiagonalDown.Style <> DiagonalUp.Style)
  then
  begin
    if (DiagonalDown.Style > DiagonalUp.Style) then
    begin
      DiagonalUp.Style := DiagonalDown.Style;
      DiagonalUp.Color := DiagonalDown.Color;
    end else
    begin
      DiagonalDown.Style := DiagonalUp.Style;
      DiagonalDown.Color := DiagonalUp.Color;
    end;
  end;
end;

{ TXlsFileCellsRangeEh }

constructor TXlsFileCellsRangeEh.Create(Worksheet: TXlsWorksheetEh);
begin
  inherited Create(Worksheet);
end;

destructor TXlsFileCellsRangeEh.Destroy;
begin
  inherited Destroy;
end;

function TXlsFileCellsRangeEh.GetFromCol: Integer;
begin
  Result := FFromCol;
end;

function TXlsFileCellsRangeEh.GetFromRow: Integer;
begin
  Result := FFromRow;
end;

function TXlsFileCellsRangeEh.GetToCol: Integer;
begin
  Result := FToCol;
end;

function TXlsFileCellsRangeEh.GetToRow: Integer;
begin
  Result := FToRow;
end;

procedure TXlsFileCellsRangeEh.ApplyChages;
var
  ic, ir: Integer;
  Cell: TXlsFileCellEh;
begin
  FBorder.Normalize;

  if (FFont.HasChanges or
      FFill.HasChanges or
      FBorder.HasChanges or
      FHorzAlignChanged or
      FVertAlignChanged or
      FWrapTextChanged or
      FRotationChanged or
      FNumberFormatChanged or
      FIndentChanged or
      FCharsFlowDirectionChanged
      ) then
  begin
    for ic := FromCol to ToCol do
    begin
      for ir := FromRow to ToRow do
      begin
        Cell := FWorksheet.Cells[ic, ir];
        UpdateStyleFromChangedRange(Cell, ic, ir);
      end;
    end;
  end;
end;

procedure TXlsFileCellsRangeEh.UpdateStyleFromChangedRange(Cell: TXlsFileCellEh; ACol, ARow: Integer);
var
  NewNumberFormat: TXlsFileStyleNumberFormatEh;
  NewFont: TXlsFileStyleFont;
  NewFill: TXlsFileStyleFill;
  NewBorder: TXlsFileStyleLinesEh;
  NewHorzAlign: TXlsFileCellHorzAlign;
  NewVertAlign: TXlsFileCellVertAlign;
  NewWrapText: Boolean;
  NewRotation: Integer;
  NewIndent: Integer;
  NewCharsFlowDirection: TXlsFileCharsFlowDirectionEh;
begin
  NewNumberFormat := GetNewNumberFormat(Cell);

  NewFont := GetNewFont(Cell);
  NewFill := GetNewFill(Cell);
  NewBorder := GetNewBorder(Cell, ACol = FromCol, ACol = ToCol, ARow = FromRow, ARow = ToRow);

  if (FHorzAlignChanged)
    then NewHorzAlign := HorzAlign
    else NewHorzAlign := Cell.Style.HorzAlign;

  if (FVertAlignChanged)
    then NewVertAlign := VertAlign
    else NewVertAlign := Cell.Style.VertAlign;

  if (FWrapTextChanged)
    then NewWrapText := WrapText
    else NewWrapText := Cell.Style.WrapText;

  if (FRotationChanged)
    then NewRotation := Rotation
    else NewRotation := Cell.Style.Rotation;

  if (FIndentChanged)
    then NewIndent := Indent
    else NewIndent := Cell.Style.Indent;

  if (FCharsFlowDirectionChanged)
    then NewCharsFlowDirection := CharsFlowDirection
    else NewCharsFlowDirection := Cell.Style.CharsFlowDirection;

  Cell.FStyle := GetNewStyle(NewNumberFormat, NewFont, NewFill, NewBorder,
    NewHorzAlign, NewVertAlign, NewWrapText, NewRotation, NewIndent, NewCharsFlowDirection);
end;

function TXlsFileCellsRangeEh.GetNewNumberFormat(Cell: TXlsFileCellEh): TXlsFileStyleNumberFormatEh;
var
  FormatStr: String;
begin

  if (FNumberFormatChanged) then
  begin
    FormatStr := NumberFormat;
  end else
  begin
    FormatStr := Cell.Style.NumberFormat.FormatStr;
  end;

  Result := FWorksheet.FWorkbook.Styles.GetOrCreateNumberFormat(FormatStr);
end;

function TXlsFileCellsRangeEh.GetNewFont(Cell: TXlsFileCellEh): TXlsFileStyleFont;
var
  FontName: String;
  FontSize: Integer;
  FontColor: TColor;
  FontIsBold: Boolean;
  FontIsItalic: Boolean;
  FontIsUnderline: Boolean;
begin
  if Font.FNameChanged
    then FontName := Font.Name
    else FontName := Cell.Style.Font.Name;

  if Font.FSizeChanged
    then FontSize := Font.Size
    else FontSize := Cell.Style.Font.Size;

  if Font.FColorChanged
    then FontColor := Font.Color
    else FontColor := Cell.Style.Font.Color;

  if Font.FIsBoldChanged
    then FontIsBold := Font.IsBold
    else FontIsBold := Cell.Style.Font.IsBold;

  if Font.FIsItalicChanged
    then FontIsItalic := Font.IsItalic
    else FontIsItalic := Cell.Style.Font.IsItalic;

  if Font.FIsUnderlineChanged
    then FontIsUnderline := Font.IsUnderline
    else FontIsUnderline := Cell.Style.Font.IsUnderline;

  Result := FWorksheet.FWorkbook.Styles.
    GetOrCreateFont(FontName, FontSize, FontColor, FontIsBold, FontIsItalic, FontIsUnderline);
end;

function TXlsFileCellsRangeEh.GetNewFill(Cell: TXlsFileCellEh): TXlsFileStyleFill;
var
  FillColor: TColor;
  FillPatternColor: TColor;
  FillPatternType: TXlsFileStyleFillPatternTypeEh;
begin
  if (Fill.FColorChanged) then
    FillColor := Fill.Color
  else
    FillColor := Cell.Style.Fill.Color;

  if (Fill.FPatternColorChanged) then
    FillPatternColor := Fill.PatternColor
  else
    FillPatternColor := Cell.Style.Fill.PatternColor;

  if (Fill.FPatternTypeChanged) then
    FillPatternType := Fill.PatternType
  else
    FillPatternType := Cell.Style.Fill.PatternType;

  Result := FWorksheet.FWorkbook.Styles.GetOrCreateFill(FillColor, FillPatternColor, FillPatternType);
end;

function TXlsFileCellsRangeEh.GetNewBorder(Cell: TXlsFileCellEh;
  UseLeftOutsideBorder, UseRightOutsideBorder,
  UseTopOutsideBorder, UseBottomOutsideBorder: Boolean): TXlsFileStyleLinesEh;
var
  LeftBorderColor: TColor;
  LeftBorderStyle: TXlsFileCellLineStyleEh;
  RightBorderColor: TColor;
  RightBorderStyle: TXlsFileCellLineStyleEh;
  TopBorderColor: TColor;
  TopBorderStyle: TXlsFileCellLineStyleEh;
  BottomBorderColor: TColor;
  BottomBorderStyle: TXlsFileCellLineStyleEh;

  DiagonalDownBorderColor: TColor;
  DiagonalDownBorderStyle: TXlsFileCellLineStyleEh;
  DiagonalUpBorderColor: TColor;
  DiagonalUpBorderStyle: TXlsFileCellLineStyleEh;

begin
  
  if (Border.Left.FColorChanged and UseLeftOutsideBorder) then
    LeftBorderColor := Border.Left.Color
  else if (Border.InsideVertical.FColorChanged and not UseLeftOutsideBorder) then
    LeftBorderColor := Border.InsideVertical.Color
  else
    LeftBorderColor := Cell.Style.Border.Left.Color;

  if (Border.Left.FStyleChanged and UseLeftOutsideBorder) then
    LeftBorderStyle := Border.Left.Style
  else if (Border.InsideVertical.FStyleChanged and not UseLeftOutsideBorder) then
    LeftBorderStyle := Border.InsideVertical.Style
  else
    LeftBorderStyle := Cell.Style.Border.Left.Style;

  
  if (Border.Right.FColorChanged and UseRightOutsideBorder) then
    RightBorderColor := Border.Right.Color
  else if (Border.InsideVertical.FColorChanged and not UseRightOutsideBorder) then
    RightBorderColor := Border.InsideVertical.Color
  else
    RightBorderColor := Cell.Style.Border.Right.Color;

  if (Border.Right.FStyleChanged and UseRightOutsideBorder) then
    RightBorderStyle := Border.Right.Style
  else if (Border.InsideVertical.FStyleChanged and not UseRightOutsideBorder) then
    RightBorderStyle := Border.InsideVertical.Style
  else
    RightBorderStyle := Cell.Style.Border.Right.Style;

  
  if (Border.Top.FColorChanged and UseTopOutsideBorder) then
    TopBorderColor := Border.Top.Color
  else if (Border.InsideHorizontal.FColorChanged and not UseTopOutsideBorder) then
    TopBorderColor := Border.InsideHorizontal.Color
  else
    TopBorderColor := Cell.Style.Border.Top.Color;

  if (Border.Top.FStyleChanged and UseTopOutsideBorder) then
    TopBorderStyle := Border.Top.Style
  else if (Border.InsideHorizontal.FStyleChanged and not UseTopOutsideBorder) then
    TopBorderStyle := Border.InsideHorizontal.Style
  else
    TopBorderStyle := Cell.Style.Border.Top.Style;

  
  if (Border.Bottom.FColorChanged and UseBottomOutsideBorder) then
    BottomBorderColor := Border.Bottom.Color
  else if (Border.InsideHorizontal.FColorChanged and not UseBottomOutsideBorder) then
    BottomBorderColor := Border.InsideHorizontal.Color
  else
    BottomBorderColor := Cell.Style.Border.Bottom.Color;

  if (Border.Bottom.FStyleChanged and UseBottomOutsideBorder) then
    BottomBorderStyle := Border.Bottom.Style
  else if (Border.InsideHorizontal.FStyleChanged and not UseBottomOutsideBorder) then
    BottomBorderStyle := Border.InsideHorizontal.Style
  else
    BottomBorderStyle := Cell.Style.Border.Bottom.Style;

  
  if (Border.DiagonalDown.FColorChanged) then
    DiagonalDownBorderColor := Border.DiagonalDown.Color
  else
    DiagonalDownBorderColor := Cell.Style.Border.DiagonalDown.Color;

  if (Border.DiagonalDown.FStyleChanged) then
    DiagonalDownBorderStyle := Border.DiagonalDown.Style
  else
    DiagonalDownBorderStyle := Cell.Style.Border.DiagonalDown.Style;

  
  if (Border.DiagonalUp.FColorChanged) then
    DiagonalUpBorderColor := Border.DiagonalUp.Color
  else
    DiagonalUpBorderColor := Cell.Style.Border.DiagonalUp.Color;

  if (Border.DiagonalUp.FStyleChanged) then
    DiagonalUpBorderStyle := Border.DiagonalUp.Style
  else
    DiagonalUpBorderStyle := Cell.Style.Border.DiagonalUp.Style;

  Result := FWorksheet.FWorkbook.Styles.GetOrCreateBorder(LeftBorderColor, LeftBorderStyle,
                                                          RightBorderColor, RightBorderStyle,
                                                          TopBorderColor, TopBorderStyle,
                                                          BottomBorderColor, BottomBorderStyle,
                                                          DiagonalDownBorderColor, DiagonalDownBorderStyle,
                                                          DiagonalUpBorderColor, DiagonalUpBorderStyle);
end;

{ TXlsFileColumnsRangeEh }

constructor TXlsFileColumnsRangeEh.Create(Worksheet: TXlsWorksheetEh;
  const ColumnIndexes: array of Integer);
var
  CI: Integer;
begin
  inherited Create(Worksheet);
  SetLength(FColumnIndexes, High(ColumnIndexes) + 1);
  for CI := Low(ColumnIndexes) to High(ColumnIndexes) do
  begin
    FColumnIndexes[CI] := ColumnIndexes[CI];
  end;
end;

destructor TXlsFileColumnsRangeEh.Destroy;
begin
  inherited Destroy;
end;

procedure TXlsFileColumnsRangeEh.ApplyChages;
var
  ic: Integer;
  Col: TXlsFileColumnEh;
begin
  FBorder.Normalize;

  if (FFont.HasChanges or
      FFill.HasChanges or
      FBorder.HasChanges or
      FHorzAlignChanged or
      FVertAlignChanged or
      FWrapTextChanged or
      FRotationChanged or
      FNumberFormatChanged or
      FIndentChanged or
      FCharsFlowDirectionChanged
      ) then
  begin
    for ic := 0 to Length(FColumnIndexes) - 1 do
    begin
      Col := FWorksheet.Columns[FColumnIndexes[ic]];
      UpdateStyleFromChangedRange(Col);
      UpdateCellStylesFromColumnStyle(FColumnIndexes[ic], Col);
    end;
  end;
end;

procedure TXlsFileColumnsRangeEh.UpdateCellStylesFromColumnStyle(ColumnIndex: Integer;
  Column: TXlsFileColumnEh);
var
  RowIdx: Integer;
  CRange: IXlsFileCellsRangeEh;
begin
  if (Column.Style = nil) then Exit;

  for RowIdx := FWorksheet.Dimension.FromRow to FWorksheet.Dimension.ToRow do
  begin
    if (FWorksheet.CellDataExists[ColumnIndex, RowIdx]) then
    begin
      //Cell := FWorksheet.Cells[ColumnIndex, RowIdx];
      CRange := FWorksheet.GetCellsRange(ColumnIndex, RowIdx, ColumnIndex, RowIdx);

      if (Font.FNameChanged) then
        CRange.Font.Name := Font.Name;
      if (Font.FIsUnderlineChanged) then
        CRange.Font.IsUnderline := Font.IsUnderline;
      if (Font.FColorChanged) then
        CRange.Font.Color := Font.Color;
      if (Font.FIsItalicChanged) then
        CRange.Font.IsItalic := Font.IsItalic;
      if (Font.FIsBoldChanged) then
        CRange.Font.IsBold := Font.IsBold;
      if (Font.FSizeChanged) then
        CRange.Font.Size := Font.Size;

      if (FNumberFormatChanged) then
        CRange.NumberFormat := NumberFormat;

      CRange.ApplyChages;
    end;
  end;
end;

procedure TXlsFileColumnsRangeEh.UpdateStyleFromChangedRange(Column: TXlsFileColumnEh);
var
  NewNumberFormat: TXlsFileStyleNumberFormatEh;
  NewFont: TXlsFileStyleFont;
  NewFill: TXlsFileStyleFill;
  NewBorder: TXlsFileStyleLinesEh;
  NewHorzAlign: TXlsFileCellHorzAlign;
  NewVertAlign: TXlsFileCellVertAlign;
  NewWrapText: Boolean;
  NewRotation: Integer;
  NewIndent: Integer;
  NewCharsFlowDirection: TXlsFileCharsFlowDirectionEh;
  NullStyle: TXlsFileCellStyle;
  NewStyle: TXlsFileCellStyle;
begin
  NewNumberFormat := GetNewNumberFormat(Column);
  NullStyle := FWorksheet.FWorkbook.Styles.CellStyle[0];

  NewFont := GetNewFont(Column);
  NewFill := GetNewFill(Column);
  NewBorder := GetNewBorder(Column);

  if (FHorzAlignChanged) then
    NewHorzAlign := HorzAlign
  else if Column.Style = nil then
    NewHorzAlign := NullStyle.HorzAlign
  else
    NewHorzAlign := Column.Style.HorzAlign;

  if (FVertAlignChanged) then
    NewVertAlign := VertAlign
  else if Column.Style = nil then
    NewVertAlign := NullStyle.VertAlign
  else
    NewVertAlign := Column.Style.VertAlign;

  if (FWrapTextChanged) then
    NewWrapText := WrapText
  else if Column.Style = nil then
    NewWrapText := NullStyle.WrapText
  else
    NewWrapText := Column.Style.WrapText;

  if (FRotationChanged) then
    NewRotation := Rotation
  else if Column.Style = nil then
    NewRotation := NullStyle.Rotation
  else
    NewRotation := Column.Style.Rotation;

  if (FIndentChanged) then
    NewIndent := Indent
  else if Column.Style = nil then
    NewIndent := NullStyle.Indent
  else
    NewIndent := Column.Style.Indent;

  if (FCharsFlowDirectionChanged) then
    NewCharsFlowDirection := CharsFlowDirection
  else if Column.Style = nil then
    NewCharsFlowDirection := NullStyle.CharsFlowDirection
  else
    NewCharsFlowDirection := Column.Style.CharsFlowDirection;

  NewStyle := GetNewStyle(NewNumberFormat, NewFont, NewFill, NewBorder,
    NewHorzAlign, NewVertAlign, NewWrapText, NewRotation, NewIndent, NewCharsFlowDirection);

  if NewStyle = NullStyle then
    Column.FStyle := nil
  else
    Column.FStyle := NewStyle;
end;

function TXlsFileColumnsRangeEh.GetNewBorder(AColumn: TXlsFileColumnEh): TXlsFileStyleLinesEh;
var
  LeftBorderColor: TColor;
  LeftBorderStyle: TXlsFileCellLineStyleEh;
  RightBorderColor: TColor;
  RightBorderStyle: TXlsFileCellLineStyleEh;
  TopBorderColor: TColor;
  TopBorderStyle: TXlsFileCellLineStyleEh;
  BottomBorderColor: TColor;
  BottomBorderStyle: TXlsFileCellLineStyleEh;

  DiagonalDownBorderColor: TColor;
  DiagonalDownBorderStyle: TXlsFileCellLineStyleEh;
  DiagonalUpBorderColor: TColor;
  DiagonalUpBorderStyle: TXlsFileCellLineStyleEh;
  NullStyle: TXlsFileCellStyle;

begin
  NullStyle := FWorksheet.FWorkbook.Styles.CellStyle[0];

  
  if (Border.Left.FColorChanged) then
    LeftBorderColor := Border.Left.Color
  else if AColumn.Style = nil then
    LeftBorderColor :=  NullStyle.Border.Left.Color
  else
    LeftBorderColor := AColumn.Style.Border.Left.Color;

  if (Border.Left.FStyleChanged) then
    LeftBorderStyle := Border.Left.Style
  else if AColumn.Style = nil then
    LeftBorderStyle :=  NullStyle.Border.Left.Style
  else
    LeftBorderStyle := AColumn.Style.Border.Left.Style;

  
  if (Border.Right.FColorChanged) then
    RightBorderColor := Border.Right.Color
  else if AColumn.Style = nil then
    RightBorderColor := NullStyle.Border.Right.Color
  else
    RightBorderColor := AColumn.Style.Border.Right.Color;

  if (Border.Right.FStyleChanged) then
    RightBorderStyle := Border.Right.Style
  else if AColumn.Style = nil then
    RightBorderStyle := NullStyle.Border.Right.Style
  else
    RightBorderStyle := AColumn.Style.Border.Right.Style;

  
  if (Border.Top.FColorChanged) then
    TopBorderColor := Border.Top.Color
  else if AColumn.Style = nil then
    TopBorderColor := NullStyle.Border.Top.Color
  else
    TopBorderColor := AColumn.Style.Border.Top.Color;

  if (Border.Top.FStyleChanged) then
    TopBorderStyle := Border.Top.Style
  else if AColumn.Style = nil then
    TopBorderStyle := NullStyle.Border.Top.Style
  else
    TopBorderStyle := AColumn.Style.Border.Top.Style;

  
  if (Border.Bottom.FColorChanged) then
    BottomBorderColor := Border.Bottom.Color
  else if AColumn.Style = nil then
    BottomBorderColor := NullStyle.Border.Bottom.Color
  else
    BottomBorderColor := AColumn.Style.Border.Bottom.Color;

  if (Border.Bottom.FStyleChanged) then
    BottomBorderStyle := Border.Bottom.Style
  else if AColumn.Style = nil then
    BottomBorderStyle := NullStyle.Border.Bottom.Style
  else
    BottomBorderStyle := AColumn.Style.Border.Bottom.Style;

  
  if (Border.DiagonalDown.FColorChanged) then
    DiagonalDownBorderColor := Border.DiagonalDown.Color
  else if AColumn.Style = nil then
    DiagonalDownBorderColor := NullStyle.Border.DiagonalDown.Color
  else
    DiagonalDownBorderColor := AColumn.Style.Border.DiagonalDown.Color;

  if (Border.DiagonalDown.FStyleChanged) then
    DiagonalDownBorderStyle := Border.DiagonalDown.Style
  else if AColumn.Style = nil then
    DiagonalDownBorderStyle := NullStyle.Border.DiagonalDown.Style
  else
    DiagonalDownBorderStyle := AColumn.Style.Border.DiagonalDown.Style;

  
  if (Border.DiagonalUp.FColorChanged) then
    DiagonalUpBorderColor := Border.DiagonalUp.Color
  else if AColumn.Style = nil then
    DiagonalUpBorderColor := NullStyle.Border.DiagonalUp.Color
  else
    DiagonalUpBorderColor := AColumn.Style.Border.DiagonalUp.Color;

  if (Border.DiagonalUp.FStyleChanged) then
    DiagonalUpBorderStyle := Border.DiagonalUp.Style
  else if AColumn.Style = nil then
    DiagonalUpBorderStyle := NullStyle.Border.DiagonalUp.Style
  else
    DiagonalUpBorderStyle := AColumn.Style.Border.DiagonalUp.Style;

  Result := FWorksheet.FWorkbook.Styles.GetOrCreateBorder(LeftBorderColor, LeftBorderStyle,
                                                          RightBorderColor, RightBorderStyle,
                                                          TopBorderColor, TopBorderStyle,
                                                          BottomBorderColor, BottomBorderStyle,
                                                          DiagonalDownBorderColor, DiagonalDownBorderStyle,
                                                          DiagonalUpBorderColor, DiagonalUpBorderStyle);
end;

function TXlsFileColumnsRangeEh.GetNewFill(AColumn: TXlsFileColumnEh): TXlsFileStyleFill;
var
  FillColor: TColor;
  FillPatternColor: TColor;
  FillPatternType: TXlsFileStyleFillPatternTypeEh;
  NullStyle: TXlsFileCellStyle;
begin
  NullStyle := FWorksheet.FWorkbook.Styles.CellStyle[0];

  if (Fill.FColorChanged) then
    FillColor := Fill.Color
  else if AColumn.Style = nil then
    FillColor := NullStyle.Fill.Color
  else
    FillColor := AColumn.Style.Fill.Color;

  if (Fill.FPatternColorChanged) then
    FillPatternColor := Fill.PatternColor
  else if AColumn.Style = nil then
    FillPatternColor := NullStyle.Fill.PatternColor
  else
    FillPatternColor := AColumn.Style.Fill.PatternColor;

  if (Fill.FPatternTypeChanged) then
    FillPatternType := Fill.PatternType
  else if AColumn.Style = nil then
    FillPatternType := NullStyle.Fill.PatternType
  else
    FillPatternType := AColumn.Style.Fill.PatternType;

  Result := FWorksheet.FWorkbook.Styles.GetOrCreateFill(FillColor, FillPatternColor, FillPatternType);
end;

function TXlsFileColumnsRangeEh.GetNewFont(AColumn: TXlsFileColumnEh): TXlsFileStyleFont;
var
  FontName: String;
  FontSize: Integer;
  FontColor: TColor;
  FontIsBold: Boolean;
  FontIsItalic: Boolean;
  FontIsUnderline: Boolean;
  NullStyle: TXlsFileCellStyle;
begin
  NullStyle := FWorksheet.FWorkbook.Styles.CellStyle[0];

  if Font.FNameChanged then
    FontName := Font.Name
  else if AColumn.Style = nil then
    FontName := NullStyle.Font.Name
  else
    FontName := AColumn.Style.Font.Name;

  if Font.FSizeChanged then
    FontSize := Font.Size
  else if AColumn.Style = nil then
    FontSize := NullStyle.Font.Size
  else
    FontSize := AColumn.Style.Font.Size;

  if Font.FColorChanged then
    FontColor := Font.Color
  else if AColumn.Style = nil then
    FontColor := NullStyle.Font.Color
  else
    FontColor := AColumn.Style.Font.Color;

  if Font.FIsBoldChanged then
    FontIsBold := Font.IsBold
  else if AColumn.Style = nil then
    FontIsBold := NullStyle.Font.IsBold
  else
    FontIsBold := AColumn.Style.Font.IsBold;

  if Font.FIsItalicChanged then
    FontIsItalic := Font.IsItalic
  else if AColumn.Style = nil then
    FontIsItalic := NullStyle.Font.IsItalic
  else
    FontIsItalic := AColumn.Style.Font.IsItalic;

  if Font.FIsUnderlineChanged then
    FontIsUnderline := Font.IsUnderline
  else if AColumn.Style = nil then
    FontIsUnderline := NullStyle.Font.IsUnderline
  else
    FontIsUnderline := AColumn.Style.Font.IsUnderline;

  Result := FWorksheet.FWorkbook.Styles.
    GetOrCreateFont(FontName, FontSize, FontColor, FontIsBold, FontIsItalic, FontIsUnderline);
end;

function TXlsFileColumnsRangeEh.GetNewNumberFormat(
  AColumn: TXlsFileColumnEh): TXlsFileStyleNumberFormatEh;
var
  FormatStr: String;
begin

  if (FNumberFormatChanged) then
  begin
    FormatStr := NumberFormat;
  end else if AColumn.Style = nil then
  begin
    FormatStr := FWorksheet.FWorkbook.Styles.CellStyle[0].NumberFormat.FormatStr;
  end else
  begin
    FormatStr := AColumn.Style.NumberFormat.FormatStr;
  end;

  Result := FWorksheet.FWorkbook.Styles.GetOrCreateNumberFormat(FormatStr);
end;

{ TXlsFileStyleLinesEh }

constructor TXlsFileStyleLinesEh.Create;
begin
  FRight := TXlsFileStyleLineEh.Create;
  FBottom := TXlsFileStyleLineEh.Create;
  FTop := TXlsFileStyleLineEh.Create;
  FLeft := TXlsFileStyleLineEh.Create;
  FDiagonalDown := TXlsFileStyleLineEh.Create;
  FDiagonalUp := TXlsFileStyleLineEh.Create;
end;

destructor TXlsFileStyleLinesEh.Destroy;
begin
  FreeAndNil(FRight);
  FreeAndNil(FBottom);
  FreeAndNil(FTop);
  FreeAndNil(FLeft);
  FreeAndNil(FDiagonalDown);
  FreeAndNil(FDiagonalUp);
  inherited Destroy;
end;

{ TXlsFileWorksheetCellsRangeEh }

constructor TXlsFileWorksheetCellsRectEh.Create(Worksheet: TXlsWorksheetEh);
begin
  FWorksheet := Worksheet;
end;

destructor TXlsFileWorksheetCellsRectEh.Destroy;
begin
  inherited Destroy;
end;

function TXlsFileWorksheetCellsRectEh.IsEmpty: Boolean;
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

procedure TXlsFileWorksheetCellsRectEh.Clear;
begin
  FFromCol := 0;
  FToCol := 0;
  FFromRow := 0;
  FToRow := 0;
end;

{ TXlsFileWorksheetPrintParamsEh }

constructor TXlsFileWorksheetPrintParamsEh.Create(AWorksheet: TXlsWorksheetEh);
begin
  inherited Create;
  FWorksheet := AWorksheet;
  FPageMargins := TXlsFileWorksheetPrintPageMarginsEh.Create;
  FScale := 100;
  FFitToPagesWide := 0;
  FFitToPagesTall := 0;
  FScalingMode := fpsmAdjustToScaleEh;
end;

destructor TXlsFileWorksheetPrintParamsEh.Destroy;
begin
  FreeAndNil(FPageMargins);
  inherited Destroy;
end;

procedure TXlsFileWorksheetPrintParamsEh.SetPageMargins(const Value: TXlsFileWorksheetPrintPageMarginsEh);
begin
  FPageMargins.Assign(Value);
end;

{ TXlsFileWorksheetPrintPageMarginsEh }

constructor TXlsFileWorksheetPrintPageMarginsEh.Create;
begin
  FLeft := 0.7;
  FRight := 0.7;
  FTop := 0.75;
  FBottom := 0.75;
  FHeader := 0.3;
  FFooter := 0.3;
end;

destructor TXlsFileWorksheetPrintPageMarginsEh.Destroy;
begin
  inherited Destroy;
end;

end.
