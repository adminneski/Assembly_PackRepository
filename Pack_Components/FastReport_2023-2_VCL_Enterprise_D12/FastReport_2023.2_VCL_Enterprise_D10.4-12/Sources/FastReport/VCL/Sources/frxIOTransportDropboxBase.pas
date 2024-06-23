
{******************************************}
{                                          }
{              FastReport v6.0             }
{            Dropbox Save Filter           }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxIOTransportDropboxBase;

interface

{$I frx.inc}

uses
  Classes, Forms, Controls, StdCtrls, ComCtrls,
  frxClass, frxIOTransportHelpers, frxBaseTransportConnection, frxIOTransportOAuthDialog;

  const FRX_DBOX_DL_URL = 'https://content.dropboxapi.com/2/files/download';
  const FRX_DBOX_UL_URL = 'https://content.dropboxapi.com/2/files/upload';

type
  TfrxDropboxIOTransportForm = class(TfrxOAuthTransportDialog)
  protected
    function GetHelpLink: String; override;
  public
    procedure UpdateResouces; override;
  end;

{$IFDEF DELPHI16}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxBaseDropboxIOTransport = class(TfrxHTTPIOTransport)
  private
  protected
    function FilterSection: String; override;
    procedure SetRemoteDir(const Value: String); override;
    function GetRemoteDir: String; override;
    procedure TestRemoteDir; override;
    procedure DialogDirChange(Name, Id: String; DirItems: TStrings); override;
    procedure DialogDirCreate(Name: String; DirItems: TStrings); override;
    procedure DialogFileDelete(Name, Id: String; DirItems: TStrings); override;
    procedure DialogDirDelete(Name, Id: String; DirItems: TStrings); override;

    function FolderAPI(const URL, Source: String): String; virtual; abstract;
    function GetListFolder: String;
    function GetListFolderContinue(Cursor: String): String;
    procedure CreateFolder(Dir: String);
    procedure CreateRemoteDir(DirName: String; ChangeDir: Boolean = True); override;
    procedure DeleteFileOrFolder(Name: String);
    function IsDeleteSupported: Boolean; override;
  public
    class function GetDescription: String; override;
    class function TransportDialogClass: TfrxBaseTransportDialogClass; override;
    procedure GetDirItems(DirItems: TStrings; aFilter: String = ''); override;
    function GetOAuthURI: String; override;
  published
    property RemoteDir;
  end;

implementation

uses
  Windows, SysUtils, Graphics,
  frxMapHelpers, frxRes, frxSaveFilterBrowser, frxUtils, 
  frxJSON, Variants, StrUtils;

{ TfrxDropboxIOTransport }

procedure TfrxBaseDropboxIOTransport.CreateFolder(Dir: String);
const
  URL = 'https://api.dropboxapi.com/2/files/create_folder';
begin
  FolderAPI(URL, Format('{ "path": "%s" }', [SureUTF8(RemoteDir + Dir)]));
end;

procedure TfrxBaseDropboxIOTransport.CreateRemoteDir(DirName: String;
  ChangeDir: Boolean);
begin
  CreateFolder(DirName);
  if ChangeDir then
    RemoteDir := RemoteDir + DirName;
end;

procedure TfrxBaseDropboxIOTransport.DeleteFileOrFolder(Name: String);
const
  URL = 'https://api.dropboxapi.com/2/files/delete';
begin
  FolderAPI(URL, Format('{ "path": "%s" }', [SureUTF8(RemoteDir + Name)]));
end;

procedure TfrxBaseDropboxIOTransport.DialogDirChange(Name, Id: String;
  DirItems: TStrings);
begin
  RemoteDir := PathChangeDir(RemoteDir, Name);
  GetDirItems(DirItems);
end;

procedure TfrxBaseDropboxIOTransport.DialogDirCreate(Name: String;
  DirItems: TStrings);
begin
  CreateFolder(Name);
  GetDirItems(DirItems);
end;

procedure TfrxBaseDropboxIOTransport.DialogDirDelete(Name, Id: String;
  DirItems: TStrings);
begin
  DeleteFileOrFolder(Name);
  GetDirItems(DirItems);
end;

procedure TfrxBaseDropboxIOTransport.DialogFileDelete(Name, Id: String;
  DirItems: TStrings);
