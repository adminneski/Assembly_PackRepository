{******************************************}
{                                          }
{             FastReport VCL               }
{             support Mutex                }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxMutex;

{$I frx.inc}

interface

uses
{$IFNDEF Linux}
  Windows
{$ELSE}
  frxMutex_Linux
{$ENDIF}
  , frCore;
type
  TfrxMutex = class
  private
  {$IFNDEF Linux}
    crit: TfrHandle;
  {$ELSE}
    Sem: TfrxSemafor;
  {$ENDIF}
  public
    constructor Create(skey: String);
    destructor Destroy; override;
    procedure Lock;
    procedure Unlock;
  end;

implementation

constructor TfrxMutex.Create(skey: String);
begin
{$IFNDEF Linux}
  crit := CreateMutex(nil, True, PChar(skey));
{$ELSE}
  Sem := CreatefrxSemafor(skey);
{$ENDIF}
end;

destructor TfrxMutex.Destroy;
begin
{$IFNDEF Linux}
  CloseHandle(crit);
{$ELSE}
  FreefrxSemafor(Sem);
{$ENDIF}
  inherited;
end;

procedure TfrxMutex.Lock;
begin
{$IFNDEF Linux}
  WaitForSingleObject(crit, INFINITE);
{$ELSE}
  Sem.Lock;
{$ENDIF}
end;

procedure TfrxMutex.Unlock;
begin
{$IFNDEF Linux}
  ReleaseMutex(crit);
{$ELSE}
  Sem.Unlock();
{$ENDIF}
end;

end.
