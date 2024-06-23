{******************************************}
{                                          }
{             FastReport VCL               }
{             LCLGTK2 Mutex                }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxMutex_Linux;

interface

uses
  Classes, Unix, pthreads;

var
  SemList: TList;
  GlobMut: pthread_mutex_t;

type

{ TfrxSemafor }

  TfrxSemafor = class
  private
    FMut: pthread_mutex_t;
    FKey: String;
    FCount: Integer;
  public
    constructor Create(skey: String);
    destructor Destroy; override;
    procedure Lock;
    procedure Unlock;

    property Key: String read FKey write FKey;
    property Count: Integer read FCount write FCount;
  end;

  function CreatefrxSemafor(skey: String): TfrxSemafor;
  procedure FreefrxSemafor(var sem: TfrxSemafor);
  function FindInSemList(skey: String): Integer;

implementation

function CreatefrxSemafor(skey: String): TfrxSemafor;
var
  i: Integer;
begin
  pthread_mutex_lock(@GlobMut);
  i := FindInSemList(skey);
  if (i <> -1) then
  begin
    Result := TfrxSemafor(SemList.Items[i]);
    Result.Count := Result.Count + 1;
  end
  else
  begin
    Result := TfrxSemafor.Create(skey);
    SemList.Add(Result);
  end;
  pthread_mutex_unlock(@GlobMut);
end;

procedure FreefrxSemafor(var sem: TfrxSemafor);
begin
  pthread_mutex_lock(@GlobMut);
  sem.Count := sem.Count - 1;
  if (sem.Count = 0) then
  begin
    sem.Free;
    SemList.Delete(FindInSemList(sem.Key));
  end;
  sem := nil;
  pthread_mutex_unlock(@GlobMut);
end;

function FindInSemList(skey: String): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to SemList.Count - 1 do
    if (TfrxSemafor(SemList.Items[i]).Key = skey) then
    begin
      Result := i;
      break;
    end;
end;

constructor TfrxSemafor.Create(skey: String);
begin
  pthread_mutex_init(@FMut, nil);
  FCount := 1;
  FKey := skey;
end;

destructor TfrxSemafor.Destroy;
begin
  pthread_mutex_destroy(@FMut);
  inherited;
end;

procedure TfrxSemafor.Lock;
begin
  pthread_mutex_lock(@FMut);
end;

procedure TfrxSemafor.Unlock;
begin
  pthread_mutex_unlock(@FMut);
end;

initialization
  pthread_mutex_init(@GlobMut, nil);
  SemList := TList.Create;

finalization
  pthread_mutex_destroy(@GlobMut);
  SemList.Free;
end.
