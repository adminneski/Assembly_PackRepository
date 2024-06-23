
{******************************************}
{                                          }
{             FastReport VCL               }
{                Laz Socket                }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit LazSocket;

interface

{$I frx.inc}

uses
  Sockets,
  {$IFDEF Windows}
  Windows ,winsock2, WinSock,
  {$ELSE}
  BaseUnix, Unix, LazHelperCS, cNetDB, termio,
  {$ENDIF}
  Forms, LCLType, Messages, Classes, frxClass, Registry,
  syncobjs, SysUtils, resolve,FileUtil, LResources, Controls,
  Graphics, Dialogs,ComCtrls, LMessages, ExtCtrls, StdCtrls, LCLIntf, frCore;

type
  TCustomWinSocket = class;
  TCustomSocket = class;
  TServerAcceptThread = class;
  TServerClientThread = class;
  TServerWinSocket = class;
  TServerClientWinSocket = class;

  TSocketSupport = class(TThread)
  private
    FSocketForEvent: TCustomWinSocket;
    FSocket : LongInt;
    CritSec: TCriticalSection;
    ReadTFDS, WriteTFDS, ExcepTFDS: TFDSet;
  protected
    procedure Execute; Override;
  public
    constructor Create(Socket: LongInt; SocketForEvent: TCustomWinSocket);
  end;

  TFRMLookupComplete = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    LookupHandle: TfrHandle;
    AsyncBufLen: Word;
    AsyncError: Word;
    AsyncBufLenErrorFiller: TDWordFiller;
    Result: LRESULT;
  end;

  TFRMSocketMessage = record
    Msg: Cardinal;
    MsgFiller: TDWordFiller;
    Socket: TSocket;
    SelectEvent: Word;
    SelectError: Word;
    SelectEventErrorFiller: TDWordFiller;
    Result: LRESULT;
  end;

  TServerType = (stNonBlocking, stThreadBlocking);
  TClientType = (ctNonBlocking, ctBlocking);
  TAsyncStyle = (asRead, asWrite, asOOB, asAccept, asConnect, asClose);
  TAsyncStyles = set of TAsyncStyle;
  TSocketEvent = (seLookup, seConnecting, seConnect, seDisconnect, seListen, seAccept, seWrite, seRead);
  TLookupState = (lsIdle, lsLookupAddress, lsLookupService);
  TErrorEvent = (eeGeneral, eeSend, eeReceive, eeConnect, eeDisconnect, eeAccept, eeLookup);

  TSocketEventEvent  = procedure (Sender: TObject; Socket: TCustomWinSocket; SocketEvent: TSocketEvent) of object;
  TSocketErrorEvent  = procedure (Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer) of object;
  TGetSocketEvent    = procedure (Sender: TObject; Socket: TSocket; var ClientSocket: TServerClientWinSocket) of object;
  TGetThreadEvent    = procedure (Sender: TObject; ClientSocket: TServerClientWinSocket; var SocketThread: TServerClientThread) of object;
  TSocketNotifyEvent = procedure (Sender: TObject; Socket: TCustomWinSocket) of object;
  TThreadNotifyEvent = procedure (Sender: TObject;Thread: TServerClientThread) of object;

  TCustomWinSocket = class
  private
    FSocket: TSocket;
    FConnected: Boolean;
    FSendStream: TStream;
    FDropAfterSend: Boolean;
    FAddr: TSockAddrIn;
    FAsyncStyles: TASyncStyles;
    FLookupState: TLookupState;
    FOnSocketEvent: TSocketEventEvent;
    FOnErrorEvent: TSocketErrorEvent;
    FSocketLock: TCriticalSection;
    FGetHostData: PHostEnt;
    FData: Pointer;
    FService: string;
    FPort: Word;
    FClient: Boolean;
    FQueueSize: Integer;
    FSocketSupport: TSocketSupport;

    function SendStreamPiece: Boolean;
    procedure CMLookupComplete(var Message: TFRMLookupComplete);
    procedure CMSocketMessage(var Message: TFRMSocketMessage);
    procedure DoSetAsyncStyles;
    function GetLocalAddress: string;
    function GetLocalPort: Integer;
    function GetRemoteHost: string;
    function GetRemoteAddress: string;
    function GetRemotePort: Integer;
    function GetRemoteAddr: TSockAddrIn;
  protected
    procedure AsyncInitSocket(const Name, Address, Service: string; Port: Word; QueueSize: Integer; Client: Boolean);
    procedure DoOpen;
    procedure DoListen(QueueSize: Integer);
    function InitSocket(const Name, Address, Service: string; Port: Word; Client: Boolean): TSockAddrIn;
    procedure Event(Socket: TCustomWinSocket; SocketEvent: TSocketEvent); virtual;
    procedure Error(Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer); virtual;
    procedure SetAsyncStyles(Value: TASyncStyles);
  public
    constructor Create(ASocket: TSocket);
    destructor Destroy; override;
    procedure Close;
    procedure Lock;
    procedure Unlock;
    procedure Listen(const Name, Address, Service: string; Port: Word; QueueSize: Integer; Block: Boolean = True);
    procedure Open(const Name, Address, Service: string; Port: Word; Block: Boolean = True);
    procedure Disconnect(Socket: TSocket); virtual;
    procedure Read(Socket: TSocket); virtual;
    procedure Write(Socket: TSocket); virtual;
    function LookupName(const name: string): TInAddr;
    function LookupService(const service: string): Integer;
    procedure Connect(Socket: TSocket); virtual;
    procedure Accept(Socket: TSocket); virtual;
    function ReceiveLength: Integer;
    function ReceiveBuf(var Buf; Count: Integer): Integer;
    function ReceiveText: AnsiString;
    function SendBuf(var Buf; Count: Integer): Integer;
    function SendStream(AStream: TStream): Boolean;
    function SendStreamThenDrop(AStream: TStream): Boolean;
    function SendText(const S: AnsiString): Integer;

    property LocalAddress: string read GetLocalAddress;
    property LocalPort: Integer read GetLocalPort;
    property RemoteHost: string read GetRemoteHost;
    property RemoteAddress: string read GetRemoteAddress;
    property RemotePort: Integer read GetRemotePort;
    property RemoteAddr: TSockAddrIn read GetRemoteAddr;
    property Connected: Boolean read FConnected;
    property Addr: TSockAddrIn read FAddr;
    property ASyncStyles: TAsyncStyles read FAsyncStyles write SetAsyncStyles;
    property SocketHandle: TSocket read FSocket;
    property LookupState: TLookupState read FLookupState;
    property OnSocketEvent: TSocketEventEvent read FOnSocketEvent write FOnSocketEvent;
    property OnErrorEvent: TSocketErrorEvent read FOnErrorEvent write FOnErrorEvent;
    property Data: Pointer read FData write FData;
  end;

  TClientWinSocket = class(TCustomWinSocket)
  private
    FClientType: TClientType;
  protected
    procedure SetClientType(Value: TClientType);
  public
    procedure Connect(Socket: TSocket); override;
    property ClientType: TClientType read FClientType write SetClientType;
  end;

  TServerClientWinSocket = class(TCustomWinSocket)
  private
    FServerWinSocket: TServerWinSocket;
  public
    constructor Create(Socket: TSocket; ServerWinSocket: TServerWinSocket);
    destructor Destroy; override;
    property ServerWinSocket: TServerWinSocket read FServerWinSocket;
  end;

  TServerWinSocket = class(TCustomWinSocket)
  private
    FServerType: TServerType;
    FThreadCacheSize: Integer;
    FConnections: TList;
    FActiveThreads: TList;
    FListLock: TCriticalSection;
    FServerAcceptThread: TServerAcceptThread;
    FOnGetSocket: TGetSocketEvent;
    FOnGetThread: TGetThreadEvent;
    FOnThreadStart: TThreadNotifyEvent;
    FOnThreadEnd: TThreadNotifyEvent;
    FOnClientConnect: TSocketNotifyEvent;
    FOnClientDisconnect: TSocketNotifyEvent;
    FOnClientRead: TSocketNotifyEvent;
    FOnClientWrite: TSocketNotifyEvent;
    FOnClientError: TSocketErrorEvent;
    procedure AddClient(AClient: TServerClientWinSocket);
    procedure RemoveClient(AClient: TServerClientWinSocket);
    procedure AddThread(AThread: TServerClientThread);
    procedure RemoveThread(AThread: TServerClientThread);
    procedure ClientEvent(Sender: TObject; Socket: TCustomWinSocket; SocketEvent: TSocketEvent);
    procedure ClientError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    function GetActiveConnections: Integer;
    function GetConnections(Index: Integer): TCustomWinSocket;
    function GetActiveThreads: Integer;
    function GetIdleThreads: Integer;
  protected
    procedure Listen(var Name, Address, Service: string; Port: Word; QueueSize: Integer);
    procedure SetServerType(Value: TServerType);
    function DoCreateThread(ClientSocket: TServerClientWinSocket): TServerClientThread; virtual;
    procedure SetThreadCacheSize(Value: Integer);
    procedure ThreadStart(AThread: TServerClientThread); virtual;
    procedure ThreadEnd(AThread: TServerClientThread); virtual;
    function GetServerThread(ClientSocket: TServerClientWinSocket): TServerClientThread; virtual;
    function GetClientSocket(Socket: TSocket): TServerClientWinSocket; virtual;
    procedure ClientConnect(Socket: TCustomWinSOcket); virtual;
    procedure ClientDisconnect(Socket: TCustomWinSOcket); virtual;
    procedure ClientRead(Socket: TCustomWinSocket); virtual;
    procedure ClientWrite(Socket: TCustomWinSOcket); virtual;
    procedure ClientErrorEvent(Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer); virtual;
  public
    constructor Create(ASocket: TSocket);
    destructor Destroy; override;
    procedure Accept(Socket: TSocket); override;
    procedure Disconnect(Socket: TSocket); override;
    function GetClientThread(ClientSocket: TServerClientWinSocket): TServerClientThread;

    property ActiveConnections: Integer read GetActiveConnections;
    property ActiveThreads: Integer read GetActiveThreads;
    property Connections[Index: Integer]: TCustomWinSocket read GetConnections;
    property IdleThreads: Integer read GetIdleThreads;
    property ServerType: TServerType read FServerType write SetServerType;
    property ThreadCacheSize: Integer read FThreadCacheSize write SetThreadCacheSize;
    property OnGetSocket: TGetSocketEvent read FOnGetSocket write FOnGetSocket;
    property OnGetThread: TGetThreadEvent read FOnGetThread write FOnGetThread;
    property OnThreadStart: TThreadNotifyEvent read FOnThreadStart write FOnThreadStart;
    property OnThreadEnd: TThreadNotifyEvent read FOnThreadEnd write FOnThreadEnd;
    property OnClientConnect: TSocketNotifyEvent read FOnClientConnect write FOnClientConnect;
    property OnClientDisconnect: TSocketNotifyEvent read FOnClientDisconnect write FOnClientDisconnect;
    property OnClientRead: TSocketNotifyEvent read FOnClientRead write FOnClientRead;
    property OnClientWrite: TSocketNotifyEvent read FOnClientWrite write FOnClientWrite;
    property OnClientError: TSocketErrorEvent read FOnClientError write FOnClientError;
  end;

  TServerAcceptThread = class(TThread)
  private
    FServerSocket: TServerWinSocket;
  public
    constructor Create(CreateSuspended: Boolean; ASocket: TServerWinSocket);
    procedure Execute; override;

    property ServerSocket: TServerWinSocket read FServerSocket;
  end;

  TServerClientThread = class(TThread)
  private
    FServerSocket: TServerWinSocket;
    FClientSocket: TServerClientWinSocket;
    FException: Exception;
    FEvent: TSimpleEvent;
    FKeepInCache: Boolean;
    FData: Pointer;
    procedure HandleEvent(Sender: TObject; Socket: TCustomWinSocket; SocketEvent: TSocketEvent);
    procedure HandleError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure DoHandleException;
    procedure DoRead;
    procedure DoWrite;
  protected
    procedure ReActivate(ASocket: TServerClientWinSocket);
    function StartConnect: Boolean;
    function EndConnect: Boolean;
    procedure DoTerminate; override;
    procedure Execute; override;
    procedure ClientExecute; virtual;
    procedure Event(SocketEvent: TSocketEvent); virtual;
    procedure Error(ErrorEvent: TErrorEvent; var ErrorCode: Integer); virtual;
    procedure HandleException; virtual;
  public
    constructor Create(CreateSuspended: Boolean; ASocket: TServerClientWinSocket);
    destructor Destroy; override;

    property ClientSocket: TServerClientWinSocket read FClientSocket;
    property ServerSocket: TServerWinSocket read FServerSocket;
    property KeepInCache: Boolean read FKeepInCache write FKeepInCache;
    property Data: Pointer read FData write FData;
  end;

  TAbstractSocket = class(TComponent)
  private
    FActive: Boolean;
    FPort: Integer;
    FAddress: string;
    FHost: string;
    FService: string;
    procedure DoEvent(Sender: TObject; Socket: TCustomWinSocket; SocketEvent: TSocketEvent);
    procedure DoError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
  protected
    procedure Event(Socket: TCustomWinSocket; SocketEvent: TSocketEvent); virtual; abstract;
    procedure Error(Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer); virtual; abstract;
    procedure DoActivate(Value: Boolean); virtual; abstract;
    procedure InitSocket(Socket: TCustomWinSocket);
    procedure SetActive(Value: Boolean);
    procedure Loaded; override;
    procedure SetHost(Value: string);
    procedure SetPort(Value: Integer);
    procedure SetService(Value: string);
    procedure SetAddress(Value: string);

    property Active: Boolean read FActive write SetActive;
    property Address: string read FAddress write SetAddress;
    property Host: string read FHost write SetHost;
    property Port: Integer read FPort write SetPort;
    property Service: string read FService write SetService;
  public
    procedure Open;
    procedure Close;
  end;

  TCustomSocket = class(TAbstractSocket)
  private
    FOnLookup: TSocketNotifyEvent;
    FOnConnect: TSocketNotifyEvent;
    FOnConnecting: TSocketNotifyEvent;
    FOnDisconnect: TSocketNotifyEvent;
    FOnListen: TSocketNotifyEvent;
    FOnAccept: TSocketNotifyEvent;
    FOnRead: TSocketNotifyEvent;
    FOnWrite: TSocketNotifyEvent;
    FOnError: TSocketErrorEvent;
  protected
    procedure Event(Socket: TCustomWinSocket; SocketEvent: TSocketEvent); override;
    procedure Error(Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer); override;
    property OnLookup: TSocketNotifyEvent read FOnLookup write FOnLookup;
    property OnConnecting: TSocketNotifyEvent read FOnConnecting write FOnConnecting;
    property OnConnect: TSocketNotifyEvent read FOnConnect write FOnConnect;
    property OnDisconnect: TSocketNotifyEvent read FOnDisconnect write FOnDisconnect;
    property OnListen: TSocketNotifyEvent read FOnListen write FOnListen;
    property OnAccept: TSocketNotifyEvent read FOnAccept write FOnAccept;
    property OnRead: TSocketNotifyEvent read FOnRead write FOnRead;
    property OnWrite: TSocketNotifyEvent read FOnWrite write FOnWrite;
    property OnError: TSocketErrorEvent read FOnError write FOnError;
  end;

  TClientSocket = class(TCustomSocket)
  private
    FClientSocket: TClientWinSocket;
  protected
    procedure DoActivate(Value: Boolean); override;
    function GetClientType: TClientType;
    procedure SetClientType(Value: TClientType);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Socket: TClientWinSocket read FClientSocket;
  published
    property Active;
    property Address;
    property ClientType: TClientType read GetClientType write SetClientType;
    property Host;
    property Port;
    property Service;
    property OnLookup;
    property OnConnecting;
    property OnConnect;
    property OnDisconnect;
    property OnRead;
    property OnWrite;
    property OnError;
  end;

  TCustomServerSocket = class(TCustomSocket)
  protected
    FServerSocket: TServerWinSocket;
    procedure DoActivate(Value: Boolean); override;
    function GetServerType: TServerType;
    procedure SetServerType(Value: TServerType);
    function GetGetThreadEvent: TGetThreadEvent;
    procedure SetGetThreadEvent(Value: TGetThreadEvent);
    function GetGetSocketEvent: TGetSocketEvent;
    procedure SetGetSocketEvent(Value: TGetSocketEvent);
    function GetThreadCacheSize: Integer;
    procedure SetThreadCacheSize(Value: Integer);
    function GetOnThreadStart: TThreadNotifyEvent;
    procedure SetOnThreadStart(Value: TThreadNotifyEvent);
    function GetOnThreadEnd: TThreadNotifyEvent;
    procedure SetOnThreadEnd(Value: TThreadNotifyEvent);
    function GetOnClientEvent(Index: Integer): TSocketNotifyEvent;
    procedure SetOnClientEvent(Index: Integer; Value: TSocketNotifyEvent);
    function GetOnClientError: TSocketErrorEvent;
    procedure SetOnClientError(Value: TSocketErrorEvent);

    property ServerType: TServerType read GetServerType write SetServerType;
    property ThreadCacheSize: Integer read GetThreadCacheSize write SetThreadCacheSize;
    property OnGetThread: TGetThreadEvent read GetGetThreadEvent write SetGetThreadEvent;
    property OnGetSocket: TGetSocketEvent read GetGetSocketEvent write SetGetSocketEvent;
    property OnThreadStart: TThreadNotifyEvent read GetOnThreadStart write SetOnThreadStart;
    property OnThreadEnd: TThreadNotifyEvent read GetOnThreadEnd write SetOnThreadEnd;
    property OnClientConnect: TSocketNotifyEvent index 2 read GetOnClientEvent write SetOnClientEvent;
    property OnClientDisconnect: TSocketNotifyEvent index 3 read GetOnClientEvent write SetOnClientEvent;
    property OnClientRead: TSocketNotifyEvent index 0 read GetOnClientEvent write SetOnClientEvent;
    property OnClientWrite: TSocketNotifyEvent index 1 read GetOnClientEvent write SetOnClientEvent;
    property OnClientError: TSocketErrorEvent read GetOnClientError write SetOnClientError;
  public
    destructor Destroy; override;
  end;

  TServerSocket = class(TCustomServerSocket)
  public
    constructor Create(AOwner: TComponent); override;
    property Socket: TServerWinSocket read FServerSocket;
  published
    property Active;
    property Port;
    property Service;
    property ServerType;
    property ThreadCacheSize default 10;
    property OnListen;
    property OnAccept;
    property OnGetThread;
    property OnGetSocket;
    property OnThreadStart;
    property OnThreadEnd;
    property OnClientConnect;
    property OnClientDisconnect;
    property OnClientRead;
    property OnClientWrite;
    property OnClientError;
  end;

