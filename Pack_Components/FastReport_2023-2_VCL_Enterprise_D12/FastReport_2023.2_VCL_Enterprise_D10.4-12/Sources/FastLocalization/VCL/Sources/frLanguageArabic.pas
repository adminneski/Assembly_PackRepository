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
unit frLanguageArabic;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'Arabic';

implementation

{$R frLanguageArabic.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'frxrcClassArabic');
  AResources.AddFormResource(hInstance, 'frxrcDesgnArabic');
  AResources.AddFormResource(hInstance, 'frxrcExportsArabic');
  AResources.AddFormResource(hInstance, 'frxrcInspArabic');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
  TfrAvailableLanguagesController.RegisterLanguageUnit('Arabic', 'frLanguageArabic')
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
