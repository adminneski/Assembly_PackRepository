
{******************************************}
{                                          }
{             FastReport VCL               }
{         ComboBox InPlace Editor          }
{                                          }
{         Copyright (c) 1998-2022          }
{           by Fast Reports Inc.           }
{                                          }
{******************************************}

unit frxComboBoxInPlaceEditor;

interface

{$I frx.inc}

uses
  Types,
{$IFNDEF FPC}
  Windows,
{$ELSE}
  LCLType, LCLIntf, LCLProc,
{$ENDIF}
  Classes, Graphics, frxClass;

implementation

uses
  Controls, SysUtils, Math, StdCtrls, Buttons, Forms,
  frxComboBox, frxInPlaceEditors, frxPopupForm, frxRes, frUtils, frxUtils, frxHelpers;

type
  TfrxComboBoxInPlaceEditor = class(TfrxInPlaceBaseListBoxEditor)
  private
    FLastScale: Extended;
    procedure SetScaleOffset(EventParams: TfrxInteractiveEventsParams);
    function ComboBox: TfrxComboBoxView;
  protected
    function ListBoxClicked(Sender: TObject): Boolean; override;
    function IsFillListBox: Boolean; override;
    function GetButtonSize: Integer; override;
    procedure CalcPopupBounds(out ATopLeft: TPoint; out AWidth, AHeight: Integer); override;
    function ListBoxCreate: TListBox; override;
    procedure ListBoxDrawItem(ACanvas: TCanvas; AControl: TWinControl; AIndex: Integer; ARect: TRect;
      AState: TfrOwnerDrawState); override;
  public
    function ShowPopup(aParent: TComponent; aRect: TRect; X, Y: Integer): Boolean; override;
    procedure InitializeUI(var EventParams: TfrxInteractiveEventsParams); override;
    procedure FinalizeUI(var EventParams: TfrxInteractiveEventsParams); override;

    function DoMouseDown(X, Y: Integer; Button: TMouseButton; Shift: TShiftState;
      var EventParams: TfrxInteractiveEventsParams): Boolean; override;
  end;

{ TfrxComboBoxInPlaceEditor }

procedure TfrxComboBoxInPlaceEditor.CalcPopupBounds(out ATopLeft: TPoint; out AWidth, AHeight: Integer);
var
  LineCount: Integer;
begin
  ATopLeft.X := FRect.Left;
  ATopLeft.Y := FRect.Bottom + 1;
  AWidth := FRect.Right - FRect.Left;
  LineCount := frLimit(ComboBox.Items.Count, 1, ComboBox.DropDownCount);
  AHeight := LineCount * GetItemHeight + 3;
end;

function TfrxComboBoxInPlaceEditor.ComboBox: TfrxComboBoxView;
begin
  Result := Component as TfrxComboBoxView;
end;

function TfrxComboBoxInPlaceEditor.ListBoxClicked(Sender: TObject): Boolean;
begin
  Result := ComboBox.ItemIndex <> ListItemIndex;
  if Result then
    ComboBox.ItemIndex := ListItemIndex;
end;

function TfrxComboBoxInPlaceEditor.DoMouseDown(X, Y: Integer;
  Button: TMouseButton; Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams): Boolean;
begin
  SetScaleOffset(EventParams);
  Result := inherited DoMouseDown(X, Y, Button, Shift, EventParams);
end;

procedure TfrxComboBoxInPlaceEditor.FinalizeUI(var EventParams: TfrxInteractiveEventsParams);
begin
  inherited FinalizeUI(EventParams);
  ComboBox.NeedReDraw := True;
  EventParams.Refresh := True;
  EventParams.Modified := True;
end;

function TfrxComboBoxInPlaceEditor.GetButtonSize: Integer;
begin
  Result := FRect.Bottom - FRect.Top - 1;
  Result := Result - Result mod 2;
end;

procedure TfrxComboBoxInPlaceEditor.InitializeUI(var EventParams: TfrxInteractiveEventsParams);
begin
  inherited InitializeUI(EventParams);
  ComboBox.NeedReDraw := True;
  SetScaleOffset(EventParams);
end;

function TfrxComboBoxInPlaceEditor.IsFillListBox: Boolean;
begin
  ListItems.Text := ComboBox.ItemsText;
  ListItemIndex := ComboBox.ItemIndex;
  Result := True;
end;

procedure TfrxComboBoxInPlaceEditor.ListBoxDrawItem(ACanvas: TCanvas; AControl: TWinControl; AIndex: Integer; ARect: TRect;
      AState: TfrOwnerDrawState);
begin
  ACanvas.FillRect(aRect);
  ACanvas.TextOut(aRect.Left + 2, aRect.Top + 1, ListItems[AIndex]);
end;

function TfrxComboBoxInPlaceEditor.ListBoxCreate: TListBox;
begin
  Result := inherited ListBoxCreate;
  Result.Font := Component.Font;
  Result.Font.Height := Round(Result.Font.Height * FLastScale * frx_DefaultPPI / FDevicePPI);
  Result.ItemHeight := Ceil((ComboBox.ContentHeight + 3) * FLastScale);
  Result.Color := frIfColor(ComboBox.Color = clNone, clWhite, ComboBox.Color);
end;

procedure TfrxComboBoxInPlaceEditor.SetScaleOffset(EventParams: TfrxInteractiveEventsParams);
begin
  FLastScale := EventParams.Scale;
end;

function TfrxComboBoxInPlaceEditor.ShowPopup(aParent: TComponent; aRect: TRect; X, Y: Integer): Boolean;
begin
  ComboBox.PreviewCoordinates(X, Y);
  Result := inherited ShowPopup(aParent, aRect, X, Y);
end;

initialization
  frxRegEditorsClasses.Register(TfrxComboBoxView, [TfrxComboBoxInPlaceEditor], [[evDesigner, evPreview]]);

finalization
  frxUnregisterEditorsClass(TfrxComboBoxView, TfrxComboBoxInPlaceEditor);
end.
