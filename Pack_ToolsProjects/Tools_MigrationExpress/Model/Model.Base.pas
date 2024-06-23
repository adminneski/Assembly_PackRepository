unit Model.Base;

interface

uses
  System.Rtti
  ,System.SysUtils
  ,Dialogs
  ,Vcl.Forms
  ,FireDAC.Comp.DataSet
  ,Winapi.Windows

  // Uses para o Gauge
  ,Vcl.Samples.Gauges

  // Uses para Label
  ,Vcl.StdCtrls, goxormbr.core.types, goxormbr.core.utils;

type
  TModelBase = class
  private
    function PopularObjeto(ADBRSet: TGOXDBQuery): TModelBase;
    procedure SetInstanceProp(AInstance: TObject; AProperty: TRttiProperty; const AValue: Variant);
  public
    constructor Create;
    destructor Destroy; override;

    procedure ExecutarConversao(ASourceConnection,ATargetConnection: TGOXDBConnection; AlblFuncao, AlblTempoProcessamento : TLabel; AGaugeWhile : TGauge);
    function ExecutarConversaoCopyDataSet(ASourceConnection, ATargetConnection : TGOXDBConnection; AlblFuncao, AlblTempoProcessamento : TLabel; AGaugeWhile : TGauge; AlblRowCopyRecord, AlblTotalRowCopyRecord : TLabel) : String;
    procedure ObjectSetInsert(AObject : TObject; ASourceConn, ATargetConnection : TGOXDBConnection); virtual; abstract;
  end;

  function IncCodigo(AFIL_CODIGO, AFieldName: String; ATargetConnection: TGOXDBConnection): Variant;

implementation

uses
  Core.Query
  ,Frm_MigrationExpress
  ,Dtm_MigrationExpress;

{ TModelBase }

constructor TModelBase.Create;
begin
  //
end;

destructor TModelBase.Destroy;
begin
  inherited;
  //
end;

procedure TModelBase.ExecutarConversao(ASourceConnection,ATargetConnection: TGOXDBConnection; AlblFuncao, AlblTempoProcessamento : TLabel; AGaugeWhile : TGauge);
var
  LResultSet: TGOXDBQuery;
begin
  try
    LResultSet         := ASourceConnection.CreateGOXDBQuery(TCoreQuery.QueryList[Self.ClassName]);
    AlblFuncao.Caption := 'ORM';

    Application.ProcessMessages;

    AGaugeWhile.Progress := 0;
    AGaugeWhile.MaxValue := LResultSet.RecordCount; //500;
    while not LResultSet.Eof do
    begin
      try
        ObjectSetInsert(PopularObjeto(LResultSet),ASourceConnection,ATargetConnection);
        AGaugeWhile.Progress := AGaugeWhile.Progress + 1;
        DtmMigrationExpress.NumeroRegistro := AGaugeWhile.Progress;

        if AGaugeWhile.Progress = AGaugeWhile.MaxValue then
          AGaugeWhile.MaxValue := AGaugeWhile.MaxValue + 500;

        AlblTempoProcessamento.Caption := 'Tempo Processado : '+ TimeToStr(Time - DtmMigrationExpress.LTempo);
        Application.ProcessMessages;
      except on E: Exception do
        begin
          Application.MessageBox(PChar('TModelBase.ExecutarConversao' + #13 +
                                       'Tabela : ' + Self.ClassName + #13#13 +
                                       E.Message),'Perigo',MB_OK+MB_ICONWARNING);// +''+ TCoreQuery.QueryList[Self.ClassName]);
        end;
      end;
      LResultSet.Next;
    end;
  finally
    FreeAndNil(LResultSet);
  end;
end;

function TModelBase.ExecutarConversaoCopyDataSet(ASourceConnection, ATargetConnection: TGOXDBConnection; AlblFuncao, AlblTempoProcessamento : TLabel; AGaugeWhile : TGauge; AlblRowCopyRecord, AlblTotalRowCopyRecord : TLabel) : String;
var
//LResultSet: TGOXDBQuery;
  Tabela : String;
