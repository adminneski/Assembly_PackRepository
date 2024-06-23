
{******************************************}
{                                          }
{             FastReport VCL               }
{            PDF export filter             }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxExportPDFHelpers;

interface

{$I frx.inc}

uses
{$IFNDEF Linux}
  Windows,
{$ELSE}
  LCLType, LCLIntf, LCLProc,
{$ENDIF}
  Graphics, Classes, SysUtils, frxRC4, frxTrueTypeCollection, Contnrs, frBaseGraphicsTypes, frPictureGraphics,
{$IFNDEF FPC}frxEMFAbstractExport, {$ENDIF}
  frxClass,
{$IFNDEF FPC}frxEMFFormat, {$ENDIF}
{$IFDEF FPC}LazHelper, {$ENDIF}
  frxUtils,
{$IFDEF DELPHI12}
  AnsiStrings,
{$ENDIF}
{$IFDEF DELPHI16}
  System.UITypes,
{$ENDIF}
  frxAnaliticGeometry, frxExportHelpers, frxHelpers,
{$IFDEF Linux}
  types,  Messages, Controls, Forms, Dialogs, Process,
  Variants,  StdCtrls, Db, DBCtrls, Buttons, ExtCtrls, Menus, ComCtrls, lmessages, frxStorage, frxLinuxFonts,
{$ENDIF}
  frCoreClasses;

type
  TfrxPDFFont = class(TfrxExportFont)
  private
    FColor: TColor;
    FFontName: AnsiString;
    FSize: Extended;
  protected
//    Index: Integer;
    FSaved: Boolean;

    procedure FillOutlineTextMetrix();
  public
    Name: AnsiString;
    Reference: Longint;

    constructor Create(Font: TFont);
    procedure Save(AReference: Longint);
    procedure PackTTFFont;
    function GetFontName: AnsiString;
    function SpaceAdjustment(RS: TRemapedString; TextWidth, FontSize: Extended): Extended;
    function FontHeightToPointSizeFactor: Double;
    {$IFDEF Linux}
    function GetFontDataSize(): Longint; Override;
    {$ENDIF}
    procedure Update(const SourcePDFFont: TfrxPDFFont; const SourceFont: TFont);
    property FontName: AnsiString read FFontName write FFontName;
    property Size: Extended read FSize write FSize;
    property Color: TColor read FColor write FColor;
    property Saved: Boolean read FSaved;
  end;

  TfrxPDFXObjectHash = array[0..15] of Byte; // MD5
  TfrxPDFXObjectArray = class
  private
    FCount: Integer;
    FObjId: array of Integer; // id that appears in 'id 0 R'
    FHash: array of TfrxPDFXObjectHash;

    function GetId(Index: Integer): Integer;
  protected
    procedure SureIndex(Index: Integer);
  public
    constructor Create;
    function Add(AId: Integer; const Hash: TfrxPDFXObjectHash): Integer;
    procedure Clear;
    function Find(const Hash: TfrxPDFXObjectHash): Integer;

    property Id[Index: Integer]: Integer read GetId;
    property Count: Integer read FCount;
  end;

  TCrossReferenceSubsection = record
    Start: Boolean;
    Length: Integer; // number of entries
  end;

  TReferenceArray = class
  private
    FCount: Integer;
    FData: array of Integer;
    function GetRef(Index: Integer): string;
    function GetNo(Index: Integer): Integer;
  public
    constructor Create;
    function Add(ObjNo: Integer): Integer; // Return Index
    procedure WriteAsArray(Stream: TStream; Caption: string);
    procedure Clear;

    property Count: Integer read FCount;
    property Ref[Index: Integer]: string read GetRef;
    property No[Index: Integer]: Integer read GetNo;
  end;

  TPageByPageReferenceArray = class
  private
    FData: array of TReferenceArray;
    FContents: array of Integer;
    function GetData(Index: Integer): TReferenceArray;
    procedure SetData(Index: Integer; const Value: TReferenceArray);
    function GetContents(Index: Integer): Integer;
    procedure SetContents(Index: Integer; const Value: Integer);
  protected
    procedure SureIndex(Index: Integer);
  public
    constructor Create;
    destructor Destroy; override;

    property Data[Index: Integer]: TReferenceArray read GetData write SetData; default;
    property Contents[Index: Integer]: Integer read GetContents write SetContents;
  end;

  TCrossReferenceSection = class (TfrOwnObjList)
  private
    FSingleCharacterEOL: Boolean;
    FSectionOffset: Integer;
    FNextId: Integer;
  protected
    function IndexOfId(Id: Integer): Integer;
  public
    constructor Create(ASingleCharacterEOL: Boolean = False);
    procedure Clear; override;
    procedure Init;
    procedure AddId(Id: Integer; Offset: Integer = 0);
    function AddNext(Offset: Integer = 0): Integer; // Return Id
    procedure SetOffset(Id: Integer; Offset: Integer);

    procedure PrepareToOut;
    function IsSubsection(Index: Integer; out SubsectionStr: string): Boolean;
    function OutLine(Index: Integer): string;

    property NextId: Integer read FNextId write FNextId;
    property SectionOffset: Integer write FSectionOffset;
  end;

  TPDFGLobalFonts = class(TfrOwnObjList)
  protected
    function Get(Index: Integer): TfrxPDFFont;
  public
    function AddFont(const Font: TFont; const OSFontName: String): Integer;
    function IndexOfFont(Name: String; Style: TFontStyles): Integer;
    function IndexByReference(No: Integer): Integer;

    property Items[Index: Integer]: TfrxPDFFont read Get; default;
  end;

  TPDFObjectsHelper = class
  private
    FFonts: TPDFGLobalFonts;
    FAcroFonts: TList;
    FBBoxFonts: TList;
    FPageFonts: TReferenceArray; // Fonts' ids used within the current page
    FPatterns: TReferenceArray;
    FCRS: TCrossReferenceSection;
    FpdfStream: TStream;
    FProtection: boolean;
    FEncKey: AnsiString;
    FEmbedded: boolean;
    FQuality: Integer;
    FXObjects: TfrxPDFXObjectArray;
    FPageXObjects: TReferenceArray; // XObjects' ids used within the current page
    FIsBBoxReleative: Boolean;
    FLastRequestedXRef: Integer;
    FGraphicHelper: TfrxCustomGraphicFormatClass;
    function GetAcroFonts(Index: integer): TfrxPDFFont;
    function GetAcroFontsCount: integer;
    function GetBBoxFonts(Index: integer): TfrxPDFFont;
    function GetBBoxFontsCount: Integer;
    function GetLastObjectXRefID: Integer;
  protected
    function GetOSFontName(const Font: TFont): String;
    function IsFontNameAndStyle(const Font: TFont; Name: String; Style: TFontStyles): Boolean;
    function GetGlobalFont(const Font: TFont; const OSFontName: String): TfrxPDFFont;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function GetAcroFont(const Font: TFont): TfrxPDFFont;
    function GetObjFontNumber(const Font: TFont): integer; // Returns the index in the FFonts, if absent, then first adds

    procedure OutPageFonts;
    procedure OutPagePatterns;
    function FindXObject(const Hash: TfrxPDFXObjectHash): Integer;
    function OutPattern(PicIndex, Width, Height: Integer): Integer;
    function OutXObjectImage(XObjectHash: TfrxPDFXObjectHash;
      Image: TGraphic; XObjectStream: TStream;
      IsTransparent: Boolean = False; MaskId: Integer = 0): Integer;
    function OutTransparentGraphic(Graphic: TGraphic): Integer; // map images
    function UpdateXRef: Integer;
    procedure StartBBox;
    procedure EndBBox;

    property AcroFonts[Index: integer]: TfrxPDFFont read GetAcroFonts;
    property AcroFontsCount: integer read GetAcroFontsCount;
    property BBoxFonts[Index: integer]: TfrxPDFFont read GetBBoxFonts;
    property BBoxFontsCount: Integer read GetBBoxFontsCount;

    property Fonts: TPDFGLobalFonts read FFonts write FFonts;

    property XObjects: TfrxPDFXObjectArray read FXObjects write FXObjects;
    property PageXObjects: TReferenceArray read FPageXObjects write FPageXObjects;
    property PageFonts: TReferenceArray read FPageFonts write FPageFonts;
    property Patterns: TReferenceArray read FPatterns write FPatterns;
    property pdfStream: TStream write FpdfStream;
    property CRS: TCrossReferenceSection read FCRS;
    property LastObjectXRefID: Integer read GetLastObjectXRefID;
    property Protection: boolean write FProtection;
    property EncKey: AnsiString write FEncKey;
    property EmbeddedFonts: Boolean read FEmbedded write FEmbedded default False;
    property IsBBox: Boolean read FIsBBoxReleative;
    property Quality: Integer read FQuality write FQuality;
  end;

function IsNeedsItalicSimulation(Font: TFont; out Simulation: String): Boolean;
function IsNeedsBoldSimulation(Font: TFont; out Simulation: String): Boolean;

procedure AddStyleSimulation(FontName: String; FontStyles: TFontStyles);
procedure DeleteStyleSimulation(FontName: String);

function StrToHex(const Value: WideString): AnsiString;
function StrToHexSp(const Value: WideString; SpaceAdjustment: Extended): AnsiString;
function StrToHexDx(const RS: TRemapedString; pdfDX: TDoubleArray; AverageDx: Boolean): AnsiString;

function Color2Str(Color: TColor): String;
function frxRect2Str(DR: TfrxRect; const Prec: Integer = DefaultPrec): String;

function frxPointSum(P1, P2: TfrxPoint): TfrxPoint;
function frxPointMult(P: TfrxPoint; Factor: Extended): TfrxPoint;

