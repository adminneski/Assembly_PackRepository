{*******************************************************}
{                                                       }
{                        EhLib 10.2                     }
{                                                       }
{                  TEhLibImageResources                 }
{                                                       }
{   Copyright (c) 2020-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit EhLibImageReses;

interface

uses
  Messages,
  {$IFDEF EH_LIB_17} System.UITypes, {$ENDIF}
  {$IFDEF FPC}
    EhLibLCL, LMessages, LCLType, LCLIntf,
    {$IFDEF FPC_CROSSP}
    {$ELSE}
      Windows,
    {$ENDIF}
  {$ELSE}
    EhLibVCL, SqlTimSt, Windows, UxTheme,
  {$ENDIF}
  SysUtils, Classes, Controls, Forms, StdCtrls, Contnrs,
  Graphics, Types;

type

{ TResourceImageItemEh }

  TResourceImageItemEh = class(TPersistent)
  private
    FStdImages: TObjectList;
    FDisableImages: TObjectList;

  protected
    procedure ClearImages(Images: TObjectList); virtual;

  public
    constructor Create;
    destructor Destroy; override;

    procedure InitGraphics(AStdImages: array of TGraphic; ADisableImages: array of TGraphic); virtual;

    function GetGraphic(MaxSize: TSize; ScaleFactor: Double; IsDisabled: Boolean; IsDackTheme: Boolean): TGraphic; virtual;
    function GetImageForScale(Images: TObjectList; MaxSize: TSize; ScaleFactor: Double): TGraphic; virtual;
  end;


{ TEhLibImageResources }

  TEhLibImageResources = class(TPersistent)
  private
    FGridScrollBarNavCancelImageItem: TResourceImageItemEh;
    FGridScrollBarNavDeleteImageItem: TResourceImageItemEh;
    FGridScrollBarNavEditImageItem: TResourceImageItemEh;
    FGridScrollBarNavFirstImageItem: TResourceImageItemEh;
    FGridScrollBarNavInsertImageItem: TResourceImageItemEh;
    FGridScrollBarNavLastImageItem: TResourceImageItemEh;
    FGridScrollBarNavNextImageItem: TResourceImageItemEh;
    FGridScrollBarNavPostImageItem: TResourceImageItemEh;
    FGridScrollBarNavPriorImageItem: TResourceImageItemEh;
    FGridScrollBarNavRefreshImageItem: TResourceImageItemEh;
    FSearchPanelCancelSearchImageItem: TResourceImageItemEh;
    FSearchPanelFilterImageItem: TResourceImageItemEh;
    FSearchPanelFindNextImageItem: TResourceImageItemEh;
    FSearchPanelFindPriorImageItem: TResourceImageItemEh;
    FSearchPanelMenuImageItem: TResourceImageItemEh;
    FCustomizeColumnsDialogRight: TResourceImageItemEh;
    FCustomizeColumnsDialogDown: TResourceImageItemEh;
    FCustomizeColumnsDialogUp: TResourceImageItemEh;
    FCustomizeColumnsDialogLeft: TResourceImageItemEh;
    FCustomizeColumnsDialogSetColWidth: TResourceImageItemEh;
  public
    constructor Create;
    destructor Destroy; override;

    property GridScrollBarNavFirstImageItem: TResourceImageItemEh read FGridScrollBarNavFirstImageItem write FGridScrollBarNavFirstImageItem;
    property GridScrollBarNavPriorImageItem: TResourceImageItemEh read FGridScrollBarNavPriorImageItem write FGridScrollBarNavPriorImageItem;
    property GridScrollBarNavNextImageItem: TResourceImageItemEh read FGridScrollBarNavNextImageItem write FGridScrollBarNavNextImageItem;
    property GridScrollBarNavLastImageItem: TResourceImageItemEh read FGridScrollBarNavLastImageItem write FGridScrollBarNavLastImageItem;
    property GridScrollBarNavInsertImageItem: TResourceImageItemEh read FGridScrollBarNavInsertImageItem write FGridScrollBarNavInsertImageItem;
    property GridScrollBarNavDeleteImageItem: TResourceImageItemEh read FGridScrollBarNavDeleteImageItem write FGridScrollBarNavDeleteImageItem;
    property GridScrollBarNavEditImageItem: TResourceImageItemEh read FGridScrollBarNavEditImageItem write FGridScrollBarNavEditImageItem;
    property GridScrollBarNavPostImageItem: TResourceImageItemEh read FGridScrollBarNavPostImageItem write FGridScrollBarNavPostImageItem;
    property GridScrollBarNavCancelImageItem: TResourceImageItemEh read FGridScrollBarNavCancelImageItem write FGridScrollBarNavCancelImageItem;
    property GridScrollBarNavRefreshImageItem: TResourceImageItemEh read FGridScrollBarNavRefreshImageItem write FGridScrollBarNavRefreshImageItem;

    property SearchPanelCancelSearchImageItem: TResourceImageItemEh read FSearchPanelCancelSearchImageItem write FSearchPanelCancelSearchImageItem;
    property SearchPanelFindNextImageItem: TResourceImageItemEh read FSearchPanelFindNextImageItem write FSearchPanelFindNextImageItem;
    property SearchPanelFindPriorImageItem: TResourceImageItemEh read FSearchPanelFindPriorImageItem write FSearchPanelFindPriorImageItem;
    property SearchPanelMenuImageItem: TResourceImageItemEh read FSearchPanelMenuImageItem write FSearchPanelMenuImageItem;
    property SearchPanelFilterImageItem: TResourceImageItemEh read FSearchPanelFilterImageItem write FSearchPanelFilterImageItem;

    property CustomizeColumnsDialogDown: TResourceImageItemEh read FCustomizeColumnsDialogDown write FCustomizeColumnsDialogDown;
    property CustomizeColumnsDialogUp: TResourceImageItemEh read FCustomizeColumnsDialogUp write FCustomizeColumnsDialogUp;
    property CustomizeColumnsDialogLeft: TResourceImageItemEh read FCustomizeColumnsDialogLeft write FCustomizeColumnsDialogLeft;
    property CustomizeColumnsDialogRight: TResourceImageItemEh read FCustomizeColumnsDialogRight write FCustomizeColumnsDialogRight;
    property CustomizeColumnsDialogSetColWidth: TResourceImageItemEh read FCustomizeColumnsDialogSetColWidth write FCustomizeColumnsDialogSetColWidth;
  end;

function EhLibImageResources: TEhLibImageResources;

implementation

uses EhLibImageListRes;

var
  FEhLibImageResources: TEhLibImageResources;

function EhLibImageResources: TEhLibImageResources;
begin
  Result := FEhLibImageResources;
end;

{$IFDEF FPC}
{$ELSE}
const
  PixelsQuad = MaxInt div SizeOf(TRGBQuad) - 1;
type
  TRGBAArray = Array [0..PixelsQuad - 1] of TRGBQuad;
  PRGBAArray = ^TRGBAArray;
{$ENDIF}

{ TResourceImageItemEh }

constructor TResourceImageItemEh.Create;
begin
  FStdImages := TObjectList.Create(False);
  FDisableImages := TObjectList.Create(False);
end;

destructor TResourceImageItemEh.Destroy;
begin
  ClearImages(FStdImages);
  FreeAndNil(FStdImages);

  ClearImages(FDisableImages);
  FreeAndNil(FDisableImages);

  inherited Destroy;
end;

procedure TResourceImageItemEh.ClearImages(Images: TObjectList);
var
  i: Integer;
begin
  for i := 0 to Images.Count-1 do
  begin
    Images[i].Free;
    Images[i] := nil;
  end;
  Images.Clear;
end;

procedure TResourceImageItemEh.InitGraphics(AStdImages, ADisableImages: array of TGraphic);
var
  I: Integer;
begin
  ClearImages(FStdImages);
  for I := Low(AStdImages) to High(AStdImages) do
    FStdImages.Add(AStdImages[i]);

  ClearImages(FDisableImages);
  for I := Low(ADisableImages) to High(ADisableImages) do
    FDisableImages.Add(ADisableImages[i]);
end;

function TResourceImageItemEh.GetGraphic(MaxSize: TSize; ScaleFactor: Double;
  IsDisabled, IsDackTheme: Boolean): TGraphic;
begin
  if IsDisabled then
  begin
    if FDisableImages.Count = 1 then
      Result := TGraphic(FDisableImages[0])
    else
      Result := GetImageForScale(FDisableImages, MaxSize, ScaleFactor);
  end else
  begin
    if FStdImages.Count = 1 then
      Result := TGraphic(FStdImages[0])
    else
      Result := GetImageForScale(FStdImages, MaxSize, ScaleFactor);
  end;
end;

function TResourceImageItemEh.GetImageForScale(Images: TObjectList; MaxSize: TSize; ScaleFactor: Double): TGraphic;
var
  NewSize: Integer;
  I: Integer;
  Image: TGraphic;
begin
  Result := TGraphic(Images[0]);
  NewSize := Trunc(TGraphic(Images[0]).Width * ScaleFactor);
  for i := Images.Count - 1 downto 1 do
  begin
    Image := TGraphic(Images[i]);
    if (Image <> nil) and
       (Image.Width <= NewSize) and
       (MaxSize.cx > Image.Width) then
    begin
      Result := Image;
      Exit;
    end;
  end;
end;

{ TEhLibImageResources }

constructor TEhLibImageResources.Create;
var
  dm: TEhLibImageListDataMod;
  StdImages: array of TGraphic;
  DisableImages: array of TGraphic;
begin
  dm := EhLibImageListDataMod;

  SetLength(StdImages, 3);
  SetLength(DisableImages, 3);

  
  StdImages[0] := dm.GetImageFromImageList(dm.imList12_12, 0);
  StdImages[1] := dm.GetImageFromImageList(dm.imList16_16, 0);
  StdImages[2] := dm.GetImageFromImageList(dm.imList24_24, 0);

  DisableImages[0] := dm.GetImageFromImageList(dm.imList12_12_Dis, 0);
  DisableImages[1] := dm.GetImageFromImageList(dm.imList16_16_Dis, 0);
  DisableImages[2] := dm.GetImageFromImageList(dm.imList24_24_Dis, 0);

  FGridScrollBarNavFirstImageItem := TResourceImageItemEh.Create;
  FGridScrollBarNavFirstImageItem.InitGraphics(StdImages, DisableImages);

  
  StdImages[0] := dm.GetImageFromImageList(dm.imList12_12, 1);
  StdImages[1] := dm.GetImageFromImageList(dm.imList16_16, 1);
  StdImages[2] := dm.GetImageFromImageList(dm.imList24_24, 1);

  DisableImages[0] := dm.GetImageFromImageList(dm.imList12_12_Dis, 1);
  DisableImages[1] := dm.GetImageFromImageList(dm.imList16_16_Dis, 1);
  DisableImages[2] := dm.GetImageFromImageList(dm.imList24_24_Dis, 1);

  FGridScrollBarNavPriorImageItem := TResourceImageItemEh.Create;
  FGridScrollBarNavPriorImageItem.InitGraphics(StdImages, DisableImages);

  
  StdImages[0] := dm.GetImageFromImageList(dm.imList12_12, 2);
  StdImages[1] := dm.GetImageFromImageList(dm.imList16_16, 2);
  StdImages[2] := dm.GetImageFromImageList(dm.imList24_24, 2);

  DisableImages[0] := dm.GetImageFromImageList(dm.imList12_12_Dis, 2);
  DisableImages[1] := dm.GetImageFromImageList(dm.imList16_16_Dis, 2);
  DisableImages[2] := dm.GetImageFromImageList(dm.imList24_24_Dis, 2);

  FGridScrollBarNavNextImageItem := TResourceImageItemEh.Create;
  FGridScrollBarNavNextImageItem.InitGraphics(StdImages, DisableImages);

  
  StdImages[0] := dm.GetImageFromImageList(dm.imList12_12, 3);
  StdImages[1] := dm.GetImageFromImageList(dm.imList16_16, 3);
  StdImages[2] := dm.GetImageFromImageList(dm.imList24_24, 3);

  DisableImages[0] := dm.GetImageFromImageList(dm.imList12_12_Dis, 3);
  DisableImages[1] := dm.GetImageFromImageList(dm.imList16_16_Dis, 3);
  DisableImages[2] := dm.GetImageFromImageList(dm.imList24_24_Dis, 3);

  FGridScrollBarNavLastImageItem := TResourceImageItemEh.Create;
  FGridScrollBarNavLastImageItem.InitGraphics(StdImages, DisableImages);

  
  StdImages[0] := dm.GetImageFromImageList(dm.imList12_12, 4);
  StdImages[1] := dm.GetImageFromImageList(dm.imList16_16, 4);
  StdImages[2] := dm.GetImageFromImageList(dm.imList24_24, 4);

  DisableImages[0] := dm.GetImageFromImageList(dm.imList12_12_Dis, 4);
  DisableImages[1] := dm.GetImageFromImageList(dm.imList16_16_Dis, 4);
  DisableImages[2] := dm.GetImageFromImageList(dm.imList24_24_Dis, 4);

  FGridScrollBarNavInsertImageItem := TResourceImageItemEh.Create;
  FGridScrollBarNavInsertImageItem.InitGraphics(StdImages, DisableImages);

  
  StdImages[0] := dm.GetImageFromImageList(dm.imList12_12, 5);
  StdImages[1] := dm.GetImageFromImageList(dm.imList16_16, 5);
  StdImages[2] := dm.GetImageFromImageList(dm.imList24_24, 5);

  DisableImages[0] := dm.GetImageFromImageList(dm.imList12_12_Dis, 5);
  DisableImages[1] := dm.GetImageFromImageList(dm.imList16_16_Dis, 5);
  DisableImages[2] := dm.GetImageFromImageList(dm.imList24_24_Dis, 5);

  FGridScrollBarNavDeleteImageItem := TResourceImageItemEh.Create;
  FGridScrollBarNavDeleteImageItem.InitGraphics(StdImages, DisableImages);

  
  StdImages[0] := dm.GetImageFromImageList(dm.imList12_12, 6);
  StdImages[1] := dm.GetImageFromImageList(dm.imList16_16, 6);
  StdImages[2] := dm.GetImageFromImageList(dm.imList24_24, 6);

  DisableImages[0] := dm.GetImageFromImageList(dm.imList12_12_Dis, 6);
  DisableImages[1] := dm.GetImageFromImageList(dm.imList16_16_Dis, 6);
  DisableImages[2] := dm.GetImageFromImageList(dm.imList24_24_Dis, 6);

  FGridScrollBarNavEditImageItem := TResourceImageItemEh.Create;
  FGridScrollBarNavEditImageItem.InitGraphics(StdImages, DisableImages);

  
  StdImages[0] := dm.GetImageFromImageList(dm.imList12_12, 7);
  StdImages[1] := dm.GetImageFromImageList(dm.imList16_16, 7);
  StdImages[2] := dm.GetImageFromImageList(dm.imList24_24, 7);

  DisableImages[0] := dm.GetImageFromImageList(dm.imList12_12_Dis, 7);
  DisableImages[1] := dm.GetImageFromImageList(dm.imList16_16_Dis, 7);
  DisableImages[2] := dm.GetImageFromImageList(dm.imList24_24_Dis, 7);

  FGridScrollBarNavPostImageItem := TResourceImageItemEh.Create;
  FGridScrollBarNavPostImageItem.InitGraphics(StdImages, DisableImages);

  
  StdImages[0] := dm.GetImageFromImageList(dm.imList12_12, 8);
  StdImages[1] := dm.GetImageFromImageList(dm.imList16_16, 8);
  StdImages[2] := dm.GetImageFromImageList(dm.imList24_24, 8);

  DisableImages[0] := dm.GetImageFromImageList(dm.imList12_12_Dis, 8);
  DisableImages[1] := dm.GetImageFromImageList(dm.imList16_16_Dis, 8);
  DisableImages[2] := dm.GetImageFromImageList(dm.imList24_24_Dis, 8);

  FGridScrollBarNavCancelImageItem := TResourceImageItemEh.Create;
  FGridScrollBarNavCancelImageItem.InitGraphics(StdImages, DisableImages);

  
  StdImages[0] := dm.GetImageFromImageList(dm.imList12_12, 9);
  StdImages[1] := dm.GetImageFromImageList(dm.imList16_16, 9);
  StdImages[2] := dm.GetImageFromImageList(dm.imList24_24, 9);

  DisableImages[0] := dm.GetImageFromImageList(dm.imList12_12_Dis, 9);
  DisableImages[1] := dm.GetImageFromImageList(dm.imList16_16_Dis, 9);
  DisableImages[2] := dm.GetImageFromImageList(dm.imList24_24_Dis, 9);

  FGridScrollBarNavRefreshImageItem := TResourceImageItemEh.Create;
  FGridScrollBarNavRefreshImageItem.InitGraphics(StdImages, DisableImages);

  
  StdImages[0] := dm.GetImageFromImageList(dm.imList12_12, 10);
  StdImages[1] := dm.GetImageFromImageList(dm.imList16_16, 10);
  StdImages[2] := dm.GetImageFromImageList(dm.imList24_24, 10);

  DisableImages[0] := dm.GetImageFromImageList(dm.imList12_12_Dis, 10);
  DisableImages[1] := dm.GetImageFromImageList(dm.imList16_16_Dis, 10);
  DisableImages[2] := dm.GetImageFromImageList(dm.imList24_24_Dis, 10);

  FSearchPanelCancelSearchImageItem := TResourceImageItemEh.Create;
  FSearchPanelCancelSearchImageItem.InitGraphics(StdImages, DisableImages);

  
  StdImages[0] := dm.GetImageFromImageList(dm.imList12_12, 11);
  StdImages[1] := dm.GetImageFromImageList(dm.imList16_16, 11);
  StdImages[2] := dm.GetImageFromImageList(dm.imList24_24, 11);

  DisableImages[0] := dm.GetImageFromImageList(dm.imList12_12_Dis, 11);
  DisableImages[1] := dm.GetImageFromImageList(dm.imList16_16_Dis, 11);
  DisableImages[2] := dm.GetImageFromImageList(dm.imList24_24_Dis, 11);

  FSearchPanelFindNextImageItem := TResourceImageItemEh.Create;
  FSearchPanelFindNextImageItem.InitGraphics(StdImages, DisableImages);

  
  StdImages[0] := dm.GetImageFromImageList(dm.imList12_12, 12);
  StdImages[1] := dm.GetImageFromImageList(dm.imList16_16, 12);
  StdImages[2] := dm.GetImageFromImageList(dm.imList24_24, 12);

  DisableImages[0] := dm.GetImageFromImageList(dm.imList12_12_Dis, 12);
  DisableImages[1] := dm.GetImageFromImageList(dm.imList16_16_Dis, 12);
  DisableImages[2] := dm.GetImageFromImageList(dm.imList24_24_Dis, 12);

  FSearchPanelFindPriorImageItem := TResourceImageItemEh.Create;
  FSearchPanelFindPriorImageItem.InitGraphics(StdImages, DisableImages);

  
  StdImages[0] := dm.GetImageFromImageList(dm.imList12_12, 13);
  StdImages[1] := dm.GetImageFromImageList(dm.imList16_16, 13);
  StdImages[2] := dm.GetImageFromImageList(dm.imList24_24, 13);

  DisableImages[0] := dm.GetImageFromImageList(dm.imList12_12_Dis, 13);
  DisableImages[1] := dm.GetImageFromImageList(dm.imList16_16_Dis, 13);
  DisableImages[2] := dm.GetImageFromImageList(dm.imList24_24_Dis, 13);

  FSearchPanelMenuImageItem := TResourceImageItemEh.Create;
  FSearchPanelMenuImageItem.InitGraphics(StdImages, DisableImages);

  
  StdImages[0] := dm.GetImageFromImageList(dm.imList12_12, 14);
  StdImages[1] := dm.GetImageFromImageList(dm.imList16_16, 14);
  StdImages[2] := dm.GetImageFromImageList(dm.imList24_24, 14);

  DisableImages[0] := dm.GetImageFromImageList(dm.imList12_12_Dis, 14);
  DisableImages[1] := dm.GetImageFromImageList(dm.imList16_16_Dis, 14);
  DisableImages[2] := dm.GetImageFromImageList(dm.imList24_24_Dis, 14);

  FSearchPanelFilterImageItem := TResourceImageItemEh.Create;
  FSearchPanelFilterImageItem.InitGraphics(StdImages, DisableImages);

  
  StdImages[0] := dm.GetImageFromImageList(dm.imList16_16, 16);
  StdImages[1] := dm.GetImageFromImageList(dm.imList16_16, 16);
  StdImages[2] := dm.GetImageFromImageList(dm.imList16_16, 16);

  DisableImages[0] := dm.GetImageFromImageList(dm.imList16_16, 16);
  DisableImages[1] := dm.GetImageFromImageList(dm.imList16_16, 16);
  DisableImages[2] := dm.GetImageFromImageList(dm.imList16_16, 16);

  FCustomizeColumnsDialogDown := TResourceImageItemEh.Create;
  FCustomizeColumnsDialogDown.InitGraphics(StdImages, DisableImages);

  
  StdImages[0] := dm.GetImageFromImageList(dm.imList16_16, 17);
  StdImages[1] := dm.GetImageFromImageList(dm.imList16_16, 17);
  StdImages[2] := dm.GetImageFromImageList(dm.imList16_16, 17);

  DisableImages[0] := dm.GetImageFromImageList(dm.imList16_16, 17);
  DisableImages[1] := dm.GetImageFromImageList(dm.imList16_16, 17);
  DisableImages[2] := dm.GetImageFromImageList(dm.imList16_16, 17);

  FCustomizeColumnsDialogUp := TResourceImageItemEh.Create;
  FCustomizeColumnsDialogUp.InitGraphics(StdImages, DisableImages);

  
  StdImages[0] := dm.GetImageFromImageList(dm.imList16_16, 18);
  StdImages[1] := dm.GetImageFromImageList(dm.imList16_16, 18);
  StdImages[2] := dm.GetImageFromImageList(dm.imList16_16, 18);

  DisableImages[0] := dm.GetImageFromImageList(dm.imList16_16, 18);
  DisableImages[1] := dm.GetImageFromImageList(dm.imList16_16, 18);
  DisableImages[2] := dm.GetImageFromImageList(dm.imList16_16, 18);

  FCustomizeColumnsDialogLeft := TResourceImageItemEh.Create;
  FCustomizeColumnsDialogLeft.InitGraphics(StdImages, DisableImages);

  
  StdImages[0] := dm.GetImageFromImageList(dm.imList16_16, 19);
  StdImages[1] := dm.GetImageFromImageList(dm.imList16_16, 19);
  StdImages[2] := dm.GetImageFromImageList(dm.imList16_16, 19);

  DisableImages[0] := dm.GetImageFromImageList(dm.imList16_16, 19);
  DisableImages[1] := dm.GetImageFromImageList(dm.imList16_16, 19);
  DisableImages[2] := dm.GetImageFromImageList(dm.imList16_16, 19);

  FCustomizeColumnsDialogRight := TResourceImageItemEh.Create;
  FCustomizeColumnsDialogRight.InitGraphics(StdImages, DisableImages);

  
  StdImages[0] := dm.GetImageFromImageList(dm.imList16_16, 20);
  StdImages[1] := dm.GetImageFromImageList(dm.imList16_16, 20);
  StdImages[2] := dm.GetImageFromImageList(dm.imList16_16, 20);

  DisableImages[0] := dm.GetImageFromImageList(dm.imList16_16, 20);
  DisableImages[1] := dm.GetImageFromImageList(dm.imList16_16, 20);
  DisableImages[2] := dm.GetImageFromImageList(dm.imList16_16, 20);

  FCustomizeColumnsDialogSetColWidth := TResourceImageItemEh.Create;
  FCustomizeColumnsDialogSetColWidth.InitGraphics(StdImages, DisableImages);
end;

destructor TEhLibImageResources.Destroy;
begin
  FreeAndNil(FGridScrollBarNavCancelImageItem);
  FreeAndNil(FGridScrollBarNavDeleteImageItem);
  FreeAndNil(FGridScrollBarNavEditImageItem);
  FreeAndNil(FGridScrollBarNavFirstImageItem);
  FreeAndNil(FGridScrollBarNavInsertImageItem);
  FreeAndNil(FGridScrollBarNavLastImageItem);
  FreeAndNil(FGridScrollBarNavNextImageItem);
  FreeAndNil(FGridScrollBarNavPostImageItem);
  FreeAndNil(FGridScrollBarNavPriorImageItem);
  FreeAndNil(FGridScrollBarNavRefreshImageItem);
  FreeAndNil(FSearchPanelCancelSearchImageItem);
  FreeAndNil(FSearchPanelFilterImageItem);
  FreeAndNil(FSearchPanelFindNextImageItem);
  FreeAndNil(FSearchPanelFindPriorImageItem);
  FreeAndNil(FSearchPanelMenuImageItem);

  FreeAndNil(FCustomizeColumnsDialogRight);
  FreeAndNil(FCustomizeColumnsDialogDown);
  FreeAndNil(FCustomizeColumnsDialogUp);
  FreeAndNil(FCustomizeColumnsDialogLeft);
  FreeAndNil(FCustomizeColumnsDialogSetColWidth);

  inherited Destroy;
end;

initialization
  FEhLibImageResources := TEhLibImageResources.Create;
finalization
  FreeAndNil(FEhLibImageResources);
end.

