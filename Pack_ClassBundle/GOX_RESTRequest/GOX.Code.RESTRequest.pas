unit GOX.Code.RESTRequest;
{Fonte: post}
interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  Data.DB,
  System.Net.Mime,
  System.Net.HttpClientComponent,
  System.Net.HttpClient,
  System.NetEncoding,
  System.Net.URLClient,
  REST.Json,
  IdURI;

type
  TMethodRequest = (mrGET, mrPOST, mrPUT, mrPATCH, mrDELETE);

  IGOXResponse = interface
  ['{D32A146F-587F-40DC-9939-DAE19A29BF53}']
    function Content: string;
    function ContentLength: Cardinal;
    function ContentType: string;
    function ContentEncoding: string;
    function ContentStream: TStream;
    function StatusCode: Integer;
    function StatusText: string;
    function RawBytes: TBytes;
    function Headers: TStrings;
    function JSONValue: TJSONValue;
  end;

  TGOXResponse = class(TInterfacedObject, IGOXResponse)
  private
    FJSONValue: TJSONValue;
    FHTTPResponse: IHTTPResponse;
    FContent: TStringStream;
    function Content: string;
    function ContentLength: Cardinal;
    function ContentType: string;
    function ContentEncoding: string;
    function ContentStream: TStream;
    function StatusCode: Integer;
    function StatusText: string;
    function RawBytes: TBytes;
    function JSONValue: TJSONValue;
    function Headers: TStrings;
  public
    procedure SetContent(const AContent: TStringStream);
    procedure SetHTTPResponse(const AHTTPResponse: IHTTPResponse);
    destructor Destroy; override;
  end;
  //
  //Interface Resquest
  IGOXRequest = interface
  ['{E5825174-84DB-47F5-8E37-FA9E86EF2312}']
    function AcceptEncoding: string; overload;
    function AcceptEncoding(const AAcceptEncoding: string): IGOXRequest; overload;
    function AcceptCharset: string; overload;
    function AcceptCharset(const AAcceptCharset: string): IGOXRequest; overload;
    function Accept: string; overload;
    function Accept(const AAccept: string): IGOXRequest; overload;
    function Timeout: Integer; overload;
    function Timeout(const ATimeout: Integer): IGOXRequest; overload;
    function BaseURL(const ABaseURL: string): IGOXRequest; overload;
    function BaseURL: string; overload;
    function Resource(const AResource: string): IGOXRequest; overload;
    function Resource: string; overload;
    function ResourceSuffix(const AResourceSuffix: string): IGOXRequest; overload;
    function ResourceSuffix: string; overload;
    function Token(const AToken: string): IGOXRequest;
    function TokenBearer(const AToken: string): IGOXRequest;
    function BasicAuthentication(const AUsername, APassword: string): IGOXRequest;
    function Retry(const ARetries: Integer): IGOXRequest;
    function Get: IGOXResponse;
    function Post: IGOXResponse;
    function Put: IGOXResponse;
    function Delete: IGOXResponse;
    function Patch: IGOXResponse;
    function FullRequestURL(const AIncludeParams: Boolean = True): string;
    function Asynchronous(const AValue: Boolean): IGOXRequest;
    function AddHeader(const AName, AValue: string): IGOXRequest;
    function AddParam(const AName, AValue: string): IGOXRequest;
    function AddBody(const AContent: string): IGOXRequest; overload;
    function AddBody(const AContent: TJSONObject; const AOwns: Boolean = True): IGOXRequest; overload;
    function AddBody(const AContent: TJSONArray; const AOwns: Boolean = True): IGOXRequest; overload;
    function AddBody(const AContent: TObject; const AOwns: Boolean = True): IGOXRequest; overload;
    function AddBody(const AContent: TStream; const AOwns: Boolean = True): IGOXRequest; overload;
    function AddUrlSegment(const AName, AValue: string): IGOXRequest;
    function ClearHeaders: IGOXRequest;
    function ClearParams: IGOXRequest;
    function ClearBody: IGOXRequest;
    function UserAgent(const AName: string): IGOXRequest;
    function ContentType(const AContentType: string): IGOXRequest;
    function AddCookies(const ACookies: TStrings): IGOXRequest;
    function AddCookie(const ACookieName, ACookieValue: string): IGOXRequest;
    function AddField(const AFieldName: string; const AValue: string): IGOXRequest; overload;
    function AddFile(const AFieldName: string; const AFileName: string; const AContentType: string = ''): IGOXRequest; overload;
    function AddFile(const AFieldName: string; const AValue: TStream; const AFileName: string = ''; const AContentType: string = ''): IGOXRequest; overload;
    function Proxy(const AServer, APassword, AUsername: string; const APort: Integer): IGOXRequest;
    function DeactivateProxy: IGOXRequest;
  end;
  //
  //Concrete Class Request
  TGOXRequest = class(TInterfacedObject, IGOXRequest)
  private
    FUseMultipartFormData: Boolean;
    FMultipartFormData: TMultipartFormData;
    FParams: TStrings;
    FUrlSegments: TStrings;
    FNetHTTPClient: TNetHTTPClient;
    FBaseURL: string;
    FResource: string;
    FResourceSuffix: string;
    FDataSetAdapter: TDataSet;
    FResponse: IGOXResponse;
    FStreamSend: TStream;
    FStreamResult: TStringStream;
    FRetries: Integer;
    function ExecuteRequest(const AMethod: TMethodRequest): IHTTPResponse;
    function AcceptEncoding: string; overload;
    function AcceptEncoding(const AAcceptEncoding: string): IGOXRequest; overload;
    function AcceptCharset: string; overload;
    function AcceptCharset(const AAcceptCharset: string): IGOXRequest; overload;
    function Accept: string; overload;
    function Accept(const AAccept: string): IGOXRequest; overload;
    function Timeout: Integer; overload;
    function Timeout(const ATimeout: Integer): IGOXRequest; overload;
    function BaseURL(const ABaseURL: string): IGOXRequest; overload;
    function BaseURL: string; overload;
    function Resource(const AResource: string): IGOXRequest; overload;
    function Resource: string; overload;
    function ResourceSuffix(const AResourceSuffix: string): IGOXRequest; overload;
    function ResourceSuffix: string; overload;
    function Token(const AToken: string): IGOXRequest;
    function TokenBearer(const AToken: string): IGOXRequest;
    function BasicAuthentication(const AUsername, APassword: string): IGOXRequest;
    function Retry(const ARetries: Integer): IGOXRequest;
    function Get: IGOXResponse;
    function Post: IGOXResponse;
    function Put: IGOXResponse;
    function Delete: IGOXResponse;
    function Patch: IGOXResponse;
    function FullRequestURL(const AIncludeParams: Boolean = True): string;
    function AddHeader(const AName, AValue: string): IGOXRequest;
    function AddParam(const AName, AValue: string): IGOXRequest;
    function AddBody(const AContent: string): IGOXRequest; overload;
    function AddBody(const AContent: TJSONObject; const AOwns: Boolean = True): IGOXRequest; overload;
    function AddBody(const AContent: TJSONArray; const AOwns: Boolean = True): IGOXRequest; overload;
    function AddBody(const AContent: TObject; const AOwns: Boolean = True): IGOXRequest; overload;
    function AddBody(const AContent: TStream; const AOwns: Boolean = True): IGOXRequest; overload;
    function AddUrlSegment(const AName, AValue: string): IGOXRequest;
    function ClearHeaders: IGOXRequest;
    function ClearParams: IGOXRequest;
    function ClearBody: IGOXRequest;
    function ContentType(const AContentType: string): IGOXRequest;
    function UserAgent(const AName: string): IGOXRequest;
    function AddCookies(const ACookies: TStrings): IGOXRequest;
    function AddCookie(const ACookieName, ACookieValue: string): IGOXRequest;
    function AddField(const AFieldName: string; const AValue: string): IGOXRequest; overload;
    function AddFile(const AFieldName: string; const AFileName: string; const AContentType: string = ''): IGOXRequest; overload;
    function AddFile(const AFieldName: string; const AValue: TStream; const AFileName: string = ''; const AContentType: string = ''): IGOXRequest; overload;
    function Asynchronous(const AValue: Boolean): IGOXRequest;
    function MakeURL(const AIncludeParams: Boolean = True): string;
    function Proxy(const AServer, APassword, AUsername: string; const APort: Integer): IGOXRequest;
    function DeactivateProxy: IGOXRequest;
  protected
    procedure DoAfterExecute(const Sender: TObject; const AResponse: IHTTPResponse); virtual;
    procedure DoBeforeExecute(const Sender: TNetHTTPClient); virtual;
    procedure DoHTTPProtocolError(const Sender: TObject; const AError: string); virtual;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: IGOXRequest;
  end;

