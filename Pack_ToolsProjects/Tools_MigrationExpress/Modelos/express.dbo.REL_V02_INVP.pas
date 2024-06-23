unit express.dbo.REL_V02_INVP;

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
  [Table('REL_V02_INVP', '')]
  TDtoREL_V02_INVP = class
  private
    { Private declarations } 
    FINVP_ES: String;
    FINVP_TIPOMOVTO: String;
    FINVP_SIGLA: String;
    FINVP_SIGLA2: String;
    FINVP_ORDEM: Integer;
    FINVP_DATA: TDateTime;
    FINVP_MES: Integer;
    FINVP_ANO: Integer;
    FINVP_MES_ANO: String;
    FINVP_SERIE: String;
    FINVP_NOTAFISCAL: String;
    FINVP_NUMERODOCTO: String;
    FINVP_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FPRO_CODIGO: Integer;
    FPRO_DESCRICAO: String;
    FGRP_CODIGO: Integer;
    FCST_CODIGO: String;
    FINVP_QUANTIDADE: Double;
    FINVP_VALORCUSTOARMAZENAGEM: Double;
  public 
    { Public declarations } 
     const Table      = 'REL_V02_INVP';

    [Restrictions([NoValidate, NotNull])]
    [Column('INVP_ES', ftString, 1)]
    [Dictionary('INVP_ES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INVP_ES: String read FINVP_ES write FINVP_ES;
    const INVP_ES_Name = 'INVP_ES';

    [Restrictions([NoValidate, NotNull])]
    [Column('INVP_TIPOMOVTO', ftString, 25)]
    [Dictionary('INVP_TIPOMOVTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INVP_TIPOMOVTO: String read FINVP_TIPOMOVTO write FINVP_TIPOMOVTO;
    const INVP_TIPOMOVTO_Name = 'INVP_TIPOMOVTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INVP_SIGLA', ftString, 3)]
    [Dictionary('INVP_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INVP_SIGLA: String read FINVP_SIGLA write FINVP_SIGLA;
    const INVP_SIGLA_Name = 'INVP_SIGLA';

    [Restrictions([NoValidate, NotNull])]
    [Column('INVP_SIGLA2', ftString, 2)]
    [Dictionary('INVP_SIGLA2', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INVP_SIGLA2: String read FINVP_SIGLA2 write FINVP_SIGLA2;
    const INVP_SIGLA2_Name = 'INVP_SIGLA2';

    [Restrictions([NoValidate, NotNull])]
    [Column('INVP_ORDEM', ftInteger)]
    [Dictionary('INVP_ORDEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property INVP_ORDEM: Integer read FINVP_ORDEM write FINVP_ORDEM;
    const INVP_ORDEM_Name = 'INVP_ORDEM';

    [Restrictions([NoValidate])]
    [Column('INVP_DATA', ftDateTime)]
    [Dictionary('INVP_DATA', 'Mensagem de validação', '', '', '', taCenter)]
    property INVP_DATA: TDateTime read FINVP_DATA write FINVP_DATA;
    const INVP_DATA_Name = 'INVP_DATA';

    [Restrictions([NoValidate])]
    [Column('INVP_MES', ftInteger)]
    [Dictionary('INVP_MES', 'Mensagem de validação', '0', '', '', taCenter)]
    property INVP_MES: Integer read FINVP_MES write FINVP_MES;
    const INVP_MES_Name = 'INVP_MES';

    [Restrictions([NoValidate])]
    [Column('INVP_ANO', ftInteger)]
    [Dictionary('INVP_ANO', 'Mensagem de validação', '0', '', '', taCenter)]
    property INVP_ANO: Integer read FINVP_ANO write FINVP_ANO;
    const INVP_ANO_Name = 'INVP_ANO';

    [Restrictions([NoValidate])]
    [Column('INVP_MES_ANO', ftString, 60)]
    [Dictionary('INVP_MES_ANO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INVP_MES_ANO: String read FINVP_MES_ANO write FINVP_MES_ANO;
    const INVP_MES_ANO_Name = 'INVP_MES_ANO';

    [Restrictions([NoValidate])]
    [Column('INVP_SERIE', ftString, 3)]
    [Dictionary('INVP_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INVP_SERIE: String read FINVP_SERIE write FINVP_SERIE;
    const INVP_SERIE_Name = 'INVP_SERIE';

    [Restrictions([NoValidate])]
    [Column('INVP_NOTAFISCAL', ftString, 9)]
    [Dictionary('INVP_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INVP_NOTAFISCAL: String read FINVP_NOTAFISCAL write FINVP_NOTAFISCAL;
    const INVP_NOTAFISCAL_Name = 'INVP_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('INVP_NUMERODOCTO', ftString, 9)]
    [Dictionary('INVP_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INVP_NUMERODOCTO: String read FINVP_NUMERODOCTO write FINVP_NUMERODOCTO;
    const INVP_NUMERODOCTO_Name = 'INVP_NUMERODOCTO';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

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
    [Column('GRP_CODIGO', ftInteger)]
    [Dictionary('GRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property GRP_CODIGO: Integer read FGRP_CODIGO write FGRP_CODIGO;
    const GRP_CODIGO_Name = 'GRP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGO', ftString, 2)]
    [Dictionary('CST_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGO: String read FCST_CODIGO write FCST_CODIGO;
    const CST_CODIGO_Name = 'CST_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INVP_QUANTIDADE', ftBCD, 18, 4)]
    [Dictionary('INVP_QUANTIDADE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INVP_QUANTIDADE: Double read FINVP_QUANTIDADE write FINVP_QUANTIDADE;
    const INVP_QUANTIDADE_Name = 'INVP_QUANTIDADE';

    [Restrictions([NoValidate, NotNull])]
    [Column('INVP_VALORCUSTOARMAZENAGEM', ftBCD, 48, 5)]
    [Dictionary('INVP_VALORCUSTOARMAZENAGEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INVP_VALORCUSTOARMAZENAGEM: Double read FINVP_VALORCUSTOARMAZENAGEM write FINVP_VALORCUSTOARMAZENAGEM;
    const INVP_VALORCUSTOARMAZENAGEM_Name = 'INVP_VALORCUSTOARMAZENAGEM';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V02_INVP)

end.
