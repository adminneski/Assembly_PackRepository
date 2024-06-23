{*******************************************************}
{                                                       }
{                      EhLib 10.2                       }
{                  Language Resources                   }
{                                                       }
{     Copyright (c) 2016-2022 by Dmitry V. Bolshakov    }
{                                                       }
{*******************************************************}

unit LanguageResManEh;

interface

{$WARN SYMBOL_PLATFORM OFF}
{$I EhLib.Inc}

uses
  Messages, Variants, Graphics, Types,
{$IFDEF FPC}
  {$IFDEF FPC_CROSSP}
    LCLIntf, LCLType,
  {$ELSE}
    Windows,
  {$ENDIF}
  EhLibLCL,
{$ELSE}
  EhLibVCL, Windows,
{$ENDIF}
  ToolCtrlsEh, SysUtils, Classes,
  Controls, Forms, Dialogs, StdCtrls, Contnrs;

type
  TLanguageResourcePlacementEh = (lrpExternalEh, lrpEmbeddedEh);

  TAutoselectResourceLanguageEh = procedure(Sender: TObject; var LanguageAbbr: String) of object;

  ILanguageResourceLoadNotificationConsumer = interface
    ['{D0726CDE-269E-4E3C-8295-1FB9BDCE327A}']
    procedure ResourceLanguageChanged();
  end;

  TResObjectEh = class(TObject)
    RefResObject: TComponent;
    ResourceName: String;
    ExtResourceFileName: String;
    DefaultResourceLanguage: String;
  end;

{ TLanguageResourceManagerEh }

  TLanguageResourceManagerEh = class(TPersistent)
  private
    FLanguageList: TStringList;
    FLocObjects: TObjectListEh;
    FChangeNotifyConsumers: TObjectListEh;
    FActiveLanguageAbbr: String;
    FOnAutoselectLanguage: TAutoselectResourceLanguageEh;
    FResourceFolderPath: String;
    FResourcePlacement: TLanguageResourcePlacementEh;
    procedure SetActiveLanguageAbbr(const Value: String);
    function GetResObject(Index: Integer): TResObjectEh;
    function GetResObjectCount: Integer;
    function CheckLangExtIsCorrect(LangExt: String): Boolean;

  protected
    procedure ActiveLanguageChanged; virtual;
    procedure LoadListOfExternalLanguages(ALanguageList: TStringList; BaseFileName: String);
    procedure LoadListOfEmbeddedLanguages(ALanguageList: TStringList; BaseFileName: String);

  public
    constructor Create;
    destructor Destroy; override;

    function AutoselectLanguage(LCID: Integer): String; overload;
    function AutoselectLanguage: String; overload;
    function GetNativeLanguageName(LanguageAbbr: String): String;
    function GetSuffixForLocale(LCID: TLocaleID): String;
    function IndexOfLanguage(LangID: String): Integer;

    procedure ReadComponentResource(Component: TComponent; ResourceName: String);
    procedure ReadComponentEmbeddedResource(Component: TComponent);
    procedure ReadComponentExternalResource(Component: TComponent; ResourceName: String);
    procedure ReadComponentFromStream(Component: TComponent; Streat: TStream);

    procedure ReadObjectResource(ObjectRes: TResObjectEh);
    procedure AddLocalizableObject(Component: TComponent; ResourceName: String; ExtResourceFileName: String; DefaultResourceLanguage: String);
    procedure DeleteLocalizableObject(Component: TComponent);
    procedure LoadListOfAvailableLanguages(BaseFileName: String);
    procedure AddChangeNotifyConsumer(Component: TComponent; DefaultResourceLanguage: String);
    procedure DeleteChangeNotifyConsumer(Component: TComponent);
    procedure NotifyConsumerChange(Component: TObject);
    procedure NotifyAllConsumersChange;

    property LanguageList: TStringList read FLanguageList;
    property ResObject[Index: Integer]: TResObjectEh read GetResObject;
    property ResObjectCount: Integer read GetResObjectCount;
    property ActiveLanguageAbbr: String read FActiveLanguageAbbr write SetActiveLanguageAbbr;
    property ResourceFolderPath: String read FResourceFolderPath write FResourceFolderPath;
    property ResourcePlacement: TLanguageResourcePlacementEh read FResourcePlacement write FResourcePlacement default lrpExternalEh;

    property OnAutoselectLanguage: TAutoselectResourceLanguageEh read FOnAutoselectLanguage write FOnAutoselectLanguage;
  end;

