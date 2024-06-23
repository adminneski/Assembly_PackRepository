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
unit frLanguageSlovene;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'Slovene';

implementation

{$R frLanguageSlovene.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'frxrcClassSlovene');
  AResources.AddFormResource(hInstance, 'frxrcDesgnSlovene');
  AResources.AddFormResource(hInstance, 'frxrcExportsSlovene');
  AResources.AddFormResource(hInstance, 'frxrcInspSlovene');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
  TfrAvailableLanguagesController.RegisterLanguageUnit('Slovene', 'frLanguageSlovene')
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