procedure GetStreamHash(out Hash: TfrxPDFXObjectHash; S: TStream);
function ObjNumberRef(FNumber: longint): String;
function ObjNumber(FNumber: longint): String;
function PrepXRefPos(Index: Integer): String;
function CryptStream(Source: TStream; Target: TStream; Key: AnsiString; id: Integer): AnsiString;

procedure Write(Stream: TStream; const S: AnsiString);{$IFDEF DELPHI12} overload;
procedure Write(Stream: TStream; const S: String); overload; {$ENDIF}
procedure WriteLn(Stream: TStream; const S: AnsiString);{$IFDEF DELPHI12} overload;
procedure WriteLn(Stream: TStream; const S: String); overload; {$ENDIF}

type
  TMaskArray = array of byte;
function BitmapPixelSize(Bitmap: TBitmap): Integer;
function CreateBitmap(PixelFormat: TPixelFormat; SizeBitmap: TBitmap): TBitmap; overload;
function CreateBitmap(PixelFormat: TPixelFormat; Width, Height: Integer): TBitmap; overload;
function CreateBitmap(PixelFormat: TPixelFormat; Size: TPoint): TBitmap; overload;
procedure CreateMask(Bitmap: TBitmap; var Mask: TMaskArray);
procedure SaveMask(pdf, XObjectStream: TStream; MaskBytes: TMaskArray;
  FPOH: TPDFObjectsHelper; TempBitmap: TBitmap; FProtection: Boolean; FEncKey: AnsiString;
  out XObjectHash: TfrxPDFXObjectHash; out XMaskId, PicIndex: Integer);

const
  PDF_DIVIDER = 0.75;

type
  TfrxShapeKindSet = set of TfrxShapeKind;

function IsShape(Obj: TfrxView; ShapeKindSet: TfrxShapeKindSet): boolean;
function Is2DShape(Obj: TfrxView): boolean;

type
  TViewSizes = record l, t, w, h, r, b: Extended; end;

function ShadowlessSizes(Obj: TfrxView): TViewSizes;

type
  TRGBAWord = packed record
    Blue: Byte;
    Green: Byte;
    Red: Byte;
    Alpha: Byte;
  end;

  PRGBAWord = ^TRGBAWordArray;
  TRGBAWordArray = array[0..4095] of TRGBAWord;

  TPDFStandard =
    (psNone, psPDFA_1a, psPDFA_1b, psPDFA_2a, psPDFA_2b, psPDFA_3a, psPDFA_3b);
  TPDFVersion =
    (pv14, pv15, pv16, pv17);

const
  PDFStandardName: array[TPDFStandard] of string =
    ('None', 'PDF/A-1a', 'PDF/A-1b', 'PDF/A-2a', 'PDF/A-2b', 'PDF/A-3a', 'PDF/A-3b');
  PDFPartName: array[TPDFStandard] of string =
    (    '',       '1',        '1',         '2',       '2',         '3',       '3');
  PDFConformanceName: array[TPDFStandard] of string =
    (    '',       'A',        'B',         'A',       'B',         'A',       'B');
  PDFVersionName: array[TPDFVersion] of string =
    ('1.4', '1.5', '1.6', '1.7');

function PDFStandardByName(StandardName: string): TPDFStandard;
function PDFVersionByName(VersionName: string): TPDFVersion;
function IsPDFA(ps: TPDFStandard): Boolean;
function IsPDFA_1(ps: TPDFStandard): Boolean;
function IsVersionByStandard(ps: TPDFStandard; var pv: TPDFVersion): Boolean;

function PDFFontSize(Font: TFont): Extended;
function EMFPDFFontSize(Font: TFont): Extended;
//function IsMonospaced(FontName: string): Boolean;
procedure StretchFont(FontName: TFontName; FontSize: Integer; Factor: Double); overload; // Monospaced Font
procedure StretchFont(FontName: TFontName; Factor: Single); overload; // Proportionsl Font (for EMF)
procedure ClearStretchedFont(FontName: TFontName);
procedure DisableTpPtCorrection;
procedure EnableTpPtCorrection;

type
  TInt64List = class
  private
    function GetItem(Index: integer): Int64;
    procedure Setitem(Index: integer; const Value: Int64);
    function GetCount: Integer;
  protected
    FObjectList: TObjectList;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Add(Value: Int64);
    procedure Clear;

    property Items[Index: integer]: Int64 read GetItem write Setitem; default;
    property Count: Integer read GetCount;
  end;

const
  tpPt = 0.254 / 72; // typography pt
  UnderlineShift = -0.12;
  StrikeOutShift = 0.28;
  UnderlineWidth = 0.08;
  StrikeOutWidth = UnderlineWidth / 1.4142;

function ResizeBitmap32(Source: TBitmap; Size: TPoint): TBitmap;

implementation

uses
  Math,
  frUtils,
  frxTrueTypeFont, frxCrypto, frHashUtils;

var
  tpPtCorrection: Boolean;

type
  TPDFFontSimulation = class
  private
    FName: String;
    FFontStyles: TFontStyles;
  public
    constructor Create(Name: String; FontStyles: TFontStyles);
    procedure AddStyles(FontStyles: TFontStyles);
    function IsName(Name: String): Boolean;
    function IsStyle(FontStyle: TFontStyle): Boolean;
  end;

  TPDFFontSimulationList = class(TObjectList)
  protected
    procedure DeleteFont(Name: String);
    function Find(Name: String): TPDFFontSimulation;
    function IsNeedsStyle(Name: String; FontStyle: TFontStyle): Boolean;
  public
    procedure AddFont(Name: String; FontStyles: TFontStyles);

    function IsNeedsBold(Name: String): Boolean;
    function IsNeedsItalic(Name: String): Boolean;
  end;

// list of fonts that do not have bold-italic versions and needs to be simulated
var
  PDFFontSimulationList: TPDFFontSimulationList;

type
  TPDFFontCorrection = class
  private
    function GetCorrection(Index: Integer): Double;
    procedure SetCorrection(Index: Integer; const Value: Double);
  protected
    FCorrection: array [0..64] of Double;
  public
    constructor Create;
    property Correction[Index: Integer]: Double read GetCorrection write SetCorrection;
  end;

  TPDFMonospacedFontCorrectionList = class(TStringList)
  protected
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddCorrection(FontName: TFontName; FontSize: Integer; Factor: Double);
    procedure DeleteCorrection(FontName: TFontName);
    function GetCorrection(FontName: TFontName; FontSize: Integer): Double;
  end;

var
  PDFMonospacedFontCorrectionList: TPDFMonospacedFontCorrectionList;

type
  TEMFPDFontCorrection = class
  protected
    FCorrection: Single;
  public
    property Correction: Single read FCorrection write FCorrection;
  end;

  TEMFPDFFontCorrectionList = class(TStringList)
  protected
  public
    constructor Create;
    destructor Destroy; override;
    procedure AddCorrection(FontName: TFontName; Factor: Single);
    procedure DeleteCorrection(FontName: TFontName);
    function IsGetCorrection(FontName: TFontName; out Corr: Single): Boolean;
  end;

var
  EMFPDFFontCorrectionList: TEMFPDFFontCorrectionList;

type
  TCrossReferenceEntry = class
  private
    FId: Integer;
    FOffset: Integer;
    FSubsection: TCrossReferenceSubsection;
    FGenerationNumber: Integer;
    FFreeEntry: Boolean;
  public
    constructor Create(AId, AOffset: Integer; AFreeEntry: Boolean = False; AGenerationNumber: Integer = 0);
    procedure CombiteSubsections(NextEntry: TCrossReferenceEntry);
    function SubsectionStr: string;
    function EntryStr(SingleCharacterEOL: Boolean = False): string;

    property Id: Integer read FId;
    property Offset: Integer read FOffset write FOffset;
    property Subsection: TCrossReferenceSubsection read FSubsection;
    property GenerationNumber: Integer read FGenerationNumber;
    property FreeEntry: Boolean read FFreeEntry;
  end;

{ Utility routines }

function CreateResize(Size: TPoint; Source: TBitmap): TBitmap;
{$IFNDEF Linux}
var
  PrevPt: TPoint;
{$ENDIF}
begin
  Result := CreateBitmap(Source.PixelFormat, Size);
  Result.Transparent := Source.Transparent;
  {$IFNDEF Linux}
  GetBrushOrgEx(Result.Canvas.Handle, PrevPt);
  {$ENDIF}
  SetStretchBltMode(Result.Canvas.Handle, HALFTONE);
  {$IFNDEF Linux}
  SetBrushOrgEx(Result.Canvas.Handle, PrevPt.x, PrevPt.y, @PrevPt);
  {$ENDIF}
  StretchBlt(Result.Canvas.Handle, 0, 0, Result.Width, Result.Height,
             Source.Canvas.Handle, 0, 0, Source.Width, Source.Height,
             SRCCOPY);
end;

function GrayPalette256: HPalette;
var
  i: integer;
  lp:  TMaxLogPalette;
begin
  lp.palVersion    := $300;
  lp.palNumEntries := 256;
  for i := 0 TO 255 do
    with lp.palPalEntry[i] do
    begin
     peRed   := i;
     peGreen := i;
     peBlue  := i;
     {$IFNDEF Linux}
     peFlags := PC_RESERVED;
     {$ENDIF}
   end;
   Result := CreatePalette(pLogPalette(@lp)^);
end;

function ResizeBitmap32(Source: TBitmap; Size: TPoint): TBitmap;
var
  w, h: Integer;
  SourceAlpha, ResultAlpha: TBitmap;
  P4: PRGBQuad;
  P1: PByte;