begin
  DeleteFileOrFolder(Name);
  GetDirItems(DirItems);
end;

function TfrxBaseDropboxIOTransport.FilterSection: String;
begin
  Result := 'DropboxFilter';
end;

class function TfrxBaseDropboxIOTransport.GetDescription: String;
begin
  Result := frxResources.Get('DropboxIOTransport');
end;

procedure TfrxBaseDropboxIOTransport.GetDirItems(DirItems: TStrings; aFilter: String);
var
  HasMore: Boolean;
  Cursor, s: String;

  procedure FillDirItems(frxJSONArray: TfrxJSONArray);
  var
    i: Integer;
  begin
    if RemoteDir <> '' then // Up directory
      AddToDirItems(DirItems, True, False, '..');

    for i := 0 to frxJSONArray.Count - 1 do
      with frxJSONArray.Get(i) do
        try
          AddToDirItems(DirItems,
            ValueByName('.tag') = 'folder', ValueByName('.tag') = 'file',
            ValueByName('name'));
        finally
          Free;
        end;
    frxJSONArray.Free;
  end;

  procedure GetJSONList(frxJSON: TfrxJSON);
  begin
    if not Assigned(frxJSON) then
      raise Exception.Create('Non valid JSON data');

    FillDirItems(TfrxJSONArray.Create(frxJSON.ObjectByName('entries')));

    HasMore := frxJSON.ValueByName('has_more') = 'true';
    if HasMore then
      Cursor := frxJSON.ValueByName('cursor');
    frxJSON.Free;
  end;

begin
  DirItems.BeginUpdate;
  try
    ClearWithObjects(DirItems);
    s := GetListFolder;
    if s <> '' then
      GetJSONList(TfrxJSON.Create(s));
    while HasMore do
    begin
      s := GetListFolderContinue(Cursor);
      if s <> '' then
        GetJSONList(TfrxJSON.Create(s));
    end;
  finally
    DirItems.EndUpdate;
  end;
end;

function TfrxBaseDropboxIOTransport.GetListFolder: String;
const
  URL = 'https://api.dropboxapi.com/2/files/list_folder';
begin
  Result := FolderAPI(URL, Format('{ "path": "%s" }', [SureUTF8(RemoteDir)]));
end;

function TfrxBaseDropboxIOTransport.GetListFolderContinue(Cursor: String): String;
const
  URL = 'https://api.dropboxapi.com/2/files/list_folder/continue';
begin
  Result := FolderAPI(URL, Format('{ "cursor": "%s" }', [Cursor]));
end;

function TfrxBaseDropboxIOTransport.GetOAuthURI: String;
begin
  Result := 'https://www.dropbox.com/oauth2/authorize?' +
                       'response_type=code' + '&' +
                       'client_id=' + ClientID + '&' +
                       'redirect_uri=' + GetRedirectURI;
end;

function TfrxBaseDropboxIOTransport.GetRemoteDir: String;
begin
  Result := FRemoteDir;
  if (Length(Result) > 1) and (Result[Length(Result)] <> '/') then Result := Result + '/';
  if (Length(Result) = 1) and (Result[1] = '/') then Delete(Result, 1, 1);
end;

function TfrxBaseDropboxIOTransport.IsDeleteSupported: Boolean;
begin
  Result := True;
end;

procedure TfrxBaseDropboxIOTransport.SetRemoteDir(const Value: String);
begin
  FRemoteDir := PathFirstSlash(Value);
end;

procedure TfrxBaseDropboxIOTransport.TestRemoteDir;
begin
  try
    GetListFolder;
  except
    raise;
//    Exception.Create(Format(
//      'Can''t change directory to %s: No such directory.',
//      [RemoteDir]));
  end;
end;

class function TfrxBaseDropboxIOTransport.TransportDialogClass: TfrxBaseTransportDialogClass;
begin
  Result := TfrxDropboxIOTransportForm;
end;

{ TfrxDropboxIOTransportForm }

function TfrxDropboxIOTransportForm.GetHelpLink: String;
begin
  Result := 'https://www.dropbox.com/developers/apps/create';
end;

procedure TfrxDropboxIOTransportForm.UpdateResouces;
begin
  Tag := 6490;
  ClientIDLabel.Tag := 6491;
  ClientSecLabel.Tag := 6495;
  inherited;
end;

end.
