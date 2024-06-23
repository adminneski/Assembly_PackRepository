unit Dtm_MainClient;

interface

uses
  System.SysUtils,
  System.StrUtils,
  System.Classes,
  System.Generics.Collections,
  Data.DB,
  System.TypInfo,
  Vcl.Dialogs,
  Vcl.Forms,
  FireDAC.Comp.Client,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Comp.DataSet,
  Kernel.REST.Connection,
  Dto.contacts_00,
  Dto.contacts_00_01,
  Repository.Manager.rest, goxormbr.core.json.utils;

type
  TDtmMainClient = class(TDataModule)
    CONTACTS_00: TFDMemTable;
    CONTACTS_00_01: TFDMemTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FRepDSetR : TRepositoryManagerDataSetRest;
    FRepOSetR : TRepositoryManagerObjectSetRest;
    procedure Contacts_Incluir;
    //
    procedure Contacts_SelectALL_DataSet;
    procedure Contacts_SelectALL_ObjectSet;


    procedure Contacts_FindFrom;

    procedure Contacts_Incluir_Dataset1000;
    procedure Contacts_Incluir_Dataset100;
  end;


implementation

uses
  Frm_MainClient;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDtmMainClient.DataModuleCreate(Sender: TObject);
begin
  FRepDSetR := TRepositoryManagerDataSetRest.Create(TRESTConnection.Get.GOXRESTClient);
  FRepDSetR.AddDataSet<TDtoCONTACTS_00>(CONTACTS_00);
  FRepDSetR.AddDataSet<TDtoCONTACTS_00_01,TDtoCONTACTS_00>(CONTACTS_00_01);
  //
  FRepOSetR := TRepositoryManagerObjectSetRest.Create(TRESTConnection.Get.GOXRESTClient);
  FRepOSetR.AddObjectSet<TDtoCONTACTS_00>;
end;

procedure TDtmMainClient.DataModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FRepDSetR);
  FreeAndNil(FRepOSetR);
end;

procedure TDtmMainClient.Contacts_FindFrom;
var
  LObjList : TObjectList<TDtoCONTACTS_00>;
begin
  LObjList :=  FRepOSetR.FindFrom<TDtoCONTACTS_00>('from');
  FrmMainClient.Memo1.Clear;
  FrmMainClient.Memo1.Text := 'Aguarde...';
  FrmMainClient.TabSheet_ObjectSet.Show;
  FrmMainClient.Memo1.Text :=  TGOXJson.ObjectToJSONString(LObjList);
end;

procedure TDtmMainClient.Contacts_Incluir;
var
  LCONTACTS00 : TDtoCONTACTS_00;
begin
//  FrmMainClient.Gauge.MaxValue := 1000;
//  FrmMainClient.Gauge.Progress := 0;
//  for var X  := 0 to 1000 do
//  begin
//    FrmMainClient.Gauge.Progress := x;
//    Application.ProcessMessages;
//    //
//    LVEI00 := TDtoVEI_00.Create;
//    LVEI00.VEI_PLACA := 'ABC'+X.ToString;
//    LVEI00.VEI_DESCRICAO := 'DESCRICAO'+X.ToString;
//    LVEI00.VEI_DESCREDUZIDA := '';
//    LVEI00.VEI_ANOFABRICACAO := 2021;
//    LVEI00.VEI_ANOMODELO := 2021;
//    LVEI00.VEI_CHASSIS := '';
//    LVEI00.VEI_RENAVAN := '';
//    LVEI00.VEI_RNTCR := '';
//    LVEI00.VEI_COMBUSTIVEL := 'G';
//    LVEI00.VEI_TIPORODADO := '';
//    LVEI00.VEI_TIPOCARROCERIA := '';
//    LVEI00.VEI_TIPOUNIDADETRANSPORTE := '';
//    LVEI00.VEI_PESOMAXIMO := 1000;
//    LVEI00.VEI_ATIVO := 'S';
//    LVEI00.VEI_USUARIOALTERACAO := 'JEICKSON';
//    LVEI00.VEI_DATAHORAALTERACAO := now;
//    //
//    oManager.Insert<TDtoVEI_00>(LVEI00);
//    //
//    FreeAndNil(LVEI00);
//  end;
//  ShowMessage('Finalizou.');
end;

