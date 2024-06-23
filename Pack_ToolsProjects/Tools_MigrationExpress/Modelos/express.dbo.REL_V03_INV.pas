unit express.dbo.REL_V03_INV;

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
  [Table('REL_V03_INV', '')]
  TDtoREL_V03_INV = class
  private
    { Private declarations } 
    FINV_ES: String;
    FINV_TIPOMOVTO: String;
    FINV_SIGLA: String;
    FINV_ORDEM: Integer;
    FINV_DATA: TDateTime;
    FINV_NOTAFISCAL: String;
    FFIL_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FPRO_DESCRICAO: String;
    FGRP_CODIGO: Integer;
    FCST_CODIGO: String;
    FINV_QUANTIDADE: Double;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V03_INV';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_ES', ftString, 1)]
    [Dictionary('INV_ES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INV_ES: String read FINV_ES write FINV_ES;
    const INV_ES_Name = 'INV_ES';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_TIPOMOVTO', ftString, 44)]
    [Dictionary('INV_TIPOMOVTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INV_TIPOMOVTO: String read FINV_TIPOMOVTO write FINV_TIPOMOVTO;
    const INV_TIPOMOVTO_Name = 'INV_TIPOMOVTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_SIGLA', ftString, 3)]
    [Dictionary('INV_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INV_SIGLA: String read FINV_SIGLA write FINV_SIGLA;
    const INV_SIGLA_Name = 'INV_SIGLA';

    [Restrictions([NoValidate, NotNull])]
    [Column('INV_ORDEM', ftInteger)]
    [Dictionary('INV_ORDEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property INV_ORDEM: Integer read FINV_ORDEM write FINV_ORDEM;
    const INV_ORDEM_Name = 'INV_ORDEM';

    [Restrictions([NoValidate])]
    [Column('INV_DATA', ftDateTime)]
    [Dictionary('INV_DATA', 'Mensagem de validação', '', '', '', taCenter)]
    property INV_DATA: TDateTime read FINV_DATA write FINV_DATA;
    const INV_DATA_Name = 'INV_DATA';

    [Restrictions([NoValidate])]
    [Column('INV_NOTAFISCAL', ftString, 15)]
    [Dictionary('INV_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property INV_NOTAFISCAL: String read FINV_NOTAFISCAL write FINV_NOTAFISCAL;
    const INV_NOTAFISCAL_Name = 'INV_NOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('FIL_CODIGO', ftInteger)]
    [Dictionary('FIL_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FIL_CODIGO: Integer read FFIL_CODIGO write FFIL_CODIGO;
    const FIL_CODIGO_Name = 'FIL_CODIGO';

    [Restrictions([NoValidate])]
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

    [Restrictions([NoValidate])]
    [Column('INV_QUANTIDADE', ftBCD)]
    [Dictionary('INV_QUANTIDADE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property INV_QUANTIDADE: Double read FINV_QUANTIDADE write FINV_QUANTIDADE;
    const INV_QUANTIDADE_Name = 'INV_QUANTIDADE';

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
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V03_INV)

end.
