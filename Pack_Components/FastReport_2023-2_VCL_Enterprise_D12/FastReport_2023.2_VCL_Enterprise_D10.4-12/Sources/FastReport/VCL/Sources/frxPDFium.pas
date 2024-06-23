{******************************************}
{                                          }
{             FastReport VCL               }
{            PDFView support               }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxPDFium;

{$I frx.inc}

interface

uses
{$IFNDEF Linux}
  Windows,
{$ELSE}
  LCLType, LCLIntf, LCLProc,
{$ENDIF}
  SysUtils, Classes, Graphics, Contnrs, SyncObjs, frCore;

type
  TPdfDocument = class;

  TPdfDocumentSaveOption = (
    dsoIncremental    = 1,
    dsoNoIncremental  = 2,
    dsoRemoveSecurity = 3
  );

  TPdfDrawOption = (
    pdoAnnotations,
    pdoLCDOptimized,
    pdoNoNativeText,
    pdoGrayScale,
    pdoNoCatch,
    pdoLimitedImageCacheSize,
    pdoForceHalftone,
    pdoPrinting,
    pdoUseMetafile,
    pdoPrintTextWithGDI
  );
  TPdfDrawOptions = set of TPdfDrawOption;

  PFPDF_FILEWRITE = ^FPDF_FILEWRITE;
  FPDF_FILEWRITE = record
    version: Integer;
    WriteBlock: function(pThis: PFPDF_FILEWRITE; pData: Pointer; size: LongWord): Integer; cdecl;
  end;
  PFPdfFileWrite = ^TFPdfFileWrite;
  TFPdfFileWrite = FPDF_FILEWRITE;

  PFPDFFileWriteEx = ^TFPDFFileWriteEx;
  TFPDFFileWriteEx = record
    Inner: TFPDFFileWrite;
    Stream: TStream;
  end;

  FPDF_BOOL  = Integer;
  FPDF_DWORD = LongWord;
  FPDF_BYTESTRING = PAnsiChar;
  __FPDF_PTRREC = record end;
  __PFPDF_PTRREC = ^__FPDF_PTRREC;
  FPDF_DOCUMENT          = type __PFPDF_PTRREC;
  FPDF_FORMHANDLE        = type __PFPDF_PTRREC;
  FPDF_PAGE              = type __PFPDF_PTRREC;
  FPDF_BITMAP            = type __PFPDF_PTRREC;

  TPdfPage = class
  private
    FDocument: TPdfDocument;
    FPage: FPDF_PAGE;
    FWidth: Single;
    FHeight: Single;
    function GetDrawFlags(const Options: TPdfDrawOptions): Integer;
    procedure AfterOpen;
  public
    constructor Create(ADocument: TPdfDocument; APage: FPDF_PAGE);
    procedure Draw(vCanvas: TCanvas; X, Y, Width, Height, Rotation: Integer; const Options: TPdfDrawOptions);
    function IsLoaded: Boolean;
    procedure Open;
    procedure Close;
    property Width: Single read FWidth;
    property Height: Single read FHeight;
  end;

{$IFNDEF FPC}
  TfrEMFDrawState = class
  private
    FNeedPathScaleDown: Boolean;
    FPenStyle: DWORD;
    FBrushStyle: UINT;
    FColor: COLORREF;
    FHatch: DWORD;
  public
    property NeedPathScaleDown: Boolean read FNeedPathScaleDown write FNeedPathScaleDown;
    property PenStyle: DWORD read FPenStyle write FPenStyle;
    property BrushStyle: UINT read FBrushStyle write FBrushStyle;
    property Color: COLORREF read FColor write FColor;
    property Hatch: DWORD read FHatch write FHatch;
  end;
{$ENDIF}

  TPdfDocument = class
  private
    FDocument: FPDF_DOCUMENT;
    FPages: TObjectList;
    FBuffer: PByte;
    FPageIndex: Integer;
    FErrorText: String;
    StrongError: Boolean;
{$IFNDEF FPC}
    FDrawState: TfrEMFDrawState;
{$ENDIF}
    procedure InitPDFium;
    procedure InternLoadFromMem(Buffer: PByte; Size: frInteger; const Password: String);

    function GetActive: Boolean;
    function GetPageCount: Integer;
    function IsPageValid: Boolean;
    function GetCurrentPage: TPdfPage;
    function GetPage(Index: Integer): TPdfPage;
    procedure SetPageIndex(Value: Integer);
    procedure SetErrorText(v: String);
    procedure PageContentChanged(Closing: Boolean);
    function IsPageLoaded(PageIndex: Integer): Boolean;
    procedure CheckActive;
  public

    constructor Create;
    destructor Destroy; override;
    procedure Close;
    procedure Clear;
    procedure LoadFromStream(AStream: TStream; const Password: String = '');
    procedure Paint(Canvas: Tcanvas; Rect: TRect; Rotation: Integer; DrawOptions: TPdfDrawOptions);
    function ReloadPage(APage: TPdfPage): FPDF_PAGE;

    function NewDocument: Boolean;
    function ImportPages(Source: TPdfDocument; const Range: string = ''; Index: Integer = -1): Boolean;
    procedure SaveToStream(Stream: TStream; Option: TPdfDocumentSaveOption = dsoRemoveSecurity; FileVersion: Integer = -1);

    property Active: Boolean read GetActive;
    property PageIndex: Integer read FPageIndex write SetPageIndex;
    property PageCount: Integer read GetPageCount;
    property CurrentPage: TPdfPage read GetCurrentPage;
    property Pages[Index: Integer]: TPdfPage read GetPage;
    property ErrorText: String read FErrorText write SetErrorText;
