unit Frm_MigrationExpress;

interface

uses
  Winapi.Windows
  ,Winapi.Messages
  ,System.SysUtils
  ,System.Variants
  ,System.Classes
  ,Vcl.Graphics
  ,Vcl.Controls
  ,Vcl.Forms
  ,Vcl.Dialogs
  ,Vcl.ExtCtrls
  ,Gobt_ButtonAdvanced
  ,RzTabs
  ,DBGridEhGrouping
  ,ToolCtrlsEh
  ,DBGridEhToolCtrls
  ,DynVarsEh
  ,EhLibVCL
  ,GridsEh
  ,DBAxisGridsEh
  ,DBGridEh
  ,Vcl.Samples.Gauges
  ,Vcl.StdCtrls
  ,Vcl.NumberBox
  ,System.Rtti
  ,FireDAC.Comp.Client

  //MigrationExpress
  ,Dtm_MigrationExpress
  ,Dlg_Connection

  // Status DataSets
  ,Data.DB
  ,Vcl.FileCtrl
  ,Vcl.CheckLst
  ,Vcl.ComCtrls,
   Vcl.Imaging.pngimage, Core.Server.Params;

type
  TFrmMigrationExpress = class(TForm)
    Panel1: TPanel;
    Pnl_Menu: TPanel;
    pnl_ConectarDB: TPanel;
    btnConectarBancos: TGoButtonAdvanced;
    pnl_Botoes: TPanel;
    btnBuscarEmpresa: TGoButtonAdvanced;
    btnValidacaoDatabase: TGoButtonAdvanced;
    Linha1: TShape;
    Linha2: TShape;
    pcMenu: TRzPageControl;
    tbAlteracaoComCodigo: TRzTabSheet;
    Panel12: TPanel;
    Panel6: TPanel;
    DBGridEhFiliaisERP: TDBGridEh;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    Panel13: TPanel;
    Panel14: TPanel;
    edtOrigem: TNumberBox;
    edtDestino: TNumberBox;
    Shape3: TShape;
    Shape4: TShape;
    GaugeAlterarComCodigo: TGauge;
    Panel15: TPanel;
    btnAlteracaoComCodigoAutomatico: TGoButtonAdvanced;
    tbValidarDatabase: TRzTabSheet;
    Panel16: TPanel;
    lblTabela: TLabel;
    Panel17: TPanel;
    ltbColunas: TListBox;
    ltbTabelas: TListBox;
    Panel18: TPanel;
    Panel21: TPanel;
    pgbFor: TGauge;
    Panel19: TPanel;
    Panel20: TPanel;
    pgbWhile: TGauge;
    Panel22: TPanel;
    lstLogs: TListBox;
    Panel23: TPanel;
    Panel24: TPanel;
    btnProcessarInconsistenciaERP: TGoButtonAdvanced;
    Panel25: TPanel;
    lblTbl: TLabel;
    btnAbaConversao: TGoButtonAdvanced;
    tbConverterDatabase: TRzTabSheet;
    Panel26: TPanel;
    Panel27: TPanel;
    Panel28: TPanel;
    lstTempoTabela: TListBox;
    Panel29: TPanel;
    Panel30: TPanel;
    GaugeWhile: TGauge;
    Panel31: TPanel;
    Panel32: TPanel;
    GaugeConversao: TGauge;
    Panel33: TPanel;
    Panel34: TPanel;
    btnExecutarConversao: TGoButtonAdvanced;
    Panel35: TPanel;
    Panel36: TPanel;
    Panel37: TPanel;
    lblTempo: TLabel;
    lblHoraFinal: TLabel;
    lblHoraInicio: TLabel;
    Panel38: TPanel;
    lblField: TLabel;
    lblTabelaAtual: TLabel;
    lblTempoProcessamento: TLabel;
    lblFuncao: TLabel;
    TimerProcesamentoTabela: TTimer;
    lblRowCopyRecord: TLabel;
    lblTotalRowCopyRecord: TLabel;
    tbReparoDatabase: TRzTabSheet;
    Panel39: TPanel;
    btnAbaReparo: TGoButtonAdvanced;
    Panel40: TPanel;
    Panel41: TPanel;
    Panel43: TPanel;
    Panel44: TPanel;
    btnExecutarReparoDatabase: TGoButtonAdvanced;
    Panel42: TPanel;
    DirectoryListBox1: TDirectoryListBox;
    Panel45: TPanel;
    btnBuscar: TGoButtonAdvanced;
    FileListBox1: TFileListBox;
    lblNumberFound: TLabel;
    Panel46: TPanel;
    Panel47: TPanel;
    GaugeReparo: TGauge;
    btnAbrirBackup: TGoButtonAdvanced;
    Panel48: TPanel;
    lstArqsBusca: TCheckListBox;
    lstReparoLogs: TRichEdit;
    btnExcluirForeignKeys: TGoButtonAdvanced;
    tbMain: TRzTabSheet;
    pnlprincipal: TPanel;
    Image1: TImage;
    btnAlteracaoComCodigoManual: TGoButtonAdvanced;
    Shape1: TShape;
    PnlConteudo: TPanel;
    btnDuvida: TGoButtonAdvanced;

    // Eventos Formulario
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

    //Eventos de Botões
    procedure btnConectarBancosClick(Sender: TObject);

    procedure btnBuscarEmpresaClick(Sender: TObject);
    procedure btnAlteracaoComCodigoManualClick(Sender: TObject);
    procedure btnAlteracaoComCodigoAutomaticoClick(Sender: TObject);

    procedure btnValidacaoDatabaseClick(Sender: TObject);
    procedure btnProcessarInconsistenciaERPClick(Sender: TObject);

    procedure btnAbaConversaoClick(Sender: TObject);
    procedure btnExecutarConversaoClick(Sender: TObject);

    procedure btnAbaReparoClick(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure btnExecutarReparoDatabaseClick(Sender: TObject);

    procedure btnExcluirForeignKeysClick(Sender: TObject);

    procedure btnAbrirBackupClick(Sender: TObject);

    // Eventos de Grid
    procedure DBGridEhFiliaisERPSelectionChanged(Sender: TObject);
    procedure DBGridEhFiliaisERPExit(Sender: TObject);
    procedure DBGridEhFiliaisERPKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGridEhFiliaisERPSelectedRowsItemChanged(Sender: TCustomDBGridEh; Item: TArray<System.Byte>; Action: TListNotification);

    // Evento Timer
    procedure TimerProcesamentoTabelaTimer(Sender: TObject);

    // Eventos TabSheet
    procedure tbValidarDatabaseShow(Sender: TObject);
    procedure tbReparoDatabaseShow(Sender: TObject);
    procedure tbAlteracaoComCodigoShow(Sender: TObject);
    procedure pnl_ConectarDBDblClick(Sender: TObject);
    procedure tbConverterDatabaseShow(Sender: TObject);
    procedure btnDuvidaMouseEnter(Sender: TObject);
    procedure btnDuvidaMouseLeave(Sender: TObject);


  private
    { Private declarations }
    DlgConnection : TFrmConnection;
  public
    { Public declarations }
    GListCopyDataSet : TStringList;

    procedure FieldDoORM(Field : TRttiProperty);

    procedure ExecutarTodosScripts;
    function  ExecutScriptSQL(pArquivoSQL: String;pDataBaseName:String): String;

  end;

var
  FrmMigrationExpress: TFrmMigrationExpress;

implementation

{$R *.dfm}

uses Dlg_Finalizado, Dlg_informacao;

procedure TFrmMigrationExpress.btnBuscarEmpresaClick(Sender: TObject);
begin

  if not (DtmMigrationExpress.ValidaERPAtualizado(22007)) then
    begin
      DtmMigrationExpress.MessageDlgColor('BANCO DE DADOS DO ERP ESTA DESATUALIZADO!! ' + #13#13 +
                                        'ATUALIZE PARA A VERSÃO MINIMA PARA CONVERSÃO. (V22.002_B008)', 'Atenção',mtCustom, [mbOK], $002E2E2E, clRed);
      Exit;
    end;

  pcMenu.ActivePage := tbAlteracaoComCodigo;
end;

procedure TFrmMigrationExpress.btnConectarBancosClick(Sender: TObject);
begin
  if DtmMigrationExpress.ConnectionOrigem.Connected and DtmMigrationExpress.ConnectionDestino.Connected then
    Exit;

  try
    DlgConnection := TFrmConnection.Create(Application);
    DlgConnection.ShowModal;

    if (DlgConnection.ModalResult = mrOk) then
    begin
      // Aparencia Normal do Bot�o
      btnConectarBancos.Appearance.BorderColor    := $0051C800;
      btnConectarBancos.Appearance.Color          := $0051C800;
      btnConectarBancos.Appearance.ColorMirror    := $0051C800;
      btnConectarBancos.Appearance.ColorMirrorTo  := $0051C800;
      btnConectarBancos.Appearance.ColorTo        := $0051C800;

      // Aparencia quando esta com mouse em cima do botão
      btnConectarBancos.Appearance.BorderColorHot   := $00337E00;
      btnConectarBancos.Appearance.ColorHot         := $00337E00;
      btnConectarBancos.Appearance.ColorHotTo       := $00337E00;
      btnConectarBancos.Appearance.ColorMirrorHot   := $00337E00;
      btnConectarBancos.Appearance.ColorMirrorHotTo := $00337E00;
      btnConectarBancos.Hint                        := 'Realiza as conexões com os bancos de dados.' + #13 + 'Status : Online';

      FrmMigrationExpress.Caption := FrmMigrationExpress.Caption + ' - Origem: ' + DlgConnection.edtInstanciaOrigem.Text + '\' + DlgConnection.cbxDatabaseOrigem.Text +
                                     ' x Destino: ' + DlgConnection.edtInstanciaDestino.Text + '\' + DlgConnection.cbxDatabaseDestino.Text;

      btnConectarBancos.ModalResult := mrOk;
      btnBuscarEmpresa.Enabled      := True;
//      btnValidacaoDatabase.Enabled  := True;
//      btnAbaConversao.Enabled       := True;
//      btnAbaReparo.Enabled          := True;
    end;
  finally
    FreeAndNil(DlgConnection);
  end;
end;

procedure TFrmMigrationExpress.btnProcessarInconsistenciaERPClick(Sender: TObject);
var
  iFor, iRepeat : Integer;
  //IntField: Integer;
  sTabela , sTabelaRepeat, sColuna : string;
  //sSairRepeat, sRegistroCorrigido : string;

begin
  if btnProcessarInconsistenciaERP.ModalResult = mrOk then
    Exit;
  try
    btnProcessarInconsistenciaERP.Enabled := False;
    pgbfor.MaxValue                       := ltbTabelas.Items.Count;
    pgbFor.MinValue                       := 0;
    pgbFor.Progress                       := 0;

    if lstLogs.Items.Count > 0 then
      lstLogs.Items.Clear;

    for iFor := 0 to ltbTabelas.Items.Count -1 do
    begin
      pgbFor.Progress := iFor;
      if sTabelaRepeat <> ltbTabelas.Items[iFor] then
      begin
        DtmMigrationExpress.TABLES.Close;
        DtmMigrationExpress.TABLES.SQL.Clear;
        DtmMigrationExpress.TABLES.SQL.Add(' SELECT DISTINCT C.TABLE_NAME FROM INFORMATION_SCHEMA.COLUMNS AS C ' +
                                           ' WHERE TABLE_NAME IS NOT NULL ' +
                                           ' AND TABLE_NAME IN ( ' + QuotedStr(ltbTabelas.Items[iFor]) + ')' +
                                           ' AND TABLE_CATALOG = ' + QuotedStr(DtmMigrationExpress.ConnectionOrigem.Params.Database));
        DtmMigrationExpress.TABLES.Open;

        if DtmMigrationExpress.TABLES.RecordCount > 0 then
        begin
          iRepeat := iFor;
          var sSairRepeat : String;
          repeat
            var UpdateCamposVazios : String;

            sTabela := ltbTabelas.Items[iFor];

            if iRepeat = iFor then
              begin
                sColuna := ' RTRIM(LTRIM(' + ltbColunas.Items[iRepeat] + ')) AS ' + ltbColunas.Items[iRepeat];
              end
            else
              begin
                sColuna := sColuna + ', ' + ' RTRIM(LTRIM(' + ltbColunas.Items[iRepeat] + ')) AS ' + ltbColunas.Items[iRepeat];
              end;
            lblTbl.Caption := sTabela + '  ;  ' + ltbColunas.Items[iRepeat] + '  ; UpdateCamposVazios';
            Application.ProcessMessages;


            var NOTNULL := DtmMigrationExpress.VerificaCamposNOTNULLBanco(ltbColunas.Items[iRepeat], sTabela);

            if (NOTNULL) and (ltbColunas.Items[iRepeat] = 'CTA_AGENCIA') then
              UpdateCamposVazios := 'UPDATE ' + sTabela + ' SET ' + ltbColunas.Items[iRepeat] + ' = ' + QuotedStr('0') + ' WHERE LEN(RTRIM(LTRIM(' + ltbColunas.Items[iRepeat] + '))) = 0'
            else if (NOTNULL) and (ltbColunas.Items[iRepeat] = 'TAB_CODIGO') then
              UpdateCamposVazios := 'UPDATE ' + sTabela + ' SET ' + ltbColunas.Items[iRepeat] + ' = ' + QuotedStr('001') + ' WHERE LEN(RTRIM(LTRIM(' + ltbColunas.Items[iRepeat] + '))) = 0'
            else if (NOTNULL) and (ltbColunas.Items[iRepeat] = 'PES_CODIGO') then
              UpdateCamposVazios := 'UPDATE ' + sTabela + ' SET ' + ltbColunas.Items[iRepeat] + ' = ' + QuotedStr('999999') + ' WHERE LEN(RTRIM(LTRIM(' + ltbColunas.Items[iRepeat] + '))) = 0'
            else if (NOTNULL) and (ltbColunas.Items[iRepeat] = 'PRZ_CODIGO') then
              UpdateCamposVazios := 'UPDATE ' + sTabela + ' SET ' + ltbColunas.Items[iRepeat] + ' = ' + QuotedStr('0') + ' WHERE LEN(RTRIM(LTRIM(' + ltbColunas.Items[iRepeat] + '))) = 0'
            else if (NOTNULL) and (ltbColunas.Items[iRepeat] = 'CTA_CODIGO') then
              UpdateCamposVazios := 'UPDATE ' + sTabela + ' SET ' + ltbColunas.Items[iRepeat] + ' = ' + QuotedStr('0') + ' WHERE LEN(RTRIM(LTRIM(' + ltbColunas.Items[iRepeat] + '))) = 0'
            else if (NOTNULL) and (ltbColunas.Items[iRepeat] = 'FIL_CODIGO') then
              UpdateCamposVazios := 'UPDATE ' + sTabela + ' SET ' + ltbColunas.Items[iRepeat] + ' = 0'  + ' WHERE ' + ltbColunas.Items[iRepeat] +' = '+ QuotedStr('CAD') +' or ' + ltbColunas.Items[iRepeat] +'=' + QuotedStr('XXX')
            else
              UpdateCamposVazios := 'UPDATE ' + sTabela + ' SET ' + ltbColunas.Items[iRepeat] + ' = NUll'  + ' WHERE LEN(RTRIM(LTRIM(' + ltbColunas.Items[iRepeat] + '))) = 0' ; //+ ' or '+ ltbColunas.Items[iRepeat] + ' is NUll';


            DtmMigrationExpress.SQLCorrige.ExecSQL(UpdateCamposVazios);




            //lstLogs.Items.Add(UpdateCamposVazios);
            //Application.ProcessMessages;

            //var LPath : String;
            //LPath := ExtractFileDir(Application.ExeName);
            //lstLogs.Items.SaveToFile(LPath+'\TempoConversãoTabelas.txt');

            Inc(iRepeat,1);
            sTabelaRepeat := sTabela;

            if iRepeat < ltbTabelas.Items.Count then
              sSairRepeat := ltbTabelas.Items[iRepeat]
            else
              sSairRepeat := '';

          until sTabela <> sSairRepeat;

          //ShowMessage(sTabela + '  ' + sColuna);

          DtmMigrationExpress.FDQuery_VALORCOLUNA.Close;
          DtmMigrationExpress.FDQuery_VALORCOLUNA.SQL.Clear;
          DtmMigrationExpress.FDQuery_VALORCOLUNA.SQL.Add('SELECT ' + sColuna + ' FROM ' + sTabela);
          DtmMigrationExpress.FDQuery_VALORCOLUNA.Open;
          if DtmMigrationExpress.FDQuery_VALORCOLUNA.RecordCount > 0 then
          begin
            DtmMigrationExpress.FDQuery_VALORCOLUNA.First;
            pgbWhile.MaxValue := DtmMigrationExpress.FDQuery_VALORCOLUNA.RecordCount;
            pgbWhile.MinValue := 0;
            pgbWhile.Progress := 0;

            while not DtmMigrationExpress.FDQuery_VALORCOLUNA.Eof do
            begin
              var IntField : Integer;
              for IntField := 0 to DtmMigrationExpress.FDQuery_VALORCOLUNA.FieldCount - 1 do
              begin
                DtmMigrationExpress.FDQuery_VALORCOLUNA.Fields[IntField];

                var sRegistroAntesCorrigir := DtmMigrationExpress.FDQuery_VALORCOLUNA.Fields[IntField].Text;
                var sRegistroCorrigido     := DtmMigrationExpress.RemoveChar(DtmMigrationExpress.FDQuery_VALORCOLUNA.Fields[IntField].Text,0);

                if (DtmMigrationExpress.FDQuery_VALORCOLUNA.Fields[IntField].Text <> sRegistroCorrigido) then
                begin
                  lstLogs.ItemIndex := lstLogs.Items.Count - 1;

                  if Length(sRegistroCorrigido) = 0 then
                    sRegistroCorrigido := 'NULL';

                  pgbWhile.Progress := DtmMigrationExpress.FDQuery_VALORCOLUNA.RecNo;
                  lblTbl.Caption    := sTabela + ' ; ' + DtmMigrationExpress.FDQuery_VALORCOLUNA.Fields[IntField].FieldName + ' ; Correção: ' + sRegistroAntesCorrigir +
                                                                                              ' ; Registro: ' + IntToStr(DtmMigrationExpress.FDQuery_VALORCOLUNA.Recno);
                  Application.ProcessMessages;

                  if sRegistroCorrigido = 'NULL' then
                  begin
                    if DtmMigrationExpress.FDQuery_VALORCOLUNA.Fields[IntField].FieldName = 'PRO_CODIGO' then
                      begin
                        sRegistroCorrigido := '0';
                        DtmMigrationExpress.SQLCorrige.ExecSQL('UPDATE ' + sTabela +
                                                             ' SET '   + sTabela + '.' + DtmMigrationExpress.FDQuery_VALORCOLUNA.Fields[IntField].FieldName + ' = ' + sRegistroCorrigido +
                                                             ' FROM '  + sTabela +
                                                             ' WHERE ' + sTabela + '.' + DtmMigrationExpress.FDQuery_VALORCOLUNA.Fields[IntField].FieldName + ' = ' + QuotedStr(sRegistroAntesCorrigir));
                      end
                    else
                      DtmMigrationExpress.SQLCorrige.ExecSQL('UPDATE ' + sTabela +
                                                             ' SET ' + sTabela + '.' + DtmMigrationExpress.FDQuery_VALORCOLUNA.Fields[IntField].FieldName + ' = ' + sRegistroCorrigido +
                                                             ' FROM ' + sTabela +
                                                             ' WHERE ' + sTabela + '.' + DtmMigrationExpress.FDQuery_VALORCOLUNA.Fields[IntField].FieldName + ' = ' + QuotedStr(sRegistroAntesCorrigir))
                  end
                  else
                    DtmMigrationExpress.SQLCorrige.ExecSQL('UPDATE ' + sTabela +
                                                           ' SET ' + sTabela + '.' + DtmMigrationExpress.FDQuery_VALORCOLUNA.Fields[IntField].FieldName + ' = ' + QuotedStr(sRegistroCorrigido) +
                                                           ' FROM ' + sTabela +
                                                           ' WHERE ' + sTabela + '.' + DtmMigrationExpress.FDQuery_VALORCOLUNA.Fields[IntField].FieldName + ' = ' + QuotedStr(sRegistroAntesCorrigir));

                  lstLogs.Items.Add(sTabela + ' || ' + DtmMigrationExpress.FDQuery_VALORCOLUNA.Fields[IntField].FieldName + ' : "' + sRegistroAntesCorrigir + '" <> "' + sRegistroCorrigido + '"');
                end;
              end;
              Application.ProcessMessages;
              DtmMigrationExpress.FDQuery_VALORCOLUNA.Next;
            end;
            pgbWhile.Progress := 0;
          end;
        end
        else
        begin
          sTabelaRepeat := '';
        end;

      end;
      Application.ProcessMessages;
    end;

    pgbFor.Progress                           := 0;
    btnProcessarInconsistenciaERP.ModalResult := mrOK;
    lblTbl.Caption
                                := '';
  // Ativando o Botão
    btnAbaConversao.Enabled       := True;

    Application.MessageBox('Processo de ajuste na base do RP finalizado!','Ajuste', + MB_ICONINFORMATION);

    // Aparencia  do Botão depois de finalizar o processo
    btnValidacaoDatabase.Appearance.BorderColor     := $0051C800;
    btnValidacaoDatabase.Appearance.Color           := $0051C800;
    btnValidacaoDatabase.Appearance.ColorMirror     := $0051C800;
    btnValidacaoDatabase.Appearance.ColorMirrorTo   := $0051C800;
    btnValidacaoDatabase.Appearance.ColorTo         := $0051C800;

    // Aparencia quando esta com mouse em cima do botão
    btnValidacaoDatabase.Appearance.BorderColorHot   := $00337E00;
    btnValidacaoDatabase.Appearance.ColorHot         := $00337E00;
    btnValidacaoDatabase.Appearance.ColorHotTo       := $00337E00;
    btnValidacaoDatabase.Appearance.ColorMirrorHot   := $00337E00;
    btnValidacaoDatabase.Appearance.ColorMirrorHotTo := $00337E00;
    btnValidacaoDatabase.Hint                        := 'Ajuste na base do RP finalizado!' + #13 + 'Status : OK';
    pcMenu.ActivePage := tbConverterDatabase;

  except on E: Exception do
    btnProcessarInconsistenciaERP.Enabled := True;
  end;
end;

procedure TFrmMigrationExpress.btnValidacaoDatabaseClick(Sender: TObject);
begin
  pcMenu.ActivePage := tbValidarDatabase;
end;

procedure TFrmMigrationExpress.DBGridEhFiliaisERPExit(Sender: TObject);
begin
  if DBGridEhFiliaisERP.DataSource.DataSet.State in dsEditModes then
    DBGridEhFiliaisERP.DataSource.DataSet.Post;
end;

procedure TFrmMigrationExpress.DBGridEhFiliaisERPKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Shift = []) and (Key = VK_SPACE) then
    DBGridEhFiliaisERP.SelectedRows.CurrentRowSelected := not (DBGridEhFiliaisERP.SelectedRows.CurrentRowSelected);
