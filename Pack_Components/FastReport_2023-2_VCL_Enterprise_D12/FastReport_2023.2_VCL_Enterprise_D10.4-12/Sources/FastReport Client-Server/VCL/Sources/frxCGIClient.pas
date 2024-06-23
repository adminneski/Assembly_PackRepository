
{******************************************}
{                                          }
{             FastReport VCL               }
{         CGI wrapper client unit          }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxCGIClient;

{$I frx.inc}

{$IFDEF DELPHI12}
{$WARNINGS OFF}
{$ENDIF}

interface

uses
{$IFDEF FPC}
 {$IFDEF Linux}
  iostream,
 {$ELSE}
  Windows,
 {$ENDIF}
  LazSocket,
{$ELSE}
  Windows, ScktComp,
{$ENDIF}
  SysUtils, Classes, frxServerUtils, frxNetUtils
{$IFDEF DELPHI6}
, Variants
{$ENDIF};

type
  TfrxCGIServerFields = class;
  TfrxCGIClientFields = class;
  TfrxClientThread = class;

  TfrxCGIClient = class(TObject)
  private
    FActive: Boolean;
    FAnswer: TStrings;
    FBreaked: Boolean;
    FClientFields: TfrxCGIClientFields;
    FErrors: TStrings;
    FHeader: TStrings;
    FHost: String;
    FPort: Integer;
    FProxyHost: String;
    FProxyPort: Integer;
    FRetryCount: Integer;
    FRetryTimeOut: Integer;
    FServerFields: TfrxCGIServerFields;
    FStream: TMemoryStream;
    FTempStream: TMemoryStream;
    FThread: TfrxClientThread;
    FTimeOut: Integer;
    F_REQUEST_METHOD: AnsiString;
    F_REMOTE_USER: AnsiString;
    F_QUERY_STRING: AnsiString;
    F_REMOTE_HOST: AnsiString;
    F_SERVER_NAME: AnsiString;
    F_SERVER_PORT: AnsiString;
    F_HTTP_REFERER: AnsiString;
    F_HTTP_USER_AGENT: AnsiString;
    F_HTTP_AUTHORIZATION: AnsiString;
    F_HTTP_COOKIE: AnsiString;
    F_DIALOG_REDIR: AnsiString;
    F_CGI_FILENAME: AnsiString;
    F_CONTENT_LENGTH: AnsiString;
    F_CONTENT: AnsiString;
    OutStream: THandleStream;
    IsHTML: Boolean;
    FPostData: AnsiString;
    function GetCurrentUserName: string;
    procedure DoConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure DoDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure DoError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure DoRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure SetActive(const Value: Boolean);
    procedure SetClientFields(const Value: TfrxCGIClientFields);
    procedure SetServerFields(const Value: TfrxCGIServerFields);
    procedure PrepareCGIStream(IStream: TStream; OStream: TStream);
    procedure ReplaceCGIReps(Sign1: String; Sign2: String; IStream: TStream; OStream: TStream);
    procedure DeleteCGIReps(Sign: String; IStream: TStream; OStream: TStream);
    procedure InsertCGIHref(Sign: AnsiString; IStream: TStream; OStream: TStream);
  public
    ParentThread: TThread;
    StreamSize: Cardinal;
    constructor Create;
    destructor Destroy; override;
    procedure Connect;
    procedure Disconnect;
    procedure Open;
    procedure Close;
    property Answer: TStrings read FAnswer write FAnswer;
    property Breaked: Boolean read FBreaked;
    property Errors: TStrings read FErrors write Ferrors;
    property Header: TStrings read FHeader write FHeader;
    property Stream: TMemoryStream read FStream write FStream;
    property ClientFields: TfrxCGIClientFields read FClientFields write SetClientFields;
    property ServerFields: TfrxCGIServerFields read FServerFields write SetServerFields;

    property Active: Boolean read FActive write SetActive;
    property Host: String read FHost write FHost;
    property Port: Integer read FPort write FPort;
    property ProxyHost: String read FProxyHost write FProxyHost;
    property ProxyPort: Integer read FProxyPort write FProxyPort;
    property RetryCount: Integer read FRetryCount write FRetryCount;
    property RetryTimeOut: Integer read FRetryTimeOut write FRetryTimeOut;
    property TimeOut: Integer read FTimeOut write FTimeOut;
    property PostData: AnsiString read FPostData write FPostData;
  end;

  TfrxCGIServerFields = class (TPersistent)
  private
    FAnswerCode: Integer;
    FContentEncoding: String;
    FContentLength: Integer;
    FLocation: String;
    FSessionId: String;
    FContentDisposition: String;
    FDialogRedirect: String;
    FExportRedirect: String;
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;

    property AnswerCode: Integer read FAnswerCode write FAnswerCode;
    property ContentEncoding: String read FContentEncoding write FContentEncoding;
    property ContentLength: Integer read FContentLength write FContentLength;
    property ContentDisposition: String read FContentDisposition write FContentDisposition;
    property Location: String read FLocation write FLocation;
    property DialogRedirect: String read FDialogRedirect write FDialogRedirect;
    property ExportRedirect: String read FExportRedirect write FExportRedirect;
    property SessionId: String read FSessionId write FSessionId;
  end;

  TfrxCGIClientFields = class (TPersistent)
  private
    FAcceptEncoding: String;
    FHost: String;
    FHTTPVer: String;
    FLogin: String;
    FName: String;
    FPassword: String;
    FQueryType: TfrxHTTPQueryType;
    FReferer: String;
    FUserAgent: String;
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;

    property AcceptEncoding: String read FAcceptEncoding write FAcceptEncoding;
    property FileName: String read FName write FName;
    property Host: String read FHost write FHost;
    property HTTPVer: String read FHTTPVer write FHTTPVer;
    property Login: String read FLogin write FLogin;
    property Password: String read FPassword write FPassword;
    property QueryType: TfrxHTTPQueryType read FQueryType write FQueryType;
    property Referer: String read FReferer write FReferer;
    property UserAgent: String read FUserAgent write FUserAgent;
  end;

  TfrxClientThread = class (TThread)
  protected
    FClient: TfrxCGIClient;
    procedure DoOpen;
    procedure Execute; override;
  public
    FSocket: TClientSocket;
    constructor Create(Client: TfrxCGIClient);
    destructor Destroy; override;
  end;

