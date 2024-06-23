{******************************************}
{                                          }
{          FastReport VCL/FMX/LCL          }
{              Core Library                }
{                                          }
{         Copyright (c) 1998-2022          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frDPIAwareControls;

interface

{$I frVer.inc}

uses
  Classes, Controls;

type

  { TfrDPIAwareCustomControl }

  TfrDPIAwareCustomControl = class(TCustomControl)
  protected
    FCurrentPPI: Integer;

    procedure DoPPIChanged(aNewPPI: Integer); virtual;
    procedure PPIChanged(aNewPPI: Integer);

    procedure BeforePPIChange; virtual;
    procedure AfterPPIChange; virtual;
  public
    function GetReleativeScale: Single;
    function GetScale: Single;

    property CurrentPPI: Integer read FCurrentPPI write FCurrentPPI;
  end;

  TfrDPIAwareBaseControl = class(TfrDPIAwareCustomControl)
  protected
{$IFDEF FPC}
    procedure AutoAdjustLayout(AMode: TLayoutAdjustmentPolicy; const AFromPPI,
      AToPPI, AOldFormWidth, ANewFormWidth: Integer); override;
{$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
{$IFDEF DELPHI24}
    procedure ChangeScale(M: Integer; D: Integer; isDpiChange: Boolean); override;
{$ELSE}
    procedure ChangeScale(M, D: Integer); override;
{$ENDIF}
  end;

implementation

uses
  Forms,
  frUtils, frDPIAwareUtils;

{ TfrDPIAwareCustomControl }

function TfrDPIAwareCustomControl.GetReleativeScale: Single;
begin
  Result := FCurrentPPI / Screen.PixelsPerInch;
end;

function TfrDPIAwareCustomControl.GetScale: Single;
begin
  Result := FCurrentPPI / FR_DefaultPPI;
end;

procedure TfrDPIAwareCustomControl.DoPPIChanged(ANewPPI: Integer);
begin
//
end;

procedure TfrDPIAwareCustomControl.PPIChanged(ANewPPI: Integer);
begin
  if ANewPPI <> FCurrentPPI then
  begin
    DoPPIChanged(ANewPPI);
    FCurrentPPI := ANewPPI;
  end;
end;

procedure TfrDPIAwareCustomControl.BeforePPIChange;
begin
//
end;

procedure TfrDPIAwareCustomControl.AfterPPIChange;
begin
//
end;

{ TfrDPIAwareBaseControl }

constructor TfrDPIAwareBaseControl.Create(AOwner: TComponent);
begin
  inherited;
  FCurrentPPI := FR_DefaultPPI;
end;

{$IFDEF FPC}
procedure TfrDPIAwareBaseControl.AutoAdjustLayout(AMode: TLayoutAdjustmentPolicy; const AFromPPI,
  AToPPI, AOldFormWidth, ANewFormWidth: Integer);
begin
  inherited;
  PPIChanged(AToPPI);
end;
{$ENDIF}

{$IFDEF DELPHI24}
procedure TfrDPIAwareBaseControl.ChangeScale(M: Integer; D: Integer; isDpiChange: Boolean);
begin
  BeforePPIChange;
  try
    inherited;
    if M <> D then
      PPIChanged(M);
    if isDpiChange then
      FCurrentPPI := M;
  finally
    AfterPPIChange;
  end;
end;
{$ELSE}

procedure TfrDPIAwareBaseControl.ChangeScale(M, D: Integer);
begin
  BeforePPIChange;
  try
    inherited;
    if M <> D then
      PPIChanged(frApplyPPI(CurrentPPI, M, D));
  finally
    AfterPPIChange;
  end;
end;
{$ENDIF}

end.
