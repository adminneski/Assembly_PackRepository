
{******************************************}
{                                          }
{             FastReport VCL               }
{            File utilities unit           }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxFileUtils;

interface

{$I frx.inc}

uses
  {$IFNDEF FPC}Windows, Messages,{$ENDIF}
  SysUtils, Classes
  {$IFDEF FPC}, LazFileUtils, FileUtil, lazhelper{$ENDIF}
  {$IFNDEF NONWINFPC}, ShlObj, FileCtrl, Registry{$ENDIF};


function frxExpandRelativePath(const Path: string): string;
function GetFileSize(const FileName: String): Longint;
function StreamSearch(Strm: TStream; const StartPos: Longint; const Value: AnsiString): Longint;
{$IFNDEF FPC}
function BrowseDialog(const Path:String; const Title: string = ''): string;
{$ENDIF}
procedure DeleteFolder(const DirName: String);
{$IFNDEF DELPHI6}
function DirectoryExists(const Name: string): Boolean;
{$ENDIF}
function GetFileMIMEType(const Extension: String): String;

implementation

{$IFNDEF DELPHI6}
function DirectoryExists(const Name: string): Boolean;
var
  Code: Integer;
begin
  Code := GetFileAttributes(PChar(Name));
  Result := (Code <> -1) and (FILE_ATTRIBUTE_DIRECTORY and Code <> 0);
end;
{$ENDIF}

function frxExpandRelativePath(const Path: string): string;
{$IFNDEF FPC}
var
  I, CurPos, Len: Integer;
  PosList: TList;
begin
  Result := Path;
  Len := Length(Result);
  PosList := TList.Create;
  try
  { only full path allowed }
    if (Len < 3) or ((Result[2] <> ':') and (Result[3] <> PathDelim)) then Exit;
    I := 3;
    CurPos := 3;
    while I <= Len do
    begin
      Result[CurPos] := Path[I];
      if Path[i] = PathDelim then
        PosList.Add(Pointer(CurPos));
      if (Path[i] = '.') and (Path[i - 1] = PathDelim ) then
      begin
         if (i + 1 <= Len) and (Path[i + 1] = PathDelim) then
          Inc(i, 1)
         else if (i + 2 <= Len) and (Path[i + 1] = '.') and (Path[i + 2] = PathDelim) then
         begin
          Inc(i, 2);
          if PosList.Count > 1 then
          begin
            PosList.Delete(PosList.Count - 1);
            CurPos := Integer(PosList[PosList.Count - 1]);
          end;
         end;
      end;
      Inc(I);
      Inc(CurPos);
    end;
    SetLength(Result, CurPos - 1);
  finally
    FreeAndNil(PosList);
  end;
end;
{$ELSE}
begin
  Result := ExpandFileName(Path);
end;
{$ENDIF}

function GetFileSize(const FileName: String): Longint;
var
  SRec: TSearchRec;
begin
  FindFirst(FileName, faAnyFile, SRec);
  Result := SRec.Size;
  FindClose(SRec);
end;

function StreamSearch(Strm: TStream; const StartPos: Longint; const Value: AnsiString): Longint;
var
  i, oldpos: Longint;
  s1: AnsiString;
  Stream: TMemoryStream;
begin
  Result := -1;
  try
    Stream := TMemoryStream.Create;
    oldpos := Strm.Position;
    try
      Strm.Position := 0;
      Stream.CopyFrom(Strm, 0);
      SetLength(s1, 1);
      i := 1;
      Stream.Position := StartPos;
      while (Stream.Position < Stream.Size) do
      begin
        while ((Stream.Position < Stream.Size) and (Length(Value) > (i - 1))) do
        begin
          Stream.Read(s1[1], 1);
          if (s1[1] = Value[i]) then
            inc(i)
          else
            break;
        end;
        if Length(Value) = (i - 1) then
        begin
          Result := Stream.Position - i + 1;
          break;
        end else
        begin
          if (i > 1) and (Stream.Position > 0) then
            Stream.Position := Stream.Position - 1;
          i := 1;
        end;
      end;
    finally
      Stream.Free;
    end;
    Strm.Position := oldpos;
  except
  end;
end;

{$IFNDEF FPC}
function BrowseCallbackProc(hwnd: HWND; uMsg: UINT; lParam: LPARAM; lpData: LPARAM):integer; stdcall;
begin
  if  uMsg = BFFM_INITIALIZED then
    if lpData <> 0 then
      SendMessage(hwnd, BFFM_SETSELECTION, 1, lpData);
  Result := 0;
end;

function BrowseDialog(const Path: String; const Title: String = ''): string;
var
  lpItemID : PItemIDList;
  bi : TBrowseInfo;
  DisplayName : array[0..MAX_PATH] of char;
  TempPath : array[0..MAX_PATH] of char;
begin
  Result := Path;
  FillChar(bi, sizeof(TBrowseInfo), #0);
  bi.hwndOwner := GetActiveWindow;
  bi.pszDisplayName := @DisplayName;
  bi.lpszTitle := PChar(Title);
  bi.ulFlags := BIF_RETURNONLYFSDIRS + $0040;
  bi.lpfn := BrowseCallbackProc;
  bi.lParam := LPARAM(PChar(Path));
  lpItemID := SHBrowseForFolder(bi);
  if lpItemId <> nil then
  begin
    SHGetPathFromIDList(lpItemID, TempPath);
    Result := TempPath;
    GlobalFreePtr(lpItemID);
  end;
  if Result[Length(Result)] <> '\' then
    Result := Result + '\';
end;
{$ENDIF}
{$WARNINGS OFF}
procedure DeleteFolder(const DirName: String);
{$IFNDEF FPC}
var
  SearchRec: TSearchRec;
  i: Integer;
begin
  if DirectoryExists(DirName) then
  begin
    i := FindFirst(DirName + '\*.*', faAnyFile, SearchRec);
    while i = 0 do
    begin
      if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
      begin
        if (SearchRec.Attr and faDirectory) > 0 then
          DeleteFolder(DirName + '\' + SearchRec.Name)
        else if (SearchRec.Attr and faVolumeID) = 0 then
        try
          DeleteFile(PChar(DirName + '\' + SearchRec.Name));
        except
        end;
      end;
      i := FindNext(SearchRec);
    end;
    FindClose(SearchRec);
    try
      RemoveDirectory(PChar(DirName));
    except
    end;
  end;
end;
{$ELSE}
begin
  DeleteDirectory(DirName, False);
end;

{$ENDIF}
{$WARNINGS ON}

function GetFileMIMEType(const Extension: String): String;
{$IFNDEF FPC}
var
  Registry: TRegistry;
begin
  Result := '';
  Registry  := TRegistry.Create;
  try
{$IFNDEF DELPHI4}
    Registry.Access := KEY_READ;
{$ENDIF}
    Registry.RootKey := HKEY_CLASSES_ROOT;
    if Registry.KeyExists(Extension) then
    begin
      Registry.OpenKey(Extension, false);
      Result := Registry.ReadString('Content Type');
      if Result = '' then
        Result := Registry.ReadString('PerceivedType');
      Registry.CloseKey;
    end;
  finally
    Registry.Free;
  end;
end;
{$ELSE}
begin
  Result := lazhelper.GetFileMIMEType(Extension);
end;

{$ENDIF}


end.
