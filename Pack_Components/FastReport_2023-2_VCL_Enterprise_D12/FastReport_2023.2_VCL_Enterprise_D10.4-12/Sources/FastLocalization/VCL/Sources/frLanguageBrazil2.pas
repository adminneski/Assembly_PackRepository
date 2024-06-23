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
unit frLanguageBrazil2;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'Brazil2';

implementation

{$R frLanguageBrazil2.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'fcxrcDesgnBrazil2');
  AResources.AddFormResource(hInstance, 'fcxrcExportsBrazil2');
  AResources.AddFormResource(hInstance, 'fcxrcStringsBrazil2');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
  TfrAvailableLanguagesController.RegisterLanguageUnit('Brazil2', 'frLanguageBrazil2')
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
