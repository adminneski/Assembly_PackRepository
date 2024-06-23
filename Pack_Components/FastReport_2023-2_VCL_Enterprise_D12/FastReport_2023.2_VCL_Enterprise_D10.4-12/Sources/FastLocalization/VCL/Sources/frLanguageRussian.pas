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
unit frLanguageRussian;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'Russian';

implementation

{$R frLanguageRussian.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'fcxrcDesgnRussian');
  AResources.AddFormResource(hInstance, 'fcxrcExportsRussian');
  AResources.AddFormResource(hInstance, 'fcxrcStringsRussian');
  AResources.AddFormResource(hInstance, 'frxrcClassRussian');
  AResources.AddFormResource(hInstance, 'frxrcDesgnRussian');
  AResources.AddFormResource(hInstance, 'frxrcExportsRussian');
  AResources.AddFormResource(hInstance, 'frxrcInspRussian');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
  TfrAvailableLanguagesController.RegisterLanguageUnit('Russian', 'frLanguageRussian')
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
