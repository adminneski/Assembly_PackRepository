
{******************************************}
{                                          }
{             FastReport VCL               }
{         PDFView  InPlace Editor          }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxHTMLViewInPlaceEditor;

interface

{$I frx.inc}

uses
{$IFNDEF FPC}
  Windows,
{$ENDIF}
  Messages, SysUtils, Classes, Graphics, Controls,
  frxClass, frxInPlaceEditors, frxDataLinkInPlaceEditor
{$IFDEF DELPHI6}
, Variants
{$ENDIF};

implementation
uses frxHTML;

initialization
  frxRegEditorsClasses.Register(TfrxHtmlView, [TfrxInPlaceDataLinkEditor], [[evDesigner]]);

finalization
  frxUnregisterEditorsClass(TfrxHtmlView, TfrxInPlaceDataLinkEditor);
end.