end;

procedure RaiseLastPdfError;

const
{$IFDEF Linux}
  {$IFDEF CPU64}
  pdfium_dll = 'frx_pdfium_64.so';
  {$ELSE}
  pdfium_dll = 'frx_pdfium.so';
  {$ENDIF}
{$ELSE}
  {$IFDEF WIN64}
    pdfium_dll = 'frx_pdfium_64.dll';
  {$ELSE}
    pdfium_dll = 'frx_pdfium.dll';
  {$ENDIF}
{$ENDIF}
  EMF_PPI = 600;

type
  TPDF_InitLibrary = procedure(); {$IFDEF DLLEXPORT}stdcall{$ELSE}cdecl{$ENDIF};
  TPDF_CloseDocument = procedure(document: FPDF_DOCUMENT); {$IFDEF DLLEXPORT}stdcall{$ELSE}cdecl{$ENDIF};
  TPDF_LoadMemDocument64 = function(data_buf: Pointer; size: frInteger; password: FPDF_BYTESTRING): FPDF_DOCUMENT; {$IFDEF DLLEXPORT}stdcall{$ELSE}cdecl{$ENDIF};
  TPDF_LoadPage = function(document: FPDF_DOCUMENT; page_index: Integer): FPDF_PAGE; {$IFDEF DLLEXPORT}stdcall{$ELSE}cdecl{$ENDIF};
  TPDF_GetPageCount = function(document: FPDF_DOCUMENT): Integer; {$IFDEF DLLEXPORT}stdcall{$ELSE}cdecl{$ENDIF};
{$IFNDEF Linux}
  TPDF_RenderPage = procedure(DC: HDC; page: FPDF_PAGE; start_x, start_y, size_x, size_y: Integer;
    rotate: Integer; flags: Integer); {$IFDEF DLLEXPORT}stdcall{$ELSE}cdecl{$ENDIF};
{$ELSE}
  TPDFBitmap_Create = function(width, height: Integer; alpha: Integer): FPDF_BITMAP; {$IFDEF DLLEXPORT}stdcall{$ELSE}cdecl{$ENDIF};
  TPDFBitmap_FillRect = procedure(bitmap: FPDF_BITMAP; left, top, width, height: Integer; color: FPDF_DWORD); {$IFDEF DLLEXPORT}stdcall{$ELSE}cdecl{$ENDIF};
  TPDF_RenderPageBitmap = procedure(bitmap: FPDF_BITMAP; page: FPDF_PAGE; start_x, start_y, size_x, size_y: Integer; rotate: Integer; flags: Integer); {$IFDEF DLLEXPORT}stdcall{$ELSE}cdecl{$ENDIF};
  TPDFBitmap_GetBuffer = function(bitmap: FPDF_BITMAP): Pointer; {$IFDEF DLLEXPORT}stdcall{$ELSE}cdecl{$ENDIF};
  TPDFBitmap_Destroy = procedure(bitmap: FPDF_BITMAP); {$IFDEF DLLEXPORT}stdcall{$ELSE}cdecl{$ENDIF};
{$ENDIF}
  TPDF_GetPageWidthF = function(page: FPDF_PAGE): Single; {$IFDEF DLLEXPORT}stdcall{$ELSE}cdecl{$ENDIF};
  TPDF_GetPageHeightF = function(page: FPDF_PAGE): Single; {$IFDEF DLLEXPORT}stdcall{$ELSE}cdecl{$ENDIF};
  TPDFPage_HasTransparency = function(page: FPDF_PAGE): FPDF_BOOL; {$IFDEF DLLEXPORT}stdcall{$ELSE}cdecl{$ENDIF};
  TPDFPage_GetRotation = function(page: FPDF_PAGE): Integer; {$IFDEF DLLEXPORT}stdcall{$ELSE}cdecl{$ENDIF};
  TPDF_ClosePage = procedure(page: FPDF_PAGE); {$IFDEF DLLEXPORT}stdcall{$ELSE}cdecl{$ENDIF};
  TPDF_ImportPages = function(dest_doc, src_doc: FPDF_DOCUMENT; pagerange: FPDF_BYTESTRING; index: Integer): FPDF_BOOL; {$IFDEF DLLEXPORT}stdcall{$ELSE}cdecl{$ENDIF};
  TPDF_CreateNewDocument = function: FPDF_DOCUMENT; {$IFDEF DLLEXPORT}stdcall{$ELSE}cdecl{$ENDIF};
  TPDF_SaveAsCopy = function(document: FPDF_DOCUMENT; pFileWrite: PFPDF_FILEWRITE; flags: FPDF_DWORD): FPDF_BOOL; {$IFDEF DLLEXPORT}stdcall{$ELSE}cdecl{$ENDIF};
  TPDF_SaveWithVersion = function(document: FPDF_DOCUMENT; pFileWrite: PFPDF_FILEWRITE;
    flags: FPDF_DWORD; fileVersion: Integer): FPDF_BOOL; {$IFDEF DLLEXPORT}stdcall{$ELSE}cdecl{$ENDIF};
  TPDF_GetLastError = function(): LongWord; {$IFDEF DLLEXPORT}stdcall{$ELSE}cdecl{$ENDIF};
  TPDF_SetPrintTextWithGDI = procedure(use_gdi: LongBool); {$IFDEF DLLEXPORT}stdcall{$ELSE}cdecl{$ENDIF};