implementation

uses frxFileUtils;

type
  THackThread = class(TThread);

{ TfrxCGIServerFields }

constructor TfrxCGIServerFields.Create;
begin
  FAnswerCode := 0;
  FLocation := '';
  FContentEncoding := '';
  FContentLength := 0;
end;

procedure TfrxCGIServerFields.Assign(Source: TPersistent);
begin
  if Source is TfrxCGIServerFields then
  begin
    FAnswerCode := TfrxCGIServerFields(Source).AnswerCode;
    FLocation := TfrxCGIServerFields(Source).Location;
    FContentEncoding := TfrxCGIServerFields(Source).ContentEncoding;
    FContentLength := TfrxCGIServerFields(Source).ContentLength;
    FContentDisposition := TfrxCGIServerFields(Source).ContentDisposition;
    FDialogRedirect := TfrxCGIServerFields(Source).DialogRedirect;
    FExportRedirect := TfrxCGIServerFields(Source).ExportRedirect;
  end;
end;

{ TfrxCGIClientFields }

constructor TfrxCGIClientFields.Create;
begin
  FQueryType := qtGet;
  FHTTPVer := 'HTTP/1.1';
  FName := '';
  FUserAgent := 'FastReportCGI/4.0';
  FHost := '';
  FAcceptEncoding := '';
  FLogin := '';
  FPassword := '';
  FReferer := '';
end;

