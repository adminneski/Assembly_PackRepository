unit GOX.Code.PowerShell;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  ShellApi;

type
   TGOXPowerShell = class
   private
     { private declarations }
   protected
     { protected declarations }
     FPowerShellExeName: String;
     FShowConsole : Boolean;
     FCommandLine :String;
     FCurrentDir: String;
     FOutputLines: TStringList;
   public
     { public declarations }
     constructor Create;
     destructor  Destroy; override;
     function Execute:Boolean;
     function OutputLines: TStringList;

     property CommandLine: String read FCommandLine write FCommandLine;
     property ShowConsole: Boolean read FShowConsole write FShowConsole;
    end;

implementation

{ TGOXPowerShell }

constructor TGOXPowerShell.Create;
begin
  FPowerShellExeName := 'powershell.exe';
  FShowConsole := false;
  FCommandLine := '';
  FCurrentDir:= ExtractFileDir(ExtractShortPathName(ParamStr(0)));
  FOutputLines := TStringList.Create;
end;

destructor TGOXPowerShell.Destroy;
begin
  FreeAndNil(FOutputLines);
  inherited;
end;

function TGOXPowerShell.Execute: Boolean;
var
  start: TStartupInfo;
  procInfo: TProcessInformation;
  tmpName: string;
  T: THandle;
  tmp: THandle;
  tmpSec: TSecurityAttributes;
  res: TStringList;
  return: Cardinal;
begin
  Result := false;
  // set a temporary file
  tmpName := 'Temp'+IntToStr(Random(99999))+'.tmp';
  FillChar(tmpSec, SizeOf(tmpSec), #0);
  tmpSec.nLength := SizeOf(tmpSec);
  tmpSec.bInheritHandle := True;
  tmp := CreateFile(PChar(tmpName), Generic_Write, File_Share_Write, @tmpSec, Create_Always, File_Attribute_Normal, 0);
  try
    FillChar(start, SizeOf(start), #0);
    start.cb          := SizeOf(start);
    start.hStdOutput  := tmp;
    start.dwFlags     := StartF_UseStdHandles or StartF_UseShowWindow;

    if FShowConsole then
      start.wShowWindow := SW_SHOWNORMAL // SW_SHOWMAXIMIZED
    else start.wShowWindow := SW_HIDE;  //SW_Minimize;
    //
    // Start the program
    if CreateProcess(nil, PChar(FPowerShellExeName + ' ' + FCommandLine), nil, nil, True, 0, nil, PChar(FCurrentDir), start, procInfo) then
    begin
      SetPriorityClass(procInfo.hProcess, Idle_Priority_Class);
      WaitForSingleObject(procInfo.hProcess, Infinite);
      GetExitCodeProcess(procInfo.hProcess, return);
      Result := (return = 0);
      CloseHandle(procInfo.hThread);
      CloseHandle(procInfo.hProcess);
      CloseHandle(tmp);
      // Add the output
      res := TStringList.Create;
      try
        res.LoadFromFile(tmpName);
        FOutputLines.LoadFromFile(tmpName);
        //Limpa Linhas em Branco Output
        for var X := FOutputLines.Count-1 downto 0 do
        begin
          if (Length(Trim(FOutputLines.Strings[X])) = 0) then
             FOutputLines.Delete(X);
        end;
      finally
        res.Free;
      end;
      DeleteFile(PChar(tmpName));
    end
    else
      raise Exception.Create(PChar('RunCaptured Error'+SysErrorMessage(GetLastError())));
  except on E: Exception do
    begin
      CloseHandle(tmp);
      DeleteFile(PChar(tmpName));
      raise Exception.Create(E.Message);
    end;
  end;
end;

function TGOXPowerShell.OutputLines: TStringList;
begin
  Result := FOutputLines;
end;

end.
