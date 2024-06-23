
{******************************************}
{                                          }
{             FastReport VCL               }
{               GS1 Databars               }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{             Fast Reports, Inc.           }
{                                          }
{******************************************}

unit frxGS1Databar;

interface

{$I frx.inc}

uses
{$IFDEF FPC}
  LCLType, LMessages, LazHelper, LCLIntf,
{$ELSE}
  Windows, Messages,
{$ENDIF}
  SysUtils, Types, StrUtils, Classes, Graphics, Controls, Forms, Dialogs, frxBarcode2DBase, frxGS1Databar_Helper;


type
  TfrxGS1Databar = class(TfrxBarcode2DBaseWithUnion)
  private
    base: TBaseDatabar;
  public
    constructor Create; override;
    destructor  Destroy; override;
    procedure   Assign(src: TfrxBarcode2DBase); override;
    function IsScaled: Boolean; override;
  end;

  TfrxGS1DatabarE = class(TfrxGS1Databar)
  protected
    procedure GenerateLM(Text: string; rebase: Boolean = True); override;
  end;

  TfrxGS1DatabarES = class(TfrxGS1Databar)
  protected
    FColumns: Integer;
    procedure SetColumns(Col: Integer);
    procedure GenerateLM(Text: string; rebase: Boolean = True); override;
  public
    constructor Create; override;
    property Columns: Integer read FColumns write SetColumns;
  end;


implementation


{ TfrxBarcodeQR }

procedure TfrxGS1Databar.Assign(src: TfrxBarcode2DBase);
var
   BSource : TfrxGS1Databar;
begin
   inherited;
   if src is TfrxGS1Databar then
   begin
      BSource    := TfrxGS1Databar(src);
      FHeight    := BSource.FHeight;
      QuietZone := BSource.QuietZone;
   end;
end;

destructor TfrxGS1Databar.Destroy;
begin
  FreeAndNil(base);
  inherited;
end;

function TfrxGS1Databar.IsScaled: Boolean;
begin
  Result := True;
end;

constructor TfrxGS1Databar.Create;
begin
  inherited;
  PixelWidth := 1;
  PixelHeight := 1;
  QuietZone := 0;
  FHeight := 0;
  Text := '(01)12345678901234';
end;

constructor TfrxGS1DatabarES.Create;
begin
  FColumns := 2;
  inherited;
end;

procedure TfrxGS1DatabarE.GenerateLM(Text: string; rebase: Boolean = True);
var
  i, iLeft: Integer;
  black: Boolean;
begin
  ClearFigures;
  if rebase then
    try
      FreeAndNil(base);
      base := Code_DBEorES(Text, False);
    except
      on e : Exception do
      begin
        ErrorText := e.Message;
        base := nil;
      end;
    end;
  if base = nil then
  begin
    if ErrorText = '' then
      ErrorText := 'base = nil';
    exit;
  end
  else
    ErrorText := '';
  FWidth := CalcSumArrayOfInteger(base.elements);
  black := false;
  i := 0;
  iLeft := 0;
  while(base.elements[i] > 0) do
  begin
    if(black) then
    begin
      FVectorPrimitivesAdd(iLeft, 0, base.elements[i], FHeight);
    end;
    black := not black;
    inc(iLeft, base.elements[i]);
    inc(i);
  end;
end;

procedure TfrxGS1DatabarES.GenerateLM(Text: string; rebase: Boolean = True);
var
  i, row, BarHeight, block_width, LX, LY, SumMil, BigLineHeight, kolBigLine: Integer;
  isspace: Boolean;
begin
  ClearFigures;
  if rebase then
    try
      FreeAndNil(base);
      base := Code_DBEorES(Text, True, FColumns);
    except
      on e : Exception do
      begin
        ErrorText := e.Message;
        base := nil;
      end;
    end;
  if base = nil then
  begin
    if ErrorText = '' then
      ErrorText := 'base = nil';
    exit;
  end
  else
    ErrorText := '';
  SumMil := 0;
  for i := 0 to Length(base.row_height) - 1 do
    inc(SumMil, base.row_height[i]);
  kolBigLine := SumMil div 3 + 1;
  BigLineHeight := (FHeight - SumMil) div kolBigLine; // BigLinesHeight = (FHeight - SumMil);
  if BigLineHeight < 1 then
    BigLineHeight := 1;
  LY := 0;
  for row := 0 to base.rows - 1 do
  begin
    LX := 0;
    isspace := not module_is_set(base.symbol, row, LX);
    if base.row_height[row] = 0 then
      BarHeight := BigLineHeight
    else
      BarHeight := 1;
    repeat
      block_width := 0;
      repeat
        Inc(block_width);
        if (LX + block_width >= base.width) then
          break;
      until not (module_is_set(base.symbol, row, LX + block_width) = module_is_set(base.symbol, row, LX));
      if not isspace then
        FVectorPrimitivesAdd(LX, LY, block_width, BarHeight);
      inc(LX, block_width);
      isspace := not isspace;
    until LX >= base.width;
    if(LY = 0) then
      FWidth := LX;
    inc(LY, BarHeight);
  end;
end;

procedure TfrxGS1DatabarES.SetColumns(Col: Integer);
begin
  FColumns := Col;
  GenerateLM(Text);
end;

end.
