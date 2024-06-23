
{******************************************}
{                                          }
{             FastReport VCL               }
{         PDFView  InPlace Editor          }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxPDFViewInPlaceEditor;

interface

{$I frx.inc}

uses
{$IFNDEF Linux}
  Windows,
{$ELSE}
  LCLType, LCLIntf, LCLProc,
{$ENDIF}
  Messages, SysUtils, Classes, Graphics, Controls,
  frxClass, frxInPlaceEditors, frxDataLinkInPlaceEditor
{$IFDEF DELPHI6}
, Variants
{$ENDIF};

implementation
uses frxPDFViewer;

initialization
  frxRegEditorsClasses.Register(TfrxPDFView, [TfrxInPlaceDataLinkEditor], [[evDesigner]]);

finalization
  frxUnregisterEditorsClass(TfrxPDFView, TfrxInPlaceDataLinkEditor);
end.
