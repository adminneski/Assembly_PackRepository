unit FormAbout;

{$MODE Delphi}

//{$I EhLib.Inc}

interface

uses
  LCLIntf, LCLType, LMessages,
  Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Clipbrd, LazVersion, LCLPlatformDef, InterfaceBase,
  EhLibLCL, Process,
  {$IFDEF EH_LIB_6} Types, {$ENDIF}
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type

  { TfAbout }

  TfAbout = class(TForm)
    Image1: TImage;
    Memo1: TMemo;
    Bevel1: TBevel;
    Bevel2: TBevel;
    bbClose: TBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Bevel3: TBevel;
    lBuild: TLabel;
    Memo2: TMemo;
    Shape1: TShape;
    lSupportRef: TLabel;
    lForumRef: TLabel;
    lHomePage: TLabel;
    Shape2: TShape;
    Image2: TImage;
    lVer: TLabel;
    SpeedButton1: TButton;
    spCopy: TButton;
    procedure bbCloseClick(Sender: TObject);
    procedure lHomePageClick(Sender: TObject);
    procedure lForumRefClick(Sender: TObject);
    procedure lSupportRefClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure spCopyClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTESt;
  public
    function DelphiCompilerInfo: String;
    function DelphiPlatformInfo: String;
    function GetPOSIXInfo: String;
    function CompiledForCPUInfo: String;
    function GetCompilerSpecificInfo: String;
    //function GetOSInfo: String;

    procedure FillSysInfo;
  end;

var
  fAbout: TfAbout;

procedure ShowAboutForm;

implementation

{$R *.lfm}

procedure ShowAboutForm;
begin
  fAbout := TfAbout.Create(Application);
  try
    fAbout.ShowModal;
  finally
    FreeAndNil(fAbout);
  end
end;

type
  TOSInfo = record
    Kernel: String;
    OSName: String;
    OSVersion: String;
    Architecture: String;
  end;

