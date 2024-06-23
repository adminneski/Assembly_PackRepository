unit express.dbo.PRT_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.prt_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('PRT_00_01', '')]
  [PrimaryKey('PRT_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PRT_01_ID')]
  TDtoPRT_00_01 = class
  private
    { Private declarations } 
    FPRT_01_ID: Integer;
    FPRT_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FPRT_LARGURAITEM: Double;
    FPRT_COMPRIMENTOITEM: Double;
    FPRT_ALTURAITEM: Double;
    FPRT_QUANTIDADETOTALITEM: Double;
    FPRT_VALORUNITARIOITEM: Double;
    FPRT_VALORTOTALITEM: Double;
    FPRT_DATAALTERACAO: TDateTime;
    FPRT_01_ID_OLD: Integer;
    FPRT_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'PRT_00_01';
    const PrimaryKey = 'PRT_01_ID';
    const Sequence   = 'SEQ_PRT_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRT_01_ID', ftInteger)]
    [Dictionary('PRT_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRT_01_ID: Integer read FPRT_01_ID write FPRT_01_ID;
    const PRT_01_ID_Name = 'PRT_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRT_ID', ftInteger)]
    [ForeignKey('PRT_00_01_fk', 'PRT_ID', 'PRT_00', 'PRT_ID', SetNull, SetNull)]
    [Dictionary('PRT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRT_ID: Integer read FPRT_ID write FPRT_ID;
    const PRT_ID_Name = 'PRT_ID';

    [Restrictions([NoValidate, NotNull])]
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
    [Column('PRT_LARGURAITEM', ftBCD, 1869770784, 2)]
    [Dictionary('PRT_LARGURAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRT_LARGURAITEM: Double read FPRT_LARGURAITEM write FPRT_LARGURAITEM;
    const PRT_LARGURAITEM_Name = 'PRT_LARGURAITEM';

    [Restrictions([NoValidate])]
    [Column('PRT_COMPRIMENTOITEM', ftBCD, 1529377646, 2)]
    [Dictionary('PRT_COMPRIMENTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRT_COMPRIMENTOITEM: Double read FPRT_COMPRIMENTOITEM write FPRT_COMPRIMENTOITEM;
    const PRT_COMPRIMENTOITEM_Name = 'PRT_COMPRIMENTOITEM';

    [Restrictions([NoValidate])]
    [Column('PRT_ALTURAITEM', ftBCD, 1952531540, 2)]
    [Dictionary('PRT_ALTURAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRT_ALTURAITEM: Double read FPRT_ALTURAITEM write FPRT_ALTURAITEM;
    const PRT_ALTURAITEM_Name = 'PRT_ALTURAITEM';

    [Restrictions([NoValidate])]
    [Column('PRT_QUANTIDADETOTALITEM', ftBCD, 1142962771, 2)]
    [Dictionary('PRT_QUANTIDADETOTALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRT_QUANTIDADETOTALITEM: Double read FPRT_QUANTIDADETOTALITEM write FPRT_QUANTIDADETOTALITEM;
    const PRT_QUANTIDADETOTALITEM_Name = 'PRT_QUANTIDADETOTALITEM';

    [Restrictions([NoValidate])]
    [Column('PRT_VALORUNITARIOITEM', ftBCD, 1769238085, 2)]
    [Dictionary('PRT_VALORUNITARIOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRT_VALORUNITARIOITEM: Double read FPRT_VALORUNITARIOITEM write FPRT_VALORUNITARIOITEM;
    const PRT_VALORUNITARIOITEM_Name = 'PRT_VALORUNITARIOITEM';

    [Restrictions([NoValidate])]
    [Column('PRT_VALORTOTALITEM', ftBCD, 1380275039, 2)]
    [Dictionary('PRT_VALORTOTALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRT_VALORTOTALITEM: Double read FPRT_VALORTOTALITEM write FPRT_VALORTOTALITEM;
    const PRT_VALORTOTALITEM_Name = 'PRT_VALORTOTALITEM';

    [Restrictions([NoValidate])]
    [Column('PRT_DATAALTERACAO', ftDateTime)]
    [Dictionary('PRT_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property PRT_DATAALTERACAO: TDateTime read FPRT_DATAALTERACAO write FPRT_DATAALTERACAO;
    const PRT_DATAALTERACAO_Name = 'PRT_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('PRT_01_ID_OLD', ftInteger)]
    [Dictionary('PRT_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRT_01_ID_OLD: Integer read FPRT_01_ID_OLD write FPRT_01_ID_OLD;
    const PRT_01_ID_OLD_Name = 'PRT_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('PRT_ID_OLD', ftInteger)]
    [Dictionary('PRT_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRT_ID_OLD: Integer read FPRT_ID_OLD write FPRT_ID_OLD;
    const PRT_ID_OLD_Name = 'PRT_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPRT_00_01)

end.