procedure TfrxCGIClientFields.Assign(Source: TPersistent);
begin
  if Source is TfrxCGIClientFields then
  begin
    FQueryType := TfrxCGIClientFields(Source).QueryType;
    FName := TfrxCGIClientFields(Source).FileName;
    FHTTPVer := TfrxCGIClientFields(Source).HTTPVer;
    FUserAgent := TfrxCGIClientFields(Source).UserAgent;
    FHost := TfrxCGIClientFields(Source).Host;
    FAcceptEncoding := TfrxCGIClientFields(Source).AcceptEncoding;
    FLogin := TfrxCGIClientFields(Source).Login;
    FPassword := TfrxCGIClientFields(Source).Password;
    FReferer := TfrxCGIClientFields(Source).Referer;
  end;
end;

{ TfrxCGIClient }

constructor TfrxCGIClient.Create;
begin
  FHeader := TStringList.Create;
  FAnswer := TStringList.Create;
  {$IFDEF FPC}
  FHeader.LineBreak := #13#10;
  FAnswer.LineBreak := #13#10;
  {$ENDIF}
  FStream := TMemoryStream.Create;
  FTempStream := TMemoryStream.Create;
  FErrors := TStringList.Create;
  FHost := '127.0.0.1';
  FPort := 8097;
  FProxyHost := '';
  FProxyPort := 8080;
  FActive := False;
  FServerFields := TfrxCGIServerFields.Create;
  FClientFields := TfrxCGIClientFields.Create;
  FRetryTimeOut := 5; //5
  FRetryCount := 3; //3
  FTimeOut := 30;    //30
  FBreaked := False;
  ParentThread := nil;
  FThread := TfrxClientThread.Create(Self);
  FThread.FSocket.OnConnect := DoConnect;
  FThread.FSocket.OnRead := DoRead;
  FThread.FSocket.OnDisconnect := DoDisconnect;
  FThread.FSocket.OnError := DoError;
end;

destructor TfrxCGIClient.Destroy;
begin
  Close;
  while FActive do
    PMessages;
  FThread.Free;
  FClientFields.Free;
  FServerFields.Free;
  FHeader.Free;
  FAnswer.Free;
  FStream.Free;
  FTempStream.Free;
  FErrors.Free;
  inherited;
end;

function TfrxCGIClient.GetCurrentUserName: string;
{$IFNDEF Linux}
var
  UserName: String;
  UserNameLen: Dword;
{$ENDIF}
begin
{$IFNDEF Linux}
  UserNameLen := 255;
  SetLength(userName, UserNameLen);
  if GetUserName(PChar(UserName), UserNameLen) then
    Result := Copy(UserName,1,UserNameLen - 1)
  else
    Result := 'Unknown';
{$ELSE}
  Result := GetEnvironmentVariable('USERNAME');
  if Result = '' then
    Result := GetEnvironmentVariable('USER');
  if Result = '' then
    Result := 'Unknown';
{$ENDIF}
end;

procedure TfrxCGIClient.Connect;
var
  ticks: Cardinal;
  i: Integer;
  s: AnsiString;
begin
  IsHTML := False;
  F_QUERY_STRING := GetEnvVar('QUERY_STRING');
  F_REMOTE_HOST := GetEnvVar('REMOTE_HOST');
  F_SERVER_NAME := GetEnvVar('SERVER_NAME');
  F_SERVER_PORT := GetEnvVar('SERVER_PORT');
  F_HTTP_REFERER := GetEnvVar('HTTP_REFERER');
  F_HTTP_USER_AGENT := GetEnvVar('HTTP_USER_AGENT');

  F_REMOTE_USER := GetEnvVar('REMOTE_USER');
  F_HTTP_AUTHORIZATION := GetEnvVar('HTTP_AUTHORIZATION');
  F_CGI_FILENAME := ExtractFileName(ParamStr(0));
  F_REQUEST_METHOD := GetEnvVar('REQUEST_METHOD');
  F_CONTENT_LENGTH := GetEnvVar('CONTENT_LENGTH');
  F_HTTP_COOKIE := GetEnvVar('HTTP_COOKIE');
  F_DIALOG_REDIR := GetEnvVar('DIALOG_REDIRECT');

  F_CONTENT := FPostData;


  ClientFields.AcceptEncoding := '';
  if Pos('report', ClientFields.FileName) > 0 then
    ClientFields.FileName := 'result?' + ClientFields.FileName;
  ClientFields.FileName := F_QUERY_STRING;
  ClientFields.Host := F_REMOTE_HOST;
  ClientFields.UserAgent := F_HTTP_USER_AGENT;
  ClientFields.Referer := F_HTTP_REFERER;

