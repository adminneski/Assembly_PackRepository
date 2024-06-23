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
unit frLanguageTaiwan;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'Taiwan';

implementation

{$R frLanguageTaiwan.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'frxrcClassTaiwan');
  AResources.AddFormResource(hInstance, 'frxrcDesgnTaiwan');
  AResources.AddFormResource(hInstance, 'frxrcExportsTaiwan');
  AResources.AddFormResource(hInstance, 'frxrcInspTaiwan');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
  TfrAvailableLanguagesController.RegisterLanguageUnit('Taiwan', 'frLanguageTaiwan')
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
