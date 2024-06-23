{*******************************************************}
{                                                       }
{                       EhLib 10.2                      }
{       TPdfDocument, TPdfDocumentInformation,          }
{     TPdfCatalog, TPdfTrailer, TPdfPages, TPdfPage,    }
{        TPdfContent, TPdfResources classes             }
{                                                       }
{   Copyright (c) 2021-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit PdfDocumentsEh;

{$SCOPEDENUMS ON}

interface

uses
  Classes, Types, SysUtils, Graphics,
{$IFDEF FPC}
    {$IFDEF FPC_WINDOWS}
    Windows, ComObj,
    {$ENDIF}
  EhLibLCL, LCLType, Generics.Collections,
{$ELSE}
  EhLibVCL, Generics.Collections,
    {$IFDEF MSWINDOWS}
    ComObj,
    {$ENDIF}
{$ENDIF}
  PdfElemetsEh, PdfGraphicsEh, PdfFontsEh, PdfImagesEh;

{
 The four sections of a PDF
   ------
   Header
   ------
   Body
   ------
   Cross-reference table
   ------
   Trailer
   ------

// Example of Hello world Pdf file

========================================
  %PDF-1.4
  %%EOF

  6 0 obj
  <<
   /Type /Catalog
   /Pages 5 0 R
  >>
  endobj

  1 0 obj
  <<
   /Type /Page
   /Parent 5 0 R
   /MediaBox [ 0 0 612 792 ]
   /Resources 3 0 R
   /Contents 2 0 R
  >>
  endobj

  4 0 obj
  <<
   /Type /Font
   /Subtype /Type1
   /Name /F1
   /BaseFont/Helvetica
  >>
  endobj

  2 0 obj
  <<
   /Length 53
  >>
  stream
  BT
   /F1 24 Tf
   1 0 0 1 260 600 Tm
   (Hello World)Tj
  ET
  endstream
  endobj

  5 0 obj
  <<
   /Type /Pages
   /Kids [ 1 0 R ]
   /Count 1
  >>
  endobj

  3 0 obj
  <<
   /ProcSet[/PDF/Text]
   /Font <</F1 4 0 R >>
  >>
  endobj

  xref
  0 7
  0000000000 65535 f
  0000000060 00000 n
  0000000228 00000 n
  0000000424 00000 n
  0000000145 00000 n
  0000000333 00000 n
  0000000009 00000 n
  trailer
  <<
   /Size 7
   /Root 6 0 R
  >>
  startxref
  488
  %%EOF
========================================

}

type
  TPdfDocumentEh = class;
  TPdfDocumentInformationEh = class;
  TPdfCatalogEh = class;
  TPdfTrailerEh = class;
  TPdfPagesEh = class;
  TPdfPageEh = class;
  TPdfContentEh = class;
  TPdfResourcesEh = class;
//  TPdfCrossReferenceTable = class;

  TPdfFontDictionaryEh = TDictionary<String, TPdfType0FontEh>;

{ TPdfDocumentInformationEh }

  TPdfDocumentInformationEh = class(TPdfIdrectDictionaryObjectEh)
  private
    function GetTitle: String;
    procedure SetTitle(const Value: String);
  public
    constructor Create(ADocument: TPdfDocumentEh);

    property Title: String read GetTitle write SetTitle;
  end;

{ TPdfCatalogEh }

  TPdfCatalogEh = class(TPdfIdrectDictionaryObjectEh)
  private
    FDocument: TPdfDocumentEh;
    FPages: TPdfPagesEh;
    function GetPages: TPdfPagesEh;

  protected
    procedure InitCatalog;

  public
    constructor Create(ADocument: TPdfDocumentEh);
    destructor Destroy; override;

    property Pages: TPdfPagesEh read GetPages;
  end;

{ TPdfPagesEh }

  TPdfPagesEh = class(TPdfIdrectDictionaryObjectEh)
  private
    FCatalog: TPdfCatalogEh;
    FKids: TPdfArrayEh;
    FPages: TList<TPdfPageEh>;
  protected
    procedure InitPages;

  public
    constructor Create(ACatalog: TPdfCatalogEh);
    destructor Destroy; override;

    procedure PrepareForExport; override;

    function Add: TPdfPageEh;
  end;

{ TPdfPageEh }

  TPdfPageEh = class(TPdfIdrectDictionaryObjectEh)
  private
    FPages: TPdfPagesEh;
    FGraphics: TPdgGraphicsEh;
    FContent: TPdfContentEh;
    FSize: TSizeF;
    FResources: TPdfResourcesEh;
    FUserUnit: Double;
    function GetContent: TPdfContentEh;
    procedure SetSize(const Value: TSizeF);

  protected
    procedure InitPage;

    procedure EnsureContent;
    procedure SetMediaBoxArr;

  public
    constructor Create(APages: TPdfPagesEh);
    destructor Destroy; override;

    procedure AddUsedFont(PdfFont: TPdfType0FontEh);
    procedure EnsureImageRef(AnImage: TPdfImageEh);

    property Graphics: TPdgGraphicsEh read FGraphics;
    property Content: TPdfContentEh read GetContent;
    property Size: TSizeF read FSize write SetSize;
    property UserUnit: Double read FUserUnit;
  end;

  /// <summary>
  /// These external references are managed via the resource dictionary
  /// that is the value of the Resources key in the page dictionary
  /// </summary>
  ///
  TPdfResourcesEh = class(TPdfDictionaryEh)
  private
    FPage: TPdfPageEh;
  public
    constructor Create(APage: TPdfPageEh);
    destructor Destroy; override;
  end;

{ TPdfContentEh }

  /// <summary>
  /// Content of the page (for the drawing instructions)
  /// </summary>
  TPdfContentEh = class(TPdfIdrectDictionaryObjectEh)
  private
    FPage: TPdfPageEh;
    function GetBoundStream: TPdfAsciiStreamEh;

  protected
    procedure InitContent;
    function CreateBoundStream: TPdfDictionaryStreamEh; override;

  public
    constructor Create(APage: TPdfPageEh);
    destructor Destroy; override;

    procedure PrepareForExport; override;

    property BoundStream: TPdfAsciiStreamEh read GetBoundStream;
  end;


{ TPdfTrailerEh }

  /// <summary>
  /// Represents a PDF trailer dictionary.
  /// </summary>
  TPdfTrailerEh = class(TPdfDictionaryEh)
  private
    //FRoot: TPdfCatalog;
    FDocument: TPdfDocumentEh;

  public
    constructor Create(ADocument: TPdfDocumentEh);

    procedure PrepareForExport; override;

    //property Root: TPdfCatalog read FRoot;
  end;

{ TPdfDocumentEh }

  /// <summary>
  /// Represents a PDF Document.
  /// </summary>
  TPdfDocumentEh = class(TPdfBaseDocumentEh)
  private
    FDocInfo: TPdfDocumentInformationEh;
    FCatalog: TPdfCatalogEh;
    FTrailer: TPdfTrailerEh;
    FFontDictionary: TPdfFontDictionaryEh;
    FImages: TList<TPdfImageEh>;
    //FElementaryValues: TList<TPdfObject>;
    FNextFontCode: Integer;
    FNextImageCode: Integer;
    FPixelsPerInch: Integer;
    FCompressStreams: Boolean;

    function GetCatalog:  TPdfCatalogEh;
    function GetNextFontCode: String;
    function GetNextImageCode: String;

  protected
    property Catalog: TPdfCatalogEh read GetCatalog;
    property Trailer: TPdfTrailerEh read FTrailer;

    function CreateStringValue(AValue: String; AStringType: TPdfStringType): TPdfStringEh;

    procedure InitDocument;
    {$IFDEF FPC}
    procedure FontDicItemNotification(Sender: TObject; constref Item: TPdfType0FontEh; Action: TCollectionNotification);
    {$ELSE}
    procedure FontDicItemNotification(Sender: TObject; const Item: TPdfType0FontEh; Action: TCollectionNotification);
    {$ENDIF}
  public
    constructor Create;
    destructor Destroy; override;

    function AddPage: TPdfPageEh;
    function GetFontByKey(var PdfFontDef: TPdfFontDefEh): TPdfType0FontEh;
    function GetPdfImageByGraphic(Graphic: TGraphic): TPdfImageEh;

    procedure SaveToFile(const FileName: String);
    procedure WriteToStream(Stream: TStream);

    property DocInfo: TPdfDocumentInformationEh read FDocInfo;
    property PixelsPerInch: Integer read FPixelsPerInch write FPixelsPerInch;
    property CompressStreams: Boolean read FCompressStreams write FCompressStreams;
  end;

var
  {$IFDEF FPC}
  CompressPdfStreams: Boolean = False;
  {$ELSE}
  CompressPdfStreams: Boolean = True;
  {$ENDIF}

implementation

uses PdfWritersEh;

function CreateGuidString: String;
{$IFDEF FPC_LINUX}
begin
  Result := '';
end;
{$ELSE}
var
  ClassIDStr: String;
begin
{$IFDEF MSWINDOWS}
  ClassIDStr := CreateClassID;
{$ELSE}
  ClassIDStr := '';
{$ENDIF}
  Result := Copy(ClassIDStr, 2, 8) +
                Copy(ClassIDStr, 11, 4) +
                Copy(ClassIDStr, 16, 4) +
                Copy(ClassIDStr, 21, 4) +
                Copy(ClassIDStr, 26, 12);
end;
{$ENDIF}

{ TPdfCatalogEh }

constructor TPdfCatalogEh.Create(ADocument: TPdfDocumentEh);
begin
  inherited Create(ADocument);

  FDocument := ADocument;
  FPages := TPdfPagesEh.Create(Self);
end;

destructor TPdfCatalogEh.Destroy;
begin
  FreeAndNil(FPages);
  inherited Destroy;
end;

function TPdfCatalogEh.GetPages: TPdfPagesEh;
begin
  Result := FPages;
end;

procedure TPdfCatalogEh.InitCatalog;
begin
  Items.Add('/Pages', FPages);
  Items.Add('/Type', TPdfNameEh.Create('/Catalog'));
  FPages.InitPages;
end;

{ TPdfTrailerEh }

constructor TPdfTrailerEh.Create(ADocument: TPdfDocumentEh);
var
  IdArray: TPdfArrayEh;
  PdfString1: TPdfStringEh;
  PdfString2: TPdfStringEh;
begin
  inherited Create;
  FDocument := ADocument;

  PdfString1 := ADocument.CreateStringValue(CreateGuidString, TPdfStringType.Hexadecimal);
  PdfString2 := ADocument.CreateStringValue(String(PdfString1.Value), TPdfStringType.Hexadecimal);

  IdArray := TPdfArrayEh.Create;
  IdArray.Items.Add(PdfString1);
  IdArray.Items.Add(PdfString2);

  Items.Add('/ID', IdArray);
end;

procedure TPdfTrailerEh.PrepareForExport;
var
  Size: Integer;
begin
  inherited PrepareForExport;
  Size := FDocument.IndirectObjectList.Count + 1;

  Items.Add('/Size', TPdfIntegerNumberEh.Create(Size));
end;

{ TPdfDocumentEh }

constructor TPdfDocumentEh.Create;
begin
  inherited Create;

  FPixelsPerInch := 72;
  FCompressStreams := CompressPdfStreams;
  FDocInfo := TPdfDocumentInformationEh.Create(Self);
  FCatalog := TPdfCatalogEh.Create(Self);
  FTrailer := TPdfTrailerEh.Create(Self);
  FFontDictionary := TPdfFontDictionaryEh.Create;
  FFontDictionary.OnValueNotify := FontDicItemNotification;
  FImages := TList<TPdfImageEh>.Create;

  InitDocument;
end;

destructor TPdfDocumentEh.Destroy;
begin
  FreeAndNil(FDocInfo);
  FreeAndNil(FCatalog);
  FreeAndNil(FTrailer);

  FreeAndNil(FFontDictionary);

  while FImages.Count > 0 do
  begin
    FImages[FImages.Count - 1].Free;
    FImages.Delete(FImages.Count - 1);
  end;

  FreeAndNil(FImages);
  inherited Destroy;
end;

{$IFDEF FPC}
procedure TPdfDocumentEh.FontDicItemNotification(Sender: TObject;
  constref Item: TPdfType0FontEh; Action: TCollectionNotification);
{$ELSE}
procedure TPdfDocumentEh.FontDicItemNotification(Sender: TObject;
  const Item: TPdfType0FontEh; Action: TCollectionNotification);
{$ENDIF}
begin
  if Action = cnRemoved then
    Item.Free;
end;

function TPdfDocumentEh.CreateStringValue(AValue: String;
  AStringType: TPdfStringType): TPdfStringEh;
begin
  Result := TPdfStringEh.Create(AValue, AStringType);
  //FElementaryValues.Add(Result);
end;

function TPdfDocumentEh.AddPage: TPdfPageEh;
begin
  Result := Catalog.Pages.Add;
end;

function TPdfDocumentEh.GetCatalog: TPdfCatalogEh;
begin
  Result := FCatalog;
end;

function TPdfDocumentEh.GetFontByKey(var PdfFontDef: TPdfFontDefEh): TPdfType0FontEh;
begin
  if (FFontDictionary.TryGetValue(PdfFontDef.FontKeyName, Result)) then
    //Ok
  else
  begin
    Result := TPdfType0FontEh.Create(Self, PdfFontDef.FontKeyName,
      PdfFontDef.Name, PdfFontDef.IsBold, PdfFontDef.IsItalic, GetNextFontCode);
    FFontDictionary.Add(PdfFontDef.FontKeyName, Result);
  end;
end;

function TPdfDocumentEh.GetNextFontCode: String;
begin
  Result := 'F' + IntToStr(FNextFontCode);
  FNextFontCode := FNextFontCode + 1;
end;

function TPdfDocumentEh.GetNextImageCode: String;
begin
  Result := 'Img' + IntToStr(FNextImageCode);
  FNextImageCode := FNextImageCode + 1;
end;

function TPdfDocumentEh.GetPdfImageByGraphic(Graphic: TGraphic): TPdfImageEh;
var
  Image: TPdfImageEh;
begin
  Image := TPdfImageEh.GetPdfImageByGraphic(Self, Graphic, GetNextImageCode);
  FImages.Add(Image);
  Result := Image;
end;

procedure TPdfDocumentEh.InitDocument;
begin
  FTrailer.Items.Add('/Info', FDocInfo);
  FTrailer.Items.Add('/Root', FCatalog);
  FCatalog.InitCatalog;
end;

procedure TPdfDocumentEh.SaveToFile(const FileName: String);
var
  fs: TFileStream;
begin
  fs := TFileStream.Create(FileName, fmCreate);
  WriteToStream(fs);
  fs.Free;
end;

procedure TPdfDocumentEh.WriteToStream(Stream: TStream);
var
  PdfWriter: TPdfWriterEh;
begin
  PdfWriter := TPdfWriterEh.Create;
  try
    PdfWriter.WriteToStream(Self, Stream);
  finally
    PdfWriter.Free;
  end;
end;

{ TPdfDocumentInformationEh }

constructor TPdfDocumentInformationEh.Create(ADocument: TPdfDocumentEh);
begin
  inherited Create(ADocument);
end;

function TPdfDocumentInformationEh.GetTitle: String;
var
  Value: TPdfObjectEh;
begin
  if (Items.TryGetValue('/Title', Value)) then
    Result := String(TPdfStringEh(Value).Value)
  else
    Result := '';
end;

procedure TPdfDocumentInformationEh.SetTitle(const Value: String);
var
  TitleValue: TPdfStringEh;
  AtomValue: TPdfObjectEh;
begin
  if (Items.TryGetValue('/Title', AtomValue)) then
  begin
    TPdfStringEh(AtomValue).Value := AnsiString(Value);
  end else
  begin
    TitleValue := TPdfStringEh.Create(Value, TPdfStringType.Regular);
    Items.Add('/Title', TitleValue);
  end;
end;

{ TPdfPageEh }

constructor TPdfPageEh.Create(APages: TPdfPagesEh);
begin
  inherited Create(APages.FCatalog.FDocument);

  FPages := APages;
  FGraphics := TPdgGraphicsEh.Create(Self);
  FResources := TPdfResourcesEh.Create(Self);
end;

destructor TPdfPageEh.Destroy;
begin
  FreeAndNil(FGraphics);
  FreeAndNil(FContent);

  inherited Destroy;
end;

procedure TPdfPageEh.InitPage;
var
  GroupDic: TPdfDictionaryEh;
  ASize: TSizeF;
begin
  Items.Add('/Type', TPdfNameEh.Create('/Page'));
  Items.Add('/Parent', FPages);

  FUserUnit := 1 / (TPdfDocumentEh(FPages.Document).PixelsPerInch / 72);
  Items.Add('/UserUnit', TPdfRealNumber.Create(UserUnit));

  ASize.cx := 595 / UserUnit;
  ASize.cy := 842 / UserUnit;
  Size := ASize;

  SetMediaBoxArr;

  GroupDic := TPdfDictionaryEh.Create;
  GroupDic.Items.Add('/CS', TPdfNameEh.Create('/DeviceRGB'));
  GroupDic.Items.Add('/S', TPdfNameEh.Create('/Transparency'));
  Items.Add('/Group', GroupDic);

  Items.Add('/Resources', FResources);

  EnsureContent;
end;

procedure TPdfPageEh.SetMediaBoxArr;
var
  MediaBoxArr: TPdfArrayEh;
  MediaBoxArrObj: TPdfObjectEh;
begin
  if Items.TryGetValue('/MediaBox', MediaBoxArrObj) then
  begin
    MediaBoxArr := MediaBoxArrObj as TPdfArrayEh;
    MediaBoxArr.Items.Clear;
  end
  else
  begin
    MediaBoxArr := TPdfArrayEh.Create;
    Items.Add('/MediaBox', MediaBoxArr);
  end;

  MediaBoxArr.Items.Add(TPdfIntegerNumberEh.Create(0));
  MediaBoxArr.Items.Add(TPdfIntegerNumberEh.Create(0));
  MediaBoxArr.Items.Add(TPdfRealNumber.Create(Size.Width));
  MediaBoxArr.Items.Add(TPdfRealNumber.Create(Size.Height));
end;

procedure TPdfPageEh.SetSize(const Value: TSizeF);
begin
  if (FSize.Width <> Value.Width) or (FSize.Height <> Value.Height) then
  begin
    FSize := Value;
    SetMediaBoxArr;
  end;
end;

procedure TPdfPageEh.EnsureContent;
begin
  if (FContent = nil) then
  begin
    FContent := TPdfContentEh.Create(Self);
    Items.Add('/Contents', FContent);
  end;
end;

procedure TPdfPageEh.EnsureImageRef(AnImage: TPdfImageEh);
var
  XObjectObj: TPdfObjectEh;
  XObjectDic: TPdfDictionaryEh;
  ImgRef: TPdfObjectEh;
begin
  if not FResources.Items.TryGetValue('/XObject', XObjectObj) then
  begin
    XObjectDic := TPdfDictionaryEh.Create;
    FResources.Items.Add('/XObject', XObjectDic);
  end
  else
  begin
    XObjectDic := XObjectObj as TPdfDictionaryEh;
  end;

  if not XObjectDic.Items.TryGetValue('/' + AnImage.ImageCode, ImgRef) then
  begin
    XObjectDic.Items.Add('/' + AnImage.ImageCode, AnImage);
  end;
end;

function TPdfPageEh.GetContent: TPdfContentEh;
begin
  Result := FContent;
end;

procedure TPdfPageEh.AddUsedFont(PdfFont: TPdfType0FontEh);
var
  FontsObj: TPdfObjectEh;
  FontsDic: TPdfDictionaryEh;
  FontObj: TPdfObjectEh;
begin
  if (FResources.Items.TryGetValue('/Font', FontsObj) = False) then
  begin
    FontsDic := TPdfDictionaryEh.Create;
    FResources.Items.Add('/Font', FontsDic);
  end else
  begin
    FontsDic := TPdfDictionaryEh(FontsObj);
  end;

  if (FontsDic.Items.TryGetValue('/' + PdfFont.FontCode, FontObj) = False) then
  begin
    FontsDic.Items.Add('/' + PdfFont.FontCode, PdfFont);
  end;
end;

{ TPdfResourcesEh }

constructor TPdfResourcesEh.Create(APage: TPdfPageEh);
var
  Arr: TPdfArrayEh;
begin
  inherited Create;
  FPage := APage;

  Arr := TPdfArrayEh.Create;
  Arr.Items.Add(TPdfNameEh.Create('/PDF'));
  Arr.Items.Add(TPdfNameEh.Create('/Text'));
  Arr.Items.Add(TPdfNameEh.Create('/ImageB'));
  Arr.Items.Add(TPdfNameEh.Create('/ImageC'));
  Arr.Items.Add(TPdfNameEh.Create('/ImageI'));
  Items.Add('/ProcSet', Arr);
end;

destructor TPdfResourcesEh.Destroy;
begin
  inherited Destroy;
end;

{ TPdfPagesEh }

constructor TPdfPagesEh.Create(ACatalog: TPdfCatalogEh);
begin
  inherited Create(ACatalog.FDocument);

  FCatalog := ACatalog;
  FKids := TPdfArrayEh.Create;
  FPages := TList<TPdfPageEh>.Create;
end;

destructor TPdfPagesEh.Destroy;
begin
  while FPages.Count > 0 do
  begin
    FPages[FPages.Count - 1].Free;
    FPages.Delete(FPages.Count - 1);
  end;
  FreeAndNil(FPages);

  inherited Destroy;
end;

procedure TPdfPagesEh.InitPages;
begin
  Items.Add('/Type', TPdfNameEh.Create('/Pages'));
  Items.Add('/Kids', FKids);
end;

procedure TPdfPagesEh.PrepareForExport;
begin
  inherited PrepareForExport;

  Items.Add('/Count', TPdfIntegerNumberEh.Create(FPages.Count));
end;

function TPdfPagesEh.Add: TPdfPageEh;
begin
  Result := TPdfPageEh.Create(Self);
  FPages.Add(Result);
  FKids.Items.Add(Result);

  Result.InitPage;
end;

{ TPdfContentEh }

constructor TPdfContentEh.Create(APage: TPdfPageEh);
begin
  inherited Create(APage.FPages.FCatalog.FDocument);
  FPage := APage;
end;

function TPdfContentEh.CreateBoundStream: TPdfDictionaryStreamEh;
begin
  Result := TPdfAsciiStreamEh.Create;
end;

destructor TPdfContentEh.Destroy;
begin
  inherited Destroy;
end;

function TPdfContentEh.GetBoundStream: TPdfAsciiStreamEh;
begin
  Result := TPdfAsciiStreamEh(inherited BoundStream);
end;

procedure TPdfContentEh.InitContent;
begin

end;

procedure TPdfContentEh.PrepareForExport;
begin
  inherited PrepareForExport;
  Items.Add('/Length', TPdfIntegerNumberEh.Create(BoundStream.Size));
end;

end.
