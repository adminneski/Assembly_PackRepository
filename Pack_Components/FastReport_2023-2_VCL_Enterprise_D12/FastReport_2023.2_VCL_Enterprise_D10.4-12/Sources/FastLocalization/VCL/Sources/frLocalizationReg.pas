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
unit frLocalizationReg;
{$ENDIF}

interface

{$I frVer.inc}
{$R *.dcr}   //Repacked Version Line added

uses
{$IFNDEF FPC}
  DesignMenus, DesignEditors, DesignIntf,
{$ELSE}
  PropEdits, ComponentEditors,
{$ENDIF}
{$IFNDEF FMX}
  Types, Classes,
  frCoreReg,
  frCoreClasses,
  frResources,
  frLocalization,
{$ELSE}
  System.Types, System.Classes,
  FMX.Types,
  FMX.frCoreReg,
  FMX.frCoreClasses,
  FMX.frResources,
  FMX.frLocalization,
{$ENDIF}
  SysUtils;

procedure Register;

implementation

uses
{$IFDEF FMX}
  FMX.Menus
{$ELSE}
  Menus
{$ENDIF};

{$IFDEF FPC}
  {$R 'frLocalizationReg.dcr'}
{$ENDIF}

var
  FAddedLanguages: TStringList;

type
  { TfrLanguagePropertyEditor }

  TfrLanguagePropertyEditor = class(TfrChooserStringPropertyEditor)
  protected
    function DoGetValues: TStringDynArray; override;
  end;

  { TfrLocalizationControllerComponentEditor }

  TfrLocalizationControllerComponentEditor = class(TfrComponentEditor)
  private
    procedure ClickAllHandler(Sender: TObject);
    procedure ClickLanguageHandler(Sender: TObject);
  protected
    procedure DoExecuteVerb(AIndex: Integer); override;
    function DoGetVerb(AIndex: Integer): string; override;
    function DoGetVerbCount: Integer; override;
  public
  {$IFNDEF FPC}
    procedure PrepareItem(Index: Integer; const AItem: IMenuItem); override;
  {$ENDIF}
  end;

{$IFNDEF FPC}
  { TfrLocalizationControllerSelectionEditor }

  TfrLocalizationControllerSelectionEditor = class(TSelectionEditor)
  public
    procedure RequiresUnits(Proc: TGetStrProc); override;
  end;
{$ENDIF}

function SortList(const AList: TStringDynArray): TStringDynArray;
var
  AResult: TStringList;
  I: Integer;
  ALength: Integer;
begin
  ALength := Length(AList);
  AResult := TStringList.Create;
  try
    AResult.Sorted := True;
    for I := 0 to ALength - 1 do
      AResult.Add(AList[I]);
    SetLength(Result, ALength);
    for I := 0 to ALength - 1 do
      Result[I] := AResult[I];
  finally
    AResult.Free;
  end;
end;

{ TfrLanguagePropertyEditor }

function TfrLanguagePropertyEditor.DoGetValues: TStringDynArray;
begin
  Result := SortList(frStringResources.RegistredLanguages);
end;

{ TfrLocalizationControllerComponentEditor }

procedure TfrLocalizationControllerComponentEditor.ClickAllHandler(Sender: TObject);
var
  I: Integer;
  AList: TStringDynArray;
begin
  AList := TfrAvailableLanguagesController.GetLanguages;
  for I := 0 to Length(AList) - 1 do
  begin
    if FAddedLanguages.IndexOf(AList[I]) = -1 then
      FAddedLanguages.Add(AList[I]);
  end;
  Designer.Modified;
end;

procedure TfrLocalizationControllerComponentEditor.ClickLanguageHandler(
  Sender: TObject);
var
  AItem: TMenuItem;
  AIndex: Integer;
  AChecked: Boolean;
  ACaption: string;
