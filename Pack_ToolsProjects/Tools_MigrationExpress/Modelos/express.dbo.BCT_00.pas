unit express.dbo.BCT_00;

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
  [Table('BCT_00', '')]
  [PrimaryKey('BCT_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_BCT_ID')]
  TDtoBCT_00 = class
  private
    { Private declarations } 
    FBCT_ID: Integer;
    FCOM_CODIGO: Integer;
    FCTR_ID: Integer;
    FBCT_DATALACAMENTO: TDateTime;
    FCTR_NUMERODOCTO: String;
    FBCT_TOTALNUMEROVOLUMES: Double;
    FBCT_TOTALPESOLIQUIDO: Double;
    FBCT_DATAALTERACAO: TDateTime;
    FBCT_ID_OLD: Integer;
    FCTR_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'BCT_00';
     const PrimaryKey = 'BCT_ID';
     const Sequence   = 'SEQ_BCT_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCT_ID', ftInteger)]
    [Dictionary('BCT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCT_ID: Integer read FBCT_ID write FBCT_ID;
    const BCT_ID_Name = 'BCT_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_ID', ftInteger)]
    [Dictionary('CTR_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_ID: Integer read FCTR_ID write FCTR_ID;
    const CTR_ID_Name = 'CTR_ID';

    [Restrictions([NoValidate])]
    [Column('BCT_DATALACAMENTO', ftDateTime)]
    [Dictionary('BCT_DATALACAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property BCT_DATALACAMENTO: TDateTime read FBCT_DATALACAMENTO write FBCT_DATALACAMENTO;
    const BCT_DATALACAMENTO_Name = 'BCT_DATALACAMENTO';

    [Restrictions([NoValidate])]
    [Column('CTR_NUMERODOCTO', ftString, 6)]
    [Dictionary('CTR_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NUMERODOCTO: String read FCTR_NUMERODOCTO write FCTR_NUMERODOCTO;
    const CTR_NUMERODOCTO_Name = 'CTR_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('BCT_TOTALNUMEROVOLUMES', ftBCD)]
    [Dictionary('BCT_TOTALNUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property BCT_TOTALNUMEROVOLUMES: Double read FBCT_TOTALNUMEROVOLUMES write FBCT_TOTALNUMEROVOLUMES;
    const BCT_TOTALNUMEROVOLUMES_Name = 'BCT_TOTALNUMEROVOLUMES';

    [Restrictions([NoValidate])]
    [Column('BCT_TOTALPESOLIQUIDO', ftBCD)]
    [Dictionary('BCT_TOTALPESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property BCT_TOTALPESOLIQUIDO: Double read FBCT_TOTALPESOLIQUIDO write FBCT_TOTALPESOLIQUIDO;
    const BCT_TOTALPESOLIQUIDO_Name = 'BCT_TOTALPESOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('BCT_DATAALTERACAO', ftDateTime)]
    [Dictionary('BCT_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property BCT_DATAALTERACAO: TDateTime read FBCT_DATAALTERACAO write FBCT_DATAALTERACAO;
    const BCT_DATAALTERACAO_Name = 'BCT_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('BCT_ID_OLD', ftInteger)]
    [Dictionary('BCT_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCT_ID_OLD: Integer read FBCT_ID_OLD write FBCT_ID_OLD;
    const BCT_ID_OLD_Name = 'BCT_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CTR_ID_OLD', ftInteger)]
    [Dictionary('CTR_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_ID_OLD: Integer read FCTR_ID_OLD write FCTR_ID_OLD;
    const CTR_ID_OLD_Name = 'CTR_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoBCT_00)

end.
