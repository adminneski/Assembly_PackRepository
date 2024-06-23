unit DlgNSK_DBLocaliza;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls, StdCtrls,
  ExtCtrls, Forms, DBGrids, Db, ComCtrls, Grids, DBClient, dialogs, DBCtrls,
  Buttons, Vcl.Imaging.pngimage;

type
  TDlgDBLocaliza = class(TForm)
    DTS: TDataSource;
    FIND: TClientDataSet;
    Panel4: TPanel;
    BtnConfirma: TBitBtn;
    GradBtn1: TBitBtn;
    DBGPesquise: TDBGrid;
    memOBS: TDBMemo;
    Panel3: TPanel;
    AxLabel1: TLabel;
    EDTPesquise: TEdit;
    Panel1: TPanel;
    lbDescricao: TLabel;
    lblInformativo: TLabel;
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EDTPesquiseChange(Sender: TObject);
    procedure EDTPesquiseKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    function GetWidth(Texto: String): Integer;
    { Private declarations }

  public
    { Public declarations }
    axTitles: TStringList;
    axMask: TStringList;
    axLocate: Boolean;
    LValueFieldReturn,
    axLocateField: String;
    axMemoField: String;
    axMostraTodosRegistrosAbrir: Boolean;
    booMultiSelecao: Boolean;
    strMultiValue: String;
  end;
var
  DlgDBLocaliza: TDlgDBLocaliza;

implementation

uses NSK_DBLocaliza;

{$R *.DFM}


Function TDlgDBLocaliza.GetWidth(Texto:String):Integer;
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


procedure TDlgDBLocaliza.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if ActiveControl <> EDTPesquise then EDTPesquise.SetFocus;
end;

procedure TDlgDBLocaliza.EDTPesquiseKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
LFieldNo: Integer;
begin
   if (Key = VK_RETURN) and (Shift = [ssCtrl]) then
   begin
     if not DBGPesquise.DataSource.DataSet.Active then
     begin
       Self.OnKeyDown(Self,Key,[]);
       Exit;
     end;

     LFieldNo := 0; //Por Default é zero para carregar o calor do Field 0 = Primeira Coluna
     if Length(Trim(LValueFieldReturn))> 0 then //Se Tiver valor na variável, encontra a posição do Field
       LFieldNo := DBGPesquise.DataSource.DataSet.FindField(LValueFieldReturn).FieldNo-1;

     if Length(Trim(DBGPesquise.DataSource.DataSet.Fields[LFieldNo].AsString)) > 0  then
     begin
       if Length(Trim(strMultiValue)) = 0 then
         strMultiValue := DBGPesquise.DataSource.DataSet.Fields[LFieldNo].AsString// DBGPesquise.DataSource.DataSet.FieldByName(LKeyField).AsString
       else
         strMultiValue := strMultiValue+','+DBGPesquise.DataSource.DataSet.Fields[LFieldNo].AsString;// DBGPesquise.DataSource.DataSet.FieldByName(LKeyField).AsString;
     end;
   end;
   if (memOBS.Visible) and (Length(Trim(strMultiValue)) > 0) then
     memOBS.Lines.Text := strMultiValue;
end;

procedure TDlgDBLocaliza.FormCreate(Sender: TObject);
begin
   strMultiValue     := '';
   axTitles          := TStringList.Create;
   axMask            := TStringList.Create;
   EDTPesquise.Align := alClient;
   ActiveControl     := EDTPesquise;
end;

procedure TDlgDBLocaliza.FormDestroy(Sender: TObject);
begin
   axTitles.Free;
   axMask.Free;
   axMostraTodosRegistrosAbrir := false;
end;

procedure TDlgDBLocaliza.FormShow(Sender: TObject);
var
intFor: Integer;
intFor_2: Integer;
intWidth : Integer;
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
        // DBGPesquise.Options := [dgIndicator,dgTitles,dgColLines,dgRowSelect,dgAlwaysShowSelection];
         DBGPesquise.Options := [dgIndicator,dgTitles,dgColLines,dgAlwaysShowSelection,dgColumnResize];
      end
      else
      begin
       //  DBGPesquise.Options := [dgIndicator,dgColLines,dgRowSelect,dgAlwaysShowSelection];
         DBGPesquise.Options := [dgIndicator,dgColLines,dgAlwaysShowSelection,dgColumnResize];
      end;
   end
   else
      FIND.IndexFieldNames := axLocateField;

  //  DBGPesquise.Options    := [dgTitles,dgIndicator,dgColLines,dgRowSelect,dgAlwaysShowSelection];
  DBGPesquise.Options    := [dgTitles,dgIndicator,dgColLines,dgAlwaysShowSelection,dgColumnResize];
  DBGPesquise.FixedColor := clBtnFace;
  EDTPesquise.Modified   := False;
  axLocate := false;

  // MOSTRA TODOS OS REGISTRO
  if axMostraTodosRegistrosAbrir then
  begin
    FIND.Params[0].Value := EDTPesquise.Text + '%';
    FIND.Open;
    FIND.First;
  end;


end;

procedure TDlgDBLocaliza.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  intFor_1: Integer;
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
            for intFor_1 := 0 to FIND.Params.Count -1 do
                FIND.Params[intFor_1].Value := EDTPesquise.Text + '%';
            //
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
            FIND.First;
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
           // DBGPesquise.Options    := [dgTitles,dgIndicator,dgColLines,dgRowSelect,dgAlwaysShowSelection];
            DBGPesquise.Options    := [dgTitles,dgIndicator,dgColLines,dgAlwaysShowSelection,dgColumnResize];
            DBGPesquise.FixedColor := clBtnFace;
            EDTPesquise.Modified   := False;
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
         else if (Shift = []) and (Key = VK_DOWN ) then FIND.Next
         else if (Shift = []) and (Key = VK_PRIOR) then FIND.MoveBy(-12)
         else if (Shift = []) and (Key = VK_NEXT ) then FIND.MoveBy(12)

         else if (Shift = [ssCtrl]) and (Key = VK_HOME) then  FIND.First
         else if (Shift = [ssCtrl]) and (Key = VK_END ) then  FIND.Last;
      end;
      if (FIND.Active) then
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

procedure TDlgDBLocaliza.EDTPesquiseChange(Sender: TObject);
var
  LKey: word;
begin
   if (Length(EDTPesquise.Text) = 0) and (not axLocate) then
   begin
     // MOSTRA TODOS OS REGISTRO
     if axMostraTodosRegistrosAbrir then
     begin
       FIND.Close;
       DBGPesquise.Columns.Clear;
       // DBGPesquise.Options := [dgColLines,dgRowSelect,dgAlwaysShowSelection];
       DBGPesquise.Options := [dgColLines,dgAlwaysShowSelection];



//       EDTPesquise.Text := '%';
//       axLocate := false;
//       LKey := VK_RETURN;
//       Self.OnKeyDown(Self,LKey,[]);
//       FIND.FindNearest([EDTPesquise.Text]);
     end
     else
     begin
       FIND.Close;
       DBGPesquise.Columns.Clear;
       // DBGPesquise.Options := [dgColLines,dgRowSelect,dgAlwaysShowSelection];
       DBGPesquise.Options := [dgColLines,dgAlwaysShowSelection];
     end;
     Application.ProcessMessages;
   end
   else
   if (axLocate) then
   begin
      FIND.FindNearest([EDTPesquise.Text]);
   end;
end;

end.
