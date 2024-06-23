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
unit frLanguageEnglish;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'English';

implementation

{$R frLanguageEnglish.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'fcxrcDesgnEnglish');
  AResources.AddFormResource(hInstance, 'fcxrcExportsEnglish');
  AResources.AddFormResource(hInstance, 'fcxrcStringsEnglish');
  AResources.AddFormResource(hInstance, 'frxrcClassEnglish');
  AResources.AddFormResource(hInstance, 'frxrcDesgnEnglish');
  AResources.AddFormResource(hInstance, 'frxrcExportsEnglish');
  AResources.AddFormResource(hInstance, 'frxrcInspEnglish');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