implementation

{TGOXResponse}
function TGOXResponse.JSONValue: TJSONValue;
var
  LContent: string;
begin
  if not(Assigned(FJSONValue)) then
  begin
    if Assigned(FHTTPResponse) then
      LContent := FHTTPResponse.ContentAsString.Trim;
    if LContent.StartsWith('{') then
      FJSONValue := (TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(LContent), 0) as TJSONObject)
    else if LContent.StartsWith('[') then
      FJSONValue := (TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(LContent), 0) as TJSONArray)
    else
      raise Exception.Create('The return content is not a valid JSON value.');
  end;
  Result := FJSONValue;
end;
function TGOXResponse.Content: string;
begin
  if Assigned(FHTTPResponse) then
    Result := FHTTPResponse.ContentAsString;
end;
function TGOXResponse.ContentEncoding: string;
begin
  if Assigned(FHTTPResponse) then
    Result := FHTTPResponse.ContentEncoding;
end;
function TGOXResponse.ContentLength: Cardinal;
begin
  Result := 0;
  if Assigned(FHTTPResponse) then
    Result := FHTTPResponse.ContentLength
end;
function TGOXResponse.ContentStream: TStream;
begin
  Result := nil;
  if Assigned(FHTTPResponse) then
  begin
    Result := FHTTPResponse.ContentStream;
    Result.Position := 0;
  end;
