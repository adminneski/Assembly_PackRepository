unit express.dbo.FPG_00;

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
  [Table('FPG_00', '')]
  [PrimaryKey('FPG_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_FPG_CODIGO')]
  TDtoFPG_00 = class
  private
    { Private declarations } 
    FFPG_CODIGO: Integer;
    FFPG_DESCRICAO: String;
    FPLC_CODIGO: Integer;
    FFPG_NOMEAPELIDO: String;
    FFPG_TIPOPAGAMENTO: Integer;
    FFPG_TIPOPAGTOCOMISSAO: String;
    FFPG_DESATIVADO: String;
    FFPG_DATAALTERACAO: TDateTime;
    FFPG_GERARPALM: String;
    FFPG_OBSERVACAOPEDIDO: String;
    FCTB_CODIGO: Integer;
    FCOM_CODIGO: Integer;
    FCTA_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'FPG_00';
     const PrimaryKey = 'FPG_CODIGO';
     const Sequence   = 'SEQ_FPG_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FPG_DESCRICAO', ftString, 30)]
    [Dictionary('FPG_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FPG_DESCRICAO: String read FFPG_DESCRICAO write FFPG_DESCRICAO;
    const FPG_DESCRICAO_Name = 'FPG_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PLC_CODIGO', ftInteger)]
    [Dictionary('PLC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGO: Integer read FPLC_CODIGO write FPLC_CODIGO;
    const PLC_CODIGO_Name = 'PLC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FPG_NOMEAPELIDO', ftString, 10)]
    [Dictionary('FPG_NOMEAPELIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FPG_NOMEAPELIDO: String read FFPG_NOMEAPELIDO write FFPG_NOMEAPELIDO;
    const FPG_NOMEAPELIDO_Name = 'FPG_NOMEAPELIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FPG_TIPOPAGAMENTO', ftInteger)]
    [Dictionary('FPG_TIPOPAGAMENTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_TIPOPAGAMENTO: Integer read FFPG_TIPOPAGAMENTO write FFPG_TIPOPAGAMENTO;
    const FPG_TIPOPAGAMENTO_Name = 'FPG_TIPOPAGAMENTO';

    [Restrictions([NoValidate])]
    [Column('FPG_TIPOPAGTOCOMISSAO', ftString, 1)]
    [Dictionary('FPG_TIPOPAGTOCOMISSAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FPG_TIPOPAGTOCOMISSAO: String read FFPG_TIPOPAGTOCOMISSAO write FFPG_TIPOPAGTOCOMISSAO;
    const FPG_TIPOPAGTOCOMISSAO_Name = 'FPG_TIPOPAGTOCOMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FPG_DESATIVADO', ftString, 1)]
    [Dictionary('FPG_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FPG_DESATIVADO: String read FFPG_DESATIVADO write FFPG_DESATIVADO;
    const FPG_DESATIVADO_Name = 'FPG_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FPG_DATAALTERACAO', ftDateTime)]
    [Dictionary('FPG_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property FPG_DATAALTERACAO: TDateTime read FFPG_DATAALTERACAO write FFPG_DATAALTERACAO;
    const FPG_DATAALTERACAO_Name = 'FPG_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('FPG_GERARPALM', ftString, 1)]
    [Dictionary('FPG_GERARPALM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FPG_GERARPALM: String read FFPG_GERARPALM write FFPG_GERARPALM;
    const FPG_GERARPALM_Name = 'FPG_GERARPALM';

    [Restrictions([NoValidate])]
    [Column('FPG_OBSERVACAOPEDIDO', ftString, 300)]
    [Dictionary('FPG_OBSERVACAOPEDIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FPG_OBSERVACAOPEDIDO: String read FFPG_OBSERVACAOPEDIDO write FFPG_OBSERVACAOPEDIDO;
    const FPG_OBSERVACAOPEDIDO_Name = 'FPG_OBSERVACAOPEDIDO';

    [Restrictions([NoValidate])]
    [Column('CTB_CODIGO', ftInteger)]
    [Dictionary('CTB_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTB_CODIGO: Integer read FCTB_CODIGO write FCTB_CODIGO;
    const CTB_CODIGO_Name = 'CTB_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGO', ftInteger)]
    [Dictionary('CTA_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGO: Integer read FCTA_CODIGO write FCTA_CODIGO;
    const CTA_CODIGO_Name = 'CTA_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoFPG_00)

end.