var
  PdfiumModule: HMODULE;
  PDFiumInitCritSect: TCriticalSection;
//
  FPDF_InitLibrary: TPDF_InitLibrary;
  FPDF_CloseDocument: TPDF_CloseDocument;
  FPDF_LoadMemDocument64: TPDF_LoadMemDocument64;
  FPDF_LoadPage: TPDF_LoadPage;
  FPDF_GetPageCount: TPDF_GetPageCount;
{$IFNDEF Linux}
  FPDF_RenderPage: TPDF_RenderPage;
{$ELSE}
  FPDFBitmap_Create: TPDFBitmap_Create;
  FPDFBitmap_FillRect: TPDFBitmap_FillRect;
  FPDF_RenderPageBitmap: TPDF_RenderPageBitmap;
  FPDFBitmap_GetBuffer: TPDFBitmap_GetBuffer;
  FPDFBitmap_Destroy: TPDFBitmap_Destroy;
{$ENDIF}
  FPDF_GetPageWidthF: TPDF_GetPageWidthF;
  FPDF_GetPageHeightF: TPDF_GetPageHeightF;
  FPDFPage_HasTransparency: TPDFPage_HasTransparency;
  FPDFPage_GetRotation: TPDFPage_GetRotation;
  FPDF_ClosePage: TPDF_ClosePage;
  FPDF_ImportPages: TPDF_ImportPages;
  FPDF_CreateNewDocument: TPDF_CreateNewDocument;
  FPDF_SaveAsCopy: TPDF_SaveAsCopy;
  FPDF_SaveWithVersion: TPDF_SaveWithVersion;
  FPDF_GetLastError: TPDF_GetLastError;
  FPDF_SetPrintTextWithGDI: TPDF_SetPrintTextWithGDI;

  PDFiumDLLPath: String;

  procedure Lock;
  procedure UnLock;

  procedure frxPDF_InitLibrary();
  procedure frxPDF_CloseDocument(document: FPDF_DOCUMENT);
  function frxPDF_LoadMemDocument64(data_buf: Pointer; size: frInteger; password: FPDF_BYTESTRING): FPDF_DOCUMENT;
  function frxPDF_LoadPage(document: FPDF_DOCUMENT; page_index: Integer): FPDF_PAGE;
  function frxPDF_GetPageCount(document: FPDF_DOCUMENT): Integer;
{$IFNDEF Linux}
  procedure frxPDF_RenderPage(DC: HDC; page: FPDF_PAGE; start_x, start_y, size_x, size_y: Integer;
    rotate: Integer; flags: Integer);
{$ELSE}
  function frxPDFBitmap_Create(width, height: Integer; alpha: Integer): FPDF_BITMAP;
  procedure frxPDFBitmap_FillRect(bitmap: FPDF_BITMAP; left, top, width, height: Integer; color: FPDF_DWORD);
  procedure frxPDF_RenderPageBitmap(bitmap: FPDF_BITMAP; page: FPDF_PAGE; start_x, start_y, size_x, size_y: Integer; rotate: Integer; flags: Integer);
  function frxPDFBitmap_GetBuffer(bitmap: FPDF_BITMAP): Pointer;
  procedure frxPDFBitmap_Destroy(bitmap: FPDF_BITMAP);
{$ENDIF}
  function frxPDF_GetPageWidthF(page: FPDF_PAGE): Single;
  function frxPDF_GetPageHeightF(page: FPDF_PAGE): Single;
  function frxPDFPage_HasTransparency(page: FPDF_PAGE): FPDF_BOOL;
  function frxPDFPage_GetRotation(page: FPDF_PAGE): Integer;
  procedure frxPDF_ClosePage(page: FPDF_PAGE);
  function frxPDF_ImportPages(dest_doc, src_doc: FPDF_DOCUMENT; pagerange: FPDF_BYTESTRING; index: Integer): FPDF_BOOL;
  function frxPDF_CreateNewDocument: FPDF_DOCUMENT;
  function frxPDF_SaveAsCopy(document: FPDF_DOCUMENT; pFileWrite: PFPDF_FILEWRITE; flags: FPDF_DWORD): FPDF_BOOL;
  function frxPDF_SaveWithVersion(document: FPDF_DOCUMENT; pFileWrite: PFPDF_FILEWRITE;
    flags: FPDF_DWORD; fileVersion: Integer): FPDF_BOOL;
  function frxPDF_GetLastError(): LongWord;
  procedure frxPDF_SetPrintTextWithGDI(use_gdi: LongBool);

  procedure frxRenderPage(vCanvas: TCanvas; page: FPDF_PAGE; start_x, start_y, size_x, size_y: Integer;
    rotate: Integer; flags: Integer);