end;
function TGOXResponse.ContentType: string;
begin
  if Assigned(FHTTPResponse) and FHTTPResponse.ContainsHeader('Content-Type') then
    Result := FHTTPResponse.HeaderValue['Content-Type'];
end;
destructor TGOXResponse.Destroy;
begin
  FHTTPResponse := nil;
  if Assigned(FJSONValue) then
    FJSONValue.Free;
  inherited;
end;
function TGOXResponse.Headers: TStrings;
var
  LHeader: TNameValuePair;
begin
  Result := TStringList.Create;
  if Assigned(FHTTPResponse) then
    for LHeader in FHTTPResponse.Headers do
      Result.Add(LHeader.Name + '=' + LHeader.Value);
end;
function TGOXResponse.RawBytes: TBytes;
begin
  if Assigned(FContent) then
    Result := FContent.Bytes;
end;
procedure TGOXResponse.SetContent(const AContent: TStringStream);
begin
  FContent := AContent;
end;
procedure TGOXResponse.SetHTTPResponse(const AHTTPResponse: IHTTPResponse);
begin
  FHTTPResponse := AHTTPResponse;
end;
function TGOXResponse.StatusCode: Integer;
begin
  Result := 0;
  if Assigned(FHTTPResponse) then
    Result := FHTTPResponse.StatusCode;
end;
function TGOXResponse.StatusText: string;
begin
  if Assigned(FHTTPResponse) then
    Result := FHTTPResponse.StatusText;
end;


{TGOXRequest}
function TGOXRequest.Accept(const AAccept: string): IGOXRequest;
begin
  Result := Self;
  FNetHTTPClient.Accept := AAccept;
end;
function TGOXRequest.Accept: string;
begin
  Result := FNetHTTPClient.Accept;
end;
function TGOXRequest.AcceptCharset(const AAcceptCharset: string): IGOXRequest;
begin
  Result := Self;
  FNetHTTPClient.AcceptCharSet := AAcceptCharset;
end;
function TGOXRequest.AcceptCharset: string;
begin
  Result := FNetHTTPClient.AcceptCharSet;
end;
function TGOXRequest.AcceptEncoding(const AAcceptEncoding: string): IGOXRequest;
begin
  Result := Self;
  FNetHTTPClient.AcceptEncoding := AAcceptEncoding;
end;
function TGOXRequest.AcceptEncoding: string;
begin
  Result := FNetHTTPClient.AcceptEncoding;
