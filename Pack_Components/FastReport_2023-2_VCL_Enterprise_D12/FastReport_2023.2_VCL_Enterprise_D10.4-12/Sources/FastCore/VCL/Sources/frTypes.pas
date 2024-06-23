{******************************************}
{                                          }
{          FastReport VCL/FMX/LCL          }
{              Core Library                }
{           Resources management           }
{                                          }
{         Copyright (c) 1998-2022          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

{$IFNDEF FMX}
unit frTypes;
{$ENDIF}

interface

{$I frVer.inc}

uses
{$IFDEF FPC}
  LCLType, LMessages,
{$ENDIF}
  SysUtils;

type
{$IFDEF FPC}
  UINT = Cardinal;
  TMessage = TLMessage;
{$ENDIF}

  { TfrPointF }

  TfrPointF = packed record
    X: Extended;
    Y: Extended;
  end;

  { TfrRectF }

  TfrRectF = packed record
    case Integer of
      0: (Left, Top, Right, Bottom: Single);
      1: (TopLeft, BottomRight: TfrPointF);
  end;

  { TfrPackedRect }

  TfrPackedRect = packed record
    Left:     LongInt;
    Top:      LongInt;
    Right:    LongInt;
    Bottom:   LongInt;
  end;

implementation
end.