begin
  try
     try
      DtmMigrationExpress.FDQueryOrigem.SQL.Clear;
      DtmMigrationExpress.FDQueryOrigem.Close;
      DtmMigrationExpress.FDQueryOrigem.SQL.Add(TCoreQuery.QueryList[Self.ClassName]);
      DtmMigrationExpress.FDQueryOrigem.FetchOptions.Unidirectional := True;
      DtmMigrationExpress.FDQueryOrigem.Open;
      //DtmConvert.FDQueryERP.Last;
      DtmMigrationExpress.NumeroRegistro := DtmMigrationExpress.FDQueryOrigem.RecordCount;
      //DtmConvert.FDQueryERP.First;

      Tabela := Copy(Self.ClassName,2,20);
      DtmMigrationExpress.FDQueryDestino.SQL.Clear;
      DtmMigrationExpress.FDQueryDestino.Close;
      DtmMigrationExpress.FDQueryDestino.SQL.Add('SELECT * FROM ' + Tabela + ' WHERE 1 = 0');
      DtmMigrationExpress.FDQueryDestino.FetchOptions.Unidirectional := True;
      DtmMigrationExpress.FDQueryDestino.Open;
    except on EXC: Exception do
      begin
        Application.MessageBox(PChar('TModelBase.ExecutarConversaoCopyDataSet' + #13 +
                                     'Falha Antes Das Rotinas de Migração De Dados. ' +
                                     '(CopyRecord / CopyDataSet / ORM)' + #13#13 +
                                     EXC.Message),'Perigo',MB_OK+MB_ICONWARNING);
      end;
    end;

    try
      if (DtmMigrationExpress.FDQueryOrigem.FieldCount > 85) or (DtmMigrationExpress.NumeroRegistro > 750000) then
      begin
        try
          AlblFuncao.Caption             := 'CopyRecord';
          Result                         := 'CopyRecord';
          AGaugeWhile.Progress           := 0;
          AGaugeWhile.MaxValue           := DtmMigrationExpress.NumeroRegistro;
          AlblRowCopyRecord.Visible      := True;
          AlblTotalRowCopyRecord.Visible := True;
          AlblTotalRowCopyRecord.Caption := DtmMigrationExpress.NumeroRegistro.ToString;

          DtmMigrationExpress.FDQueryOrigem.First;

          while not (DtmMigrationExpress.FDQueryOrigem.Eof) do
          begin
            DtmMigrationExpress.FDQueryDestino.Append;
            DtmMigrationExpress.FDQueryDestino.CopyRecord(DtmMigrationExpress.FDQueryOrigem);
            DtmMigrationExpress.FDQueryDestino.Post;

            if (DtmMigrationExpress.FDQueryOrigem.RecNo mod 1000) = 0 then
            begin
              DtmMigrationExpress.FDQueryDestino.Close;
              DtmMigrationExpress.FDQueryDestino.Open;
            end;

            AGaugeWhile.Progress      := DtmMigrationExpress.FDQueryOrigem.RecNo;
            AlblRowCopyRecord.Caption := DtmMigrationExpress.FDQueryOrigem.RecNo.ToString;

            Application.ProcessMessages;
            DtmMigrationExpress.FDQueryOrigem.Next;
          end;
          DtmMigrationExpress.FDQueryDestino.Close;
        except on EXC : Exception do
          begin
            Application.MessageBox(PChar('TModelBase.ExecutarConversaoCopyDataSet' + #13 +
                                         'No CopyRecord, Chamando Função de Migração Dos Dados ' +
                                         'Registro a Registro(Linha a Linha) do ORM.' + #1313 +
                                         EXC.Message),'Perigo',MB_OK+MB_ICONWARNING);
          end;
        end;
      end
      else
      begin
        try
          AlblFuncao.Caption := 'CopyDataSet';
          Result             := 'CopyDataSet';

          Application.ProcessMessages;
          DtmMigrationExpress.FDQueryDestino.CopyDataSet(DtmMigrationExpress.FDQueryOrigem);

        except on EXC : Exception do
          begin
            Application.MessageBox(PChar('TModelBase.ExecutarConversaoCopyDataSet' + #13 +
                                         'No CopyDataSet, Chamando Função de Migração Dos Dados ' +
                                         'Registro a Registro(Linha a Linha) do ORM.' + #1313 +
                                         EXC.Message),'Perigo',MB_OK+MB_ICONWARNING);
          end;
        end;
      end;
    except // Somente para execução dos procedimentos a seguir, sem mensagem, pois foi realizada anteriormente.
      ATargetConnection.ExecuteSQL('DELETE  FROM ' + Tabela);
      try
        Result := 'ORM';
        ExecutarConversao(ASourceConnection, ATargetConnection, AlblFuncao, AlblTempoProcessamento, AGaugeWhile);
      except on EXC : Exception do
        begin
          Application.MessageBox(PChar('TModelBase.ExecutarConversaoCopyDataSet' + #13 +
                                       'Após Erro no CopyDataSet/CopyRecord Foi Chamado o ORM, ' +
                                       'Porem Tambem Deu Falha.' + #13#13 + EXC.Message),'Perigo',
                                       MB_OK+MB_ICONWARNING);
        end;
      end;
    end;
  finally
    AlblRowCopyRecord.Visible      := False;
    AlblTotalRowCopyRecord.Visible := False;
    Application.ProcessMessages;
    DtmMigrationExpress.FDQueryDestino.Close;
    DtmMigrationExpress.FDQueryOrigem.Close;
  end;
end;

function TModelBase.PopularObjeto(ADBRSet: TGOXDBQuery): TModelBase;
var
  LRttiContext  : TRttiContext;
  LRttiType     : TRttiType;
  LRttiProperty : TRttiProperty;
begin
  LRttiContext := TRttiContext.Create;
  LRttiType    := LRttiContext.GetType(Self.ClassType);

  for LRttiProperty in LRttiType.GetProperties do
  begin
    try
      try
        SetInstanceProp(Self, LRttiProperty,ADBRSet.FieldByName(LRttiProperty.Name).AsVariant);
      except on E: Exception do
        begin
          FrmMigrationExpress.FieldDoORM(LRttiProperty);
          Application.ProcessMessages;
          raise Exception.Create(E.Message +
                                 #13 +
                                 #13 +
                                 'Erro PROPOSITAL, para Identificação do Campo com Problema' +
                                 #13 +
                                 'Campo : ' + LRttiProperty.Name);
        end;
      end;
    finally
//      FrmMain.FieldDoORM(LRttiProperty);
//      Application.ProcessMessages;
    end;
  end;
  Result := Self;
end;

procedure TModelBase.SetInstanceProp(AInstance: TObject; AProperty: TRttiProperty; const AValue: Variant);
begin
  if (AProperty <> nil) and (AInstance <> nil) then
  begin
    case AProperty.PropertyType.TypeKind of
      tkString, tkWString, tkUString, tkWChar, tkLString, tkChar:
        if TVarData(AValue).VType <= varNull then
          AProperty.SetValue(AInstance, '')
        else
          AProperty.SetValue(AInstance, String(AValue));
      tkInteger, tkSet, tkInt64:
        AProperty.SetValue(AInstance, Integer(AValue));
      tkFloat:
        if TVarData(AValue).VType <= varNull then
          AProperty.SetValue(AInstance, 0)
        else
        if AProperty.PropertyType.Handle = TypeInfo(TDateTime) then
          AProperty.SetValue(AInstance, TUtilSingleton.GetInstance.Iso8601ToDateTime(AValue))
        else
        if AProperty.PropertyType.Handle = TypeInfo(TTime) then
          AProperty.SetValue(AInstance, TUtilSingleton.GetInstance.Iso8601ToDateTime(AValue))
        else
          AProperty.SetValue(AInstance, Double(AValue));
      tkVariant:
        AProperty.SetValue(AInstance, TValue.FromVariant(AValue));
      tkRecord:
      begin
        AProperty.SetValue(AInstance, TValue.FromVariant(AValue));
//          AProperty.SetValueNullable(AInstance,
//                                     AProperty.PropertyType.Handle,
//                                     AValue);
      end;
    end;
  end;
end;

function IncCodigo(AFIL_CODIGO, AFieldName: String; ATargetConnection: TGOXDBConnection): Variant;
var
  LRSet : TGOXDBQuery;
  SQL   : string;
begin
  Result := 0;
  //
  try
    LRSet := ATargetConnection.CreateGOXDBQuery('SELECT * FROM COD_00 WHERE (COD_FIELD = '+QuotedStr(AFieldName)+')'+
                                                'AND(COM_CODIGO = '+QuotedStr(AFIL_CODIGO)+')');
    if not LRSet.Eof then
    begin
      SQL := 'UPDATE COD_00 SET '+
             'COD_SEQUENCIA    = ' + QuotedStr(IntToStr(LRSet.FieldByName('COD_SEQUENCIA').AsInteger + 1)) + ','+
             'COD_SERIE        = ' + QuotedStr('XXX') + ' '+
             'WHERE COM_CODIGO = ' + QuotedStr(AFIL_CODIGO)+
             ' AND  COD_FIELD  = ' + QuotedStr(AFieldName);
      ATargetConnection.ExecuteSQL(SQL);

      Result := (LRSet.FieldByName('COD_SEQUENCIA').AsInteger + 1);
    end
    else
    begin
      SQL := 'INSERT INTO COD_00 (COD_FIELD, COM_CODIGO, COD_SERIE, COD_SEQUENCIA) VALUES ('+
             QuotedStr(AFieldName)+ ',' +
             QuotedStr(AFIL_CODIGO)+ ',' +
             QuotedStr('XXX')+ ',' +
             IntToStr(1)+ ')';
      ATargetConnection.ExecuteSQL(SQL);
      //
      Result := 1;
    end;
  finally
   FreeAndNil(LRSet);
  end;
end;

end.
