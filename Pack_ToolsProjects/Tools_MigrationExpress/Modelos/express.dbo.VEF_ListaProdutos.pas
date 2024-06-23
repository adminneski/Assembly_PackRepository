unit express.dbo.VEF_LISTAPRODUTOS;

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
  [Table('VEF_ListaProdutos', '')]
  TDtoVEF_ListaProdutos = class
  private
    { Private declarations } 
    FVEF_ID: Integer;
    FVEF_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FPRO_DESCRICAO: String;
    FPRO_EMBALAGEM: String;
    FSGM_CODIGO: String;
    FGRD_CODIGO: String;
    FVEF_QTDPEDIDA: Double;
    FVEF_QTDFATURADA: Double;
    FVEF_TOTALPRECOLIQUIDO: Double;
  public 
    { Public declarations } 
     const Table      = 'VEF_ListaProdutos';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_ID', ftInteger)]
    [Dictionary('VEF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEF_ID: Integer read FVEF_ID write FVEF_ID;
    const VEF_ID_Name = 'VEF_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_01_ID', ftInteger)]
    [Dictionary('VEF_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEF_01_ID: Integer read FVEF_01_ID write FVEF_01_ID;
    const VEF_01_ID_Name = 'VEF_01_ID';

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
    [Column('SGM_CODIGO', ftString, 2)]
    [Dictionary('SGM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_CODIGO: String read FSGM_CODIGO write FSGM_CODIGO;
    const SGM_CODIGO_Name = 'SGM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('GRD_CODIGO', ftString, 6)]
    [Dictionary('GRD_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRD_CODIGO: String read FGRD_CODIGO write FGRD_CODIGO;
    const GRD_CODIGO_Name = 'GRD_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_QTDPEDIDA', ftBCD, 18, 4)]
    [Dictionary('VEF_QTDPEDIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_QTDPEDIDA: Double read FVEF_QTDPEDIDA write FVEF_QTDPEDIDA;
    const VEF_QTDPEDIDA_Name = 'VEF_QTDPEDIDA';

    [Restrictions([NoValidate])]
    [Column('VEF_QTDFATURADA', ftBCD)]
    [Dictionary('VEF_QTDFATURADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_QTDFATURADA: Double read FVEF_QTDFATURADA write FVEF_QTDFATURADA;
    const VEF_QTDFATURADA_Name = 'VEF_QTDFATURADA';

    [Restrictions([NoValidate])]
    [Column('VEF_TOTALPRECOLIQUIDO', ftBCD)]
    [Dictionary('VEF_TOTALPRECOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_TOTALPRECOLIQUIDO: Double read FVEF_TOTALPRECOLIQUIDO write FVEF_TOTALPRECOLIQUIDO;
    const VEF_TOTALPRECOLIQUIDO_Name = 'VEF_TOTALPRECOLIQUIDO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVEF_ListaProdutos)

end.
