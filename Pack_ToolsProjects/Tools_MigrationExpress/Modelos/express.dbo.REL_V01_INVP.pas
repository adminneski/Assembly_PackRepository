unit express.dbo.REL_V01_INVP;

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
  [Table('REL_V01_INVP', '')]
  TDtoREL_V01_INVP = class
  private
    { Private declarations } 
    FINVP_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FPES_TIPOPESSOA: String;
    FPES_CNPJ_CPF: String;
    FPES_IE_CI: String;
    FCOM_UF: String;
    FPRO_CODIGO: Integer;
    FPRO_DESCRICAO: String;
    FSGM_CODIGO: String;
    FINVP_DATAFECHAMENTO: TDateTime;
    FINVP_SALDOFECHAMENTO: Double;
    FINVP_VALORCUSTOARMAZENAGEM: Double;
    FINVP_VALORCUSTOARMAZENAGEMMEDIO: Double;
    FINVP_QTDENTRADA: Double;
    FINVP_QTDSAIDA: Double;
    FGRP_DESCRICAO: String;
    FGRP_CODIGO: Integer;
    FGRP_GRUPO: String;
    FSGP_CODIGO: Integer;
    FSGP_DESCRICAO: String;
    FSGP_SUBGRUPO: String;
    FCST_CODIGO: String;
    FFAB_CODIGO: Integer;
    FFAB_NOME: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_INVP';

    [Restrictions([NoValidate, NotNull])]
    [Column('INVP_ID', ftInteger)]
    [Dictionary('INVP_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property INVP_ID: Integer read FINVP_ID write FINVP_ID;
    const INVP_ID_Name = 'INVP_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

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
    [Column('COM_UF', ftString, 2)]
    [Dictionary('COM_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_UF: String read FCOM_UF write FCOM_UF;
    const COM_UF_Name = 'COM_UF';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('SGM_CODIGO', ftString, 2)]
    [Dictionary('SGM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_CODIGO: String read FSGM_CODIGO write FSGM_CODIGO;
    const SGM_CODIGO_Name = 'SGM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INVP_DATAFECHAMENTO', ftDateTime)]
    [Dictionary('INVP_DATAFECHAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property INVP_DATAFECHAMENTO: TDateTime read FINVP_DATAFECHAMENTO write FINVP_DATAFECHAMENTO;
    const INVP_DATAFECHAMENTO_Name = 'INVP_DATAFECHAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INVP_SALDOFECHAMENTO', ftBCD, 18, 4)]
    [Dictionary('INVP_SALDOFECHAMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INVP_SALDOFECHAMENTO: Double read FINVP_SALDOFECHAMENTO write FINVP_SALDOFECHAMENTO;
    const INVP_SALDOFECHAMENTO_Name = 'INVP_SALDOFECHAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INVP_VALORCUSTOARMAZENAGEM', ftBCD, 18, 4)]
    [Dictionary('INVP_VALORCUSTOARMAZENAGEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INVP_VALORCUSTOARMAZENAGEM: Double read FINVP_VALORCUSTOARMAZENAGEM write FINVP_VALORCUSTOARMAZENAGEM;
    const INVP_VALORCUSTOARMAZENAGEM_Name = 'INVP_VALORCUSTOARMAZENAGEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('INVP_VALORCUSTOARMAZENAGEMMEDIO', ftBCD, 18, 4)]
    [Dictionary('INVP_VALORCUSTOARMAZENAGEMMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INVP_VALORCUSTOARMAZENAGEMMEDIO: Double read FINVP_VALORCUSTOARMAZENAGEMMEDIO write FINVP_VALORCUSTOARMAZENAGEMMEDIO;
    const INVP_VALORCUSTOARMAZENAGEMMEDIO_Name = 'INVP_VALORCUSTOARMAZENAGEMMEDIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INVP_QTDENTRADA', ftBCD, 18, 4)]
    [Dictionary('INVP_QTDENTRADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INVP_QTDENTRADA: Double read FINVP_QTDENTRADA write FINVP_QTDENTRADA;
    const INVP_QTDENTRADA_Name = 'INVP_QTDENTRADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('INVP_QTDSAIDA', ftBCD, 18, 4)]
    [Dictionary('INVP_QTDSAIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INVP_QTDSAIDA: Double read FINVP_QTDSAIDA write FINVP_QTDSAIDA;
    const INVP_QTDSAIDA_Name = 'INVP_QTDSAIDA';

    [Restrictions([NoValidate])]
    [Column('GRP_DESCRICAO', ftString, 50)]
    [Dictionary('GRP_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRP_DESCRICAO: String read FGRP_DESCRICAO write FGRP_DESCRICAO;
    const GRP_DESCRICAO_Name = 'GRP_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('GRP_CODIGO', ftInteger)]
    [Dictionary('GRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property GRP_CODIGO: Integer read FGRP_CODIGO write FGRP_CODIGO;
    const GRP_CODIGO_Name = 'GRP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('GRP_GRUPO', ftString, 4)]
    [Dictionary('GRP_GRUPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRP_GRUPO: String read FGRP_GRUPO write FGRP_GRUPO;
    const GRP_GRUPO_Name = 'GRP_GRUPO';

    [Restrictions([NoValidate])]
    [Column('SGP_CODIGO', ftInteger)]
    [Dictionary('SGP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property SGP_CODIGO: Integer read FSGP_CODIGO write FSGP_CODIGO;
    const SGP_CODIGO_Name = 'SGP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('SGP_DESCRICAO', ftString, 50)]
    [Dictionary('SGP_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGP_DESCRICAO: String read FSGP_DESCRICAO write FSGP_DESCRICAO;
    const SGP_DESCRICAO_Name = 'SGP_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('SGP_SUBGRUPO', ftString, 4)]
    [Dictionary('SGP_SUBGRUPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGP_SUBGRUPO: String read FSGP_SUBGRUPO write FSGP_SUBGRUPO;
    const SGP_SUBGRUPO_Name = 'SGP_SUBGRUPO';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGO', ftString, 2)]
    [Dictionary('CST_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGO: String read FCST_CODIGO write FCST_CODIGO;
    const CST_CODIGO_Name = 'CST_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAB_CODIGO', ftInteger)]
    [Dictionary('FAB_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAB_CODIGO: Integer read FFAB_CODIGO write FFAB_CODIGO;
    const FAB_CODIGO_Name = 'FAB_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAB_NOME', ftString, 100)]
    [Dictionary('FAB_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAB_NOME: String read FFAB_NOME write FFAB_NOME;
    const FAB_NOME_Name = 'FAB_NOME';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_INVP)

end.
