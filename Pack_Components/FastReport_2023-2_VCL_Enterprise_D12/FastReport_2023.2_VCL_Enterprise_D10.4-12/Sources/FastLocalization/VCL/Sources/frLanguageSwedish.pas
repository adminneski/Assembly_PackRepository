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
unit frLanguageSwedish;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'Swedish';

implementation

{$R frLanguageSwedish.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'fcxrcDesgnSwedish');
  AResources.AddFormResource(hInstance, 'fcxrcExportsSwedish');
  AResources.AddFormResource(hInstance, 'fcxrcStringsSwedish');
  AResources.AddFormResource(hInstance, 'frxrcClassSwedish');
  AResources.AddFormResource(hInstance, 'frxrcDesgnSwedish');
  AResources.AddFormResource(hInstance, 'frxrcExportsSwedish');
  AResources.AddFormResource(hInstance, 'frxrcInspSwedish');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
  TfrAvailableLanguagesController.RegisterLanguageUnit('Swedish', 'frLanguageSwedish')
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
