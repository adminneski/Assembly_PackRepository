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
unit frLanguageBrazil;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'Brazil';

implementation

{$R frLanguageBrazil.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'frxrcClassBrazil');
  AResources.AddFormResource(hInstance, 'frxrcDesgnBrazil');
  AResources.AddFormResource(hInstance, 'frxrcExportsBrazil');
  AResources.AddFormResource(hInstance, 'frxrcInspBrazil');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
  TfrAvailableLanguagesController.RegisterLanguageUnit('Brazil', 'frLanguageBrazil')
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
