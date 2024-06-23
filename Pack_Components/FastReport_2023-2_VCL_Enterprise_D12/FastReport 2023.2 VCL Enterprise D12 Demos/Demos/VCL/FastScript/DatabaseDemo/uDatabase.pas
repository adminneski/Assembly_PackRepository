unit uDatabase;

interface

{$I fs.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  fs_iInterpreter, StdCtrls, fs_iBDERTTI, fs_iFormsRTTI, fs_iDBCtrlsRTTI,
  fs_ipascal, XPMan, ImgList, ActnList, Menus, uDemoMain;

type
  TfrmDatabaseMain = class(TfrmDemoMain)
    Button1: TButton;
    Memo1: TMemo;
    fsScript1: TfsScript;
    fsFormsRTTI1: TfsFormsRTTI;
    fsBDERTTI1: TfsBDERTTI;
    fsDBCtrlsRTTI1: TfsDBCtrlsRTTI;
    fsPascal1: TfsPascal;
    procedure Button1Click(Sender: TObject);
  end;

var
  frmDatabaseMain: TfrmDatabaseMain;

implementation

{$R *.DFM}

uses Variants;

procedure TfrmDatabaseMain.Button1Click(Sender: TObject);
begin
  { clear all items }
  fsScript1.Clear;
  { script text }
  fsScript1.Lines := Memo1.Lines;
  { frGlobalUnit contains standard types and functions }
  fsScript1.Parent := fsGlobalUnit;

  { compile the script }
  if fsScript1.Compile then
    fsScript1.Execute
  else   { execute if compilation was succesfull }
    ShowMessage(fsScript1.ErrorMsg); { show an error message }
end;

end.
