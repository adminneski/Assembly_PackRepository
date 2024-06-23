unit express.dbo.CTA_00;

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
  [Table('CTA_00', '')]
  [PrimaryKey('CTA_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CTA_CODIGO')]
  TDtoCTA_00 = class
  private
    { Private declarations } 
    FCTA_CODIGO: Integer;
    FCOM_CODIGO: Integer;
    FCTA_DATACADASTRO: TDateTime;
    FCID_IBGE: String;
    FCEP_CODIGO: String;
    FCTA_BAIRRO: String;
    FCTA_CONTA: String;
    FBCO_CODIGO: Integer;
    FPLC_CODIGO: Integer;
    FCTA_TIPO: String;
    FCTA_AGENCIA: String;
    FCTA_EMITENTE: String;
    FCTA_ENDERECO: String;
    FCTA_NOMEAPELIDO: String;
    FCTA_NUMEROENDERECO: String;
    FCTA_NUMEROCHEQUE: Integer;
    FCTA_DDD_TELEFONE_1: String;
    FCTA_DDD_TELEFONE_2: String;
    FCTA_DDD_FAX: String;
    FCTA_GERENTECONTA: String;
    FCTA_EMAIL: String;
    FCTA_SALDOESPECIAL: Double;
    FCTA_SALDOLIMITEROTATIVO: Double;
    FCTA_TOTALPREDATADOS: Double;
    FCTA_INTEGRACAOCONTABIL: String;
    FCTA_CONFIGURACOES: String;
    FCTA_ULTIMONOSSONUMERO: String;
    FCTA_CONTROLER: String;
    FCTA_DESATIVADO: String;
    FCTA_DATAALTERACAO: TDateTime;
    FCTA_CIDADE: String;
    FCTA_UF: String;
  public 
    { Public declarations } 
     const Table      = 'CTA_00';
     const PrimaryKey = 'CTA_CODIGO';
     const Sequence   = 'SEQ_CTA_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTA_CODIGO', ftInteger)]
    [Dictionary('CTA_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGO: Integer read FCTA_CODIGO write FCTA_CODIGO;
    const CTA_CODIGO_Name = 'CTA_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTA_DATACADASTRO', ftDateTime)]
    [Dictionary('CTA_DATACADASTRO', 'Mensagem de validação', '', '', '', taCenter)]
    property CTA_DATACADASTRO: TDateTime read FCTA_DATACADASTRO write FCTA_DATACADASTRO;
    const CTA_DATACADASTRO_Name = 'CTA_DATACADASTRO';

    [Restrictions([NoValidate])]
    [Column('CID_IBGE', ftString, 7)]
    [Dictionary('CID_IBGE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE: String read FCID_IBGE write FCID_IBGE;
    const CID_IBGE_Name = 'CID_IBGE';

    [Restrictions([NoValidate])]
    [Column('CEP_CODIGO', ftString, 8)]
    [Dictionary('CEP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEP_CODIGO: String read FCEP_CODIGO write FCEP_CODIGO;
    const CEP_CODIGO_Name = 'CEP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTA_BAIRRO', ftString, 30)]
    [Dictionary('CTA_BAIRRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_BAIRRO: String read FCTA_BAIRRO write FCTA_BAIRRO;
    const CTA_BAIRRO_Name = 'CTA_BAIRRO';

    [Restrictions([NoValidate])]
    [Column('CTA_CONTA', ftString, 15)]
    [Dictionary('CTA_CONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_CONTA: String read FCTA_CONTA write FCTA_CONTA;
    const CTA_CONTA_Name = 'CTA_CONTA';

    [Restrictions([NoValidate])]
    [Column('BCO_CODIGO', ftInteger)]
    [Dictionary('BCO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCO_CODIGO: Integer read FBCO_CODIGO write FBCO_CODIGO;
    const BCO_CODIGO_Name = 'BCO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGO', ftInteger)]
    [Dictionary('PLC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGO: Integer read FPLC_CODIGO write FPLC_CODIGO;
    const PLC_CODIGO_Name = 'PLC_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTA_TIPO', ftString, 1)]
    [Dictionary('CTA_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_TIPO: String read FCTA_TIPO write FCTA_TIPO;
    const CTA_TIPO_Name = 'CTA_TIPO';

    [Restrictions([NoValidate])]
    [Column('CTA_AGENCIA', ftString, 10)]
    [Dictionary('CTA_AGENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_AGENCIA: String read FCTA_AGENCIA write FCTA_AGENCIA;
    const CTA_AGENCIA_Name = 'CTA_AGENCIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTA_EMITENTE', ftString, 50)]
    [Dictionary('CTA_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_EMITENTE: String read FCTA_EMITENTE write FCTA_EMITENTE;
    const CTA_EMITENTE_Name = 'CTA_EMITENTE';

    [Restrictions([NoValidate])]
    [Column('CTA_ENDERECO', ftString, 50)]
    [Dictionary('CTA_ENDERECO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_ENDERECO: String read FCTA_ENDERECO write FCTA_ENDERECO;
    const CTA_ENDERECO_Name = 'CTA_ENDERECO';

    [Restrictions([NoValidate])]
    [Column('CTA_NOMEAPELIDO', ftString, 10)]
    [Dictionary('CTA_NOMEAPELIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_NOMEAPELIDO: String read FCTA_NOMEAPELIDO write FCTA_NOMEAPELIDO;
    const CTA_NOMEAPELIDO_Name = 'CTA_NOMEAPELIDO';

    [Restrictions([NoValidate])]
    [Column('CTA_NUMEROENDERECO', ftString, 5)]
    [Dictionary('CTA_NUMEROENDERECO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_NUMEROENDERECO: String read FCTA_NUMEROENDERECO write FCTA_NUMEROENDERECO;
    const CTA_NUMEROENDERECO_Name = 'CTA_NUMEROENDERECO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTA_NUMEROCHEQUE', ftInteger)]
    [Dictionary('CTA_NUMEROCHEQUE', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_NUMEROCHEQUE: Integer read FCTA_NUMEROCHEQUE write FCTA_NUMEROCHEQUE;
    const CTA_NUMEROCHEQUE_Name = 'CTA_NUMEROCHEQUE';

    [Restrictions([NoValidate])]
    [Column('CTA_DDD_TELEFONE_1', ftString, 11)]
    [Dictionary('CTA_DDD_TELEFONE_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_DDD_TELEFONE_1: String read FCTA_DDD_TELEFONE_1 write FCTA_DDD_TELEFONE_1;
    const CTA_DDD_TELEFONE_1_Name = 'CTA_DDD_TELEFONE_1';

    [Restrictions([NoValidate])]
    [Column('CTA_DDD_TELEFONE_2', ftString, 11)]
    [Dictionary('CTA_DDD_TELEFONE_2', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_DDD_TELEFONE_2: String read FCTA_DDD_TELEFONE_2 write FCTA_DDD_TELEFONE_2;
    const CTA_DDD_TELEFONE_2_Name = 'CTA_DDD_TELEFONE_2';

    [Restrictions([NoValidate])]
    [Column('CTA_DDD_FAX', ftString, 11)]
    [Dictionary('CTA_DDD_FAX', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_DDD_FAX: String read FCTA_DDD_FAX write FCTA_DDD_FAX;
    const CTA_DDD_FAX_Name = 'CTA_DDD_FAX';

    [Restrictions([NoValidate])]
    [Column('CTA_GERENTECONTA', ftString, 30)]
    [Dictionary('CTA_GERENTECONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_GERENTECONTA: String read FCTA_GERENTECONTA write FCTA_GERENTECONTA;
    const CTA_GERENTECONTA_Name = 'CTA_GERENTECONTA';

    [Restrictions([NoValidate])]
    [Column('CTA_EMAIL', ftString, 30)]
    [Dictionary('CTA_EMAIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_EMAIL: String read FCTA_EMAIL write FCTA_EMAIL;
    const CTA_EMAIL_Name = 'CTA_EMAIL';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTA_SALDOESPECIAL', ftBCD)]
    [Dictionary('CTA_SALDOESPECIAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTA_SALDOESPECIAL: Double read FCTA_SALDOESPECIAL write FCTA_SALDOESPECIAL;
    const CTA_SALDOESPECIAL_Name = 'CTA_SALDOESPECIAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTA_SALDOLIMITEROTATIVO', ftBCD)]
    [Dictionary('CTA_SALDOLIMITEROTATIVO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTA_SALDOLIMITEROTATIVO: Double read FCTA_SALDOLIMITEROTATIVO write FCTA_SALDOLIMITEROTATIVO;
    const CTA_SALDOLIMITEROTATIVO_Name = 'CTA_SALDOLIMITEROTATIVO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTA_TOTALPREDATADOS', ftBCD)]
    [Dictionary('CTA_TOTALPREDATADOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTA_TOTALPREDATADOS: Double read FCTA_TOTALPREDATADOS write FCTA_TOTALPREDATADOS;
    const CTA_TOTALPREDATADOS_Name = 'CTA_TOTALPREDATADOS';

    [Restrictions([NoValidate])]
    [Column('CTA_INTEGRACAOCONTABIL', ftString, 15)]
    [Dictionary('CTA_INTEGRACAOCONTABIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_INTEGRACAOCONTABIL: String read FCTA_INTEGRACAOCONTABIL write FCTA_INTEGRACAOCONTABIL;
    const CTA_INTEGRACAOCONTABIL_Name = 'CTA_INTEGRACAOCONTABIL';

    [Restrictions([NoValidate])]
    [Column('CTA_CONFIGURACOES', ftString, 100)]
    [Dictionary('CTA_CONFIGURACOES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_CONFIGURACOES: String read FCTA_CONFIGURACOES write FCTA_CONFIGURACOES;
    const CTA_CONFIGURACOES_Name = 'CTA_CONFIGURACOES';

    [Restrictions([NoValidate])]
    [Column('CTA_ULTIMONOSSONUMERO', ftString, 20)]
    [Dictionary('CTA_ULTIMONOSSONUMERO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_ULTIMONOSSONUMERO: String read FCTA_ULTIMONOSSONUMERO write FCTA_ULTIMONOSSONUMERO;
    const CTA_ULTIMONOSSONUMERO_Name = 'CTA_ULTIMONOSSONUMERO';

    [Restrictions([NoValidate])]
    [Column('CTA_CONTROLER', ftString, 1)]
    [Dictionary('CTA_CONTROLER', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_CONTROLER: String read FCTA_CONTROLER write FCTA_CONTROLER;
    const CTA_CONTROLER_Name = 'CTA_CONTROLER';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTA_DESATIVADO', ftString, 1)]
    [Dictionary('CTA_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_DESATIVADO: String read FCTA_DESATIVADO write FCTA_DESATIVADO;
    const CTA_DESATIVADO_Name = 'CTA_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTA_DATAALTERACAO', ftDateTime)]
    [Dictionary('CTA_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CTA_DATAALTERACAO: TDateTime read FCTA_DATAALTERACAO write FCTA_DATAALTERACAO;
    const CTA_DATAALTERACAO_Name = 'CTA_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CTA_CIDADE', ftString, 100)]
    [Dictionary('CTA_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_CIDADE: String read FCTA_CIDADE write FCTA_CIDADE;
    const CTA_CIDADE_Name = 'CTA_CIDADE';

    [Restrictions([NoValidate])]
    [Column('CTA_UF', ftString, 2)]
    [Dictionary('CTA_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_UF: String read FCTA_UF write FCTA_UF;
    const CTA_UF_Name = 'CTA_UF';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCTA_00)

end.
