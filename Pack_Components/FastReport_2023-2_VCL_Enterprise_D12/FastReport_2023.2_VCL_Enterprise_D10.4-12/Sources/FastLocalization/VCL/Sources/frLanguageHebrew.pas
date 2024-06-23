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
unit frLanguageHebrew;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'Hebrew';

implementation

{$R frLanguageHebrew.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'frxrcClassHebrew');
  AResources.AddFormResource(hInstance, 'frxrcDesgnHebrew');
  AResources.AddFormResource(hInstance, 'frxrcExportsHebrew');
  AResources.AddFormResource(hInstance, 'frxrcInspHebrew');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
  TfrAvailableLanguagesController.RegisterLanguageUnit('Hebrew', 'frLanguageHebrew')
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
