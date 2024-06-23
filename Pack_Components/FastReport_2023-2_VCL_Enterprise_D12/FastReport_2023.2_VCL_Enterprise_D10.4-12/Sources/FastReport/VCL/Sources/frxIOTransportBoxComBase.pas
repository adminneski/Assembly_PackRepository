
{******************************************}
{                                          }
{              FastReport v6.0             }
{            BoxCom Save Filter            }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxIOTransportBoxComBase;

interface

{$I frx.inc}

uses
  Classes, Forms, Controls, StdCtrls, ComCtrls,
  frxIOTransportHelpers, frxBaseTransportConnection, frxIOTransportOAuthDialog;

const
  frx_BoxCom_CreateDir_URL = 'https://api.box.com/2.0/folders';
  frx_BoxCom_DelFile_URL = 'https://api.box.com/2.0/files/%s';
  frx_BoxCom_DelDir_URL = 'https://api.box.com/2.0/folders/%s?recursive=true';
  frx_BoxCom_GetToken_URL = 'https://api.box.com/oauth2/token';
  frx_BoxCom_ListDir_URL = 'https://api.box.com/2.0/folders/%s/items?fields=type,name';
  frx_BoxCom_ListDirContinue_URL = 'https://api.box.com/2.0/folders/%s/items?fields=type,name&offset=%u';
  frx_BoxCom_Upload_URL = 'https://upload.box.com/api/2.0/files/content';

type
  TfrxBoxComIOTransportForm = class(TfrxOAuthTransportDialog)
  protected
    function GetHelpLink: String; override;
  public
    procedure UpdateResouces; override;
  end;

{$IFDEF DELPHI16}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxBaseBoxComIOTransport = class(TfrxHTTPIOTransport)
  protected
    FDirStack: TDirStack;
    function FilterSection: String; override;
    procedure DialogDirChange(Name, Id: String; DirItems: TStrings); override;
    procedure DialogDirCreate(Name: String; DirItems: TStrings); override;
    procedure DialogFileDelete(Name, Id: String; DirItems: TStrings); override;
    procedure DialogDirDelete(Name, Id: String; DirItems: TStrings); override;

    function GetListFolder: String; virtual; abstract;
    function GetListFolderContinue(Offset: Integer): String; virtual; abstract;
    procedure CreateFolder(Dir: String); virtual; abstract;
    procedure DeleteFile(Id: String); virtual; abstract;
    procedure DeleteFolder(Id: String); virtual; abstract;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    class function GetDescription: String; override;
    class function TransportDialogClass: TfrxBaseTransportDialogClass; override;
    procedure GetDirItems(DirItems: TStrings; aFilter: String = ''); override;
    function GetOAuthURI: String; override;
  end;

implementation

uses
  Windows, SysUtils, Graphics,
  frxMapHelpers, frxRes, frxSaveFilterBrowser, frxUtils,
  frxJSON;

const
  // https://docs.box.com/v2.0/reference#authorize
  MY_SECURITY_TOKEN = 'FUyabdy9G81Y';
  // The root folder of a Box account is always represented by the id “0”.
  RootFolderId = '0';

{ TfrxBoxComIOTransport }

constructor TfrxBaseBoxComIOTransport.Create(AOwner: TComponent);
begin
  inherited;
  FDirStack := TDirStack.Create(RootFolderId);
end;

destructor TfrxBaseBoxComIOTransport.Destroy;
begin
  FDirStack.Free;
  inherited;
end;

procedure TfrxBaseBoxComIOTransport.DialogDirChange(Name, Id: String;
  DirItems: TStrings);
begin
  if Name = '..' then
    FDirStack.Pop
  else
    FDirStack.Push(Id);
  GetDirItems(DirItems);
end;

procedure TfrxBaseBoxComIOTransport.DialogDirCreate(Name: String;
  DirItems: TStrings);
begin
  CreateFolder(Name);
  GetDirItems(DirItems);
end;

procedure TfrxBaseBoxComIOTransport.DialogDirDelete(Name, Id: String;
  DirItems: TStrings);
begin
  DeleteFolder(Id);
  GetDirItems(DirItems);
end;

procedure TfrxBaseBoxComIOTransport.DialogFileDelete(Name, Id: String;
  DirItems: TStrings);
begin
  DeleteFile(Id);
  GetDirItems(DirItems);
end;

function TfrxBaseBoxComIOTransport.FilterSection: String;
begin
  Result := 'BoxComFilter';
end;

class function TfrxBaseBoxComIOTransport.GetDescription: String;
begin
  Result := frxResources.Get('BoxComIOTransport');
end;

procedure TfrxBaseBoxComIOTransport.GetDirItems(DirItems: TStrings; aFilter: String);
var
  HasMore: Boolean;
  Offset, TotalCount: integer;

  procedure FillDirItems(frxJSONArray: TfrxJSONArray);
  var
    i: Integer;
  begin
    if FDirStack.Top <> RootFolderId then // Up directory
      AddToDirItems(DirItems, True, False, '..', FDirStack.Top);

    for i := 0 to frxJSONArray.Count - 1 do
      with frxJSONArray.Get(i) do
        try
          AddToDirItems(DirItems,
            ValueByName('type') = 'folder', ValueByName('type') = 'file',
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

    FillDirItems(TfrxJSONArray.Create(frxJSON.ObjectByName('entries')));

    Offset := Offset + StrToInt(frxJSON.ValueByName('limit'));
    TotalCount := StrToInt(frxJSON.ValueByName('total_count'));
    HasMore := Offset < TotalCount;
    frxJSON.Free;
  end;

begin
  DirItems.BeginUpdate;
  ClearWithObjects(DirItems);
  Offset := 0;
  GetJSONList(TfrxJSON.Create(GetListFolder));
  while HasMore do
    GetJSONList(TfrxJSON.Create(GetListFolderContinue(Offset)));
  DirItems.EndUpdate;
end;

function TfrxBaseBoxComIOTransport.GetOAuthURI: String;
begin
  Result := 'https://account.box.com/api/oauth2/authorize?' +
                       'response_type=code' + '&' +
                       'client_id=' + ClientID + '&' +
                       'redirect_uri=' + GetRedirectURI + '&' +
                       'state=' + MY_SECURITY_TOKEN;
end;

class function TfrxBaseBoxComIOTransport.TransportDialogClass: TfrxBaseTransportDialogClass;
begin
  Result := TfrxBoxComIOTransportForm;
end;

{ TfrxBoxComIOTransportForm }

function TfrxBoxComIOTransportForm.GetHelpLink: String;
begin
  Result := 'https://app.box.com/developers/console';
end;

procedure TfrxBoxComIOTransportForm.UpdateResouces;
begin
  Tag := 6510;
  ClientIDLabel.Tag := 6511;
  ClientSecLabel.Tag := 6512;
  inherited;
end;

end.