function LanguageResourceManagerEh: TLanguageResourceManagerEh;

var
{$IFDEF EH_LIB_12}
  LanguageResourcesFolder: String = PathDelim+'Res';
{$ELSE}
  {$IFDEF FPC}
    LanguageResourcesFolder: String = PathDelim+'Res';
  {$ELSE}
    LanguageResourcesFolder: String = PathDelim+'Res.Ansi';
  {$ENDIF}
{$ENDIF}

implementation

var
  FLanguageResourceManager: TLanguageResourceManagerEh;

procedure BroadcastPerformMessage(Msg: Cardinal; WParam: WPARAM; LParam: LPARAM);
var
  i: Integer;
begin
  for I := 0 to Screen.FormCount - 1 do
  begin
    Screen.Forms[I].Perform(Msg, WParam, LParam);
    BroadcastPerformMessageFor(Screen.Forms[I], TControl, Msg, WParam, LParam);
  end;
end;

procedure InitUnit;
begin
end;

procedure FinalizeUnit;
begin
  FreeAndNil(FLanguageResourceManager);
end;

function LanguageResourceManagerEh: TLanguageResourceManagerEh;
begin
  if FLanguageResourceManager = nil then
    FLanguageResourceManager := TLanguageResourceManagerEh.Create;
   Result := FLanguageResourceManager;
end;

{$IFDEF FPC_CROSSP}
{$ELSE}
function GetLocaleDataW(ID: LCID; Flag: DWORD): string;
var
  Buffer: array[0..1023] of WideChar;
begin
  Buffer[0] := #0;
  GetLocaleInfoW(ID, Flag, Buffer, Length(Buffer));
  Result := Buffer;
end;

function GetLangAbbrByLCID(AID: LCID): String;
begin
  Result := GetLocaleDataW(AID, LOCALE_SABBREVLANGNAME);
end;

function GetPriLangAbbrByLCID(AID: Integer): String;
{$IFDEF MSWINDOWS}
var
  LSysLocale: TSysLocale;
  LanID: LANGID;
begin
  LanID := Word(AID);
  if LanID <> 0 then
  begin
    LSysLocale.PriLangID := LanID and $3ff;
    LSysLocale.SubLangID := LanID shr 10;
  end;
  Result := GetLangAbbrByLCID(LSysLocale.PriLangID);
end;
{$ELSE}
begin
  Result := 'ENU';
end;
{$ENDIF}

{$ENDIF} 

{ TLanguageResourceManagerEh }

constructor TLanguageResourceManagerEh.Create;
begin
  FLanguageList := TStringList.Create;
  FResourcePlacement := lrpExternalEh;

  FLocObjects := TObjectListEh.Create;
  FChangeNotifyConsumers := TObjectListEh.Create;
end;

destructor TLanguageResourceManagerEh.Destroy;
var
  i: Integer;
begin
  FreeAndNil(FLanguageList);

  for i := 0 to FLocObjects.Count-1 do
    FLocObjects[i].Free;
  FreeAndNil(FLocObjects);

  FreeAndNil(FChangeNotifyConsumers);
  inherited Destroy;
end;

procedure TLanguageResourceManagerEh.SetActiveLanguageAbbr(const Value: String);
begin
  if FActiveLanguageAbbr <> Value then
  begin
    if FLanguageList.IndexOf(Value) = -1 then
      raise Exception.Create('Language "' + Value + '" is not supported');
    FActiveLanguageAbbr := Value;
    ActiveLanguageChanged;
  end;
end;

procedure TLanguageResourceManagerEh.ReadObjectResource(ObjectRes: TResObjectEh);
begin
  if ResourcePlacement = lrpExternalEh then
    ReadComponentExternalResource(ObjectRes.RefResObject, ObjectRes.ExtResourceFileName)
  else
    ReadComponentEmbeddedResource(ObjectRes.RefResObject);
