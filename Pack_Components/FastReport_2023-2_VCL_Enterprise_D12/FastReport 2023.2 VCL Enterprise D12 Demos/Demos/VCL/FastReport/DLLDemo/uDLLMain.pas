unit uDLLMain;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, DB, frxDBSet, frxClass, ADODB,
  frxDesgn, frCoreClasses;

type
  TfrmDLL = class(TForm)
    PreviewB: TButton;
    frxReport1: TfrxReport;
    CustomersDS: TfrxDBDataset;
    CustomerSource: TDataSource;
    Customers: TADOTable;
    CustomersCustNo: TFloatField;
    CustomersCompany: TStringField;
    CustomersAddr1: TStringField;
    CustomersAddr2: TStringField;
    CustomersCity: TStringField;
    CustomersState: TStringField;
    CustomersZip: TStringField;
    CustomersCountry: TStringField;
    CustomersPhone: TStringField;
    CustomersFAX: TStringField;
    CustomersTaxRate: TFloatField;
    CustomersContact: TStringField;
    CustomersLastInvoiceDate: TDateTimeField;
    ADOConnection1: TADOConnection;
    frxDesigner1: TfrxDesigner;
    DesignB: TButton;
    procedure PreviewBClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DesignBClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


function ShowForm(H: THandle): Bool; StdCall;


implementation

{$R *.DFM}

{------------------------------------------------------------------------}

function ShowForm(H: THandle): Bool;
var
  Form1: TfrmDLL;
begin
  Application.Handle := H;
  Form1 := TfrmDLL.Create(Application);
  try
    Result := (Form1.ShowModal = mrOK);
  finally
    Form1.Free;
  end;
end;

procedure TfrmDLL.PreviewBClick(Sender: TObject);
begin
  frxReport1.ShowReport;
end;

procedure TfrmDLL.FormActivate(Sender: TObject);
begin
  ADOConnection1.Connected := False;
{$IFNDEF CPUX64}
  ADOConnection1.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' + ExtractFilePath(Application.ExeName) + '\..\..\Data\demo.mdb';
{$ELSE}
  ADOConnection1.ConnectionString := 'Provider=Microsoft.ACE.OLEDB.12.0;Data Source=' + ExtractFilePath(Application.ExeName) + '\..\..\Data\demo.mdb';
{$ENDIF}
  ADOConnection1.Open;
  frxReport1.LoadFromFile(ExtractFilePath(Application.ExeName) + '\..\Main\1.fr3')
end;

procedure TfrmDLL.DesignBClick(Sender: TObject);
begin
  frxReport1.DesignReport;
end;

end.
