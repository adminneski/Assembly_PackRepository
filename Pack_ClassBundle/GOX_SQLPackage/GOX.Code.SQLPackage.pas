unit GOX.Code.SQLPackage;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.ExtCtrls,
  Dialogs,
  ShellApi,
  Vcl.StdCtrls,
  Vcl.Clipbrd;

type
   TGOXSQLPackage = class
   private
     { private declarations }
     FHandleWindowPrompt: HWND;
     FPanelDock : TPanel;
     FSourceEncryptConnection:Boolean;
     FSourceServerName:String;
     FSourceDatabaseName:String;
     FSourceUser:String;
     FSourcePassword:String;
     //
     FTargetEncryptConnection:Boolean;
     FTargetServerName:String;
     FTargetDatabaseName:String;
     FTargetUser:String;
     FTargetPassword:String;
   protected
     { protected declarations }
     FSQLPackagePathExeName: String;
     FShowConsole : Boolean;
     FCommandLine :String;
     FCurrentDir: String;
     FCurrentDirDAC: String;
     FOutputLines: TStringList;
     //
     function RunWaitProcess:Boolean;
     function RunWaitPrompt:Boolean;
   public
     { public declarations }
     constructor Create;
     destructor  Destroy; override;
     function Execute:Boolean;
     function OutputLines: TStringList;
     //
     function Check_DacFrameworkInstalled:Boolean;
     //
     function Backup(const ATargetFile:String;ACloseOnFinish:Boolean = false):String;
     function Restore(const ASourceFile:String;ACloseOnFinish:Boolean = false):String;
     //
     function Extract(const ATargetFile:String;ACloseOnFinish:Boolean = false):String;
     function Publish(const ASourceFile:String;ACloseOnFinish:Boolean = false):String;
     function DeployReport(const ASourceFile:String; ACloseOnFinish:Boolean = false):String;
     //
     function Compare:String;
     function Synchronize:String;


     property DirectoryDACPAC: String read FCurrentDirDAC;
     property SQLPackagePathExeName: String read FSQLPackagePathExeName;
     //
     property CommandLine: String read FCommandLine write FCommandLine;
     property ShowConsole: Boolean read FShowConsole write FShowConsole;
     property PanelDock: TPanel read FPanelDock write FPanelDock;

     property SourceEncryptConnection: Boolean read FSourceEncryptConnection write FSourceEncryptConnection;
     property SourceServerName: String         read FSourceServerName        write FSourceServerName;
     property SourceDatabaseName: String       read FSourceDatabaseName      write FSourceDatabaseName;
     property SourceUser: String               read FSourceUser              write FSourceUser;
     property SourcePassword: String           read FSourcePassword          write FSourcePassword;

     property TargetEncryptConnection: Boolean read FTargetEncryptConnection write FTargetEncryptConnection;
     property TargetServerName: String         read FTargetServerName        write FTargetServerName;
     property TargetDatabaseName: String       read FTargetDatabaseName      write FTargetDatabaseName;
     property TargetUser: String               read FTargetUser              write FTargetUser;
     property TargetPassword: String           read FTargetPassword          write FTargetPassword;
   end;

implementation


{ TGOXSQLPackage }

