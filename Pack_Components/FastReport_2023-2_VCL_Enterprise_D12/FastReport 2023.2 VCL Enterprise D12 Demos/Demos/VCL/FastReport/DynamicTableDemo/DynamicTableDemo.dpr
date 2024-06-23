program DynamicTableDemo;

uses
  Forms,
  uDynamicTable in 'uDynamicTable.pas' {frmDynamicTable},
  uDemoMain in '..\..\Core\uDemoMain.pas' {frmDemoMain};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrmDynamicTable, frmDynamicTable);
  Application.CreateForm(TfrmDemoMain, frmDemoMain);
  Application.Run;
end.