{$IFDEF Linux}
  OutStream := TIOStream.Create(iosOutPut);
{$ELSE}
  OutStream := THandleStream.Create(GetStdHandle(STD_OUTPUT_HANDLE));
{$ENDIF}
  try
    i := FRetryCount;
    FBreaked := False;
    repeat
      FErrors.Clear;
      FTempStream.Clear;
      FActive := True;
      if Length(FProxyHost) > 0 then
      begin
        FThread.FSocket.Host := FProxyHost;
        FThread.FSocket.Address := FProxyHost;
        FThread.FSocket.Port := FProxyPort;
      end else
      begin
        FThread.FSocket.Host := FHost;
        FThread.FSocket.Address := FHost;
        FThread.FSocket.Port := FPort;
      end;
      FThread.FSocket.ClientType := ctNonBlocking;
      FThread.Execute;
      try
        ticks := GetTickCount;
        while FActive and (not FBreaked) do
        begin
          PMessages;
          if (GetTickCount - ticks) > Cardinal(FTimeOut * 1000) then
          begin
            Errors.Add('Timeout expired (' + IntToStr(FTimeOut) + ')');
            break;
          end;
        end;
      finally
        Disconnect;
      end;
      if not FBreaked then
      begin
        if (Errors.Count = 0) and ((FServerFields.AnswerCode = 301) or
           (FServerFields.AnswerCode = 302) or (FServerFields.AnswerCode = 303)) then
        begin
          i := FRetryCount;
          FClientFields.FileName := FServerFields.Location;
        end
        else if (Errors.Count > 0)
            and (FServerFields.AnswerCode <> 401)
            and (FServerFields.AnswerCode <> 403)
            and (FServerFields.AnswerCode <> 404) then
        begin
          Dec(i);
          if i > 0 then
            Sleep(FRetryTimeOut * 1000)
          else
            if FRetryCount > 1 then
              Errors.Add('Retry count (' + IntToStr(FRetryCount) + ') exceed')
        end else
          i := 0;
      end;
    until (i = 0) or FBreaked;
    for i := 0 to Answer.Count - 1 do
      if (Pos(UpperCase('Content-Type'), UpperCase(Answer[i])) > 0) or
         (Pos(UpperCase('WWW-Authenticate'), UpperCase(Answer[i])) > 0) //or
      then
      begin
        s := Answer[i] + #13#10;
        OutStream.Write(s[1], Length(s));
        IsHTML := Pos('text/html', s) > 0;
      end;
    s := 'Status: ' + IntToStr(ServerFields.AnswerCode) + #13#10;
    OutStream.Write(s[1], Length(s));
    s := 'Script-Control: no-abort'#13#10;
    OutStream.Write(s[1], Length(s));

    if ServerFields.ContentDisposition <> '' then
    begin
      s := 'Content-Disposition: ' + ServerFields.ContentDisposition + #13#10;
      OutStream.Write(s[1], Length(s));
    end;

    if ServerFields.DialogRedirect <> '' then
    begin
      s := 'dialog_redirect: ' + ServerFields.DialogRedirect + #13#10;
      OutStream.Write(s[1], Length(s));
    end;

    if ServerFields.ExportRedirect <> '' then
    begin
      s := 'export_redirect: ' + ServerFields.ExportRedirect + #13#10;
      OutStream.Write(s[1], Length(s));
    end;

    if F_HTTP_REFERER <> '' then
    begin
      s := 'referer: ' + F_HTTP_REFERER + #13#10;
      OutStream.Write(s[1], Length(s));
    end;

    if Pos('sid_', ClientFields.FileName) > 0 then
    begin
      s := 'FastReport-container:frreport'#13#10;
      OutStream.Write(s[1], Length(s));
    end;

    s := #13#10;
    OutStream.Write(s[1], Length(s));
    if IsHTML then
      PrepareCGIStream(FStream, OutStream)
    else
      OutStream.CopyFrom(FStream, 0);
  finally
    OutStream.Free;
  end;