function CheckSocketResult(ResultCode: Integer; const Op: string): Integer;

implementation

uses Types, RTLConsts;

function CheckSocketResult(ResultCode: Integer; const Op: string): Integer;
begin
  if ResultCode <> 0 then
  begin
    Result := socketerror;
    raise Exception.CreateResFmt(@sWindowsSocketError, [SysErrorMessage(Result), Result, Op]);
  end else Result := 0;
end;

{ TSocketSupport }

constructor TSocketSupport.Create(Socket : LongInt; SocketForEvent: TCustomWinSocket);
begin
  FSocket := Socket;
  FSocketForEvent := SocketForEvent;
  inherited Create(True);
end;

procedure TSocketSupport.Execute;
var
  buf: Integer;
  mes: TFRMSocketMessage;
  time: TTimeVal;

  function CreateMessage(FSelectEvent: Word): TFRMSocketMessage;
  begin
    Result.Msg := 0;
    Result.Socket := FSocket;
    Result.SelectEvent := FSelectEvent;
    Result.SelectError := 0;
    Result.Result := 0;
  end;

begin
  CritSec := TCriticalSection.Create;
  time.tv_sec:=1; //need to decrease?
  time.tv_usec:=0;
  FD_Zero(ReadTFDS);
  FD_Zero(WriteTFDS);
  FD_Zero(ExcepTFDS);
  while(NOT Terminated) do
  begin
    FD_Set(FSocket, ReadTFDS);
    FD_Set(FSocket, WriteTFDS);
    FD_Set(FSocket, ExcepTFDS);
    buf := Select(FSocket + 1, @ReadTFDS, @WriteTFDS, @excepTFDS, @time);
    if(buf <> -1) then
    begin
      CritSec.Enter;
      if FD_ISSET(FSocket, ReadTFDS) then
      begin
        if FSocketForEvent.ReceiveLength > 0 then
        begin
          mes := CreateMessage(FD_READ);
          FSocketForEvent.CMSocketMessage(mes);
        end
        else
        begin
          mes := CreateMessage(FD_CLOSE);
          FSocketForEvent.CMSocketMessage(mes);
          CritSec.Leave;
          CritSec.Free;
          Exit;
        end;
      end;
      if FD_ISSET(FSocket, WriteTFDS) then
      begin
        mes := CreateMessage(FD_WRITE);
        FSocketForEvent.CMSocketMessage(mes);
      end;
      if FD_ISSET(FSocket, excepTFDS) then
      begin
        //TODO Except for Select
      end;
      CritSec.Leave;
    end;
  end;
  CritSec.Free;
