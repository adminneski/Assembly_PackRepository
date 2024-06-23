unit DlgNSK_DBLocalizaPlus;

interface

uses
  Windows, Messages, Classes, Graphics, Controls, StdCtrls,
  ExtCtrls, Forms, DBGrids, Db, ComCtrls, Grids, DBClient, dialogs, DBCtrls,
  Buttons,NSK_DBLocalizaPlus, Vcl.Imaging.pngimage, IniFiles, System.SysUtils, Data.SqlConst, Data.SqlExpr;

type
  TDlgDBLocalizaPlus = class(TForm)
    DTS: TDataSource;
    FIND: TClientDataSet;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel5: TPanel;
    DBGPesquise: TDBGrid;
    memOBS: TDBMemo;
    Panel3: TPanel;
    AxLabel1: TLabel;
    DBGridPSQ: TDBGrid;
    PSQ: TClientDataSet;
    DTSPSQ: TDataSource;
    Panel6: TPanel;
    Panel7: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    DBText1: TDBText;
    Panel4: TPanel;
    EDTPesquise: TEdit;
    lbDescricao: TLabel;
    GradBtn1: TBitBtn;
    BtnConfirma: TBitBtn;
    Label4: TLabel;
    fixPSQ: TClientDataSet;
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EDTPesquiseChange(Sender: TObject);
    procedure DBGridPSQCellClick(Column: TColumn);
    procedure PSQBeforeScroll(DataSet: TDataSet);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DBGPesquiseColumnMoved(Sender: TObject; FromIndex, ToIndex: Integer);
    procedure DBGPesquiseEnter(Sender: TObject);
    procedure DBGPesquiseExit(Sender: TObject);
    procedure DTSDataChange(Sender: TObject; Field: TField);
    procedure FINDAfterOpen(DataSet: TDataSet);
    procedure DBGridPSQDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FINDBeforeOpen(DataSet: TDataSet);
    procedure FINDAfterClose(DataSet: TDataSet);
  private
    FActive: Boolean;
    FStreamedActive: Boolean;

    LSumWidthColsEnter,
    LSumWidthColsExit: Integer;
    LFixPSQ: TClientDataSet;
    //FSQLConnection: TSQLConnection;
    FKeepConnection: Boolean;
    [Weak]FSQLConnection: TSQLConnection;
    LSelectedIndexPesquisa: Integer;

    function GetWidth(Texto: String): Integer;

    function  GetSQLConnection: TSQLConnection;

    procedure CheckInactive;
    procedure SetSQLConnection(Value: TSQLConnection);
    procedure proOrdenarColunasDBGrid(AFieldPesquisaCorrente: String);
    procedure proReorderPSQ_ORDER(APSQ, AFixPSQ: TClientDataSet; AOldOrderPSQ: Integer);
    { Private declarations }
  protected
    procedure SetActive(Value: Boolean);
  public
    { Public declarations }
    FPathNameTemplateGridUser: String;
    axTitles: TStringList;
    axMask: TStringList;
    axLocate: Boolean;
    axLocateField: String;
    axMemoField: String;
    axSELECT: String;
    axWHERE: String;
    axORDERBY: String;
    axMostraTodosRegistrosAbrir: Boolean;
    axAscDescOrderByField: String;
    axReordenarColunas: Boolean;
    property SQLConnection: TSQLConnection read  FSQLConnection write SetSQLConnection;
  published
    { Published declarations }

  end;
var
  DlgDBLocalizaPlus: TDlgDBLocalizaPlus;
  FixOrderPSQ: TSQLQuery;

implementation


{$R *.DFM}

procedure TDlgDBLocalizaPlus.FINDBeforeOpen(DataSet: TDataSet);
begin
//
end;

procedure TDlgDBLocalizaPlus.FINDAfterClose(DataSet: TDataSet);
begin
  if axReordenarColunas  then
    LSelectedIndexPesquisa := -1;
end;

