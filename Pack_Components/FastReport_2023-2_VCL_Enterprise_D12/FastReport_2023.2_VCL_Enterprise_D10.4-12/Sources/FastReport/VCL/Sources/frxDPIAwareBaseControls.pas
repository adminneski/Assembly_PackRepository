
{******************************************}
{                                          }
{             FastReport VCL               }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

{ it used to reduce precompiler directives }
{ some interfaces was introduces only in lastest Delphi }
unit frxDPIAwareBaseControls;

interface

{$I frx.inc}

uses
  {$IFNDEF FPC}Windows, Messages, {$ENDIF}
  SysUtils, Classes, frDPIAwareUtils, frDPIAwareControls, Controls, StdCtrls, ExtCtrls, ComCtrls,
{$IFDEF FPC}
  LazarusPackageIntf, LazHelper,
{$ENDIF}
  frTypes;

type
  TfrxDPIAwareBasePanel = class(TCustomPanel)
  private
    FCurrentPPI: Integer;
    procedure WMDpiChanged(var Message: TMessage); message FRX_WM_DPICHANGED_AFTERPARENT;
  protected
    procedure DoPPIChanged(aNewPPI: Integer); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    function GetScale: Single;
    function GetReleativeScale: Single;
{$IFDEF DELPHI24}
    procedure ScaleForPPI(NewPPI: Integer); override;
{$ENDIF}
    property CurrentPPI: Integer read FCurrentPPI write FCurrentPPI;
  end;


  TfrxDPIAwarePanel = class(TfrxDPIAwareBasePanel)
  public
    property DockManager;
  published
    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;
    property BevelInner;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property BorderWidth;
    property BorderStyle;
    property Caption;
    property Color;
    property Constraints;
{$IFNDEF FPC}
    property Ctl3D;
    property BevelKind;
{$ENDIF}
    property UseDockManager default True;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FullRepaint;
    property Font;
{$IFNDEF FPC}
    property Locked;
{$ENDIF}
    property ParentBiDiMode;
    property ParentBackground;
    property ParentColor;
{$IFNDEF FPC}
    property ParentCtl3D;
{$ENDIF}
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
{$IFNDEF FPC}
    property OnCanResize;
{$ENDIF}
    property OnClick;
    property OnConstrainedResize;
    property OnContextPopup;
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

  { TfrxDPIAwareCustomControl }

  TfrxDPIAwareCustomControl = class(TfrDPIAwareCustomControl)
  private
    procedure WMDpiChanged(var Message: TMessage); message FRX_WM_DPICHANGED_AFTERPARENT;
  public
    constructor Create(AOwner: TComponent); override;
{$IFDEF DELPHI24}
    procedure ScaleForPPI(NewPPI: Integer); override;
{$ENDIF}
  end;

implementation

uses Forms;

{ TfrxDPIAwareBasePanel }

constructor TfrxDPIAwareBasePanel.Create(AOwner: TComponent);
begin
  inherited;
  FCurrentPPI := Screen.PixelsPerInch;
end;

procedure TfrxDPIAwareBasePanel.DoPPIChanged(aNewPPI: Integer);
begin

end;

function TfrxDPIAwareBasePanel.GetReleativeScale: Single;
begin
  Result := FCurrentPPI / Screen.PixelsPerInch;
end;

function TfrxDPIAwareBasePanel.GetScale: Single;
begin
  Result := FCurrentPPI / 96;
end;

{$IFDEF DELPHI24}
procedure TfrxDPIAwareBasePanel.ScaleForPPI(NewPPI: Integer);
begin
  inherited;
  if NewPPI = FCurrentPPI then Exit;
  DoPPIChanged(NewPPI);
  FCurrentPPI := NewPPI;
end;
{$ENDIF}

procedure TfrxDPIAwareBasePanel.WMDpiChanged(var Message: TMessage);
var
  NewPPI: Integer;
begin
  Inherited;
  NewPPI := frxGetDpiForWindow(Handle);
  if NewPPI = FCurrentPPI then Exit;
  DoPPIChanged(NewPPI);
  FCurrentPPI := NewPPI;
end;

{ TfrxDPIAwareCustomControl }

constructor TfrxDPIAwareCustomControl.Create(AOwner: TComponent);
begin
  inherited;
  FCurrentPPI := Screen.PixelsPerInch;
end;

{$IFDEF DELPHI24}
procedure TfrxDPIAwareCustomControl.ScaleForPPI(NewPPI: Integer);
begin
  inherited;
  PPIChanged(NewPPI);
end;
{$ENDIF}

procedure TfrxDPIAwareCustomControl.WMDpiChanged(var Message: TMessage);
begin
  Inherited;
  PPIChanged(frxGetDpiForWindow(Handle));
end;

end.
