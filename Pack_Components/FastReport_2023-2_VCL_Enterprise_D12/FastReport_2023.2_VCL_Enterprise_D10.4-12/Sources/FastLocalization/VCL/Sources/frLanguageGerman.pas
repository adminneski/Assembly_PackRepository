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
unit frLanguageGerman;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'German';

implementation

{$R frLanguageGerman.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'fcxrcDesgnGerman');
  AResources.AddFormResource(hInstance, 'fcxrcExportsGerman');
  AResources.AddFormResource(hInstance, 'fcxrcStringsGerman');
  AResources.AddFormResource(hInstance, 'frxrcClassGerman');
  AResources.AddFormResource(hInstance, 'frxrcDesgnGerman');
  AResources.AddFormResource(hInstance, 'frxrcExportsGerman');
  AResources.AddFormResource(hInstance, 'frxrcInspGerman');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
  TfrAvailableLanguagesController.RegisterLanguageUnit('German', 'frLanguageGerman')
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