procedure TDlgDBLocalizaPlus.FINDAfterOpen(DataSet: TDataSet);
begin
  if FIND.RecordCount = 0 then Exit;

  if (PSQ.FieldByName('PSQ_ORDER').AsInteger <> 0) and (axReordenarColunas) then
    proReorderPSQ_ORDER(PSQ,LFixPSQ, PSQ.FieldByName('PSQ_ORDER').AsInteger);

  if axReordenarColunas then
    proOrdenarColunasDBGrid(PSQ.FieldByName('PSQ_FIELDPESQUISA').AsString);
end;


//procedure TDlgDBLocalizaPlus.proOrdenarColunasDBGrid(AFixOrderPSQ: TSQLQuery);
procedure TDlgDBLocalizaPlus.proOrdenarColunasDBGrid(AFieldPesquisaCorrente: String);
begin
  //Posicionar na coluna do Field usado para o Filtro
  if PSQ.RecordCount > 0 then
  begin
    for var intFor := 0 to DBGPesquise.Columns.Count -1 do
    begin
      if UpperCase(AFieldPesquisaCorrente) = UpperCase(DBGPesquise.Columns[intFor].FieldName) then
      begin
        DBGPesquise.SelectedIndex := intFor;
        LSelectedIndexPesquisa    := intFor;

        Break;
      end;
    end;
  end;
end;

procedure TDlgDBLocalizaPlus.proReorderPSQ_ORDER(APSQ, AFixPSQ: TClientDataSet; AOldOrderPSQ: Integer);
begin
  try
    FixOrderPSQ               := TSQLQuery.Create(nil);
    FixOrderPSQ.SQLConnection := SQLConnection;
    FixOrderPSQ.SQL.Clear;

    //Guarda informações do campo usado para a pesquisa
    var LPSQ_ID                  := APSQ.FieldByName('PSQ_ID').AsString;
    var LCurrentPSQ_FIELDPESQUIA := APSQ.FieldByName('PSQ_FIELDPESQUISA').AsString;
    var LCurrentPSQ_ORDER        := APSQ.FieldByName('PSQ_ORDER').AsInteger;
    var LPSQ_NOMETELA            := APSQ.FieldByName('PSQ_NOMETELA').AsString;
    var LPSQ_VISUALIZAR_MOD_ATA  := APSQ.FieldByName('PSQ_VISUALIZAR_MOD_ATA').AsString;


    APSQ.DisableControls;
    //Atribui a ordem atual ao campo que mantinha a ordem 1 para pesquisa
    FixOrderPSQ.SQL.ADD('UPDATE  dbo.PSQ_XX SET  PSQ_ORDER =  ' + LCurrentPSQ_ORDER.ToString) ;
    FixOrderPSQ.SQL.ADD(' WHERE (PSQ_NOMETELA = '+QuotedStr(LPSQ_NOMETELA)+')') ;
    FixOrderPSQ.SQL.ADD('   AND (PSQ_VISUALIZAR_MOD_ATA = '+QuotedStr(LPSQ_VISUALIZAR_MOD_ATA)+')') ;
    FixOrderPSQ.SQL.ADD('   AND (PSQ_ORDER = 0)') ;
    FixOrderPSQ.ExecSQL();

    //Atribui a ordem 1 para o atual campo pesquisado
    FixOrderPSQ.SQL.Clear;
    FixOrderPSQ.SQL.ADD('UPDATE  dbo.PSQ_XX SET  PSQ_ORDER =  0');
    FixOrderPSQ.SQL.ADD(' WHERE PSQ_ID = '+LPSQ_ID);
    FixOrderPSQ.ExecSQL();

    //Reabre pesquisa já atualizado
    FixOrderPSQ.SQL.Clear;
    FixOrderPSQ.SQL.ADD('SELECT * FROM dbo.PSQ_XX');
    FixOrderPSQ.SQL.ADD(' WHERE (PSQ_NOMETELA = '+QuotedStr(LPSQ_NOMETELA)+')') ;
    FixOrderPSQ.SQL.ADD('   AND (PSQ_VISUALIZAR_MOD_ATA = '+QuotedStr(LPSQ_VISUALIZAR_MOD_ATA)+')') ;
    FixOrderPSQ.SQL.ADD('   ORDER BY PSQ_ORDER') ;

    FixOrderPSQ.Open;

  finally
    FreeAndNil(FixOrderPSQ);
    APSQ.EnableControls;
  end;
