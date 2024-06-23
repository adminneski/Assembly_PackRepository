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
unit frLanguageGreek;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'Greek';

implementation

{$R frLanguageGreek.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'fcxrcDesgnGreek');
  AResources.AddFormResource(hInstance, 'fcxrcExportsGreek');
  AResources.AddFormResource(hInstance, 'fcxrcStringsGreek');
  AResources.AddFormResource(hInstance, 'frxrcClassGreek');
  AResources.AddFormResource(hInstance, 'frxrcDesgnGreek');
  AResources.AddFormResource(hInstance, 'frxrcExportsGreek');
  AResources.AddFormResource(hInstance, 'frxrcInspGreek');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
  TfrAvailableLanguagesController.RegisterLanguageUnit('Greek', 'frLanguageGreek')
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
