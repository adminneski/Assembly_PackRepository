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
unit frLanguageChinese;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'Chinese';

implementation

{$R frLanguageChinese.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'frxrcClassChinese');
  AResources.AddFormResource(hInstance, 'frxrcDesgnChinese');
  AResources.AddFormResource(hInstance, 'frxrcExportsChinese');
  AResources.AddFormResource(hInstance, 'frxrcInspChinese');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
  TfrAvailableLanguagesController.RegisterLanguageUnit('Chinese', 'frLanguageChinese')
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
