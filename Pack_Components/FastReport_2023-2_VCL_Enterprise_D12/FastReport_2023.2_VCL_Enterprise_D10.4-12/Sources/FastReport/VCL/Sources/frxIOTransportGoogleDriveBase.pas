
{******************************************}
{                                          }
{              FastReport v6.0             }
{          GoogleDrive Save Filter         }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxIOTransportGoogleDriveBase;

interface

{$I frx.inc}

uses
  Classes, Forms, Controls, StdCtrls, ComCtrls,
  frxIOTransportHelpers, frxBaseTransportConnection, frxIOTransportOAuthDialog;

const
// You can use the alias 'root' to refer to the root folder anywhere a file ID is provided
  frx_GoogleDrive_RootFolderId = 'root';
// In the Drive API, a folder is essentially a file — one identified by the special folder MIME type
  frx_GoogleDrive_MimeFolder = 'application/vnd.google-apps.folder';
  frx_GoogleDrive_CreateDir_URL = 'https://www.googleapis.com/drive/v3/files';
  frx_GoogleDrive_Delete_URL = 'https://www.googleapis.com/drive/v3/files/%s';
  frx_GoogleDrive_Download_URL = 'https://www.googleapis.com/drive/v3/files/%s?alt=media';
  frx_GoogleDrive_GetToken_URL = 'https://www.googleapis.com/oauth2/v4/token';
  frx_GoogleDrive_ListDir_URL = 'https://www.googleapis.com/drive/v3/files?q=''%s''+in+parents%s';
  frx_GoogleDrive_ListDirContinue_URL = 'https://www.googleapis.com/drive/v3/files?q=''%s''+in+parents%s&pageToken=%s';
  frx_GoogleDrive_Upload_URL = 'https://www.googleapis.com/upload/drive/v3/files?uploadType=multipart';

type
  TfrxGoogleDriveIOTransportForm = class(TfrxOAuthTransportDialog)
  protected
    function GetHelpLink: String; override;
  public
    procedure UpdateResouces; override;
  end;

{$IFDEF DELPHI16}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxBaseGoogleDriveIOTransport = class(TfrxHTTPIOTransport)
  protected
    FDirStack: TDirStack;
    function FilterSection: String; override;
    procedure DialogDirChange(Name, Id: String; DirItems: TStrings); override;
    procedure DialogDirCreate(Name: String; DirItems: TStrings); override;
    procedure DialogFileDelete(Name, Id: String; DirItems: TStrings); override;
    procedure DialogDirDelete(Name, Id: String; DirItems: TStrings); override;

    procedure CreateRemoteDir(DirName: String; ChangeDir: Boolean = True); override;
    procedure ChangeDirUP; override;
    function GetListFolder(aFilter: String = ''): String; virtual; abstract;
    function GetListFolderContinue(NextPageToken: String; aFilter: String = ''): String; virtual; abstract;
    procedure CreateFolder(Dir: String); virtual; abstract;
    procedure DeleteFileOrFolder(const Id: String); virtual; abstract;
    function PrepareName(const Name: String): String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function TransportDialogClass: TfrxBaseTransportDialogClass; override;
    class function GetDescription: String; override;
    procedure GetDirItems(DirItems: TStrings; aFilter: String = ''); override;
    function GetOAuthURI: String; override;
  end;

implementation

uses
  Windows, SysUtils, Graphics,
  frxMapHelpers, frxRes, frxSaveFilterBrowser, frxUtils,
  frxJSON;

{ TfrxGoogleDriveIOTransport }

procedure TfrxBaseGoogleDriveIOTransport.ChangeDirUP;
begin
  FDirStack.Pop;
end;

constructor TfrxBaseGoogleDriveIOTransport.Create(AOwner: TComponent);
begin
  inherited;
  FDirStack := TDirStack.Create(frx_GoogleDrive_RootFolderId);
end;

