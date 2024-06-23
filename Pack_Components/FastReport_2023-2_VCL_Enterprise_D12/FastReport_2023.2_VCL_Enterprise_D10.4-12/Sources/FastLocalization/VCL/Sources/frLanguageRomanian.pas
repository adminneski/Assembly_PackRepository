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
unit frLanguageRomanian;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'Romanian';

implementation

{$R frLanguageRomanian.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'frxrcClassRomanian');
  AResources.AddFormResource(hInstance, 'frxrcDesgnRomanian');
  AResources.AddFormResource(hInstance, 'frxrcExportsRomanian');
  AResources.AddFormResource(hInstance, 'frxrcInspRomanian');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
  TfrAvailableLanguagesController.RegisterLanguageUnit('Romanian', 'frLanguageRomanian')
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
