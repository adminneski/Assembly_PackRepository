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
unit frLanguageBrazil1;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'Brazil1';

implementation

{$R frLanguageBrazil1.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'fcxrcDesgnBrazil1');
  AResources.AddFormResource(hInstance, 'fcxrcExportsBrazil1');
  AResources.AddFormResource(hInstance, 'fcxrcStringsBrazil1');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
  TfrAvailableLanguagesController.RegisterLanguageUnit('Brazil1', 'frLanguageBrazil1')
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