const
  FPDF_ERR_SUCCESS   = 0;
  FPDF_ERR_UNKNOWN   = 1;
  FPDF_ERR_FILE      = 2;
  FPDF_ERR_FORMAT    = 3;
  FPDF_ERR_PASSWORD  = 4;
  FPDF_ERR_SECURITY  = 5;
  FPDF_ERR_PAGE      = 6;
  RsPdfErrorSuccess  = 'No error.';
  RsPdfErrorUnknown  = 'Unknown error.';
  RsPdfErrorFile     = 'File not found or can''t be opened.';
  RsPdfErrorFormat   = 'File is not a PDF document or is corrupted.';
  RsPdfErrorPassword = 'Password required or invalid password.';
  RsPdfErrorSecurity = 'Security schema is not supports.';
  RsPdfErrorPage     = 'Page does not exist or data error.';

  RsPdfInvalidPage   = 'Invalid page';
  RsPdfDLLNotFound   = pdfium_dll + ' was not found.';
  RsPdfCheckActive   = 'attempt to render before loading the document.';
  RsPdfEmptyDocument = 'Empty document.';

implementation

uses frxPrinter, Math;
{TPdfPage}

function TPdfPage.GetDrawFlags(const Options: TPdfDrawOptions): Integer;
begin
  Result := 0;
  if (pdoAnnotations in Options) then
    Result := Result or 1;
  if (pdoLCDOptimized in Options) then
    Result := Result or 2;
  if (pdoNoNativeText in Options) then
    Result := Result or 4;
  if (pdoGrayScale in Options) then
    Result := Result or 8;
  if (pdoNoCatch in Options) then
    Result := Result or 256;
  if (pdoLimitedImageCacheSize in Options) then
    Result := Result or 512;
  if (pdoForceHalftone in Options) then
    Result := Result or 1024;
  if (pdoPrinting in Options) then
    Result := Result or 2048;
end;

procedure TPdfPage.AfterOpen;
begin
  FWidth := frxPDF_GetPageWidthF(FPage);
  FHeight := frxPDF_GetPageHeightF(FPage);
end;

constructor TPdfPage.Create(ADocument: TPdfDocument; APage: FPDF_PAGE);
begin
  FDocument := ADocument;
  FPage := APage;
  AfterOpen;
end;

procedure TPdfPage.Draw(vCanvas: TCanvas; X, Y, Width, Height, Rotation: Integer; const Options: TPdfDrawOptions);
begin
  Lock;
  if Assigned(FPDF_SetPrintTextWithGDI) then
    FPDF_SetPrintTextWithGDI(LongBool(pdoPrintTextWithGDI in Options));
  UnLock;
  frxRenderPage(vCanvas, FPage, X, Y, Width, Height, Rotation, GetDrawFlags(Options));
end;

function TPdfPage.IsLoaded: Boolean;
begin
  Result := FPage <> nil;
end;

procedure TPdfPage.Open;
begin
  if FPage = nil then
  begin
    FPage := FDocument.ReloadPage(Self);
    AfterOpen;
  end;
end;

procedure TPdfPage.Close;
begin
  if FPage <> nil then
  begin
    frxPDF_ClosePage(FPage);
    FPage := nil;
  end;
end;

{TPdfDocument}

procedure TPdfDocument.InitPDFium;
var
  DLL_FPath: String;
begin
  try
    PDFiumInitCritSect.Enter;
    if (PdfiumModule <> 0) then
      Exit;

    DLL_FPath := PDFiumDLLPath + pdfium_dll;
    PdfiumModule := LoadLibrary(PChar(DLL_FPath));

    {$IFDEF LCLGTK2}
    if (PdfiumModule = 0) then
    begin
      DLL_FPath := ExtractFilePath(ParamStr(0)) + pdfium_dll;
      PdfiumModule := LoadLibrary(PChar(DLL_FPath));
    end;
    {$ENDIF}

    if (PdfiumModule = 0) then
    begin
      ErrorText := RsPdfDLLNotFound;
      StrongError := True;
      Exit;
    end;

    // Init Func
    FPDF_InitLibrary := TPDF_InitLibrary(GetProcAddress(PdfiumModule, 'FPDF_InitLibrary'));
    FPDF_CloseDocument := TPDF_CloseDocument(GetProcAddress(PdfiumModule, 'FPDF_CloseDocument'));
    FPDF_LoadMemDocument64 := TPDF_LoadMemDocument64(GetProcAddress(PdfiumModule, 'FPDF_LoadMemDocument64'));
    FPDF_LoadPage := TPDF_LoadPage(GetProcAddress(PdfiumModule, 'FPDF_LoadPage'));
    FPDF_GetPageCount := TPDF_GetPageCount(GetProcAddress(PdfiumModule, 'FPDF_GetPageCount'));
  {$IFNDEF Linux}
    FPDF_RenderPage := TPDF_RenderPage(GetProcAddress(PdfiumModule, 'FPDF_RenderPage'));
  {$ELSE}
    FPDFBitmap_Create := TPDFBitmap_Create(GetProcAddress(PdfiumModule, 'FPDFBitmap_Create'));
    FPDFBitmap_FillRect := TPDFBitmap_FillRect(GetProcAddress(PdfiumModule, 'FPDFBitmap_FillRect'));
    FPDF_RenderPageBitmap := TPDF_RenderPageBitmap(GetProcAddress(PdfiumModule, 'FPDF_RenderPageBitmap'));
    FPDFBitmap_GetBuffer := TPDFBitmap_GetBuffer(GetProcAddress(PdfiumModule, 'FPDFBitmap_GetBuffer'));
    FPDFBitmap_Destroy := TPDFBitmap_Destroy(GetProcAddress(PdfiumModule, 'FPDFBitmap_Destroy'));
  {$ENDIF}
    FPDF_GetPageWidthF := TPDF_GetPageWidthF(GetProcAddress(PdfiumModule, 'FPDF_GetPageWidthF'));
    FPDF_GetPageHeightF := TPDF_GetPageHeightF(GetProcAddress(PdfiumModule, 'FPDF_GetPageHeightF'));
    FPDFPage_HasTransparency := TPDFPage_HasTransparency(GetProcAddress(PdfiumModule, 'FPDFPage_HasTransparency'));
    FPDFPage_GetRotation := TPDFPage_GetRotation(GetProcAddress(PdfiumModule, 'FPDFPage_GetRotation'));
    FPDF_ClosePage := TPDF_ClosePage(GetProcAddress(PdfiumModule, 'FPDF_ClosePage'));
    FPDF_ImportPages := TPDF_ImportPages(GetProcAddress(PdfiumModule, 'FPDF_ImportPages'));
    FPDF_CreateNewDocument := TPDF_CreateNewDocument(GetProcAddress(PdfiumModule, 'FPDF_CreateNewDocument'));
    FPDF_SaveAsCopy := TPDF_SaveAsCopy(GetProcAddress(PdfiumModule, 'FPDF_SaveAsCopy'));
    FPDF_SaveWithVersion := TPDF_SaveWithVersion(GetProcAddress(PdfiumModule, 'FPDF_SaveWithVersion'));
    FPDF_GetLastError := TPDF_GetLastError(GetProcAddress(PdfiumModule, 'FPDF_GetLastError'));
    FPDF_SetPrintTextWithGDI := TPDF_SetPrintTextWithGDI(GetProcAddress(PdfiumModule, 'FPDF_SetPrintTextWithGDI'));
    FPDF_InitLibrary;
  finally
    PDFiumInitCritSect.Leave;
  end;
