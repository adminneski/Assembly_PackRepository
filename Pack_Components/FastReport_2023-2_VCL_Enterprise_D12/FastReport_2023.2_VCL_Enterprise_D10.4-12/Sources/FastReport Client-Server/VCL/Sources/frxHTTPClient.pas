
{******************************************}
{                                          }
{             FastReport VCL               }
{        HTTP connection client unit       }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxHTTPClient;

{$I frx.inc}

interface

uses
{$IFDEF FPC}
 {$IFNDEF Linux}
  Windows,
 {$ENDIF}
  LazSocket,
{$ELSE}
  Windows, ScktComp,
{$ENDIF}
  SysUtils, Classes, frxServerUtils, frxNetUtils, frGZip,
{$IFDEF DELPHI6}
  Variants,
{$ENDIF}
  frHashUtils;

type
  TfrxHTTPServerFields = class;
  TfrxHTTPClientFields = class;
  TfrxClientThread = class;

{$IFDEF DELPHI16}
[ComponentPlatformsAttribute(pidWin32 or pidWin64)]
{$ENDIF}
  TfrxHTTPClient = class(TComponent)
  private
    FActive: Boolean;
    FAnswer: TStrings;
    FBreaked: Boolean;
    FClientFields: TfrxHTTPClientFields;
    FErrors: TStrings;
    FHeader: TStrings;
    FHost: String;
    FMIC: Boolean;
    FPort: Integer;
    FProxyHost: String;
    FProxyPort: Integer;
    FRetryCount: Integer;
    FRetryTimeOut: Integer;
    FServerFields: TfrxHTTPServerFields;
    FStream: TMemoryStream;
    FTempStream: TMemoryStream;
    FThread: TfrxClientThread;
    FTimeOut: Integer;
    FProxyLogin: String;
    FProxyPassword: String;
    FConnectDelay: Cardinal;
    FAnswerDelay: Cardinal;
    procedure DoConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure DoDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure DoError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure DoRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure SetActive(const Value: Boolean);
    procedure SetClientFields(const Value: TfrxHTTPClientFields);
    procedure SetServerFields(const Value: TfrxHTTPServerFields);
  public
    ParentThread: TThread;
    StreamSize: Cardinal;
    constructor Create(AOwner: TComponent); override;
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
  published
    property Active: Boolean read FActive write SetActive;
    property ClientFields: TfrxHTTPClientFields read FClientFields write SetClientFields;
    property Host: String read FHost write FHost;
    property MIC: Boolean read FMIC write FMIC;
    property Port: Integer read FPort write FPort;
    property ProxyHost: String read FProxyHost write FProxyHost;
    property ProxyPort: Integer read FProxyPort write FProxyPort;
    property ProxyLogin: String  read FProxyLogin write FProxyLogin;
    property ProxyPassword: String read FProxyPassword write FProxyPassword;
    property RetryCount: Integer read FRetryCount write FRetryCount;
    property RetryTimeOut: Integer read FRetryTimeOut write FRetryTimeOut;
    property ServerFields: TfrxHTTPServerFields read FServerFields write SetServerFields;
    property TimeOut: Integer read FTimeOut write FTimeOut;
    property ConnectDelay: Cardinal read FConnectDelay;
    property AnswerDelay: Cardinal read FAnswerDelay;
  end;

  TfrxHTTPServerFields = class (TPersistent)
  private
    FAnswerCode: Integer;
    FContentEncoding: String;
    FContentMD5: String;
    FContentLength: Integer;
    FLocation: String;
    FSessionId: String;
    FCookie: String;
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
  published
    property AnswerCode: Integer read FAnswerCode write FAnswerCode;
    property ContentEncoding: String read FContentEncoding write FContentEncoding;
    property ContentMD5: String read FContentMD5 write FContentMD5;
    property ContentLength: Integer read FContentLength write FContentLength;
    property Location: String read FLocation write FLocation;
    property SessionId: String read FSessionId write FSessionId;
    property Cookie: String read FCookie write FCookie;
  end;

  TfrxHTTPClientFields = class (TPersistent)
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
    FVariables: String;
    FAccept: String;
    FAcceptCharset: String;
    FContentType: String;
    FRange: String;
  public
    constructor Create;
    procedure Assign(Source: TPersistent); override;
  published
    property AcceptEncoding: String read FAcceptEncoding write FAcceptEncoding;
    property Accept: String read FAccept write FAccept;
    property AcceptCharset: String read FAcceptCharset write FAcceptCharset;
    property FileName: String read FName write FName;
    property Host: String read FHost write FHost;
    property HTTPVer: String read FHTTPVer write FHTTPVer;
    property Login: String read FLogin write FLogin;
    property Password: String read FPassword write FPassword;
    property QueryType: TfrxHTTPQueryType read FQueryType write FQueryType;
    property Referer: String read FReferer write FReferer;
    property UserAgent: String read FUserAgent write FUserAgent;
    property Variables: String read FVariables write FVariables;
    property ContentType: String read FContentType write FContentType;
    property Range: String read FRange write FRange;
  end;

  TfrxClientThread = class (TThread)
  protected
    FClient: TfrxHTTPClient;
    procedure DoOpen;
    procedure Execute; override;
  public
    FSocket: TClientSocket;
    constructor Create(Client: TfrxHTTPClient);
    destructor Destroy; override;
  end;