end;

{ TCustomWinSocket }

constructor TCustomWinSocket.Create(ASocket: TSocket);
begin
  inherited Create;
  FSocketLock := TCriticalSection.Create;
  FASyncStyles := [asRead, asWrite, asConnect, asClose];
  FSocket := ASocket;
  FAddr.sin_family := PF_INET;
  FAddr.sin_addr.s_addr := INADDR_ANY;
  FAddr.sin_port := 0;
  FConnected := FSocket <> INVALID_SOCKET;
  FSocketSupport := nil;
end;

destructor TCustomWinSocket.Destroy;
begin
  FOnSocketEvent := nil;
  if FConnected and (FSocket <> INVALID_SOCKET) then
    Disconnect(FSocket);
  FSocketLock.Free;
  FGetHostData := nil;
  inherited Destroy;
end;

function TCustomWinSocket.SendStreamPiece: Boolean;
var
  Buf: array[0..65535] of Byte;
  SPos, RemBuf, RemSend, ErrorCode: Integer;

  procedure DropStream;
  begin
    if FDropAfterSend then Disconnect(FSocket);
    FDropAfterSend := False;
    FSendStream.Free;
    FSendStream := nil;
  end;

begin
  Lock;
  try
    Result := False;
    if FSendStream <> nil then
    begin
      if (FSocket = INVALID_SOCKET) or (not FConnected) then exit;
      while True do
      begin
        SPos := FSendStream.Position;
        RemBuf := FSendStream.Read(Buf, SizeOf(Buf));
        if RemBuf > 0 then
        begin
          RemSend := fpsend(FSocket, @Buf, RemBuf, 0);
          if RemSend = SOCKET_ERROR then
          begin
            ErrorCode := socketerror;
            Error(Self, eeSend, ErrorCode);
            Disconnect(FSocket);
            DropStream;
            if FAsyncStyles <> [] then Abort;
            Break;
          end else if RemBuf > RemSend then
            FSendStream.Position := SPos + RemSend
          else if FSendStream.Position = FSendStream.Size then
          begin
            DropStream;
            Break;
          end;
        end else
        begin
          DropStream;
          Break;
        end;
      end;
      Result := True;
    end;
  finally
    Unlock;
  end;
end;