end;

procedure TPdfDocument.InternLoadFromMem(Buffer: PByte; Size: frInteger; const Password: String);
var
  APassword: AnsiString;
begin
  if Size > 0 then
  begin
    APassword := AnsiString(Password);
    if Password = '' then
      FDocument := frxPDF_LoadMemDocument64(Buffer, Size, nil)
    else
      FDocument := frxPDF_LoadMemDocument64(Buffer, Size, PAnsiChar(@APassword[1]));

    if FDocument = nil then
      RaiseLastPdfError;
    FPages.Count := frxPDF_GetPageCount(FDocument);
    FPageIndex := 0;
    PageContentChanged(False);
  end;
end;

function TPdfDocument.GetActive: Boolean;
begin
  Result := FDocument <> nil;
end;

function TPdfDocument.GetPageCount: Integer;
begin
  Result := FPages.Count;
end;

function TPdfDocument.IsPageValid: Boolean;
begin
  Result := Active and (PageIndex < PageCount);
end;

function TPdfDocument.GetCurrentPage: TPdfPage;
begin
  if IsPageValid then
    Result := Pages[PageIndex]
  else
    Result := nil;
end;

function TPdfDocument.GetPage(Index: Integer): TPdfPage;
var
  LPage: FPDF_PAGE;
begin
  Result := TPdfPage(FPages[Index]);
  if Result = nil then
  begin
    LPage := frxPDF_LoadPage(FDocument, Index);
    if LPage = nil then
      RaiseLastPdfError;
    Result := TPdfPage.Create(Self, LPage);
    FPages[Index] := Result;
  end
end;

procedure TPdfDocument.SetPageIndex(Value: Integer);
begin
  if Value >= PageCount then
    Value := PageCount - 1;
  if Value < 0 then
    Value := 0;

  if Value <> FPageIndex then
  begin
    if (FPageIndex >= 0) and (FPageIndex < PageCount) and IsPageLoaded(FPageIndex) then
      Pages[FPageIndex].Close;
    FPageIndex := Value;
    PageContentChanged(False);
  end;
end;

procedure TPdfDocument.SetErrorText(v: String);
begin
  if not StrongError then
    FErrorText := v;
end;

procedure TPdfDocument.PageContentChanged(Closing: Boolean);
begin
  CurrentPage.Open;
end;

function TPdfDocument.IsPageLoaded(PageIndex: Integer): Boolean;
begin
  Result := False;
  if (CurrentPage <> nil) then
    Result := CurrentPage.IsLoaded;
end;

procedure TPdfDocument.CheckActive;
begin
  if not Active then
    raise Exception.Create(RsPdfCheckActive);
end;

constructor TPdfDocument.Create;
begin
{$IFNDEF FPC}
  FDrawState := TfrEMFDrawState.Create;
{$ENDIF}
  FPages := TObjectList.Create;
  StrongError := False;
  try
    ErrorText := '';
    InitPDFium;
  except
    on E : Exception do
      ErrorText := E.Message;
  end;
end;

destructor TPdfDocument.Destroy;
begin
  Close;
  FreeAndNil(FPages);
{$IFNDEF FPC}
  FreeAndNil(FDrawState);
{$ENDIF}
end;

procedure TPdfDocument.Close;
var
  i: Integer;
