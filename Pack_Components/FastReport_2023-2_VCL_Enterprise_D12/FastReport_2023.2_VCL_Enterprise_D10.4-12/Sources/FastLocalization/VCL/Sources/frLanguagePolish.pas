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
unit frLanguagePolish;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'Polish';

implementation

{$R frLanguagePolish.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'fcxrcDesgnPolish');
  AResources.AddFormResource(hInstance, 'fcxrcExportsPolish');
  AResources.AddFormResource(hInstance, 'fcxrcStringsPolish');
  AResources.AddFormResource(hInstance, 'frxrcClassPolish');
  AResources.AddFormResource(hInstance, 'frxrcDesgnPolish');
  AResources.AddFormResource(hInstance, 'frxrcExportsPolish');
  AResources.AddFormResource(hInstance, 'frxrcInspPolish');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
  TfrAvailableLanguagesController.RegisterLanguageUnit('Polish', 'frLanguagePolish')
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
