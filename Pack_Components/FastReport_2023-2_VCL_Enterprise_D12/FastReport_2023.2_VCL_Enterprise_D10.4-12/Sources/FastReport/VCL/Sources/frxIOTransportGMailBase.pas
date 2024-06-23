
{******************************************}
{                                          }
{              FastReport v6.0             }
{             GMail base Filter            }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxIOTransportGMailBase;

interface

{$I frx.inc}

uses
  Classes, Forms, Controls, StdCtrls, ComCtrls,
  frxIOTransportHelpers, frxBaseTransportConnection, frxIOTransportOAuthDialog,
  frxBaseMailApi;

const
  frx_GMail_GetToken_URL = 'https://www.googleapis.com/oauth2/v4/token';
  frx_GMail_ListLabels_URL = 'https://gmail.googleapis.com/gmail/v1/users/me/labels';
  frx_GMail_ListMessagesBase_URL = 'https://gmail.googleapis.com/gmail/v1/users/me/messages';
  frx_GMail_Upload_URL = 'https://gmail.googleapis.com/gmail/v1/users/me/messages/send';
  frx_GMail_Test = 'https://gmail.googleapis.com/gmail/v1/users/me/profile';

type
  TfrxGMailIOTransportForm = class(TfrxOAuthTransportDialog)
  protected
    function GetHelpLink: String; override;
  public
    procedure UpdateResouces; override;
  end;

