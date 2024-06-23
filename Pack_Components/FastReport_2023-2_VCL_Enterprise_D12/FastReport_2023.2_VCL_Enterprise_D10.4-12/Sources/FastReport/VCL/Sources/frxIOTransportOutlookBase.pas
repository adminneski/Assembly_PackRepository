
{******************************************}
{                                          }
{              FastReport v6.0             }
{            Outlook base Filter           }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxIOTransportOutlookBase;

interface

{$I frx.inc}

uses
  Classes, Forms, Controls, StdCtrls, ComCtrls,
  frxIOTransportHelpers, frxBaseTransportConnection, frxIOTransportOAuthDialog,
  frxBaseMailApi;

const
  frx_Outlook_InitializeBase_URL = 'https://login.microsoftonline.com/';
  frx_Outlook_ListLabels_URL = 'https://graph.microsoft.com/v1.0/me/mailFolders';
  frx_Outlook_ListMessagesBase_URL = 'https://graph.microsoft.com/v1.0/me/mailFolders/';
  frx_Outlook_ListAttachmentsBase_URL = 'https://graph.microsoft.com/v1.0/me/messages/';
  frx_Outlook_Upload_URL = 'https://graph.microsoft.com/v1.0/me/sendMail';
  frx_Outlook_Test = 'https://graph.microsoft.com/v1.0/me';

  frx_Outlook_Scope = 'scope=Mail.Read Mail.Send User.Read';

type

  TfrxTenant = (t_common, t_organizations, t_consumers);

  TfrxOutlookIOTransportForm = class(TfrxOAuthTransportDialog)
  protected
    function GetHelpLink: String; override;
  public
    procedure UpdateResouces; override;
  end;

{$IFDEF DELPHI16}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxBaseOutlookIOTransport = class(TfrxBaseMailIOTransport)
  protected
    FfrxTenant: TfrxTenant;
    function FilterSection: String; override;

    function GetListLabels(aFilter: String = ''): String; virtual; abstract;
    function GetListMessages(aFilter: String = ''): String; virtual; abstract;
    function GetListMessagesContinue(NextPageToken: String): String; virtual; abstract;
    function GetMessageInfo(id: String; aFilter: String = ''): String; virtual; abstract;
    function GetListAttachments(aFilter: String = ''): String; virtual;
    function GetListDownloads(frxMessageStack: TfrxMessageStack; Id: String; aFilter: String = ''): String; virtual; abstract;
    function PrepareName(const Name: String): String;
    function PrepareUploadStream(const Source: TStream; CT: AnsiString; DestFileName: String): AnsiString;

    procedure Download(const SourceFileName: String; const Source: TStream); override;
  public
    class function TransportDialogClass: TfrxBaseTransportDialogClass; override;
    class function GetDescription: String; override;
    procedure GetDirItems(DirItems: TStrings; aFilter: String = ''); override;
    function GetOAuthURI: String; override;
    property frxTenant: TfrxTenant read FfrxTenant write FfrxTenant default t_common;
  end;

  function frx_Outlook_Initialize(ft: TfrxTenant): String;
  function frx_Outlook_Authorize_URL(ft: TfrxTenant): String;
  function frx_Outlook_GetToken_URL(ft: TfrxTenant): String;
  function frx_Outlook_ListMessages_URL(frxLabel: TfrxLabel; q: String = ''): String;
  function frx_Outlook_ListAttachments_URL(id: String): String;
  function frx_Outlook_Download_URL(frxMessage: TfrxMessage; Id: String): String;
  function frxTenantToString(ft: TfrxTenant): String;

implementation

uses
  Windows, SysUtils, Graphics,
  frHashUtils, frxMapHelpers, frxRes, frxSaveFilterBrowser, frxUtils, frxNetUtils,
  frxJSON;

{ TfrxBaseOutlookIOTransport }

function TfrxBaseOutlookIOTransport.FilterSection: String;
begin
  Result := 'OutlookFilter';
end;

class function TfrxBaseOutlookIOTransport.GetDescription: String;
begin
  Result := frxResources.Get('OutlookIOTransport');
end;

