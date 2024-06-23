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
unit frLanguageSlovak;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'Slovak';

implementation

{$R frLanguageSlovak.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'frxrcClassSlovak');
  AResources.AddFormResource(hInstance, 'frxrcDesgnSlovak');
  AResources.AddFormResource(hInstance, 'frxrcExportsSlovak');
  AResources.AddFormResource(hInstance, 'frxrcInspSlovak');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
  TfrAvailableLanguagesController.RegisterLanguageUnit('Slovak', 'frLanguageSlovak')
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
