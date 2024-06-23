unit ColRegIni;

interface

uses
  Windows,  SysUtils, Classes, ExtCtrls, StdCtrls, IniFiles,
  Registry, Forms,Dialogs;

type
  TRootKey = (CurrentUser, LocalMachine);

  TColRegIni = class(TComponent)

  private
    FSubKey     : String;
    FRootKey    : TRootKey;
    FTheIniFile : String;
    FIniSection : String;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  public
    //Arquivi .INI
    Function IniVer(StringName : String): String;
    Function IniGrava(StringName : String;StringValue : String): Boolean;
    Function IniApaga(StringName : String): Boolean;
    //Registro Windows
    Function RegVer(const VarName : String): String;
    Function RegGrava(const VarName : String;const VarValue: String): Boolean;
    Function RegApaga(const VarName : String): Boolean;
    procedure ExecutanaInicializacao(Titulo: String);
    procedure RemovedaInicializacao(Titulo : String);
  published
    property Arquivo_Ini: String read FTheIniFile    write FTheIniFile;
    property Chave_Ini: String   read FIniSection    write FIniSection;
    property RegLocal: TRootKey  read FRootKey   write FRootKey;
    property RegChave: String    read FSubKey    write FSubKey;
  end;

implementation

//********  TColRegIni  ******************
constructor TColRegIni.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FSubKey := '\Software\Default';
end;

destructor TColRegIni.Destroy;
begin
  inherited Destroy;
end;

Function TColRegIni.IniVer(StringName : String): String;
Var
  TheIni : TIniFile;
Begin
  TheIni := TIniFile.Create(FTheIniFile);
  Try
    Result :=  TheIni.ReadString(FIniSection,StringName,'');
  Finally
    TheIni.Free;
  End;
End;

Function TColRegIni.IniGrava(StringName : String; StringValue : String): Boolean;
Var
  TheIni : TIniFile;
Begin
  TheIni := TIniFile.Create(FTheIniFile);
  Try
    Try
      TheIni.WriteString(FIniSection, StringName, StringValue);
      Result := True;
    Except
      Result := False;
    End;
  Finally
    TheIni.Free;
  End;
End;

Function TColRegIni.IniApaga(StringName : String): Boolean;
Var
  TheIni : TIniFile;
Begin
  TheIni := TIniFile.Create(FTheIniFile);
  Try
    Try
      TheIni.DeleteKey(FIniSection, StringName);
      Result := True;
    Except
      Result := False;
    End;
  Finally
    TheIni.Free;
  End;
End;




Function TColRegIni.RegVer(const VarName: String): String;
Var
  Reg : TRegIniFile;
begin
  Reg := TRegIniFile.Create('');
  Try
    if FRootKey = CurrentUser then
      Reg.RootKey := HKEY_CURRENT_USER
    else
      Reg.RootKey := HKEY_LOCAL_MACHINE;
    Reg.OpenKey(FSubKey,True);

    Result := Reg.ReadString('', VarName, '');
  Finally
    Reg.Free;
  End;
end;

Function TColRegIni.RegGrava(const VarName : String; const VarValue: String): Boolean;
Var
  Reg : TRegIniFile;
begin
  Reg := TRegIniFile.Create('');
  Try
    Try
      if FRootKey = CurrentUser then
        Reg.RootKey := HKEY_CURRENT_USER
      else
        Reg.RootKey := HKEY_LOCAL_MACHINE;
      Reg.OpenKey(FSubKey,True);
      Reg.WriteString('', VarName, VarValue);
      Result := True;
    Except
      Result := False;
    End;
  Finally
    Reg.Free;
  End;
end;


Function TColRegIni.RegApaga(const VarName : String): Boolean;
Var
  Reg : TRegIniFile;
begin
  Reg := TRegIniFile.Create('');
  Try
    Try
      if FRootKey = CurrentUser then
        Reg.RootKey := HKEY_CURRENT_USER
      else
        Reg.RootKey := HKEY_LOCAL_MACHINE;
      Reg.OpenKey(FSubKey,True);
      Reg.DeleteKey('', VarName);
      Result := True;
    Except
      Result := False;
    End;
  Finally
    Reg.Free;
  End;
end;
procedure TColRegIni.ExecutanaInicializacao(Titulo: String);
var
  Registry : TRegistry;
begin
  Registry := TRegistry.Create;
  try
    Registry.RootKey := HKEY_LOCAL_MACHINE;
    Registry.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Run', False);
    Registry.WriteString(Titulo,Application.Exename);
    Registry.CloseKey;
  finally
    Registry.Free;
  end;
end;
procedure TColRegIni.RemovedaInicializacao(Titulo : String);
var
  Registry : TRegistry;
begin
  Registry := TRegistry.Create;
  try
    Registry.RootKey := HKEY_LOCAL_MACHINE;
    Registry.OpenKey('\Software\Microsoft\Windows\CurrentVersion\Run', False);
    Registry.DeleteValue(Titulo);
    Registry.CloseKey;
  finally
    Registry.Free;
  end;
end;


end.
