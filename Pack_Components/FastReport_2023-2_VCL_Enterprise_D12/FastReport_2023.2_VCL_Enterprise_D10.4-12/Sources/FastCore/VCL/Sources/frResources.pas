{******************************************}
{                                          }
{          FastReport VCL/FMX/LCL          }
{              Core Library                }
{           Resources management           }
{                                          }
{         Copyright (c) 1998-2022          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

{$IFNDEF FMX}
unit frResources;
{$ENDIF}

interface

{$I frVer.inc}

uses
{$IFNDEF FMX}
  Types, SysUtils, Classes,
  {$IFNDEF FPC} Windows, {$ELSE} LCLType, {$ENDIF}
  Forms, Controls, Buttons, ImgList, Graphics,
  frCore, frGZip, frCoreClasses, frGraphics, frXML;
{$ELSE}
  System.Types, System.SysUtils, System.Classes,
  FMX.frCore, FMX.frCoreClasses, FMX.frXML;
{$ENDIF}

type
  TfrStringResources = class;

  { TfrStringResourcesChangedListener }

  IfrStringResourcesChangedListener = interface
  ['{17F117AE-5105-40CB-82ED-02F1CA00348A}']
    procedure ResourcesChanged(AResources: TfrStringResources);
  end;

  { TfrHelpTopics }

  TfrHelpTopic = record
    Sender: string;
    Topic: string;
  end;

  TfrHelpTopics = array of TfrHelpTopic;

  { TfrStringResources }

  TfrStringResources = class
  public type
    TApplyLocalizationProc = procedure(const AResources: TfrStringResources);
  strict private
    class var
      FRegistredLanguages: TfrNamedObjectDictionary;
  private
    FCodePage: Integer;
    FHasChanges: Boolean;
    FHelpFile: string;
    FHelpTopics: TfrHelpTopics;
    FLanguage: string;
    FLockCount: Integer;
    FLiseners: TInterfaceList;
    FValues: TfrStringDictionary;
    procedure SetLanguage(const Value: string);
  protected
    procedure Changed;
    function GetHelpFileName: string; virtual;
    procedure UpdateResources; virtual;

    procedure RegisterHelpTopic(const ASender, ATopic: string); overload;
    procedure RegisterHelpTopic(const ATopic: TfrHelpTopic); overload;
    procedure UnregisterHelpTopic(const ASender: string);

    class procedure Initialize; static;
    class procedure Finalize; static;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Get(const AName: string): string; overload;
    function Get(const ID: Integer): string; overload;
    procedure Add(const AName, AValue: string);
    procedure AddOrSet(const AName: string; const AValue: WideString);
    procedure AddStrings(const AValues: string);
    procedure AddXML(const AValue: AnsiString);
    procedure AddFormResource(AInstance: TfrHandle; const AResourceName: string);
    procedure Clear;
    procedure Help(Sender: TObject); overload;
    procedure LoadFromFile(const AFileName: string);
    procedure LoadFromStream(AStream: TStream);

    procedure BeginUpdate;
    procedure EndUpdate;
    function IsUpdateLocked: Boolean;

    procedure AddListener(const AListener: IfrStringResourcesChangedListener);
    procedure RemoveListener(const AListener: IfrStringResourcesChangedListener);

    class procedure Register(const ALanguage: string; AProc: TApplyLocalizationProc); static;
    class procedure Unregister(const ALanguage: string; AProc: TApplyLocalizationProc); static;
    class function RegistredLanguages: TStringDynArray; static;

    property HelpFile: string read FHelpFile write FHelpFile;
    property Language: string read FLanguage write SetLanguage;
  end;

  { TfrStringResourcesChangedListener }

  TfrStringResourcesChangedListener = class abstract(TfrInterfacedObject, IfrStringResourcesChangedListener)
  protected
    // IfrStringResourcesChangedListener
    procedure ResourcesChanged(AResources: TfrStringResources); virtual; abstract;
  end;

{$IFNDEF FMX}
  { TfrImageResources }

  TfrImageResourcesAssignProc = procedure(AImages: TBitmap; AClear: Boolean = False) of object;

  TfrImageResources = class
  private
    FImages: TStringList;
    FImagesPPI: Integer;
    procedure SetImagesPPI(AValue: Integer);
  protected
    procedure AssignImages(ABitmap: TBitmap; DX, DY: Integer; ANormal, ADisabled: TImageList; AClear: Boolean = False; PPI: Integer = 0);
    procedure ClearFields; virtual;
    function CheckImageList(AInstance: TfrHandle; var AImageList: TImageList; const AListName, AResName: string;
      AAssignProc: TfrImageResourcesAssignProc; PPI: Integer): TImageList; overload; virtual;
    function CheckImageList(AInstance: TfrHandle; var AImageList: TImageList; const AListName, AResName: string;
      AAssignProc: TfrImageResourcesAssignProc = nil; const AWidth: Integer = DefaultToolBarImageWidth;
      const AHeigh: Integer = DefaultToolBarImageHeight; PPI: Integer = 0): TImageList; overload; virtual;
    function GetImages(const AName: string; APPIScale: Integer; AImageWidth, AImageHeight: Integer): TImageList;
    procedure LoadFromResourceName(AInstance: TfrHandle; const AResName: string; AResType: PChar; AAssignProc: TfrImageResourcesAssignProc; PPI: Integer = 0);
    procedure SetSpeedButtonGlyphFromImageList(AButton: TSpeedButton; AIndex: Integer; AImages, ADisabledImages: TImageList; PPI: Integer = 0); //delete fix for Transperent when WinLaz fix it.

    property Images: TStringList read FImages;
  public
    constructor Create;
    destructor Destroy; override;

    property ImagesPPI: Integer read FImagesPPI write SetImagesPPI;
  end;
{$ENDIF}

procedure frDisplayHHTopic(AHandle: TfrHandle; const ATopic: string);
function frStringResources: TfrStringResources;

implementation

{$IFDEF DELPHIVCL}
  type
  {$IFDEF UNICODE}
    THtmlHelp = function(hwndCaller: TfrHandle; pszFile: PWideChar;
      uCommand: Cardinal; dwData: Longint): TfrHandle; stdcall;
  {$ELSE}
    THtmlHelp = function(hwndCaller: TfrHandle; pszFile: PAnsiChar;
      uCommand: Cardinal; dwData: Longint): TfrHandle; stdcall;
  {$ENDIF}

  var
    HtmlHelp: THtmlHelp;
    OCXHandle: TfrHandle;
{$ENDIF}
var
  FStringResources: TfrStringResources;

{$IFDEF DELPHIVCL}
  procedure frDisplayHHTopic(AHandle: TfrHandle; const ATopic: string);
  const
    HelpProcName = {$IFDEF UNICODE} 'HtmlHelpW' {$ELSE} 'HtmlHelpA' {$ENDIF};
    HH_DISPLAY_TOPIC  = $0000;
    HH_DISPLAY_TOC    = $0001;
  begin
    if OCXHandle = 0 then
    begin
      OCXHandle := LoadLibrary('HHCtrl.OCX');
      if (OCXHandle <> 0) then
        HtmlHelp := GetProcAddress(OCXHandle, HelpProcName);
    end;
    if Assigned(HtmlHelp) then
      HtmlHelp(AHandle, PChar(ATopic), HH_DISPLAY_TOC, 0);
  end;
{$ELSE}
  procedure frDisplayHHTopic(AHandle: TfrHandle; const ATopic: string);
  begin
    {$IFDEF FPC}
      {$note frxDisplayHHTopic is just dummy proc ...}
    {$ENDIF}
  end;
{$ENDIF}

function frStringResources: TfrStringResources;
begin
  if FStringResources = nil then
    FStringResources := TfrStringResources.Create;
  Result := FStringResources;
end;

{ TfrStringResources }

class procedure TfrStringResources.Initialize;
begin
  FRegistredLanguages := TfrNamedObjectDictionary.Create;
end;

class procedure TfrStringResources.Finalize;
begin
  FreeAndNil(FRegistredLanguages)
end;

constructor TfrStringResources.Create;
begin
  inherited Create;
  FValues := TfrStringDictionary.Create;
  FLiseners := TInterfaceList.Create;
  FHelpFile := GetHelpFileName;
  SetLength(FHelpTopics, 0);
end;

destructor TfrStringResources.Destroy;
begin
  SetLength(FHelpTopics, 0);
  FreeAndNil(FValues);
  FreeAndNil(FLiseners);
  inherited Destroy;
end;

procedure TfrStringResources.Add(const AName, AValue: string);
begin
  AddOrSet(AName, frStrToWStr(AValue, FCodePage));
end;

procedure TfrStringResources.AddOrSet(const AName: string; const AValue: WideString);
begin
  if (AName = '') or (AValue = '') then
    Exit;
  FValues.AddOrSetValue(AName, AValue);
  Changed;
end;

procedure TfrStringResources.AddStrings(const AValues: string);
var
  I, LPos: Integer;
  LList: TStringList;
  LName, LValue: WideString;
begin
  BeginUpdate;
  try
    LList := TStringList.Create;
    try
      LList.Text := AValues;
      for I := 0 to LList.Count - 1 do
      begin
        LName := LList[I];
        LPos := Pos('=', LName);
        if LPos > 0 then
        begin
          LValue := Copy(LName, LPos + 1, MaxInt);
          Delete(LName, LPos - 1, MaxInt);
          AddOrSet(frWStrToStr(LName), LValue);
        end;
      end;
    finally
      LList.Free;
    end;
  finally
    EndUpdate;
  end;
end;

procedure TfrStringResources.AddXML(const AValue: AnsiString);
var
  AStream: TStringStream;
begin
  AStream := TStringStream.Create({$IFDEF UNICODE}'', TEncoding.UTF8{$ELSE}AValue{$ENDIF});
  try
  {$IFDEF UNICODE}
    AStream.WriteString(frAnsiToStr(AValue));
    AStream.Position := 0;
  {$ENDIF}
    LoadFromStream(AStream);
  finally
    AStream.Free;
  end;
end;

procedure TfrStringResources.Clear;
begin
  FValues.Clear;
  Changed;
end;

function TfrStringResources.Get(const AName: string): string;
begin
  if not FValues.TryGetValue(AName, Result) then
    Result := AName;
  if (Result <> '') and (Result[1] = '!') then //MSN! magic char
    Delete(Result, 1, 1);
end;

function TfrStringResources.Get(const ID: Integer): string;
begin
  Result := Get(IntToStr(ID));
end;

procedure TfrStringResources.LoadFromFile(const AFileName: string);
var
  LStream: TFileStream;
begin
  if FileExists(AFileName) then
  begin
    LStream := TFileStream.Create(AFileName, fmOpenRead or fmShareDenyNone);
    try
      LoadFromStream(LStream);
    finally
      LStream.Free;
    end;
  end;
end;

procedure TfrStringResources.LoadFromStream(AStream: TStream);

  procedure CheckAndAddItem(AItem: TfrXMLItem);
  begin
   if SameText(AItem.Name, 'StrRes') then
     AddOrSet(AItem.Prop['Name'], frxXMLToStr(AItem.Prop['Text'])) else
  end;

var
  LIndex: Integer;
  LRoot: TfrXMLItem;
  LXMLRes: TfrXMLDocument;
begin
  LXMLRes := TfrXMLDocument.Create;
  try
    BeginUpdate;
    try
      LXMLRes.LoadFromStream(AStream);
      LRoot := LXMLRes.Root;
      if not SameText(LRoot.Name, 'Resources') then
        Exit;
      FCodePage := StrToInt(LRoot.Prop['CodePage']);
      for LIndex := 0 to LRoot.Count - 1 do
        CheckAndAddItem(LRoot.Items[LIndex]);
    finally
      EndUpdate;
    end;
  finally
    LXMLRes.Free;
  end;
  UpdateResources;
end;

procedure TfrStringResources.BeginUpdate;
begin
  Inc(FLockCount);
end;

procedure TfrStringResources.EndUpdate;
begin
  Dec(FLockCount);
  if FHasChanges then
    Changed;
end;

function TfrStringResources.IsUpdateLocked: Boolean;
begin
  Result := FLockCount > 0;
end;

procedure TfrStringResources.AddFormResource(AInstance: TfrHandle; const AResourceName: string);
var
  AStream: TResourceStream;
begin
  AStream := TResourceStream.Create(AInstance, AResourceName, RT_RCDATA);
  try
    LoadFromStream(AStream);
  finally
    AStream.Free;
  end;
end;

procedure TfrStringResources.AddListener(const AListener: IfrStringResourcesChangedListener);
begin
  FLiseners.Add(AListener);
end;

procedure TfrStringResources.RemoveListener(const AListener: IfrStringResourcesChangedListener);
begin
  FLiseners.Remove(AListener);
end;

class procedure TfrStringResources.Register(const ALanguage: string; AProc: TApplyLocalizationProc);
var
  AList: TList;
  AValue: TObject;
begin
  if FRegistredLanguages.TryGetValue(ALanguage, AValue) then
    AList := TList(AValue)
  else
  begin
    AList := TList.Create;
    FRegistredLanguages.AddOrSetValue(ALanguage, AList);
  end;
  AList.Add(@AProc);
  if SameText(ALanguage, frStringResources.Language) then
    AProc(frStringResources);
end;

class function TfrStringResources.RegistredLanguages: TStringDynArray;
begin
  Result := FRegistredLanguages.Keys;
end;

procedure TfrStringResources.SetLanguage(const Value: string);
var
  AList: TList;
  AValue: TObject;
  I: Integer;
begin
  if FLanguage <> Value then
  begin
    FLanguage := Value;
    if FRegistredLanguages.TryGetValue(FLanguage, AValue) then
    begin
      AList := TList(AValue);
      BeginUpdate;
      try
        for I := 0 to AList.Count - 1 do
          TApplyLocalizationProc(AList[I])(Self);
      finally
        EndUpdate;
      end;
    end;
  end;
end;

class procedure TfrStringResources.Unregister(const ALanguage: string; AProc: TApplyLocalizationProc);
var
  AList: TList;
  AValue: TObject;
begin
  if FRegistredLanguages.TryGetValue(ALanguage, AValue) then
  begin
    AList := TList(AValue);
    AList.Remove(@AProc);
    if AList.Count = 0 then
      FRegistredLanguages.Remove(ALanguage);
  end;
end;

procedure TfrStringResources.Changed;
var
  I: Integer;
begin
  if IsUpdateLocked then
  begin
    FHasChanges := True;
    Exit;
  end;
  for I := 0 to FLiseners.Count - 1 do
    (FLiseners[I] as IfrStringResourcesChangedListener).ResourcesChanged(Self);
  FHasChanges := False;
end;

function TfrStringResources.GetHelpFileName: string;
begin
  Result := 'FRUser.chm';
end;

procedure TfrStringResources.UpdateResources;
begin
end;

procedure TfrStringResources.RegisterHelpTopic(const ASender, ATopic: string);
var
  AItem: TfrHelpTopic;
begin
  AItem.Sender := ASender;
  AItem.Topic := ATopic;
  RegisterHelpTopic(AItem);
end;

procedure TfrStringResources.RegisterHelpTopic(const ATopic: TfrHelpTopic);
var
  ACount: Integer;
begin
  ACount := Length(FHelpTopics);
  SetLength(FHelpTopics, ACount + 1);
  FHelpTopics[ACount] := ATopic;
end;

procedure TfrStringResources.UnregisterHelpTopic(const ASender: string);
var
  I: Integer;
  ACount: Integer;
  ADeletedCount: Integer;
begin
  I := 0;
  ADeletedCount := 0;
  ACount := Length(FHelpTopics);
  while I < ACount do
  begin
    if SameText(FHelpTopics[I].Sender, ASender) then
      Inc(ADeletedCount)
    else
      FHelpTopics[I - ADeletedCount] := FHelpTopics[I];
    Inc(I);
  end;
  SetLength(FHelpTopics, ACount - ADeletedCount);
end;

procedure TfrStringResources.Help(Sender: TObject);
var
  I: Integer;
  ATopic: string;
begin
  if Sender = nil then
    Exit;
  ATopic := '';
  for I := 0 to Length(FHelpTopics) do
    if SameText(FHelpTopics[I].Sender, Sender.ClassName) then
    begin
      ATopic := '::/' + FHelpTopics[I].Topic;
      Break;
    end;
  ATopic := FHelpFile + ATopic;
{$IFDEF DELPHIVCL}
  {$IFNDEF FR_COM}
    ATopic := ExtractFilePath(Application.ExeName) + ATopic;
  {$ENDIF}
  frDisplayHHTopic(Application.Handle, ATopic);
{$ENDIF}
end;

{$IFNDEF FMX}

{ TfrImageResources }

constructor TfrImageResources.Create;
begin
  inherited Create;
  FImagesPPI := DefaultPPI;
  FImages := TStringList.Create;
  FImages.OwnsObjects := True;
end;

destructor TfrImageResources.Destroy;
begin
  FreeAndNil(FImages);
  inherited Destroy;
end;

procedure TfrImageResources.AssignImages(ABitmap: TBitmap; DX, DY: Integer; ANormal, ADisabled: TImageList; AClear: Boolean = False; PPI: Integer = 0);
begin
  if ANormal = nil then
    Exit;
  if PPI = 0 then
    PPI := FImagesPPI;
  if AClear then
  begin
    ANormal.Clear;
    if Assigned(ADisabled) then
      ADisabled.Clear;
  end;
  frAssignImages(ABitmap, Round(DX * (PPI / 96)), Round(DY * (PPI / 96)), ANormal, ADisabled);
end;

procedure TfrImageResources.ClearFields;
begin
end;

function TfrImageResources.CheckImageList(AInstance: TfrHandle; var AImageList: TImageList; const AListName, AResName: string;
  AAssignProc: TfrImageResourcesAssignProc; PPI: Integer): TImageList;
begin
  Result := CheckImageList(AInstance, AImageList, AListName, AResName, AAssignProc,
    DefaultToolBarImageWidth, DefaultToolBarImageHeight, PPI);
end;

function TfrImageResources.CheckImageList(AInstance: THandle; var AImageList: TImageList; const AListName,
  AResName: string; AAssignProc: TfrImageResourcesAssignProc = nil; const AWidth: Integer = DefaultToolBarImageWidth;
  const AHeigh: Integer = DefaultToolBarImageHeight; PPI: Integer = 0): TImageList;
begin
  if AImageList = nil then
  begin
    if PPI = 0 then
      PPI := FImagesPPI;
    AImageList := GetImages(AListName, PPI, AWidth, AHeigh);
    if AResName <> '' then
      LoadFromResourceName(AInstance, AResName, RT_RCDATA, AAssignProc);
  end;
  Result := AImageList;
end;

function TfrImageResources.GetImages(const AName: string; APPIScale: Integer; AImageWidth, AImageHeight: Integer): TImageList;
var
  LName: string;
  LIndex: Integer;
begin
  LName := AName + IntToStr(APPIScale);
  LIndex := FImages.IndexOf(LName);
  if LIndex < 0 then
    LIndex := FImages.AddObject(LName, TImageList.Create(nil));
  Result := TImageList(FImages.Objects[LIndex]);
  if Result.Count = 0 then
  begin
    Result.Width := MulDiv(AImageWidth, APPIScale, 96);
    Result.Height := MulDiv(AImageHeight, APPIScale, 96);
  end;
end;

procedure TfrImageResources.LoadFromResourceName(AInstance: TfrHandle; const AResName: string; AResType: PChar;
  AAssignProc: TfrImageResourcesAssignProc; PPI: Integer = 0);
var
  LBitmap: TBitmap;
  LStream: TMemoryStream;
  LResStream: TResourceStream;
begin
  if PPI = 0 then
    PPI := FImagesPPI;
  LStream := TMemoryStream.Create;
  LResStream := TResourceStream.Create(AInstance, AResName, AResType);
  try
    frDecompressStream(LResStream, LStream);
    LStream.Position := 0;
    LBitmap := TBitmap.Create;
    try
      LBitmap.LoadFromStream(LStream);
      ScaleBitmap(LBitmap, PPI);
      AAssignProc(LBitmap);
    finally
      LBitmap.Free;
    end;
  finally
    LStream.Free;
    LResStream.Free;
  end;
end;

procedure TfrImageResources.SetSpeedButtonGlyphFromImageList(AButton: TSpeedButton; AIndex: Integer;
  AImages, ADisabledImages: TImageList; PPI: Integer = 0);  //delete fix for Transperent when WinLaz fix it.
var
  LBitmap: TfrBitmap;
begin
  if PPI = 0 then
    PPI := FImagesPPI;
  LBitmap := TfrBitmap.CreateSize(
    Round(DefaultToolBarImageWidth * 2 * (PPI / 96)),
    Round(DefaultToolBarImageHeight * (PPI / 96)));
  try
    LBitmap.Canvas.Brush.Color := clOlive;
    LBitmap.TransparentColor := clOlive;
    LBitmap.Canvas.FillRect(Rect(0, 0, LBitmap.Width, LBitmap.Height));
    AImages.Draw(LBitmap.Canvas, 0, 0, AIndex);
    ADisabledImages.Draw(LBitmap.Canvas, LBitmap.Width div 2, 0, AIndex);
    AButton.Glyph := LBitmap;
  finally
    LBitmap.Free;
  end;
end;

procedure TfrImageResources.SetImagesPPI(AValue: Integer);
begin
  // scale images only for PPI more than .25%
  if AValue mod 24  > 0 then
    AValue := AValue - AValue mod 24;
  if FImagesPPI = AValue Then Exit;
    FImagesPPI := AValue;
  ClearFields;
end;

{$ENDIF}

initialization
  TfrStringResources.Initialize;

finalization
  TfrStringResources.Finalize;
  FreeAndNil(FStringResources);
{$IFDEF DELPHIVCL}
  FreeLibrary(OCXHandle);
{$ENDIF}

end.