end;

procedure TFrmMigrationExpress.DBGridEhFiliaisERPSelectedRowsItemChanged(Sender: TCustomDBGridEh; Item: TArray<System.Byte>; Action: TListNotification);
begin
  if DtmMigrationExpress.FIL_00.State in [dsBrowse] then
    DtmMigrationExpress.FIL_00.Edit;
end;

procedure TFrmMigrationExpress.DBGridEhFiliaisERPSelectionChanged(Sender: TObject);
begin
  if (DtmMigrationExpress.FIL_00.RecordCount > 0) then
  begin
    if (DBGridEhFiliaisERP.SelectedRows.CurrentRowSelected)
       and (Length(DtmMigrationExpress.FIL_00.FieldByName('COM_CODIGO').AsString) > 0) then
    begin
      if DtmMigrationExpress.FIL_00.State in [dsBrowse] then
        DtmMigrationExpress.FIL_00.Edit;

      DtmMigrationExpress.FIL_00.FieldByName('FIL_SELECIONADO').AsString := 'S';
      DtmMigrationExpress.FIL_00.Post;
    end
    else
    begin
      if DtmMigrationExpress.FIL_00.State in [dsBrowse] then
        DtmMigrationExpress.FIL_00.Edit;

      DtmMigrationExpress.FIL_00.FieldByName('FIL_SELECIONADO').AsString := 'N';
      DBGridEhFiliaisERP.SelectedRows.CurrentRowSelected := False;
      DtmMigrationExpress.FIL_00.Post;
    end;
  end;
