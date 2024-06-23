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
unit frLanguageFarsi;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'Farsi';

implementation

{$R frLanguageFarsi.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'frxrcClassFarsi');
  AResources.AddFormResource(hInstance, 'frxrcDesgnFarsi');
  AResources.AddFormResource(hInstance, 'frxrcExportsFarsi');
  AResources.AddFormResource(hInstance, 'frxrcInspFarsi');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
  TfrAvailableLanguagesController.RegisterLanguageUnit('Farsi', 'frLanguageFarsi')
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
