unit express.dbo.REL_V02_CTR;

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
  [Table('REL_V02_CTR', '')]
  TDtoREL_V02_CTR = class
  private
    { Private declarations } 
    FCTR_ID: Integer;
    FCOM_CODIGO: Integer;
    FCTR_DATAEMISSAO: TDateTime;
    FCTR_TOTALPRESTACAO: Double;
    FCTR_TOTALICMS: Double;
    FTRP_CODIGO: Integer;
    FMFC_NUMERODOCTO: String;
    FCRB_TOTALFRETE: Double;
    FCRB_TOTALADIANTAMENTO: Double;
  public 
    { Public declarations } 
     const Table      = 'REL_V02_CTR';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_ID', ftInteger)]
    [Dictionary('CTR_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_ID: Integer read FCTR_ID write FCTR_ID;
    const CTR_ID_Name = 'CTR_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_DATAEMISSAO', ftDateTime)]
    [Dictionary('CTR_DATAEMISSAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CTR_DATAEMISSAO: TDateTime read FCTR_DATAEMISSAO write FCTR_DATAEMISSAO;
    const CTR_DATAEMISSAO_Name = 'CTR_DATAEMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TOTALPRESTACAO', ftBCD)]
    [Dictionary('CTR_TOTALPRESTACAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALPRESTACAO: Double read FCTR_TOTALPRESTACAO write FCTR_TOTALPRESTACAO;
    const CTR_TOTALPRESTACAO_Name = 'CTR_TOTALPRESTACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TOTALICMS', ftBCD)]
    [Dictionary('CTR_TOTALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALICMS: Double read FCTR_TOTALICMS write FCTR_TOTALICMS;
    const CTR_TOTALICMS_Name = 'CTR_TOTALICMS';

    [Restrictions([NoValidate])]
    [Column('TRP_CODIGO', ftInteger)]
    [Dictionary('TRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TRP_CODIGO: Integer read FTRP_CODIGO write FTRP_CODIGO;
    const TRP_CODIGO_Name = 'TRP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('MFC_NUMERODOCTO', ftString, 6)]
    [Dictionary('MFC_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_NUMERODOCTO: String read FMFC_NUMERODOCTO write FMFC_NUMERODOCTO;
    const MFC_NUMERODOCTO_Name = 'MFC_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('CRB_TOTALFRETE', ftBCD, 66260064, 2)]
    [Dictionary('CRB_TOTALFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRB_TOTALFRETE: Double read FCRB_TOTALFRETE write FCRB_TOTALFRETE;
    const CRB_TOTALFRETE_Name = 'CRB_TOTALFRETE';

    [Restrictions([NoValidate])]
    [Column('CRB_TOTALADIANTAMENTO', ftBCD)]
    [Dictionary('CRB_TOTALADIANTAMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRB_TOTALADIANTAMENTO: Double read FCRB_TOTALADIANTAMENTO write FCRB_TOTALADIANTAMENTO;
    const CRB_TOTALADIANTAMENTO_Name = 'CRB_TOTALADIANTAMENTO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V02_CTR)

end.