end;
function TGOXRequest.AddBody(const AContent: string): IGOXRequest;
begin
  Result := Self;
  if not Assigned(FStreamSend) then
    FStreamSend := TStringStream.Create(AContent, TEncoding.UTF8)
  else
    TStringStream(FStreamSend).WriteString(AContent);
  FStreamSend.Position := 0;
end;
function TGOXRequest.AddBody(const AContent: TStream; const AOwns: Boolean): IGOXRequest;
begin
  Result := Self;
  try
    if not Assigned(FStreamSend) then
      FStreamSend := TStringStream.Create;
    TStringStream(FStreamSend).CopyFrom(AContent, AContent.Size);
    FStreamSend.Position := 0;
  finally
    if AOwns then
    begin
      {$IFDEF MSWINDOWS}
        AContent.Free;
      {$ELSE}
        AContent.DisposeOf;
      {$ENDIF}
    end;
  end;
end;
function TGOXRequest.AddBody(const AContent: TJSONObject; const AOwns: Boolean): IGOXRequest;
begin
  Result := Self.AddBody(AContent.ToJSON);
  if AOwns then
  begin
    {$IFDEF MSWINDOWS}
      AContent.Free;
    {$ELSE}
      AContent.DisposeOf;
    {$ENDIF}
  end;
end;
function TGOXRequest.AddBody(const AContent: TObject; const AOwns: Boolean): IGOXRequest;
var
  LJSONObject: TJSONObject;
begin
  LJSONObject := TJson.ObjectToJsonObject(AContent);
  try
    Result := Self.AddBody(LJSONObject, False);
  finally
    LJSONObject.Free;
    if AOwns then
    begin
      {$IFDEF MSWINDOWS}
        AContent.Free;
      {$ELSE}
        AContent.DisposeOf;
      {$ENDIF}
    end;
  end;
end;
function TGOXRequest.AddBody(const AContent: TJSONArray; const AOwns: Boolean): IGOXRequest;
begin
  Result := Self.AddBody(AContent.ToJSON);
  if AOwns then
  begin
    {$IFDEF MSWINDOWS}
      AContent.Free;
    {$ELSE}
      AContent.DisposeOf;
    {$ENDIF}
  end;
end;
function TGOXRequest.AddCookies(const ACookies: TStrings): IGOXRequest;
var
  LURI: TIdURI;
begin
  Result := Self;
  LURI := TIdURI.Create(MakeURL(False));
  try
    if not Assigned(FNetHTTPClient.CookieManager) then
      FNetHTTPClient.CookieManager := TCookieManager.Create;
    FNetHTTPClient.CookieManager.AddServerCookie(ACookies.Text, LURI.URI);
  finally
    {$IFDEF MSWINDOWS}
      ACookies.Free;
    {$ELSE}
      ACookies.DisposeOf;
    {$ENDIF}
    LURI.Free;
  end;
end;
function TGOXRequest.AddCookie(const ACookieName, ACookieValue: string): IGOXRequest;
var
  cookies: TStringList;
begin
  cookies := TStringList.Create;
  try
    cookies.AddPair(ACookieName, ACookieValue);
    Result := AddCookies(cookies);
  finally
    cookies.Free;
  end;
end;
function TGOXRequest.AddField(const AFieldName: string; const AValue: string): IGOXRequest;
begin
  Result := Self;
  FMultipartFormData.AddField(AFieldName, AValue);
  FUseMultipartFormData := True;
end;
function TGOXRequest.AddFile(const AFieldName: string; const AFileName: string; const AContentType: string): IGOXRequest;
begin
  Result := Self;
  if not FileExists(AFileName) then
    Exit;
  {$IF COMPILERVERSION >= 33.0}
    FMultipartFormData.AddFile(AFieldName, AFileName, AContentType);
  {$ELSE}
    FMultipartFormData.AddFile(AFieldName, AFileName);
  {$ENDIF}
  FUseMultipartFormData := True;