implementation

uses frxFileUtils;

type
  THackThread = class(TThread);

{ TfrxHTTPServerFields }

constructor TfrxHTTPServerFields.Create;
begin
  FAnswerCode := 0;
  FLocation := '';
  FContentEncoding := '';
  FContentMD5 := '';
  FContentLength := 0;
end;

procedure TfrxHTTPServerFields.Assign(Source: TPersistent);
begin
  if Source is TfrxHTTPServerFields then
  begin
    FAnswerCode := TfrxHTTPServerFields(Source).AnswerCode;
    FLocation := TfrxHTTPServerFields(Source).Location;
    FContentEncoding := TfrxHTTPServerFields(Source).ContentEncoding;
    FContentMD5 := TfrxHTTPServerFields(Source).ContentMD5;
    FContentLength := TfrxHTTPServerFields(Source).ContentLength;
  end;
end;

{ TfrxHTTPClientFields }

constructor TfrxHTTPClientFields.Create;
begin
  FQueryType := qtGet;
  FHTTPVer := 'HTTP/1.1';
  FName := '';
  FUserAgent := 'FastReport/4.0';
  FHost := '';
  FAcceptEncoding := 'gzip';
  FLogin := '';
  FPassword := '';
  FReferer := '';
end;

procedure TfrxHTTPClientFields.Assign(Source: TPersistent);
begin
  if Source is TfrxHTTPClientFields then
  begin
    FQueryType := TfrxHTTPClientFields(Source).QueryType;
    FName := TfrxHTTPClientFields(Source).FileName;
    FHTTPVer := TfrxHTTPClientFields(Source).HTTPVer;
    FUserAgent := TfrxHTTPClientFields(Source).UserAgent;
    FHost := TfrxHTTPClientFields(Source).Host;
    FAcceptEncoding := TfrxHTTPClientFields(Source).AcceptEncoding;
    FLogin := TfrxHTTPClientFields(Source).Login;
    FPassword := TfrxHTTPClientFields(Source).Password;
    FReferer := TfrxHTTPClientFields(Source).Referer;
  end;
end;

{ TfrxHTTPClient }

constructor TfrxHTTPClient.Create(AOwner: TComponent);
begin
  inherited;
  FConnectDelay := 0;
  FAnswerDelay := 0;
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
  FPort := 80;
  FProxyHost := '';
  FProxyPort := 8080;
  FActive := False;
  FServerFields := TfrxHTTPServerFields.Create;
  FClientFields := TfrxHTTPClientFields.Create;
  FRetryTimeOut := 5;
  FRetryCount := 3;
  FTimeOut := 30;
  FBreaked := False;
  FMIC := True;
  ParentThread := nil;
  FThread := TfrxClientThread.Create(Self);
  FThread.FSocket.OnConnect := DoConnect;
  FThread.FSocket.OnRead := DoRead;
  FThread.FSocket.OnDisconnect := DoDisconnect;
  FThread.FSocket.OnError := DoError;
end;

destructor TfrxHTTPClient.Destroy;
begin
  Close;
  PMessages;
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

procedure TfrxHTTPClient.Connect;
var
  ticks: Cardinal;
  i: Integer;
begin
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
    FConnectDelay := GetTickCount;
    FAnswerDelay := GetTickCount;
    FThread.Execute;
    try
      ticks := GetTickCount;
      while (FActive and (not FBreaked)) or FThread.FSocket.Socket.Connected do
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
          and (FServerFields.AnswerCode <> 500)
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
end;

