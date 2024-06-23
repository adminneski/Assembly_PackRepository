unit express.dbo.VW_PSQ_ALG;

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
  [Table('VW_PSQ_ALG', '')]
  TDtoVW_PSQ_ALG = class
  private
    { Private declarations } 
    FALG_ID: Integer;
    FPES_CODIGO: Integer;
    FCOM_CODIGO: Integer;
    FALG_DATALANCAMENTO: TDateTime;
    FPES_NOME: String;
    FPES_CNPJ_CPF: String;
    FPES_IE_CI: String;
    FVND_NOME: String;
    FALG_DATAALTERACAO: TDateTime;
    FALG_DATAUTILIZACAO: TDateTime;
    FALG_OBSERVACAO: String;
    FALG_TOTALLIQUIDO: Double;
    FALG_PROCESSADO: String;
    FALG_CANCELADO: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_ALG';

    [Restrictions([NoValidate, NotNull])]
    [Column('ALG_ID', ftInteger)]
    [Dictionary('ALG_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ALG_ID: Integer read FALG_ID write FALG_ID;
    const ALG_ID_Name = 'ALG_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ALG_DATALANCAMENTO', ftDateTime)]
    [Dictionary('ALG_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property ALG_DATALANCAMENTO: TDateTime read FALG_DATALANCAMENTO write FALG_DATALANCAMENTO;
    const ALG_DATALANCAMENTO_Name = 'ALG_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF: String read FPES_CNPJ_CPF write FPES_CNPJ_CPF;
    const PES_CNPJ_CPF_Name = 'PES_CNPJ_CPF';

    [Restrictions([NoValidate])]
    [Column('PES_IE_CI', ftString, 16)]
    [Dictionary('PES_IE_CI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE_CI: String read FPES_IE_CI write FPES_IE_CI;
    const PES_IE_CI_Name = 'PES_IE_CI';

    [Restrictions([NoValidate])]
    [Column('VND_NOME', ftString, 100)]
    [Dictionary('VND_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VND_NOME: String read FVND_NOME write FVND_NOME;
    const VND_NOME_Name = 'VND_NOME';

    [Restrictions([NoValidate, NotNull])]
    [Column('ALG_DATAALTERACAO', ftDateTime)]
    [Dictionary('ALG_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property ALG_DATAALTERACAO: TDateTime read FALG_DATAALTERACAO write FALG_DATAALTERACAO;
    const ALG_DATAALTERACAO_Name = 'ALG_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('ALG_DATAUTILIZACAO', ftDateTime)]
    [Dictionary('ALG_DATAUTILIZACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property ALG_DATAUTILIZACAO: TDateTime read FALG_DATAUTILIZACAO write FALG_DATAUTILIZACAO;
    const ALG_DATAUTILIZACAO_Name = 'ALG_DATAUTILIZACAO';

    [Restrictions([NoValidate])]
    [Column('ALG_OBSERVACAO', ftString, 5000)]
    [Dictionary('ALG_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_OBSERVACAO: String read FALG_OBSERVACAO write FALG_OBSERVACAO;
    const ALG_OBSERVACAO_Name = 'ALG_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ALG_TOTALLIQUIDO', ftBCD)]
    [Dictionary('ALG_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ALG_TOTALLIQUIDO: Double read FALG_TOTALLIQUIDO write FALG_TOTALLIQUIDO;
    const ALG_TOTALLIQUIDO_Name = 'ALG_TOTALLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('ALG_PROCESSADO', ftString, 1)]
    [Dictionary('ALG_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_PROCESSADO: String read FALG_PROCESSADO write FALG_PROCESSADO;
    const ALG_PROCESSADO_Name = 'ALG_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('ALG_CANCELADO', ftString, 1)]
    [Dictionary('ALG_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ALG_CANCELADO: String read FALG_CANCELADO write FALG_CANCELADO;
    const ALG_CANCELADO_Name = 'ALG_CANCELADO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_ALG)

end.
