unit express.dbo.MDO_00;

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
  [Table('MDO_00', '')]
  [PrimaryKey('MDO_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_MDO_CODIGO')]
  TDtoMDO_00 = class
  private
    { Private declarations } 
    FMDO_CODIGO: Integer;
    FAQT_CODIGO: Integer;
    FLEF_CODIGO: Integer;
    FMDO_DESCRICAO: String;
    FMDO_NOMEAPELIDO: String;
    FMDO_VALORHORA: Double;
    FMDO_QUANTIDADEROHORA: Double;
    FMDO_PERIODOGARANTIA: String;
    FMDO_TIPOSERVICO: String;
    FMDO_OBSERVACAO: String;
    FMDO_NEGOCIARPRECO: String;
    FMDO_PATHIMAGEM: String;
    FMDO_SIGLASISTEMA: String;
    FMDO_DESATIVADO: String;
    FMDO_DATAALTERACAO: TDateTime;
    FMDO_CODIGOCNAE: String;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'MDO_00';
     const PrimaryKey = 'MDO_CODIGO';
     const Sequence   = 'SEQ_MDO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MDO_CODIGO', ftInteger)]
    [Dictionary('MDO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property MDO_CODIGO: Integer read FMDO_CODIGO write FMDO_CODIGO;
    const MDO_CODIGO_Name = 'MDO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('AQT_CODIGO', ftInteger)]
    [Dictionary('AQT_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property AQT_CODIGO: Integer read FAQT_CODIGO write FAQT_CODIGO;
    const AQT_CODIGO_Name = 'AQT_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LEF_CODIGO', ftInteger)]
    [Dictionary('LEF_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEF_CODIGO: Integer read FLEF_CODIGO write FLEF_CODIGO;
    const LEF_CODIGO_Name = 'LEF_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MDO_DESCRICAO', ftString, 300)]
    [Dictionary('MDO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MDO_DESCRICAO: String read FMDO_DESCRICAO write FMDO_DESCRICAO;
    const MDO_DESCRICAO_Name = 'MDO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('MDO_NOMEAPELIDO', ftString, 10)]
    [Dictionary('MDO_NOMEAPELIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MDO_NOMEAPELIDO: String read FMDO_NOMEAPELIDO write FMDO_NOMEAPELIDO;
    const MDO_NOMEAPELIDO_Name = 'MDO_NOMEAPELIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MDO_VALORHORA', ftBCD, 18, 4)]
    [Dictionary('MDO_VALORHORA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MDO_VALORHORA: Double read FMDO_VALORHORA write FMDO_VALORHORA;
    const MDO_VALORHORA_Name = 'MDO_VALORHORA';

    [Restrictions([NoValidate, NotNull])]
    [Column('MDO_QUANTIDADEROHORA', ftBCD)]
    [Dictionary('MDO_QUANTIDADEROHORA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MDO_QUANTIDADEROHORA: Double read FMDO_QUANTIDADEROHORA write FMDO_QUANTIDADEROHORA;
    const MDO_QUANTIDADEROHORA_Name = 'MDO_QUANTIDADEROHORA';

    [Restrictions([NoValidate])]
    [Column('MDO_PERIODOGARANTIA', ftString, 2)]
    [Dictionary('MDO_PERIODOGARANTIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MDO_PERIODOGARANTIA: String read FMDO_PERIODOGARANTIA write FMDO_PERIODOGARANTIA;
    const MDO_PERIODOGARANTIA_Name = 'MDO_PERIODOGARANTIA';

    [Restrictions([NoValidate])]
    [Column('MDO_TIPOSERVICO', ftString, 1)]
    [Dictionary('MDO_TIPOSERVICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MDO_TIPOSERVICO: String read FMDO_TIPOSERVICO write FMDO_TIPOSERVICO;
    const MDO_TIPOSERVICO_Name = 'MDO_TIPOSERVICO';

    [Restrictions([NoValidate])]
    [Column('MDO_OBSERVACAO', ftString, 5000)]
    [Dictionary('MDO_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MDO_OBSERVACAO: String read FMDO_OBSERVACAO write FMDO_OBSERVACAO;
    const MDO_OBSERVACAO_Name = 'MDO_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('MDO_NEGOCIARPRECO', ftString, 1)]
    [Dictionary('MDO_NEGOCIARPRECO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MDO_NEGOCIARPRECO: String read FMDO_NEGOCIARPRECO write FMDO_NEGOCIARPRECO;
    const MDO_NEGOCIARPRECO_Name = 'MDO_NEGOCIARPRECO';

    [Restrictions([NoValidate])]
    [Column('MDO_PATHIMAGEM', ftString, 300)]
    [Dictionary('MDO_PATHIMAGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MDO_PATHIMAGEM: String read FMDO_PATHIMAGEM write FMDO_PATHIMAGEM;
    const MDO_PATHIMAGEM_Name = 'MDO_PATHIMAGEM';

    [Restrictions([NoValidate])]
    [Column('MDO_SIGLASISTEMA', ftString, 5)]
    [Dictionary('MDO_SIGLASISTEMA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MDO_SIGLASISTEMA: String read FMDO_SIGLASISTEMA write FMDO_SIGLASISTEMA;
    const MDO_SIGLASISTEMA_Name = 'MDO_SIGLASISTEMA';

    [Restrictions([NoValidate, NotNull])]
    [Column('MDO_DESATIVADO', ftString, 1)]
    [Dictionary('MDO_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MDO_DESATIVADO: String read FMDO_DESATIVADO write FMDO_DESATIVADO;
    const MDO_DESATIVADO_Name = 'MDO_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MDO_DATAALTERACAO', ftDateTime)]
    [Dictionary('MDO_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MDO_DATAALTERACAO: TDateTime read FMDO_DATAALTERACAO write FMDO_DATAALTERACAO;
    const MDO_DATAALTERACAO_Name = 'MDO_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('MDO_CODIGOCNAE', ftString, 20)]
    [Dictionary('MDO_CODIGOCNAE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MDO_CODIGOCNAE: String read FMDO_CODIGOCNAE write FMDO_CODIGOCNAE;
    const MDO_CODIGOCNAE_Name = 'MDO_CODIGOCNAE';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoMDO_00)

end.