end;

function TDlgDBLocalizaPlus.GetSQLConnection: TSQLConnection;
begin
  Result := FSQLConnection;
end;

procedure TDlgDBLocalizaPlus.SetActive(Value: Boolean);
var
  FileHandle: THandle;
begin
  if FActive <> Value then
  begin
    if (csReading in ComponentState) then
      FStreamedActive := Value
    else begin
      if not (csDestroying in ComponentState) and
         not Assigned(FSQLConnection) then
        DatabaseError(SConnectionNameMissing)
      else
      begin
        if Assigned(FSQLConnection) then
            FSQLConnection.SetTraceEvent(nil);

        FActive := Value;
      end;
    end;
  end;
end;

procedure TDlgDBLocalizaPlus.CheckInactive;
begin
  if FActive then
  begin
    if (csDesigning in ComponentState) or (csLoading in ComponentState) then
      SetActive(False)
    else
      DatabaseError(SMonitorActive, Self);
  end;
end;

procedure TDlgDBLocalizaPlus.SetSQLConnection(Value: TSQLConnection);
var
  IsActive: Boolean;
begin
  if Value <> FSQLConnection then
  begin
    IsActive := Active;
    CheckInactive;
    FSQLConnection := Value;
  end;
end;

Function TDlgDBLocalizaPlus.GetWidth(Texto:String):Integer;
var
  I,Posicao1,Posicao2:Integer;
  TextoInvertido:String;
begin
  Result:= 100;
  for I := Length(Texto) downto 1 do
  begin
    TextoInvertido:=TextoInvertido+Texto[I]
  end;
  Posicao1:=Pos('<',Texto)+1;
  Posicao2:=Pos('>',TextoInvertido)-1;
  Result:= StrToIntDef(Trim(Copy(Texto,Posicao1,Length(Texto)-(Posicao1+Posicao2))),100);
 end;



procedure TDlgDBLocalizaPlus.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if ActiveControl <> EDTPesquise then EDTPesquise.SetFocus;
end;

procedure TDlgDBLocalizaPlus.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  axReordenarColunas       := false;
  axMostraTodosRegistrosAbrir := false;
  axAscDescOrderByField       := '';
  SQLConnection               := nil;
end;

procedure TDlgDBLocalizaPlus.FormCreate(Sender: TObject);
begin
  axTitles                    := TStringList.Create;
  axMask                      := TStringList.Create;
  EDTPesquise.Align           := alClient;
  ActiveControl               := EDTPesquise;

  axMostraTodosRegistrosAbrir := false;
  axReordenarColunas       := false;

  axAscDescOrderByField       := '';
  SQLConnection               := nil;
end;

procedure TDlgDBLocalizaPlus.FormDestroy(Sender: TObject);
begin
   axTitles.Free;
   axMask.Free;
   axMostraTodosRegistrosAbrir := false;
   axReordenarColunas       := false;
   axAscDescOrderByField       := '';
   //SQLConnection               := nil;
   SetSQLConnection(nil);
end;

procedure TDlgDBLocalizaPlus.FormShow(Sender: TObject);
var
 intFor: Integer;
 intFor_2: Integer;
