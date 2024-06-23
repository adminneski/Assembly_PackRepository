
{******************************************}
{                                          }
{              FastReport v6.0             }
{          YandexDisk Save Filter          }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxIOTransportYandexDiskBase;

interface

{$I frx.inc}

uses
  Classes, Forms, Controls, StdCtrls, ComCtrls,
  frxIOTransportHelpers, frxBaseTransportConnection, frxIOTransportOAuthDialog;

const
  frx_YandexDisk_RootFolderId = 'disk:/'; // root
  frx_YandexDisk_MimeFolder = 'dir';      //type folder
  frx_YandexDisk_PreAut = 'OAuth ';       // Bearer swap
  frx_YandexDisk_CreateDir_URL = 'https://cloud-api.yandex.net/v1/disk/resources?path=%s';
  frx_YandexDisk_Delete_URL = 'https://cloud-api.yandex.net/v1/disk/resources?path=%s';
  frx_YandexDisk_Download_URL = 'https://cloud-api.yandex.net/v1/disk/resources/download?path=%s';
  frx_YandexDisk_ListDir_URL = 'https://cloud-api.yandex.net/v1/disk/resources?path=%s';
  frx_YandexDisk_ListDirContinue_URL = 'https://cloud-api.yandex.net/v1/disk/resources?path=%s&offset=%s';
  frx_YandexDisk_Upload_URL = 'https://cloud-api.yandex.net/v1/disk/resources/upload?path=%s&overwrite=true';
  frx_YandexDisk_Test = 'https://cloud-api.yandex.net/v1/disk';

type
  TfrxYandexDiskIOTransportForm = class(TfrxOAuthTransportDialog)
  protected
    function GetHelpLink: String; override;
  public
    procedure UpdateResouces; override;
  end;

{$IFDEF DELPHI16}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxBaseYandexDiskIOTransport = class(TfrxHTTPIOTransport)
  protected
    FDirStack: TDirStack;
    function FilterSection: String; override;
    procedure DialogDirChange(Name, Id: String; DirItems: TStrings); override;
    procedure DialogDirCreate(Name: String; DirItems: TStrings); override;
    procedure DialogFileDelete(Name, Id: String; DirItems: TStrings); override;
    procedure DialogDirDelete(Name, Id: String; DirItems: TStrings); override;

    procedure CreateRemoteDir(DirName: String; ChangeDir: Boolean = True); override;
    procedure ChangeDirUP; override;
    function GetListFolder: String; virtual; abstract;
    function GetListFolderContinue(Offset: String): String; virtual; abstract;
    procedure CreateFolder(Dir: String); virtual; abstract;
    procedure DeleteFileOrFolder(const Id: String); virtual; abstract;
    procedure AddToDirItems(DirItems: TStrings; IsFolder, IsFile: Boolean;
      Name: String; Id: String = ''); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function TransportDialogClass: TfrxBaseTransportDialogClass; override;
    class function GetDescription: String; override;
    procedure GetDirItems(DirItems: TStrings; aFilter: String = ''); override;
    function GetOAuthURI: String; override;
  end;

function frx_YandexDisk_GetToken_URL: String;

implementation

uses
  Windows, SysUtils, Graphics,
  frxMapHelpers, frxRes, frxSaveFilterBrowser, frxUtils,
  frxJSON;

{ TfrxYandexDiskIOTransport }

procedure TfrxBaseYandexDiskIOTransport.ChangeDirUP;
begin
  FDirStack.Pop;
end;

constructor TfrxBaseYandexDiskIOTransport.Create(AOwner: TComponent);
begin
  inherited;
  FDirStack := TDirStack.Create(frx_YandexDisk_RootFolderId);
end;

procedure TfrxBaseYandexDiskIOTransport.CreateRemoteDir(DirName: String;
  ChangeDir: Boolean);
var
  sList: TStringList;
  sID: String;
  Index: Integer;
begin
  CreateFolder(DirName);
  if not ChangeDir then Exit;
   sID := '';
  SList := TStringList.Create;
   try
    GetDirItems(sList, DirName);
    Index := sList.IndexOf('[' + DirName + ']');
    if Index <> -1 then
      sID := TIdObject(sList.Objects[Index]).Id;

    if sID <> '' then
      FDirStack.Push(sID);
  finally
    sList.Free;
  end;
end;

destructor TfrxBaseYandexDiskIOTransport.Destroy;
begin
  FDirStack.Free;
  inherited;
end;

