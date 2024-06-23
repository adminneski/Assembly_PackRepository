{******************************************}
{                                          }
{             FastReport VCL               }
{           Rich Object Editors            }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxRichInPlaceEditor;

interface

{$I frx.inc}

uses
  SysUtils, Types, Classes, Variants, Controls,
  frxClass, frxDsgnIntf;

implementation

uses Math, Graphics, Forms, Windows, Messages, frxDesgnEditors, frxRes, frxInPlaceEditors, StdCtrls, ComCtrls,
  frxUnicodeCtrls, frUnicodeUtils, RichEdit, frxRichEdit, frxRich;

type
  TfrxRichInPlaceEditor = class(TfrxInPlaceMemoEditorBase)
  protected
    procedure InitControlFromComponent; override;
    procedure InitComponentFromControl; override;
    procedure CreateMemo; override;
  public
    procedure EditInPlace(aParent: TComponent; aRect: TRect); override;
    procedure DrawCustomEditor(aCanvas: TCanvas; aRect: TRect); override;
  end;

  THackWinControl = class(TWinControl);
{ TfrxRichInPlaceEditor }

procedure TfrxRichInPlaceEditor.CreateMemo;
begin
  FInPlaceMemo := TRxUnicodeRichEdit.Create(FOwner);
end;

procedure TfrxRichInPlaceEditor.DrawCustomEditor(aCanvas: TCanvas;
  aRect: TRect);
  var
    R: TRect;
begin
  inherited;
  TRxUnicodeRichEdit(FInPlaceMemo).Invalidate;
  TRxUnicodeRichEdit(FInPlaceMemo).Perform(EM_FORMATRANGE, 0, 0);
  with TRxUnicodeRichEdit(FInPlaceMemo) do
  begin
    R := Rect(0, 0, ClientWidth, ClientHeight);
    SendMessage(Handle, EM_SETRECT, 0, LPARAM(@R));
  end;
end;

procedure TfrxRichInPlaceEditor.EditInPlace(aParent: TComponent; aRect: TRect);
begin
  inherited;
  TRxUnicodeRichEdit(FInPlaceMemo).WordWrap := True;
  TRxUnicodeRichEdit(FInPlaceMemo).ScrollBars := TScrollStyle(0);
  TRxUnicodeRichEdit(FInPlaceMemo).SelStart := 0;
  TRxUnicodeRichEdit(FInPlaceMemo).SelLength := 0;
end;

procedure TfrxRichInPlaceEditor.InitComponentFromControl;
var
  Rich: TfrxRichView;
begin
  Rich := TfrxRichView(FComponent);
  frxAssignRich(TRxUnicodeRichEdit(FInPlaceMemo), Rich.RichEdit);
end;

procedure TfrxRichInPlaceEditor.InitControlFromComponent;
var
  Rich: TfrxRichView;
begin
  Rich := TfrxRichView(FComponent);
  frxAssignRich(Rich.RichEdit, TRxUnicodeRichEdit(FInPlaceMemo));
end;

initialization
  frxRegEditorsClasses.Register(TfrxRichView, [TfrxRichInPlaceEditor], [[evPreview]]);

finalization
  frxUnregisterEditorsClass(TfrxRichView, TfrxRichInPlaceEditor);
end.
