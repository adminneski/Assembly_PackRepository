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
unit frLanguageSpanish;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'Spanish';

implementation

{$R frLanguageSpanish.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'fcxrcDesgnSpanish');
  AResources.AddFormResource(hInstance, 'fcxrcExportsSpanish');
  AResources.AddFormResource(hInstance, 'fcxrcStringsSpanish');
  AResources.AddFormResource(hInstance, 'frxrcClassSpanish');
  AResources.AddFormResource(hInstance, 'frxrcDesgnSpanish');
  AResources.AddFormResource(hInstance, 'frxrcExportsSpanish');
  AResources.AddFormResource(hInstance, 'frxrcInspSpanish');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
  TfrAvailableLanguagesController.RegisterLanguageUnit('Spanish', 'frLanguageSpanish')
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
