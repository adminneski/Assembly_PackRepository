unit express.dbo.CMP_LISTAPRODUTOS;

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
  [Table('CMP_ListaProdutos', '')]
  TDtoCMP_ListaProdutos = class
  private
    { Private declarations } 
    FCMP_ID: Integer;
    FCMP_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FSGM_CODIGO: String;
    FCFOP_CODIGO: String;
    FCST_CODIGO: String;
    FCMP_QTDPEDIDA: Currency;
    FCMP_VALORITEM: Double;
    FPRO_DESCRICAO: String;
    FPRO_EMBALAGEM: String;
    FPRO_REFERENCIAINTERNA: String;
    FPRO_DESCRICAOADICIONAL: String;
  public 
    { Public declarations } 
     const Table      = 'CMP_ListaProdutos';

    [Restrictions([NoValidate, NotNull])]
    [Column('CMP_ID', ftInteger)]
    [Dictionary('CMP_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CMP_ID: Integer read FCMP_ID write FCMP_ID;
    const CMP_ID_Name = 'CMP_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CMP_01_ID', ftInteger)]
    [Dictionary('CMP_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CMP_01_ID: Integer read FCMP_01_ID write FCMP_01_ID;
    const CMP_01_ID_Name = 'CMP_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('SGM_CODIGO', ftString, 2)]
    [Dictionary('SGM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_CODIGO: String read FSGM_CODIGO write FSGM_CODIGO;
    const SGM_CODIGO_Name = 'SGM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGO', ftString, 2)]
    [Dictionary('CST_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGO: String read FCST_CODIGO write FCST_CODIGO;
    const CST_CODIGO_Name = 'CST_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CMP_QTDPEDIDA', ftCurrency)]
    [Dictionary('CMP_QTDPEDIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_QTDPEDIDA: Currency read FCMP_QTDPEDIDA write FCMP_QTDPEDIDA;
    const CMP_QTDPEDIDA_Name = 'CMP_QTDPEDIDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CMP_VALORITEM', ftBCD, 18, 4)]
    [Dictionary('CMP_VALORITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CMP_VALORITEM: Double read FCMP_VALORITEM write FCMP_VALORITEM;
    const CMP_VALORITEM_Name = 'CMP_VALORITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('PRO_EMBALAGEM', ftString, 15)]
    [Dictionary('PRO_EMBALAGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_EMBALAGEM: String read FPRO_EMBALAGEM write FPRO_EMBALAGEM;
    const PRO_EMBALAGEM_Name = 'PRO_EMBALAGEM';

    [Restrictions([NoValidate])]
    [Column('PRO_REFERENCIAINTERNA', ftString, 20)]
    [Dictionary('PRO_REFERENCIAINTERNA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_REFERENCIAINTERNA: String read FPRO_REFERENCIAINTERNA write FPRO_REFERENCIAINTERNA;
    const PRO_REFERENCIAINTERNA_Name = 'PRO_REFERENCIAINTERNA';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAOADICIONAL', ftString, 300)]
    [Dictionary('PRO_DESCRICAOADICIONAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAOADICIONAL: String read FPRO_DESCRICAOADICIONAL write FPRO_DESCRICAOADICIONAL;
    const PRO_DESCRICAOADICIONAL_Name = 'PRO_DESCRICAOADICIONAL';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCMP_ListaProdutos)

end.
