{*******************************************************}
{                                                       }
{                        EhLib 10.2                     }
{                                                       }
{        Classes for detection Images stream format     }
{                                                       }
{   Copyright (c) 2011-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

unit EhLibJPegImage;

{$I EhLib.Inc}

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
{$IFDEF FPC}
{$ELSE}
  JPeg,
{$ENDIF}
  Dialogs, ExtCtrls, Buttons, ToolCtrlsEh;


type

{ TJPEGGraphicProviderEh }

  TJPEGGraphicProviderEh = class(TGraphicProviderEh)
    class function GetImageClassForStream(Start: Pointer): TGraphicClass; override;
  end;

implementation

{ TJPEGGraphicProviderEh }

class function TJPEGGraphicProviderEh.GetImageClassForStream(Start: Pointer): TGraphicClass;
var
  JpegCode: Word;
begin
  Result := nil;
  if (Start = nil) then
    Exit;

  Move(Start^, JpegCode, 2);
  if (JpegCode = $D8FF) then
    Result := TJPEGImage
end;

initialization
  RegisterGraphicProviderEh(TJPEGGraphicProviderEh);
finalization
end.
