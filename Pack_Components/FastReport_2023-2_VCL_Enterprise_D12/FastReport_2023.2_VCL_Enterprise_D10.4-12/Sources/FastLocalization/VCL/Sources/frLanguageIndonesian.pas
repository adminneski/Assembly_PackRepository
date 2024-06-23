{******************************************}
{                                          }
{          FastReport VCL/FMX/LCL          }
{           Localization Library           }
{                                          }
{         Copyright (c) 1998-2023          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

{$IFNDEF FMX}
unit frLanguageIndonesian;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'Indonesian';

implementation

{$R frLanguageIndonesian.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'frxrcClassIndonesian');
  AResources.AddFormResource(hInstance, 'frxrcDesgnIndonesian');
  AResources.AddFormResource(hInstance, 'frxrcExportsIndonesian');
  AResources.AddFormResource(hInstance, 'frxrcInspIndonesian');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
  TfrAvailableLanguagesController.RegisterLanguageUnit('Indonesian', 'frLanguageIndonesian')
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
