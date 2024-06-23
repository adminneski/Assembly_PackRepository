{*******************************************************}
{                                                       }
{                       EhLib 10.2                      }
{                     Tool controls                     }
{                                                       }
{      Copyright (c) 2020-2022 by Dmitry V. Bolshakov   }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit EhLibImageListRes;

interface

uses
  SysUtils, Classes, ImgList, Controls,
  {$IFDEF FPC}
  EhLibLCL,
  {$ELSE}
  EhLibVCL, Windows,
  {$ENDIF}
  Graphics;

type
  TEhLibImageListDataMod = class(TDataModule)
    imList12_12: TImageList;
    imList12_12_Dis: TImageList;
    imList16_16: TImageList;
    imList16_16_Dis: TImageList;
    imList24_24: TImageList;
    imList24_24_Dis: TImageList;
  private
    { Private declarations }
  public
    function GetImageFromImageList(ImageList: TImageList; ImageIndex: Integer): TGraphic;
  end;

var
  EhLibImageListDataMod: TEhLibImageListDataMod;

implementation


{$IFDEF FPC}
{$R EhLibImageListResLaz.dfm}
{$ELSE}
{$R *.dfm}
{$ENDIF}

{ TEhLibImageListDataMod }

{$IFDEF FPC}
{$ELSE}
const
  PixelsQuad = MaxInt div SizeOf(TRGBQuad) - 1;
type
  TRGBAArray = Array [0..PixelsQuad - 1] of TRGBQuad;
  PRGBAArray = ^TRGBAArray;
{$ENDIF}

function TEhLibImageListDataMod.GetImageFromImageList(ImageList: TImageList;
  ImageIndex: Integer): TGraphic;
var
  {$IFDEF ImageListGetBitmap}
  {$ELSE}
  ARGBVal: TRGBQuad;
  pscanLine32, pscanLine32_src: PRGBAArray;
  il, ip: Integer;
  SrcBitmap: TBitmap;
  SrcStartLine: Integer;
  PicsPreLine: Integer;
  StartInLine: Integer;
  {$ENDIF}
  ResultBitmap: TBitmap;
begin

{$IFDEF ImageListGetBitmap}
  if (ImageIndex >= ImageList.Count) then
  begin
    Result := nil;
    Exit;
  end else
  begin
    ResultBitmap := TBitmap.Create();
//    {$IFDEF CROSSVCL}
//    ResultBitmap.SetSize(ImageList.Width, ImageList.Height);
//    ResultBitmap.AlphaFormat := afDefined;
//    ClearRectWithAlpha(ResultBitmap.Canvas.Handle, Rect(0, 0, ResultBitmap.Width, ResultBitmap.Height), 0, 0);
//    {$ENDIF}
    ImageList.GetBitmap(ImageIndex, ResultBitmap);
    Result := ResultBitmap;
  end;
{$ELSE} 

{$IFDEF EH_LIB_12} 
  ResultBitmap := TBitmap.Create();
{$ELSE}
  ResultBitmap := TBitmapEh32bit.Create();
{$ENDIF}

  SrcBitmap := TBitmap.Create;
  SrcBitmap.Handle := ImageList.GetImageBitmap;

  ResultBitmap.Width := ImageList.Width;
  ResultBitmap.Height := ImageList.Height;
  ResultBitmap.PixelFormat := pf32bit;

{$IFDEF EH_LIB_12} 
  ResultBitmap.AlphaFormat := afDefined; 
{$ENDIF}

  PicsPreLine := SrcBitmap.Width div ImageList.Width;
  StartInLine := ImageIndex mod PicsPreLine * ImageList.Width;
  SrcStartLine := ImageIndex div PicsPreLine * ImageList.Height;
  for il := 0 to ImageList.Height - 1 do
  begin
    pscanLine32_src := SrcBitmap.ScanLine[il + SrcStartLine];
    pscanLine32 := ResultBitmap.Scanline[il];
    for ip := 0 to ImageList.Width - 1 do
      begin
        ARGBVal.rgbReserved := pscanLine32_src[ip + StartInLine].rgbReserved;
        ARGBVal.rgbBlue := pscanLine32_src[ip + StartInLine].rgbBlue;
        ARGBVal.rgbRed := pscanLine32_src[ip + StartInLine].rgbRed;
        ARGBVal.rgbGreen := pscanLine32_src[ip + StartInLine].rgbGreen;
        pscanLine32[ip] := ARGBVal;
      end;
  end;

  SrcBitmap.Free;

  Result := ResultBitmap;
  
{$ENDIF} 
end;

initialization
  EhLibImageListDataMod := TEhLibImageListDataMod.CreateNew(nil, -1);
  InitInheritedComponent(EhLibImageListDataMod, TDataModule);
finalization
  FreeAndNil(EhLibImageListDataMod);
end.