begin
   if (axLocate) then
   begin
      FIND.IndexFieldNames := '';
      FIND.Open;
      FIND.IndexFieldNames := axLocateField;
      FIND.First;
      //
      DBGPesquise.Columns.Clear;
      // Loop dos Fields para montar o DBGrid.
      for intFor := 0 to FIND.FieldCount -1 do
      begin
         // Verifica se o Field não um MEMO, se for não é incluido no Grid.
         if (FIND.Fields[intFor].FieldName <> axMemoField) and (FIND.Fields[intFor].Visible) then
         begin
            DBGPesquise.Columns.Add;
            if (intFor <= axTitles.Count -1) then
            begin
               //Verifica se tem tanho do campo no Descricao
               if Pos('>',axTitles.Strings[intFor]) > 0 then
               begin
                 DBGPesquise.Columns.Items[intFor].Title.Caption  :=  Copy(axTitles.Strings[intFor],Pos('>',axTitles.Strings[intFor])+1,Length(axTitles.Strings[intFor]));
                 DBGPesquise.Columns.Items[intFor].Width  := GetWidth(axTitles.Strings[intFor]);
                 DBGPesquise.Columns.Items[intFor].Title.Color := clBtnFace;
               end
               else
               begin
                 DBGPesquise.Columns.Items[intFor].Title.Caption  := axTitles.Strings[intFor];
                 DBGPesquise.Columns.Items[intFor].Title.Color := clBtnFace;
               end;
            end;
            DBGPesquise.Columns.Items[intFor].Field := FIND.Fields[intFor];
            // Coloca mascara nos campos.
            if (intFor <= axMask.Count -1) then
            begin
               if (FIND.Fields[intFor].DataType = ftDateTime) or (FIND.Fields[intFor].DataType = ftTimeStamp) then
               begin
                  TDateTimeField(DBGPesquise.Columns.Items[intFor].Field).DisplayFormat := axMask[intFor];
                  DBGPesquise.Columns.Items[intFor].Width := 85;
               end
               else
               if FIND.Fields[intFor].DataType = ftString then
                  DBGPesquise.Columns.Items[intFor].Field.EditMask := axMask[intFor] + ';0; '
               else
               if FIND.Fields[intFor].DataType = ftBCD then
               begin
                  TNumericField(DBGPesquise.Columns.Items[intFor].Field).DisplayFormat := axMask[intFor];
                  DBGPesquise.Columns.Items[intFor].Width := 85;
               end
               else
               if FIND.Fields[intFor].DataType = ftFMTBcd then
               begin
                  TNumericField(DBGPesquise.Columns.Items[intFor].Field).DisplayFormat := axMask[intFor];
                  DBGPesquise.Columns.Items[intFor].Width := 85;
               end
               else
               if FIND.Fields[intFor].DataType = ftFloat then
               begin
                  TNumericField(DBGPesquise.Columns.Items[intFor].Field).DisplayFormat := axMask[intFor];
                  DBGPesquise.Columns.Items[intFor].Width := 85;
               end;
            end;
         end;
      end;
      if (axLocate) then
      begin
        // DBGPesquise.Options := [dgIndicator,dgTitles,dgColLines,dgRowSelect,dgAlwaysShowSelection]
           DBGPesquise.Options := [dgIndicator,dgTitles,dgColLines,dgAlwaysShowSelection,dgColumnResize]
      end
      else
      begin
        // DBGPesquise.Options := [dgIndicator,dgColLines,dgRowSelect,dgAlwaysShowSelection];
           DBGPesquise.Options := [dgIndicator,dgColLines,dgAlwaysShowSelection,dgColumnResize];
      end;
   end
   else
      FIND.IndexFieldNames := '';

// DBGPesquise.Options    := [dgTitles,dgIndicator,dgColLines,dgRowSelect,dgAlwaysShowSelection];
   DBGPesquise.Options    := [dgTitles,dgIndicator,dgColLines,dgAlwaysShowSelection,dgColumnResize];
   DBGPesquise.FixedColor := clInfoBk;
   EDTPesquise.Modified   := False;
   axLocate := false;