procedure TCustomWinSocket.CMLookupComplete(var Message: TFRMLookupComplete);
var
  ErrorCode: Integer;
begin
  begin
    if Message.AsyncError <> 0 then
    begin
      ErrorCode := Message.AsyncError;
      Error(Self, eeLookup, ErrorCode);
      Disconnect(FSocket);
      if ErrorCode <> 0 then
        raise Exception.CreateResFmt(@sWindowsSocketError,
          [SysErrorMessage(Message.AsyncError), Message.ASyncError, 'ASync Lookup']);
      Exit;
    end;
    if FLookupState = lsLookupAddress then
    begin
      {$IFDEF Windows}
      FAddr.sin_addr.S_addr := Integer(Pointer(PHostEnt(FGetHostData).h_addr^)^);
      {$ELSE}
      FAddr.sin_addr.S_addr := inet_addr(PHostEnt(FGetHostData).h_name);
      {$ENDIF}
      ASyncInitSocket('', '', FService, FPort, FQueueSize, FClient);
    end else if FLookupState = lsLookupService then
    begin
      FAddr.sin_port := PServEnt(FGetHostData).s_port;
      FPort := 0;
      FService := '';
      ASyncInitSocket('', '', '', 0, FQueueSize, FClient);
    end;
  end;
end;

procedure TCustomWinSocket.CMSocketMessage(var Message: TFRMSocketMessage);

  function CheckErr: Boolean;
  var
    ErrorEvent: TErrorEvent;
    ErrorCode: Integer;
  begin
    if Message.SelectError <> 0 then
    begin
      Result := False;
      ErrorCode := Message.SelectError;
      case Message.SelectEvent of
        FD_CONNECT: ErrorEvent := eeConnect;
        FD_READ: ErrorEvent := eeReceive;
        FD_WRITE: ErrorEvent := eeSend;
        FD_CLOSE: ErrorEvent := eeDisconnect;
        FD_ACCEPT: ErrorEvent := eeAccept;
      else
        ErrorEvent := eeGeneral;
      end;
      Error(Self, ErrorEvent, ErrorCode);
      if ErrorCode <> 0 then
        raise Exception.CreateResFmt(@sASyncSocketError, [ErrorCode]);
    end else Result := True;
  end;

begin
  with Message do
    if CheckErr then
      case SelectEvent of
        FD_CONNECT: Connect(Socket);
        FD_CLOSE: Disconnect(Socket);
        FD_READ: Read(Socket);
        FD_WRITE: Write(Socket);
        FD_ACCEPT: Accept(Socket);
      end;
end;

procedure TCustomWinSocket.DoSetAsyncStyles;
var
  Block: Longint;
begin
  if FAsyncStyles <> [] then
  begin
    FSocketSupport := TSocketSupport.Create(FSocket, Self);
    FSocketSupport.FreeOnTerminate := True;
  end
  else
  begin
    Block := 0;
    ioctlsocket(FSocket, FIONBIO, Block);
  end;
end;

function TCustomWinSocket.GetLocalAddress: string;
var
  SockAddrIn: TSockAddrIn;
  Size: Integer;
begin
  Lock;
  try
    Result := '';
    if FSocket = INVALID_SOCKET then Exit;
    Size := SizeOf(SockAddrIn);
    if fpgetsockname(FSocket, @SockAddrIn, @Size) = 0 then
      Result := string(inet_ntoa(SockAddrIn.sin_addr));
  finally
    Unlock;
  end;
end;

function TCustomWinSocket.GetLocalPort: Integer;
var
  SockAddrIn: TSockAddrIn;
  Size: Integer;
begin
  Lock;
  try
    Result := -1;
    if FSocket = INVALID_SOCKET then Exit;
    Size := SizeOf(SockAddrIn);
    if fpgetsockname(FSocket, @SockAddrIn, @Size) = 0 then
      Result := ntohs(SockAddrIn.sin_port);
  finally
    Unlock;
  end;
end;

function TCustomWinSocket.GetRemoteHost: string;
var
  SockAddrIn: TSockAddrIn;
  Size: Integer;
  HostEnt: PHostEnt;
begin
  Lock;
  try
    Result := '';
    if not FConnected then Exit;
    Size := SizeOf(SockAddrIn);
    CheckSocketResult(getpeername(FSocket, SockAddrIn, Size), 'getpeername');
    HostEnt := gethostbyaddr(@SockAddrIn.sin_addr.s_addr, 4, PF_INET);
    if HostEnt <> nil then Result := string(HostEnt.h_name);
  finally
    Unlock;
  end;
end;

function TCustomWinSocket.GetRemoteAddress: string;
var
  SockAddrIn: TSockAddrIn;
  Size: Integer;
begin
  Lock;
  try
    Result := '';
    if not FConnected then Exit;
    Size := SizeOf(SockAddrIn);
    CheckSocketResult(getpeername(FSocket, SockAddrIn, Size), 'getpeername');
    Result := string(inet_ntoa(SockAddrIn.sin_addr));
  finally
    Unlock;
  end;
end;

function TCustomWinSocket.GetRemotePort: Integer;
var
  SockAddrIn: TSockAddrIn;
  Size: Integer;
begin
  Lock;
  try
    Result := 0;
    if not FConnected then Exit;
    Size := SizeOf(SockAddrIn);
    CheckSocketResult(getpeername(FSocket, SockAddrIn, Size), 'getpeername');
    Result := ntohs(SockAddrIn.sin_port);
  finally
    Unlock;
  end;
end;

function TCustomWinSocket.GetRemoteAddr: TSockAddrIn;
var
  Size: Integer;
begin
  Lock;
  try
    FillChar(Result, SizeOf(Result), 0);
    if not FConnected then Exit;
    Size := SizeOf(Result);
    if getpeername(FSocket, Result, Size) <> 0 then
      FillChar(Result, SizeOf(Result), 0);
  finally
    Unlock;
  end;
end;

procedure TCustomWinSocket.AsyncInitSocket(const Name, Address, Service: string; Port: Word; QueueSize: Integer; Client: Boolean);
var
  ErrorCode: Integer;
  mes: TFRMLookupComplete;
begin
  try
    case FLookupState of
      lsIdle:
        begin
          if not Client then
          begin
            FLookupState := lsLookupAddress;
            FAddr.sin_addr.S_addr := INADDR_ANY;
          end else if Name <> '' then
          begin
            FGetHostData := gethostbyname(Pchar(Name));
            FService := Service;
            FPort := Port;
            FQueueSize := QueueSize;
            FClient := Client;
            FLookupState := lsLookupAddress;
            mes.Msg:=1027;
            mes.AsyncError:=0;
            CMLookupComplete(mes);
            Exit;
          end else if Address <> '' then
          begin
            FLookupState := lsLookupAddress;
            FAddr.sin_addr.S_addr := inet_addr(PAnsiChar(AnsiString(Address)));
          end else
          begin
            ErrorCode := 1110;
            Error(Self, eeLookup, ErrorCode);
            Disconnect(FSocket);
            if ErrorCode <> 0 then
              raise Exception.CreateRes(@sNoAddress);
            Exit;
          end;
        end;
      lsLookupAddress:
        begin
          if Service <> '' then
          begin
            FLookupState := lsLookupService;
            Exit;
          end else
          begin
            FLookupState := lsLookupService;
            FAddr.sin_port := htons(Port);
          end;
        end;
      lsLookupService:
        begin
          FLookupState := lsIdle;
          if Client then
            DoOpen
          else DoListen(QueueSize);
        end;
    end;
    if FLookupState <> lsIdle then
      ASyncInitSocket(Name, Address, Service, Port, QueueSize, Client);
  except
    Disconnect(FSocket);
    raise;
  end;
end;

procedure TCustomWinSocket.DoOpen;
begin
  DoSetASyncStyles;
  Event(Self, seConnecting);
  CheckSocketResult(fpconnect(FSocket, @FAddr, SizeOf(FAddr)), 'connect');
  FLookupState := lsIdle;
  FConnected := FSocket <> INVALID_SOCKET;
  Event(Self, seConnect);
  FSocketSupport.Start;