begin
  for i := 0 to FPages.Count - 1 do
    if (FPages[i] <> nil) then
      TPdfPage(FPages[i]).Close;

  FPages.Clear;
  FPageIndex := 0;

  if FDocument <> nil then
  begin
    frxPDF_CloseDocument(FDocument);
    FDocument := nil;
  end;

  if FBuffer <> nil then
  begin
    FreeMem(FBuffer);
    FBuffer := nil;
  end;
end;

procedure TPdfDocument.Clear;
begin
  Close;
end;

procedure RaiseLastPdfError;
begin
  case (frxPDF_GetLastError()) of
    FPDF_ERR_SUCCESS:
      raise Exception.Create(RsPdfErrorSuccess);
    FPDF_ERR_FILE:
      raise Exception.Create(RsPdfErrorFile);
    FPDF_ERR_FORMAT:
      raise Exception.Create(RsPdfErrorFormat);
    FPDF_ERR_PASSWORD:
      raise Exception.Create(RsPdfErrorPassword);
    FPDF_ERR_SECURITY:
      raise Exception.Create(RsPdfErrorSecurity);
    FPDF_ERR_PAGE:
      raise Exception.Create(RsPdfErrorPage);
  else
    raise Exception.Create(RsPdfErrorUnknown);
  end;
end;

procedure TPdfDocument.LoadFromStream(AStream: TStream; const Password: String = '');
var
  Size: NativeInt;
begin
  if StrongError then
    Exit;
  ErrorText := '';
  Close;
  Size := AStream.Size;
  if Size > 0 then
  begin
    GetMem(FBuffer, Size);
    try
      AStream.ReadBuffer(FBuffer^, Size);
      InternLoadFromMem(FBuffer, Size, Password);
    except
      on E : Exception do
      begin
        Close;
        ErrorText := E.Message;
      end;
    end;
  end
  else ErrorText := RsPdfEmptyDocument;
end;

{$IFNDEF FPC}
function EnhMetaFileProc(DC: HDC; var lpHTable: THandleTable; var lpEMFR: TEnhMetaRecord; nObj: Integer; lpData: LPARAM): Integer; stdcall;
var
  xform: TXForm;
  LTransform: TEMRModifyWorldTransform absolute lpEMFR;
  LBrush: TLogBrush;
  LPen: HPEN;
  FDrawState: ^TfrEMFDrawState absolute lpData;
begin
  LPen := 0;
  try
    if lpEMFR.iType = EMR_ModifyWorldTransform then
      FDrawState^.NeedPathScaleDown := SameValue(LTransform.xform.eM11, EMF_PPI / 9600, 0.00001) and SameValue(LTransform.xform.eM22, EMF_PPI / 9600, 0.00001);
    if lpEMFR.iType in [EMR_POLYPOLYGON16, EMR_POLYGON16] then
    begin
      if FDrawState^.NeedPathScaleDown then
      begin
        ZeroMemory(@xform, sizeof(xform));
        xform.eM11 := (EMF_PPI / 72);
        xform.eM22 := (EMF_PPI / 72);
        ModifyWorldTransform(DC, xform, MWT_LEFTMULTIPLY);
        LBrush.lbStyle := FDrawState^.BrushStyle;
        LBrush.lbColor := FDrawState^.Color;
        LBrush.lbHatch := FDrawState^.Hatch;
        LPen := ExtCreatePen(FDrawState^.PenStyle, 1, LBrush, 0, nil);
        SelectObject(DC, LPen);
      end;
      FDrawState^.NeedPathScaleDown := False;
    end;
    if lpEMFR.iType = EMR_ExtCreatePen then
    begin
      FDrawState^.PenStyle := PEMRExtCreatePen(@lpEMFR)^.elp.elpPenStyle;
      FDrawState^.BrushStyle := PEMRExtCreatePen(@lpEMFR)^.elp.elpBrushStyle;
      FDrawState^.Color := PEMRExtCreatePen(@lpEMFR)^.elp.elpColor;
      FDrawState^.Hatch := PEMRExtCreatePen(@lpEMFR)^.elp.elpHatch;
    end;

    PlayEnhMetaFileRecord (DC, lpHTable, lpEMFR, nObj);
  finally
    if LPen > 0 then
      DeleteObject(LPen);
    Result := 1;
  end;
end;
{$ENDIF}

procedure TPdfDocument.Paint(Canvas: Tcanvas; Rect: TRect; Rotation: Integer; DrawOptions: TPdfDrawOptions);
  procedure DrawOnMetafile;
{$IFNDEF FPC}
  var
    emf: TMetafile;
    c: TMetafileCanvas;
    xForm: TXForm;
  begin
    emf := TMetafile.Create;
    emf.Width := Round(CurrentPage.Width);
    emf.Height := Round(CurrentPage.Height);
    try
      c := TMetafileCanvas.Create(emf, 0);
      SetGraphicsMode(C.Handle, GM_ADVANCED);
      xForm.eM11 := 1 / (EMF_PPI / 72);
      xForm.eM12 := 0.0;
      xForm.eM21 :=  0.0;
      xForm.eM22 := 1 / (EMF_PPI / 72);
      xForm.eDx  :=  0.0;
      xForm.eDy  := 0.0;
      SetWorldTransform(C.Handle, xForm);
      try
        CurrentPage.Draw(C, 0, 0, Round(CurrentPage.Width * EMF_PPI / 72), Round(CurrentPage.Height * EMF_PPI / 72), Rotation, DrawOptions  + [pdoPrinting]);
      finally
        c.Free;
      end;
      //Canvas.StretchDraw(Rect, emf);
      EnumEnhMetaFile(Canvas.Handle, emf.Handle, @EnhMetaFileProc, @FDrawState, Rect);
    finally
      emf.Free;
    end;
{$ELSE}
  begin
    CurrentPage.Draw(Canvas, Rect.Left, Rect.Top, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top, Rotation, DrawOptions)
{$ENDIF}
  end;
