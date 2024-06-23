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
unit frLanguageItalian;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'Italian';

implementation

{$R frLanguageItalian.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'fcxrcDesgnItalian');
  AResources.AddFormResource(hInstance, 'fcxrcExportsItalian');
  AResources.AddFormResource(hInstance, 'fcxrcStringsItalian');
  AResources.AddFormResource(hInstance, 'frxrcClassItalian');
  AResources.AddFormResource(hInstance, 'frxrcDesgnItalian');
  AResources.AddFormResource(hInstance, 'frxrcExportsItalian');
  AResources.AddFormResource(hInstance, 'frxrcInspItalian');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
  TfrAvailableLanguagesController.RegisterLanguageUnit('Italian', 'frLanguageItalian')
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
