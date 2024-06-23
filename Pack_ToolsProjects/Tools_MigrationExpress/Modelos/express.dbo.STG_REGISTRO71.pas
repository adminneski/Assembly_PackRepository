unit express.dbo.STG_REGISTRO71;

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
  [Table('STG_REGISTRO71', '')]
  TDtoSTG_REGISTRO71 = class
  private
    { Private declarations } 
    FSTG_TIPO: String;
    FSTG_ID: Integer;
    FCOM_CODIGO: Integer;
    FSTG_NOTAFISCAL: String;
    FPES_CNPJ: String;
    FPES_IE: String;
    FPES_UF: String;
    FSTG_DATAEMISSAO: TDateTime;
    FMNF_CODIGO: String;
    FSTG_SERIE: String;
    FSTG_NOTAFISCALCTR: String;
    FSTG_VALORNF: Double;
  public 
    { Public declarations } 
     const Table      = 'STG_REGISTRO71';

    [Restrictions([NoValidate, NotNull])]
    [Column('STG_TIPO', ftString, 3)]
    [Dictionary('STG_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property STG_TIPO: String read FSTG_TIPO write FSTG_TIPO;
    const STG_TIPO_Name = 'STG_TIPO';

    [Restrictions([NoValidate, NotNull])]
    [Column('STG_ID', ftInteger)]
    [Dictionary('STG_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property STG_ID: Integer read FSTG_ID write FSTG_ID;
    const STG_ID_Name = 'STG_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('STG_NOTAFISCAL', ftString, 9)]
    [Dictionary('STG_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property STG_NOTAFISCAL: String read FSTG_NOTAFISCAL write FSTG_NOTAFISCAL;
    const STG_NOTAFISCAL_Name = 'STG_NOTAFISCAL';

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
    [Column('STG_DATAEMISSAO', ftDateTime)]
    [Dictionary('STG_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property STG_DATAEMISSAO: TDateTime read FSTG_DATAEMISSAO write FSTG_DATAEMISSAO;
    const STG_DATAEMISSAO_Name = 'STG_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('STG_SERIE', ftString, 3)]
    [Dictionary('STG_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property STG_SERIE: String read FSTG_SERIE write FSTG_SERIE;
    const STG_SERIE_Name = 'STG_SERIE';

    [Restrictions([NoValidate])]
    [Column('STG_NOTAFISCALCTR', ftString, 9)]
    [Dictionary('STG_NOTAFISCALCTR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property STG_NOTAFISCALCTR: String read FSTG_NOTAFISCALCTR write FSTG_NOTAFISCALCTR;
    const STG_NOTAFISCALCTR_Name = 'STG_NOTAFISCALCTR';

    [Restrictions([NoValidate, NotNull])]
    [Column('STG_VALORNF', ftBCD)]
    [Dictionary('STG_VALORNF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_VALORNF: Double read FSTG_VALORNF write FSTG_VALORNF;
    const STG_VALORNF_Name = 'STG_VALORNF';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSTG_REGISTRO71)

end.
