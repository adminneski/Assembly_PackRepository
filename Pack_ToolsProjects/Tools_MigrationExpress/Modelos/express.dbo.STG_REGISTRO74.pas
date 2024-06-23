unit express.dbo.STG_REGISTRO74;

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
  [Table('STG_REGISTRO74', '')]
  TDtoSTG_REGISTRO74 = class
  private
    { Private declarations } 
    FSTG_ANO: Integer;
    FSTG_MES: Integer;
    FSTG_DATAFECHAMENTO: TDateTime;
    FPRO_CODIGO: Integer;
    FSTG_SALDOFECHAMENTO: Double;
    FSTG_VALORCUSTOINVENTARIO: Double;
    FSTG_TIPOPOSSE: Integer;
    FCOM_CODIGO: Integer;
    FCOM_UF: String;
    FCOM_CNPJ_CPF: String;
    FCOM_CNPJ: String;
    FCOM_IE_RG: String;
  public 
    { Public declarations } 
     const Table      = 'STG_REGISTRO74';

    [Restrictions([NoValidate])]
    [Column('STG_ANO', ftInteger)]
    [Dictionary('STG_ANO', 'Mensagem de validação', '0', '', '', taCenter)]
    property STG_ANO: Integer read FSTG_ANO write FSTG_ANO;
    const STG_ANO_Name = 'STG_ANO';

    [Restrictions([NoValidate])]
    [Column('STG_MES', ftInteger)]
    [Dictionary('STG_MES', 'Mensagem de validação', '0', '', '', taCenter)]
    property STG_MES: Integer read FSTG_MES write FSTG_MES;
    const STG_MES_Name = 'STG_MES';

    [Restrictions([NoValidate, NotNull])]
    [Column('STG_DATAFECHAMENTO', ftDateTime)]
    [Dictionary('STG_DATAFECHAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property STG_DATAFECHAMENTO: TDateTime read FSTG_DATAFECHAMENTO write FSTG_DATAFECHAMENTO;
    const STG_DATAFECHAMENTO_Name = 'STG_DATAFECHAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('STG_SALDOFECHAMENTO', ftBCD, 18, 4)]
    [Dictionary('STG_SALDOFECHAMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_SALDOFECHAMENTO: Double read FSTG_SALDOFECHAMENTO write FSTG_SALDOFECHAMENTO;
    const STG_SALDOFECHAMENTO_Name = 'STG_SALDOFECHAMENTO';

    [Restrictions([NoValidate])]
    [Column('STG_VALORCUSTOINVENTARIO', ftBCD, 48, 8)]
    [Dictionary('STG_VALORCUSTOINVENTARIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_VALORCUSTOINVENTARIO: Double read FSTG_VALORCUSTOINVENTARIO write FSTG_VALORCUSTOINVENTARIO;
    const STG_VALORCUSTOINVENTARIO_Name = 'STG_VALORCUSTOINVENTARIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('STG_TIPOPOSSE', ftInteger)]
    [Dictionary('STG_TIPOPOSSE', 'Mensagem de validação', '0', '', '', taCenter)]
    property STG_TIPOPOSSE: Integer read FSTG_TIPOPOSSE write FSTG_TIPOPOSSE;
    const STG_TIPOPOSSE_Name = 'STG_TIPOPOSSE';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('COM_UF', ftString, 2)]
    [Dictionary('COM_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_UF: String read FCOM_UF write FCOM_UF;
    const COM_UF_Name = 'COM_UF';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CNPJ_CPF', ftString, 14)]
    [Dictionary('COM_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CNPJ_CPF: String read FCOM_CNPJ_CPF write FCOM_CNPJ_CPF;
    const COM_CNPJ_CPF_Name = 'COM_CNPJ_CPF';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CNPJ', ftString, 14)]
    [Dictionary('COM_CNPJ', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CNPJ: String read FCOM_CNPJ write FCOM_CNPJ;
    const COM_CNPJ_Name = 'COM_CNPJ';

    [Restrictions([NoValidate])]
    [Column('COM_IE_RG', ftString, 16)]
    [Dictionary('COM_IE_RG', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_IE_RG: String read FCOM_IE_RG write FCOM_IE_RG;
    const COM_IE_RG_Name = 'COM_IE_RG';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSTG_REGISTRO74)

end.
