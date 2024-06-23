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
unit frLanguageSerbian;
{$ENDIF}

interface

{$I frVer.inc}

const
  frsLanguageName = 'Serbian';

implementation

{$R frLanguageSerbian.res}

uses
  {$IFDEF FMX}FMX.frResources, FMX.frLocalization{$ELSE}frResources, frLocalization{$ENDIF};

procedure ApplyLanguage(const AResources: TfrStringResources);
begin
  AResources.AddFormResource(hInstance, 'frxrcClassSerbian');
  AResources.AddFormResource(hInstance, 'frxrcDesgnSerbian');
  AResources.AddFormResource(hInstance, 'frxrcExportsSerbian');
  AResources.AddFormResource(hInstance, 'frxrcInspSerbian');
end;
initialization
  TfrStringResources.Register(frsLanguageName, ApplyLanguage);
  TfrAvailableLanguagesController.RegisterLanguageUnit('Serbian', 'frLanguageSerbian')
finalization
  TfrStringResources.Unregister(frsLanguageName, ApplyLanguage);
end.
