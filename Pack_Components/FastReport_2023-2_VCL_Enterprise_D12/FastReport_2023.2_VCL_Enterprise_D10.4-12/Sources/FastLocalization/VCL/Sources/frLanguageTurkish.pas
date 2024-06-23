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
unit frLanguageTurkish;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'Turkish';

implementation

{$R frLanguageTurkish.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'fcxrcDesgnTurkish');
  AResources.AddFormResource(hInstance, 'fcxrcExportsTurkish');
  AResources.AddFormResource(hInstance, 'fcxrcStringsTurkish');
  AResources.AddFormResource(hInstance, 'frxrcClassTurkish');
  AResources.AddFormResource(hInstance, 'frxrcDesgnTurkish');
  AResources.AddFormResource(hInstance, 'frxrcExportsTurkish');
  AResources.AddFormResource(hInstance, 'frxrcInspTurkish');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
  TfrAvailableLanguagesController.RegisterLanguageUnit('Turkish', 'frLanguageTurkish')
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
