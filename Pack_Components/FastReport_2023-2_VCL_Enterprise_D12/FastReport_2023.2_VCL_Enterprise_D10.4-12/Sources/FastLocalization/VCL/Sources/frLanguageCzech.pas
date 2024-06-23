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
unit frLanguageCzech;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'Czech';

implementation

{$R frLanguageCzech.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'fcxrcDesgnCzech');
  AResources.AddFormResource(hInstance, 'fcxrcExportsCzech');
  AResources.AddFormResource(hInstance, 'fcxrcStringsCzech');
  AResources.AddFormResource(hInstance, 'frxrcClassCzech');
  AResources.AddFormResource(hInstance, 'frxrcDesgnCzech');
  AResources.AddFormResource(hInstance, 'frxrcExportsCzech');
  AResources.AddFormResource(hInstance, 'frxrcInspCzech');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
  TfrAvailableLanguagesController.RegisterLanguageUnit('Czech', 'frLanguageCzech')
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
