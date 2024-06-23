unit uCallDLL;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, ExtCtrls, frGDIPAPI,
  uDemoMain, XPMan, ImgList, ActnList, Menus;

type
  TShowForm = function(H: THandle): Bool; StdCall;

  EDLLLoadError = class(Exception);

  TfrmCallDLL = class(TfrmDemoMain)
    btnCallDLL: TButton;
    procedure btnCallDLLClick(Sender: TObject);
  protected
    function GetCaption: string; override;
  end;

var
  frmCallDLL: TfrmCallDLL;

implementation


{$R *.DFM}

procedure TfrmCallDLL.btnCallDLLClick(Sender: TObject);
var
  LibHandle: THandle;
  ShowForm: TShowForm;
  StartupInput: TGDIPlusStartupInput;
  gdiplusToken: ULONG;
begin
  LibHandle := LoadLibrary('RptDLL.DLL');
  try
    if LibHandle = HINSTANCE_ERROR then
      raise EDLLLoadError.Create('Unable to Load DLL');
    @ShowForm := GetProcAddress(LibHandle, 'ShowForm');
    if not (@ShowForm = nil) then
      try
        // Initialize StartupInput structure
        StartupInput.DebugEventCallback := nil;
        StartupInput.SuppressBackgroundThread := False;
        StartupInput.SuppressExternalCodecs   := False;
        StartupInput.GdiplusVersion := 1;
        // Initialize GDI+
        GdiplusStartup(gdiplusToken, @StartupInput, nil);
        ShowForm(Application.Handle);
      finally
        GdiplusShutdown(gdiplusToken);
      end;
  finally
    FreeLibrary(LibHandle);
  end;
end;

function TfrmCallDLL.GetCaption: string;
begin
  Result := 'DLL Demo';
end;

end.
