unit express.dbo.STG_REGISTRO55;

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
  [Table('STG_REGISTRO55', '')]
  TDtoSTG_REGISTRO55 = class
  private
    { Private declarations } 
    FGNRE_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FPES_CNPJ: String;
    FPES_IE: String;
    FPES_UF: String;
    FGNRE_TOTALVALOR: Double;
    FGNRE_BANCO: String;
    FGNRE_AGENCIA: String;
    FGNRE_PERIODO: String;
    FGNRE_DATAEMISSAO: TDateTime;
    FGNRE_DATAVENCTO: TDateTime;
    FGNRE_OBSERVACAO: String;
    FGNRE_NUMERODOCTO: String;
    FGNRE_NUMEROCONVENIO: String;
    FGNRE_MES: String;
    FGNRE_ANO: String;
  public 
    { Public declarations } 
     const Table      = 'STG_REGISTRO55';

    [Restrictions([NoValidate, NotNull])]
    [Column('GNRE_ID', ftInteger)]
    [Dictionary('GNRE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property GNRE_ID: Integer read FGNRE_ID write FGNRE_ID;
    const GNRE_ID_Name = 'GNRE_ID';

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
    [Column('PES_CNPJ', ftString, 14)]
    [Dictionary('PES_CNPJ', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ: String read FPES_CNPJ write FPES_CNPJ;
    const PES_CNPJ_Name = 'PES_CNPJ';

    [Restrictions([NoValidate])]
    [Column('PES_IE', ftString, 16)]
    [Dictionary('PES_IE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE: String read FPES_IE write FPES_IE;
    const PES_IE_Name = 'PES_IE';

    [Restrictions([NoValidate])]
    [Column('PES_UF', ftString, 2)]
    [Dictionary('PES_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF: String read FPES_UF write FPES_UF;
    const PES_UF_Name = 'PES_UF';

    [Restrictions([NoValidate])]
    [Column('GNRE_TOTALVALOR', ftBCD, 48, 2)]
    [Dictionary('GNRE_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property GNRE_TOTALVALOR: Double read FGNRE_TOTALVALOR write FGNRE_TOTALVALOR;
    const GNRE_TOTALVALOR_Name = 'GNRE_TOTALVALOR';

    [Restrictions([NoValidate])]
    [Column('GNRE_BANCO', ftString, 3)]
    [Dictionary('GNRE_BANCO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GNRE_BANCO: String read FGNRE_BANCO write FGNRE_BANCO;
    const GNRE_BANCO_Name = 'GNRE_BANCO';

    [Restrictions([NoValidate])]
    [Column('GNRE_AGENCIA', ftString, 6)]
    [Dictionary('GNRE_AGENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GNRE_AGENCIA: String read FGNRE_AGENCIA write FGNRE_AGENCIA;
    const GNRE_AGENCIA_Name = 'GNRE_AGENCIA';

    [Restrictions([NoValidate])]
    [Column('GNRE_PERIODO', ftString, 6)]
    [Dictionary('GNRE_PERIODO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GNRE_PERIODO: String read FGNRE_PERIODO write FGNRE_PERIODO;
    const GNRE_PERIODO_Name = 'GNRE_PERIODO';

    [Restrictions([NoValidate])]
    [Column('GNRE_DATAEMISSAO', ftDateTime)]
    [Dictionary('GNRE_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property GNRE_DATAEMISSAO: TDateTime read FGNRE_DATAEMISSAO write FGNRE_DATAEMISSAO;
    const GNRE_DATAEMISSAO_Name = 'GNRE_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('GNRE_DATAVENCTO', ftDateTime)]
    [Dictionary('GNRE_DATAVENCTO', 'Mensagem de validação', '', '', '', taCenter)]
    property GNRE_DATAVENCTO: TDateTime read FGNRE_DATAVENCTO write FGNRE_DATAVENCTO;
    const GNRE_DATAVENCTO_Name = 'GNRE_DATAVENCTO';

    [Restrictions([NoValidate])]
    [Column('GNRE_OBSERVACAO', ftString, 300)]
    [Dictionary('GNRE_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GNRE_OBSERVACAO: String read FGNRE_OBSERVACAO write FGNRE_OBSERVACAO;
    const GNRE_OBSERVACAO_Name = 'GNRE_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('GNRE_NUMERODOCTO', ftString, 20)]
    [Dictionary('GNRE_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GNRE_NUMERODOCTO: String read FGNRE_NUMERODOCTO write FGNRE_NUMERODOCTO;
    const GNRE_NUMERODOCTO_Name = 'GNRE_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('GNRE_NUMEROCONVENIO', ftString, 30)]
    [Dictionary('GNRE_NUMEROCONVENIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GNRE_NUMEROCONVENIO: String read FGNRE_NUMEROCONVENIO write FGNRE_NUMEROCONVENIO;
    const GNRE_NUMEROCONVENIO_Name = 'GNRE_NUMEROCONVENIO';

    [Restrictions([NoValidate])]
    [Column('GNRE_MES', ftString, 2)]
    [Dictionary('GNRE_MES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GNRE_MES: String read FGNRE_MES write FGNRE_MES;
    const GNRE_MES_Name = 'GNRE_MES';

    [Restrictions([NoValidate])]
    [Column('GNRE_ANO', ftString, 4)]
    [Dictionary('GNRE_ANO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GNRE_ANO: String read FGNRE_ANO write FGNRE_ANO;
    const GNRE_ANO_Name = 'GNRE_ANO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSTG_REGISTRO55)

end.
