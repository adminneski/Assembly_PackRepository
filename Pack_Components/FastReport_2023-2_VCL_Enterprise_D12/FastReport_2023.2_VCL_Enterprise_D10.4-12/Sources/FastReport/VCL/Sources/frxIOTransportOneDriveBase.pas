
{******************************************}
{                                          }
{              FastReport v6.0             }
{           OneDrive Save Filter           }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxIOTransportOneDriveBase;

interface

{$I frx.inc}

uses
  Classes, Forms, Controls, StdCtrls, ComCtrls,
  frxIOTransportHelpers,
  frxBaseTransportConnection, frxIOTransportOAuthDialog;

const
  frx_OneD_UP_URL = 'https://api.onedrive.com/v1.0/drive/root:%s:/children';
  frx_OneD_LF_URL = 'https://api.onedrive.com/v1.0/drive/root:%s:/children?select=name,folder,file';
  frx_OneD_DL_URL = 'https://api.onedrive.com/v1.0/drive/root:%s/%s:/content';
  frx_OneD_DEL_URL = 'https://api.onedrive.com/v1.0/drive/root:%s';
  frx_OneD_CreateDir_URL = 'https://api.onedrive.com/v1.0/drive/root:%s:/children';
  frx_OneD_Boundary = '560310243403';

type
  TfrxOneDriveIOTransportForm = class(TfrxOAuthTransportDialog)
  protected
    function GetHelpLink: String; override;
  public
    procedure UpdateResouces; override;
  end;

{$IFDEF DELPHI16}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxBaseOneDriveIOTransport = class(TfrxHTTPIOTransport)
  protected
    procedure SetRemoteDir(const Value: String); override;
    function GetRemoteDir: String; override;
    function FilterSection: String; override;
    procedure TestRemoteDir; override;
    procedure DialogDirChange(Name, Id: String; DirItems: TStrings); override;
    procedure DialogDirCreate(Name: String; DirItems: TStrings); override;
    procedure DialogFileDelete(Name, Id: String; DirItems: TStrings); override;
    procedure DialogDirDelete(Name, Id: String; DirItems: TStrings); override;

    procedure CreateRemoteDir(DirName: String; ChangeDir: Boolean = True); override;
    function GetListFolder: String; virtual; abstract;
    function GetListFolderContinue(NextLink: String): String; virtual; abstract;
    procedure CreateFolder(Dir: String); virtual; abstract;
    procedure DeleteFileOrFolder(Name: String); virtual; abstract;
  public
    constructor Create(AOwner: TComponent); override;
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
  frxJSON;

{ TfrxOneDriveIOTransport }

constructor TfrxBaseOneDriveIOTransport.Create(AOwner: TComponent);
begin
  inherited;

end;

procedure TfrxBaseOneDriveIOTransport.CreateRemoteDir(DirName: String;
  ChangeDir: Boolean);
begin
  CreateFolder(DirName);
  if ChangeDir then
    RemoteDir := RemoteDir + DirName;
end;

procedure TfrxBaseOneDriveIOTransport.DialogDirChange(Name, Id: String;
  DirItems: TStrings);
begin
  RemoteDir := PathChangeDir(RemoteDir, Name);
  GetDirItems(DirItems);
end;

procedure TfrxBaseOneDriveIOTransport.DialogDirCreate(Name: String;
  DirItems: TStrings);
begin
  CreateFolder(Name);
  GetDirItems(DirItems);
end;

procedure TfrxBaseOneDriveIOTransport.DialogDirDelete(Name, Id: String;
  DirItems: TStrings);
begin
  DeleteFileOrFolder(Name);
  GetDirItems(DirItems);
end;

procedure TfrxBaseOneDriveIOTransport.DialogFileDelete(Name, Id: String;
  DirItems: TStrings);
begin
  DeleteFileOrFolder(Name);
  GetDirItems(DirItems);
end;

function TfrxBaseOneDriveIOTransport.FilterSection: String;
begin
  Result := 'OneDriveFilter';
end;

class function TfrxBaseOneDriveIOTransport.GetDescription: String;
begin
  Result := frxResources.Get('OneDriveIOTransport');
end;

procedure TfrxBaseOneDriveIOTransport.GetDirItems(DirItems: TStrings; aFilter: String);
var
  HasMore: Boolean;
  NextLink: String;

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
            IsNameExists('folder'), IsNameExists('file'),
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

    FillDirItems(TfrxJSONArray.Create(frxJSON.ObjectByName('value')));

    HasMore := frxJSON.IsNameExists('@odata.nextLink');
    if HasMore then
      NextLink := frxJSON.ValueByName('@odata.nextLink');
    frxJSON.Free;
  end;

begin
  DirItems.BeginUpdate;
  ClearWithObjects(DirItems);
  GetJSONList(TfrxJSON.Create(GetListFolder));
  while HasMore do
    GetJSONList(TfrxJSON.Create(GetListFolderContinue(NextLink)));
  DirItems.EndUpdate;
end;

function TfrxBaseOneDriveIOTransport.GetOAuthURI: String;
begin
  Result := 'https://login.live.com/oauth20_authorize.srf?' +
            'client_id=' + ClientID + '&' +
            'scope=onedrive.readwrite' + '&' +
            'response_type=code' + '&' +
            'redirect_uri=' + GetRedirectURI;
end;

function TfrxBaseOneDriveIOTransport.GetRemoteDir: String;
begin
  Result := FRemoteDir;
 // if (Length(Result) = 0) or (Result[Length(Result)] <> '/') then Result := Result + '/';
end;

procedure TfrxBaseOneDriveIOTransport.SetRemoteDir(const Value: String);
begin
  FRemoteDir := PathFirstSlash(Value);
end;

procedure TfrxBaseOneDriveIOTransport.TestRemoteDir;
begin
  try
    GetListFolder;
  except
    raise Exception.Create(Format(
      'Can''t change directory to %s: No such directory.',
      [RemoteDir]));
  end;
end;

class function TfrxBaseOneDriveIOTransport.TransportDialogClass: TfrxBaseTransportDialogClass;
begin
  Result := TfrxOneDriveIOTransportForm;
end;

{ TfrxOneDriveIOTransportForm }

function TfrxOneDriveIOTransportForm.GetHelpLink: String;
begin
  Result := 'https://portal.azure.com/#blade/Microsoft_AAD_RegisteredApps/ApplicationsListBlade';
end;

procedure TfrxOneDriveIOTransportForm.UpdateResouces;
begin
  Tag := 6500;
  ClientIDLabel.Tag := 6501;
  ClientSecLabel.Tag := 6495;
  inherited;
end;

end.