procedure TfrxBaseOutlookIOTransport.GetDirItems(DirItems: TStrings; aFilter: String);
var
  HasMore: Boolean;
  NextPageToken: String;

  procedure AddRevert;
  begin
    AddToDirItems(DirItems, True, False, '..', '..');
  end;

  procedure GetJSONMessagesList(frxJSON: TfrxJSON);

    procedure FillMessages(frxJSONArray: TfrxJSONArray);
    var
      i: Integer;
    begin
      for i := 0 to frxJSONArray.Count - 1 do
        with frxJSONArray.Get(i) do
          try
            AddToDirItems(DirItems, True, False, FormatMailName(ValueByName('subject'), ValueByName('lastModifiedDateTime'),
              ValueByName('id')), ValueByName('id'));
          finally
            Free;
          end;
      frxJSONArray.Free;
    end;

  begin
    if not Assigned(frxJSON) then
      raise Exception.Create('Non valid JSON data');

    FillMessages(TfrxJSONArray.Create(frxJSON.ObjectByName('value')));

    HasMore := frxJSON.IsNameExists('@odata.nextLink');
    if HasMore then
      NextPageToken := frxJSON.ValueByName('@odata.nextLink');
    frxJSON.Free;
  end;

  procedure GetJSONLabelsList(frxJSON: TfrxJSON);

    procedure FillLabels(frxJSONArray: TfrxJSONArray);
    var
      i: Integer;
    begin
      for i := 0 to frxJSONArray.Count - 1 do
        with frxJSONArray.Get(i) do
          try
            AddToDirItems(DirItems, True, False, ValueByName('displayName'), ValueByName('id'));
          finally
            Free;
          end;
      frxJSONArray.Free;
    end;

  begin
    if not Assigned(frxJSON) then
      raise Exception.Create('Non valid JSON data');

    FillLabels(TfrxJSONArray.Create(frxJSON.ObjectByName('value')));

    frxJSON.Free;
  end;

  procedure GetJSONAttachmentsList(frxJSON: TfrxJSON);

    procedure FillAttachments(frxJSONArray: TfrxJSONArray);
    var
      i: Integer;
    begin
      for i := 0 to frxJSONArray.Count - 1 do
        with frxJSONArray.Get(i) do
          try
            AddToDirItems(DirItems, False, True, ValueByName('name'), ValueByName('id'));
          finally
            Free;
          end;
      frxJSONArray.Free;
    end;

  begin
    if not Assigned(frxJSON) then
      raise Exception.Create('Non valid JSON data');
    try
      FillAttachments(TfrxJSONArray.Create(frxJSON.ObjectByName('value')));
    finally
      frxJSON.Free;
    end;
  end;

begin
  DirItems.BeginUpdate;
  ClearWithObjects(DirItems);
  aFilter := PrepareName(aFilter);
  if (FfrxMessageStack.frxLabel.Id = '') then
  begin
    GetJSONLabelsList(TfrxJSON.Create(GetListLabels(aFilter)));
  end
  else
  if (FfrxMessageStack.frxMessage.Id = '') then
  begin
    AddRevert;
    GetJSONMessagesList(TfrxJSON.Create(GetListMessages(aFilter)));
    while HasMore do
      GetJSONMessagesList(TfrxJSON.Create(GetListMessagesContinue(NextPageToken)));
  end
  else
  begin
    AddRevert;
    GetJSONAttachmentsList(TfrxJSON.Create(GetListAttachments(aFilter)));
  end;

  DirItems.EndUpdate;
end;

function TfrxBaseOutlookIOTransport.GetOAuthURI: String;
begin
  Result := frx_Outlook_Authorize_URL(FfrxTenant) + '?' +
            'client_id=' + ClientID + '&' +
            'redirect_uri=' + GetRedirectURI + '&' +
            'response_type=code&' +
            'response_mode=query&' +
            frx_Outlook_Scope;
end;

function TfrxBaseOutlookIOTransport.GetListAttachments(aFilter: String = ''): String;
begin
  Result := GetMessageInfo(FfrxMessageStack.frxMessage.Id, aFilter);
end;

function TfrxBaseOutlookIOTransport.PrepareName(const Name: String): String;
begin
  Result := StringReplace(Name, ' ', '+', [rfReplaceAll]);
end;