end;

procedure TCustomWinSocket.DoListen(QueueSize: Integer);
begin
  CheckSocketResult(fpbind(FSocket, @FAddr, SizeOf(FAddr)), 'bind');
  DoSetASyncStyles;
  if QueueSize > SOMAXCONN then QueueSize := SOMAXCONN;
  Event(Self, seListen);
  CheckSocketResult(fplisten(FSocket, QueueSize), 'listen');
  FLookupState := lsIdle;
  FConnected := True;
end;

function TCustomWinSocket.InitSocket(const Name, Address, Service: string; Port: Word; Client: Boolean): TSockAddrIn;
begin
  Result.sin_family := PF_INET;
  if Name <> '' then
    Result.sin_addr := LookupName(name)
  else if Address <> '' then
    Result.sin_addr.s_addr := inet_addr(PAnsiChar(AnsiString(Address)))
  else if not Client then
    Result.sin_addr.s_addr := INADDR_ANY
  else raise Exception.CreateRes(@sNoAddress);
  if Service <> '' then
    Result.sin_port := htons(LookupService(Service))
  else
    Result.sin_port := htons(Port);
end;

procedure TCustomWinSocket.Event(Socket: TCustomWinSocket; SocketEvent: TSocketEvent);
begin
  if Assigned(FOnSocketEvent) then FOnSocketEvent(Self, Socket, SocketEvent);
end;

