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
unit frLanguageLatvian;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'Latvian';

implementation

{$R frLanguageLatvian.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'frxrcClassLatvian');
  AResources.AddFormResource(hInstance, 'frxrcDesgnLatvian');
  AResources.AddFormResource(hInstance, 'frxrcExportsLatvian');
  AResources.AddFormResource(hInstance, 'frxrcInspLatvian');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
  TfrAvailableLanguagesController.RegisterLanguageUnit('Latvian', 'frLanguageLatvian')
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