function TfrxBaseOutlookIOTransport.PrepareUploadStream(const Source: TStream;
  CT: AnsiString; DestFileName: String): AnsiString;

  procedure Put(str: AnsiString);
  begin
    Result := Result + str;
  end;

  procedure PutLn(str: AnsiString = '');
  begin
    Put(str + #13#10);
  end;

begin
  Result := '';
  PutLn('{');
  PutLn('  "message": {');
  PutLn('    "subject": "' + AnsiString(UTF8Encode(Subject)) + '",');
  PutLn('    "body": {');
  PutLn('      "contentType": "Text",');
  PutLn('      "content": "' + AnsiString(UTF8Encode(MessageText.Text)) + '"');
  PutLn('    },');
  PutLn('    "toRecipients": [');
  PutLn('      {');
  PutLn('        "emailAddress": {');
  PutLn('          "address": "' + AnsiString(UTF8Encode(Address)) + '"');
  PutLn('        }');
  PutLn('      }');
  PutLn('    ],');
  PutLn('    "attachments": [');
  PutLn('      {');
  PutLn('        "@odata.type": "#microsoft.graph.fileAttachment",');
  PutLn('        "name": "' + AnsiString(UTF8Encode(DestFileName)) + '",');
  PutLn('        "contentType": "text/plain",');
  PutLn('        "contentBytes": "' + frBase64Encode(AnsiString(LoadStringFromStream(Source))) + '"');
  PutLn('      }');
  PutLn('    ]');
  PutLn('  }');
  PutLn('}');
end;

procedure TfrxBaseOutlookIOTransport.Download(const SourceFileName: String; const Source: TStream);
var
  sList: TStringList;
  sID: String;
  Index: Integer;

  procedure ParseRes(frxJSON: TfrxJSON);
  var
    buf: AnsiString;
  begin
    if not Assigned(frxJSON) then
      raise Exception.Create('Non valid JSON data');

    buf := frBase64URLDecode(AnsiString(frxJSON.ValueByName('contentBytes')));
    Source.Write(buf[1], Length(buf));

    frxJSON.Free;
  end;

begin
  inherited;
  sID := '';
  SList := TStringList.Create;
  GetDirItems(SList, SourceFileName);
  Index := sList.IndexOf(SourceFileName);
  if Index = -1 then Exit;
  sID  := TIdObject(sList.Objects[Index]).Id;
  try
    ParseRes(TfrxJSON.Create(GetListDownloads(FfrxMessageStack, sID)));
  finally
    ClearWithObjects(SList);
    SList.Free;
  end;
end;

class function TfrxBaseOutlookIOTransport.TransportDialogClass: TfrxBaseTransportDialogClass;
begin
  Result := TfrxOutlookIOTransportForm;
end;

{ TfrxOutlookIOTransportForm }

function TfrxOutlookIOTransportForm.GetHelpLink: String;
begin
  Result := 'https://portal.azure.com/#blade/Microsoft_AAD_IAM/ActiveDirectoryMenuBlade/RegisteredApps';
end;

procedure TfrxOutlookIOTransportForm.UpdateResouces;
begin
  Tag := 6523;
  ClientIDLabel.Tag := 6511;
  ClientSecLabel.Tag := 6512;
  RemoteDirLabel.Visible := False;
  RemoteDirComboBox.Visible := False;
  inherited;
end;

{ support }

function frx_Outlook_Initialize(ft: TfrxTenant): String;
begin
  Result := frx_Outlook_InitializeBase_URL + frxTenantToString(ft) + '/oauth2/v2.0/';
end;

function frx_Outlook_Authorize_URL(ft: TfrxTenant): String;
begin
  Result := frx_Outlook_Initialize(ft) + 'authorize';
end;

function frx_Outlook_GetToken_URL(ft: TfrxTenant): String;
begin
  Result := frx_Outlook_Initialize(ft) + 'token';
end;

function frx_Outlook_ListMessages_URL(frxLabel: TfrxLabel; q: String = ''): String;
begin
  Result := frx_Outlook_ListMessagesBase_URL + frxLabel.Id + '/messages?$select=subject,lastModifiedDateTime&$search="hasAttachments:True';
  if q <> '' then
    Result := Result + ' ' + q;
  Result := Result + '"';
end;

function frx_Outlook_ListAttachments_URL(id: String): String;
begin
  Result := frx_Outlook_ListAttachmentsBase_URL + id + '/attachments?$select=id,name';
end;

function frx_Outlook_Download_URL(frxMessage: TfrxMessage; Id: String): String;
begin
  Result := frx_Outlook_ListAttachmentsBase_URL + frxMessage.Id + '/attachments/' + Id;
end;

function frxTenantToString(ft: TfrxTenant): String;
begin
  case ft of
    t_common: Result := 'common';
    t_organizations: Result := 'organizations';
    t_consumers: Result := 'consumers';
  end;
end;

end.
