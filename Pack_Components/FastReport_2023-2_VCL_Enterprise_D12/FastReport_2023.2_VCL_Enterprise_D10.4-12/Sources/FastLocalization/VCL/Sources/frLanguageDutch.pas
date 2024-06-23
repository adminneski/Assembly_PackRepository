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
unit frLanguageDutch;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'Dutch';

implementation

{$R frLanguageDutch.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'fcxrcDesgnDutch');
  AResources.AddFormResource(hInstance, 'fcxrcExportsDutch');
  AResources.AddFormResource(hInstance, 'fcxrcStringsDutch');
  AResources.AddFormResource(hInstance, 'frxrcClassDutch');
  AResources.AddFormResource(hInstance, 'frxrcDesgnDutch');
  AResources.AddFormResource(hInstance, 'frxrcExportsDutch');
  AResources.AddFormResource(hInstance, 'frxrcInspDutch');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
  TfrAvailableLanguagesController.RegisterLanguageUnit('Dutch', 'frLanguageDutch')
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
