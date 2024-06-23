unit express.dbo.CRT_00;

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
  [Table('CRT_00', '')]
  [PrimaryKey('CRT_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CRT_CODIGO')]
  TDtoCRT_00 = class
  private
    { Private declarations } 
    FCRT_CODIGO: Integer;
    FCRT_DESCRICAO: String;
    FCRT_PERCENTUALFINANCEIRO: Double;
    FCRT_DIARECEBIMENTO: Integer;
    FCRT_DATAALTERACAO: TDateTime;
    FCRT_DESATIVADO: String;
    FCRT_CNPJCREDENCIADORA: String;
    FCRT_BANDEIRA: Integer;
    FCRED_CODIGO: String;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'CRT_00';
     const PrimaryKey = 'CRT_CODIGO';
     const Sequence   = 'SEQ_CRT_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRT_CODIGO', ftInteger)]
    [Dictionary('CRT_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRT_CODIGO: Integer read FCRT_CODIGO write FCRT_CODIGO;
    const CRT_CODIGO_Name = 'CRT_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRT_DESCRICAO', ftString, 30)]
    [Dictionary('CRT_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRT_DESCRICAO: String read FCRT_DESCRICAO write FCRT_DESCRICAO;
    const CRT_DESCRICAO_Name = 'CRT_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRT_PERCENTUALFINANCEIRO', ftBCD)]
    [Dictionary('CRT_PERCENTUALFINANCEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRT_PERCENTUALFINANCEIRO: Double read FCRT_PERCENTUALFINANCEIRO write FCRT_PERCENTUALFINANCEIRO;
    const CRT_PERCENTUALFINANCEIRO_Name = 'CRT_PERCENTUALFINANCEIRO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRT_DIARECEBIMENTO', ftInteger)]
    [Dictionary('CRT_DIARECEBIMENTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRT_DIARECEBIMENTO: Integer read FCRT_DIARECEBIMENTO write FCRT_DIARECEBIMENTO;
    const CRT_DIARECEBIMENTO_Name = 'CRT_DIARECEBIMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRT_DATAALTERACAO', ftDateTime)]
    [Dictionary('CRT_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRT_DATAALTERACAO: TDateTime read FCRT_DATAALTERACAO write FCRT_DATAALTERACAO;
    const CRT_DATAALTERACAO_Name = 'CRT_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRT_DESATIVADO', ftString, 1)]
    [Dictionary('CRT_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRT_DESATIVADO: String read FCRT_DESATIVADO write FCRT_DESATIVADO;
    const CRT_DESATIVADO_Name = 'CRT_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('CRT_CNPJCREDENCIADORA', ftString, 14)]
    [Dictionary('CRT_CNPJCREDENCIADORA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRT_CNPJCREDENCIADORA: String read FCRT_CNPJCREDENCIADORA write FCRT_CNPJCREDENCIADORA;
    const CRT_CNPJCREDENCIADORA_Name = 'CRT_CNPJCREDENCIADORA';

    [Restrictions([NoValidate])]
    [Column('CRT_BANDEIRA', ftInteger)]
    [Dictionary('CRT_BANDEIRA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRT_BANDEIRA: Integer read FCRT_BANDEIRA write FCRT_BANDEIRA;
    const CRT_BANDEIRA_Name = 'CRT_BANDEIRA';

    [Restrictions([NoValidate])]
    [Column('CRED_CODIGO', ftString, 6)]
    [Dictionary('CRED_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRED_CODIGO: String read FCRED_CODIGO write FCRED_CODIGO;
    const CRED_CODIGO_Name = 'CRED_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCRT_00)

end.