begin
  if not (Sender is TMenuItem) then
    Exit;
  AItem := TMenuItem(Sender);
  ACaption := AItem.{$IFNDEF FMX}Caption{$ELSE}Text{$ENDIF};
  AIndex := FAddedLanguages.IndexOf(ACaption);
  AChecked := AItem.{$IFNDEF FMX}Checked{$ELSE}IsChecked{$ENDIF};
  if AChecked then
  begin
    if AIndex <> -1 then
      FAddedLanguages.Delete(AIndex);
  end
  else
  begin
    if AIndex = -1 then
      FAddedLanguages.Add(ACaption);
  end;
  Designer.Modified;
end;

procedure TfrLocalizationControllerComponentEditor.DoExecuteVerb(
  AIndex: Integer);
begin
  case AIndex of
    0:;
  else
    inherited DoExecuteVerb(AIndex);
  end;
end;

function TfrLocalizationControllerComponentEditor.DoGetVerb(
  AIndex: Integer): string;
begin
  case AIndex of
    0: Result := 'Add Language';
  else
    Result := inherited DoGetVerb(AIndex);
  end;
end;

function TfrLocalizationControllerComponentEditor.DoGetVerbCount: Integer;
begin
{$IFNDEF FMX}
  if TfrAvailableLanguagesController.Empty then
    Result := 0
  else
    Result := 1;
{$ELSE}
  Result := 0;
{$ENDIF}
end;

{$IFNDEF FPC}
  procedure TfrLocalizationControllerComponentEditor.PrepareItem(Index: Integer;
    const AItem: IMenuItem);
  var
    AList: TStringDynArray;
    I: Integer;
  begin
    AList := SortList(TfrAvailableLanguagesController.GetLanguages);
    if (Index = 0) and (Length(AList) > 0) then
    begin
      AItem.AddItem('All', 0, False, True, ClickAllHandler);
      AItem.AddItem('-', 0, False, False);
      for I := 0 to Length(AList) - 1 do
        AItem.AddItem(AList[I], 0,  FAddedLanguages.IndexOf(AList[I]) >= 0, True, ClickLanguageHandler);
    end
    else
      inherited PrepareItem(Index, AItem);
  end;
{$ENDIF}

{$IFNDEF FPC}
  { TfrLocalizationControllerSelectionEditor }

  procedure TfrLocalizationControllerSelectionEditor.RequiresUnits(
    Proc: TGetStrProc);

    procedure AddUnit(const ALanguage: string);
    var
      ALanguageUnit: string;
    begin
      if TfrAvailableLanguagesController.FindUnit(ALanguage, ALanguageUnit) then
      begin
      {$IFDEF FMX}
        Proc('FMX.' + ALanguageUnit);
      {$ELSE}
        Proc(ALanguageUnit);
      {$ENDIF}
      end;
    end;

  var
    I: Integer;
  begin
    inherited RequiresUnits(Proc);
  {$IFDEF FMX}
    Proc('FMX.frLocalization');
  {$ELSE}
    Proc('frLocalization');
  {$ENDIF}
    AddUnit(frStringResources.Language);
    for I := 0 to FAddedLanguages.Count - 1 do
      AddUnit(FAddedLanguages[I]);
    FAddedLanguages.Clear;
  end;
{$ENDIF FPC}

procedure Register;
begin
  frRegisterFrameworkComponentClass(TfrLocalizationController);
  RegisterComponents(frDefaultLibraryProductPage, [TfrLocalizationController]);
  RegisterComponentEditor(TfrLocalizationController, TfrLocalizationControllerComponentEditor);
{$IFNDEF FPC}
  RegisterSelectionEditor(TfrLocalizationController, TfrLocalizationControllerSelectionEditor);
{$ENDIF}

  RegisterPropertyEditor(TypeInfo(TfrLanguage), TfrLocalizationController, 'Language', TfrLanguagePropertyEditor);
end;

initialization
  FAddedLanguages := TStringList.Create;
finalization
  FreeAndNil(FAddedLanguages);
end.