begin
  Result := nil;
  if Source.PixelFormat <> pf32bit then
    Exit;

  SourceAlpha := CreateBitmap(pf8bit, Source);
  SourceAlpha.Palette := GrayPalette256;
  for h := 0 to Source.Height - 1 do
  begin
    P4 := Source.ScanLine[h];
    P1 := SourceAlpha.ScanLine[h];
    for w := 0 to Source.Width - 1 do
    begin
      P1^ := P4^.rgbReserved;
      Inc(P4);
      Inc(P1);
    end;
  end;

  ResultAlpha := CreateResize(Size, SourceAlpha);
  ResultAlpha.Palette := GrayPalette256;
  SourceAlpha.Free;

  Result := CreateResize(Size, Source);
  {$IFDEF Delphi16}
  Result.AlphaFormat := Source.AlphaFormat;
  {$ENDIF}
  for h := 0 to Result.Height - 1 do
  begin
    P4 := Result.ScanLine[h];
    P1 := ResultAlpha.ScanLine[h];
    for w := 0 to Result.Width - 1 do
    begin
      P4^.rgbReserved := P1^;
      Inc(P4);
      Inc(P1);
    end;
  end;
  ResultAlpha.Free;
end;

//function EnumFontsProc(var EnumLogFont: TEnumLogFont;
//  var TextMetric: TNewTextMetric; FontType: Integer;
//  Data: LPARAM): Integer; export; stdcall;
//begin
//  Result := Integer((EnumLogFont.elfLogFont.lfPitchAndFamily and FIXED_PITCH) = FIXED_PITCH);
//end;
//
//function IsMonospaced(FontName: string): Boolean;
//var
//  DC : HDC;
//begin;
//  DC:=GetDC(0);
//  try
//    Result := EnumFontFamilies(DC, PChar(FontName), @EnumFontsProc, 0); //EnumFontFamilies return Integer, but Result is Boolean
//  finally
//    ReleaseDC(0, DC);
//  end;
//end;

function IfMonospacedFontCorrected(Font: TFont; out Corr: Extended): Boolean;
begin
  Corr := PDFMonospacedFontCorrectionList.GetCorrection(Font.Name, Font.Size);
  Result := Corr <> 1.0;
end;

function IfEMFFontCorrected(Font: TFont; out Corr: Single): Boolean;
begin
  Result := EMFPDFFontCorrectionList.IsGetCorrection(Font.Name, Corr);
end;

procedure DisableTpPtCorrection;
begin
  tpPtCorrection := False;
end;

procedure EnableTpPtCorrection;
begin
  tpPtCorrection := True;;
end;

procedure StretchFont(FontName: TFontName; FontSize: Integer; Factor: Double);
begin
  PDFMonospacedFontCorrectionList.AddCorrection(FontName, FontSize, Factor);
end;

procedure StretchFont(FontName: TFontName; Factor: Single);
begin
  EMFPDFFontCorrectionList.AddCorrection(FontName, Factor);
end;

procedure ClearStretchedFont(FontName: TFontName);
begin
  PDFMonospacedFontCorrectionList.DeleteCorrection(FontName);
  EMFPDFFontCorrectionList.DeleteCorrection(FontName);
end;

function PDFFontSize(Font: TFont): Extended;
var
  Corr: Extended;
begin
  if      IfMonospacedFontCorrected(Font, Corr) then
    Result := Round((Font.Size * (1 - tpPt) * Corr) * 1000) / 1000
  else if tpPtCorrection then
    Result := Trunc(Font.Size * (1 - tpPt) * 10) / 10
  else
    Result := Font.Size;
end;

function EMFPDFFontSize(Font: TFont): Extended;
var
  Corr: Single;
begin
  if IfEMFFontCorrected(Font, Corr) then
    Result := Font.Size * Corr
  else if tpPtCorrection then
    Result := Trunc(Font.Size * (1 - tpPt) * 10) / 10
  else
    Result := Font.Size;
end;

function CreateBitmap(PixelFormat: TPixelFormat; Size: TPoint): TBitmap;
begin
  Result := TBitmap.Create;
  Result.PixelFormat := PixelFormat;
  Result.Width := Size.X;
  Result.Height := Size.Y;
end;

function CreateBitmap(PixelFormat: TPixelFormat; Width, Height: Integer): TBitmap;
begin
  Result := TBitmap.Create;
  Result.PixelFormat := PixelFormat;
  Result.Width := Width;
  Result.Height := Height;
end;

function CreateBitmap(PixelFormat: TPixelFormat; SizeBitmap: TBitmap): TBitmap;
begin
  Result := CreateBitmap(PixelFormat, SizeBitmap.Width, SizeBitmap.Height);
end;

function BitmapPixelSize(Bitmap: TBitmap): Integer;
begin
  Result := Bitmap.Width * Bitmap.Height;
end;

procedure SaveMask(pdf, XObjectStream: TStream; MaskBytes: TMaskArray;
  FPOH: TPDFObjectsHelper; TempBitmap: TBitmap; FProtection: Boolean; FEncKey: AnsiString;
  out XObjectHash: TfrxPDFXObjectHash; out XMaskId, PicIndex: Integer);
var
  MaskIndex, MaskSize: Integer;
  XMaskStream: TStream;
  XMaskHash: TfrxPDFXObjectHash;
