{******************************************}
{                                          }
{             FastReport VCL               }
{          Cellular Text Editors           }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxCellularTextInPlaceEditor;

interface

{$I frx.inc}

uses
  SysUtils, Types, Classes, Variants, Controls,
  frxClass, frxDsgnIntf;

implementation

uses
  {$IFNDEF FPC}
  Windows,
  {$ENDIF}
  Math, Graphics, Forms, Messages, frxDesgnEditors, frxRes, frxInPlaceEditors, StdCtrls, ComCtrls,
  frxUnicodeCtrls, frUnicodeUtils, frxCellularTextEdit, frxCellularTextObject;

type

  TfrxHackView = class(TfrxView);
  THackCustomMemo = class(TCustomMemo);

  TfrxInPlaceCellularTextEditorBase = class(TfrxInPlaceEditor)
  private
    procedure MemoKeyPress(Sender: TObject; var Key: Char);
    procedure DoExit(Sender: TObject);
    procedure MemoKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
  protected
    FInPlaceCellular: TfrxCellularTextControl;
    FEdited: Boolean;
    procedure InitControlFromComponent; virtual;
    procedure InitComponentFromControl; virtual;
    procedure EditDone;
    procedure CreateMemo; virtual; abstract;
  public
    constructor Create(aClassRef: TfrxComponentClass;
      aOwner: TWinControl); override;
    destructor  Destroy; override;
    function HasCustomEditor: Boolean; override;
    function DoMouseUp(X, Y: Integer; Button: TMouseButton;
      Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams): Boolean; override;
    procedure EditInPlace(aParent: TComponent; aRect: TRect); override;
    function EditInPlaceDone: Boolean; override;
    function DoMouseWheel(Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var EventParams: TfrxInteractiveEventsParams): Boolean; override;
    procedure FinalizeUI(var EventParams: TfrxInteractiveEventsParams); override;
  end;

  TfrxInCellularTextEditor = class(TfrxInPlaceCellularTextEditorBase)
  protected
    procedure CreateMemo; override;
    procedure InitControlFromComponent; override;
    procedure InitComponentFromControl; override;
  end;


  THackWinControl = class(TWinControl);

{ TfrxMemoEditor }

constructor TfrxInPlaceCellularTextEditorBase.Create(aClassRef: TfrxComponentClass;
  aOwner: TWinControl);
begin
  inherited;
  CreateMemo;
  THackCustomMemo(FInPlaceCellular).OnExit := DoExit;
  with FInPlaceCellular do
  begin
    Visible := False;
    OnKeyPress := MemoKeyPress;
    OnKeyDown := MemoKeyDown;
    Parent := FOwner;
  end;
end;

procedure TfrxInPlaceCellularTextEditorBase.DoExit(Sender: TObject);
begin
  EditDone;
end;

function TfrxInPlaceCellularTextEditorBase.DoMouseUp(X, Y: Integer;
  Button: TMouseButton; Shift: TShiftState; var EventParams: TfrxInteractiveEventsParams): Boolean;
begin
  Result := Inherited DoMouseUp(X, Y, Button, Shift, EventParams);
  OnFinishInPlace := EventParams.OnFinish;
  EditInPlaceDone;
  if ((EventParams.EditMode = dtText) or ((EventParams.EventSender = esPreview) and (ssAlt in Shift) and (ferAllowInPreview in FComponent.Editable))) then
  EditInPlace(EventParams.Sender as TComponent, Rect(TfrxHackView(FComponent).FX, TfrxHackView(FComponent).FY, TfrxHackView(FComponent).FX1, TfrxHackView(FComponent).FY1));
end;

function TfrxInPlaceCellularTextEditorBase.DoMouseWheel(Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint;
  var EventParams: TfrxInteractiveEventsParams): Boolean;
begin
  Result := FInPlaceCellular.Visible;
end;

