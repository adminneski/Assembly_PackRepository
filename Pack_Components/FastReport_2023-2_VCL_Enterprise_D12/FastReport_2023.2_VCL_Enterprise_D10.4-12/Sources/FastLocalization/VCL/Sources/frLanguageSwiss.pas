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
unit frLanguageSwiss;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'Swiss';

implementation

{$R frLanguageSwiss.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'frxrcClassSwiss');
  AResources.AddFormResource(hInstance, 'frxrcDesgnSwiss');
  AResources.AddFormResource(hInstance, 'frxrcExportsSwiss');
  AResources.AddFormResource(hInstance, 'frxrcInspSwiss');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
  TfrAvailableLanguagesController.RegisterLanguageUnit('Swiss', 'frLanguageSwiss')
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
