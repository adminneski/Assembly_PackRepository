unit express.dbo.SPEDPC_R_0100;

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
  [Table('SPEDPC_R_0100', '')]
  TDtoSPEDPC_R_0100 = class
  private
    { Private declarations } 
    FNOME: String;
    FCPF: String;
    FCRC: String;
    FCNPJ: String;
    FCEP: String;
    FENDE: String;
    FNUM: String;
    FCOMPL: String;
    FBAIRRO: String;
    FFONE: String;
    FFAX: String;
    FEMAIL: String;
    FCOD_MUN: String;
  public 
    { Public declarations } 
     const Table      = 'SPEDPC_R_0100';

    [Restrictions([NoValidate, NotNull])]
    [Column('NOME', ftString, 100)]
    [Dictionary('NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NOME: String read FNOME write FNOME;
    const NOME_Name = 'NOME';

    [Restrictions([NoValidate])]
    [Column('CPF', ftString, 14)]
    [Dictionary('CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPF: String read FCPF write FCPF;
    const CPF_Name = 'CPF';

    [Restrictions([NoValidate])]
    [Column('CRC', ftString, 20)]
    [Dictionary('CRC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRC: String read FCRC write FCRC;
    const CRC_Name = 'CRC';

    [Restrictions([NoValidate])]
    [Column('CNPJ', ftString, 14)]
    [Dictionary('CNPJ', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CNPJ: String read FCNPJ write FCNPJ;
    const CNPJ_Name = 'CNPJ';

    [Restrictions([NoValidate])]
    [Column('CEP', ftString, 8)]
    [Dictionary('CEP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEP: String read FCEP write FCEP;
    const CEP_Name = 'CEP';

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

    [Restrictions([NoValidate])]
    [Column('FONE', ftString, 11)]
    [Dictionary('FONE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FONE: String read FFONE write FFONE;
    const FONE_Name = 'FONE';

    [Restrictions([NoValidate])]
    [Column('FAX', ftString, 11)]
    [Dictionary('FAX', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAX: String read FFAX write FFAX;
    const FAX_Name = 'FAX';

    [Restrictions([NoValidate])]
    [Column('EMAIL', ftString, 300)]
    [Dictionary('EMAIL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property EMAIL: String read FEMAIL write FEMAIL;
    const EMAIL_Name = 'EMAIL';

    [Restrictions([NoValidate])]
    [Column('COD_MUN', ftString, 7)]
    [Dictionary('COD_MUN', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_MUN: String read FCOD_MUN write FCOD_MUN;
    const COD_MUN_Name = 'COD_MUN';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPEDPC_R_0100)

end.