end;

procedure TLanguageResourceManagerEh.ReadComponentResource(
  Component: TComponent; ResourceName: String);
var
  ConsumerItfs: ILanguageResourceLoadNotificationConsumer;
  {$IFDEF FPC}
  HRs: {%H-}HRSRC;
  {$ELSE}
  HRs: HRSRC;
  {$ENDIF}
  HIn: HINST;
begin
  {$IFDEF FPC}
  HIn := HInstance;
  {$ELSE}
  HIn := FindResourceHInstance(FindClassHInstance(Component.ClassType));
  {$ENDIF}
  HRs := FindResource(HIn, PChar(ResourceName), PChar(RT_RCDATA));

  if HRs <> 0 then
  begin
    ReadComponentRes(ResourceName, Component);
    if Supports(Component, ILanguageResourceLoadNotificationConsumer, ConsumerItfs) then
      ConsumerItfs.ResourceLanguageChanged;
  end;
end;

function ReadSrcStream(FileName: String): TStream;
var
  fs: TFileStream;
begin
  fs := TFileStream.Create(FileName, fmOpenRead);
  Result := fs;
end;

procedure TLanguageResourceManagerEh.ReadComponentExternalResource(
  Component: TComponent; ResourceName: String);
var
  fs: TStream;
  FileName: String;
begin
  if ActiveLanguageAbbr = '' then
    raise Exception.Create('ActiveLanguage is not defined');

  FileName := ResourceFolderPath + PathDelim + ResourceName + '.' + ActiveLanguageAbbr+'.dfm';
  if FileExists(FileName) then
  begin
    fs := ReadSrcStream(FileName);

    try
      ReadComponentFromStream(Component, fs);
    finally
      fs.Free;
    end;
  end;
end;

procedure TLanguageResourceManagerEh.ReadComponentEmbeddedResource(Component: TComponent);
var
  ResourceName: String;
begin
  ResourceName := Component.ClassName + '_' + ActiveLanguageAbbr;
  ReadComponentResource(Component, ResourceName);
end;

procedure TLanguageResourceManagerEh.ReadComponentFromStream(Component: TComponent;
  Streat: TStream);
var
  ms: TMemoryStream;
begin
  if TestStreamFormat(Streat) = sofUnknown then
    raise Exception.Create('Invalid stream format.');

{$IFDEF EH_LIB_12}
  if TestStreamFormat(Streat) in [sofText, sofUTF8Text] then
{$ELSE}
  if TestStreamFormat(Streat) in [sofText] then
{$ENDIF}
  begin
    ms := TMemoryStream.Create;
    try
      ObjectTextToBinary(Streat, ms);
      ms.Position := 0;
      try
        ms.ReadComponent(Component);
      except
        on E: EReadError do
          Application.HandleException(E);
      end;
    finally
      ms.Free;
    end;
  end else
  begin
    Streat.ReadComponent(Component);
  end;
end;

procedure TLanguageResourceManagerEh.ActiveLanguageChanged;
var
  i: Integer;
begin
  for i := 0 to FLocObjects.Count-1 do
  begin
    if (ActiveLanguageAbbr <> '') then
      ReadObjectResource(TResObjectEh(FLocObjects[i]));
  end;
  NotifyAllConsumersChange;
end;

function TLanguageResourceManagerEh.GetNativeLanguageName(
  LanguageAbbr: String): String;
{$IFDEF FPC}
{$ELSE}
  {$IFDEF MSWINDOWS}
var
  i: Integer;
  AID: LCID;
  {$ENDIF}
{$ENDIF}
begin
{$IFDEF FPC}
  Result := LanguageAbbr;
{$ELSE}
  {$IFDEF MSWINDOWS}
  AID := 0;
  Result := '';
  for i := 0 to Languages.Count-1 do
  begin
    if Languages.Ext[i] = LanguageAbbr then
    begin
      AID := Languages.LocaleID[i];
      Break;
    end;
  end;
  if AID <> 0 then
    Result := GetLocaleDataW(AID, LOCALE_SNATIVELANGNAME);
  {$ELSE}
  Result := LanguageAbbr;
  {$ENDIF}
{$ENDIF}
end;