{$IFDEF DELPHI16}
  [ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxBaseGMailIOTransport = class(TfrxBaseMailIOTransport)
  protected
    function FilterSection: String; override;

    function GetListLabels(aFilter: String = ''): String; virtual; abstract;
    function GetListMessages(aFilter: String = ''): String; virtual; abstract;
    function GetListMessagesContinue(NextPageToken: String; aFilter: String = ''): String; virtual; abstract;
    function GetMessageInfo(id: String; aFilter: String = ''): String; virtual; abstract;
    function GetListAttachments(aFilter: String = ''): String; virtual;
    function GetListDownloads(frxMessageStack: TfrxMessageStack; Id: String; aFilter: String = ''): String; virtual; abstract;
    function GetSomethingById(id: String): String;
    function PrepareName(const Name: String): String;
    function PrepareUploadStream(const Source: TStream; CT: AnsiString; DestFileName: String): AnsiString;

    procedure Download(const SourceFileName: String; const Source: TStream); override;
  public
    class function TransportDialogClass: TfrxBaseTransportDialogClass; override;
    class function GetDescription: String; override;
    procedure GetDirItems(DirItems: TStrings; aFilter: String = ''); override;
    function GetOAuthURI: String; override;
  end;

  function frx_GMail_ListMessages_URL(frxLabel: TfrxLabel; q: String = ''): String;
  function frx_GMail_ListMessagesContinue_URL(frxLabel: TfrxLabel; q: String = ''; pt: String = ''): String;
  function frx_GMail_ListAttachments_URL(id: String): String;
  function frx_GMail_Download_URL(frxMessage: TfrxMessage; Id: String): String;

  const
    GMailBoundary = '560310243403';

implementation

uses
  Windows, SysUtils, Graphics,
  frHashUtils, frxMapHelpers, frxRes, frxSaveFilterBrowser, frxUtils, frxNetUtils,
  frxJSON;

{ TfrxBaseGMailIOTransport }

function TfrxBaseGMailIOTransport.FilterSection: String;
begin
  Result := 'GMailFilter';
end;

class function TfrxBaseGMailIOTransport.GetDescription: String;
begin
  Result := frxResources.Get('GMailIOTransport');
end;

procedure TfrxBaseGMailIOTransport.GetDirItems(DirItems: TStrings; aFilter: String);
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
            AddToDirItems(DirItems, True, False, GetSomethingById(ValueByName('id')), ValueByName('id'));
          finally
            Free;
          end;
      frxJSONArray.Free;
    end;

  begin
    if not Assigned(frxJSON) then
      raise Exception.Create('Non valid JSON data');

    FillMessages(TfrxJSONArray.Create(frxJSON.ObjectByName('messages')));

    HasMore := frxJSON.IsNameExists('nextPageToken');
    if HasMore then
      NextPageToken := frxJSON.ValueByName('nextPageToken');
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
            AddToDirItems(DirItems, True, False, ValueByName('name'), ValueByName('id'));
          finally
            Free;
          end;
      frxJSONArray.Free;
    end;

  begin
    if not Assigned(frxJSON) then
      raise Exception.Create('Non valid JSON data');

    FillLabels(TfrxJSONArray.Create(frxJSON.ObjectByName('labels')));

    frxJSON.Free;
  end;

  procedure GetJSONAttachmentsList(frxJSON: TfrxJSON);
  var
    PLD: TfrxJSON;

    procedure FillAttachments(frxJSONArray: TfrxJSONArray);
    var
      i: Integer;
      Body: TfrxJSON;
    begin
      for i := 0 to frxJSONArray.Count - 1 do
        with frxJSONArray.Get(i) do
        try
          if (ValueByName('filename') <> '') then
          begin
            Body := TfrxJSON.CreateWeek(ObjectByName('body'));
            try
              AddToDirItems(DirItems, False, True, ValueByName('filename'), Body.ValueByName('attachmentId'));
            finally
              Body.Free;
            end;
          end;
        finally
          Free;
        end;
      frxJSONArray.Free;
    end;

  begin
    if not Assigned(frxJSON) then
      raise Exception.Create('Non valid JSON data');
    try
      PLD := TfrxJSON.CreateWeek(frxJSON.ObjectByName('payload'));
      try
        FillAttachments(TfrxJSONArray.Create(PLD.ObjectByName('parts')));
      finally
        PLD.Free;
      end;
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
      GetJSONMessagesList(TfrxJSON.Create(GetListMessagesContinue(NextPageToken, aFilter)));
  end
  else
  begin
    AddRevert;
    GetJSONAttachmentsList(TfrxJSON.Create(GetListAttachments(aFilter)));
  end;

  DirItems.EndUpdate;
end;

function TfrxBaseGMailIOTransport.GetOAuthURI: String;
begin
  Result := 'https://accounts.google.com/o/oauth2/v2/auth?' +
            'client_id=' + ClientID + '&' +
            'redirect_uri=' + GetRedirectURI + '&' +
            'response_type=code&' +
            'scope=https://mail.google.com';
end;

function TfrxBaseGMailIOTransport.GetListAttachments(aFilter: String = ''): String;
begin
  Result := GetMessageInfo(FfrxMessageStack.frxMessage.Id, aFilter);
end;

function TfrxBaseGMailIOTransport.GetSomethingById(id: String): String;
var
  Date: String;
  Subject: String;

  procedure FillMessageInfo(frxJSON: TfrxJSON);
  var
    PLD: TfrxJSON;

    procedure FillInfo(frxJSONArray: TfrxJSONArray);
    var
      i: Integer;
    begin
      for i := 0 to frxJSONArray.Count - 1 do
        with frxJSONArray.Get(i) do
        try
          if (ValueByName('name') = 'Date') then
            Date := ValueByName('value')
          else
          if (ValueByName('name') = 'Subject') then
            Subject := ValueByName('value');
        finally
          Free;
        end;
      frxJSONArray.Free;
    end;

  begin
    if not Assigned(frxJSON) then
      raise Exception.Create('Non valid JSON data');
    try
      PLD := TfrxJSON.CreateWeek(frxJSON.ObjectByName('payload'));
      try
        FillInfo(TfrxJSONArray.Create(PLD.ObjectByName('headers')));
      finally
        PLD.Free;
      end;
    finally
      frxJSON.Free;
    end;
  end;

begin
  FillMessageInfo(TfrxJSON.Create(GetMessageInfo(id)));
  Result := FormatMailName(Subject, Date, id);
end;

function TfrxBaseGMailIOTransport.PrepareName(const Name: String): String;
begin
  Result := StringReplace(Name, ' ', '+', [rfReplaceAll]);
end;

function TfrxBaseGMailIOTransport.PrepareUploadStream(const Source: TStream;
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
  PutLn('Content-Type: ' + CT);
  PutLn('MIME-Version: 1.0');
  //PutLn('From: John Doe <test@gmail.com>');
  PutLn('To: ' + AnsiString(Address));
  PutLn('Subject: =?utf-8?b?' + frBase64Encode(UTF8Encode(Subject)) + '?=');
  //PutLn('Date: Fri, 21 Nov 1997 09:55:06 -0600');
  //PutLn('Message-ID: <1234@local.machine.example>');
  PutLn('');
  PutLn('--' + GMailBoundary);
  PutLn('Content-Type: text/plain; charset="utf-8"');
  PutLn('MIME-Version: 1.0');
  PutLn('Content-Transfer-Encoding: 7bit');
  PutLn('');
  PutLn(AnsiString(MessageText.Text));
  PutLn('--' + GMailBoundary);
  PutLn('Content-Type: text/plain');//application/json
  PutLn('MIME-Version: 1.0');
  PutLn('Content-Disposition: attachment; filename="' + AnsiString(DestFileName) + '"');
  PutLn('');

  PutLn(AnsiString(LoadStringFromStream(Source)));

  PutLn;
  Put('--' + GMailBoundary + '--');

  Result := frBase64Encode(Result);

  Result := '{"raw": "' + Result + '"}';
end;

procedure TfrxBaseGMailIOTransport.Download(const SourceFileName: String; const Source: TStream);
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

    buf := frBase64URLDecode(AnsiString(frxJSON.ValueByName('data')));
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

class function TfrxBaseGMailIOTransport.TransportDialogClass: TfrxBaseTransportDialogClass;
begin
  Result := TfrxGMailIOTransportForm;
end;

{ TfrxGMailIOTransportForm }

function TfrxGMailIOTransportForm.GetHelpLink: String;
begin
  Result := 'https://console.cloud.google.com/apis/api/gmail.googleapis.com/credentials';
end;

procedure TfrxGMailIOTransportForm.UpdateResouces;
begin
  Tag := 6522;
  ClientIDLabel.Tag := 6511;
  ClientSecLabel.Tag := 6512;
  RemoteDirLabel.Visible := False;
  RemoteDirComboBox.Visible := False;
  inherited;
end;

{ support }

function frx_GMail_ListMessages_URL(frxLabel: TfrxLabel; q: String = ''): String;
begin
  Result := frx_GMail_ListMessagesBase_URL + '?labelIds=' + frxLabel.Id + '&q=has:attachment';
  if q <> '' then
    Result := Result + ' ' + q;
end;

function frx_GMail_ListMessagesContinue_URL(frxLabel: TfrxLabel; q: String = ''; pt: String = ''): String;
begin
  Result := frx_GMail_ListMessages_URL(frxLabel, q) + '&pageToken=' + pt;
end;

function frx_GMail_ListAttachments_URL(id: String): String;
begin
  Result := frx_GMail_ListMessagesBase_URL + '/' + id;
end;

function frx_GMail_Download_URL(frxMessage: TfrxMessage; Id: String): String;
begin
  Result := frx_GMail_ListAttachments_URL(frxMessage.Id) + '/attachments/' + Id;
end;

end.
