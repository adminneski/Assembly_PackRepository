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
unit frLanguagePortuguese;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'Portuguese';

implementation

{$R frLanguagePortuguese.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'fcxrcDesgnPortuguese');
  AResources.AddFormResource(hInstance, 'fcxrcExportsPortuguese');
  AResources.AddFormResource(hInstance, 'fcxrcStringsPortuguese');
  AResources.AddFormResource(hInstance, 'frxrcClassPortuguese');
  AResources.AddFormResource(hInstance, 'frxrcDesgnPortuguese');
  AResources.AddFormResource(hInstance, 'frxrcExportsPortuguese');
  AResources.AddFormResource(hInstance, 'frxrcInspPortuguese');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
  TfrAvailableLanguagesController.RegisterLanguageUnit('Portuguese', 'frLanguagePortuguese')
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