end;

procedure TfrxCGIClient.Disconnect;
begin
  FThread.FSocket.Close;
  FThread.Terminate;
  FActive := False;
end;

procedure TfrxCGIClient.DoConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  s, s1: String;
  m: TMemoryStream;
{$IFDEF DELPHI12}
  TempStr: AnsiString;
{$ENDIF}
begin
  FHeader.Clear;
//  if FClientFields.QueryType = qtGet then
//    s := 'GET'
//  else if FClientFields.QueryType = qtPost then
//    s := 'POST'
//  else
  s := F_REQUEST_METHOD;
  if Length(FProxyHost) > 0 then
    s1 := 'http://' + Host + ':' + IntToStr(FPort) + '/' + FClientFields.FileName
  else
    s1 := '/' + FClientFields.FileName;
  FHeader.Add(s + ' ' + s1 + ' ' + FClientFields.HTTPVer);
  if Length(FClientFields.Host) = 0 then
    s := Socket.LocalAddress
  else
    s := FClientFields.Host;
  FHeader.Add('Host: ' + s);
  if Length(FClientFields.UserAgent) > 0 then
    FHeader.Add('User-Agent: ' + FClientFields.UserAgent);
  if Length(FClientFields.AcceptEncoding) > 0 then
    FHeader.Add('Accept-Encoding: ' + FClientFields.AcceptEncoding);
//  if Length(FClientFields.Login) > 0 then
//    FHeader.Add('Authorization: Basic ' + Base64Encode(FClientFields.Login + ':' +
//      FClientFields.Password));
//  FHeader.Add('Connection: close');
  if (Length(F_HTTP_AUTHORIZATION) > 0) and (Pos('Basic', F_HTTP_AUTHORIZATION) > 0) then
    FHeader.Add('Authorization: ' + F_HTTP_AUTHORIZATION);
  FHeader.Add('UserName: ' + GetCurrentUserName); //GetCurrentUserName F_REMOTE_USER
  FHeader.Add('RemoteUserName: ' + F_REMOTE_USER); //GetCurrentUserName F_REMOTE_USER
  FHeader.Add('Cookie: ' + F_HTTP_COOKIE);
  if FClientFields.Referer <> '' then
    FHeader.Add('Referer: ' + FClientFields.Referer);
  if F_DIALOG_REDIR <> '' then
    FHeader.Add('dialog_redirect: ' + F_DIALOG_REDIR);
  if F_CONTENT_LENGTH <> '' then
    FHeader.Add('Content-Length: ' + F_CONTENT_LENGTH);
  FHeader.Add('');
  if (F_REQUEST_METHOD = 'POST') then
    FHeader.Add(F_CONTENT);
  try
    m := TMemoryStream.Create;
    try
{$IFDEF DELPHI12}
      TempStr := AnsiString(FHeader.Text);
      m.Write(TempStr[1], Length(TempStr));
{$ELSE}
      m.Write(FHeader.Text[1], Length(FHeader.Text));
{$ENDIF}
      if FStream.Size > 1 then
        m.Write(FStream.Memory^, FStream.Size);
      Socket.SendBuf(m.Memory^, m.Size);
    finally
      m.Free;
    end
  except
    Errors.Add('Data send error');
  end;
end;

procedure TfrxCGIClient.DoDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  i, j, Len: Integer;
  s, s1: AnsiString;