function TLanguageResourceManagerEh.GetResObject(Index: Integer): TResObjectEh;
begin
  Result := TResObjectEh(FLocObjects[Index]);
end;

function TLanguageResourceManagerEh.GetResObjectCount: Integer;
begin
  Result := FLocObjects.Count;
end;

function TLanguageResourceManagerEh.GetSuffixForLocale(LCID: TLocaleID): String;
{$IFDEF FPC}
{$ELSE}
  {$IFDEF MSWINDOWS}
var
  LcidIdx: Integer;
  {$ENDIF}
{$ENDIF}
begin
{$IFDEF FPC}
  Result := '';
{$ELSE}
  {$IFDEF MSWINDOWS}
  LcidIdx := Languages.IndexOf(LCID);
  if (LcidIdx = -1)
    then Result := ''
    else Result := Languages.Ext[LcidIdx];
  {$ELSE}
  Result := '';
  {$ENDIF}
{$ENDIF}
end;

function TLanguageResourceManagerEh.IndexOfLanguage(LangID: String): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to LanguageList.Count-1 do
  begin
    if LanguageList[i] = LangID then
    begin
      Result := i;
      Break;
    end;
  end;
end;

procedure TLanguageResourceManagerEh.LoadListOfAvailableLanguages(BaseFileName: String);
begin
  LanguageList.Clear();
  if ResourcePlacement = lrpExternalEh then
    LoadListOfExternalLanguages(LanguageList, BaseFileName)
  else
    LoadListOfEmbeddedLanguages(LanguageList, BaseFileName);
end;

var
  BaseResNameForEnum: String = '';

function EnumResNames(Module: HMODULE; ResType, ResName: PChar; lParam: Pointer): Integer; stdcall;
begin
  if (Pos(BaseResNameForEnum, ResName) > 0) and
     (Length(BaseResNameForEnum) + 3 = Length(ResName)) then
  begin
    TStringList(lParam).Add(Copy(ResName, Length(BaseResNameForEnum)+1, 3));
  end;
  Result := 1;
end;

procedure TLanguageResourceManagerEh.LoadListOfEmbeddedLanguages(
  ALanguageList: TStringList; BaseFileName: String);
begin
  BaseResNameForEnum := AnsiUpperCase(BaseFileName) + '_';
  EnumResourceNames(HInstance, RT_RCDATA, @EnumResNames, NativeInt(ALanguageList));
end;

procedure TLanguageResourceManagerEh.LoadListOfExternalLanguages(
  ALanguageList: TStringList; BaseFileName: String);
var
  sr: TSearchRec;
  ALangPaths: TStringList;
  i: Integer;
  Path: String;
  fName: String;
  LangExt: String;
  FindFilePathName: String;
begin
  if ResourceFolderPath = '' then
  begin
    Path := '';
    GetDir(0, Path);
    ResourceFolderPath := Path + LanguageResourcesFolder;
  end;

  ALangPaths := TStringList.Create;
  FindFilePathName := ResourceFolderPath + PathDelim + BaseFileName+'.???.dfm';
  if FindFirst(FindFilePathName, faAnyFile, sr) = 0 then
  begin
    repeat
      if (sr.name = '..') or (sr.name = '.') then Continue;
      if sr.Attr and faDirectory = 0 then
      begin
        ALangPaths.Add(ResourceFolderPath + PathDelim + sr.name);
      end;
    until
      FindNext(sr) <> 0;
  end;
  FindClose(sr);

  for i := 0 to ALangPaths.Count-1 do
  begin
    fName := ExtractFileName(ALangPaths[i]);
    fName := ChangeFileExt(fName, '');
    LangExt := ExtractFileExt(fName);
    if Copy(LangExt, 1, 1) = '.' then
      LangExt := Copy(LangExt, 2, Length(LangExt));
    LangExt := UpperCase(LangExt);

    if CheckLangExtIsCorrect(LangExt) then
      ALanguageList.Add(UpperCase(LangExt));
  end;

  ALangPaths.Free;