end;
function TGOXRequest.AddFile(const AFieldName: string; const AValue: TStream; const AFileName: string; const AContentType: string): IGOXRequest;
{$IF COMPILERVERSION >= 33.0}
var
  lFileName: string;
{$ENDIF}
begin
  Result := Self;
  if not Assigned(AValue) then
    Exit;
  {$IF COMPILERVERSION >= 33.0}
    lFileName := Trim(AFileName);
    if (lFileName = EmptyStr) then
      lFileName := AFieldName;
    AValue.Position := 0;
    FMultipartFormData.AddStream(AFieldName, AValue, lFileName, AContentType);
    FUseMultipartFormData := True;
  {$ENDIF}
end;
function TGOXRequest.AddHeader(const AName, AValue: string): IGOXRequest;
begin
  Result := Self;
  if AName.Trim.IsEmpty or AValue.Trim.IsEmpty then
    Exit;
  {$IF COMPILERVERSION >= 34}
    FNetHTTPClient.CustHeaders.Add(AName, AValue);
  {$ELSE}
    {TODO -oAll -cCustoms Headers : Add headers with NetHTTPClient in versions below of 10.4 Sydney}
  {$ENDIF}
end;
function TGOXRequest.AddParam(const AName, AValue: string): IGOXRequest;
begin
  Result := Self;
  if (not AName.Trim.IsEmpty) and (not AValue.Trim.IsEmpty) then
    FParams.Add(AName + '=' + AValue);
end;
function TGOXRequest.AddUrlSegment(const AName, AValue: string): IGOXRequest;
begin
  Result := Self;
  if AName.Trim.IsEmpty or AValue.Trim.IsEmpty then
    Exit;
  if not FullRequestURL(False).Contains(AName) then
  begin
    if (not ResourceSuffix.Trim.IsEmpty) and (not ResourceSuffix.EndsWith('/')) then
      ResourceSuffix(ResourceSuffix + '/');
    ResourceSuffix(ResourceSuffix + '{' + AName + '}');
  end;
  if FUrlSegments.IndexOf(AName) < 0 then
    FUrlSegments.Add(Format('%s=%s', [AName, AValue]));
end;
function TGOXRequest.Asynchronous(const AValue: Boolean): IGOXRequest;
begin
  Result := Self;
  FNetHTTPClient.Asynchronous := AValue;
end;
function TGOXRequest.BaseURL(const ABaseURL: string): IGOXRequest;
begin
  Result := Self;
  FBaseURL := ABaseURL;
end;
function TGOXRequest.BaseURL: string;
begin
  Result := FBaseURL;
end;
function TGOXRequest.BasicAuthentication(const AUsername, APassword: string): IGOXRequest;
begin
  Result := Self.AddHeader('Authorization', 'Basic ' + TNetEncoding.Base64.Encode(AUsername + ':' + APassword));
end;
function TGOXRequest.ClearBody: IGOXRequest;
begin
  Result := Self;
  if Assigned(FStreamSend) then
    FreeAndNil(FStreamSend);
end;
function TGOXRequest.ClearHeaders: IGOXRequest;
{$IF COMPILERVERSION >= 34}
var
  I: Integer;
{$ENDIF}
begin
  Result := Self;
  {$IF COMPILERVERSION >= 34}
    for I := 0 to Pred(FNetHTTPClient.CustHeaders.Count) do
      FNetHTTPClient.CustHeaders.Delete(I);
  {$ELSE}
    {TODO -oAll -cCustom Headers : Clear headers with NetHTTPClient in versions below of 10.4 Sydney}
  {$ENDIF}
end;
function TGOXRequest.ClearParams: IGOXRequest;
begin
  Result := Self;
  FParams.Clear;
end;
function TGOXRequest.ContentType(const AContentType: string): IGOXRequest;
begin
  Result := Self;
  Self.AddHeader('Content-Type', AContentType);
end;
constructor TGOXRequest.Create;
begin
  FNetHTTPClient := TNetHTTPClient.Create(nil);;
  FNetHTTPClient.ResponseTimeout := 900000;
  FNetHTTPClient.ConnectionTimeout := 900000;
  FNetHTTPClient.UserAgent := 'User-Agent:Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.96 Safari/537.36';
  FNetHTTPClient.AcceptCharSet := 'utf-8';
  FNetHTTPClient.AcceptEncoding := 'utf-8';
  FNetHTTPClient.HandleRedirects := True;
  FNetHTTPClient.ContentType := 'application/json';
  FNetHTTPClient.OnRequestError := DoHTTPProtocolError;
  FNetHTTPClient.OnRequestCompleted := DoAfterExecute;
  FNetHTTPClient.Asynchronous := False;
  FParams := TStringList.Create;
  FUrlSegments := TStringList.Create;
  FResponse := TGOXResponse.Create;
  TGOXResponse(FResponse).SetContent(FStreamResult);
  FStreamResult := TStringStream.Create;
  Self.ContentType('application/json');
  FRetries := 0;
  FMultipartFormData := TMultipartFormData.Create;
  FUseMultipartFormData := False;