procedure TDtmMainClient.Contacts_Incluir_Dataset1000;
begin
  FrmMainClient.Gauge.MaxValue := 1000;
  FrmMainClient.Gauge.Progress := 0;
  //
  CONTACTS_00.Close;
  CONTACTS_00.Open;
  CONTACTS_00_01.Close;
  CONTACTS_00_01.Open;
  CONTACTS_00.DisableControls;
  CONTACTS_00_01.DisableControls;
  FRepDSetR.Open<TDtoCONTACTS_00>(-1);
  for var X  := 1 to 1000 do
  begin
    FrmMainClient.Gauge.Progress := x;
    Application.ProcessMessages;
    CONTACTS_00.Append;
    CONTACTS_00.FieldByName('CONTACT_BIRTHDATE').AsDateTime:= Date;
    CONTACTS_00.FieldByName('CONTACT_NAME').AsString       := 'JEICKSON';
    CONTACTS_00.FieldByName('CONTACT_LASTNAME').AsString   := 'GOBETI';
    CONTACTS_00.FieldByName('CONTACT_SALARY').AsFloat      := 222.22;
    CONTACTS_00.FieldByName('CONTACT_AGE').AsInteger       := 25;
    for var XFor := 1 to 10 do
    begin
      CONTACTS_00_01.Append;
      CONTACTS_00_01.FieldByName('CONTACT_CELL').AsString    := '27981006500';
      CONTACTS_00_01.FieldByName('CONTACT_PHONE').AsString   := '2732645500';
      CONTACTS_00_01.FieldByName('CONTACT_EMAIL').AsString   := 'neski@neski.com.br';
      CONTACTS_00_01.Post;
    end;
    CONTACTS_00.Post;
    FRepDSetR.ApplyUpdates<TDtoCONTACTS_00>(0);
  end;
  CONTACTS_00.EnableControls;
  CONTACTS_00_01.EnableControls;
 // ShowMessage('Finalizou.');
end;

procedure TDtmMainClient.Contacts_Incluir_Dataset100;
begin
  FrmMainClient.Gauge.MaxValue := 100;
  FrmMainClient.Gauge.Progress := 0;
  //
  CONTACTS_00.Close;
  CONTACTS_00.Open;
  CONTACTS_00_01.Close;
  CONTACTS_00_01.Open;
  CONTACTS_00.DisableControls;
  CONTACTS_00_01.DisableControls;
  FRepDSetR.Open<TDtoCONTACTS_00>(-1);
  for var X  := 1 to 100 do
  begin
    FrmMainClient.Gauge.Progress := x;
    Application.ProcessMessages;
    CONTACTS_00.Append;
    CONTACTS_00.FieldByName('CONTACT_BIRTHDATE').AsDateTime:= Date;
    CONTACTS_00.FieldByName('CONTACT_NAME').AsString       := 'JEICKSON';
    CONTACTS_00.FieldByName('CONTACT_LASTNAME').AsString   := 'GOBETI';
    CONTACTS_00.FieldByName('CONTACT_SALARY').AsFloat      := 222.22;
    CONTACTS_00.FieldByName('CONTACT_AGE').AsInteger       := 25;
    for var XFor := 1 to 10 do
    begin
      CONTACTS_00_01.Append;
      CONTACTS_00_01.FieldByName('CONTACT_CELL').AsString    := '27981006500';
      CONTACTS_00_01.FieldByName('CONTACT_PHONE').AsString   := '2732645500';
      CONTACTS_00_01.FieldByName('CONTACT_EMAIL').AsString   := 'neski@neski.com.br';
      CONTACTS_00_01.Post;
    end;
    CONTACTS_00.Post;
    FRepDSetR.ApplyUpdates<TDtoCONTACTS_00>(0);
  end;
  CONTACTS_00.EnableControls;
  CONTACTS_00_01.EnableControls;
 // ShowMessage('Finalizou.');
end;


procedure TDtmMainClient.Contacts_SelectALL_DataSet;
begin
  FrmMainClient.TabSheet_DataSet.Show;
  CONTACTS_00.Close;
  CONTACTS_00_01.Close;
  CONTACTS_00.Open;
  CONTACTS_00_01.Open;
  FRepDSetR.Open<TDtoCONTACTS_00>;
end;

procedure TDtmMainClient.Contacts_SelectALL_ObjectSet;
var
  LObjList : TObjectList<TDtoCONTACTS_00>;
begin
  LObjList :=  FRepOSetR.Find<TDtoCONTACTS_00>;
  FrmMainClient.Memo1.Clear;
  FrmMainClient.Memo1.Text := 'Aguarde...';
  FrmMainClient.TabSheet_ObjectSet.Show;
  FrmMainClient.Memo1.Text :=  TGOXJson.ObjectToJSONString(LObjList);
end;

end.