procedure TCustomWinSocket.Error(Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
  if Assigned(FOnErrorEvent) then FOnErrorEvent(Self, Socket, ErrorEvent, ErrorCode);
end;

procedure TCustomWinSocket.SetAsyncStyles(Value: TASyncStyles);
begin
  if Value <> FASyncStyles then
  begin
    FASyncStyles := Value;
    if FSocket <> INVALID_SOCKET then
      DoSetAsyncStyles;
  end;
end;

procedure TCustomWinSocket.Close;
begin
  Disconnect(FSocket);
end;

procedure TCustomWinSocket.Lock;
begin
  FSocketLock.Enter;
end;

procedure TCustomWinSocket.Unlock;
begin
  FSocketLock.Leave;
end;

procedure TCustomWinSocket.Listen(const Name, Address, Service: string; Port: Word; QueueSize: Integer; Block: Boolean);
begin
  if FConnected then raise Exception.CreateRes(@sCannotListenOnOpen);
  FSocket := socket(PF_INET, SOCK_STREAM, IPPROTO_IP);
  if FSocket = INVALID_SOCKET then raise Exception.CreateRes(@sCannotCreateSocket);
  try
    Event(Self, seLookUp);
    if Block then
    begin
      FAddr := InitSocket(Name, Address, Service, Port, False);
      DoListen(QueueSize);
    end else
      AsyncInitSocket(Name, Address, Service, Port, QueueSize, False);
  except
    Disconnect(FSocket);
    raise;
  end;
end;

procedure TCustomWinSocket.Open(const Name, Address, Service: string; Port: Word; Block: Boolean);
begin
  if FConnected then raise Exception.CreateRes(@sSocketAlreadyOpen);
  FSocket := socket(PF_INET, SOCK_STREAM, IPPROTO_IP);
  if FSocket = INVALID_SOCKET then raise Exception.CreateRes(@sCannotCreateSocket);
  try
    Event(Self, seLookUp);
    if Block then
    begin
      FAddr := InitSocket(Name, Address, Service, Port, True);
      DoOpen;
    end else
      AsyncInitSocket(Name, Address, Service, Port, 0, True);
  except
    Disconnect(FSocket);
    raise;
  end;
end;

procedure TCustomWinSocket.Disconnect(Socket: TSocket);
begin
  Lock;
  try
    if Assigned(FSocketSupport) then
      FSocketSupport.Terminate;
    if (Socket = INVALID_SOCKET) or (Socket <> FSocket) then exit;
    Event(Self, seDisconnect);
    CheckSocketResult(closesocket(FSocket), 'closesocket');
    FSocket := INVALID_SOCKET;
    FAddr.sin_family := PF_INET;
    FAddr.sin_addr.s_addr := INADDR_ANY;
    FAddr.sin_port := 0;
    FConnected := False;
    FreeAndNil(FSendStream);
  finally
    Unlock;
  end;
end;

procedure TCustomWinSocket.Read(Socket: TSocket);
begin
  if (FSocket = INVALID_SOCKET) or (Socket <> FSocket) then Exit;
  Event(Self, seRead);
end;

procedure TCustomWinSocket.Write(Socket: TSocket);
begin
  if (FSocket = INVALID_SOCKET) or (Socket <> FSocket) then Exit;
  if not SendStreamPiece then Event(Self, seWrite);
end;

function TCustomWinSocket.LookupName(const Name: string): TInAddr;
var
  HostEnt: PHostEnt;
  InAddr: TInAddr;
begin
  HostEnt := gethostbyname(PAnsiChar(AnsiString(Name)));
  FillChar(InAddr, SizeOf(InAddr), 0);
  if HostEnt <> nil then
  begin
    with InAddr, HostEnt^ do
    begin
      {$IFDEF Linux}
      s_bytes[1] := Byte(h_name[0]);
      s_bytes[2] := Byte(h_name[1]);
      s_bytes[3] := Byte(h_name[2]);
      s_bytes[4] := Byte(h_name[3]);
      {$ELSE}
      S_un_b.s_b1 := h_addr^[0];
      S_un_b.s_b2 := h_addr^[1];
      S_un_b.s_b3 := h_addr^[2];
      S_un_b.s_b4 := h_addr^[3];
      {$ENDIF}
    end;
  end;
  Result := InAddr;
end;

function TCustomWinSocket.LookupService(const Service: string): Integer;
var
  ServEnt: PServEnt;
begin
  ServEnt := getservbyname(PAnsiChar(AnsiString(Service)), 'tcp');
  if ServEnt <> nil then
    Result := ntohs(ServEnt.s_port)
  else Result := 0;
end;

procedure TCustomWinSocket.Connect(Socket: TSocket);
begin
end;

procedure TCustomWinSocket.Accept(Socket: TSocket);
begin
end;

function TCustomWinSocket.ReceiveLength: Integer;
begin
  Result := ReceiveBuf(Pointer(nil)^, -1);
end;

function TCustomWinSocket.ReceiveBuf(var Buf; Count: Integer): Integer;
var
  ErrorCode, iCount: Integer;
begin
  Lock;
  try
    Result := 0;
    if (Count = -1) and FConnected then
      ioctlsocket(FSocket, FIONREAD, Longint(Result))
    else begin
      if not FConnected then Exit;
      if ioctlsocket(FSocket, FIONREAD, iCount) = 0 then
      begin
        if (iCount > 0) and (iCount < Count) then
          Count := iCount;
      end;

      Result := fprecv(FSocket, @Buf, Count, 0);
      if Result = SOCKET_ERROR then
      begin
        ErrorCode := socketerror;
        Error(Self, eeReceive, ErrorCode);
        Disconnect(FSocket);
        if ErrorCode <> 0 then
          raise Exception.CreateResFmt(@sWindowsSocketError, [SysErrorMessage(ErrorCode), ErrorCode, 'recv']);
      end;
    end;
  finally
    Unlock;
  end;
end;

function TCustomWinSocket.ReceiveText: AnsiString;
begin
  SetLength(Result, ReceiveBuf(Pointer(nil)^, -1));
end;

function TCustomWinSocket.SendBuf(var Buf; Count: Integer): Integer;
var
  ErrorCode: Integer;
begin
  Lock;
  try
    Result := 0;
    if not FConnected then Exit;
    Result := fpsend(FSocket, @Buf, Count, 0);
    if Result = SOCKET_ERROR then
    begin
      ErrorCode := socketerror;
      begin
        Error(Self, eeSend, ErrorCode);
        Disconnect(FSocket);
        if ErrorCode <> 0 then
          raise Exception.CreateResFmt(@sWindowsSocketError,
            [SysErrorMessage(ErrorCode), ErrorCode, 'send']);
      end;
    end;
  finally
    Unlock;
  end;
end;

function TCustomWinSocket.SendStream(AStream: TStream): Boolean;
begin
  Result := False;
  if FSendStream = nil then
  begin
    FSendStream := AStream;
    Result := SendStreamPiece;
  end;
end;

function TCustomWinSocket.SendStreamThenDrop(AStream: TStream): Boolean;
begin
  FDropAfterSend := True;
  Result := SendStream(AStream);
  if not Result then FDropAfterSend := False;
end;

function TCustomWinSocket.SendText(const s: AnsiString): Integer;
begin
  Result := SendBuf(Pointer(S)^, Length(S) * SizeOf(AnsiChar));
end;

{ TClientWinSocket }

procedure TClientWinSocket.SetClientType(Value: TClientType);
begin
  if Value <> FClientType then
    if not FConnected then
    begin
      FClientType := Value;
      if FClientType = ctBlocking then
        ASyncStyles := []
      else ASyncStyles := [asRead, asWrite, asConnect, asClose];
    end else raise Exception.CreateRes(@sCantChangeWhileActive);
end;

procedure TClientWinSocket.Connect(Socket: TSocket);
begin
  FConnected := True;
  Event(Self, seConnect);
end;

{ TServerClientWinsocket }

constructor TServerClientWinSocket.Create(Socket: TSocket; ServerWinSocket: TServerWinSocket);
begin
  FServerWinSocket := ServerWinSocket;
  if Assigned(FServerWinSocket) then
  begin
    FServerWinSocket.AddClient(Self);
    if FServerWinSocket.AsyncStyles <> [] then
    begin
      OnSocketEvent := FServerWinSocket.ClientEvent;
      OnErrorEvent := FServerWinSocket.ClientError;
    end;
  end;
  inherited Create(Socket);
  if FServerWinSocket.ASyncStyles <> [] then DoSetAsyncStyles;
  if FConnected then Event(Self, seConnect);
end;

destructor TServerClientWinSocket.Destroy;
begin
  if Assigned(FServerWinSocket) then
    FServerWinSocket.RemoveClient(Self);
  inherited Destroy;
end;

{ TServerWinSocket }

constructor TServerWinSocket.Create(ASocket: TSocket);
begin
  FConnections := TList.Create;
  FActiveThreads := TList.Create;
  FListLock := TCriticalSection.Create;
  inherited Create(ASocket);
  FAsyncStyles := [asAccept];
end;

destructor TServerWinSocket.Destroy;
begin
  inherited Destroy;
  FConnections.Free;
  FActiveThreads.Free;
  FListLock.Free;
end;

procedure TServerWinSocket.AddClient(AClient: TServerClientWinSocket);
begin
  FListLock.Enter;
  try
    if FConnections.IndexOf(AClient) < 0 then
      FConnections.Add(AClient);
  finally
    FListLock.Leave;
  end;
end;

procedure TServerWinSocket.RemoveClient(AClient: TServerClientWinSocket);
begin
  FListLock.Enter;
  try
    FConnections.Remove(AClient);
  finally
    FListLock.Leave;
  end;
end;

procedure TServerWinSocket.AddThread(AThread: TServerClientThread);
begin
  FListLock.Enter;
  try
    if FActiveThreads.IndexOf(AThread) < 0 then
    begin
      FActiveThreads.Add(AThread);
      if FActiveThreads.Count <= FThreadCacheSize then
        AThread.KeepInCache := True;
    end;
  finally
    FListLock.Leave;
  end;
end;

procedure TServerWinSocket.RemoveThread(AThread: TServerClientThread);
begin
  FListLock.Enter;
  try
    FActiveThreads.Remove(AThread);
  finally
    FListLock.Leave;
  end;
end;

procedure TServerWinSocket.ClientEvent(Sender: TObject; Socket: TCustomWinSocket; SocketEvent: TSocketEvent);
begin
  case SocketEvent of
    seAccept,
    seLookup,
    seConnecting,
    seListen:
      begin end;
    seConnect: ClientConnect(Socket);
    seDisconnect: ClientDisconnect(Socket);
    seRead: ClientRead(Socket);
    seWrite: ClientWrite(Socket);
  end;
end;

procedure TServerWinSocket.ClientError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  ClientErrorEvent(Socket, ErrorEvent, ErrorCode);
end;

function TServerWinSocket.GetActiveConnections: Integer;
begin
  Result := FConnections.Count;
end;

function TServerWinSocket.GetConnections(Index: Integer): TCustomWinSocket;
begin
  Result := FConnections[Index];
end;

function TServerWinSocket.GetActiveThreads: Integer;
var
  I: Integer;
begin
  FListLock.Enter;
  try
    Result := 0;
    for I := 0 to FActiveThreads.Count - 1 do
      if TServerClientThread(FActiveThreads[I]).ClientSocket <> nil then
        Inc(Result);
  finally
    FListLock.Leave;
  end;
end;

function TServerWinSocket.GetIdleThreads: Integer;
var
  I: Integer;
begin
  FListLock.Enter;
  try
    Result := 0;
    for I := 0 to FActiveThreads.Count - 1 do
      if TServerClientThread(FActiveThreads[I]).ClientSocket = nil then
        Inc(Result);
  finally
    FListLock.Leave;
  end;
end;

procedure TServerWinSocket.Listen(var Name, Address, Service: string; Port: Word; QueueSize: Integer);
begin
  inherited Listen(Name, Address, Service, Port, QueueSize, ServerType = stThreadBlocking);
  if FConnected and (ServerType = stThreadBlocking) then
    FServerAcceptThread := TServerAcceptThread.Create(False, Self);
end;

procedure TServerWinSocket.SetServerType(Value: TServerType);
begin
  if Value <> FServerType then
    if not FConnected then
    begin
      FServerType := Value;
      if FServerType = stThreadBlocking then
        ASyncStyles := []
      else ASyncStyles := [asAccept];
    end else raise Exception.CreateRes(@sCantChangeWhileActive);
end;

function TServerWinSocket.DoCreateThread(ClientSocket: TServerClientWinSocket): TServerClientThread;
begin
  Result := TServerClientThread.Create(False, ClientSocket);
end;

procedure TServerWinSocket.SetThreadCacheSize(Value: Integer);
var
  LStart, I: Integer;
begin
  if Value <> FThreadCacheSize then
  begin
    if Value < FThreadCacheSize then
      LStart := Value
    else LStart := FThreadCacheSize;
    FThreadCacheSize := Value;
    FListLock.Enter;
    try
      for I := 0 to FActiveThreads.Count - 1 do
        with TServerClientThread(FActiveThreads[I]) do
          KeepInCache := I < LStart;
    finally
      FListLock.Leave;
    end;
  end;
end;

procedure TServerWinSocket.ThreadStart(AThread: TServerClientThread);
begin
  if Assigned(FOnThreadStart) then FOnThreadStart(Self, AThread);
end;

procedure TServerWinSocket.ThreadEnd(AThread: TServerClientThread);
begin
  if Assigned(FOnThreadEnd) then FOnThreadEnd(Self, AThread);
end;

function TServerWinSocket.GetServerThread(ClientSocket: TServerClientWinSocket): TServerClientThread;
var
  I: Integer;
begin
  Result := nil;
  FListLock.Enter;
  try
    for I := 0 to FActiveThreads.Count - 1 do
      if TServerClientThread(FActiveThreads[I]).ClientSocket = nil then
      begin
        Result := FActiveThreads[I];
        Result.ReActivate(ClientSocket);
        Break;
      end;
  finally
    FListLock.Leave;
  end;
  if Result = nil then
  begin
    if Assigned(FOnGetThread) then FOnGetThread(Self, ClientSocket, Result);
    if Result = nil then Result := DoCreateThread(ClientSocket);
  end;
end;

function TServerWinSocket.GetClientSocket(Socket: TSocket): TServerClientWinSocket;
begin
  Result := nil;
  if Assigned(FOnGetSocket) then FOnGetSocket(Self, Socket, Result);
  if Result = nil then
    Result := TServerClientWinSocket.Create(Socket, Self);
end;

procedure TServerWinSocket.ClientConnect(Socket: TCustomWinSocket);
begin
  if Assigned(FOnClientConnect) then FOnClientConnect(Self, Socket);
end;

procedure TServerWinSocket.ClientDisconnect(Socket: TCustomWinSocket);
begin
  if Assigned(FOnClientDisconnect) then FOnClientDisconnect(Self, Socket);
end;

procedure TServerWinSocket.ClientRead(Socket: TCustomWinSocket);
begin
  if Assigned(FOnClientRead) then FOnClientRead(Self, Socket);
end;

procedure TServerWinSocket.ClientWrite(Socket: TCustomWinSocket);
begin
  if Assigned(FOnClientWrite) then FOnClientWrite(Self, Socket);
end;

procedure TServerWinSocket.ClientErrorEvent(Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  if Assigned(FOnClientError) then FOnClientError(Self, Socket, ErrorEvent, ErrorCode);
end;

procedure TServerWinSocket.Accept(Socket: TSocket);
var
  ClientSocket: TServerClientWinSocket;
  ClientWinSocket: TSocket;
  Addr: TSockAddrIn;
  Len: Integer;
begin
  Len := SizeOf(Addr);
  ClientWinSocket := fpaccept(Socket, @Addr, @Len);
  if ClientWinSocket <> INVALID_SOCKET then
  begin
    ClientSocket := GetClientSocket(ClientWinSocket);
    if Assigned(FOnSocketEvent) then
      FOnSocketEvent(Self, ClientSocket, seAccept);
    if FServerType = stThreadBlocking then
    begin
      ClientSocket.ASyncStyles := [];
      try
        GetServerThread(ClientSocket);
      except
        on E: Exception do
        begin
          if not (E is EAbort) then
            raise;
        end;
      end;
    end;
  end;
end;

procedure TServerWinSocket.Disconnect(Socket: TSocket);
var
  SaveCacheSize: Integer;
begin
  Lock;
  try
    SaveCacheSize := ThreadCacheSize;
    try
      ThreadCacheSize := 0;
      while FActiveThreads.Count > 0 do
        with TServerClientThread(FActiveThreads.Last) do
        begin
          FreeOnTerminate := False;
          Terminate;
          FEvent.SetEvent;
          if (ClientSocket <> nil) and ClientSocket.Connected then
            ClientSocket.Close;
          WaitFor;
          Free;
        end;
      while FConnections.Count > 0 do
        TCustomWinSocket(FConnections.Last).Free;
      if FServerAcceptThread <> nil then
        FServerAcceptThread.Terminate;
      fpshutdown(Socket, SHUT_RDWR);
      inherited Disconnect(Socket);
      FServerAcceptThread.Free;
      FServerAcceptThread := nil;
    finally
      ThreadCacheSize := SaveCacheSize;
    end;
  finally
    Unlock;
  end;
end;

function TServerWinSocket.GetClientThread(ClientSocket: TServerClientWinSocket): TServerClientThread;
var
  I: Integer;
begin
  Result := nil;
  FListLock.Enter;
  try
    for I := 0 to FActiveThreads.Count - 1 do
      if TServerClientThread(FActiveThreads[I]).ClientSocket = ClientSocket then
      begin
        Result := FActiveThreads[I];
        Break;
      end;
  finally
    FListLock.Leave;
  end;
end;

{ TServerAcceptThread }

constructor TServerAcceptThread.Create(CreateSuspended: Boolean; ASocket: TServerWinSocket);
begin
  FServerSocket := ASocket;
  inherited Create(CreateSuspended);
end;

procedure TServerAcceptThread.Execute;
begin
  while not Terminated do
    FServerSocket.Accept(FServerSocket.SocketHandle);
end;

{ TServerClientThread }

constructor TServerClientThread.Create(CreateSuspended: Boolean; ASocket: TServerClientWinSocket);
begin
  FreeOnTerminate := True;
  FEvent := TSimpleEvent.Create;
  inherited Create(True);
  Priority := tpHigher;
  ReActivate(ASocket);
  if not CreateSuspended then Resume;
end;

destructor TServerClientThread.Destroy;
begin
  FClientSocket.Free;
  FEvent.Free;
  inherited Destroy;
end;

procedure TServerClientThread.HandleEvent(Sender: TObject; Socket: TCustomWinSocket; SocketEvent: TSocketEvent);
begin
  Event(SocketEvent);
end;

procedure TServerClientThread.HandleError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  Error(ErrorEvent, ErrorCode);
end;

procedure TServerClientThread.DoHandleException;
begin
  if GetCapture <> 0 then SendMessage(GetCapture, WM_CANCELMODE, 0, 0);
  if FException is Exception then
  begin
    if Assigned(ApplicationShowException) then
      ApplicationShowException(FException);
  end else
    SysUtils.ShowException(FException, nil);
end;

procedure TServerClientThread.DoRead;
begin
  ClientSocket.ServerWinSocket.Event(ClientSocket, seRead);
end;

procedure TServerClientThread.DoWrite;
begin
  FServerSocket.Event(ClientSocket, seWrite);
end;

procedure TServerClientThread.ReActivate(ASocket: TServerClientWinSocket);
begin
  FClientSocket := ASocket;
  if Assigned(FClientSocket) then
  begin
    FServerSocket := FClientSocket.ServerWinSocket;
    FServerSocket.AddThread(Self);
    FClientSocket.OnSocketEvent := HandleEvent;
    FClientSocket.OnErrorEvent := HandleError;
    FEvent.SetEvent;
  end;
end;

function TServerClientThread.StartConnect: Boolean;
begin
  if FEvent.WaitFor(INFINITE) = wrSignaled then
    FEvent.ResetEvent;
  Result := not Terminated;
end;

function TServerClientThread.EndConnect: Boolean;
begin
  FClientSocket.Free;
  FClientSocket := nil;
  Result := Terminated or not KeepInCache;
end;

procedure TServerClientThread.DoTerminate;
begin
  inherited DoTerminate;
  if Assigned(FServerSocket) then
    FServerSocket.RemoveThread(Self);
end;

procedure TServerClientThread.Execute;
begin
  FServerSocket.ThreadStart(Self);
  try
    try
      while True do
      begin
        if StartConnect then ClientExecute;
        if EndConnect then Break;
      end;
    except
      HandleException;
      KeepInCache := False;
    end;
  finally
    FServerSocket.ThreadEnd(Self);
  end;
end;

procedure TServerClientThread.ClientExecute;
var
  FDSet: TFDSet;
  TimeVal: TTimeVal;
begin
  while not Terminated and ClientSocket.Connected do
  begin
    FD_ZERO(FDSet);
    FD_SET(ClientSocket.SocketHandle, FDSet);
    TimeVal.tv_sec := 0;
    TimeVal.tv_usec := 500;
    if (select(0, @FDSet, nil, nil, @TimeVal) > 0) and not Terminated then
      if ClientSocket.ReceiveBuf(FDSet, -1) = 0 then Break
      else Synchronize(DoRead);
    if (select(0, nil, @FDSet, nil, @TimeVal) > 0) and not Terminated then
      Synchronize(DoWrite);
  end;
end;

procedure TServerClientThread.Event(SocketEvent: TSocketEvent);
begin
  FServerSocket.ClientEvent(Self, ClientSocket, SocketEvent);
end;

procedure TServerClientThread.Error(ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  FServerSocket.ClientError(Self, ClientSocket, ErrorEvent, ErrorCode);
end;

procedure TServerClientThread.HandleException;
begin
  FException := Exception(ExceptObject);
  try
    if not (FException is EAbort) then
      Synchronize(DoHandleException);
  finally
    FException := nil;
  end;
end;

{ TAbstractSocket }

procedure TAbstractSocket.DoEvent(Sender: TObject; Socket: TCustomWinSocket; SocketEvent: TSocketEvent);
begin
  Event(Socket, SocketEvent);
end;

procedure TAbstractSocket.DoError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  Error(Socket, ErrorEvent, ErrorCode);
end;

procedure TAbstractSocket.InitSocket(Socket: TCustomWinSocket);
begin
  Socket.OnSocketEvent := DoEvent;
  Socket.OnErrorEvent := DoError;
end;

procedure TAbstractSocket.SetActive(Value: Boolean);
begin
  if Value <> FActive then
  begin
    if (csDesigning in ComponentState) or (csLoading in ComponentState) then
      FActive := Value;
    if not (csLoading in ComponentState) then
      DoActivate(Value);
  end;
end;

procedure TAbstractSocket.Loaded;
begin
  inherited Loaded;
  DoActivate(FActive);
end;

procedure TAbstractSocket.SetHost(Value: string);
begin
  if CompareText(Value, FHost) <> 0 then
  begin
    if not (csLoading in ComponentState) and FActive then
      raise Exception.CreateRes(@sCantChangeWhileActive);
    FHost := Value;
  end;
end;

procedure TAbstractSocket.SetPort(Value: Integer);
begin
  if FPort <> Value then
  begin
    if not (csLoading in ComponentState) and FActive then
      raise Exception.CreateRes(@sCantChangeWhileActive);
    FPort := Value;
  end;
end;

procedure TAbstractSocket.SetService(Value: string);
begin
  if CompareText(Value, FService) <> 0 then
  begin
    if not (csLoading in ComponentState) and FActive then
      raise Exception.CreateRes(@sCantChangeWhileActive);
    FService := Value;
  end;
end;

procedure TAbstractSocket.SetAddress(Value: string);
begin
  if CompareText(Value, FAddress) <> 0 then
  begin
    if not (csLoading in ComponentState) and FActive then
      raise Exception.CreateRes(@sCantChangeWhileActive);
    FAddress := Value;
  end;
end;

procedure TAbstractSocket.Open;
begin
  Active := True;
end;

procedure TAbstractSocket.Close;
begin
  Active := False;
end;

{ TCustomSocket }

procedure TCustomSocket.Event(Socket: TCustomWinSocket; SocketEvent: TSocketEvent);
begin
  case SocketEvent of
    seLookup: if Assigned(FOnLookup) then FOnLookup(Self, Socket);
    seConnecting: if Assigned(FOnConnecting) then FOnConnecting(Self, Socket);
    seConnect:
      begin
        FActive := True;
        if Assigned(FOnConnect) then FOnConnect(Self, Socket);
      end;
    seListen:
      begin
        FActive := True;
        if Assigned(FOnListen) then FOnListen(Self, Socket);
      end;
    seDisconnect:
      begin
        FActive := False;
        if Assigned(FOnDisconnect) then FOnDisconnect(Self, Socket);
      end;
    seAccept: if Assigned(FOnAccept) then FOnAccept(Self, Socket);
    seRead: if Assigned(FOnRead) then FOnRead(Self, Socket);
    seWrite: if Assigned(FOnWrite) then FOnWrite(Self, Socket);
  end;
end;

procedure TCustomSocket.Error(Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  if Assigned(FOnError) then FOnError(Self, Socket, ErrorEvent, ErrorCode);
end;

{ TClientSocket }

constructor TClientSocket.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FClientSocket := TClientWinSocket.Create(INVALID_SOCKET);
  InitSocket(FClientSocket);
end;

destructor TClientSocket.Destroy;
begin
  FClientSocket.Free;
  inherited Destroy;
end;

procedure TClientSocket.DoActivate(Value: Boolean);
begin
  if (Value <> FClientSocket.Connected) and not (csDesigning in ComponentState) then
  begin
    if FClientSocket.Connected then
      FClientSocket.Disconnect(FClientSocket.FSocket)
    else FClientSocket.Open(FHost, FAddress, FService, FPort, ClientType = ctBlocking);
  end;
end;

function TClientSocket.GetClientType: TClientType;
begin
  Result := FClientSocket.ClientType;
end;

procedure TClientSocket.SetClientType(Value: TClientType);
begin
  FClientSocket.ClientType := Value;
end;

{ TCustomServerSocket }

destructor TCustomServerSocket.Destroy;
begin
  FServerSocket.Free;
  inherited Destroy;
end;

procedure TCustomServerSocket.DoActivate(Value: Boolean);
begin
  if (Value <> FServerSocket.Connected) and not (csDesigning in ComponentState) then
  begin
    if FServerSocket.Connected then
      FServerSocket.Disconnect(FServerSocket.SocketHandle)
    else FServerSocket.Listen(FHost, FAddress, FService, FPort, SOMAXCONN);
  end;
end;

function TCustomServerSocket.GetServerType: TServerType;
begin
  Result := FServerSocket.ServerType;
end;

procedure TCustomServerSocket.SetServerType(Value: TServerType);
begin
  FServerSocket.ServerType := Value;
end;

function TCustomServerSocket.GetGetThreadEvent: TGetThreadEvent;
begin
  Result := FServerSocket.OnGetThread;
end;

procedure TCustomServerSocket.SetGetThreadEvent(Value: TGetThreadEvent);
begin
  FServerSocket.OnGetThread := Value;
end;

function TCustomServerSocket.GetGetSocketEvent: TGetSocketEvent;
begin
  Result := FServerSocket.OnGetSocket;
end;

procedure TCustomServerSocket.SetGetSocketEvent(Value: TGetSocketEvent);
begin
  FServerSocket.OnGetSocket := Value;
end;

function TCustomServerSocket.GetThreadCacheSize: Integer;
begin
  Result := FServerSocket.ThreadCacheSize;
end;

procedure TCustomServerSocket.SetThreadCacheSize(Value: Integer);
begin
  FServerSocket.ThreadCacheSize := Value;
end;

function TCustomServerSocket.GetOnThreadStart: TThreadNotifyEvent;
begin
  Result := FServerSocket.OnThreadStart;
end;

function TCustomServerSocket.GetOnThreadEnd: TThreadNotifyEvent;
begin
  Result := FServerSocket.OnThreadEnd;
end;

procedure TCustomServerSocket.SetOnThreadStart(Value: TThreadNotifyEvent);
begin
  FServerSocket.OnThreadStart := Value;
end;

procedure TCustomServerSocket.SetOnThreadEnd(Value: TThreadNotifyEvent);
begin
  FServerSocket.OnThreadEnd := Value;
end;

function TCustomServerSocket.GetOnClientEvent(Index: Integer): TSocketNotifyEvent;
begin
  case Index of
    0: Result := FServerSocket.OnClientRead;
    1: Result := FServerSocket.OnClientWrite;
    2: Result := FServerSocket.OnClientConnect;
    3: Result := FServerSocket.OnClientDisconnect;
  end;
end;

procedure TCustomServerSocket.SetOnClientEvent(Index: Integer; Value: TSocketNotifyEvent);
begin
  case Index of
    0: FServerSocket.OnClientRead := Value;
    1: FServerSocket.OnClientWrite := Value;
    2: FServerSocket.OnClientConnect := Value;
    3: FServerSocket.OnClientDisconnect := Value;
  end;
end;

function TCustomServerSocket.GetOnClientError: TSocketErrorEvent;
begin
  Result := FServerSocket.OnClientError;
end;

procedure TCustomServerSocket.SetOnClientError(Value: TSocketErrorEvent);
begin
  FServerSocket.OnClientError := Value;
end;

{ TServerSocket }

constructor TServerSocket.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FServerSocket := TServerWinSocket.Create(INVALID_SOCKET);
  InitSocket(FServerSocket);
  FServerSocket.ThreadCacheSize := 10;
end;

end.
