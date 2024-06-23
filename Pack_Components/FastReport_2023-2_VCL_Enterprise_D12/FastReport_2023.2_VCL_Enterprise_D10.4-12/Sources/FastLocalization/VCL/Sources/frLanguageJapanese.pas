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
unit frLanguageJapanese;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'Japanese';

implementation

{$R frLanguageJapanese.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'frxrcClassJapanese');
  AResources.AddFormResource(hInstance, 'frxrcDesgnJapanese');
  AResources.AddFormResource(hInstance, 'frxrcExportsJapanese');
  AResources.AddFormResource(hInstance, 'frxrcInspJapanese');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
  TfrAvailableLanguagesController.RegisterLanguageUnit('Japanese', 'frLanguageJapanese')
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
