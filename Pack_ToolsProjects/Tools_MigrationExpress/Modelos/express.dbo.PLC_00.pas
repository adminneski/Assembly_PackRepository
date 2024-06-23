unit express.dbo.PLC_00;

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
  [Table('PLC_00', '')]
  [PrimaryKey('PLC_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PLC_CODIGO')]
  TDtoPLC_00 = class
  private
    { Private declarations } 
    FPLC_CODIGO: Integer;
    FPLC_PLANOCONTA: String;
    FPLC_DESCRICAO: String;
    FPLC_SIGLA: String;
    FHSP_CODIGO: Integer;
    FPLC_RATEIO: String;
    FPLC_DIVERSO: String;
    FPLC_DESATIVADO: String;
    FPLC_SIGLACONTABIL: String;
    FPLC_SAIRNOBALANCO: String;
    FPLC_INTEGRACAOCONTABIL: String;
    FPLC_DATAALTERACAO: TDateTime;
    FPLC_INTEGRACAOSPED: String;
    FPLC_HISTORICOPADRAOCONTABIL: String;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'PLC_00';
     const PrimaryKey = 'PLC_CODIGO';
     const Sequence   = 'SEQ_PLC_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PLC_CODIGO', ftInteger)]
    [Dictionary('PLC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGO: Integer read FPLC_CODIGO write FPLC_CODIGO;
    const PLC_CODIGO_Name = 'PLC_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PLC_PLANOCONTA', ftString, 10)]
    [Dictionary('PLC_PLANOCONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PLC_PLANOCONTA: String read FPLC_PLANOCONTA write FPLC_PLANOCONTA;
    const PLC_PLANOCONTA_Name = 'PLC_PLANOCONTA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PLC_DESCRICAO', ftString, 30)]
    [Dictionary('PLC_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PLC_DESCRICAO: String read FPLC_DESCRICAO write FPLC_DESCRICAO;
    const PLC_DESCRICAO_Name = 'PLC_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PLC_SIGLA', ftString, 3)]
    [Dictionary('PLC_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PLC_SIGLA: String read FPLC_SIGLA write FPLC_SIGLA;
    const PLC_SIGLA_Name = 'PLC_SIGLA';

    [Restrictions([NoValidate])]
    [Column('HSP_CODIGO', ftInteger)]
    [Dictionary('HSP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property HSP_CODIGO: Integer read FHSP_CODIGO write FHSP_CODIGO;
    const HSP_CODIGO_Name = 'HSP_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PLC_RATEIO', ftString, 1)]
    [Dictionary('PLC_RATEIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PLC_RATEIO: String read FPLC_RATEIO write FPLC_RATEIO;
    const PLC_RATEIO_Name = 'PLC_RATEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PLC_DIVERSO', ftString, 1)]
    [Dictionary('PLC_DIVERSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PLC_DIVERSO: String read FPLC_DIVERSO write FPLC_DIVERSO;
    const PLC_DIVERSO_Name = 'PLC_DIVERSO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PLC_DESATIVADO', ftString, 1)]
    [Dictionary('PLC_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PLC_DESATIVADO: String read FPLC_DESATIVADO write FPLC_DESATIVADO;
    const PLC_DESATIVADO_Name = 'PLC_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('PLC_SIGLACONTABIL', ftString, 3)]
    [Dictionary('PLC_SIGLACONTABIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PLC_SIGLACONTABIL: String read FPLC_SIGLACONTABIL write FPLC_SIGLACONTABIL;
    const PLC_SIGLACONTABIL_Name = 'PLC_SIGLACONTABIL';

    [Restrictions([NoValidate, NotNull])]
    [Column('PLC_SAIRNOBALANCO', ftString, 1)]
    [Dictionary('PLC_SAIRNOBALANCO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PLC_SAIRNOBALANCO: String read FPLC_SAIRNOBALANCO write FPLC_SAIRNOBALANCO;
    const PLC_SAIRNOBALANCO_Name = 'PLC_SAIRNOBALANCO';

    [Restrictions([NoValidate])]
    [Column('PLC_INTEGRACAOCONTABIL', ftString, 15)]
    [Dictionary('PLC_INTEGRACAOCONTABIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PLC_INTEGRACAOCONTABIL: String read FPLC_INTEGRACAOCONTABIL write FPLC_INTEGRACAOCONTABIL;
    const PLC_INTEGRACAOCONTABIL_Name = 'PLC_INTEGRACAOCONTABIL';

    [Restrictions([NoValidate, NotNull])]
    [Column('PLC_DATAALTERACAO', ftDateTime)]
    [Dictionary('PLC_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PLC_DATAALTERACAO: TDateTime read FPLC_DATAALTERACAO write FPLC_DATAALTERACAO;
    const PLC_DATAALTERACAO_Name = 'PLC_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('PLC_INTEGRACAOSPED', ftString, 60)]
    [Dictionary('PLC_INTEGRACAOSPED', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PLC_INTEGRACAOSPED: String read FPLC_INTEGRACAOSPED write FPLC_INTEGRACAOSPED;
    const PLC_INTEGRACAOSPED_Name = 'PLC_INTEGRACAOSPED';

    [Restrictions([NoValidate])]
    [Column('PLC_HISTORICOPADRAOCONTABIL', ftString, 1)]
    [Dictionary('PLC_HISTORICOPADRAOCONTABIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PLC_HISTORICOPADRAOCONTABIL: String read FPLC_HISTORICOPADRAOCONTABIL write FPLC_HISTORICOPADRAOCONTABIL;
    const PLC_HISTORICOPADRAOCONTABIL_Name = 'PLC_HISTORICOPADRAOCONTABIL';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPLC_00)

end.