end;

function TLanguageResourceManagerEh.CheckLangExtIsCorrect(LangExt: String): Boolean;
{$IFDEF FPC}
begin
  Result := True;
end;
{$ELSE}
  {$IFDEF MSWINDOWS}
var
  i: Integer;
begin
  Result := False;
  for i := 0 to Languages.Count-1 do
  begin
    if Languages.Ext[i] = LangExt then
    begin
      Result := True;
      Break;
    end;
  end;
end;
  {$ELSE}
begin
  Result := True;
end;
  {$ENDIF}
{$ENDIF}

procedure TLanguageResourceManagerEh.AddLocalizableObject(Component: TComponent;
  ResourceName: String; ExtResourceFileName: String; DefaultResourceLanguage: String);
var
  ResObject: TResObjectEh;
begin
  ResObject := TResObjectEh.Create;
  ResObject.RefResObject := Component;
  ResObject.ResourceName := ResourceName;
  ResObject.ExtResourceFileName := ExtResourceFileName;
  ResObject.DefaultResourceLanguage := DefaultResourceLanguage;

  FLocObjects.Add(ResObject);
  if (DefaultResourceLanguage <> ActiveLanguageAbbr) and (ActiveLanguageAbbr <> '') then
    ReadObjectResource(ResObject);
end;

procedure TLanguageResourceManagerEh.DeleteLocalizableObject(Component: TComponent);
var
  i: Integer;
begin
  for i := 0 to FLocObjects.Count-1 do
  begin
    if (TResObjectEh(FLocObjects[i]).RefResObject = Component) then
    begin
      FreeObjectEh(FLocObjects[i]);
      FLocObjects.Delete(i);
    end;
  end;
end;

procedure TLanguageResourceManagerEh.AddChangeNotifyConsumer(Component: TComponent;
  DefaultResourceLanguage: String);
begin
  FChangeNotifyConsumers.Add(Component);
  if (DefaultResourceLanguage <> ActiveLanguageAbbr) and (ActiveLanguageAbbr <> '') then
    NotifyConsumerChange(Component);
end;

procedure TLanguageResourceManagerEh.DeleteChangeNotifyConsumer(Component: TComponent);
begin
  FChangeNotifyConsumers.Remove(Component);
end;

procedure TLanguageResourceManagerEh.NotifyConsumerChange(Component: TObject);
var
  ConsumerItfs: ILanguageResourceLoadNotificationConsumer;
begin
  if Supports(Component, ILanguageResourceLoadNotificationConsumer, ConsumerItfs) then
    ConsumerItfs.ResourceLanguageChanged;
end;

procedure TLanguageResourceManagerEh.NotifyAllConsumersChange;
var
  i: Integer;
begin
  for i := 0 to FChangeNotifyConsumers.Count-1 do
    NotifyConsumerChange(FChangeNotifyConsumers[i]);
  BroadcastPerformMessage(WM_SETTINGCHANGE, 0, 0);
end;

function TLanguageResourceManagerEh.AutoselectLanguage(LCID: Integer): String;
{$IFDEF FPC_CROSSP}
begin
  Result := 'ENU';
end;
{$ELSE}
begin
  Result := GetLangAbbrByLCID(LCID);
  if FLanguageList.IndexOf(Result) >= 0 then
    Exit;
  Result := GetPriLangAbbrByLCID(LCID);
  if FLanguageList.IndexOf(Result) >= 0 then
    Exit;
  if (FLanguageList.Count > 0) and (FLanguageList.IndexOf('ENU') >= 0) then
    Result := 'ENU'
  else
    Result := '';
end;
{$ENDIF}

function TLanguageResourceManagerEh.AutoselectLanguage: String;
{$IFDEF FPC_CROSSP}
begin
  Result := 'ENU';
end;
{$ELSE}
begin
  Result := AutoselectLanguage(GetThreadLocale);
  if Assigned(OnAutoselectLanguage) then
    OnAutoselectLanguage(Self, Result);
end;
{$ENDIF}

initialization
  InitUnit;
finalization
  FinalizeUnit;
end.