procedure TfrxInPlaceCellularTextEditorBase.EditDone;
begin
  if (csDestroying in FInPlaceCellular.ComponentState) or
    Assigned(FInPlaceCellular.Parent) and
    (csDestroying in FInPlaceCellular.Parent.ComponentState) then
    Exit;
  if FInPlaceCellular.Modified then
  begin
    InitComponentFromControl;
    DoFinishInPlace(Component, True, True);
    FInPlaceCellular.Modified := False;
    FEdited := True;
  end;
  FInPlaceCellular.Hide;
end;

procedure TfrxInPlaceCellularTextEditorBase.EditInPlace(aParent: TComponent; aRect: TRect);
var
  View: TfrxView;
  Scale: Extended;
  r: TRect;
begin
  View := TfrxView(Component);
  Scale := FScale;
  with FInPlaceCellular do
  begin

    r := Rect(Round(View.AbsLeft * Scale), Round(View.AbsTop * Scale),
      Round((View.AbsLeft + View.Width) * Scale + 1),
      Round((View.AbsTop + View.Height) * Scale + 1));
    OffsetRect(r, Round(FOffsetX), Round(FOffsetY));
    SetBounds(r.Left, r.Top, r.Right - r.Left, r.Bottom - r.Top);
    InitControlFromComponent;

    if View.Color = clNone then
      Color := clWhite
    else
      Color := View.Color;
{$IFNDEF FPC}
    Ctl3D := False;
{$ENDIF}
    //BorderStyle := bsNone;

    Show;
    SetFocus;
    //SelectAll;
    FEdited := False;
  end;

end;

function TfrxInPlaceCellularTextEditorBase.EditInPlaceDone: Boolean;
begin
  EditDone;
  Result := FEdited;
end;

procedure TfrxInPlaceCellularTextEditorBase.FinalizeUI(
  var EventParams: TfrxInteractiveEventsParams);
begin
  inherited;
  EventParams.Refresh := EventParams.Refresh or EditInPlaceDone;
end;

function TfrxInPlaceCellularTextEditorBase.HasCustomEditor: Boolean;
begin
  Result := True;
end;

procedure TfrxInPlaceCellularTextEditorBase.InitComponentFromControl;
begin
//
end;

procedure TfrxInPlaceCellularTextEditorBase.InitControlFromComponent;
begin
//
end;

procedure TfrxInPlaceCellularTextEditorBase.MemoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = $0D) and (ssCtrl in Shift) then
    EditDone;
end;

procedure TfrxInPlaceCellularTextEditorBase.MemoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #27 then
  begin
    FInPlaceCellular.Modified := False;
    EditDone;
  end;
end;

{ TfrxInPlaceMemoEditor }

procedure TfrxInCellularTextEditor.InitControlFromComponent;
var
  CellularText: TfrxCellularText;
  function frxAlignToAlignment(HAlign: TfrxHAlign): TAlignment;
  begin
    case HAlign of
      haLeft: Result := taLeftJustify;
      haRight: Result := taRightJustify;
      else
        Result := taCenter;
    end;
  end;

begin
  CellularText := FComponent as TfrxCellularText;
  if not Assigned(CellularText) then Exit;
  FInPlaceCellular.CellularText := CellularText;
  FInPlaceCellular.Zoom := Self.FScale;
end;


procedure TfrxInCellularTextEditor.InitComponentFromControl;
var
  CellularText: TfrxCellularText;
begin
  CellularText := TfrxCellularText(Component);
  CellularText.Text := FInPlaceCellular.CellularText.Text;
end;

{ TfrxInPlaceTextEditorBase }

procedure TfrxInCellularTextEditor.CreateMemo;
begin
  FInPlaceCellular := TfrxCellularTextControl.Create(nil);
end;

destructor TfrxInPlaceCellularTextEditorBase.Destroy;
begin
  FInPlaceCellular.Free;
  inherited;
end;


initialization
  frxRegEditorsClasses.Register(TfrxCellularText, [TfrxInCellularTextEditor], [[evPreview]]);

finalization
  frxUnregisterEditorsClass(TfrxCellularText, TfrxInCellularTextEditor);
end.
