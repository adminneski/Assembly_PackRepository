unit uMasterDetailUDS;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, frxClass, frCoreClasses,
  uDemoMain;

type
  TfrmMasterDetailUDS = class(TfrmDemoMain)
    MasterDS: TfrxUserDataSet;
    DetailDS: TfrxUserDataSet;
    BitBtn1: TBitBtn;
    frxReport1: TfrxReport;
    procedure MasterDSFirst(Sender: TObject);
    procedure MasterDSNext(Sender: TObject);
    procedure MasterDSPrior(Sender: TObject);
    procedure MasterDSCheckEOF(Sender: TObject; var Eof: Boolean);
    procedure MasterDSGetValue(const VarName: String; var Value: Variant);
    procedure DetailDSCheckEOF(Sender: TObject; var Eof: Boolean);
    procedure DetailDSFirst(Sender: TObject);
    procedure DetailDSGetValue(const VarName: String; var Value: Variant);
    procedure DetailDSNext(Sender: TObject);
    procedure DetailDSPrior(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    MasterNo: Integer;
    DetailNo: Integer;
  protected
    function GetCaption: string; override;
  end;

var
  frmMasterDetailUDS: TfrmMasterDetailUDS;

implementation

{$R *.dfm}

const
  Master: array[1..3, 1..2] of ShortString = ( // master Id, master name
    ('1', 'master 1'),
    ('2', 'master 2'),
    ('3', 'master 3'));
  Detail: array[1..15, 1..2] of ShortString = ( // master Id, detail name
    ('1', 'detail 1.1'), ('1', 'detail 1.2'), ('1', 'detail 1.3'),
    ('1', 'detail 1.4'), ('1', 'detail 1.5'), ('2', 'detail 2.1'),
    ('2', 'detail 2.2'), ('2', 'detail 2.3'), ('2', 'detail 2.4'),
    ('2', 'detail 2.5'), ('3', 'detail 3.1'), ('3', 'detail 3.2'),
    ('3', 'detail 3.3'), ('3', 'detail 3.4'), ('3', 'detail 3.5'));


procedure TfrmMasterDetailUDS.MasterDSFirst(Sender: TObject);
begin
  MasterNo := 1;
end;

procedure TfrmMasterDetailUDS.MasterDSNext(Sender: TObject);
begin
  Inc(MasterNo);
end;

procedure TfrmMasterDetailUDS.MasterDSPrior(Sender: TObject);
begin
  Dec(MasterNo);
end;

procedure TfrmMasterDetailUDS.MasterDSCheckEOF(Sender: TObject; var Eof: Boolean);
begin
  Eof := MasterNo > High(Master);
end;

procedure TfrmMasterDetailUDS.MasterDSGetValue(const VarName: String; var Value: Variant);
begin
  Value := Master[MasterNo][2];
end;

procedure TfrmMasterDetailUDS.DetailDSFirst(Sender: TObject);
begin
  DetailNo := 1;
  while (not DetailDS.Eof) and (Detail[DetailNo][1] <> Master[MasterNo][1]) do
    Inc(DetailNo);
end;

procedure TfrmMasterDetailUDS.DetailDSNext(Sender: TObject);
begin
  Inc(DetailNo);
  while (not DetailDS.Eof) and (Detail[DetailNo][1] <> Master[MasterNo][1]) do
    Inc(DetailNo);
end;

procedure TfrmMasterDetailUDS.DetailDSPrior(Sender: TObject);
begin
  Dec(DetailNo);
  while (DetailNo > 1) and (Detail[DetailNo][1] <> Master[MasterNo][1]) do
    Dec(DetailNo);
end;

function TfrmMasterDetailUDS.GetCaption: string;
begin
  Result := 'Master-Detail UDS Demo';
end;

procedure TfrmMasterDetailUDS.DetailDSCheckEOF(Sender: TObject; var Eof: Boolean);
begin
  Eof := DetailNo > High(Detail);
end;

procedure TfrmMasterDetailUDS.DetailDSGetValue(const VarName: String; var Value: Variant);
begin
  Value := Detail[DetailNo][2];
end;

procedure TfrmMasterDetailUDS.BitBtn1Click(Sender: TObject);
begin
  frxReport1.ShowReport();
end;

end.