begin
  XMaskStream := TMemoryStream.Create;
  try
    XMaskStream.Position := 0;
    MaskSize := BitmapPixelSize(TempBitmap);
    XMaskStream.Write(Pointer(MaskBytes)^, MaskSize);

    XMaskStream.Position := 0;
    GetStreamHash(XMaskHash, XMaskStream);
    MaskIndex := FPOH.FindXObject(XMaskHash);

    if MaskIndex < 0 then
    begin
      XMaskId := FPOH.UpdateXRef;
      FPOH.XObjects.Add(XMaskId, XMaskHash);
      WriteLn(pdf, ObjNumber(XMaskId));

      WriteLn(pdf, '<< /Type /XObject');
      WriteLn(pdf, '/Subtype /Image');
      WriteLn(pdf, '/Width ' + IntToStr(TempBitmap.Width));
      WriteLn(pdf, '/Height ' + IntToStr(TempBitmap.Height));
      WriteLn(pdf, '/ColorSpace /DeviceGray/Matte[ 0 0 0] ');
      WriteLn(pdf, '/BitsPerComponent 8');
      WriteLn(pdf, '/Interpolate false');

      /// ///////  NEED TO REPLACE

      WriteLn(pdf, ' /Length ' + IntToStr(MaskSize) + ' >>');
      WriteLn(pdf, 'stream');
      if FProtection then
        CryptStream(XMaskStream, pdf, FEncKey, XMaskId)
      else
        pdf.CopyFrom(XMaskStream, 0);

      Write(pdf, #13#10'endstream'#13#10);
      WriteLn(pdf, 'endobj');
    end
    else
      XMaskId := FPOH.XObjects.Id[MaskIndex];
    { hash should be calculated for Pic + Mask }
    XMaskStream.Position := XMaskStream.Size;
    XObjectStream.Position := 0;
    XMaskStream.CopyFrom(XObjectStream, 0);
    XMaskStream.Position := 0;
    XObjectStream.Position := 0;
    GetStreamHash(XObjectHash, XMaskStream);
    PicIndex := FPOH.FindXObject(XObjectHash);
  finally
    XMaskStream.Free;
  end;
end;

procedure CreateMask(Bitmap: TBitmap; var Mask: TMaskArray);
var
  Ix, Iy: Integer;
  dots: PRGBAWord;
begin
  SetLength(Mask, BitmapPixelSize(Bitmap));
  for Iy := 0 to Bitmap.Height - 1 do
  begin
    dots := Bitmap.ScanLine[Iy];
    for Ix := 0 to Bitmap.Width - 1 do
      Mask[Ix + Iy * Bitmap.Width] := dots[Ix].Alpha;
  end;
end;

function IsVersionByStandard(ps: TPDFStandard; var pv: TPDFVersion): Boolean;
begin
  Result := True;
  case ps of
    psPDFA_1a, psPDFA_1b:
      pv := pv14;
    psPDFA_2a, psPDFA_2b, psPDFA_3a, psPDFA_3b:
      pv := pv17;
  else
    Result := False;
  end;

end;

function IsPDFA_1(ps: TPDFStandard): Boolean;
begin
  Result := ps in [psPDFA_1a, psPDFA_1b];
end;

function IsPDFA(ps: TPDFStandard): Boolean;
begin
  Result := ps in [psPDFA_1a, psPDFA_1b, psPDFA_2a, psPDFA_2b, psPDFA_3a, psPDFA_3b];
end;

function PDFVersionByName(VersionName: string): TPDFVersion;
var
  pv: TPDFVersion;
begin
  for pv := Low(TPDFVersion) to High(TPDFVersion) do
    if VersionName = PDFVersionName[pv] then
    begin
      Result := pv;
      Exit;
    end;

  raise Exception.Create('Unknown/unsupported PDF version: "' + VersionName +'"');
end;

function PDFStandardByName(StandardName: string): TPDFStandard;
var
  ps: TPDFStandard;
begin
  for ps := Low(TPDFStandard) to High(TPDFStandard) do
    if StandardName = PDFStandardName[ps] then
    begin
      Result := ps;
      Exit;
    end;

  raise Exception.Create('Unknown/unsupported PDF standard: "' + StandardName +'"');
end;

function ShadowlessSizes(Obj: TfrxView): TViewSizes;
begin
  with Result do
  begin
    l := Obj.AbsLeft;
    t := Obj.AbsTop;
    w := Obj.Width - Obj.ShadowSize;
    h := Obj.Height - Obj.ShadowSize;
    r := l + w;
    b := t + h;
  end;
end;

function Is2DShape(Obj: TfrxView): boolean;
begin
  Result := IsShape(Obj,
    [skRectangle, skRoundRectangle, skEllipse, skTriangle, skDiamond]);
end;

function IsShape(Obj: TfrxView; ShapeKindSet: TfrxShapeKindSet): boolean;
begin
  Result := (Obj is TfrxShapeView) and (TfrxShapeView(Obj).Shape in ShapeKindSet);
end;

procedure Write(Stream: TStream; const S: AnsiString);
begin
  Stream.Write(S[1], Length(S));
end;

procedure WriteLn(Stream: TStream; const S: AnsiString);
begin
  Write(Stream, S + AnsiString(#13#10));
end;

{$IFDEF DELPHI12}
procedure WriteLn(Stream: TStream; const S: String);
begin
  WriteLn(Stream, AnsiString(S));
end;

procedure Write(Stream: TStream; const S: String);
begin
  Write(Stream, AnsiString(S));
end;
{$ENDIF}

procedure GetStreamHash(out Hash: TfrxPDFXObjectHash; S: TStream);
var
  H: TCryptoHash;
begin
  H := TCryptoMD5.Create;

  try
    H.Push(S);
    H.GetDigest(Hash[0], SizeOf(Hash));
  finally
    H.Free;
  end;
end;

function ObjNumber(FNumber: longint): String;
begin
  Result := IntToStr(FNumber) + ' 0 obj';
end;

function ObjNumberRef(FNumber: longint): String;
begin
  Result := IntToStr(FNumber) + ' 0 R';
end;

function PrepXRefPos(Index: Integer): String;
begin
  Result := StringOfChar('0',  10 - Length(IntToStr(Index))) + IntToStr(Index)
end;

function CryptStream(Source: TStream; Target: TStream; Key: AnsiString; id: Integer): AnsiString;
var
  s: AnsiString;
  k: array [ 1..21 ] of Byte;
  rc4: TfrxRC4;
  m1, m2: TMemoryStream;
begin
  FillChar(k, 21, 0);
  Move(Key[1], k, 16);
  Move(id, k[17], 3);
  SetLength(s, 16);
  frMD5Buf(@k, 21, @s[1]);
  m1 := TMemoryStream.Create;
  m2 := TMemoryStream.Create;
  rc4 := TfrxRC4.Create;
  try
    m1.LoadFromStream(Source);
    m2.SetSize(m1.Size);
    rc4.Start(@s[1], 16);
    rc4.Crypt(m1.Memory, m2.Memory, m1.Size);
    m2.SaveToStream(Target);
  finally
    m1.Free;
    m2.Free;
    rc4.Free;
  end;
end;

procedure AddStyleSimulation(FontName: String; FontStyles: TFontStyles);
begin
  PDFFontSimulationList.AddFont(FontName, FontStyles);
end;

function SimulationlessStyle(Font: TFont): TFontStyles;
var
  Simulation: String;
begin
  Result := Font.Style;
  if IsNeedsItalicSimulation(Font, Simulation) then
    Exclude(Result, fsItalic);
  if IsNeedsBoldSimulation(Font, Simulation) then
    Exclude(Result, fsBold);
end;

procedure DeleteStyleSimulation(FontName: String);
begin
  PDFFontSimulationList.DeleteFont(FontName);
end;

function IsNeedsBoldSimulation(Font: TFont; out Simulation: String): Boolean;
begin
  Result := (fsBold in Font.Style) and
    PDFFontSimulationList.IsNeedsBold(Font.Name);

  if Result then
    Simulation := '2 Tr ' + frFloat2Str(Font.Size / 35.0) + ' w ' +
      Color2Str(Font.Color) + ' RG';
end;

function IsNeedsItalicSimulation(Font: TFont; out Simulation: String): Boolean;
begin
  Result := (fsItalic in Font.Style) and
    PDFFontSimulationList.IsNeedsItalic(Font.Name);

  if Result then
    Simulation := '1 0 0.25 1';
end;

function Color2Str(Color: TColor): String;
var
  RGB: LongInt;
begin
  if Color = clNone then
    Result:= '0 0 0'
  else
  begin
    RGB := ColorToRGB(Color);
    Result:= Float2Str(GetRValue(RGB) / 255) + ' ' +
             Float2Str(GetGValue(RGB) / 255) + ' ' +
             Float2Str(GetBValue(RGB) / 255);
  end;
end;

function frxRect2Str(DR: TfrxRect; const Prec: Integer = DefaultPrec): String;
begin   // x  y  width  height, with lower-left corner (x, y)
  Result := Float2Str(DR.Left, Prec) + ' ' + Float2Str(DR.Bottom, Prec) + ' ' +
    Float2Str(DR.Right - DR.Left, Prec) + ' ' + Float2Str(DR.Top - DR.Bottom, Prec);
end;

function frxPointSum(P1, P2: TfrxPoint): TfrxPoint;
begin
  Result := frxPoint(P1.X + P2.X, P1.Y + P2.Y);
end;

function frxPointMult(P: TfrxPoint; Factor: Extended): TfrxPoint;
begin
  Result := frxPoint(Factor * P.X, Factor * P.Y);
end;

function StrToHex(const Value: WideString): AnsiString;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(Value) do
    Result := Result  + AnsiString(IntToHex(Word(Value[i]), 4));
end;

function StrToHexDx(const RS: TRemapedString; pdfDX: TDoubleArray; AverageDx: Boolean): AnsiString;

  function HexLetter(ZeroBasedIndex: Integer): AnsiString;
  begin
    Result := AnsiString(IntToHex(Word(RS.Data[ZeroBasedIndex + 1]), 4));
  end;

var
  Dx: TDoubleArray;
  Len, Count: Integer;

  procedure CalcAverageDx;
  var
    i: Integer;
    Average: Double;
  begin
    Average := 0;
    Count := 0;
    for i := 0 to Len - 1 do
      if not RS.IsSpace[i] then
      begin
        Average := Average + Dx[i];
        Count := Count + 1;
      end;
    if Count > 1 then
    begin
      Average := Average / Count;
      for i := 0 to Len - 1 do
        if not RS.IsSpace[i] then
          Dx[i] := Average;
    end;
  end;

var
  i: Integer;
  Ix: TIntegerDinArray;
  Balance: Double;
begin
  Result := '';

  Len := Length(pdfDx);
  SetLength(Dx, Len);
  for i := 0 to Len - 1 do
    Dx[i] := RS.CharWidth[i] - pdfDx[i];

  if AverageDx then
    CalcAverageDx;

  SetLength(Ix, Len);
  Balance := 0;
  for i := 0 to Len - 1 do
  begin
    Ix[i] := Round(Int(Dx[i]));
    Balance := Balance + Frac(Dx[i]);
    if      Balance > 0.5 then
    begin
      Ix[i] := Ix[i] + 1;
      Balance := Balance - 1;
    end
    else if Balance < -0.5 then
    begin
      Ix[i] := Ix[i] - 1;
      Balance := Balance + 1;
    end
  end;

  for i := 0 to Len - 1 do
  begin
    Result := Result + HexLetter(i);
    if (i < Len - 1) and (Ix[i] <> 0) then
      Result := Result + '>' + AnsiString(IntToStr(Ix[i])) + '<';
  end;
end;

function StrToHexSp(const Value: WideString; SpaceAdjustment: Extended): AnsiString;
var
  i: integer;
  w: Integer;
  z: Extended;
begin
  result := '';
  z := 0;
  w := Trunc(SpaceAdjustment);
  for i := 1 to Length(Value) do
  begin
    result := result + AnsiString(IntToHex(Word(Value[i]), 4));
    if Value[i] = #3 then
    begin
      z := z + Frac(SpaceAdjustment);
      if w + Trunc(z) <> 0 then
        result := result + AnsiString('>' + IntToStr(w + Trunc(z)) + '<');
      z := Frac(z);
    end;
  end;
end;

{ TfrxPDFFont }

constructor TfrxPDFFont.Create(Font: TFont);
begin
  inherited Create(Font);

  FSaved := False;
end;

procedure TfrxPDFFont.FillOutlineTextMetrix();
var
  i: Cardinal;
{$IFDEF Linux}
  FPath: String;
  SkipList: TList;
  test: TrueTypeFont;
  f: TFileStream;
{$ENDIF}
begin
  GlobalTempBitmap.Canvas.Lock;
  try
    GlobalTempBitmap.Canvas.Font.Assign(SourceFont);
    {$IFNDEF Linux}
    i := GetOutlineTextMetrics(GlobalTempBitmap.Canvas.Handle, 0, nil);
    if i = 0 then
    begin
      GlobalTempBitmap.Canvas.Font.Name := 'Arial';
      i := GetOutlineTextMetrics(GlobalTempBitmap.Canvas.Handle, 0, nil);
    end;
    if i <> 0 then
    begin
      TextMetric := GetMemory(i);
      if TextMetric <> nil then
        GetOutlineTextMetricsA(GlobalTempBitmap.Canvas.Handle, i, TextMetric);
    end;
    {$ELSE}
    FPath := LFonts.GetFontPath(SourceFont, Name);
    try
      f := TFileStream.Create(FPath, fmOpenRead or fmShareDenyNone);
      FontData.LoadFromStream(f);
      f.Free;
    except
      raise Exception.Create('Error. Cant load/find font.');
    end;
    FontData.Position := 0;
    TrueTypeTables := TrueTypeCollection.Create();
    TrueTypeTables.Initialize(FontData.Memory, FontDataSize);
    SkipList := Tlist.Create;
    SkipList.Add( Pointer(TablesID.TablesID_EmbedBitmapLocation));
    SkipList.Add( Pointer(TablesID.TablesID_EmbededBitmapData));
    SkipList.Add( Pointer(TablesID.TablesID_HorizontakDeviceMetrix));
    SkipList.Add( Pointer(TablesID.TablesID_VerticalDeviceMetrix));
    SkipList.Add( Pointer(TablesID.TablesID_DigitalSignature));

    for i := 0 to TrueTypeTables.FontCollection.Count - 1 do
    begin
      ttf := TrueTypeFont(TrueTypeTables.FontCollection[i]);
      ttf.PrepareFont( SkipList );
    end;
    SkipList.Free;
    try
      test := TrueTypeTables.Item[Name];
      TextMetric := GetMemory(sizeof(TOUTLINETEXTMETRIC));
      test.GetOutlineTextMetrics(TextMetric);
    except
      raise Exception.Create('Error. Cant get text metric');
    end;
    {$ENDIF}
  finally
    GlobalTempBitmap.Canvas.Unlock;
  end;
end;

function TfrxPDFFont.FontHeightToPointSizeFactor: Double;
begin
  with TextMetric.otmTextMetrics do
    if tmHeight = 0 then
      Result := 1.0
    else
      Result := (tmHeight - tmInternalLeading) / tmHeight;
end;

function TfrxPDFFont.GetFontName: AnsiString;
var
  s: AnsiString;

  function HexEncode7F(Str: AnsiString): AnsiString;
  var
    AnStr: AnsiString;
    s: AnsiString;
    Index, Len: Integer;
  begin
    s := '';
    AnStr := AnsiString(Str);
    Len := Length(AnStr);
    Index := 0;
    while Index < Len do
    begin
      Index := Index + 1;
      if Byte(AnStr[Index]) > $7F then
        s := s + '#' + AnsiString(IntToHex(Byte(AnStr[Index]), 2))
      else
        s := s + AnsiString(AnStr[Index]);
    end;
    Result := s;
  end;

  function IsAnsiName(ws: WideString): Boolean;
  var
    i, len: Integer;
  begin
    Result := False;
    len := Length(ws);
    for i := 1 to len do
      if ord(ws[i]) > 127 then
          exit;
    Result := True;
  end;

begin
{$IFDEF DELPHI12}
  if IsAnsiName(SourceFont.Name) then
    Result := AnsiString(SourceFont.Name)
  else if (ttf <> nil) then
    Result := UTF8Encode(ttf.PostScriptName);
  if (ttf <> nil) and (ttf.SubstitutionName <> '') and
     (ttf.FamilyName <> '') and (Pos('?', ttf.FamilyName) = 0) then
    Result :=  UTF8Encode(ttf.FamilyName);
  Result := StringReplace(Result, AnsiString(' '), AnsiString('#20'), [rfReplaceAll]);
  Result := StringReplace(Result, AnsiString('('), AnsiString('#28'), [rfReplaceAll]);
  Result := StringReplace(Result, AnsiString(')'), AnsiString('#29'), [rfReplaceAll]);
  Result := StringReplace(Result, AnsiString('%'), AnsiString('#25'), [rfReplaceAll]);
  Result := StringReplace(Result, AnsiString('<'), AnsiString('#3C'), [rfReplaceAll]);
  Result := StringReplace(Result, AnsiString('>'), AnsiString('#3E'), [rfReplaceAll]);
  Result := StringReplace(Result, AnsiString('['), AnsiString('#5B'), [rfReplaceAll]);
  Result := StringReplace(Result, AnsiString(']'), AnsiString('#5D'), [rfReplaceAll]);
  Result := StringReplace(Result, AnsiString('{'), AnsiString('#7B'), [rfReplaceAll]);
  Result := StringReplace(Result, AnsiString('}'), AnsiString('#7D'), [rfReplaceAll]);
  Result := StringReplace(Result, AnsiString('/'), AnsiString('#2F'), [rfReplaceAll]);
{$ELSE}
  Result := SourceFont.Name;
  Result := StringReplace(Result, ' ', '#20', [rfReplaceAll]);
  Result := StringReplace(Result, '(', '#28', [rfReplaceAll]);
  Result := StringReplace(Result, ')', '#29', [rfReplaceAll]);
  Result := StringReplace(Result, '%', '#25', [rfReplaceAll]);
  Result := StringReplace(Result, '<', '#3C', [rfReplaceAll]);
  Result := StringReplace(Result, '>', '#3E', [rfReplaceAll]);
  Result := StringReplace(Result, '[', '#5B', [rfReplaceAll]);
  Result := StringReplace(Result, ']', '#5D', [rfReplaceAll]);
  Result := StringReplace(Result, '{', '#7B', [rfReplaceAll]);
  Result := StringReplace(Result, '}', '#7D', [rfReplaceAll]);
  Result := StringReplace(Result, '/', '#2F', [rfReplaceAll]);
{$ENDIF}
  s := '';
  if (fsBold in SourceFont.Style) and
    not PDFFontSimulationList.IsNeedsBold(SourceFont.Name) then
    s := s + 'Bold';
  if (fsItalic in SourceFont.Style) and
    not PDFFontSimulationList.IsNeedsItalic(SourceFont.Name) then
    s := s + 'Italic';
  if s <> '' then
    Result := Result + ',' + s;
  Result := HexEncode7F(Result);
end;

procedure TfrxPDFFont.PackTTFFont;
var
  i, j: Integer;
  packed_font: frxTrueTypeFont.TByteArray;
begin
  packed_font := nil;
  if (ttf <> nil) and Self.PackFont then
  begin
    packed_font := Self.TrueTypeTables.PackFont( ttf {Self.SourceFont}, Self.UsedAlphabet );
    if packed_font <> nil then
    begin
      {$IFDEF Linux}
      FontData.SetSize(Length(packed_font));
      CopyMemory( FontData.Memory^, packed_font[0], Length(packed_font));
      FontData.SetSize(Length(packed_font));
      {$ELSE}
      FontDataSize := Length(packed_font);
      CopyMemory( FontData, packed_font, FontDataSize);

      for i := 0 to UsedAlphabet.Count - 1 do
        if (Word(UsedAlphabetUnicode[i]) <> $20) and
           (Word(UsedAlphabetUnicode[i]) <> $A0) then
        begin
          j := Integer(UsedAlphabet[i]);
          try
            { dont use values from table for ligatures }
            if Widths[i] <> Pointer(-1) then
            begin
              j := ttf.Width[j];
              Widths[i] := Pointer(j)
            end;
          except
            Widths[i] := Pointer(0);
          end;
        end;
      {$ENDIF}
    end;
  end;
end;

procedure TfrxPDFFont.Save(AReference: Longint);
begin
  Reference := AReference;
  FSaved := True;
end;

function TfrxPDFFont.SpaceAdjustment(RS: TRemapedString; TextWidth, FontSize: Extended): Extended;
var
  TotalAjustment: Extended;
begin
  TotalAjustment := RS.Width;
  if FontSize <> 0 then
    TotalAjustment := TotalAjustment - TextWidth * 1000 / FontSize;

  Result := TotalAjustment / RS.SpacesCount;
end;

procedure TfrxPDFFont.Update(const SourcePDFFont: TfrxPDFFont; const SourceFont: TFont);
begin
  FontName := SourcePDFFont.Name;
  Size := PDFFontSize(SourceFont);
  Color := frIfColor(SourceFont.Color <> clNone, SourceFont.Color, clBlack);
end;

{ TPDFObjectsHelper }

procedure TPDFObjectsHelper.Clear;
begin
  FAcroFonts.Clear;
  FBBoxFonts.Clear;
  CRS.Clear;
  CRS.Init;
end;

constructor TPDFObjectsHelper.Create;
begin
  FCRS := TCrossReferenceSection.Create;
  FAcroFonts := TList.Create;
  FBBoxFonts := TList.Create;
  Protection := False;
  EmbeddedFonts := False;
  EncKey := '';
  FGraphicHelper := GetGraphicFormats.FindByName('JPG');
end;

destructor TPDFObjectsHelper.Destroy;
begin
  Clear;
  FAcroFonts.Free;
  FBBoxFonts.Free;
  FCRS.Free;
  inherited;
end;

procedure TPDFObjectsHelper.EndBBox;
begin
  FIsBBoxReleative := False;
  FBBoxFonts.Clear;
end;

function TPDFObjectsHelper.FindXObject(const Hash: TfrxPDFXObjectHash): Integer;
begin
  Result := XObjects.Find(Hash);
  FLastRequestedXRef := Result;
end;

function TPDFObjectsHelper.GetAcroFont(const Font: TFont): TfrxPDFFont;
var
  i: Integer;
  OSFontName: String;
begin
  OSFontName := GetOSFontName(Font);
  i := 0;
  while i < FAcroFonts.Count do
    if IsFontNameAndStyle(AcroFonts[i].SourceFont, OSFontName, Font.Style) then
      Break
    else
      Inc(i);
  if i < FAcroFonts.Count then
    Result := AcroFonts[i]
  else
  begin
    Result := GetGlobalFont(Font, OSFontName);
    FAcroFonts.Add(Result);
  end;
end;

function TPDFObjectsHelper.GetAcroFonts(Index: integer): TfrxPDFFont;
begin
  Result := TfrxPDFFont(FAcroFonts[Index]);
end;

function TPDFObjectsHelper.GetAcroFontsCount: integer;
begin
  Result := FAcroFonts.Count;
end;

function TPDFObjectsHelper.GetBBoxFonts(Index: integer): TfrxPDFFont;
begin
  Result := TfrxPDFFont(FBBoxFonts[Index]);
end;

function TPDFObjectsHelper.GetBBoxFontsCount: Integer;
begin
  Result := FBBoxFonts.Count;
end;

function TPDFObjectsHelper.GetGlobalFont(const Font: TFont; const OSFontName: String): TfrxPDFFont;
var
  i: Integer;
begin
  i := FFonts.IndexOfFont(OSFontName, Font.Style);
  if i = Unknown then
    i := FFonts.AddFont(Font, OSFontName);
  Result := Fonts[i];
end;

function TPDFObjectsHelper.GetLastObjectXRefID: Integer;
begin
  Result := FLastRequestedXRef;
end;

function TPDFObjectsHelper.GetObjFontNumber(const Font: TFont): integer;
var
  i: Integer;
  OldStyle, NewStyle: TFontStyles;
  OSFontName: String;
  PDFFont: TfrxPDFFont;
  AFont: TfrxPDFFont;
begin
  NewStyle := SimulationlessStyle(Font);
  OSFontName := GetOSFontName(Font);
  Result := FFonts.IndexOfFont(OSFontName, NewStyle);
  if Result = Unknown then
  begin
    OldStyle := Font.Style;
    Font.Style := NewStyle;
    Result := FFonts.AddFont(Font, OSFontName);
    Font.Style := OldStyle;
  end;
  PDFFont := Fonts[Result];
  if not PDFFont.Saved then
    PDFFont.Save(UpdateXRef);
  FPageFonts.Add(PDFFont.Reference);

  if FIsBBoxReleative then
  begin
    AFont := GetAcroFont(Font);
    i := FBBoxFonts.IndexOf(AFont);
    if i < 0 then
    begin
      AFont.Update(AFont, Font);
      FBBoxFonts.Add(AFont);
      if not AFont.Saved then
        AFont.Save(UpdateXRef);
    end;
  end;
end;

function TPDFObjectsHelper.GetOSFontName(const Font: TFont): String;
begin
  {$IFDEF Linux}
  Result := LFonts.GetFontName(Font);
  {$ELSE}
  Result := Font.Name;
  {$ENDIF}
end;

function TPDFObjectsHelper.IsFontNameAndStyle(const Font: TFont; Name: String; Style: TFontStyles): Boolean;
begin
  Result := (Font.Name = Name) and (Font.Style = Style);
end;

procedure TPDFObjectsHelper.OutPageFonts;
var
  i: Integer;
begin
  if FPageFonts.FCount > 0 then
  begin
    Write(FpdfStream, '/Font << ');
    for i := 0 to FPageFonts.FCount - 1 do
      Write(FpdfStream, Fonts[FFonts.IndexByReference(FPageFonts.No[i])].Name +
        AnsiString(' ' + ObjNumberRef(FPageFonts.No[i]) + ' '));
    WriteLn(FpdfStream, '>>');
  end;
end;

procedure TPDFObjectsHelper.OutPagePatterns;
var
  i: Integer;
begin
  if FPatterns.FCount > 0 then
  begin
    Write(FpdfStream, '/Pattern << ');
    for i := 0 to FPatterns.FCount - 1 do
      Write(FpdfStream, '/P' + IntToStr(i) + ' ' + ObjNumberRef(FPatterns.No[i]) + ' ');
    WriteLn(FpdfStream, '>>');
  end;
end;

function TPDFObjectsHelper.OutPattern(PicIndex, Width, Height: Integer): Integer;

  function CalcPatternHash: TfrxPDFXObjectHash;
  var
    Stream: TStream;
  begin
    Stream := TMemoryStream.Create;
    try
      Stream.Write(PicIndex, SizeOf(PicIndex));
      Stream.Write(Width, SizeOf(Width));
      Stream.Write(Height, SizeOf(Height));
      Stream.Position := 0;
      GetStreamHash(Result, Stream);
    finally
      Stream.Free;
    end;
  end;
var
  PatternIndex, ObjNo: Integer;
  ImStream: string;
  Hash: TfrxPDFXObjectHash;
begin
  Hash := CalcPatternHash;
  PatternIndex := FindXObject(Hash);
  if PatternIndex = Unknown then
  begin
    ObjNo := UpdateXRef;
    XObjects.Add(ObjNo, Hash);


    WriteLn(FpdfStream, ObjNumber(ObjNo));
    WriteLn(FpdfStream, '<<');
      WriteLn(FpdfStream, '/Type /Pattern');
      WriteLn(FpdfStream, '/PatternType 1'); // (1 - tiling | 2 - shading) pattern
      WriteLn(FpdfStream, '/PaintType 1'); // (1 - colored | 2 uncolored) tiling pattern
      WriteLn(FpdfStream, '/TilingType 2'); // 2 - no distortion
      WriteLn(FpdfStream, '/BBox [0 0 1 1]');
      WriteLn(FpdfStream, '/XStep 1');
      WriteLn(FpdfStream, '/YStep 1');

      WriteLn(FpdfStream, '/Resources << /XObject << /Im' + IntToStr(PicIndex) +
        ' ' +  ObjNumberRef(XObjects.Id[PicIndex]) + ' >> >>');

      WriteLn(FpdfStream, '/Matrix [' + IntToStr(Width) + ' 0 0 ' + IntToStr(Height) + ' 0 0]');

      ImStream := 'q /Im' + IntToStr(PicIndex) + ' Do Q'#13#10;
      WriteLn(FpdfStream, '/Length ' + IntToStr(Length(ImStream)));
    WriteLn(FpdfStream, '>>');
    WriteLn(FpdfStream, 'stream');
    WriteLn(FpdfStream, ImStream);
    WriteLn(FpdfStream, 'endstream');
    WriteLn(FpdfStream, 'endobj');
  end
  else
    ObjNo := XObjects.Id[PatternIndex];

  Result := FPatterns.Add(ObjNo);
end;

function TPDFObjectsHelper.OutTransparentGraphic(Graphic: TGraphic): Integer;
var
  TempBitmap: TBitmap;
  TBRect: TRect;
  XMaskId:    Integer;
  MaskBytes: TMaskArray;
  Image: TGraphic;
  XObjectStream: TStream;
  XObjectHash: TfrxPDFXObjectHash;
  PicIndex: Integer;
begin
  TempBitmap := CreateBitmap(pf32bit, Graphic.Width, Graphic.Height);
  try
    TBRect := Rect(0, 0, TempBitmap.Width, TempBitmap.Height);

    TempBitmap.Canvas.Lock;
    try
      TempBitmap.Canvas.Brush.Color := clWhite;
      TempBitmap.Canvas.FillRect(TBRect); // Any Brush.Color
      TempBitmap.Canvas.StretchDraw(TBRect, Graphic);
    finally
      TempBitmap.Canvas.Unlock;
    end;

    CreateMask(TempBitmap, MaskBytes);

    { Write XObject with a picture inside }
    Image := FGraphicHelper.ConvertFrom(TempBitmap, pf24Bit, FQuality);
    try
      XObjectStream := TMemoryStream.Create;
      try
        Image.SaveToStream(XObjectStream);
        SaveMask(FpdfStream, XObjectStream, MaskBytes,
                 Self, TempBitmap, FProtection, FEncKey,
                 XObjectHash, XMaskId, PicIndex);
        if PicIndex = Unknown then
          PicIndex := OutXObjectImage(XObjectHash, Image, XObjectStream, True, XMaskId);
      finally
        XObjectStream.Free;
      end;
    finally
      Image.Free;
      SetLength(MaskBytes, 0);
    end;
  finally
    TempBitmap.Free;
  end;

  Result := PicIndex;
end;

function TPDFObjectsHelper.OutXObjectImage(XObjectHash: TfrxPDFXObjectHash;
  Image: TGraphic; XObjectStream: TStream;
  IsTransparent: Boolean = False; MaskId: Integer = 0): Integer;
var
  XObjectId: Integer;
begin
  XObjectId := UpdateXRef;
  Result := XObjects.Add(XObjectId, XObjectHash);

  WriteLn(FpdfStream, ObjNumber(XObjectId));
  WriteLn(FpdfStream, '<<');
  WriteLn(FpdfStream, '/Type /XObject');
  WriteLn(FpdfStream, '/Subtype /Image');
  WriteLn(FpdfStream, '/ColorSpace /DeviceRGB');
  WriteLn(FpdfStream, '/BitsPerComponent 8');
  WriteLn(FpdfStream, '/Filter /DCTDecode');
  WriteLn(FpdfStream, '/Width ' + IntToStr(Image.Width));
  WriteLn(FpdfStream, '/Height ' + IntToStr(Image.Height));

  if IsTransparent then
     WriteLn(FpdfStream, '/SMask ' + ObjNumberRef(MaskId));

  ///// NEED TO REPLACE

  WriteLn(FpdfStream, '/Length ' + IntToStr(XObjectStream.Size));
  WriteLn(FpdfStream, '>>');

  WriteLn(FpdfStream, 'stream'); // 'stream'#10 is also valid
  XObjectStream.Position := 0;
  if FProtection then
    CryptStream(XObjectStream, FpdfStream, FEncKey, XObjectId)
  else
    FpdfStream.CopyFrom(XObjectStream, 0);
  WriteLn(FpdfStream, '');
  WriteLn(FpdfStream, 'endstream');
  WriteLn(FpdfStream, 'endobj');
end;

procedure TPDFObjectsHelper.StartBBox;
begin
  FIsBBoxReleative := True;
end;

function TPDFObjectsHelper.UpdateXRef: Integer;
begin
  Result := CRS.AddNext(FpdfStream.Position);
  FLastRequestedXRef := Result;
end;

{ TPDFFontSimulation }

procedure TPDFFontSimulation.AddStyles(FontStyles: TFontStyles);
begin
  FFontStyles := FFontStyles + FontStyles;
end;

constructor TPDFFontSimulation.Create(Name: String; FontStyles: TFontStyles);
begin
  FName := Name;
  FFontStyles := FontStyles;
end;

function TPDFFontSimulation.IsName(Name: String): Boolean;
begin
  Result := FName = Name;
end;

function TPDFFontSimulation.IsStyle(FontStyle: TFontStyle): Boolean;
begin
  Result := FFontStyles * [FontStyle] <> [];
end;

{ TPDFFontSimulationList }

procedure TPDFFontSimulationList.AddFont(Name: String; FontStyles: TFontStyles);
var
  PDFFontSimulation: TPDFFontSimulation;
begin
  if FontStyles <> [] then
  begin
    PDFFontSimulation := Find(Name);
    if PDFFontSimulation <> nil then
      PDFFontSimulation.AddStyles(FontStyles)
    else
      Add(TPDFFontSimulation.Create(Name, FontStyles));
  end;
end;

procedure TPDFFontSimulationList.DeleteFont(Name: String);
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    if TPDFFontSimulation(Items[i]).IsName(Name) then
    begin
      Delete(i);
      Break;
    end;
end;

function TPDFFontSimulationList.Find(Name: String): TPDFFontSimulation;
var
  i: Integer;
begin
  Result := nil;
  for i := 0 to Count - 1 do
    if TPDFFontSimulation(Items[i]).IsName(Name) then
    begin
      Result := TPDFFontSimulation(Items[i]);
      Break;
    end;
end;

function TPDFFontSimulationList.IsNeedsBold(Name: String): Boolean;
begin
  Result := IsNeedsStyle(Name, fsBold);
end;

function TPDFFontSimulationList.IsNeedsItalic(Name: String): Boolean;
begin
  Result := IsNeedsStyle(Name, fsItalic);
end;

function TPDFFontSimulationList.IsNeedsStyle(Name: String; FontStyle: TFontStyle): Boolean;
var
  PDFFontSimulation: TPDFFontSimulation;
begin
  PDFFontSimulation := Find(Name);
  Result := (PDFFontSimulation <> nil) and PDFFontSimulation.IsStyle(FontStyle);
end;

{$IFDEF Linux}
function TfrxPDFFont.GetFontDataSize(): Longint;
begin
  if FontData <> nil then
    Result := FontData.Size
  else
    Result := 0;
end;
{$ENDIF}

{ TPDFFontCorrection }

constructor TPDFFontCorrection.Create;
var
  i: Integer;
begin
  for i := Low(FCorrection) to High(FCorrection) do
    FCorrection[i] := 1;
end;

function TPDFFontCorrection.GetCorrection(Index: Integer): Double;
begin
  if Index in [Low(FCorrection)..High(FCorrection)] then
    Result := FCorrection[Index]
  else
    Result := 1;
end;

procedure TPDFFontCorrection.SetCorrection(Index: Integer; const Value: Double);
begin
  if Index in [Low(FCorrection)..High(FCorrection)] then
    FCorrection[Index] := Value;
end;

{ TPDFMonospacedFontCorrectionList }

procedure TPDFMonospacedFontCorrectionList.AddCorrection(FontName: TFontName; FontSize: Integer; Factor: Double);
var
  Index: Integer;
begin
  if not Find(FontName, Index) then
  begin
    Index := Add(FontName);
    Objects[Index] := TPDFFontCorrection.Create;
  end;

  TPDFFontCorrection(Objects[Index]).Correction[FontSize] := Factor;
end;

constructor TPDFMonospacedFontCorrectionList.Create;
begin
  inherited Create;
  CaseSensitive := False;
  Duplicates := dupIgnore;
  Sorted := True;
end;

{ TInt64Object }

type
  TInt64Object = class
  public
    Value: Int64;
  end;

{ TInt64List }

procedure TInt64List.Add(Value: Int64);
begin
  Setitem(FObjectList.Add(TInt64Object.Create), Value);
end;

procedure TInt64List.Clear;
begin
  FObjectList.Clear;
end;

constructor TInt64List.Create;
begin
  FObjectList := TObjectList.Create;
  FObjectList.OwnsObjects := True;
end;

destructor TInt64List.Destroy;
begin
  FObjectList.Free;
  inherited;
end;

function TInt64List.GetCount: Integer;
begin
  Result := FObjectList.Count;
end;

function TInt64List.GetItem(Index: integer): Int64;
begin
  Result := TInt64Object(FObjectList[Index]).Value;
end;

procedure TInt64List.Setitem(Index: integer; const Value: Int64);
begin
  TInt64Object(FObjectList[Index]).Value := Value;
end;

procedure TPDFMonospacedFontCorrectionList.DeleteCorrection(FontName: TFontName);
var
  Index: Integer;
begin
  if Find(FontName, Index) then
  begin
    Objects[Index].Free;
    Delete(Index);
  end;
end;

destructor TPDFMonospacedFontCorrectionList.Destroy;
var
  Index: Integer;
begin
  for Index := 0 to Count - 1 do
    Objects[Index].Free;

  inherited;
end;

function TPDFMonospacedFontCorrectionList.GetCorrection(FontName: TFontName; FontSize: Integer): Double;
var
  Index: Integer;
begin
  if Find(FontName, Index) then
    Result := TPDFFontCorrection(Objects[Index]).Correction[FontSize]
  else
    Result := 1;
end;

{ TCrossReferenceEntry }

procedure TCrossReferenceEntry.CombiteSubsections(NextEntry: TCrossReferenceEntry);
begin
  if Subsection.Start and NextEntry.Subsection.Start and (Id = NextEntry.Id - 1) then // can be combined
  begin
    FSubsection.Length := Subsection.Length + NextEntry.Subsection.Length;
    NextEntry.FSubsection.Start := False;
  end;

end;

constructor TCrossReferenceEntry.Create(AId, AOffset: Integer; AFreeEntry: Boolean = False; AGenerationNumber: Integer = 0);
begin
  FId := AId;
  FOffset := AOffset;
  FGenerationNumber := AGenerationNumber;
  FFreeEntry := AFreeEntry;

  FSubsection.Start := True;
  FSubsection.Length := 1;
end;

function TCrossReferenceEntry.EntryStr(SingleCharacterEOL: Boolean = False): string;
var
  OffsetStr, GenStr: string;
begin
  OffsetStr := IntToStr(Offset);
  GenStr := IntToStr(GenerationNumber);

  Result := StringOfChar('0',  10 - Length(OffsetStr)) + OffsetStr + ' ' +
            StringOfChar('0',  5 - Length(GenStr)) + GenStr + ' ' +
            frIfStr(FFreeEntry, 'f', 'n') +
            frIfStr(SingleCharacterEOL, ' ');
end;

function TCrossReferenceEntry.SubsectionStr: string;
begin
  Result := IntToStr(Id) + ' ' + IntToStr(Subsection.Length);
end;

{ TCrossReferenceSection }

procedure TCrossReferenceSection.AddId(Id: Integer; Offset: Integer = 0);
begin
  Add(TCrossReferenceEntry.Create(Id, Offset));
end;

function TCrossReferenceSection.AddNext(Offset: Integer = 0): Integer;
begin
  Result := FNextId;
  AddId(Result, Offset);

  Inc(FNextId);
end;

procedure TCrossReferenceSection.Clear;
begin
  inherited Clear;
  FNextId := 1;
end;

constructor TCrossReferenceSection.Create(ASingleCharacterEOL: Boolean = False);
begin
  inherited Create;

  FSingleCharacterEOL := ASingleCharacterEOL;
  FNextId := 1;
  Init;
end;

function TCrossReferenceSection.IndexOfId(Id: Integer): Integer;
var
  i: Integer;
begin
  Result := Unknown;
  for i := 0 to Count - 1 do
    if TCrossReferenceEntry(Items[i]).Id = Id then
    begin
      Result := i;
      Break;
    end;
end;

procedure TCrossReferenceSection.Init;
begin
  Add(TCrossReferenceEntry.Create(0, FSectionOffset, True, 65535));
end;

function TCrossReferenceSection.IsSubsection(Index: Integer; out SubsectionStr: string): Boolean;
var
  Entry: TCrossReferenceEntry;
begin
  Entry := TCrossReferenceEntry(Items[Index]);
  Result := Entry.Subsection.Start;
  if Result then
    SubsectionStr := Entry.SubsectionStr;
end;

function TCrossReferenceSection.OutLine(Index: Integer): string;
var
  Entry: TCrossReferenceEntry;
begin
  Entry := TCrossReferenceEntry(Items[Index]);
  Result := Entry.EntryStr(FSingleCharacterEOL);
end;

function CompareById(Item1 : Pointer; Item2 : Pointer) : Integer;
var
  Entry1, Entry2 : TCrossReferenceEntry;
begin
  Entry1 := TCrossReferenceEntry(Item1);
  Entry2 := TCrossReferenceEntry(Item2);

  if      Entry1.Id > Entry2.Id then
    Result := 1
  else if Entry1.Id < Entry2.Id then
    Result := -1
  else if Item1 = Item2 then
    Result := 0
  else
    raise Exception.Create('Cross Reference Error: Entries with the same Id''s');
end;

procedure TCrossReferenceSection.PrepareToOut;
var
  i: Integer;
  Entry, NextEntry : TCrossReferenceEntry;
begin
  Sort(CompareById);

  for i := Count - 2 downto 0 do
  begin
    Entry := TCrossReferenceEntry(Items[i]);
    NextEntry := TCrossReferenceEntry(Items[i + 1]);
    Entry.CombiteSubsections(NextEntry);
  end;

end;

procedure TCrossReferenceSection.SetOffset(Id, Offset: Integer);
var
  Index: Integer;
  Entry: TCrossReferenceEntry;
begin
  Index := IndexOfId(Id);
  if Index = Unknown then
    AddId(Id, Offset)
  else
  begin
    Entry := TCrossReferenceEntry(Items[Index]);
    Entry.Offset := Offset;
  end;
end;

{ TReferenceArray }

function TReferenceArray.Add(ObjNo: Integer): Integer;
begin
  for Result := 0 to Count - 1 do
    if FData[Result] = ObjNo then
      Exit;

  Result := Count;
  if Count > High(FData) then
    SetLength(FData, Length(FData) * 2);
  FData[Count] := ObjNo;
  Inc(FCount);
end;

procedure TReferenceArray.Clear;
begin
  FCount := 0;
end;

constructor TReferenceArray.Create;
begin
  FCount := 0;
  SetLength(FData, 32);
end;

function TReferenceArray.GetNo(Index: Integer): Integer;
begin
  Result := FData[Index];
end;

function TReferenceArray.GetRef(Index: Integer): string;
begin
  Result := ObjNumberRef(FData[Index]);
end;

procedure TReferenceArray.WriteAsArray(Stream: TStream; Caption: string);
var
  i: Integer;
begin
  if Count > 0 then
  begin
    Write(Stream, Caption + ' [');
    for i := 0 to FCount - 1 do
      Write(Stream, frIfStr(i > 0, ' ') + Ref[i]);
    WriteLn(Stream, ']');
  end;
end;

{ TPageByPageReferenceArray }

constructor TPageByPageReferenceArray.Create;
begin
  SureIndex(32 - 1);
end;

destructor TPageByPageReferenceArray.Destroy;
var
  i: Integer;
begin
  for i := 0 to High(FData) do
    FData[i].Free;
  SetLength(FData, 0);
  SetLength(FContents, 0);
  inherited Destroy;
end;

function TPageByPageReferenceArray.GetContents(Index: Integer): Integer;
begin
  Result := FContents[Index];
end;

function TPageByPageReferenceArray.GetData(Index: Integer): TReferenceArray;
begin
  if Index > High(FData) then
    Result := nil
  else
    Result := FData[Index];
end;

procedure TPageByPageReferenceArray.SetContents(Index: Integer; const Value: Integer);
begin
  SureIndex(Index);
  FContents[Index] := Value;
end;

procedure TPageByPageReferenceArray.SetData(Index: Integer; const Value: TReferenceArray);
begin
  SureIndex(Index);
  FData[Index].Free;
  FData[Index] := Value;
end;

procedure TPageByPageReferenceArray.SureIndex(Index: Integer);
var
  NewLen: Integer;
begin
  if High(FData) < Index then
  begin
    NewLen := Max(Length(FData) * 2, Index + 1);
    SetLength(FData, NewLen);
    SetLength(FContents, NewLen);
  end;
end;

{ TfrxPDFXObjectArray }

function TfrxPDFXObjectArray.Add(AId: Integer; const Hash: TfrxPDFXObjectHash): Integer;
var
  Len: Integer;
begin
  Len := Length(FObjId);
  if Count >= Len then
  begin
    SetLength(FObjId, Len * 2);
    SetLength(FHash, Len * 2);
  end;
  FObjId[Count] := AId;
  Move(Hash, FHash[Count], SizeOf(Hash));
  Result := Count;
  Inc(FCount);
end;

procedure TfrxPDFXObjectArray.Clear;
begin
  FCount := 0;
end;

constructor TfrxPDFXObjectArray.Create;
begin
  FCount := 0;
  SureIndex(32 - 1);
end;

function TfrxPDFXObjectArray.Find(const Hash: TfrxPDFXObjectHash): Integer;
begin
  for Result := 0 to FCount - 1 do
    if CompareMem(@Hash, @FHash[Result], SizeOf(Hash)) then
      Exit;
  Result := Unknown;
end;

function TfrxPDFXObjectArray.GetId(Index: Integer): Integer;
begin
  Result := FObjId[Index];
end;

procedure TfrxPDFXObjectArray.SureIndex(Index: Integer);
var
  NewLen: Integer;
begin
  if High(FObjId) < Index then
  begin
    NewLen := Max(Length(FObjId) * 2, Index + 1);
    SetLength(FObjId, NewLen);
    SetLength(FHash, NewLen);
  end;
end;

{ TPDFGLobalFonts }

function TPDFGLobalFonts.AddFont(const Font: TFont; const OSFontName: String): Integer;
begin
  Result := Add(TfrxPDFFont.Create(Font));
  with Items[Result] do
  begin
    {$IFDEF Linux}
    Name := OSFontName;
    SourceFont.Name := OSFontName;
    {$ENDIF}
    FillOutlineTextMetrix();
    Name := AnsiString('/F' + IntToStr(Result));
  end;
end;

function TPDFGLobalFonts.Get(Index: Integer): TfrxPDFFont;
begin
  Result := inherited Get(Index);
end;

function TPDFGLobalFonts.IndexByReference(No: Integer): Integer;
var
  i: Integer;
begin
  Result := Unknown;
  for i := 0 to Count - 1 do
    if Items[i].Reference = No then
    begin
      Result := i;
      Exit;
    end;
end;

function TPDFGLobalFonts.IndexOfFont(Name: String; Style: TFontStyles): Integer;
var
  i: Integer;
  Font: TFont;
begin
  Result := Unknown;
  for i := 0 to Count - 1 do
  begin
    Font := Items[i].SourceFont;
    if (Font.Name = Name) and (Font.Style = Style) then
    begin
      Result := i;
      Exit;
    end;
  end;
end;

{ TEMFPDFFontCorrectionList }

procedure TEMFPDFFontCorrectionList.AddCorrection(FontName: TFontName; Factor: Single);
var
  Index: Integer;
begin
  if not Find(FontName, Index) then
  begin
    Index := Add(FontName);
    Objects[Index] := TEMFPDFontCorrection.Create;
  end;

  TEMFPDFontCorrection(Objects[Index]).Correction := Factor;
end;

constructor TEMFPDFFontCorrectionList.Create;
begin
  inherited Create;
  CaseSensitive := False;
  Duplicates := dupIgnore;
  Sorted := True;
end;

procedure TEMFPDFFontCorrectionList.DeleteCorrection(FontName: TFontName);
var
  Index: Integer;
begin
  if Find(FontName, Index) then
  begin
    Objects[Index].Free;
    Delete(Index);
  end;
end;

destructor TEMFPDFFontCorrectionList.Destroy;
var
  Index: Integer;
begin
  for Index := 0 to Count - 1 do
    Objects[Index].Free;

  inherited;
end;

function TEMFPDFFontCorrectionList.IsGetCorrection(FontName: TFontName; out Corr: Single): Boolean;
var
  Index: Integer;
begin
  Result := Find(FontName, Index);
  if Result then
    Corr := TEMFPDFontCorrection(Objects[Index]).Correction
  else
    Corr := 1.0;
end;

initialization

  EnableTpPtCorrection;

  PDFFontSimulationList := TPDFFontSimulationList.Create;
  AddStyleSimulation(#$FF2D#$FF33#$0020#$30B4#$30B7#$30C3#$30AF, [fsBold, fsItalic]);
  AddStyleSimulation(#$FF2D#$FF33#$0020#$FF30#$30B4#$30B7#$30C3#$30AF, [fsBold, fsItalic]);
  AddStyleSimulation(#$FF2D#$FF33#$0020#$660E#$671D, [fsBold, fsItalic]);
  AddStyleSimulation(#$FF2D#$FF33#$0020#$FF30#$660E#$671D, [fsBold, fsItalic]);
  AddStyleSimulation('MS UI Gothic', [fsBold, fsItalic]);
  AddStyleSimulation('Arial Black', [fsBold, fsItalic]);
  AddStyleSimulation('Tahoma', [fsItalic]);

  PDFMonospacedFontCorrectionList := TPDFMonospacedFontCorrectionList.Create;
  StretchFont('Consolas',  6, 0.986); StretchFont('Consolas',  7, 1.002);
  StretchFont('Consolas',  8, 1.012); StretchFont('Consolas',  9, 0.997);
  StretchFont('Consolas', 10, 1.008); StretchFont('Consolas', 11, 1.016);
  StretchFont('Consolas', 12, 1.002); StretchFont('Consolas', 13, 0.994);
  StretchFont('Consolas', 14, 1.002); StretchFont('Consolas', 15, 1.007);

  StretchFont('Courier New',  6, 1.004); StretchFont('Courier New',  7, 1.005);
  StretchFont('Courier New',  8, 1.002); StretchFont('Courier New',  9, 1.003);
  StretchFont('Courier New', 10, 1.004); StretchFont('Courier New', 11, 1.002);
  StretchFont('Courier New', 12, 1.004); StretchFont('Courier New', 13, 1.004);
  StretchFont('Courier New', 14, 1.004); StretchFont('Courier New', 15, 1.003);

  StretchFont('Lucida Console',  8, 0.998); StretchFont('Lucida Console',  9, 0.998);
  StretchFont('Lucida Console', 10, 0.998); StretchFont('Lucida Console', 11, 0.998);
  StretchFont('Lucida Console', 12, 0.999); StretchFont('Lucida Console', 13, 0.999);
  StretchFont('Lucida Console', 14, 1.000); StretchFont('Lucida Console', 15, 0.998);

  EMFPDFFontCorrectionList := TEMFPDFFontCorrectionList.Create;
  StretchFont('Arial', 1.0);
  StretchFont('Calibri', 1.0);
  StretchFont('Calibri Light', 1.0);
  StretchFont('Cambria', 1.0);
  StretchFont('Garamond', 1.0);
  StretchFont('Georgia', 1.0);
  StretchFont('Gotham', 1.0);
  StretchFont('Gotham Light', 1.0);
  StretchFont('Meiryo', 1.0);
  StretchFont('Tahoma', 1.0);
  StretchFont('Times New Roman', 1.0);
  StretchFont('Trebuchet MS', 0.998);
  StretchFont('Verdana',  0.999);

finalization

  PDFFontSimulationList.Free;
  PDFMonospacedFontCorrectionList.Free;
  EMFPDFFontCorrectionList.Free;

end.