end;

procedure TFrmMigrationExpress.ExecutarTodosScripts;
var
  iFile : Integer;
  sNomeTbl, sCampoIdOld: String;
begin
  if lstArqsBusca.Items.Count > 0 then
  begin
    lblNumberFound.Caption := '';
    try
      lstArqsBusca.Enabled := False;
      GaugeReparo.Progress := 0;
      GaugeReparo.MaxValue := lstArqsBusca.Items.Count;
      lstReparoLogs.Lines.Clear;

      for iFile := 0 to lstArqsBusca.Items.Count -1 do
      begin
        if lstArqsBusca.Checked[iFile] then
        begin
          lstArqsBusca.Checked[iFile] := False;

          var lTime := Time;

          try
            sNomeTbl := ExtractFileName(lstArqsBusca.Items[iFile]);
            sNomeTbl := Copy(sNomeTbl,1,Pos('.',sNomeTbl) -1);

            if Length(sNomeTbl) = 6 then
              sCampoIdOld := Copy(sNomeTbl, 1, Pos('_', sNomeTbl) - 1) + '_ID_OLD'
            else if Length(sNomeTbl) = 9 then
              sCampoIdOld := Copy(sNomeTbl, 1, Pos('_', sNomeTbl) - 1) + Copy(sNomeTbl, 7, Pos('_', sNomeTbl) - 1) + '_ID_OLD'
            else
              sCampoIdOld := Copy(sNomeTbl, 1, Pos('_', sNomeTbl) - 1) + '_ID_OLD';

            lblNumberFound.Caption := sNomeTbl;
            try
              DtmMigrationExpress.SQL_EXE.Connection := DtmMigrationExpress.ConnectionDestino;
              DtmMigrationExpress.SQL_EXE.Close;
              DtmMigrationExpress.SQL_EXE.SQL.Clear;
              DtmMigrationExpress.SQL_EXE.SQL.Add(' SELECT C.name FROM sys.sysobjects AS T (NOLOCK) ' );
              DtmMigrationExpress.SQL_EXE.SQL.Add(' INNER JOIN sys.all_columns AS C (NOLOCK) ON T.id = C.object_id AND T.XTYPE = ' + QuotedStr('U'));
              DtmMigrationExpress.SQL_EXE.SQL.Add(' WHERE T.NAME = ' + QuotedStr(sNomeTbl) + ' AND C.NAME = ' + QuotedStr(sCampoIdOld));
              DtmMigrationExpress.SQL_EXE.Open;

              if DtmMigrationExpress.SQL_EXE.RecordCount > 0 then
                begin
                  DtmMigrationExpress.SQL_EXE.Close;
                  DtmMigrationExpress.SQL_EXE.SQL.Clear;
                  DtmMigrationExpress.SQL_EXE.SQL.Add(' SELECT ' + sCampoIdOld + ' FROM ' + sNomeTbl);
                  DtmMigrationExpress.SQL_EXE.Open;

                if DtmMigrationExpress.SQL_EXE.RecordCount > 0 then
                  begin
                    DtmMigrationExpress.SQL_EXE.Close;
                    DtmMigrationExpress.SQL_EXE.SQL.Clear;
                    DtmMigrationExpress.SQL_EXE.SQL.Add(' SELECT SUM(CAST(' + sCampoIdOld + ' AS BIGINT)) AS OLD FROM ' + sNomeTbl);
                    DtmMigrationExpress.SQL_EXE.Open;
                    try
                      if DtmMigrationExpress.SQL_EXE.Fields[0].FieldName = 'OLD' then
                        lstReparoLogs.Lines.Add('Sequence da table [' + sNomeTbl + '] já executado.')
                      else
                        begin
                          lstReparoLogs.Lines.Add('Executando Script : ' + sNomeTbl);

                          ExecutScriptSQL(lstArqsBusca.Items[iFile],DtmMigrationExpress.ConnectionDestino.Params.Database);
                          lstReparoLogs.Lines.Add(TimeToStr(LTime - Time) + ' - ' + sNomeTbl);
                        end;
                    except on EXC: Exception do
                      DtmMigrationExpress.MessageDlgColor(PChar('ExecutScriptSQL' + #13#13 + EXC.Message), 'Atenção', mtWarning, [mbOK], $002E2E2E, clRed);
                    end;
                  end
                else
                  lstReparoLogs.Lines.Add('Não há registro na tabela ' + sNomeTbl);
                end
              else
                begin
                  ExecutScriptSQL(lstArqsBusca.Items[iFile], DtmMigrationExpress.ConnectionDestino.Params.Database);
                  lstReparoLogs.Lines.Add(TimeToStr(Time) + ' - Executando Script para a table ' + sNomeTbl);
                end;
            finally
              DtmMigrationExpress.SQL_EXE.Close;
            end;
            GaugeReparo.Progress := iFile;
          except on EXC: Exception do
            ShowMessage(Pchar('Error ' + #13#13 + EXC.Message));
          end;
        end;
        Application.ProcessMessages;
      end;
//      DtmMigrationExpress.MessageDlgColor('SCRIPTS EXECUTADOS COM SUCESSO.', 'Sucesso',mtCustom, [mbOK], $002E2E2E, clWhite);
    finally
      lstArqsBusca.Enabled := True;
      GaugeReparo.Progress := 0;
    end;
  end;
end;

function TFrmMigrationExpress.ExecutScriptSQL(pArquivoSQL, pDataBaseName: String): String;
//-----------------------------------------------------------------------------------
  function  funRetornaTexto(Texto:String; Caracter:Char):String;
  var
    I, Posicao1, Posicao2 : Integer;
    TextoInvertido : String;
  begin
    Result := '';
    for I  := Length(Texto) downto 1 do
      begin
        TextoInvertido := TextoInvertido + Texto[I];
        Application.ProcessMessages;
      end;

    Posicao1 := Pos(Caracter, Texto) + 1;
    Posicao2 := Pos(Caracter, TextoInvertido) - 1;
    Result   := Copy(Texto, Posicao1, Length(Texto) - (Posicao1 + Posicao2));
  end;
//-----------------------------------------------------------------------------------
  procedure proVerTexto(Texto :string; pMemo: TMemo);
  begin
    pMemo.SetFocus;
    if Pos(Texto, pMemo.Lines.Text) <> 0 then
    begin
      pMemo.SelStart  := Pos(Texto,pMemo.Lines.Text) - 1;
      pMemo.SelLength := Length(Texto);
    end;
  end;
//-----------------------------------------------------------------------------------
  procedure EXECSQLDirect(SQL: String; pConnFDC: TFDConnection);
  var
    sCarac  : String;
    Retorno : Integer;
  begin
    try
//      {Tenta Rodar o Script}
//      if chkNaoGerarIndices.Checked then
//      begin
//        if Pos('INDEX', SQL) = 0 then
//          Retorno := pConnFDC.ExecSQL(SQL);
//      end
//      else
      Retorno := pConnFDC.ExecSQL(SQL);

      Application.ProcessMessages;

    except on E: Exception do
      begin
        lstReparoLogs.Lines.Add('395 [EXECSQLDirect] Erro Script ' + E.Message);
//        proMarcaPalavra(Char(39),lstReparoLogs);

        lstReparoLogs.Lines.Add('Arquivo: ' + ExtractFileName(pArquivoSQL) + ' ');
        lstReparoLogs.Lines.Add(SQL);
        lstReparoLogs.Lines.Add(' ');
      end;
    end
  end;
//-----------------------------------------------------------------------------------
  function  SQLExec(pCommandText, pDatabaseName: String): String;
  begin
    try
      Result := '_';
      EXECSQLDirect(pCommandText, DtmMigrationExpress.ConnectionDestino);
    except on E: Exception do
      begin
        Result := 'E';
        lstReparoLogs.Lines.Add('415 Erro Script ' + E.Message);
        lstReparoLogs.Lines.Add('416 [SQLExec] - Arquivo: ' + ExtractFileName(pArquivoSQL));
      end;
    end;
  end;
//-----------------------------------------------------------------------------------
var
  objTextFile, objTextFile_Count : TextFile;
  vNomeArquivo, TextFileLine     : String;
  QtdLinhasTextFile              : Integer;
  Retorno                        : String;
  LineText                       : String;
  ComandoSQL                     : TStringList;
  Linha                          : Integer;
begin
  Result := '_';

  // Conta quantidade de linhas do arquivo.
  QtdLinhasTextFile := 0;
  AssignFile(objTextFile_Count, pArquivoSQL);
  Reset(objTextFile_Count);
  while not (Eof(objTextFile_Count)) Do
  begin
    Readln(objTextFile_Count);
    QtdLinhasTextFile := QtdLinhasTextFile + 1;
    Application.ProcessMessages;
  end;
  Closefile(objTextFile_Count);

  Linha := 0;
  Sleep(200);
  if Length(pArquivoSQL) > 0 then
  begin
    try
      try
        vNomeArquivo := ExtractFileName(pArquivoSQL);
        ComandoSQL   := TStringList.Create;

        AssignFile(objTextFile, pArquivoSQL);
        Reset(objTextFile);

        // Exibindo o conteúdo do arquivo
        while not Eof(objTextFile) do
        begin
          Linha := Linha + 1;

          ReadLn(objTextFile, TextFileLine);
          LineText := Trim(TextFileLine);
          if Length(LineText) > 0 then
          begin
            // Obs : A funçao so vai entender o GO no final da linha ou em uma linha sozinha.
            if (Pos('TRANSACTION', LineText) > 0) or (Pos('COMMIT', LineText) > 0) then
            begin
              ReadLn(objTextFile, TextFileLine);
              Continue;
            end;
            // Valida se existe GO no final da linha.
            if Copy(LineText, (Length(LineText) - 1), 2) = 'GO' then
            begin
              try
                try
                  // Se o GO estiver no final da linha copia o inicio da linha.
                  ComandoSQL.Add(Copy(LineText, 1, (Length(LineText) - 2)));
                finally
                  Insert(SQLExec(ComandoSQL.Text + #10#10#13, pDataBaseName), Retorno, 1);
                  ComandoSQL.Clear;
                end;
              except on EXC: Exception do
                ShowMessage(Pchar('Error!'+ EXC.Message));
              end;
            end
            else
              if Copy(Trim(LineText), 1, 2) <> '--' then
               begin
                // Adiciona Comando SQL.
                ComandoSQL.Add(LineText);
               end;
          end;
          Application.ProcessMessages;
        end;
      finally
        //Verifica se Hourve Error
        if Pos('E',Retorno) = 0 then
          Result := '_'
        else
          Result := 'E';

        CloseFile(objTextFile);
        FreeAndNil(ComandoSQL);
      end;
    except on EXC: Exception do
      begin
        Result := 'E';
      end;
    end;
  end;
end;

procedure TFrmMigrationExpress.FieldDoORM(Field: TRttiProperty);
begin
  lblField.Caption := Field.Name;
end;

procedure TFrmMigrationExpress.FormCreate(Sender: TObject);
begin
  //FCommandMonitorEXPRESS := TCommandMonitorEXPRESS.Create;
  FrmMigrationExpress := Self;

  //Criando a lista para inserção das tabelas.
  GListCopyDataSet := TStringList.Create;

  var LCaminho  := ExtractFilePath(Application.ExeName) + '\ListaCopyDataSet.txt';

  GListCopyDataSet.LoadFromFile(LCaminho);
  DtmMigrationExpress.AbrirBackup;
end;

procedure TFrmMigrationExpress.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Shift = [ssAlt]) and (Chr(Key)='C') then
    btnConectarBancosClick(Sender)
  else if (Shift = [ssAlt]) and (Chr(Key)='E') then
    btnBuscarEmpresaClick(Sender)
  else if (Shift = [ssAlt]) and (Chr(Key)='V') then
    btnValidacaoDatabaseClick(Sender)
end;

procedure TFrmMigrationExpress.FormShow(Sender: TObject);
begin
  //Carrega parametros do arquivo ini
  TPARAMServer.Get.UpdatePARAMS;

  pcMenu.ActivePage     := tbMain;

  btnBuscarEmpresa.Hint := 'Executa a listagem das filiais presentes no banco de dados do ERP e confere qual ' + #13 +
                           'é o codigo no banco de dados do Authenticator para realizar as conexões dos servidores ' + #13 +
                           'ao finalizar a migração para o Express.';

  btnAlteracaoComCodigoManual.Hint     := 'Executa a troca de COM_CODIGO manualmente, informando valores.';

  btnAlteracaoComCodigoAutomatico.Hint := 'Executa a troca de COM_CODIGO percorrendo todos os registros marcados no Grid, ' + #13 +
                                          'informando os valores automaticamente de acordo com os valores dos respectivos ' + #13 +
                                          'campos FIL_CODIGO e COM_CODIGO Automaticamente.';


  lblTabela.Caption := '';
end;



procedure TFrmMigrationExpress.btnDuvidaMouseEnter(Sender: TObject);
begin
  frmInformacao.Show;
end;

procedure TFrmMigrationExpress.btnDuvidaMouseLeave(Sender: TObject);
begin
  frminformacao.Close;
end;

procedure TFrmMigrationExpress.pnl_ConectarDBDblClick(Sender: TObject);
begin
  if btnConectarBancos.ModalResult = mrOk then
    btnExcluirForeignKeys.Visible := True;
end;

procedure TFrmMigrationExpress.btnAbaReparoClick(Sender: TObject);
begin
  pcMenu.ActivePage := tbReparoDatabase;
end;

procedure TFrmMigrationExpress.btnExecutarReparoDatabaseClick(Sender: TObject);
var
  sPath_insert_Sequences_FieldsOld,
  sPath_updates_IDRelacionamento,
  sPath_updates_IDIntegracoes : String;
begin
  sPath_insert_Sequences_FieldsOld  := ExtractFilePath(Application.ExeName) + '_insert_Sequences_FieldsOld';
  sPath_updates_IDRelacionamento    := ExtractFilePath(Application.ExeName) + '_updates_IDRelacionamento';
  sPath_updates_IDIntegracoes       := ExtractFilePath(Application.ExeName) + '_updates_IDIntegracoes';

  if DirectoryExists(sPath_insert_Sequences_FieldsOld) then
  begin
    DirectoryListBox1.Directory := sPath_insert_Sequences_FieldsOld;
    btnBuscarClick(Sender);
    if lstArqsBusca.Items.Count > 0 then
      ExecutarTodosScripts;
  end;

  if DirectoryExists(sPath_updates_IDRelacionamento) then
  begin
    DirectoryListBox1.Directory := sPath_updates_IDRelacionamento;
    btnBuscarClick(Sender);
    if lstArqsBusca.Items.Count > 0 then
      ExecutarTodosScripts;
  end;

  if DirectoryExists(sPath_updates_IDIntegracoes) then
  begin
    DirectoryListBox1.Directory := sPath_updates_IDIntegracoes;
    btnBuscarClick(Sender);
    if lstArqsBusca.Items.Count > 0 then
      ExecutarTodosScripts;
  end;
  btnExecutarReparoDatabase.ModalResult := mrOk;
  DtmMigrationExpress.MessageDlgColor('Processo finalizado.', 'Execução de Scripts',mtCustom, [mbOK], $002E2E2E, clWhite);

// Aparencia  do Botão depois de finalizar o processo
  btnAbaReparo.Appearance.BorderColor     := $0051C800;
  btnAbaReparo.Appearance.Color           := $0051C800;
  btnAbaReparo.Appearance.ColorMirror     := $0051C800;
  btnAbaReparo.Appearance.ColorMirrorTo   := $0051C800;
  btnAbaReparo.Appearance.ColorTo         := $0051C800;

// Aparencia quando esta com mouse em cima do botão
  btnAbaReparo.Appearance.BorderColorHot   := $00337E00;
  btnAbaReparo.Appearance.ColorHot         := $00337E00;
  btnAbaReparo.Appearance.ColorHotTo       := $00337E00;
  btnAbaReparo.Appearance.ColorMirrorHot   := $00337E00;
  btnAbaReparo.Appearance.ColorMirrorHotTo := $00337E00;
  btnAbaReparo.Hint                        := 'Scripts executados!' + #13 + 'Status : OK';
  pcMenu.ActivePage     := tbMain;

  frmfinalizado.ShowModal;

//  btnBuscarEmpresa.Enabled      := False;
//  btnValidacaoDatabase.Enabled  := False;
//  btnAbaConversao.Enabled       := False;
//  btnAbaReparo.Enabled          := False;
end;


procedure TFrmMigrationExpress.btnExcluirForeignKeysClick(Sender: TObject);
begin
//  DtmMigrationExpress.DeletandoForeignKeys;
//  DtmMigrationExpress.UpdateXML_00(lblInstrucao, lblTitulo);
end;

procedure TFrmMigrationExpress.btnBuscarClick(Sender: TObject);
var
  vPathRaiz: String;
begin
  vPathRaiz := DirectoryListBox1.Directory;
  lstArqsBusca.Clear;
  DtmMigrationExpress.FileSearch(vPathRaiz, '*.sql', True, lstArqsBusca.Items);
  lblNumberFound.Caption := Inttostr(lstArqsBusca.Items.Count) + ' arquivos encontrados.';

  for var i := 0 to lstArqsBusca.Items.Count -1 do
  begin
    lstArqsBusca.Checked[I] := True;
    Application.ProcessMessages;
  end;
end;

procedure TFrmMigrationExpress.tbAlteracaoComCodigoShow(Sender: TObject);
begin
  if btnBuscarEmpresa.ModalResult = mrOk then
    Exit;

  try
    if not (DtmMigrationExpress.ConnectionOrigem.Connected) then
      Exit;

    DtmMigrationExpress.AddComCodigoFilSelecionado_FIL00;
    DtmMigrationExpress.FIL_00.SQL.Clear;
    DtmMigrationExpress.FIL_00.SQL.Add(' SELECT FIL_CODIGO '+
                                       ' ,COM_CODIGO '+
                                       ' ,FIL_CNPJ '+
                                       ' ,FIL_RAZAO '+
                                       ' ,FIL_FANTASIA_OU_APELIDO '+
                                       ' ,FIL_IE '+
                                       ' ,UFS_SIGLA '+
                                       ' ,FIL_DESATIVADO '+
                                       ' ,FIL_SELECIONADO' +
                                       ' FROM FIL_00');
    DtmMigrationExpress.FIL_00.Open;
    DtmMigrationExpress.FIL_00.FetchAll;
    DtmMigrationExpress.FIL_00.First;

    while not (DtmMigrationExpress.FIL_00.Eof) do
    begin
      if (DBGridEhFiliaisERP.SelectedRows.CurrentRowSelected = False)
         and (Length(DtmMigrationExpress.FIL_00.FieldByName('COM_CODIGO').AsString) > 0) then
      begin
        DBGridEhFiliaisERP.SelectedRows.CurrentRowSelected := True;
      end;
      DBGridEhFiliaisERPSelectionChanged(Sender);

      DtmMigrationExpress.FIL_00.Next;
    end;
  except on EXC: Exception do
    begin
      Application.MessageBox(PChar('TFrmMigrationExpress.tbAlteracaoComCodigoShow' + #13#13 + EXC.Message),'Perigo!',MB_OK + MB_ICONWARNING);
    end;
  end;
end;

procedure TFrmMigrationExpress.tbConverterDatabaseShow(Sender: TObject);
begin
  if btnExecutarConversao.ModalResult = mrOk then
    Exit;
end;

procedure TFrmMigrationExpress.tbReparoDatabaseShow(Sender: TObject);
begin
  if btnExecutarReparoDatabase.ModalResult = mrOk then
  begin
    Exit;
  end;
  DirectoryListBox1.Directory := ExtractFilePath(Application.ExeName);
end;

procedure TFrmMigrationExpress.tbValidarDatabaseShow(Sender: TObject);
begin
  lblTbl.Caption := '';
  var LPath      := ExtractFileDir(Application.ExeName);

  ltbTabelas.Items.LoadFromFile(LPath + '\_ListaTabelasVerificacaoDB.txt');
  ltbColunas.Items.LoadFromFile(LPath + '\_ListaColunasVerificacaoDB.txt');
end;

procedure TFrmMigrationExpress.TimerProcesamentoTabelaTimer(Sender: TObject);
begin
  lblTempoProcessamento.Caption := 'Tempo Processado : '+ TimeToStr(Time - DtmMigrationExpress.LTempo);
  Application.ProcessMessages;
end;

procedure TFrmMigrationExpress.btnExecutarConversaoClick(Sender: TObject);
begin
  if (DtmMigrationExpress.ConnectionOrigem.Connected) and (DtmMigrationExpress.ConnectionDestino.Connected) then
  begin
    try
      lblHoraInicio.Caption        := 'Hora Inicial: ' + TimeToStr(Time);
      GaugeConversao.MaxValue      := 331;
      GaugeConversao.Progress      := 0;
      lblHoraFinal.Visible         := False;
      btnExecutarConversao.Enabled := False;
      Application.ProcessMessages;
      DtmMigrationExpress.AjustesAntes;
      DtmMigrationExpress.ExecutarConversao(lblHoraInicio, lblHoraFinal, lblTempo, lblTempoProcessamento, lblTabelaAtual , lblFuncao,
                                            GListCopyDataSet, lstTempoTabela, GaugeConversao, GaugeWhile, TimerProcesamentoTabela,
                                            lblRowCopyRecord, lblTotalRowCopyRecord);
      DtmMigrationExpress.AjustesDepois;
      btnExecutarConversao.Enabled     := False;
      btnExecutarConversao.ModalResult := mrOk;

    //   Ativando o Botão
     btnAbaReparo.Enabled          := True;

    // Aparencia  do Botão depois de finalizar o processo
      btnAbaConversao.Appearance.BorderColor     := $0051C800;
      btnAbaConversao.Appearance.Color           := $0051C800;
      btnAbaConversao.Appearance.ColorMirror     := $0051C800;
      btnAbaConversao.Appearance.ColorMirrorTo   := $0051C800;
      btnAbaConversao.Appearance.ColorTo         := $0051C800;

    // Aparencia quando esta com mouse em cima do botão
      btnAbaConversao.Appearance.BorderColorHot   := $00337E00;
      btnAbaConversao.Appearance.ColorHot         := $00337E00;
      btnAbaConversao.Appearance.ColorHotTo       := $00337E00;
      btnAbaConversao.Appearance.ColorMirrorHot   := $00337E00;
      btnAbaConversao.Appearance.ColorMirrorHotTo := $00337E00;
      btnAbaConversao.Hint                        := 'Migração de DataBase finalizada!' + #13 + 'Status : OK';
      pcMenu.ActivePage := tbReparoDatabase;

    except on EXC: Exception do
      begin
        Application.MessageBox(PChar('TFrmMigrationExpress.btnExecutarConversaoClick' + #13#13 + EXC.Message),'Perigo',MB_OK+MB_ICONWARNING);
      end;
    end;
  end;
end;

procedure TFrmMigrationExpress.btnAbaConversaoClick(Sender: TObject);
begin
  pcMenu.ActivePage := tbConverterDatabase;
end;

procedure TFrmMigrationExpress.btnAbrirBackupClick(Sender: TObject);
begin
  DtmMigrationExpress.AbrirBackup;
end;

procedure TFrmMigrationExpress.btnAlteracaoComCodigoAutomaticoClick(Sender: TObject);
begin
  if DBGridEhFiliaisERP.DataSource.DataSet.RecordCount = 0 then
    Exit;
  if DtmMigrationExpress.ConnectionOrigem.Connected then
    begin
      DtmMigrationExpress.AlteracaoComCodigoAutomatico(GaugeAlterarComCodigo, edtOrigem, edtDestino, lblTabela);
      DtmMigrationExpress.FIL_00.Close;
      DtmMigrationExpress.FIL_00.Open;
      edtOrigem.ValueInt                      := 0;
      edtDestino.ValueInt                     := 0;
      GaugeAlterarComCodigo.Progress          := 0;
      GaugeAlterarComCodigo.MinValue          := 0;
      GaugeAlterarComCodigo.MaxValue          := 0;
      btnAlteracaoComCodigoAutomatico.Enabled := False;
      lblTabela.Caption                       := '';
      btnBuscarEmpresa.ModalResult            := mrOk;

      btnValidacaoDatabase.Enabled  := True;

    // Aparencia do Botão depois de finalizar o processo
      btnBuscarEmpresa.Appearance.BorderColor     := $0051C800;
      btnBuscarEmpresa.Appearance.Color           := $0051C800;
      btnBuscarEmpresa.Appearance.ColorMirror     := $0051C800;
      btnBuscarEmpresa.Appearance.ColorMirrorTo   := $0051C800;
      btnBuscarEmpresa.Appearance.ColorTo         := $0051C800;

    // Aparencia quando esta com mouse em cima do botão
      btnBuscarEmpresa.Appearance.BorderColorHot   := $00337E00;
      btnBuscarEmpresa.Appearance.ColorHot         := $00337E00;
      btnBuscarEmpresa.Appearance.ColorHotTo       := $00337E00;
      btnBuscarEmpresa.Appearance.ColorMirrorHot   := $00337E00;
      btnBuscarEmpresa.Appearance.ColorMirrorHotTo := $00337E00;
      btnBuscarEmpresa.Hint                        := 'Troca do codigo da filial finalizado!' + #13 + 'Status : Ok';
      pcMenu.ActivePage := tbValidarDatabase;
    end
  else
    begin
      Application.MessageBox('Favar Conectar Database.','Atenção', MB_OK + MB_ICONEXCLAMATION);
    end;
end;

procedure TFrmMigrationExpress.btnAlteracaoComCodigoManualClick(Sender: TObject);
begin
  if DtmMigrationExpress.ConnectionOrigem.Connected then
  begin
    if (edtOrigem.ValueInt = 0) or (edtDestino.ValueInt = 0) then
    begin
      Exit;
    end
    else
    begin
      if Application.MessageBox('Continuar a Operação?','Atenção', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES then
        begin
          DtmMigrationExpress.UpdateValorTodosCampos_ComCodigo(GaugeAlterarComCodigo, edtOrigem.ValueInt, edtDestino.ValueInt, lblTabela);
        end;

      DtmMigrationExpress.FIL_00.Refresh;

      if not (DtmMigrationExpress.FIL_00.State in dsEditModes) then
        DtmMigrationExpress.FIL_00.edit;

      DtmMigrationExpress.FIL_00.FieldByName('COM_CODIGO').AsString := DtmMigrationExpress.FIL_00.FieldByName('FIL_CODIGO').AsString;

      if DtmMigrationExpress.FIL_00.State in dsEditModes then
        DtmMigrationExpress.FIL_00.Post;

      edtOrigem.ValueInt             := 0;
      edtDestino.ValueInt            := 0;
      GaugeAlterarComCodigo.Progress := 0;
      GaugeAlterarComCodigo.MinValue := 0;
      GaugeAlterarComCodigo.MaxValue := 0;
      lblTabela.Caption              := '';
      Application.MessageBox('Para Concluir o Processso de Troca, Selecione a Filial e' + #13 + 'click no botão [Automático]','Troca de Código da filial', + MB_ICONEXCLAMATION);
    end;
  end
  else
  begin
    Application.MessageBox('Favor Conectar Database.','Atenção', MB_OK + MB_ICONEXCLAMATION);
  end;
end;
end.