end;
function TGOXRequest.DeactivateProxy: IGOXRequest;
begin
  Result := Self;
  FNetHTTPClient.ProxySettings := TProxySettings.Create(EmptyStr, 0);
end;
function TGOXRequest.Delete: IGOXResponse;
begin
  Result := FResponse;
  DoBeforeExecute(FNetHTTPClient);
  TGOXResponse(FResponse).SetHTTPResponse(ExecuteRequest(mrDELETE));
end;
destructor TGOXRequest.Destroy;
begin
  if Assigned(FNetHTTPClient) then
    FNetHTTPClient.Free;
  if Assigned(FParams) then
    FParams.Free;
  if Assigned(FUrlSegments) then
    FUrlSegments.Free;
  if Assigned(FStreamSend) then
    FStreamSend.Free;
  if Assigned(FStreamResult) then
    FStreamResult.Free;
  if Assigned(FMultipartFormData) then
    FMultipartFormData.Free;
  inherited;
end;
procedure TGOXRequest.DoAfterExecute(const Sender: TObject; const AResponse: IHTTPResponse);
begin
  //--
end;
procedure TGOXRequest.DoBeforeExecute(const Sender: TNetHTTPClient);
begin
  // virtual method
end;
procedure TGOXRequest.DoHTTPProtocolError(const Sender: TObject; const AError: string);
begin
  // virtual method
end;
function TGOXRequest.ExecuteRequest(const AMethod: TMethodRequest): IHTTPResponse;
var
  LAttempts: Integer;
begin
  LAttempts := FRetries + 1;
  while LAttempts > 0 do
  begin
    try
      case AMethod of
        mrGET:
          Result := FNetHTTPClient.Get(TIdURI.URLEncode(MakeURL), FStreamResult);
        mrPOST:
        begin
          if (Assigned(FMultipartFormData.Stream) and (FUseMultipartFormData = True)) then
          begin
            FNetHTTPClient.ContentType := EmptyStr;
            FUseMultipartFormData := False;
            Result := FNetHTTPClient.Post(TIdURI.URLEncode(MakeURL), FMultipartFormData, FStreamResult);
          end
          else
            Result := FNetHTTPClient.Post(TIdURI.URLEncode(MakeURL), FStreamSend, FStreamResult);
        end;
        mrPUT:
        begin
          if (Assigned(FMultipartFormData.Stream) and (FUseMultipartFormData = True)) then
          begin
            FNetHTTPClient.ContentType := EmptyStr;
            FUseMultipartFormData := False;
            {$IF COMPILERVERSION >= 33.0}
              Result := FNetHTTPClient.Put(TIdURI.URLEncode(MakeURL), FMultipartFormData, FStreamResult);
            {$ENDIF}
          end
          else
            Result := FNetHTTPClient.Put(TIdURI.URLEncode(MakeURL), FStreamSend, FStreamResult);
        end;
        mrPATCH:
          Result := FNetHTTPClient.Patch(TIdURI.URLEncode(MakeURL), FStreamSend, FStreamResult);
        mrDELETE:
          Result := FNetHTTPClient.Delete(TIdURI.URLEncode(MakeURL), FStreamResult);
      end;
      if Assigned(Result) then
        LAttempts := 0
      else
        LAttempts := LAttempts - 1;
    except
      begin
        LAttempts := LAttempts - 1;
        if LAttempts = 0 then
          raise;
      end;
    end;
  end;
end;
function TGOXRequest.FullRequestURL(const AIncludeParams: Boolean): string;
begin
  Result := Self.MakeURL(AIncludeParams);
