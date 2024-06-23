unit express.dbo.EXP_CONTABIL_FATURAS;

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
  [Table('EXP_Contabil_Faturas', '')]
  TDtoEXP_Contabil_Faturas = class
  private
    { Private declarations } 
    FEXP_TIPO: String;
    FEXP_ID: Integer;
    FCOM_CODIGO: Integer;
    FTDC_CODIGO: String;
    FEXP_DATAEMISSAO: TDateTime;
    FEXP_DATAENTRADA: TDateTime;
    FEXP_DATALANCAMENTO: TDateTime;
    FEXP_NOTAFISCAL: String;
    FEXP_SERIE: String;
    FEXP_INTEGRACAO: String;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FPES_TIPOPESSOA: String;
    FPES_UF: String;
    FPES_CNPJ_CPF: String;
    FPES_IE_CI: String;
    FEXP_OBSERVACAO: String;
    FEXP_CANCELADO: String;
    FEXP_TIPOFRETE: String;
    FCID_IBGE: String;
  public 
    { Public declarations } 
     const Table      = 'EXP_Contabil_Faturas';

    [Restrictions([NoValidate, NotNull])]
    [Column('EXP_TIPO', ftString, 3)]
    [Dictionary('EXP_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property EXP_TIPO: String read FEXP_TIPO write FEXP_TIPO;
    const EXP_TIPO_Name = 'EXP_TIPO';

    [Restrictions([NoValidate, NotNull])]
    [Column('EXP_ID', ftInteger)]
    [Dictionary('EXP_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property EXP_ID: Integer read FEXP_ID write FEXP_ID;
    const EXP_ID_Name = 'EXP_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('TDC_CODIGO', ftString, 4)]
    [Dictionary('TDC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TDC_CODIGO: String read FTDC_CODIGO write FTDC_CODIGO;
    const TDC_CODIGO_Name = 'TDC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('EXP_DATAEMISSAO', ftDateTime)]
    [Dictionary('EXP_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property EXP_DATAEMISSAO: TDateTime read FEXP_DATAEMISSAO write FEXP_DATAEMISSAO;
    const EXP_DATAEMISSAO_Name = 'EXP_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('EXP_DATAENTRADA', ftDateTime)]
    [Dictionary('EXP_DATAENTRADA', 'Mensagem de validação', '', '', '', taCenter)]
    property EXP_DATAENTRADA: TDateTime read FEXP_DATAENTRADA write FEXP_DATAENTRADA;
    const EXP_DATAENTRADA_Name = 'EXP_DATAENTRADA';

    [Restrictions([NoValidate])]
    [Column('EXP_DATALANCAMENTO', ftDateTime)]
    [Dictionary('EXP_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property EXP_DATALANCAMENTO: TDateTime read FEXP_DATALANCAMENTO write FEXP_DATALANCAMENTO;
    const EXP_DATALANCAMENTO_Name = 'EXP_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('EXP_NOTAFISCAL', ftString, 9)]
    [Dictionary('EXP_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property EXP_NOTAFISCAL: String read FEXP_NOTAFISCAL write FEXP_NOTAFISCAL;
    const EXP_NOTAFISCAL_Name = 'EXP_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('EXP_SERIE', ftString, 3)]
    [Dictionary('EXP_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property EXP_SERIE: String read FEXP_SERIE write FEXP_SERIE;
    const EXP_SERIE_Name = 'EXP_SERIE';

    [Restrictions([NoValidate])]
    [Column('EXP_INTEGRACAO', ftString, 20)]
    [Dictionary('EXP_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property EXP_INTEGRACAO: String read FEXP_INTEGRACAO write FEXP_INTEGRACAO;
    const EXP_INTEGRACAO_Name = 'EXP_INTEGRACAO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOPESSOA', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA: String read FPES_TIPOPESSOA write FPES_TIPOPESSOA;
    const PES_TIPOPESSOA_Name = 'PES_TIPOPESSOA';

    [Restrictions([NoValidate])]
    [Column('PES_UF', ftString, 2)]
    [Dictionary('PES_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF: String read FPES_UF write FPES_UF;
    const PES_UF_Name = 'PES_UF';

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
    [Column('EXP_OBSERVACAO', ftString, 5000)]
    [Dictionary('EXP_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property EXP_OBSERVACAO: String read FEXP_OBSERVACAO write FEXP_OBSERVACAO;
    const EXP_OBSERVACAO_Name = 'EXP_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('EXP_CANCELADO', ftString, 1)]
    [Dictionary('EXP_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property EXP_CANCELADO: String read FEXP_CANCELADO write FEXP_CANCELADO;
    const EXP_CANCELADO_Name = 'EXP_CANCELADO';

    [Restrictions([NoValidate])]
    [Column('EXP_TIPOFRETE', ftString, 1)]
    [Dictionary('EXP_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property EXP_TIPOFRETE: String read FEXP_TIPOFRETE write FEXP_TIPOFRETE;
    const EXP_TIPOFRETE_Name = 'EXP_TIPOFRETE';

    [Restrictions([NoValidate])]
    [Column('CID_IBGE', ftString, 7)]
    [Dictionary('CID_IBGE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE: String read FCID_IBGE write FCID_IBGE;
    const CID_IBGE_Name = 'CID_IBGE';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoEXP_Contabil_Faturas)

end.