procedure TfrxHTTPClient.Disconnect;
begin
//  Close;
  FThread.FSocket.Close;
//  FThread.Terminate;
//  if not FThread.Terminated then
//    FThread.WaitFor;
  FActive := False;
end;

procedure TfrxHTTPClient.DoConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  s, s1, s2: AnsiString;
  m: TMemoryStream;
{$IFDEF DELPHI12}
  TempStr: AnsiString;
{$ENDIF}
begin
  FConnectDelay := GetTickCount - FConnectDelay;
  FHeader.Clear;
  if FClientFields.QueryType = qtGet then
    s := 'GET'
  else if FClientFields.QueryType = qtPost then
    s := 'POST'
  else if FClientFields.QueryType = qtHead then
    s := 'HEAD'
  else
    s := '';
  if Length(FProxyHost) > 0 then
    s1 := AnsiString('http://' + Host + ':' + IntToStr(FPort) + '/' + FClientFields.FileName)
  else
  begin
    if ((Length(FClientFields.FileName) > 0) and (FClientFields.FileName[1] = '/')) or (Pos('http://', FClientFields.FileName) = 1) then
      s1 := AnsiString(FClientFields.FileName)
    else
      s1 := AnsiString('/' + FClientFields.FileName);
  end;
  s2 := AnsiString(FClientFields.Variables);
  if (FClientFields.QueryType = qtGet) and (s2 <> '') then
    s1 := s1 + '?' + s2;
  FHeader.Add(String(s + ' ' + s1) + ' ' + FClientFields.HTTPVer);
  if Length(FClientFields.Host) = 0 then
    s := AnsiString(Socket.LocalAddress)
  else
    s := AnsiString(FClientFields.Host);
  FHeader.Add('Host: ' + Host);
  if Length(FClientFields.UserAgent) > 0 then
    FHeader.Add('User-Agent: ' + FClientFields.UserAgent);
  if FClientFields.Accept <> '' then
    FHeader.Add('Accept: ' + FClientFields.Accept);
  if Length(FClientFields.AcceptEncoding) > 0 then
    FHeader.Add('Accept-Encoding: ' + FClientFields.AcceptEncoding);
  if FClientFields.AcceptCharset <> '' then
    FHeader.Add('Accept-Charset: ' + FClientFields.AcceptCharset);
  if (FProxyHost <> '') and (FProxyLogin <> '') then
    FHeader.Add('Proxy-Authorization: Basic ' + String(frBase64Encode(AnsiString(FProxyLogin + ':' +
      FproxyPassword))));
  if Length(FClientFields.Login) > 0 then
    FHeader.Add('Authorization: Basic ' + String(frBase64Encode(AnsiString(FClientFields.Login + ':' +
      FClientFields.Password))));
  FHeader.Add('Connection: close');
  if FClientFields.Referer <> '' then
    FHeader.Add('Referer: ' + FClientFields.Referer);
  if FClientFields.ContentType <> '' then
    FHeader.Add('Content-Type: ' + FClientFields.ContentType);
  if FServerFields.Cookie <> '' then
    FHeader.Add('Cookie: ' + FServerFields.Cookie);
  if FClientFields.Range <> '' then
    FHeader.Add('Range: ' + FClientFields.Range);
  if (FClientFields.QueryType = qtPost) and (s2 <> '') then
  begin
    FStream.Write(s2[1], Length(s2));
    FStream.Position := 0;
  end;
  if FStream.Size > 0 then
    FHeader.Add('Content-Length: ' + IntToStr(FStream.Size));
  FHeader.Add('');
  try
    m := TMemoryStream.Create;
    try
{$IFDEF DELPHI12}
      TempStr := AnsiString(FHeader.Text) ;
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