// DBGPesquise.Columns.RebuildColumns;


   // MOSTRA TODOS OS REGISTRO
   if axMostraTodosRegistrosAbrir then
   begin
      FIND.CommandText := axSELECT+' '+axWHERE;
      FIND.Open;
   end;

   ShowScrollBar(DBGridPSQ.Handle, SB_HORZ, False);
   ShowScrollBar(DBGridPSQ.Handle, SB_VERT, False);
end;

procedure TDlgDBLocalizaPlus.PSQBeforeScroll(DataSet: TDataSet);
begin
  EDTPesquise.Clear;
end;

procedure TDlgDBLocalizaPlus.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  intFor_2: Integer;
begin
   if (ActiveControl = EDTPesquise) then
   begin
      if (Shift = []) and (Key = VK_RETURN) and (axLocate) then
      begin
         ModalResult := mrOK;
      end;

      if (not axLocate) then
      begin
         if (Shift = []) and (Key = VK_RETURN) and
            (Length(EDTPesquise.Text) > 0) and (EDTPesquise.Modified) then
         begin
            FIND.Close;
            // Verifica tipo do dataset para passar valor do parametro.
            // for intFor_1 := 0 to FIND.Params.Count -1 do
            //FIND.Params[intFor_1].Value := EDTPesquise.Text + '%';
            //
            var LORDERBYDEFAULT := ' ORDER BY '+PSQ.FieldByName('PSQ_FIELDPESQUISA').AsString;
            if axAscDescOrderByField.Length > 0 then
              LORDERBYDEFAULT := axAscDescOrderByField;

            if Length(Trim(axWHERE)) > 0 then
            begin
               if (Length(Trim(EDTPesquise.Text)) > 1) then
               begin
                  if Pos('%',EDTPesquise.Text) > 0 then
                  FIND.CommandText := axSELECT+' '+axWHERE+' AND '+PSQ.FieldByName('PSQ_FIELDPESQUISA').AsString +' Like '+ QuotedStr(EDTPesquise.Text+'%')+ LORDERBYDEFAULT //' ORDER BY '+PSQ.FieldByName('PSQ_FIELDPESQUISA').AsString
                  else
                  FIND.CommandText := axSELECT+' '+axWHERE+' AND '+PSQ.FieldByName('PSQ_FIELDPESQUISA').AsString +' Like '+ QuotedStr(EDTPesquise.Text+'%')+ LORDERBYDEFAULT; //' ORDER BY '+PSQ.FieldByName('PSQ_FIELDPESQUISA').AsString;
               end
               else
               begin
                  if Pos('%',EDTPesquise.Text) > 0 then
                  FIND.CommandText := axSELECT+' '+axWHERE+' AND '+PSQ.FieldByName('PSQ_FIELDPESQUISA').AsString +' Like '+ QuotedStr(EDTPesquise.Text)+ LORDERBYDEFAULT //'  ORDER BY '+PSQ.FieldByName('PSQ_FIELDPESQUISA').AsString
                  else
                  FIND.CommandText := axSELECT+' '+axWHERE+' AND '+PSQ.FieldByName('PSQ_FIELDPESQUISA').AsString +' Like '+ QuotedStr(EDTPesquise.Text+'%') + LORDERBYDEFAULT //' ORDER BY '+PSQ.FieldByName('PSQ_FIELDPESQUISA').AsString;
               end;
            end
            else
            begin
               if Pos('%',EDTPesquise.Text) > 0 then
                FIND.CommandText := axSELECT+' Where '+PSQ.FieldByName('PSQ_FIELDPESQUISA').AsString +' Like '+ QuotedStr(EDTPesquise.Text)+ LORDERBYDEFAULT //'  ORDER BY '+PSQ.FieldByName('PSQ_FIELDPESQUISA').AsString
               else
                FIND.CommandText := axSELECT+' Where '+PSQ.FieldByName('PSQ_FIELDPESQUISA').AsString +' Like '+ QuotedStr(EDTPesquise.Text+'%')+ LORDERBYDEFAULT //'  ORDER BY '+PSQ.FieldByName('PSQ_FIELDPESQUISA').AsString;
            end;
   {

    if PSQ.RecordCount > 0 then
     begin
       // IntCont := PSQ.RecordCount;
       // Fields := TStringList.Create;
       // Fields.Clear;
       // For IntFor := 0 to IntCont -1 do
       // begin
       //    Fields.Add(PSQ.FieldByName('PSQ_FIELDPESQUISA').AsString);
       //    PSQ.Next;
       // end;

        //Deleta Item Coluna do Grid se nao for Padrao
        if (DBGPesquise.Columns.Count - 1) >  axTitles.Count  then
        DBGPesquise.Columns.Delete(axTitles.Count + 1);
        //Monta Coluna de Pesquisa no Grid
        X := 0;
        for IntFor1 := 0 to DBGPesquise.Columns.Count do
        if DBGPesquise.Columns[IntFor1].FieldName = PSQ.FieldByName('PSQ_FIELDPESQUISA').AsString then
        Inc(X);
        //
        if X = 0 then
        Begin
           DBGPesquise.Columns.Add;
           Col := DBGPesquise.Columns.Count - 1;
           DBGPesquise.Columns[Col].Title.Caption := 'X';
           DBGPesquise.Columns[Col].FieldName := PSQ.FieldByName('PSQ_FIELDPESQUISA').AsString;
           DBGPesquise.Columns[Col].Title.Color := $00B3E1EA;
           DBGPesquise.Columns[Col].Title.Font.Style := [fsBold];
        End;
//     End;


    }

            if (FIND.RemoteServer <> nil) then
            begin
               if not FIND.RemoteServer.Connected then
                  FIND.RemoteServer.Connected := True;
            end
            else
            if (FIND.ConnectionBroker <> nil) then
            begin
               if not FIND.ConnectionBroker.Connection.Connected then
                  FIND.ConnectionBroker.Connection.Connected := True;
            end;
            FIND.Open;
            //
            DBGPesquise.Columns.Clear;
            // Loop dos Fields para montar o DBGrid.
            for intFor_2 := 0 to FIND.FieldCount -1 do
            begin
               // Verifica se o Field não um MEMO, se for não é incluido no Grid.
               if (FIND.Fields[intFor_2].FieldName <> axMemoField) and (FIND.Fields[intFor_2].Visible) then
               begin
                  DBGPesquise.Columns.Add;
                  if intFor_2 <= axTitles.Count -1 then
                  begin
                     if Pos('>',axTitles.Strings[intFor_2]) > 0 then
                     begin
                       DBGPesquise.Columns.Items[intFor_2].Title.Caption  :=  Copy(axTitles.Strings[intFor_2],Pos('>',axTitles.Strings[intFor_2])+1,Length(axTitles.Strings[intFor_2]));
                       DBGPesquise.Columns.Items[intFor_2].Width  := GetWidth(axTitles.Strings[intFor_2]);
                       DBGPesquise.Columns.Items[intFor_2].Title.Color := clBtnFace;
                     end
                     else
                     begin
                       DBGPesquise.Columns.Items[intFor_2].Title.Caption  := axTitles.Strings[intFor_2];
                       DBGPesquise.Columns.Items[intFor_2].Title.Color := clBtnFace;
                     end;
                  end;
                  DBGPesquise.Columns.Items[intFor_2].Field := FIND.Fields[intFor_2];
                  // Coloca mascara nos campos.
                  if intFor_2 <= axMask.Count -1 then
                  begin
                     if (FIND.Fields[intFor_2].DataType = ftDateTime) or (FIND.Fields[intFor_2].DataType = ftTimeStamp) then
                     begin
                        TDateTimeField(DBGPesquise.Columns.Items[intFor_2].Field).DisplayFormat := axMask[intFor_2];
                        DBGPesquise.Columns.Items[intFor_2].Width := 85;
                     end
                     else
                     if FIND.Fields[intFor_2].DataType = ftString then
                        DBGPesquise.Columns.Items[intFor_2].Field.EditMask := axMask[intFor_2] + ';0; '
                     else
                     if FIND.Fields[intFor_2].DataType = ftBCD then
                     begin
                        TNumericField(DBGPesquise.Columns.Items[intFor_2].Field).DisplayFormat := axMask[intFor_2];
                        DBGPesquise.Columns.Items[intFor_2].Width := 85;
                     end
                     else
                     if FIND.Fields[intFor_2].DataType = ftFMTBcd then
                     begin
                        TNumericField(DBGPesquise.Columns.Items[intFor_2].Field).DisplayFormat := axMask[intFor_2];
                        DBGPesquise.Columns.Items[intFor_2].Width := 85;
                     end
                     else
                     if FIND.Fields[intFor_2].DataType = ftFloat then
                     begin
                        TNumericField(DBGPesquise.Columns.Items[intFor_2].Field).DisplayFormat := axMask[intFor_2];
                        DBGPesquise.Columns.Items[intFor_2].Width := 85;
                     end;
                  end;
               end;
            end;
       //     DBGPesquise.Options    := [dgTitles,dgIndicator,dgColLines,dgRowSelect,dgAlwaysShowSelection];
            DBGPesquise.Options    := [dgTitles,dgIndicator,dgColLines,dgAlwaysShowSelection,dgColumnResize];
            DBGPesquise.FixedColor := clInfoBk;
            EDTPesquise.Modified   := False;

            if (LSelectedIndexPesquisa <> -1) and  (axReordenarColunas) then
              DBGPesquise.SelectedIndex := LSelectedIndexPesquisa;
            //
            Application.ProcessMessages;
         end
         else if (Shift = []) and (Key = VK_RETURN) and (Length(EDTPesquise.Text) > 0) and
            (not EDTPesquise.Modified) then
         begin
            ModalResult := mrOK;
         end
         else if (Shift = []) and (Key = VK_RETURN) and (axMostraTodosRegistrosAbrir = true) and
            (not EDTPesquise.Modified) then
         begin
            ModalResult := mrOK;
         end;
      end;
      if (FIND.Active) then
      begin
         if (Shift = []) and (Key = VK_UP) then
         begin
            FIND.Prior;
            Key := VK_END;
            FormKeyDown(Sender, Key, Shift);
         end
         else if (Shift = []) and (Key = VK_DOWN) then
           FIND.Next
         else if (Shift = []) and (Key = VK_PRIOR) then FIND.MoveBy(-12)
         else if (Shift = []) and (Key = VK_NEXT) then  FIND.MoveBy(12);
      end;
      if (PSQ.Active) then
      begin
         if (Shift = [ssCtrl]) and (Key = VK_UP) then
         begin
            PSQ.Prior;
            Key := VK_END;
            FormKeyDown(Sender, Key, Shift);
         end
         else if (Shift = [ssCtrl]) and (Key = VK_DOWN) then
           PSQ.Next
         else if (Shift = [ssCtrl]) and (Key = VK_PRIOR) then PSQ.MoveBy(-12)
         else if (Shift = [ssCtrl]) and (Key = VK_NEXT) then  PSQ.MoveBy(12);
      end;
      if (PSQ.Active) then
      begin
         if (Shift = []) and (Key = VK_LEFT) then
         begin
            DBGPesquise.SelectedIndex := DBGPesquise.SelectedIndex - 1;
         end;
         if (Shift = []) and (Key = VK_RIGHT) then
         begin
            DBGPesquise.SelectedIndex := DBGPesquise.SelectedIndex + 1;
         end
      end;


   end;
