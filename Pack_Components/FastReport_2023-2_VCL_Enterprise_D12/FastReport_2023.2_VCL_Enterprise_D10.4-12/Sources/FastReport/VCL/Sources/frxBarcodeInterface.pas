
{******************************************}
{                                          }
{             FastReport VCL               }
{            Barcode Interfaxe             }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxBarcodeInterface;

interface

{$I frx.inc}

uses
  Graphics, Classes, frxClass;

type
  TfrxBarTextPos = (btpTop = 0, btpBottom = 1);

  TfrxBarcodeText = class;

  TfrxTextSettings = class(TPersistent)
  private
    FBarcodeText: TfrxBarcodeText;
    FFont: TFont;
    FBarTextPos: TfrxBarTextPos;
    procedure SetBarTextPos(val: TfrxBarTextPos);
  public
    constructor Create(vBarcodeText: TfrxBarcodeText; vSize: Integer; vBarTextPos: TfrxBarTextPos);
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
  published
    property Font: TFont read FFont;
    property BarTextPos: TfrxBarTextPos read FBarTextPos write SetBarTextPos;
  end;

  TfrxBarcodeText = class(TPersistent)
  private
    FTextSettings: TfrxTextSettings;
    FSupSettings: TfrxTextSettings;
    FLock: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    procedure Lock;
    procedure UnLock;
    function IsLock: Boolean;
  published
    property TextSettings: TfrxTextSettings read FTextSettings write FTextSettings;
    property SupSettings: TfrxTextSettings read FSupSettings write FSupSettings;
  end;


  IfrxBarCodeView = interface
  ['{CF6CB462-96D3-43AA-9FBD-EB949BBB51C0}']
    function GetBarcodeText: TfrxBarcodeText;
    procedure SetBarcodeText(const Value: TfrxBarcodeText);
    function GetBarcodeType: Integer;
    procedure SetBarcodeType(const Value: Integer);
    function GetText: String;
    procedure SetText(Value: String);
    function GetTextSup: String;
    procedure SetTextSup(Value: String);
    procedure SetZoom(v: Extended);
    function GetZoom: Extended;

    function GetFontHeightTop: Integer;
    function GetFontHeightBottom: Integer;

    property BarcodeText: TfrxBarcodeText read GetBarcodeText write SetBarcodeText;
    property BarcodeType: Integer read GetBarcodeType write SetBarcodeType;
    property Text: String read GetText write SetText;
    property TextSup: String read GetTextSup write SetTextSup;
    property Zoom: Extended read GetZoom write SetZoom;
  end;

function GetFontHeight(comp: TfrxComponent; val: TfrxBarTextPos): Integer;
function RotPTB(valPTB: TfrxBarTextPos; Angle: Double): Integer;

implementation

{ TfrxBarcodeText }

constructor TfrxTextSettings.Create(vBarcodeText: TfrxBarcodeText; vSize: Integer; vBarTextPos: TfrxBarTextPos);
begin
  FBarcodeText := vBarcodeText;
  FFont := TFont.Create;
  FFont.Name := 'Arial';
  FFont.Size := vSize;
  FFont.PixelsPerInch := 96;
  FBarTextPos := vBarTextPos;
end;

destructor TfrxTextSettings.Destroy;
begin
  FFont.Free;
  inherited;
end;

procedure TfrxTextSettings.Assign(Source: TPersistent);
begin
  inherited;
  if (Source is TfrxTextSettings) then
  begin
    FFont.Assign(TfrxTextSettings(Source).Font);
    FBarTextPos := TfrxTextSettings(Source).BarTextPos;
  end;
end;

procedure TfrxTextSettings.SetBarTextPos(val: TfrxBarTextPos);
var
  OtherBarTextPos : TfrxTextSettings;
begin
  FBarTextPos := val;
  if (FBarcodeText.FTextSettings = Self) then
    OtherBarTextPos := FBarcodeText.SupSettings
  else
    OtherBarTextPos := FBarcodeText.TextSettings;
  if (not FBarcodeText.IsLock) then
  begin
    FBarcodeText.Lock;
    OtherBarTextPos.BarTextPos := TfrxBarTextPos((Ord(val) + 1) mod 2);
    FBarcodeText.UnLock;
  end;
end;

{ TfrxBarcodeText }

constructor TfrxBarcodeText.Create;
begin
  inherited;
  FTextSettings := TfrxTextSettings.Create(Self, 9, btpBottom);
  FSupSettings := TfrxTextSettings.Create(Self, 7, btpTop);
  FLock := False;
end;

destructor TfrxBarcodeText.Destroy;
begin
  FTextSettings.Free;
  FSupSettings.Free;
  inherited;
end;

procedure TfrxBarcodeText.Assign(Source: TPersistent);
begin
  inherited;
  if (Source is TfrxBarcodeText) then
  begin
    FTextSettings.Assign(TfrxBarcodeText(Source).FTextSettings);
    FSupSettings.Assign(TfrxBarcodeText(Source).FSupSettings);
  end;
end;

procedure TfrxBarcodeText.Lock;
begin
  FLock := True;
end;

procedure TfrxBarcodeText.UnLock;
begin
  FLock := False;
end;

function TfrxBarcodeText.IsLock: Boolean;
begin
  Result := FLock;
end;

{ Other }

function GetFontHeight(comp: TfrxComponent;val: TfrxBarTextPos): Integer;
var
  bcv: IfrxBarCodeView;
begin
  bcv := comp as IfrxBarCodeView;
  if (bcv.BarcodeText.TextSettings.BarTextPos = val) then
  begin
    Result := Round((- comp.Font.Height + 4) * bcv.Zoom);
  end
  else
  if ((bcv.BarcodeText.SupSettings.BarTextPos = val) and (bcv.TextSup <> '')) then
  begin
    Result := Round((- bcv.BarcodeText.SupSettings.Font.Height + 4) * bcv.Zoom);
  end
  else
    Result := 0;
end;

function RotPTB(valPTB: TfrxBarTextPos; Angle: Double): Integer;
begin
  Result := 0;
  case valPTB of
    btpTop: Result := 180;
  end;
  Result := (Result + Round(Angle)) mod 360;
end;

end.