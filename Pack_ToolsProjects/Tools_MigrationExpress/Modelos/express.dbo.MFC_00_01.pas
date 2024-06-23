unit express.dbo.MFC_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.mfc_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('MFC_00_01', '')]
  [PrimaryKey('MFC_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_MFC_01_ID')]
  TDtoMFC_00_01 = class
  private
    { Private declarations } 
    FMFC_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FMFC_ID: Integer;
    FCTR_ID: Integer;
    FMNF_CODIGO: String;
    FMFC_ORDEMITEM: Integer;
    FCTR_NOTAFISCAL: String;
    FCTR_NUMERODOCTO: String;
    FMFC_TIPOFRETE: String;
    FMFC_PESOBRUTO: Double;
    FMFC_VALORFRETE: Double;
    FMFC_VALORNOTAFISCAL: Double;
    FMFC_CODIGORASTREAMENTO: String;
    FMFC_DATAALTERACAO: TDateTime;
    FMFC_01_ID_OLD: Integer;
    FMFC_ID_OLD: Integer;
    FCTR_ID_OLD: Integer;
    FMFC_DESTINOFINAL: String;
  public
    { Public declarations }
    const Table      = 'MFC_00_01';
    const PrimaryKey = 'MFC_01_ID';
    const Sequence   = 'SEQ_MFC_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_01_ID', ftInteger)]
    [Dictionary('MFC_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_01_ID: Integer read FMFC_01_ID write FMFC_01_ID;
    const MFC_01_ID_Name = 'MFC_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_ID', ftInteger)]
    [ForeignKey('MFC_00_01_fk', 'MFC_ID', 'MFC_00', 'MFC_ID', SetNull, SetNull)]
    [Dictionary('MFC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_ID: Integer read FMFC_ID write FMFC_ID;
    const MFC_ID_Name = 'MFC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_ID', ftInteger)]
    [Dictionary('CTR_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_ID: Integer read FCTR_ID write FCTR_ID;
    const CTR_ID_Name = 'CTR_ID';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_ORDEMITEM', ftInteger)]
    [Dictionary('MFC_ORDEMITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_ORDEMITEM: Integer read FMFC_ORDEMITEM write FMFC_ORDEMITEM;
    const MFC_ORDEMITEM_Name = 'MFC_ORDEMITEM';

    [Restrictions([NoValidate])]
    [Column('CTR_NOTAFISCAL', ftString, 9)]
    [Dictionary('CTR_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NOTAFISCAL: String read FCTR_NOTAFISCAL write FCTR_NOTAFISCAL;
    const CTR_NOTAFISCAL_Name = 'CTR_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CTR_NUMERODOCTO', ftString, 6)]
    [Dictionary('CTR_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NUMERODOCTO: String read FCTR_NUMERODOCTO write FCTR_NUMERODOCTO;
    const CTR_NUMERODOCTO_Name = 'CTR_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_TIPOFRETE', ftString, 1)]
    [Dictionary('MFC_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_TIPOFRETE: String read FMFC_TIPOFRETE write FMFC_TIPOFRETE;
    const MFC_TIPOFRETE_Name = 'MFC_TIPOFRETE';

    [Restrictions([NoValidate])]
    [Column('MFC_PESOBRUTO', ftBCD)]
    [Dictionary('MFC_PESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_PESOBRUTO: Double read FMFC_PESOBRUTO write FMFC_PESOBRUTO;
    const MFC_PESOBRUTO_Name = 'MFC_PESOBRUTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_VALORFRETE', ftBCD)]
    [Dictionary('MFC_VALORFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_VALORFRETE: Double read FMFC_VALORFRETE write FMFC_VALORFRETE;
    const MFC_VALORFRETE_Name = 'MFC_VALORFRETE';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_VALORNOTAFISCAL', ftBCD)]
    [Dictionary('MFC_VALORNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_VALORNOTAFISCAL: Double read FMFC_VALORNOTAFISCAL write FMFC_VALORNOTAFISCAL;
    const MFC_VALORNOTAFISCAL_Name = 'MFC_VALORNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('MFC_CODIGORASTREAMENTO', ftString, 20)]
    [Dictionary('MFC_CODIGORASTREAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_CODIGORASTREAMENTO: String read FMFC_CODIGORASTREAMENTO write FMFC_CODIGORASTREAMENTO;
    const MFC_CODIGORASTREAMENTO_Name = 'MFC_CODIGORASTREAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_DATAALTERACAO', ftDateTime)]
    [Dictionary('MFC_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MFC_DATAALTERACAO: TDateTime read FMFC_DATAALTERACAO write FMFC_DATAALTERACAO;
    const MFC_DATAALTERACAO_Name = 'MFC_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('MFC_01_ID_OLD', ftInteger)]
    [Dictionary('MFC_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_01_ID_OLD: Integer read FMFC_01_ID_OLD write FMFC_01_ID_OLD;
    const MFC_01_ID_OLD_Name = 'MFC_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('MFC_ID_OLD', ftInteger)]
    [Dictionary('MFC_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_ID_OLD: Integer read FMFC_ID_OLD write FMFC_ID_OLD;
    const MFC_ID_OLD_Name = 'MFC_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CTR_ID_OLD', ftInteger)]
    [Dictionary('CTR_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_ID_OLD: Integer read FCTR_ID_OLD write FCTR_ID_OLD;
    const CTR_ID_OLD_Name = 'CTR_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('MFC_DESTINOFINAL', ftString, 1)]
    [Dictionary('MFC_DESTINOFINAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_DESTINOFINAL: String read FMFC_DESTINOFINAL write FMFC_DESTINOFINAL;
    const MFC_DESTINOFINAL_Name = 'MFC_DESTINOFINAL';
  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoMFC_00_01)

end.