begin
  if IsPageValid then
  begin
    if pdoUseMetafile in DrawOptions then
      DrawOnMetafile
    else
      CurrentPage.Draw(Canvas, Rect.Left, Rect.Top, Rect.Right - Rect.Left, Rect.Bottom - Rect.Top, Rotation, DrawOptions)
  end
  else
  begin
    with Canvas do
    begin
      Font.Name := 'Arial';
      Font.Size := Round(10);
      Font.Color := clBlue;
      Rect.Left := Rect.Left + 2;
      Rect.Top := Rect.Top + 2;
      DrawText(Handle, PChar(RsPdfInvalidPage), Length(RsPdfInvalidPage), Rect,
        DT_WORDBREAK);
    end;
  end;
end;

function TPdfDocument.ReloadPage(APage: TPdfPage): FPDF_PAGE;
var
  Index: Integer;
begin
  CheckActive;
  Index := FPages.IndexOf(APage);
  Result := frxPDF_LoadPage(FDocument, Index);
  if Result = nil then
    RaiseLastPdfError;
end;

function TPdfDocument.NewDocument: Boolean;
begin
  Close;
  FDocument := frxPDF_CreateNewDocument();
  Result := FDocument <> nil;
end;

function TPdfDocument.ImportPages(Source: TPdfDocument; const Range: string = ''; Index: Integer = -1): Boolean;
var
  A: AnsiString;
  I, NewCount, OldCount, InsertCount: Integer;
begin
  CheckActive;
  Source.CheckActive;

  OldCount := frxPDF_GetPageCount(FDocument);
  if Index < 0 then
    Index := OldCount;
  A := AnsiString(Range);
  Result := frxPDF_ImportPages(FDocument, Source.FDocument, PAnsiChar(Pointer(A)), Index) <> 0;
  NewCount := frxPDF_GetPageCount(FDocument);
  InsertCount := NewCount - OldCount;
  if InsertCount > 0 then
  begin
    FPages.Count := NewCount;
    if Index < OldCount then
    begin
      Move(FPages.List[Index], FPages.List[Index + InsertCount], (OldCount - Index) * SizeOf(TObject));
      for I := Index to Index + InsertCount - 1 do
        FPages[Index] := nil;
    end;
  end;
end;

function WriteBlockToStream(pThis: PFPDF_FILEWRITE; pData: Pointer; size: LongWord): Integer; cdecl;
begin
  Result := Ord(LongWord(PFPDFFileWriteEx(pThis)^.Stream.Write(pData^, size)) = size);
end;

procedure TPdfDocument.SaveToStream(Stream: TStream; Option: TPdfDocumentSaveOption = dsoRemoveSecurity; FileVersion: Integer = -1);
var
  FileWriteInfo: TFPDFFileWriteEx;
begin
  CheckActive;

  FileWriteInfo.Inner.version := 1;
  FileWriteInfo.Inner.WriteBlock := @WriteBlockToStream;
  FileWriteInfo.Stream := Stream;

  if FileVersion <> -1 then
    frxPDF_SaveWithVersion(FDocument, @FileWriteInfo, Ord(Option), FileVersion)
  else
    frxPDF_SaveAsCopy(FDocument, @FileWriteInfo, Ord(Option));
end;

{frxPDF_...}

procedure Lock;
begin
  PDFiumInitCritSect.Enter;
end;

procedure UnLock;
begin
  PDFiumInitCritSect.Leave;
end;

procedure frxPDF_InitLibrary();
begin
  Lock;
  FPDF_InitLibrary;
  UnLock;
end;

procedure frxPDF_CloseDocument(document: FPDF_DOCUMENT);
begin
  Lock;
  FPDF_CloseDocument(document);
  UnLock;
end;

function frxPDF_LoadMemDocument64(data_buf: Pointer; size: frInteger; password: FPDF_BYTESTRING): FPDF_DOCUMENT;
begin
  Lock;
  Result := FPDF_LoadMemDocument64(data_buf, size, password);
  UnLock;
end;

function frxPDF_LoadPage(document: FPDF_DOCUMENT; page_index: Integer): FPDF_PAGE;
begin
  Lock;
  Result := FPDF_LoadPage(document, page_index);
  UnLock;
end;

function frxPDF_GetPageCount(document: FPDF_DOCUMENT): Integer;
begin
  Lock;
  Result := FPDF_GetPageCount(document);
  UnLock;
end;

{$IFNDEF Linux}
procedure frxPDF_RenderPage(DC: HDC; page: FPDF_PAGE; start_x, start_y, size_x, size_y: Integer;
  rotate: Integer; flags: Integer);
begin
  Lock;
  FPDF_RenderPage(DC, page, start_x, start_y, size_x, size_y, rotate, flags);
  UnLock;
