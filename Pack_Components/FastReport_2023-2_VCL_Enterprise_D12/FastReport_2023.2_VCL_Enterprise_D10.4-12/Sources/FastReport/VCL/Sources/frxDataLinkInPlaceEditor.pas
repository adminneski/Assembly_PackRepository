
{******************************************}
{                                          }
{             FastReport VCL               }
{         TeeChart InPlace Editor          }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxDataLinkInPlaceEditor;

interface

{$I frx.inc}
//{$I frTeeChartVer.inc} //Repacked Version Line deleted

uses
  {$IFNDEF Linux}
  Windows,
  {$ENDIF}
  Messages, SysUtils, Classes, Graphics, Controls,
  frxClass, frxInPlaceEditors
{$IFDEF DELPHI6}
, Variants
{$ENDIF};

type
  TfrxInPlaceDataLinkEditor = class(TfrxInPlaceEditor)
  protected
    FDrawButton: Boolean;
    FMouseDown: Boolean;
    function IsDataLinkSet: Boolean;
  public
    function DoMouseUp(X, Y: Integer; Button: TMouseButton;
      Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams): Boolean; override;
    procedure DrawCustomEditor(aCanvas: TCanvas; aRect: TRect); override;
    procedure InitializeUI(var EventParams: TfrxInteractiveEventsParams); override;
    procedure FinalizeUI(var EventParams: TfrxInteractiveEventsParams); override;
  end;

implementation

uses
  Math, frxRes, Types, Clipbrd, frXML, frxXMLSerializer, frxProtocolFactory;

type
  TfrxHackView = class(TfrxView);

{ TfrxInPlaceDataLinkEditor }

function TfrxInPlaceDataLinkEditor.DoMouseUp(X, Y: Integer; Button: TMouseButton;
  Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams): Boolean;
var
  aRect: TRect;
  DataLink: IfrxDataLinkObject;
  sLink: String;
begin
  Result := Inherited DoMouseUp(X, Y, Button, Shift, EventParams);
  aRect.TopLeft := Point(TfrxHackView(FComponent).FX + (TfrxHackView(FComponent).FX1 - TfrxHackView(FComponent).FX) div 2 - 8, TfrxHackView(FComponent).FY + (TfrxHackView(FComponent).FY1 - TfrxHackView(FComponent).FY) div 2 - 8);
  aRect.BottomRight := Point(aRect.Left + 16, aRect.Top + 16);
  if FDrawButton and PtInRect(aRect, Point(X, Y)) and Supports(FComponent, IfrxDataLinkObject, DataLink) then
  begin
    sLink := DataLink.GetLink(dlmGetLink);
    if sLink <> '' then
      frxDataProtocols.LoadToObject(sLink, DataLink);
    EventParams.Refresh := True;
  end;
end;

procedure TfrxInPlaceDataLinkEditor.DrawCustomEditor(aCanvas: TCanvas;
  aRect: TRect);
var
  r: TRect;
begin
  if not FDrawButton then Exit;
  aRect := Rect(TfrxHackView(FComponent).FX, TfrxHackView(FComponent).FY, TfrxHackView(FComponent).FX1, TfrxHackView(FComponent).FY1);
  r.TopLeft := Point(aRect.Left + (aRect.Right - aRect.Left) div 2 - 8, aRect.Top + (aRect.Bottom - aRect.Top) div 2 - 8);
  r.BottomRight := Point(r.Left + 16, r.Top + 16);
//  aCanvas.FrameRect(r);
  frxImages.PreviewButtonImages.Draw(aCanvas, r.Left, r.Top, 35, True);
end;

procedure TfrxInPlaceDataLinkEditor.FinalizeUI(
  var EventParams: TfrxInteractiveEventsParams);
begin
  inherited;
  FDrawButton := False;
  EventParams.Refresh := True;
end;

procedure TfrxInPlaceDataLinkEditor.InitializeUI(
  var EventParams: TfrxInteractiveEventsParams);
begin
  inherited;
  FDrawButton := IsDataLinkSet;
  EventParams.Refresh := True;
end;

function TfrxInPlaceDataLinkEditor.IsDataLinkSet: Boolean;
var
  DataLink: IfrxDataLinkObject;
begin
  Result := Supports(FComponent, IfrxDataLinkObject, DataLink) and (DataLink.GetLink(dlmGetLink) <> '');
end;

end.
