{******************************************}
{                                          }
{          FastReport VCL/FMX/LCL          }
{           Localization Library           }
{                                          }
{         Copyright (c) 1998-2022          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

{$IFNDEF FMX}
unit frLocalization;
{$ENDIF}

interface

{$I frVer.inc}

uses
  SysUtils,
{$IFNDEF FMX}
  Types, Classes,
  frCoreClasses, frResources;
{$ELSE}
  System.Types, System.Classes,
  FMX.frCoreClasses, FMX.frResources;
{$ENDIF}

type
  TfrLanguage = type string;

  { TfrLocalizationController }

{$IFDEF DELPHI16}
  {$IFDEF FMX}
    {$IFDEF DELPHI26}
      [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32 or pidOSX64)]
    {$ELSE}
      [ComponentPlatformsAttribute(pidWin32 or pidWin64 or pidOSX32)]
    {$ENDIF}
  {$ELSE}
    [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
  {$ENDIF}
{$ENDIF}
  TfrLocalizationController = class(TfrCustomComponent)
  strict private
    function GetLanguage: TfrLanguage;
    procedure SetLanguage(const Value: TfrLanguage);
  private
    function IsStored: Boolean;
  published
    property Language: TfrLanguage read GetLanguage write SetLanguage stored IsStored;
  end;

  { TfrAvailableLanguagesController }

  TfrAvailableLanguagesController = class
  private class var
    FValues: TfrStringDictionary;
  protected
    class procedure Initialize; static;
    class procedure Finalize; static;
  public
    class procedure RegisterLanguageUnit(const ALanguage, AUnit: string); static;
    class procedure UnregisterLanguageUnit(const ALanguage, AUnit: string); static;

    class function GetLanguages: TStringDynArray; static;

    class function FindUnit(const ALanguage: string; out AUnit: string): Boolean; static;
    class function Empty: Boolean; static;
  end;

implementation

uses
{$IFNDEF FMX}
  {$IFDEF ACADEMICRU}
    frLanguageRussian,
  {$ENDIF}
  frLanguageEnglish;
{$ELSE}
  FMX.frLanguageEnglish;
{$ENDIF}

const
  FDefaultLanguageName = {$IFDEF ACADEMICRU}frLanguageRussian.frsLanguageName{$ELSE}frsLanguageName{$ENDIF};

{ TfrLocalizationController }

function TfrLocalizationController.GetLanguage: TfrLanguage;
begin
  Result := frStringResources.Language;
end;

function TfrLocalizationController.IsStored: Boolean;
begin
  Result := not SameText(Language, FDefaultLanguageName);
end;

procedure TfrLocalizationController.SetLanguage(const Value: TfrLanguage);
begin
  frStringResources.Language := Value;
end;

{ TfrAvailableLanguagesController }

class procedure TfrAvailableLanguagesController.Initialize;
begin
  FValues := TfrStringDictionary.Create;
end;

class procedure TfrAvailableLanguagesController.Finalize;
begin
  FreeAndNil(FValues);
end;

class function TfrAvailableLanguagesController.FindUnit(const ALanguage: string;
  out AUnit: string): Boolean;
begin
  Result := FValues.TryGetValue(ALanguage, AUnit);
end;

class function TfrAvailableLanguagesController.GetLanguages: TStringDynArray;
begin
  Result := FValues.Keys;
end;

class procedure TfrAvailableLanguagesController.RegisterLanguageUnit(
  const ALanguage, AUnit: string);
begin
{$IFDEF ACADEMICRU}
  if ALanguage = FDefaultLanguageName then
    Exit;
{$ENDIF}
  FValues.AddOrSetValue(ALanguage, AUnit);
end;

class procedure TfrAvailableLanguagesController.UnregisterLanguageUnit(
  const ALanguage, AUnit: string);
begin
  FValues.Remove(ALanguage);
end;

class function TfrAvailableLanguagesController.Empty: Boolean;
begin
  Result := FValues.Count = 0;
end;

initialization
  TfrAvailableLanguagesController.Initialize;
  frStringResources.Language := FDefaultLanguageName;
  frRegisterFrameworkComponentClass(TfrLocalizationController);

finalization
  TfrAvailableLanguagesController.Finalize;
end.