begin
  FAnswer.Clear;
  FStream.Clear;
  if FTempStream.Size > 0 then
  begin
    FTempStream.Position := 0;
    i := StreamSearch(FTempStream, 0, #13#10#13#10);
    if i <> 0 then
    begin
      Len := i + 4;
      StreamSize := FTempStream.Size - Len;
      SetLength(s, Len);
      FTempStream.Position := 0;
      FTempStream.ReadBuffer(s[1], Len);
      FAnswer.Text := s;
      i := Pos(' ', s) + 1;
      j := i;
      while (i < Length(s)) and (s[i] <> ' ') and (s[i] <> #13) do
        Inc(i);
      s1 := Copy(s, j, i - j);
      if Length(s1) > 0 then
        FServerFields.FAnswerCode := StrToInt(s1);
      s1 := ParseHeaderField('Content-Disposition: ', s);
      FServerFields.ContentDisposition := s1;
      s1 := ParseHeaderField('dialog_redirect: ', s);
      FServerFields.DialogRedirect := s1;
      s1 := ParseHeaderField('export_redirect: ', s);
      FServerFields.ExportRedirect := s1;

      s1 := ParseHeaderField('Location: ', s);
      if (Length(s1) > 0) and (s1[1] = '/') then
        Delete(s1, 1, 1);
      FServerFields.Location := s1;
      FServerFields.ContentEncoding := LowerCase(ParseHeaderField('Content-Encoding: ', s));
      s1 := ParseHeaderField('SessionId: ', s);
      if Length(s1) > 0 then
        FServerFields.SessionId := s1;
      s1 := ParseHeaderField('Content-length: ', s);
      if Length(s1) > 0 then
        FServerFields.ContentLength := StrToInt(s1);
      s1 := GetHTTPErrorText(FServerFields.AnswerCode);
      if Length(s1) > 0 then
        Errors.Add(s1);
      if Errors.Count = 0 then
      begin
        if FServerFields.ContentLength > 0 then
          if (FTempStream.Size - Len) <> FServerFields.ContentLength then
            Errors.Add('Received data size mismatch');
        if Errors.Count = 0 then
          FStream.CopyFrom(FTempStream, FTempStream.Size - Len);
      end;
    end else
      Errors.Add('Bad header');
    FTempStream.Clear;
  end
  else if Errors.Count = 0 then
    Errors.Add('Zero bytes received');
  if FStream.Size > 0 then
    FStream.Position := 0;
  FActive := False;
end;

procedure TfrxCGIClient.DoError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  Errors.Add(GetSocketErrorText(ErrorCode));
  FActive := False;
  ErrorCode := 0;
end;

procedure TfrxCGIClient.DoRead(Sender: TObject; Socket: TCustomWinSocket);
var
  buf: PAnsiChar;
  i, j: Integer;
begin
  i := Socket.ReceiveLength;
  GetMem(buf, i);
  j := i;
  try
    try
      while j > 0 do
      begin
        j := Socket.ReceiveBuf(buf^, i);
        FTempStream.Write(buf^, j);
      end;
    except
      Errors.Add('Data receive error.')
    end;
  finally
    FreeMem(buf);
  end;
end;

procedure TfrxCGIClient.SetActive(const Value: Boolean);
begin
  if Value then Connect
  else Disconnect;
end;

procedure TfrxCGIClient.Close;
begin
  FBreaked := True;
  Active := False;
end;

procedure TfrxCGIClient.Open;
begin
  Active := True;
end;

procedure TfrxCGIClient.SetServerFields(const Value: TfrxCGIServerFields);
begin
  FServerFields.Assign(Value);
end;

procedure TfrxCGIClient.SetClientFields(const Value: TfrxCGIClientFields);
begin
  FClientFields.Assign(Value);
end;

procedure TfrxCGIClient.InsertCGIHref(Sign: AnsiString; IStream: TStream; OStream: TStream);
var
  i, j: Integer;
  p, p1: Longint;
  s, s1, buf: AnsiString;
begin
  p := 0;
  p1 := 0;
  s := StringReplace(ExtractFileDir(StringReplace(ClientFields.FileName, '/', '\', [rfReplaceAll  ])), '\', '/', [rfReplaceAll  ]);
  if s <> '' then
    s := s + '/';
  s1 := F_CGI_FILENAME + '?';
  s := Sign;
  SetLength(buf, 1);
  while p <> -1 do
  begin
    p := StreamSearch(IStream, p, s);
    if p <> -1 then
    begin
      i := StreamSearch(IStream, p, 'http:');
      j := StreamSearch(IStream, p, 'mailto:');
      if (i <> (p + Length(s))) and (j <> (p + Length(s))) then
      begin
        IStream.Position := p1;
        OStream.CopyFrom(IStream, p - p1 + Length(s));
        IStream.Read(buf[1], 1);
{$IFDEF DELPHI12}
        if CharInSet(buf[1], ['"', '''']) then
{$ELSE}
        if buf[1] in ['"', ''''] then
{$ENDIF}
        begin
          OStream.Write(buf[1], 1);
          p := p + 1;
        end;
        OStream.Write(s1[1], Length(s1));
        p1 := p + Length(s);
        p := p + Length(s1);
      end;
      p := p + Length(s);
    end;
  end;
  IStream.Position := p1;
  OStream.CopyFrom(IStream, IStream.Size - p1);
end;

procedure TfrxCGIClient.DeleteCGIReps(Sign: String; IStream: TStream; OStream: TStream);
var
  p, p1: Longint;
  s: String;
begin
  p := 0;
  p1 := 0;
  s := Sign;
  while p <> -1 do
  begin
    p := StreamSearch(IStream, p, s);
    if p <> -1 then
    begin
      IStream.Position := p1;
      OStream.CopyFrom(IStream, p - p1);
      p := p + Length(s);
      p1 := p;
    end;
  end;
  IStream.Position := p1;
  OStream.CopyFrom(IStream, IStream.Size - p1);
end;

procedure TfrxCGIClient.ReplaceCGIReps(Sign1: String; Sign2: String; IStream: TStream; OStream: TStream);
var
  p, p1: Longint;
  s: AnsiString;
begin
  p := 0;
  p1 := 0;
  s := Sign1;
  while p <> -1 do
  begin
    p := StreamSearch(IStream, p, s);
    if p <> -1 then
    begin
      IStream.Position := p1;
      OStream.CopyFrom(IStream, p - p1);
      OStream.Write(Sign2[1], Length(Sign2));
      p := p + Length(s);
      p1 := p;
    end;
  end;
  IStream.Position := p1;
  OStream.CopyFrom(IStream, IStream.Size - p1);
end;

procedure TfrxCGIClient.PrepareCGIStream(IStream: TStream; OStream: TStream);
var
  TempStream: TMemoryStream;
  TempStream1: TMemoryStream;
begin
  TempStream := TMemoryStream.Create;
  TempStream1 := TMemoryStream.Create;
  try
    TempStream.Clear;
    InsertCGIHref(' href=', IStream, TempStream);
    TempStream1.Clear;
    InsertCGIHref(' src=', TempStream, TempStream1);
    TempStream.Clear;
    InsertCGIHref('frPrefix="', TempStream1, TempStream);
    TempStream1.Clear;
    InsertCGIHref('parent.location = "', TempStream, TempStream1);
    TempStream.Clear;
    DeleteCGIReps('result?', TempStream1, TempStream);
    TempStream1.Clear;
    ReplaceCGIReps('action="result"', 'action="' + F_CGI_FILENAME + '"', TempStream, TempStream1);
    TempStream.Clear;
    InsertCGIHref('this.src=', TempStream1, TempStream);
    TempStream1.Clear;
    InsertCGIHref(' action="', TempStream, TempStream1);
    TempStream.Clear;
    InsertCGIHref('location="', TempStream1, TempStream);
    OStream.CopyFrom(TempStream, 0);
  finally
    TempStream.Free;
    TempStream1.Free;
  end;
end;

{ TfrxClientThread }

constructor TfrxClientThread.Create(Client: TfrxCGIClient);
begin
  inherited Create(True);
  FClient := Client;
  FreeOnTerminate := False;
  FSocket := TClientSocket.Create(nil);
end;

destructor TfrxClientThread.Destroy;
begin
  FSocket.Free;
  inherited;
end;

procedure TfrxClientThread.DoOpen;
begin
  FSocket.Open;
end;

procedure TfrxClientThread.Execute;
begin
  Synchronize(DoOpen);
end;

end.
