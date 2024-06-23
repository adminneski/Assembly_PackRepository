
{******************************************}
{                                          }
{             FastReport VCL               }
{               PTT Databars               }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxBarcodePharmacodeTT;

interface

{$I frx.inc}

uses
{$IFDEF FPC}
  LCLType, LMessages, LazHelper, LCLIntf,
{$ELSE}
  Windows, Messages,
{$ENDIF}
  SysUtils, Types, StrUtils, Classes, Graphics, Controls, Forms, Dialogs,
  frxBarcode2DBase;


type
  TfrxPTTDatabar = class(TfrxBarcode2DBaseWithUnion)
  private
    base: String;
  protected
    procedure GenerateLM(Text: string; rebase: Boolean = True); override;
  public
    constructor Create; override;
    procedure   Assign(src: TfrxBarcode2DBase); override;
    function IsScaled: Boolean; override;
  end;

implementation


{ TfrxBarcodeQR }

constructor TfrxPTTDatabar.Create;
begin
  inherited;
  PixelWidth := 1;
  PixelHeight := 1;
  QuietZone := 0;
  FHeight := 0;
  Text := '12345678';
end;

procedure TfrxPTTDatabar.Assign(src: TfrxBarcode2DBase);
var
   BSource : TfrxPTTDatabar;
begin
   inherited;
   if src is TfrxPTTDatabar then
   begin
      BSource    := TfrxPTTDatabar(src);
      FHeight    := BSource.FHeight;
      QuietZone := BSource.QuietZone;
   end;
end;

function TfrxPTTDatabar.IsScaled: Boolean;
begin
  Result := True;
end;

procedure TfrxPTTDatabar.GenerateLM(Text: string; rebase: Boolean = True);
var
  i, iLeft, HalfHeigh: Integer;
const
  WCoeff = 4;
  DWCoeff = WCoeff * 2;

  function CalcPTT(data: String): String;
  var
    buf: Cardinal;
  begin
    buf := StrToIntDef(data, 0);
    if ((buf < 4) or (buf > 64570080)) then
      raise Exception.Create('Must be digital from 4 to 64,570,080');
    Result := '';
    repeat
      case (buf mod 3) of
        0:
        begin
          Result := '0' + Result;
          buf := (buf - 3) div 3;
        end;
        1:
        begin
          Result := '1' + Result;
          buf := (buf - 1) div 3;
        end;
        2:
        begin
          Result := '2' + Result;
          buf := (buf - 2) div 3;
        end;
      end;
    until not (buf <> 0);
  end;

begin
  ClearFigures;
  if rebase then
    try
      base := CalcPTT(FText);
    except
      on e : Exception do
      begin
        ErrorText := e.Message;
        base := '';
      end;
    end;
  if base = '' then
  begin
    if ErrorText = '' then
      ErrorText := 'base = nil';
    exit;
  end
  else
    ErrorText := '';
  FWidth := (Length(base) * 2 - 1) * WCoeff;
  iLeft := 0;
  FHeight := FHeight + FHeight mod 2;
  HalfHeigh := FHeight div 2;
  for i := 1 to Length(base) do
  begin
    case base[i] of
      '0': FVectorPrimitivesAdd(iLeft, 0,         WCoeff, FHeight);
      '1': FVectorPrimitivesAdd(iLeft, HalfHeigh, WCoeff, HalfHeigh);
      '2': FVectorPrimitivesAdd(iLeft, 0,         WCoeff, HalfHeigh);
    end;
    iLeft := iLeft + DWCoeff;
  end;
end;

end.
