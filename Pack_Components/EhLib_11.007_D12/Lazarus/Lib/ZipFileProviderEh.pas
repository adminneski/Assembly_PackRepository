{*******************************************************}
{                                                       }
{                      EhLib 10.2                       }
{                                                       }
{           Classes to work w ith ZipingProvider        }
{                                                       }
{     Copyright (c) 2020-2022 by Dmitry V. Bolshakov    }
{                                                       }
{*******************************************************}

unit ZipFileProviderEh;

{$I EhLib.Inc}

interface

uses
  SysUtils, Classes, Graphics, Dialogs, GridsEh, Controls,
  {$IFDEF EH_LIB_16} System.Zip, {$ENDIF}
  {$IFDEF FPC}
    zipper, EhLibLCL,
  {$ELSE}
    EhLibVCL,
  {$ENDIF}
  Variants, Types;

type

  TCustomFileZipingProviderEh = class;

{ TCustomFileZipingProviderEh }

  TCustomFileZipingProviderEh = class(TObject)
  public
    class function CreateInstance: TCustomFileZipingProviderEh; virtual;
    function InitZipFileWriting(FileName: String): TStream; virtual; abstract;
    function GetFileCount: Integer; virtual; abstract;
    function GetFileName(Index: Integer): string; virtual; abstract;

    procedure AddFile(Data: TStream; const FilePathAndName: string); virtual; abstract;
    procedure FinalizeZipFile; overload; virtual; abstract;
    procedure FinalizeZipFile(AStream: TStream); overload; virtual; abstract;

    function IndexOf(const FileName: string): Integer; virtual; abstract;
    procedure ReadFile(FileName: String); virtual; abstract;
    procedure Read(const FileName: string; out Stream: TStream); virtual; abstract;

    property FileCount: Integer read GetFileCount;
    property FileName[Index: Integer]: string read GetFileName;
  end;

  TCustomFileZipingProviderEhClass = class of TCustomFileZipingProviderEh;

{$IFDEF EH_LIB_ZIP} 

{ TSystemZipFileProvider }

  TSystemZipFileProviderEh = class(TCustomFileZipingProviderEh)
  private
    FStream: TStream;
    FFileName: String;
    {$IFDEF FPC}
    FZipFile: TZipper;
    FUnZipFile: TUnZipper;
    {$ELSE}
    FZipFile: TZipFile;
    {$ENDIF}
    FWriteStreams: TObjectListEh;
  public
    constructor Create;
    destructor Destroy; override;

    class function CreateInstance: TCustomFileZipingProviderEh; override;
    function InitZipFileWriting(FileName: String): TStream; override;
    procedure AddFile(Data: TStream; const FilePathAndName: string); override;
    procedure FinalizeZipFile; override;
    procedure FinalizeZipFile(AStream: TStream); override;

    function GetFileCount: Integer; override;
    function GetFileName(Index: Integer): string; override;

    function IndexOf(const FileName: string): Integer; override;
    procedure ReadFile(FileName: String); override;
    procedure Read(const FileName: string; out Stream: TStream); override;

    property Stream: TStream read FStream write FStream;
  end;

{$ENDIF} 

function ZipFileProviderClass: TCustomFileZipingProviderEhClass;
function RegisterZipFileProviderClass(AZipFileProviderClass: TCustomFileZipingProviderEhClass): TCustomFileZipingProviderEhClass;

implementation

var
  FZipFileProviderClass: TCustomFileZipingProviderEhClass;

{ TCustomFileZipingProviderEh }

function ZipFileProviderClass: TCustomFileZipingProviderEhClass;
begin
  Result := FZipFileProviderClass;
end;

function RegisterZipFileProviderClass(AZipFileProviderClass: TCustomFileZipingProviderEhClass):
  TCustomFileZipingProviderEhClass;
begin
  Result := FZipFileProviderClass;
  FZipFileProviderClass := AZipFileProviderClass;
end;

class function TCustomFileZipingProviderEh.CreateInstance: TCustomFileZipingProviderEh;
begin
  Result := nil;
end;

{$IFDEF EH_LIB_ZIP} 

{ TSystemZipFileProvider }

constructor TSystemZipFileProviderEh.Create;
begin
  inherited Create;
  FWriteStreams := TObjectListEh.Create;
end;

destructor TSystemZipFileProviderEh.Destroy;
begin
  inherited Destroy;
  FreeAndNil(FWriteStreams);
  FreeAndNil(FZipFile);
  FreeAndNil(FStream);
