unit express.dbo.BCT_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.bct_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('BCT_00_01', '')]
  [PrimaryKey('BCT_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_BCT_01_ID')]
  TDtoBCT_00_01 = class
  private
    { Private declarations } 
    FBCT_01_ID: Integer;
    FBCT_ID: Integer;
    FCOM_CODIGO: Integer;
    FCTR_NOTAFISCAL: String;
    FBCT_DATARECEBIMENTO: TDateTime;
    FBCT_NOMERECEPTOR: String;
    FBCT_PESOLIQUIDO: Double;
    FBCT_NUMEROVOLUMES: Double;
    FBCT_OBSERVACAO: String;
    FBCT_DATAALTERACAO: TDateTime;
    FBCT_ID_OLD: Integer;
    FBCT_01_ID_OLD: Integer;
  public
    { Public declarations }

     const Table      = 'BCT_00_01';
     const PrimaryKey = 'BCT_01_ID';
     const Sequence   = 'SEQ_BCT_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCT_01_ID', ftInteger)]
    [Dictionary('BCT_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCT_01_ID: Integer read FBCT_01_ID write FBCT_01_ID;
    const BCT_01_ID_Name = 'BCT_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCT_ID', ftInteger)]
    [ForeignKey('BCT_00_01_fk', 'BCT_ID', 'BCT_00', 'BCT_ID', SetNull, SetNull)]
    [Dictionary('BCT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCT_ID: Integer read FBCT_ID write FBCT_ID;
    const BCT_ID_Name = 'BCT_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTR_NOTAFISCAL', ftString, 6)]
    [Dictionary('CTR_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NOTAFISCAL: String read FCTR_NOTAFISCAL write FCTR_NOTAFISCAL;
    const CTR_NOTAFISCAL_Name = 'CTR_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('BCT_DATARECEBIMENTO', ftDateTime)]
    [Dictionary('BCT_DATARECEBIMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property BCT_DATARECEBIMENTO: TDateTime read FBCT_DATARECEBIMENTO write FBCT_DATARECEBIMENTO;
    const BCT_DATARECEBIMENTO_Name = 'BCT_DATARECEBIMENTO';

    [Restrictions([NoValidate])]
    [Column('BCT_NOMERECEPTOR', ftString, 50)]
    [Dictionary('BCT_NOMERECEPTOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCT_NOMERECEPTOR: String read FBCT_NOMERECEPTOR write FBCT_NOMERECEPTOR;
    const BCT_NOMERECEPTOR_Name = 'BCT_NOMERECEPTOR';

    [Restrictions([NoValidate])]
    [Column('BCT_PESOLIQUIDO', ftBCD)]
    [Dictionary('BCT_PESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property BCT_PESOLIQUIDO: Double read FBCT_PESOLIQUIDO write FBCT_PESOLIQUIDO;
    const BCT_PESOLIQUIDO_Name = 'BCT_PESOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('BCT_NUMEROVOLUMES', ftBCD)]
    [Dictionary('BCT_NUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property BCT_NUMEROVOLUMES: Double read FBCT_NUMEROVOLUMES write FBCT_NUMEROVOLUMES;
    const BCT_NUMEROVOLUMES_Name = 'BCT_NUMEROVOLUMES';

    [Restrictions([NoValidate])]
    [Column('BCT_OBSERVACAO', ftString, 300)]
    [Dictionary('BCT_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCT_OBSERVACAO: String read FBCT_OBSERVACAO write FBCT_OBSERVACAO;
    const BCT_OBSERVACAO_Name = 'BCT_OBSERVACAO';

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
    [Column('BCT_01_ID_OLD', ftInteger)]
    [Dictionary('BCT_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCT_01_ID_OLD: Integer read FBCT_01_ID_OLD write FBCT_01_ID_OLD;
    const BCT_01_ID_OLD_Name = 'BCT_01_ID_OLD';
  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoBCT_00_01)

end.
