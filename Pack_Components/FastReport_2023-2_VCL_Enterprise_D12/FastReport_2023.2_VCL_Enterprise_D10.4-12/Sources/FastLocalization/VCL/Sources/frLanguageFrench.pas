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
unit frLanguageFrench;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'French';

implementation

{$R frLanguageFrench.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'fcxrcDesgnFrench');
  AResources.AddFormResource(hInstance, 'fcxrcExportsFrench');
  AResources.AddFormResource(hInstance, 'fcxrcStringsFrench');
  AResources.AddFormResource(hInstance, 'frxrcClassFrench');
  AResources.AddFormResource(hInstance, 'frxrcDesgnFrench');
  AResources.AddFormResource(hInstance, 'frxrcExportsFrench');
  AResources.AddFormResource(hInstance, 'frxrcInspFrench');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
  TfrAvailableLanguagesController.RegisterLanguageUnit('French', 'frLanguageFrench')
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
