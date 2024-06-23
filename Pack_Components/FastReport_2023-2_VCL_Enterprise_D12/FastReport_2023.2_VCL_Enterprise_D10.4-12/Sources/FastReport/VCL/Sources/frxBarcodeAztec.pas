{******************************************}
{                                          }
{             FastReport VCL               }
{               Aztec code                 }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxBarcodeAztec;

interface

{$I frx.inc}

uses
{$IFDEF FPC}
  LCLType, LMessages, LazHelper, LCLIntf,
{$ELSE}
  Windows, Messages,
{$ENDIF}
  SysUtils, Types, StrUtils, Classes, Graphics, Controls, Forms, Dialogs,
  frxBarcode2DBase, frxDelphiZXIngAztecCode;

type
  TfrxBarcodeAztec = class(TfrxBarcode2DBaseWithUnion)
  private
    function GetPixelSize: integer;
    procedure SetPixelSize(const Value: integer);
    function GetMinECCPercent: integer;
    procedure SetMinECCPercent(const Value: integer);
  protected
    FAztecEncoder: TAztecEncoder;

    procedure Generate;
    procedure SetText(v: string); override;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Assign(src: TfrxBarcode2DBase); override;
  published
    property PixelSize: integer read GetPixelSize write SetPixelSize;
    property MinECCPercent: integer read GetMinECCPercent
      write SetMinECCPercent;
  end;

implementation

{ TfrxBarcodeAztec }

procedure TfrxBarcodeAztec.Assign(src: TfrxBarcode2DBase);
var
  BarcodeAztec: TfrxBarcodeAztec;
begin
  inherited;
  if src is TfrxBarcodeAztec then
  begin
    BarcodeAztec := src as TfrxBarcodeAztec;

    PixelSize := BarcodeAztec.PixelSize;
    MinECCPercent := BarcodeAztec.MinECCPercent;
  end;
end;

constructor TfrxBarcodeAztec.Create;
begin
  inherited;
  FAztecEncoder := TAztecEncoder.Create;
  FAztecEncoder.Data := FText;

  PixelSize := 4;
  MinECCPercent := DEFAULT_EC_PERCENT;

  Generate;
end;

destructor TfrxBarcodeAztec.Destroy;
begin
  FAztecEncoder.Free;
  inherited;
end;

procedure TfrxBarcodeAztec.Generate;
begin
  FWidth := FAztecEncoder.MatrixSize;
  FHeight := FWidth;
  T2DBooleanArrayToVectorPrimitives(FAztecEncoder.FElements, FHeight, FWidth);
end;

function TfrxBarcodeAztec.GetMinECCPercent: integer;
begin
  Result := FAztecEncoder.MinECCPercent;
end;

function TfrxBarcodeAztec.GetPixelSize: integer;
begin
  Result := FPixelWidth;
end;

procedure TfrxBarcodeAztec.SetMinECCPercent(const Value: integer);
begin
  FAztecEncoder.MinECCPercent := Value;
  Generate;
end;

procedure TfrxBarcodeAztec.SetPixelSize(const Value: integer);
begin
  FPixelWidth := Value;
  FPixelHeight := Value;
end;

procedure TfrxBarcodeAztec.SetText(v: string);
begin
  inherited;
  ErrorText := '';
  try
    FAztecEncoder.Data := v;
  except
    on e: Exception do
      ErrorText := e.Message;
  end;
  Generate;
end;

end.