function IsAdmin:Boolean;
{ Fonte:  https://www.delphibasics.info/home/delphibasicssnippets/magicapihook }
const
  SECURITY_NT_AUTHORITY: TSIDIdentifierAuthority = (Value: (0,0,0,0,0,5));
  SECURITY_BUILTIN_DOMAIN_RID = $00000020;
  DOMAIN_ALIAS_RID_ADMINS     = $00000220;
var
  IsUserAnAdmin: function(): BOOL; stdcall;
  hAccessToken: THandle;
  ptgGroups: PTokenGroups;
  dwInfoBufferSize: DWORD;
  psidAdministrators: PSID;
  xi: Integer;
  bSuccess: BOOL;
  hMod: Thandle;
begin
 Result:=True;
 Result:=False;
 hAccessToken:=0;
 hMod:=GetModuleHandle('shell32.dll');
 if hMod=0 then hMod:=LoadLibrary('shell32.dll');
 IsUserAnAdmin:=GetProcAddress(hMod,'IsUserAnAdmin');
 if not Assigned(IsUserAnAdmin) then begin
  bSuccess:=OpenThreadToken(GetCurrentThread,TOKEN_QUERY,True,hAccessToken);
  if not bSuccess then if GetLastError=ERROR_NO_TOKEN then
   bSuccess:=OpenProcessToken(GetCurrentProcess,TOKEN_QUERY,hAccessToken);
  if bSuccess then begin
    GetMem(ptgGroups,1024);
    bSuccess:=GetTokenInformation(hAccessToken,TokenGroups,ptgGroups,1024,dwInfoBufferSize);
    CloseHandle(hAccessToken);
    if bSuccess then begin
      AllocateAndInitializeSid(SECURITY_NT_AUTHORITY,2,SECURITY_BUILTIN_DOMAIN_RID,DOMAIN_ALIAS_RID_ADMINS,0,0,0,0,0,0,psidAdministrators);
      if ptgGroups.GroupCount>0 then
        for xi:=0 to ptgGroups.GroupCount-1 do
         if EqualSid(psidAdministrators,ptgGroups.Groups[xi].Sid) then begin
          Result:=True;
          Break;
         end;
      FreeSid(psidAdministrators);
    end;
    FreeMem(ptgGroups);
  end;
 end
 else Result:=IsUserAnAdmin();
end;

function TGOXSQLPackage.Backup(const ATargetFile: String; ACloseOnFinish:Boolean): String;
begin
  var LParam := ' /Action:Export '+
                ' /TargetFile:"'+ATargetFile +'"'+
                ' /SourceEncryptConnection:"'+BoolToStr(FSourceEncryptConnection)+'"'+
                ' /SourceServerName:"'+FSourceServerName+'"'+
                ' /SourceDatabaseName:"'+FSourceDatabaseName+'"'+
                ' /SourceUser:"'+FSourceUser+'"'+
                ' /SourcePassword:"'+FSourcePassword+'"';
   FCommandLine := LParam;
   if ACloseOnFinish then
   RunWaitProcess else RunWaitPrompt;
end;

function TGOXSQLPackage.Check_DacFrameworkInstalled: Boolean;
begin
  Result := FileExists(ExtractShortPathName('C:\Program Files\Microsoft SQL Server\160\DAC\bin\')+'sqlpackage.exe');
end;

function TGOXSQLPackage.Compare: String;
begin
  try
    Extract(FCurrentDirDAC+'SourceCompare.dacpac');
  finally
    Result := DeployReport(FCurrentDirDAC+'SourceCompare.dacpac');
  end;
end;

constructor TGOXSQLPackage.Create;
begin
  FSQLPackagePathExeName := ExtractShortPathName('C:\Program Files\Microsoft SQL Server\160\DAC\bin\')+'sqlpackage.exe';
  FShowConsole := false;
  FCommandLine := '';
  FCurrentDir:= ExtractFilePath(ExtractShortPathName(ParamStr(0)));
  FOutputLines := TStringList.Create;

  FCurrentDirDAC:= FCurrentDir+'DACPAC\';
  ForceDirectories(FCurrentDirDAC);





end;

function TGOXSQLPackage.Restore(const ASourceFile: String; ACloseOnFinish:Boolean): String;
begin
  var LParam := ' /Action:Import '+
                ' /SourceFile:"'+ASourceFile +'"'+
                ' /TargetEncryptConnection:"'+BoolToStr(FTargetEncryptConnection)+'"'+
                ' /TargetServerName:"'+FTargetServerName+'"'+
                ' /TargetDatabaseName:"'+FTargetDatabaseName+'"'+
                ' /TargetUser:"'+FTargetUser+'"'+
                ' /TargetPassword:"'+FTargetPassword+'"';
   FCommandLine := LParam;
   if ACloseOnFinish then
   RunWaitProcess else RunWaitPrompt;
end;

function TGOXSQLPackage.DeployReport(const ASourceFile: String; ACloseOnFinish:Boolean): String;
begin
  try
    var LParam := ' /Action:DeployReport '+
                  ' /SourceFile:"'+ASourceFile +'"'+
                  ' /TargetEncryptConnection:"'+BoolToStr(FTargetEncryptConnection)+'"'+
                  ' /TargetServerName:"'+FTargetServerName+'"'+
                  ' /TargetDatabaseName:"'+FTargetDatabaseName+'"'+
                  ' /TargetUser:"'+FTargetUser+'"'+
                  ' /TargetPassword:"'+FTargetPassword+'"'+
                  ' /OutputPath:"'+FCurrentDirDAC+'DeployReport.xml"'+
                  ' /Diagnostics:"false"'+
                  ' /DiagnosticsFile:"'+FCurrentDirDAC+'DeployReportDiagnostics.txt'+'"'+
                  ''+
                  ' /p:BlockOnPossibleDataLoss=False';
     FCommandLine := LParam;
     RunWaitPrompt;
  finally
    Result := 'DeployReport.xml';
  end;
end;

destructor TGOXSQLPackage.Destroy;
begin
  FreeAndNil(FOutputLines);
  inherited;
end;

function TGOXSQLPackage.Execute: Boolean;
begin
  RunWaitProcess;

//    FTheWindowPrompt := FindWindow(NIL,PChar(FSQLPackagePathExeName));
//    if FTheWindowPrompt <> 0 then
//    begin
//      SetForegroundWindow(FTheWindowPrompt);
//      showwindow(FTheWindowPrompt, SW_SHOWMAXIMIZED);
//    end;


//  FHandleWindowPrompt := 0;
//  while FHandleWindowPrompt = 0 do
//  begin
//    FHandleWindowPrompt := FindWindow(nil, Pchar(FSQLPackagePathExeName));
//  end;
//  SetParent(FHandleWindowPrompt,FPanelDock.Handle);
//  SetWindowPos(FHandleWindowPrompt,0,100,100,400,400,0);
//  ShowWindow(FHandleWindowPrompt,SW_MAXIMIZE);


end;

function TGOXSQLPackage.Extract(const ATargetFile: String;ACloseOnFinish:Boolean): String;
begin
  var LParam := ' /Action:Extract '+
                ' /TargetFile:"'+ATargetFile +'"'+
                ' /SourceEncryptConnection:"'+BoolToStr(FSourceEncryptConnection)+'"'+
                ' /SourceServerName:"'+FSourceServerName+'"'+
                ' /SourceDatabaseName:"'+FSourceDatabaseName+'"'+
                ' /SourceUser:"'+FSourceUser+'"'+
                ' /SourcePassword:"'+FSourcePassword+'"';
   FCommandLine := LParam;
   //
   if ACloseOnFinish then
   RunWaitProcess else RunWaitPrompt;
end;

function TGOXSQLPackage.OutputLines: TStringList;
begin
  Result := FOutputLines;
end;

function TGOXSQLPackage.Publish(const ASourceFile: String; ACloseOnFinish:Boolean): String;
begin
  try
    DeleteFile(FCurrentDirDAC+'BackupSynchronize_1.bacpac');
    Sleep(1000);
    RenameFile(FCurrentDirDAC+'BackupSynchronize.bacpac',FCurrentDirDAC+'BackupSynchronize_1.bacpac');
    Sleep(500);
    //Faz um Backup Antes
    var LParam := ' /Action:Export '+
                  ' /TargetFile:"'+FCurrentDirDAC+'BackupSynchronize.bacpac' +'"'+
                  ' /SourceEncryptConnection:"'+BoolToStr(FTargetEncryptConnection)+'"'+
                  ' /SourceServerName:"'+FTargetServerName+'"'+
                  ' /SourceDatabaseName:"'+FTargetDatabaseName+'"'+
                  ' /SourceUser:"'+FTargetUser+'"'+
                  ' /SourcePassword:"'+FTargetPassword+'"';
     FCommandLine := LParam;

     RunWaitProcess;
  finally
    //Faz Sincronização
    try
      var LParam := ' /Action:Publish '+
                    ' /SourceFile:"'+ASourceFile +'"'+
                    ' /TargetEncryptConnection:"'+BoolToStr(FTargetEncryptConnection)+'"'+
                    ' /TargetServerName:"'+FTargetServerName+'"'+
                    ' /TargetDatabaseName:"'+FTargetDatabaseName+'"'+
                    ' /TargetUser:"'+FTargetUser+'"'+
                    ' /TargetPassword:"'+FTargetPassword+'"'+
                    ' /DeployReportPath:"'+FCurrentDirDAC+'PublishReport.xml'+'"'+
                    ' /DeployScriptPath:"'+FCurrentDirDAC+'PublishScript.sql'+'"'+
                    ' /Diagnostics:"false"'+
                    ' /DiagnosticsFile:"'+FCurrentDirDAC+'PublishDiagnostics.txt'+'"'+
                    ''+
                    ' /p:AllowIncompatiblePlatform=True'+
                    ' /p:BlockOnPossibleDataLoss=True'+
                    ' /p:GenerateSmartDefaults=true'+
                    ' /p:DropConstraintsNotInSource=True'+
                    ' /p:DropDmlTriggersNotInSource=True'+
                    ' /p:DropExtendedPropertiesNotInSource=True'+
                    ' /p:DropIndexesNotInSource=True'+
                    ' /p:DropObjectsNotInSource=True'+
                    ' /p:DropPermissionsNotInSource=True'+
                    ' /p:ExcludeObjectTypes=Sequences;Logins;ServerRoles;files;Users;LinkedServers'+
                    ' /p:ScriptDatabaseOptions=False'+ //Se aplica atualizacao ou nao;
                    '';
       FCommandLine := LParam;
       if ACloseOnFinish then
       RunWaitProcess else RunWaitPrompt;
    finally
      Result := 'PublishReport.xml';
    end;
  end;
end;

function TGOXSQLPackage.RunWaitPrompt: Boolean;
var
  si: TStartupInfo;
  pi: TProcessInformation;
  cmd: string;
  return: Cardinal;
begin
  Result := false;
  FillChar(si, SizeOf(si), 0);
  si.cb := SizeOf(si);
  si.dwFlags := STARTF_USESHOWWINDOW;
  si.wShowWindow := SW_SHOWNORMAL;
//  cmd := '/k '+ACommand+' > C:\temp\retorno.txt';
  cmd := '/k '+FSQLPackagePathExeName + ' ' + FCommandLine;
  if CreateProcess(nil, PChar('cmd.exe ' + cmd), nil, nil, False, CREATE_NEW_CONSOLE or CREATE_NO_WINDOW, nil, nil, si, pi) then
  begin
    SetPriorityClass(pi.hProcess, Idle_Priority_Class);
    WaitForSingleObject(pi.hProcess, INFINITE);
    GetExitCodeProcess(pi.hProcess, return);
    Result := (return = 0);
    CloseHandle(pi.hProcess);
    CloseHandle(pi.hThread);
  end;
end;

function TGOXSQLPackage.RunWaitProcess: Boolean;
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
    if FShowConsole then
    begin
      start.dwFlags     := STARTF_USESHOWWINDOW;
      start.wShowWindow := SW_SHOWNORMAL ///SW_SHOWNORMAL // SW_SHOWMAXIMIZED
    end
    else
    begin
      start.dwFlags     := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
      start.wShowWindow := SW_HIDE;  //SW_Minimize;
    end;
    //
    var SL := TStringList.Create;
    SL.Text := '# '+FSQLPackagePathExeName + ' ' + FCommandLine;
    SL.SaveToFile(FCurrentDirDAC+'LastCommand.txt');
    FreeAndNil(SL);
    //
    // Start the program
    if CreateProcess(nil, PChar(FSQLPackagePathExeName + ' ' + FCommandLine), nil, nil, True, 0, nil, PChar(FCurrentDir), start, procInfo) then
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

function TGOXSQLPackage.Synchronize: String;
begin
  try
    Extract(FCurrentDirDAC+'SourceSynchronize.dacpac',true);
  finally
    Result := Publish(FCurrentDirDAC+'SourceSynchronize.dacpac');
  end;
end;

end.