end;

class function TSystemZipFileProviderEh.CreateInstance: TCustomFileZipingProviderEh;
begin
  Result := TSystemZipFileProviderEh.Create;
end;

function TSystemZipFileProviderEh.InitZipFileWriting(FileName: String): TStream;
begin
  if FStream <> nil then
    raise Exception.Create('ZipFile is already Initialized.');
  if FZipFile <> nil then
    raise Exception.Create('ZipFile is already Initialized.');
  if FileName = '' then
    FStream := TMemoryStream.Create
  else
    FStream := TFileStream.Create(FileName, fmCreate);
  Result := FStream;
  FFileName := FileName;
  {$IFDEF FPC}
  FZipFile := TZipper.Create;
  {$ELSE}
  FZipFile := TZipFile.Create;
  FZipFile.Open(Result, zmWrite);
  {$ENDIF}
end;

procedure TSystemZipFileProviderEh.AddFile(Data: TStream; const FilePathAndName: string);
{$IFDEF FPC}
var
  ms: TMemoryStream;
begin
  ms := TMemoryStream.Create();
  ms.CopyFrom(Data, Data.Size);
  ms.Position := 0;
  FZipFile.Entries.AddFileEntry(ms, FilePathAndName);
  FWriteStreams.Add(ms);
end;
{$ELSE}
begin
  FZipFile.Add(Data, FilePathAndName);
end;
{$ENDIF}

procedure TSystemZipFileProviderEh.FinalizeZipFile;
{$IFDEF FPC}
var
  i: Integer;
begin
  if FZipFile <> nil then
    FZipFile.SaveToStream(FStream);

  for i := 0 to FWriteStreams.Count-1 do
    FWriteStreams[i].Free;
{$ELSE}
begin
  if FZipFile <> nil then
    FZipFile.Close;
{$ENDIF}
  FreeAndNil(FZipFile);
  FreeAndNil(FStream);
end;

procedure TSystemZipFileProviderEh.FinalizeZipFile(AStream: TStream);
begin
  {$IFDEF FPC}
  if FZipFile <> nil then
    FZipFile.SaveToStream(AStream);
  {$ELSE}
  if FZipFile <> nil then
    FZipFile.Close;
  AStream.CopyFrom(FStream, 0);
  {$ENDIF}
  FreeAndNil(FZipFile);
  FreeAndNil(FStream);
end;

procedure TSystemZipFileProviderEh.ReadFile(FileName: String);
begin
  {$IFDEF FPC}
  FUnZipFile := TUnZipper.Create;
  FUnZipFile.FileName := FileName;
  FUnZipFile.UnZipAllFiles;
  {$ELSE}
  FZipFile := TZipFile.Create;
  FZipFile.Open(FileName, zmRead);
  {$ENDIF}
end;

procedure TSystemZipFileProviderEh.Read(const FileName: string; out Stream: TStream);
{$IFDEF FPC}
{$ELSE}
var
  LocalHeader: TZipHeader;
{$ENDIF}
begin
{$IFDEF FPC}
{$ELSE}
  FZipFile.Read(FileName, Stream, LocalHeader);
{$ENDIF}
end;

function TSystemZipFileProviderEh.GetFileCount: Integer;
begin
{$IFDEF FPC}
  Result := FUnZipFile.Files.Count;
{$ELSE}
  Result := FZipFile.FileCount;
{$ENDIF}
end;

function TSystemZipFileProviderEh.GetFileName(Index: Integer): string;
begin
{$IFDEF FPC}
  Result := FUnZipFile.Files[Index];
{$ELSE}
  Result := FZipFile.FileName[Index];
{$ENDIF}
end;

function TSystemZipFileProviderEh.IndexOf(const FileName: string): Integer;
begin
{$IFDEF FPC}
  Result := FUnZipFile.Files.IndexOf(FileName);
{$ELSE}
  Result := FZipFile.IndexOf(FileName);
{$ENDIF}
end;

{$ENDIF} 

procedure InitUnit;
begin
{$IFDEF EH_LIB_ZIP} 
  RegisterZipFileProviderClass(TSystemZipFileProviderEh);
{$ENDIF} 
end;

procedure FinalizeUnit;
begin
{$IFDEF EH_LIB_ZIP} 
  RegisterZipFileProviderClass(nil);
{$ENDIF} 
end;

initialization
  InitUnit;
finalization
  FinalizeUnit;
end.
