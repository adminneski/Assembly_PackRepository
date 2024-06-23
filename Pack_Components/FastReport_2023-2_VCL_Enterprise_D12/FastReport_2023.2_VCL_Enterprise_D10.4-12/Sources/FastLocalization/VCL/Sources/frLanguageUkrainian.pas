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
unit frLanguageUkrainian;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'Ukrainian';

implementation

{$R frLanguageUkrainian.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'frxrcClassUkrainian');
  AResources.AddFormResource(hInstance, 'frxrcDesgnUkrainian');
  AResources.AddFormResource(hInstance, 'frxrcExportsUkrainian');
  AResources.AddFormResource(hInstance, 'frxrcInspUkrainian');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
  TfrAvailableLanguagesController.RegisterLanguageUnit('Ukrainian', 'frLanguageUkrainian')
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
