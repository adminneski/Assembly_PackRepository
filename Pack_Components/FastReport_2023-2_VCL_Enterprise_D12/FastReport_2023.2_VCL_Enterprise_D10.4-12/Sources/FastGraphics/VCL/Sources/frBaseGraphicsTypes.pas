
{******************************************}
{                                          }
{          FastReport VCL/FMX/LCL          }
{             Graphics Library             }
{                                          }
{         Copyright (c) 1998-2022          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frBaseGraphicsTypes;

interface

{$I frVer.inc}

uses
  Classes, Graphics, Types;

type
  TfrxGraphicQuality = (gqDefault, gqFast, gqHiQuality, gqPrint);
  TfrxGraphicDrawProp = (fgdAutoSize, fgdCenter, fgdKeepAspectRatio, fgdStretch, fgdTransparent, fgdClip, fgdDefaultMaskColor, fgdHiQuality { backward compatibility });
  TfrxGraphicDrawProps = set of TfrxGraphicDrawProp;
  TfrxThumbnailBuildType = (tbtNone, tbtOriginal, tbtAtPrepare, tbtAtSave, tbtAtPreview);
  TfrxPercentage =  0 .. 100;
  TfrxCachedGraphicType = (cgNone, cgOriginal, cgThumbnail);
  TfrPictureHashMapResultType = (phmIndex, phmData);
  TfrxLoadPictureToMethod = function (APicture: TPicture; aGraphic: TGraphic; ImageIndex: Integer): TGraphic of object;

  IfrxCachedGraphic = interface
  ['{13DA72E5-E8D1-4DEA-931A-8A729CB877E1}']
    procedure Draw(Canvas: TCanvas; X, Y, X1, Y1: Integer);
    function GetGraphic(CacheType: TfrxCachedGraphicType): TGraphic;
    function GetCacheType: TfrxCachedGraphicType;
    procedure SetCacheType(CacheType: TfrxCachedGraphicType);
    function GetOriginalSize: TSize;
  end;

  IfrxPictureCache = interface
    ['{06FD066C-726D-4BC0-811D-94150807E798}']
    function AddPicture(aGraphic: TGraphic): Integer;
    procedure GetGraphic(aGraphic: TGraphic; ImageIndex: Integer); overload;
    function GetGraphic(ImageIndex: Integer): TGraphic; overload;
    procedure GetPicture(APicture: TPicture; ImageIndex: Integer);
    function GetCachedBitmap(CacheType: TfrxCachedGraphicType; ImageIndex: Integer): IfrxCachedGraphic;
    function IsAutoRefMode: Boolean;
    function GetSize(const CacheType: TfrxCachedGraphicType; const ImageIndex: Integer): TSize;
  end;

  IfrxCachedView = interface
    ['{1E87267F-436A-4BFF-A6E9-0D03DD69F56C}']
    //function GetIndex: Integer;
    procedure SetCachedGraphic(const PictureCache: IfrxPictureCache);
    procedure GetCachedGraphic(ACacheType: TfrxCachedGraphicType; const PictureCache: IfrxPictureCache);
    function IsUpdateRequired(NewCacheType: TfrxCachedGraphicType): Boolean;
  //  function SetCachedGraphic(Index: Integer; cGraphic: IfrxCachedGraphic): Boolean;
//    function LoadSourceGraphic(Index: Integer; ALoadPictureTo: TfrxLoadPictureToMethod): Boolean;
    procedure ReleaseCachedGraphic;
  end;

  TfrxPictureConverterOptions = class(TPersistent)
  private
    FReducePercent: TfrxPercentage;
    FMinHeight: Integer;
    FMaxWidth: Integer;
    FMinWidth: Integer;
    FMaxHeight: Integer;
    procedure SetMinHeight(const Value: Integer);
    procedure SetMinWidth(const Value: Integer);
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
  published
    property MinWidth: Integer read FMinWidth write SetMinWidth default 32;
    property MaxWidth: Integer read FMaxWidth write FMaxWidth default MaxInt;
    property MinHeight: Integer read FMinHeight write SetMinHeight default 32;
    property MaxHeight: Integer read FMaxHeight write FMaxHeight default MaxInt;
    property ReducePercent: TfrxPercentage read FReducePercent write FReducePercent;
  end;

  TfrxPictureCacheOptions = class;

  TfrxPictureCacheOptions = class(TPersistent)
  private
    FCachedImagesBuildType: TfrxThumbnailBuildType;
    FThumbnailQualityReducer: TfrxPictureConverterOptions;
    FOriginalQualityReducer: TfrxPictureConverterOptions;
    FCalculateHash: Boolean;
    procedure SetOriginalQualityReducer(
      const Value: TfrxPictureConverterOptions);
    procedure SetThumbnailQualityReducer(
      const Value: TfrxPictureConverterOptions);
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    function GetPercentFor(const CacheType: TfrxCachedGraphicType; const Width, Height: Integer): TfrxPercentage;
  published
    property CalculateHash: Boolean read FCalculateHash write FCalculateHash default False;
    property OriginalQualityReducer: TfrxPictureConverterOptions read FOriginalQualityReducer write SetOriginalQualityReducer;
    property CachedImagesBuildType: TfrxThumbnailBuildType read FCachedImagesBuildType write FCachedImagesBuildType default tbtNone;
    property ThumbnailQualityReducer: TfrxPictureConverterOptions read FThumbnailQualityReducer write SetThumbnailQualityReducer;
  end;


implementation

uses Math;
{ TfrxPictureCacheOptions }

procedure TfrxPictureCacheOptions.Assign(Source: TPersistent);
begin
  if Source is TfrxPictureCacheOptions then
  begin
    OriginalQualityReducer := TfrxPictureCacheOptions(Source).OriginalQualityReducer;
    CachedImagesBuildType := TfrxPictureCacheOptions(Source).CachedImagesBuildType;
    ThumbnailQualityReducer := TfrxPictureCacheOptions(Source).ThumbnailQualityReducer;
    CalculateHash := TfrxPictureCacheOptions(Source).CalculateHash;
  end;
end;

constructor TfrxPictureCacheOptions.Create;
begin
  FOriginalQualityReducer := TfrxPictureConverterOptions.Create;
  FThumbnailQualityReducer := TfrxPictureConverterOptions.Create;
end;

destructor TfrxPictureCacheOptions.Destroy;
begin
  FOriginalQualityReducer.Free;
  FThumbnailQualityReducer.Free;
  inherited;
end;

function TfrxPictureCacheOptions.GetPercentFor(
  const CacheType: TfrxCachedGraphicType; const Width,
  Height: Integer): TfrxPercentage;
var
  LQualityReducer: TfrxPictureConverterOptions;
  LMinW, LMaxW, LMinH, LMaxH: Integer;
begin
  LQualityReducer := OriginalQualityReducer;
  Result := 0;
  case CacheType of
    cgOriginal: LQualityReducer := OriginalQualityReducer;
    cgThumbnail: LQualityReducer := ThumbnailQualityReducer;
  end;
  LMinW := Max(LQualityReducer.MinWidth, 32);
  LMaxW := Min(LQualityReducer.MaxWidth, MaxInt);
  LMinH := Max(LQualityReducer.MinHeight, 32);
  LMaxH := Min(LQualityReducer.MaxHeight, MaxInt);
  if (LMinW <= Width) and (LMaxW >= Width) then
    Result := LQualityReducer.ReducePercent;
  if (LMinH <= Height) and (LMaxH >= Height) then
    Result := LQualityReducer.ReducePercent;
end;

procedure TfrxPictureCacheOptions.SetOriginalQualityReducer(
  const Value: TfrxPictureConverterOptions);
begin
  FOriginalQualityReducer.Assign(Value);
end;

procedure TfrxPictureCacheOptions.SetThumbnailQualityReducer(
  const Value: TfrxPictureConverterOptions);
begin
  FThumbnailQualityReducer.Assign(Value);
end;

{ TfrxPictureConverterOptions }

procedure TfrxPictureConverterOptions.Assign(Source: TPersistent);
begin
  if Source is TfrxPictureConverterOptions then
  begin
    ReducePercent := TfrxPictureConverterOptions(Source).ReducePercent;
    MinWidth := TfrxPictureConverterOptions(Source).MinWidth;
    MaxWidth := TfrxPictureConverterOptions(Source).MaxWidth;
    MinHeight := TfrxPictureConverterOptions(Source).MinHeight;
    MaxHeight := TfrxPictureConverterOptions(Source).MaxHeight;
  end;
end;

constructor TfrxPictureConverterOptions.Create;
begin
  FMaxWidth := MaxInt;
  FMaxHeight := MaxInt;
end;

procedure TfrxPictureConverterOptions.SetMinHeight(const Value: Integer);
begin
  FMinHeight := Value;
  if FMinHeight < 32 then FMinHeight := 32;
end;

procedure TfrxPictureConverterOptions.SetMinWidth(const Value: Integer);
begin
  FMinWidth := Value;
  if FMinWidth < 32 then FMinWidth := 32;
end;

end.