function GetOSInfo: TOSInfo;
{$IFDEF LINUX}
var
  P: TProcess;

  function ExecParam(Param: String): String;
  begin
    P.Parameters[0] := '-' + Param;
    P.Execute;
    SetLength(Result, 1000);
    SetLength(Result, P.Output.Read(Result[1], Length(Result)));
    while (Length(Result) > 0) and
          (Result[Length(Result)] in [#8..#13,#32]) do
    begin
      SetLength(Result, Length(Result) - 1);
    end;
  end;
begin
  P:= TProcess.Create(Nil);
  P.Options:= [poWaitOnExit, poUsePipes];
  P.Executable:= 'uname';
  P.Parameters.Add('');

  Result.Kernel := ExecParam('s') + ' ' + ExecParam('r');
  Result.OSName := ExecParam('o');
  Result.OSVersion := ExecParam('v');
  Result.Architecture := ExecParam('m');
  //WriteLn('Operating System: ', ExecParam('o'));
  //WriteLn('Kernel Name: ', ExecParam('s'));
  //WriteLn('Kernel Release: ', ExecParam('r'));
  //WriteLn('Kernel Version: ', ExecParam('v'));
  //WriteLn('Network Node: ', ExecParam('n'));
  //WriteLn('Architecture: ', ExecParam('m'));
  P.Free;
end;
{$ELSE}
begin
  Result.Kernel := '';
  Result.OSName := 'Windows';
  Result.OSVersion := '';
  Result.Architecture := '';
end;
{$ENDIF}

function GetCompiledTargetCPU: string;
begin
  Result := LowerCase({$I %FPCTARGETCPU%});
end;

function GetCompiledTargetOS: string;
begin
  Result := LowerCase({$I %FPCTARGETOS%});
end;

procedure TfAbout.bbCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfAbout.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to ControlCount-1 do
  begin
    Controls[i].Font.Name := Font.Name;
  end;
  lSupportRef.Font.Style := [fsBold, fsUnderline];
//  lSupportRef.Font.Color := clNavy;
  lForumRef.Font := lSupportRef.Font;
  lHomePage.Font := lSupportRef.Font;

  lVer.Caption := EhLibVerInfo;
  lBuild.Caption := EhLibBuildInfo;

  Memo2.BoundsRect := Memo1.BoundsRect;
  spCopy.Visible := False;
end;

procedure TfAbout.spCopyClick(Sender: TObject);
begin
  Clipboard.AsText := Memo2.Text;
end;

procedure TfAbout.SpeedButton1Click(Sender: TObject);
begin
  if Memo2.Visible = False then
  begin
    FillSysInfo();
    Memo2.Visible := True;
    Memo1.Visible := False;
    spCopy.Visible := True;
  end else
  begin
    Memo1.Visible := True;
    Memo2.Visible := False;
    spCopy.Visible := False;
  end;
end;

procedure TfAbout.FillSysInfo();
var
  OSInfo: TOSInfo;
begin
  Memo2.Clear;
  Memo2.Lines.Add(EhLibVerInfo + ' ' + EhLibBuildInfo);
{$IFDEF MSWINDOWS}
{$ELSE}
//  Memo2.Lines.Add('CrossVCL ' + GetCrossVclVersion);
{$ENDIF}
  Memo2.Lines.Add('Compiler: ' + DelphiCompilerInfo());
  Memo2.Lines.Add('Platform: ' + DelphiPlatformInfo());

  OSInfo := GetOSInfo;
  Memo2.Lines.Add('');
  if (OSInfo.Kernel <> '') then
    Memo2.Lines.Add('OS.Kernel: ' + OSInfo.Kernel);
  if (OSInfo.OSName <> '') then
    Memo2.Lines.Add('OS.OSName: ' + OSInfo.OSName);
  if (OSInfo.OSVersion <> '') then
    Memo2.Lines.Add('OS.OSVersion: ' + OSInfo.OSVersion);
  if (OSInfo.Architecture <> '') then
    Memo2.Lines.Add('OS.Architecture: ' + OSInfo.Architecture);

  Memo2.Lines.Add('');
  Memo2.Lines.Add('POSIX Defined: ' + GetPOSIXInfo());
  Memo2.Lines.Add('Compiled For CPU: ' + CompiledForCPUInfo());

  Memo2.Lines.Add('');
  Memo2.Lines.Add(GetCompilerSpecificInfo());
  Memo2.SelStart := 0;
  Memo2.SelLength := 0;
end;

function TfAbout.DelphiCompilerInfo(): String;
begin
{$IFDEF FPC}
  Result := 'Lazarus: ' + laz_version;
{$ENDIF}

{$IFDEF VER150}
  Result := 'Delphi 7.0';
{$ENDIF}

{$IFDEF CIL}
  Result := 'Delphi 8.0';
{$ENDIF}

{$IFDEF VER170}
  Result := 'Delphi 2005';
{$ENDIF}

{$IFDEF VER180}
  Result := 'Developer Studio 2006';
{$ENDIF}

{$IFDEF VER190}
  Result := 'Developer Studio 2007';
{$ENDIF}

{$IFDEF VER200}
  Result := 'RAD Studio 2009';
{$ENDIF}

{$IFDEF VER210}
  Result := 'RAD Studio 2010, Weaver';
{$ENDIF}

{$IFDEF VER220}
  Result := 'RAD Studio 2011 XE';
{$ENDIF}

{$IFDEF VER230}
  Result := 'Delphi XE2 / C++Builder XE2';
{$ENDIF}

{$IFDEF VER240}
  Result := 'Delphi XE3 / C++Builder XE3';
{$ENDIF}

{$IFDEF VER250}
  Result := 'Delphi XE4 / C++Builder XE4';
{$ENDIF}

{$IFDEF VER260}
  Result := 'Delphi XE5 / C++Builder XE5';
{$ENDIF}

{$IFDEF VER270}
  Result := 'Delphi XE6 / C++Builder XE6';
{$ENDIF}

{$IFDEF VER280}
  Result := 'Delphi XE7 / C++Builder XE7';
{$ENDIF}

{$IFDEF VER290}
  Result := 'Delphi XE8 / C++Builder XE8';
{$ENDIF}

{$IFDEF VER300}
  Result := 'Delphi XE10 / C++Builder XE10';
{$ENDIF}

{$IFDEF VER310}
  Result := 'Delphi XE10.1 / C++Builder XE10.1';
{$ENDIF}

{$IFDEF VER320}
  Result := 'Delphi XE10.2 / C++Builder XE10.2';
{$ENDIF}

{$IFDEF VER330}
  Result := 'Delphi XE10.3 / C++Builder XE10.3';
{$ENDIF}

{$IFDEF VER340}
  Result := 'Delphi XE10.4 / C++Builder XE10.4';
{$ENDIF}

end;

function TfAbout.DelphiPlatformInfo(): String;
begin
Result := '';
{$IFDEF IOS32} Result := 'IOS32'; {$ENDIF}
{$IFDEF IOS64} Result := 'IOS64'; {$ENDIF}
{$IFDEF WIN32} Result := 'WIN32'; {$ENDIF}
{$IFDEF WIN64} Result := 'WIN64'; {$ENDIF}
{$IFDEF MACOS32} Result := 'MACOS32'; {$ENDIF}
{$IFDEF MACOS64} Result := 'MACOS64'; {$ENDIF}
{$IFDEF LINUX32} Result := 'LINUX32'; {$ENDIF}
{$IFDEF LINUX64} Result := 'LINUX64'; {$ENDIF}
{$IFDEF ANDROID32} Result := 'ANDROID32'; {$ENDIF}

{$IFDEF FPC}
Result := Result + ' - ' +
  GetCompiledTargetCPU + '-' +
  GetCompiledTargetOS + '-' +
  LCLPlatformDisplayNames[GetDefaultLCLWidgetType];
{$ENDIF}
end;

function TfAbout.GetPOSIXInfo(): String;
begin
{$IFDEF POSIX}
  Result := 'True';
{$ELSE}
  Result := 'False';
{$ENDIF}
{$IFDEF POSIX32} Result := Result + ', POSIX32'; {$ENDIF}
{$IFDEF POSIX64} Result := Result + ', POSIX64'; {$ENDIF}
end;

function TfAbout.CompiledForCPUInfo(): String;
begin

{$IFDEF CPU386} Result := 'CPU386'; {$ENDIF}
{$IFDEF CPUX86} Result := 'CPUX86'; {$ENDIF}
{$IFDEF CPUX64} Result := 'CPUX64'; {$ENDIF}
{$IFDEF CPUARM32} Result := 'CPUARM32'; {$ENDIF}
{$IFDEF CPUARM64} Result := 'CPUARM64'; {$ENDIF}

{$IFDEF CPU32BITS} Result := Result + ', CPU32BITS'; {$ENDIF}
{$IFDEF CPU64BITS} Result := Result + ', CPU64BITS'; {$ENDIF}
end;

function TfAbout.GetCompilerSpecificInfo(): String;
begin
  Result := '';
  Result := Result + 'AUTOREFCOUNT = ' + {$IFDEF AUTOREFCOUNT}'True'{$ELSE}'False'{$ENDIF} + sLineBreak;
  Result := Result + 'UNICODE = ' + {$IFDEF UNICODE}'True'{$ELSE}'False'{$ENDIF} + sLineBreak;

  Result := Result + 'ALIGN_STACK = ' + {$IFDEF ALIGN_STACK}'True'{$ELSE}'False'{$ENDIF} + sLineBreak;
  Result := Result + 'EXTERNALLINKER = ' + {$IFDEF EXTERNALLINKER}'True'{$ELSE}'False'{$ENDIF} + sLineBreak;
  Result := Result + 'CONDITIONALEXPRESSIONS = ' + {$IFDEF CONDITIONALEXPRESSIONS}'True'{$ELSE}'False'{$ENDIF} + sLineBreak;
  Result := Result + 'ELF = ' + {$IFDEF ELF}'True'{$ELSE}'False'{$ENDIF} + sLineBreak;
  Result := Result + 'NEXTGEN = ' + {$IFDEF NEXTGEN}'True'{$ELSE}'False'{$ENDIF} + sLineBreak;
  Result := Result + 'PC_MAPPED_EXCEPTIONS = ' + {$IFDEF PC_MAPPED_EXCEPTIONS}'True'{$ELSE}'False'{$ENDIF} + sLineBreak;
  Result := Result + 'PIC = ' + {$IFDEF PIC}'True'{$ELSE}'False'{$ENDIF} + sLineBreak;
  Result := Result + 'UNDERSCOREIMPORTNAME = ' + {$IFDEF UNDERSCOREIMPORTNAME}'True'{$ELSE}'False'{$ENDIF} + sLineBreak;

  Result := Result + 'WEAKREF = ' + {$IFDEF WEAKREF}'True'{$ELSE}'False'{$ENDIF} + sLineBreak;
  Result := Result + 'WEAKINSTREF = ' + {$IFDEF WEAKINSTREF}'True'{$ELSE}'False'{$ENDIF} + sLineBreak;
  Result := Result + 'WEAKINTFREF = ' + {$IFDEF WEAKINTFREF}'True'{$ELSE}'False'{$ENDIF} + sLineBreak;
end;

//function TfAbout.GetOSInfo(): String;
//var
//  sCPU, sOs, sWidgetSet: string;
//begin
// sOs:='OTHER';
// sCPU:='???';
// sWidgetSet:='';
// {$IFDEF UNIX              }    // --UNIX--
//   {$IFDEF LINUX           }
//      sOs:='LINUX';
//   {$ENDIF}
//   {$IFDEF BSD             }    // --BSD--
//     {$IFDEF FREEBSD       }    // FREEBSD
//       sOs:='FREEBSD';
//     {$ENDIF}
//     {$IFDEF NETBSD        }    // NETBSD
//       sOs:='NETBSD';
//     {$ENDIF}
//     {$IFDEF DARWIN        }    // Macintosh
//       sOs:='MAC';
//     {$ENDIF}
//   {$ENDIF}
// {$ENDIF}
// {$IFDEF WINDOWS       }        // --WINDOWS--
//   sOs:='WIN';
// {$ENDIF}
//
//  //CPU
// {$IFDEF CPUI386}
//   sCPU:='x86';
// {$ENDIF}
// {$IFDEF CPUX86_64}
//   sCPU:='x64';
// {$ENDIF}
// {$IFDEF CPUARM}
//   sCPU:='-ARM';
// {$ENDIF}
//
// //WIDGETSET
// {$IFDEF LCLQt}
//  sWidgetSet:='Qt';
// {$ENDIF}
// {$IFDEF LCLGTK}
//  sWidgetSet:='Gtk2';
// {$ENDIF}
// {$IFDEF LCLGTK2}
//  sWidgetSet:='Gtk2';
// {$ENDIF}
// {$IFDEF LCLGTK3}
//  sWidgetSet:='Gtk3';
// {$ENDIF}
// {$IFDEF LCLWin32}
//  sWidgetSet:='Win';
// {$ENDIF}
// {$IFDEF LCLCocoa}
// sWidgetSet:='Cocoa';
// {$ENDIF}
// {$IFDEF LCLCarbon}
//  sWidgetSet:='Carbon';
// {$ENDIF}
// Result := sOS + ' CPU: ' + sCPU + ' (' + sWidgetSet + ')';
//end;

procedure TfAbout.lForumRefClick(Sender: TObject);
begin
  OpenURL('http://forum.ehlib.com');
end;

procedure TfAbout.lHomePageClick(Sender: TObject);
begin
  OpenURL('http://www.ehlib.com');
end;

procedure TfAbout.lSupportRefClick(Sender: TObject);
begin
   OpenDocument('mailto:support@ehlib.com');
end;

procedure TfAbout.WMNCHitTest(var Message: TWMNCHitTest);
begin
  if FindDragTarget(Point(Message.XPos, Message.YPos), False) is TLabel then
    Message.Result := HTCLIENT
  else
    Message.Result := HTCAPTION;
end;

end.