procedure TfrxBaseGoogleDriveIOTransport.CreateRemoteDir(DirName: String;
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

destructor TfrxBaseGoogleDriveIOTransport.Destroy;
begin
  FDirStack.Free;
  inherited;
end;

procedure TfrxBaseGoogleDriveIOTransport.DialogDirChange(Name, Id: String;
  DirItems: TStrings);
begin
  if Name = '..' then
    FDirStack.Pop
  else
    FDirStack.Push(Id);
  GetDirItems(DirItems);
end;

procedure TfrxBaseGoogleDriveIOTransport.DialogDirCreate(Name: String;
  DirItems: TStrings);
begin
  CreateFolder(Name);
  GetDirItems(DirItems);
end;

procedure TfrxBaseGoogleDriveIOTransport.DialogDirDelete(Name, Id: String;
  DirItems: TStrings);
begin
  DeleteFileOrFolder(Id);
  GetDirItems(DirItems);
end;

procedure TfrxBaseGoogleDriveIOTransport.DialogFileDelete(Name, Id: String;
  DirItems: TStrings);
begin
  DeleteFileOrFolder(Id);
  GetDirItems(DirItems);
end;

function TfrxBaseGoogleDriveIOTransport.FilterSection: String;
begin
  Result := 'GoogleDriveFilter';
end;

class function TfrxBaseGoogleDriveIOTransport.GetDescription: String;
begin
  Result := frxResources.Get('GoogleDriveIOTransport');
end;

procedure TfrxBaseGoogleDriveIOTransport.GetDirItems(DirItems: TStrings; aFilter: String);
var
  HasMore: Boolean;
  NextPageToken: String;

  procedure FillDirItems(frxJSONArray: TfrxJSONArray);
  var
    i: Integer;
  begin
    if FDirStack.Top <> frx_GoogleDrive_RootFolderId then // Up directory
      AddToDirItems(DirItems, True, False, '..', FDirStack.Top);

    for i := 0 to frxJSONArray.Count - 1 do
      with frxJSONArray.Get(i) do
        try
          AddToDirItems(DirItems,
            ValueByName('mimeType') = frx_GoogleDrive_MimeFolder, True,
            ValueByName('name'),            ValueByName('id'));
        finally
          Free;
        end;
    frxJSONArray.Free;
  end;

  procedure GetJSONList(frxJSON: TfrxJSON);
  begin
    if not Assigned(frxJSON) then
      raise Exception.Create('Non valid JSON data');

    FillDirItems(TfrxJSONArray.Create(frxJSON.ObjectByName('files')));

    HasMore := frxJSON.IsNameExists('nextPageToken');
    if HasMore then
      NextPageToken := frxJSON.ValueByName('nextPageToken');
    frxJSON.Free;
  end;

begin
  DirItems.BeginUpdate;
  ClearWithObjects(DirItems);
  aFilter := PrepareName(aFilter);
  GetJSONList(TfrxJSON.Create(GetListFolder(aFilter)));
  while HasMore do
    GetJSONList(TfrxJSON.Create(GetListFolderContinue(NextPageToken, aFilter)));
  DirItems.EndUpdate;
end;

function TfrxBaseGoogleDriveIOTransport.GetOAuthURI: String;
begin
  Result := 'https://accounts.google.com/o/oauth2/v2/auth?' +
            'client_id=' + ClientID + '&' +
            'redirect_uri=' + GetRedirectURI + '&' +
            'response_type=code&' +
            'scope=https://www.googleapis.com/auth/drive';
end;

function TfrxBaseGoogleDriveIOTransport.PrepareName(const Name: String): String;
begin
  Result := StringReplace(Name, ' ', '+', [rfReplaceAll]);
end;

class function TfrxBaseGoogleDriveIOTransport.TransportDialogClass: TfrxBaseTransportDialogClass;
begin
  Result := TfrxGoogleDriveIOTransportForm;
end;

{ TfrxGoogleDriveIOTransportForm }

function TfrxGoogleDriveIOTransportForm.GetHelpLink: String;
begin
  Result := 'https://console.cloud.google.com/apis/api/drive.googleapis.com/credentials';
end;

procedure TfrxGoogleDriveIOTransportForm.UpdateResouces;
begin
  Tag := 6520;
  ClientIDLabel.Tag := 6511;
  ClientSecLabel.Tag := 6512;
  inherited;
end;

end.
