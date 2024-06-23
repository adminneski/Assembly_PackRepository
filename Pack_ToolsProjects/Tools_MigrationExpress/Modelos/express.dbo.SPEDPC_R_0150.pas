unit express.dbo.SPEDPC_R_0150;

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
  [Table('SPEDPC_R_0150', '')]
  TDtoSPEDPC_R_0150 = class
  private
    { Private declarations } 
    FTIPO: String;
    FNUM_DOC: String;
    FDT_DOC: TDateTime;
    FCOM_CODIGO: Integer;
    FCOD_PART: Integer;
    FNOME: String;
    FCOD_PAIS: String;
    FCNPJ: String;
    FCPF: String;
    FIE: String;
    FCOD_MUN: String;
    FSUFRAMA: String;
    FENDE: String;
    FNUM: String;
    FCOMPL: String;
    FBAIRRO: String;
  public 
    { Public declarations } 
     const Table      = 'SPEDPC_R_0150';

    [Restrictions([NoValidate, NotNull])]
    [Column('TIPO', ftString, 3)]
    [Dictionary('TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TIPO: String read FTIPO write FTIPO;
    const TIPO_Name = 'TIPO';

    [Restrictions([NoValidate])]
    [Column('NUM_DOC', ftString, 9)]
    [Dictionary('NUM_DOC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NUM_DOC: String read FNUM_DOC write FNUM_DOC;
    const NUM_DOC_Name = 'NUM_DOC';

    [Restrictions([NoValidate])]
    [Column('DT_DOC', ftDateTime)]
    [Dictionary('DT_DOC', 'Mensagem de validação', '', '', '', taCenter)]
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    const DT_DOC_Name = 'DT_DOC';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('COD_PART', ftInteger)]
    [Dictionary('COD_PART', 'Mensagem de validação', '0', '', '', taCenter)]
    property COD_PART: Integer read FCOD_PART write FCOD_PART;
    const COD_PART_Name = 'COD_PART';

    [Restrictions([NoValidate])]
    [Column('NOME', ftString, 100)]
    [Dictionary('NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NOME: String read FNOME write FNOME;
    const NOME_Name = 'NOME';

    [Restrictions([NoValidate])]
    [Column('COD_PAIS', ftString, 4)]
    [Dictionary('COD_PAIS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_PAIS: String read FCOD_PAIS write FCOD_PAIS;
    const COD_PAIS_Name = 'COD_PAIS';

    [Restrictions([NoValidate])]
    [Column('CNPJ', ftString, 14)]
    [Dictionary('CNPJ', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CNPJ: String read FCNPJ write FCNPJ;
    const CNPJ_Name = 'CNPJ';

    [Restrictions([NoValidate])]
    [Column('CPF', ftString, 14)]
    [Dictionary('CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPF: String read FCPF write FCPF;
    const CPF_Name = 'CPF';

    [Restrictions([NoValidate])]
    [Column('IE', ftString, 16)]
    [Dictionary('IE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property IE: String read FIE write FIE;
    const IE_Name = 'IE';

    [Restrictions([NoValidate, NotNull])]
    [Column('COD_MUN', ftString, 7)]
    [Dictionary('COD_MUN', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_MUN: String read FCOD_MUN write FCOD_MUN;
    const COD_MUN_Name = 'COD_MUN';

    [Restrictions([NoValidate, NotNull])]
    [Column('SUFRAMA', ftString, 1)]
    [Dictionary('SUFRAMA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SUFRAMA: String read FSUFRAMA write FSUFRAMA;
    const SUFRAMA_Name = 'SUFRAMA';

    [Restrictions([NoValidate])]
    [Column('ENDE', ftString, 100)]
    [Dictionary('ENDE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ENDE: String read FENDE write FENDE;
    const ENDE_Name = 'ENDE';

    [Restrictions([NoValidate])]
    [Column('NUM', ftString, 5)]
    [Dictionary('NUM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NUM: String read FNUM write FNUM;
    const NUM_Name = 'NUM';

    [Restrictions([NoValidate])]
    [Column('COMPL', ftString, 500)]
    [Dictionary('COMPL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COMPL: String read FCOMPL write FCOMPL;
    const COMPL_Name = 'COMPL';

    [Restrictions([NoValidate])]
    [Column('BAIRRO', ftString, 50)]
    [Dictionary('BAIRRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BAIRRO: String read FBAIRRO write FBAIRRO;
    const BAIRRO_Name = 'BAIRRO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPEDPC_R_0150)

end.