procedure TfrxBaseYandexDiskIOTransport.DialogDirChange(Name, Id: String;
  DirItems: TStrings);
begin
  if Name = '..' then
    FDirStack.Pop
  else
    FDirStack.Push(Id);
  GetDirItems(DirItems);
end;

procedure TfrxBaseYandexDiskIOTransport.DialogDirCreate(Name: String;
  DirItems: TStrings);
begin
  CreateFolder(Name);
  GetDirItems(DirItems);
end;

procedure TfrxBaseYandexDiskIOTransport.DialogDirDelete(Name, Id: String;
  DirItems: TStrings);
begin
  DeleteFileOrFolder(Id);
  GetDirItems(DirItems);
end;

procedure TfrxBaseYandexDiskIOTransport.DialogFileDelete(Name, Id: String;
  DirItems: TStrings);
begin
  DeleteFileOrFolder(Id);
  GetDirItems(DirItems);
end;

function TfrxBaseYandexDiskIOTransport.FilterSection: String;
begin
  Result := 'YandexDiskFilter';
end;

class function TfrxBaseYandexDiskIOTransport.GetDescription: String;
begin
  Result := frxResources.Get('YandexDiskIOTransport');
end;

procedure TfrxBaseYandexDiskIOTransport.GetDirItems(DirItems: TStrings; aFilter: String);
var
  HasMore: Boolean;
  Yoffset: Integer;

  function FillDirItems(frxJSONArray: TfrxJSONArray): Integer;
  var
    i: Integer;
  begin
    if FDirStack.Top <> frx_YandexDisk_RootFolderId then // Up directory
      AddToDirItems(DirItems, True, False, '..', FDirStack.Top);

    Result := frxJSONArray.Count;

    for i := 0 to frxJSONArray.Count - 1 do
      with frxJSONArray.Get(i) do
        try
          AddToDirItems(DirItems,ValueByName('type') = frx_YandexDisk_MimeFolder,
            True, ValueByName('name'));
        finally
          Free;
        end;
    frxJSONArray.Free;
  end;

  procedure GetJSONList(frxJSON: TfrxJSON);
  var
    JSONembedded: TfrxJSON;
    Ycount: Integer;
  begin
    if not Assigned(frxJSON) then
      raise Exception.Create('Non valid JSON data');

    JSONembedded := TfrxJSON.CreateWeek(frxJSON.ObjectByName('_embedded'));

    Yoffset := Yoffset + FillDirItems(TfrxJSONArray.Create(JSONembedded.ObjectByName('items')));
    Ycount := StrToInt(JSONembedded.ValueByName('total'));
    HasMore := Yoffset < Ycount;

    frxJSON.Free;
    JSONembedded.Free;
  end;

begin
  DirItems.BeginUpdate;
  ClearWithObjects(DirItems);
  Yoffset := 0;
  GetJSONList(TfrxJSON.Create(GetListFolder));
  while HasMore do
    GetJSONList(TfrxJSON.Create(GetListFolderContinue(IntToStr(Yoffset))));
  DirItems.EndUpdate;
end;

function TfrxBaseYandexDiskIOTransport.GetOAuthURI: String;
begin
  Result := frxGet(520) + 'authorize?' +
            'client_id=' + ClientID + '&' +
            'redirect_uri=' + GetRedirectURI + '&' +
            'response_type=code&' +
            'scope=cloud_api:disk.read cloud_api:disk.write';
end;

procedure TfrxBaseYandexDiskIOTransport.AddToDirItems(DirItems: TStrings;
      IsFolder, IsFile: Boolean; Name: String; Id: String = '');
begin
  if Id = '' then
    Id := Name;
  inherited AddToDirItems(DirItems, IsFolder, IsFile, Name, Id);
end;

class function TfrxBaseYandexDiskIOTransport.TransportDialogClass: TfrxBaseTransportDialogClass;
begin
  Result := TfrxYandexDiskIOTransportForm;
end;

{ TfrxYandexDiskIOTransportForm }

function TfrxYandexDiskIOTransportForm.GetHelpLink: String;
begin
  Result := frxGet(520);
end;

procedure TfrxYandexDiskIOTransportForm.UpdateResouces;
begin
  Tag := 6521;
  ClientIDLabel.Tag := 6513;
  ClientSecLabel.Tag := 5705;
  inherited;
end;

{ Support }

function frx_YandexDisk_GetToken_URL: String;
begin
  Result := frxGet(520) + 'token';
end;

end.
