unit LazHelperCS;
interface
{$I frx.inc}
uses
 {$IFDEF Linux}
  BaseUnix, termio,
 {$ENDIF}
  LCLType, Messages, Sockets, LResources, Dialogs, LMessages;

{$IFDEF Linux}
const
  INVALID_SOCKET     = TSocket(NOT(0));
  SOCKET_ERROR       = -1;
  FIONBIO            = termio.FIONBIO;

  MAXGETHOSTSTRUCT = 1024;

  FD_READ = $01;
  FD_WRITE = $02;
  FD_ACCEPT = $08;
  FD_CONNECT = $10;
  FD_CLOSE = $20;

  SO_OPENTYPE = $7008;
  SO_SYNCHRONOUS_ALERT = $10;
  SO_SYNCHRONOUS_NONALERT = $20;

type
  TSockAddrIn = TSockAddr;
  TDWordFiller = Integer;

function Socket(af, Struc, Protocol: Integer): TSocket;
function Select(nfds: Integer; readfds, writefds, exceptfds: PFDSet; timeout: PTimeVal): Longint;
function IoctlSocket(s: TSocket; cmd: DWORD; var arg: integer): Integer;
function inet_addr(cp:pchar):cardinal;
function inet_ntoa(i : TInAddr): AnsiString;
function getpeername( const s: TSocket; var name: TSockAddr; var namelen: Longint ): Longint;
function FD_ZERO(out nset : TFDSet):cint;
function FD_SET(fdno:cint;var nset : TFDSet): cint;
function FD_ISSET (fdno:cint;const nset : TFDSet): Boolean;
function setsockopt(s:cint; level:cint; optname:cint; optval:pointer; optlen : tsocklen):cint;
function getsockopt(s:cint; level:cint; optname:cint; optval:pointer; optlen : tsocklen):cint;
{$ENDIF}

implementation

uses
  frxUtils;

{$IFDEF Linux}
function Socket(af, Struc, Protocol: Integer): TSocket;
begin
  Result := fpSocket(af, struc, protocol);
end;

function Select(nfds: Integer; readfds, writefds, exceptfds: PFDSet;timeout: PTimeVal): Longint;
begin
  Result := fpSelect(nfds, readfds, writefds, exceptfds, timeout);
end;

function IoctlSocket(s: TSocket; cmd: DWORD; var arg: integer): Integer;
begin
  Result := fpIoctl(s, cmd, @arg);
end;

function inet_addr(cp:pchar):cardinal;
begin
  Result := StrToNetAddr(cp).s_addr;
end;

function inet_ntoa(i : TInAddr): AnsiString;
begin
  Result := NetAddrToStr(i);
end;

function getpeername( const s: TSocket; var name: TSockAddr; var namelen: Longint ): Longint;
begin
  Result := fpgetpeername(s, @name, @namelen);
end;

function FD_ZERO(out nset : TFDSet):cint;
begin
  Result := fpFD_ZERO(nset);
end;

function FD_SET(fdno:cint;var nset : TFDSet): cint;
begin
  Result := fpFD_SET(fdno, nset);
end;

function FD_ISSET (fdno:cint;const nset : TFDSet): Boolean;
begin
  Result := Boolean(fpFD_ISSET(fdno, nset));
end;

function setsockopt(s:cint; level:cint; optname:cint; optval:pointer; optlen : tsocklen):cint;
begin
  Result := fpsetsockopt(s, level, optname, optval, optlen);
end;

function getsockopt(s:cint; level:cint; optname:cint; optval:pointer; optlen : tsocklen):cint;
begin
  Result := fpgetsockopt(s, level, optname, optval, @optlen);
end;

{$ENDIF}

end.