end;
{$ELSE}
function frxPDFBitmap_Create(width, height: Integer; alpha: Integer): FPDF_BITMAP;
begin
  Lock;
  Result := FPDFBitmap_Create(width, height, alpha);
  UnLock;
end;

procedure frxPDFBitmap_FillRect(bitmap: FPDF_BITMAP; left, top, width, height: Integer; color: FPDF_DWORD);
begin
  Lock;
  FPDFBitmap_FillRect(bitmap, left, top, width, height, color);
  UnLock;
end;

procedure frxPDF_RenderPageBitmap(bitmap: FPDF_BITMAP; page: FPDF_PAGE; start_x, start_y, size_x, size_y: Integer; rotate: Integer; flags: Integer);
begin
  Lock;
  FPDF_RenderPageBitmap(bitmap, page, start_x, start_y, size_x, size_y, rotate, flags);
  UnLock;
end;

function frxPDFBitmap_GetBuffer(bitmap: FPDF_BITMAP): Pointer;
begin
  Lock;
  Result := FPDFBitmap_GetBuffer(bitmap);
  UnLock;
end;

procedure frxPDFBitmap_Destroy(bitmap: FPDF_BITMAP);
begin
  Lock;
  FPDFBitmap_Destroy(bitmap);
  UnLock;
end;
{$ENDIF}

function frxPDF_GetPageWidthF(page: FPDF_PAGE): Single;
begin
  Lock;
  Result := FPDF_GetPageWidthF(page);
  UnLock;
end;

function frxPDF_GetPageHeightF(page: FPDF_PAGE): Single;
begin
  Lock;
  Result := FPDF_GetPageHeightF(page);
  UnLock;
end;

function frxPDFPage_HasTransparency(page: FPDF_PAGE): FPDF_BOOL;
begin
  Lock;
  Result := FPDFPage_HasTransparency(page);
  UnLock;
end;

function frxPDFPage_GetRotation(page: FPDF_PAGE): Integer;
begin
  Lock;
  Result := FPDFPage_GetRotation(page);
  UnLock;
end;

procedure frxPDF_ClosePage(page: FPDF_PAGE);
begin
  Lock;
  FPDF_ClosePage(page);
  UnLock;
end;

function frxPDF_ImportPages(dest_doc, src_doc: FPDF_DOCUMENT; pagerange: FPDF_BYTESTRING; index: Integer): FPDF_BOOL;
begin
  Lock;
  Result := FPDF_ImportPages(dest_doc, src_doc, pagerange, index);
  UnLock;
end;

function frxPDF_CreateNewDocument: FPDF_DOCUMENT;
begin
  Lock;
  Result := FPDF_CreateNewDocument();
  UnLock;
end;

function frxPDF_SaveAsCopy(document: FPDF_DOCUMENT; pFileWrite: PFPDF_FILEWRITE; flags: FPDF_DWORD): FPDF_BOOL;
begin
  Lock;
  Result := FPDF_SaveAsCopy(document, pFileWrite, flags);
  UnLock;
end;

function frxPDF_SaveWithVersion(document: FPDF_DOCUMENT; pFileWrite: PFPDF_FILEWRITE;
  flags: FPDF_DWORD; fileVersion: Integer): FPDF_BOOL;
begin
  Lock;
  Result := FPDF_SaveWithVersion(document, pFileWrite, flags, fileVersion);
  UnLock;
end;

function frxPDF_GetLastError(): LongWord;
begin
  Lock;
  Result := FPDF_GetLastError();
  UnLock;
end;

procedure frxPDF_SetPrintTextWithGDI(use_gdi: LongBool);
begin
  Lock;
  FPDF_SetPrintTextWithGDI(use_gdi);
  UnLock;
end;

procedure frxRenderPage(vCanvas: TCanvas; page: FPDF_PAGE; start_x, start_y, size_x, size_y: Integer;
  rotate: Integer; flags: Integer);
{$IFDEF Linux}
var
  PDF_Bitmap: FPDF_BITMAP;
  bmp: TBitmap;
  PBuf: PInteger;
{$ENDIF}
begin
{$IFNDEF Linux}
  frxPDF_RenderPage(vCanvas.Handle, page, start_x, start_y, size_x, size_y, rotate, flags);
{$ELSE}
  PDF_Bitmap := frxPDFBitmap_Create(size_x, size_y, 0);
  frxPDFBitmap_FillRect(PDF_Bitmap, 0, 0, size_x, size_y, $00FFFFFF);
  frxPDF_RenderPageBitmap(PDF_Bitmap, page, 0, 0, size_x, size_y, rotate, flags);

  PBuf := frxPDFBitmap_GetBuffer(PDF_Bitmap);
  bmp := TBitmap.Create;
  bmp.Handle := CreateBitmap(size_x, size_y, 1, 32, PBuf);
  stretchblt(vCanvas.Handle, start_x, start_y + size_y, size_x, -size_y, bmp.Canvas.Handle, 0, 0, bmp.Width, bmp.Height, srccopy);
  bmp.Free;

  frxPDFBitmap_Destroy(PDF_Bitmap);
{$ENDIF}
end;

initialization
  PDFiumInitCritSect := TCriticalSection.Create;
  PdfiumModule := 0;
  PDFiumDLLPath := '';

finalization
  PDFiumInitCritSect.Free;

end.
