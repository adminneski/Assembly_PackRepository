{*******************************************************}
{                                                       }
{                        EhLib 10.2                     }
{                                                       }
{        Classes for detection Images stream format     }
{                                                       }
{   Copyright (c) 2011-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

unit EhLibPNGImage;

{$I EhLib.Inc}

interface

uses
  SysUtils, Variants, Classes, Graphics, Controls, Forms,
{$IFDEF EH_LIB_12} PNGImage, {$ENDIF} { CodeGear RAD Studio 2009 }
  Dialogs, ToolCtrlsEh;

type

  TPNGGraphicProviderEh = class(TGraphicProviderEh)
  public
    class function GetImageClassForStream(Start: Pointer): TGraphicClass; override;
  end;

implementation

{ TPNGGraphicProviderEh }

class function TPNGGraphicProviderEh.GetImageClassForStream(Start: Pointer): TGraphicClass;
var
  PngCode: LongWord;
begin
  Result := nil;
  if (Start = nil) then Exit;

  Move(Start^, PngCode, 4);
  if (PngCode = $474E5089) then
  begin
{$IFDEF FPC}
    Result := TPortableNetworkGraphic;
{$ELSE}
  {$IFDEF EH_LIB_12}
    Result := TPngImage;
  {$ELSE}
  {$ENDIF}
{$ENDIF}
  end;
end;

initialization
  RegisterGraphicProviderEh(TPNGGraphicProviderEh);
finalization
end.
