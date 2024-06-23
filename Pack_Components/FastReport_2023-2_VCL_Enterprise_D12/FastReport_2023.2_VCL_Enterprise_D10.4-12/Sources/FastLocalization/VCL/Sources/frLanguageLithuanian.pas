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
unit frLanguageLithuanian;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'Lithuanian';

implementation

{$R frLanguageLithuanian.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'fcxrcDesgnLithuanian');
  AResources.AddFormResource(hInstance, 'fcxrcExportsLithuanian');
  AResources.AddFormResource(hInstance, 'fcxrcStringsLithuanian');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
  TfrAvailableLanguagesController.RegisterLanguageUnit('Lithuanian', 'frLanguageLithuanian')
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
