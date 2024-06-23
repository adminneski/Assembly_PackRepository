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
unit frLanguageCroatian;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'Croatian';

implementation

{$R frLanguageCroatian.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'fcxrcDesgnCroatian');
  AResources.AddFormResource(hInstance, 'fcxrcExportsCroatian');
  AResources.AddFormResource(hInstance, 'fcxrcStringsCroatian');
  AResources.AddFormResource(hInstance, 'frxrcClassCroatian');
  AResources.AddFormResource(hInstance, 'frxrcDesgnCroatian');
  AResources.AddFormResource(hInstance, 'frxrcExportsCroatian');
  AResources.AddFormResource(hInstance, 'frxrcInspCroatian');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
  TfrAvailableLanguagesController.RegisterLanguageUnit('Croatian', 'frLanguageCroatian')
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
