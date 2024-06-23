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
unit frLanguageHungarian;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'Hungarian';

implementation

{$R frLanguageHungarian.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'fcxrcDesgnHungarian');
  AResources.AddFormResource(hInstance, 'fcxrcExportsHungarian');
  AResources.AddFormResource(hInstance, 'fcxrcStringsHungarian');
  AResources.AddFormResource(hInstance, 'frxrcClassHungarian');
  AResources.AddFormResource(hInstance, 'frxrcDesgnHungarian');
  AResources.AddFormResource(hInstance, 'frxrcExportsHungarian');
  AResources.AddFormResource(hInstance, 'frxrcInspHungarian');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
  TfrAvailableLanguagesController.RegisterLanguageUnit('Hungarian', 'frLanguageHungarian')
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
