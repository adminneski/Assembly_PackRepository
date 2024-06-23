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
unit frLanguageCatalon;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'Catalon';

implementation

{$R frLanguageCatalon.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'frxrcClassCatalon');
  AResources.AddFormResource(hInstance, 'frxrcDesgnCatalon');
  AResources.AddFormResource(hInstance, 'frxrcExportsCatalon');
  AResources.AddFormResource(hInstance, 'frxrcInspCatalon');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
  TfrAvailableLanguagesController.RegisterLanguageUnit('Catalon', 'frLanguageCatalon')
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
