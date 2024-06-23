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
unit frLanguageDanish;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'Danish';

implementation

{$R frLanguageDanish.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'frxrcClassDanish');
  AResources.AddFormResource(hInstance, 'frxrcDesgnDanish');
  AResources.AddFormResource(hInstance, 'frxrcExportsDanish');
  AResources.AddFormResource(hInstance, 'frxrcInspDanish');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
  TfrAvailableLanguagesController.RegisterLanguageUnit('Danish', 'frLanguageDanish')
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
