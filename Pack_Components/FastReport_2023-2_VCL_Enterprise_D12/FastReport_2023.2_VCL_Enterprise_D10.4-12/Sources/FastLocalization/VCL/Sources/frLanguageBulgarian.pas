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
unit frLanguageBulgarian;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'Bulgarian';

implementation

{$R frLanguageBulgarian.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'frxrcClassBulgarian');
  AResources.AddFormResource(hInstance, 'frxrcDesgnBulgarian');
  AResources.AddFormResource(hInstance, 'frxrcExportsBulgarian');
  AResources.AddFormResource(hInstance, 'frxrcInspBulgarian');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
  TfrAvailableLanguagesController.RegisterLanguageUnit('Bulgarian', 'frLanguageBulgarian')
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