end;
function TGOXRequest.Get: IGOXResponse;
begin
  Result := FResponse;
  DoBeforeExecute(FNetHTTPClient);
  TGOXResponse(FResponse).SetHTTPResponse(ExecuteRequest(mrGET));
end;
function TGOXRequest.MakeURL(const AIncludeParams: Boolean): string;
var
  I: Integer;
begin
  Result := FBaseURL;
  if not FResource.Trim.IsEmpty then
  begin
    if not Result.EndsWith('/') then
      Result := Result + '/';
    Result := Result + FResource;
  end;
  if not FResourceSuffix.Trim.IsEmpty then
  begin
    if not Result.EndsWith('/') then
      Result := Result + '/';
    Result := Result + FResourceSuffix;
  end;
  if FUrlSegments.Count > 0 then
  begin
    for I := 0 to Pred(FUrlSegments.Count) do
    begin
      Result := StringReplace(Result, Format('{%s}', [FUrlSegments.Names[I]]), FUrlSegments.ValueFromIndex[I], [rfReplaceAll, rfIgnoreCase]);
      Result := StringReplace(Result, Format(':%s', [FUrlSegments.Names[I]]), FUrlSegments.ValueFromIndex[I], [rfReplaceAll, rfIgnoreCase]);
    end;
  end;
  if not AIncludeParams then
    Exit;
  if FParams.Count > 0 then
  begin
    Result := Result + '?';
    for I := 0 to Pred(FParams.Count) do
    begin
      if I > 0 then
        Result := Result + '&';
      Result := Result + FParams.Strings[I];
    end;
  end;
end;
class function TGOXRequest.New: IGOXRequest;
begin
  Result := TGOXRequest.Create;
end;

function TGOXRequest.Patch: IGOXResponse;
begin
  Result := FResponse;
  DoBeforeExecute(FNetHTTPClient);
  TGOXResponse(FResponse).SetHTTPResponse(ExecuteRequest(mrPATCH));
end;
function TGOXRequest.Post: IGOXResponse;
begin
  Result := FResponse;
  DoBeforeExecute(FNetHTTPClient);
  TGOXResponse(FResponse).SetHTTPResponse(ExecuteRequest(mrPOST));
end;
function TGOXRequest.Proxy(const AServer, APassword, AUsername: string; const APort: Integer): IGOXRequest;
begin
  Result := Self;
  FNetHTTPClient.ProxySettings := TProxySettings.Create(AServer, APort, AUsername, APassword);
end;
function TGOXRequest.Put: IGOXResponse;
begin
  Result := FResponse;
  DoBeforeExecute(FNetHTTPClient);
  TGOXResponse(FResponse).SetHTTPResponse(ExecuteRequest(mrPUT));
end;
function TGOXRequest.Resource: string;
begin
  Result := FResource;
end;
function TGOXRequest.Resource(const AResource: string): IGOXRequest;
begin
  Result := Self;
  FResource := AResource;
end;
function TGOXRequest.ResourceSuffix(const AResourceSuffix: string): IGOXRequest;
begin
  Result := Self;
  FResourceSuffix := AResourceSuffix;
end;
function TGOXRequest.ResourceSuffix: string;
begin
  Result := FResourceSuffix;
end;
function TGOXRequest.Retry(const ARetries: Integer): IGOXRequest;
begin
  Result := Self;
  FRetries := ARetries;
end;
function TGOXRequest.Timeout: Integer;
begin
  Result := FNetHTTPClient.ResponseTimeout;
end;
function TGOXRequest.Timeout(const ATimeout: Integer): IGOXRequest;
begin
  Result := Self;
  FNetHTTPClient.ResponseTimeout := ATimeout;
  FNetHTTPClient.ConnectionTimeout := ATimeout;
end;
function TGOXRequest.Token(const AToken: string): IGOXRequest;
begin
  Result := Self;
  Self.AddHeader('Authorization', AToken);
end;
function TGOXRequest.TokenBearer(const AToken: string): IGOXRequest;
begin
  Result := Self;
  Self.AddHeader('Authorization', 'Bearer ' + AToken);
end;
function TGOXRequest.UserAgent(const AName: string): IGOXRequest;
begin
  Result := Self;
  FNetHTTPClient.UserAgent := AName;
end;
end.