procedure TfrxHTTPClient.DoDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
  i, j, Len: Integer;
  s, s1, s2, TempName: AnsiString;
  MICStream: TMemoryStream;

  function IsDigit(const c: AnsiChar): Boolean;
  begin
{$IFDEF DELPHI12}
    Result := CharInSet(c, ['0'..'9']);
{$ELSE}
    Result := c in ['0'..'9'];
{$ENDIF}
  end;

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
      FAnswer.Text := String(s);

      i := Pos(AnsiString(#13#10), s);
      s1 := Copy(s, 1, i - 1);
      j := 0;
      s2 := '';
      for i := 1 to Length(s1) do
      begin
        if IsDigit(s1[i]) then
        begin
          s2 := s2 + s1[i];
          Inc(j);
        end else
        if j = 3 then
          break
        else
        begin
          j := 0;
          s2 := '';
        end;
      end;
      s1 := s2;

      if Length(s1) = 3 then
        FServerFields.FAnswerCode := StrToInt(String(s1));
      s1 := ParseHeaderField('Location: ', s);
      i := Pos(AnsiString('?'), s1);
      if i > 0 then
      begin
        TempName := Copy(s1, 1, i - 1);
        s2 := Copy(s1, i + 1, Length(s1) - i);
        if TempName = 'dialog_redirect' then
        begin
          i := Pos(AnsiString('='), s2);
          if i > 0 then
          begin
            TempName := Copy(s2, 1, i - 1);
            s2 := Copy(s2, i + 1, Length(s2) - i);
            if s2 <> '' then
            begin
              s1 := s2;
              //i := 0;
            end;
          end;
        end;
      end;


      if (Length(s1) > 0) and (s1[1] = '/') then
        Delete(s1, 1, 1);
      FServerFields.Location := String(s1);
      FServerFields.ContentEncoding := LowerCase(String(ParseHeaderField('Content-Encoding: ', s)));
      FServerFields.ContentMD5 := String(ParseHeaderField('Content-MD5: ', s));

      FServerFields.Cookie := UpdateCookies(String(s), FServerFields.Cookie);

      s1 := ParseHeaderField('SessionId: ', s);
      if Length(s1) > 0 then
        FServerFields.SessionId := String(s1);
      s1 := ParseHeaderField('Content-length: ', s);
      if Length(s1) > 0 then
        FServerFields.ContentLength := StrToInt(String(s1));
      s1 := AnsiString(GetHTTPErrorText(FServerFields.AnswerCode));
      if Length(s1) > 0 then
        Errors.Add(String(s1));
      if Errors.Count = 0 then
      begin
        if FServerFields.ContentLength > 0 then
          if ((FTempStream.Size - Len) <> FServerFields.ContentLength) and ((FServerFields.FAnswerCode = 200) or (FServerFields.FAnswerCode = 206)) then
            Errors.Add('Received data size mismatch');
        if (Length(FServerFields.ContentMD5) > 0) and FMIC and (Errors.Count = 0) then
        begin
          MICStream := TMemoryStream.Create;
          try
            MICStream.CopyFrom(FTempStream, FTempStream.Size - Len);
            if frMD5Stream(MICStream) <> AnsiString(FServerFields.ContentMD5) then
              Errors.Add('Message integrity checksum (MIC) error');
          finally
            FTempStream.Position := Len;
            MICStream.Free;
          end;
        end;
        if Errors.Count = 0 then
          if Pos('gzip', FServerFields.ContentEncoding) > 0 then
          try
            frDecompressStream(FTempStream, FStream)
          except
            Errors.Add('Unpack data error')
          end
          else
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

procedure TfrxHTTPClient.DoError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  Errors.Add(GetSocketErrorText(ErrorCode));
  FActive := False;
  ErrorCode := 0;
end;

procedure TfrxHTTPClient.DoRead(Sender: TObject; Socket: TCustomWinSocket);
var
  buf: PAnsiChar;
  i, j: Integer;
begin
  FAnswerDelay := GetTickCount - FAnswerDelay;
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

procedure TfrxHTTPClient.SetActive(const Value: Boolean);
begin
  if Value then Connect
  else Disconnect;
end;

procedure TfrxHTTPClient.Close;
begin
  FBreaked := True;
  Active := False;
end;

procedure TfrxHTTPClient.Open;
begin
  Active := True;
end;

procedure TfrxHTTPClient.SetServerFields(const Value: TfrxHTTPServerFields);
begin
  FServerFields.Assign(Value);
end;

procedure TfrxHTTPClient.SetClientFields(const Value: TfrxHTTPClientFields);
begin
  FClientFields.Assign(Value);
end;

{ TfrxClientThread }

constructor TfrxClientThread.Create(Client: TfrxHTTPClient);
begin
  inherited Create(True);
  FClient := Client;
  FreeOnTerminate := False;
  FSocket := TClientSocket.Create(nil);
end;

destructor TfrxClientThread.Destroy;
begin
  FSocket.Close;
  FSocket.Free;
  inherited;
end;

procedure TfrxClientThread.DoOpen;
begin
//
end;

procedure TfrxClientThread.Execute;
begin
  FSocket.Open;
//  DoOpen;
end;

end.