end;

procedure TDlgDBLocalizaPlus.DBGPesquiseColumnMoved(Sender: TObject; FromIndex, ToIndex: Integer);
begin
  if FPathNameTemplateGridUser.Length > 0 then
    TDBGrid(Sender).Columns.SaveToFile(FPathNameTemplateGridUser+TDBGrid(Sender).Name+'.GRD');
end;

procedure TDlgDBLocalizaPlus.DBGPesquiseEnter(Sender: TObject);
begin
  if FPathNameTemplateGridUser.Length > 0 then
  begin
    if DBGPesquise.DataSource <> nil then
    begin
      if not DBGPesquise.DataSource.DataSet.active then Exit;
      if DBGPesquise.DataSource.DataSet.RecordCount > 0 then
      begin
        LSumWidthColsEnter := 0;
        for var I := 0 to DBGPesquise.Columns.Count -1 do
        begin
          LSumWidthColsEnter := LSumWidthColsEnter + DBGPesquise.Columns[I].Width;
        end;
      end;
    end;
  end;
end;

procedure TDlgDBLocalizaPlus.DBGPesquiseExit(Sender: TObject);
begin
  if FPathNameTemplateGridUser.Length > 0 then
  begin
    if DBGPesquise.DataSource <> nil then
    begin
      if not DBGPesquise.DataSource.DataSet.active then Exit;
      if DBGPesquise.DataSource.DataSet.RecordCount > 0 then
      begin
        LSumWidthColsExit := 0;
        for var I := 0 to DBGPesquise.Columns.Count -1 do
        begin
          LSumWidthColsExit := LSumWidthColsExit + DBGPesquise.Columns[I].Width;
        end;

        if LSumWidthColsExit <> LSumWidthColsEnter then
          if FPathNameTemplateGridUser.Length > 0 then
            TDBGrid(Sender).Columns.SaveToFile(FPathNameTemplateGridUser+TDBGrid(Sender).Name+'.GRD');

      end;
    end;
  end;
