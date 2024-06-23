unit express.dbo.ALG_00;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('ALG_00', '')]
  [PrimaryKey('ALG_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_ALG_ID')]
  TDtoALG_00 = class
  private
    { Private declarations } 
    FALG_ID: Integer;
    FCOM_CODIGO: Integer;
    FALG_NUMERODOCTO: String;
    FPES_CODIGO: Integer;
    FVND_CODIGO: Integer;
    FFPG_CODIGO: Integer;
    FPRZ_CODIGO: Integer;
    FALG_DATAPROVA: TDateTime;
    FALG_DATARETIRADA: TDateTime;
    FALG_DATAUTILIZACAO: TDateTime;
    FALG_DATADEVOLUCAO: TDateTime;
    FALG_TOTALLIQUIDO: Double;
    FALG_TOTALPRODUTOS: Double;
    FALG_TOTALDESCTOAVULSO: Double;
    FALG_TOTALQTDPEDIDA: Double;
    FALG_PERCENTUALDESCTOAVULSO: Double;
    FALG_OBSERVACAO: String;
    FPLC_CODIGO: Integer;
    FCCU_CODIGO: Integer;
    FALG_DATALANCAMENTO: TDateTime;
    FALG_DATAALTERACAO: TDateTime;
    FALG_CANCELADO: String;
    FALG_PROCESSADO: String;
    FALG_DATACANCELAMENTO: TDateTime;
    FALG_OBSERVACAOCANCELAMENTO: String;
    FALG_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'ALG_00';
     const PrimaryKey = 'ALG_ID';
     const Sequence   = 'SEQ_ALG_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('ALG_ID', ftInteger)]
    [Dictionary('ALG_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ALG_ID: Integer read FALG_ID write FALG_ID;
    const ALG_ID_Name = 'ALG_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ALG_NUMERODOCTO', ftString, 10)]
    [Dictionary('ALG_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_NUMERODOCTO: String read FALG_NUMERODOCTO write FALG_NUMERODOCTO;
    const ALG_NUMERODOCTO_Name = 'ALG_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRZ_CODIGO', ftInteger)]
    [Dictionary('PRZ_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRZ_CODIGO: Integer read FPRZ_CODIGO write FPRZ_CODIGO;
    const PRZ_CODIGO_Name = 'PRZ_CODIGO';

    [Restrictions([NoValidate])]
    [Column('ALG_DATAPROVA', ftDateTime)]
    [Dictionary('ALG_DATAPROVA', 'Mensagem de validação', '', '', '', taCenter)]
    property ALG_DATAPROVA: TDateTime read FALG_DATAPROVA write FALG_DATAPROVA;
    const ALG_DATAPROVA_Name = 'ALG_DATAPROVA';

    [Restrictions([NoValidate])]
    [Column('ALG_DATARETIRADA', ftDateTime)]
    [Dictionary('ALG_DATARETIRADA', 'Mensagem de validação', '', '', '', taCenter)]
    property ALG_DATARETIRADA: TDateTime read FALG_DATARETIRADA write FALG_DATARETIRADA;
    const ALG_DATARETIRADA_Name = 'ALG_DATARETIRADA';

    [Restrictions([NoValidate])]
    [Column('ALG_DATAUTILIZACAO', ftDateTime)]
    [Dictionary('ALG_DATAUTILIZACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property ALG_DATAUTILIZACAO: TDateTime read FALG_DATAUTILIZACAO write FALG_DATAUTILIZACAO;
    const ALG_DATAUTILIZACAO_Name = 'ALG_DATAUTILIZACAO';

    [Restrictions([NoValidate])]
    [Column('ALG_DATADEVOLUCAO', ftDateTime)]
    [Dictionary('ALG_DATADEVOLUCAO', 'Mensagem de validação', '', '', '', taCenter)]
    property ALG_DATADEVOLUCAO: TDateTime read FALG_DATADEVOLUCAO write FALG_DATADEVOLUCAO;
    const ALG_DATADEVOLUCAO_Name = 'ALG_DATADEVOLUCAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ALG_TOTALLIQUIDO', ftBCD)]
    [Dictionary('ALG_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ALG_TOTALLIQUIDO: Double read FALG_TOTALLIQUIDO write FALG_TOTALLIQUIDO;
    const ALG_TOTALLIQUIDO_Name = 'ALG_TOTALLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ALG_TOTALPRODUTOS', ftBCD)]
    [Dictionary('ALG_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ALG_TOTALPRODUTOS: Double read FALG_TOTALPRODUTOS write FALG_TOTALPRODUTOS;
    const ALG_TOTALPRODUTOS_Name = 'ALG_TOTALPRODUTOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('ALG_TOTALDESCTOAVULSO', ftBCD)]
    [Dictionary('ALG_TOTALDESCTOAVULSO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ALG_TOTALDESCTOAVULSO: Double read FALG_TOTALDESCTOAVULSO write FALG_TOTALDESCTOAVULSO;
    const ALG_TOTALDESCTOAVULSO_Name = 'ALG_TOTALDESCTOAVULSO';

    [Restrictions([NoValidate])]
    [Column('ALG_TOTALQTDPEDIDA', ftBCD)]
    [Dictionary('ALG_TOTALQTDPEDIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ALG_TOTALQTDPEDIDA: Double read FALG_TOTALQTDPEDIDA write FALG_TOTALQTDPEDIDA;
    const ALG_TOTALQTDPEDIDA_Name = 'ALG_TOTALQTDPEDIDA';

    [Restrictions([NoValidate])]
    [Column('ALG_PERCENTUALDESCTOAVULSO', ftBCD, 18, 4)]
    [Dictionary('ALG_PERCENTUALDESCTOAVULSO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ALG_PERCENTUALDESCTOAVULSO: Double read FALG_PERCENTUALDESCTOAVULSO write FALG_PERCENTUALDESCTOAVULSO;
    const ALG_PERCENTUALDESCTOAVULSO_Name = 'ALG_PERCENTUALDESCTOAVULSO';

    [Restrictions([NoValidate])]
    [Column('ALG_OBSERVACAO', ftString, 5000)]
    [Dictionary('ALG_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_OBSERVACAO: String read FALG_OBSERVACAO write FALG_OBSERVACAO;
    const ALG_OBSERVACAO_Name = 'ALG_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGO', ftInteger)]
    [Dictionary('PLC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGO: Integer read FPLC_CODIGO write FPLC_CODIGO;
    const PLC_CODIGO_Name = 'PLC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGO', ftInteger)]
    [Dictionary('CCU_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGO: Integer read FCCU_CODIGO write FCCU_CODIGO;
    const CCU_CODIGO_Name = 'CCU_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ALG_DATALANCAMENTO', ftDateTime)]
    [Dictionary('ALG_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property ALG_DATALANCAMENTO: TDateTime read FALG_DATALANCAMENTO write FALG_DATALANCAMENTO;
    const ALG_DATALANCAMENTO_Name = 'ALG_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ALG_DATAALTERACAO', ftDateTime)]
    [Dictionary('ALG_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property ALG_DATAALTERACAO: TDateTime read FALG_DATAALTERACAO write FALG_DATAALTERACAO;
    const ALG_DATAALTERACAO_Name = 'ALG_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('ALG_CANCELADO', ftString, 1)]
    [Dictionary('ALG_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_CANCELADO: String read FALG_CANCELADO write FALG_CANCELADO;
    const ALG_CANCELADO_Name = 'ALG_CANCELADO';

    [Restrictions([NoValidate])]
    [Column('ALG_PROCESSADO', ftString, 1)]
    [Dictionary('ALG_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_PROCESSADO: String read FALG_PROCESSADO write FALG_PROCESSADO;
    const ALG_PROCESSADO_Name = 'ALG_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('ALG_DATACANCELAMENTO', ftDateTime)]
    [Dictionary('ALG_DATACANCELAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property ALG_DATACANCELAMENTO: TDateTime read FALG_DATACANCELAMENTO write FALG_DATACANCELAMENTO;
    const ALG_DATACANCELAMENTO_Name = 'ALG_DATACANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('ALG_OBSERVACAOCANCELAMENTO', ftString, 300)]
    [Dictionary('ALG_OBSERVACAOCANCELAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_OBSERVACAOCANCELAMENTO: String read FALG_OBSERVACAOCANCELAMENTO write FALG_OBSERVACAOCANCELAMENTO;
    const ALG_OBSERVACAOCANCELAMENTO_Name = 'ALG_OBSERVACAOCANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('ALG_ID_OLD', ftInteger)]
    [Dictionary('ALG_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property ALG_ID_OLD: Integer read FALG_ID_OLD write FALG_ID_OLD;
    const ALG_ID_OLD_Name = 'ALG_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoALG_00)

end.
