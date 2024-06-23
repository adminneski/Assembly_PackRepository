unit express.dbo.REL_V01_NFE;

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
  [Table('REL_V01_NFE', '')]
  TDtoREL_V01_NFE = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FGRP_CODIGO: Integer;
    FGRP_DESCRICAO: String;
    FSGP_CODIGO: Integer;
    FSGP_GRP_CODIGO: Integer;
    FSGP_DESCRICAO: String;
    FFAB_CODIGO: Integer;
    FFAB_NOME: String;
    FNFE_DATA: TDateTime;
    FNFE_QTDENTRADA: Double;
    FNFE_VALORCUSTOCOMPRANFE: Double;
    FNFE_VALORCUSTOINVENTARIONFE: Double;
    FNFE_VALORCUSTOLIQUIDONFE: Double;
    FFAT_QTDFATURADA: Double;
    FFAT_PRECOVENDA: Double;
    FFAT_TOTALPRECOVENDA: Double;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_NFE';

    [Restrictions([NoValidate])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('GRP_CODIGO', ftInteger)]
    [Dictionary('GRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property GRP_CODIGO: Integer read FGRP_CODIGO write FGRP_CODIGO;
    const GRP_CODIGO_Name = 'GRP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('GRP_DESCRICAO', ftString, 50)]
    [Dictionary('GRP_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRP_DESCRICAO: String read FGRP_DESCRICAO write FGRP_DESCRICAO;
    const GRP_DESCRICAO_Name = 'GRP_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('SGP_CODIGO', ftInteger)]
    [Dictionary('SGP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property SGP_CODIGO: Integer read FSGP_CODIGO write FSGP_CODIGO;
    const SGP_CODIGO_Name = 'SGP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('SGP_GRP_CODIGO', ftInteger)]
    [Dictionary('SGP_GRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property SGP_GRP_CODIGO: Integer read FSGP_GRP_CODIGO write FSGP_GRP_CODIGO;
    const SGP_GRP_CODIGO_Name = 'SGP_GRP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('SGP_DESCRICAO', ftString, 50)]
    [Dictionary('SGP_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGP_DESCRICAO: String read FSGP_DESCRICAO write FSGP_DESCRICAO;
    const SGP_DESCRICAO_Name = 'SGP_DESCRICAO';

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

    [Restrictions([NoValidate])]
    [Column('NFE_DATA', ftDateTime)]
    [Dictionary('NFE_DATA', 'Mensagem de validação', '', '', '', taCenter)]
    property NFE_DATA: TDateTime read FNFE_DATA write FNFE_DATA;
    const NFE_DATA_Name = 'NFE_DATA';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_QTDENTRADA', ftBCD, 18, 4)]
    [Dictionary('NFE_QTDENTRADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_QTDENTRADA: Double read FNFE_QTDENTRADA write FNFE_QTDENTRADA;
    const NFE_QTDENTRADA_Name = 'NFE_QTDENTRADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORCUSTOCOMPRANFE', ftBCD)]
    [Dictionary('NFE_VALORCUSTOCOMPRANFE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORCUSTOCOMPRANFE: Double read FNFE_VALORCUSTOCOMPRANFE write FNFE_VALORCUSTOCOMPRANFE;
    const NFE_VALORCUSTOCOMPRANFE_Name = 'NFE_VALORCUSTOCOMPRANFE';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORCUSTOINVENTARIONFE', ftBCD)]
    [Dictionary('NFE_VALORCUSTOINVENTARIONFE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORCUSTOINVENTARIONFE: Double read FNFE_VALORCUSTOINVENTARIONFE write FNFE_VALORCUSTOINVENTARIONFE;
    const NFE_VALORCUSTOINVENTARIONFE_Name = 'NFE_VALORCUSTOINVENTARIONFE';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_VALORCUSTOLIQUIDONFE', ftBCD)]
    [Dictionary('NFE_VALORCUSTOLIQUIDONFE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORCUSTOLIQUIDONFE: Double read FNFE_VALORCUSTOLIQUIDONFE write FNFE_VALORCUSTOLIQUIDONFE;
    const NFE_VALORCUSTOLIQUIDONFE_Name = 'NFE_VALORCUSTOLIQUIDONFE';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_QTDFATURADA', ftBCD, 18, 4)]
    [Dictionary('FAT_QTDFATURADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_QTDFATURADA: Double read FFAT_QTDFATURADA write FFAT_QTDFATURADA;
    const FAT_QTDFATURADA_Name = 'FAT_QTDFATURADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PRECOVENDA', ftBCD, 66260064, 10)]
    [Dictionary('FAT_PRECOVENDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PRECOVENDA: Double read FFAT_PRECOVENDA write FFAT_PRECOVENDA;
    const FAT_PRECOVENDA_Name = 'FAT_PRECOVENDA';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPRECOVENDA', ftBCD)]
    [Dictionary('FAT_TOTALPRECOVENDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPRECOVENDA: Double read FFAT_TOTALPRECOVENDA write FFAT_TOTALPRECOVENDA;
    const FAT_TOTALPRECOVENDA_Name = 'FAT_TOTALPRECOVENDA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_NFE)

end.