end;

procedure TDlgDBLocalizaPlus.DBGridPSQCellClick(Column: TColumn);
begin
  EDTPesquise.SetFocus;
end;

procedure TDlgDBLocalizaPlus.DBGridPSQDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (gdFocused in State) and (gdSelected in State) then
  begin
    // Se a linha está selecionada e em foco, mudamos a cor
    TDBGrid(Sender).Canvas.Brush.Color := clYellow; // Define a cor de fundo da linha selecionada
    TDBGrid(Sender).Canvas.Font.Color := clBlack; // Define a cor do texto na linha selecionada
  end
  else if gdSelected in State then
  begin
    // Se a linha está selecionada, mas não está com o foco, mantemos a cor original
    TDBGrid(Sender).Canvas.Brush.Color := clWhite; // Define a cor de fundo da linha selecionada
    TDBGrid(Sender).Canvas.Font.Color := clBlack; // Define a cor do texto na linha selecionada

//    TDBGrid(Sender).Canvas.Brush.Assign(TDBGrid(Sender).Color);
//    TDBGrid(Sender).Canvas.Font.Assign(DBGrid(Sender).Font);
  end;

  TDBGrid(Sender).DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TDlgDBLocalizaPlus.DTSDataChange(Sender: TObject; Field: TField);
begin
  if FPathNameTemplateGridUser.Length > 0 then
    if FileExists(FPathNameTemplateGridUser+DBGPesquise.Name+'.GRD') then
      DBGPesquise.Columns.LoadFromFile(FPathNameTemplateGridUser+DBGPesquise.Name+'.GRD');
end;

procedure TDlgDBLocalizaPlus.EDTPesquiseChange(Sender: TObject);
begin
   if (Length(EDTPesquise.Text) = 0) and (not axLocate) then
   begin
      FIND.Close;
      DBGPesquise.Columns.Clear;
     // DBGPesquise.Options := [dgColLines,dgRowSelect,dgAlwaysShowSelection];
      DBGPesquise.Options := [dgColLines,dgAlwaysShowSelection,dgColumnResize];
      Application.ProcessMessages;
   end
   else
   if (axLocate) then
   begin
      FIND.FindNearest([EDTPesquise.Text]);
   end;
end;

end.
