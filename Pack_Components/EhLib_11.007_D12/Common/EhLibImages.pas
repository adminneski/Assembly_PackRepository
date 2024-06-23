{*******************************************************}
{                                                       }
{                        EhLib 10.2                     }
{                                                       }
{        Classes for detection Images stream format     }
{                                                       }
{   Copyright (c) 2011-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

unit EhLibImages;

{$I EhLib.Inc}

interface

uses ToolCtrlsEh, EhLibJPegImage
{$IFDEF EH_LIB_11} ,EhLibGIFImage  {$ENDIF} { Borland Developer Studio 2007 }
{$IFDEF EH_LIB_12} ,EhLibPNGImage {$ENDIF} { CodeGear RAD Studio 2009 }
  ;

implementation

initialization
end.
