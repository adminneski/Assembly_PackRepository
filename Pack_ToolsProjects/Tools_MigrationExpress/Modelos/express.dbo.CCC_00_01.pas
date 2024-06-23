unit express.dbo.CCC_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.ccc_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('CCC_00_01', '')]
  [PrimaryKey('CCC_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CCC_01_ID')]
  TDtoCCC_00_01 = class
  private
    { Private declarations } 
    FCCC_ID: Integer;
    FCCC_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FCCC_DATALANCAMENTO: TDateTime;
    FCCC_DIASRETORNO: Integer;
    FCCC_STATUS: String;
    FFAT_ID: Integer;
    FCCC_OBSERVACAO: String;
    FCCC_DATAALTERACAO: TDateTime;
    FCCC_ID_OLD: Integer;
    FCCC_01_ID_OLD: Integer;
    FFAT_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'CCC_00_01';
    const PrimaryKey = 'CCC_01_ID';
    const Sequence   = 'SEQ_CCC_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CCC_ID', ftInteger)]
    [ForeignKey('CCC_00_01_fk', 'CCC_ID', 'CCC_00', 'CCC_ID', SetNull, SetNull)]
    [Dictionary('CCC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCC_ID: Integer read FCCC_ID write FCCC_ID;
    const CCC_ID_Name = 'CCC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CCC_01_ID', ftInteger)]
    [Dictionary('CCC_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCC_01_ID: Integer read FCCC_01_ID write FCCC_01_ID;
    const CCC_01_ID_Name = 'CCC_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CCC_DATALANCAMENTO', ftDateTime)]
    [Dictionary('CCC_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CCC_DATALANCAMENTO: TDateTime read FCCC_DATALANCAMENTO write FCCC_DATALANCAMENTO;
    const CCC_DATALANCAMENTO_Name = 'CCC_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('CCC_DIASRETORNO', ftInteger)]
    [Dictionary('CCC_DIASRETORNO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCC_DIASRETORNO: Integer read FCCC_DIASRETORNO write FCCC_DIASRETORNO;
    const CCC_DIASRETORNO_Name = 'CCC_DIASRETORNO';

    [Restrictions([NoValidate])]
    [Column('CCC_STATUS', ftString, 1)]
    [Dictionary('CCC_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CCC_STATUS: String read FCCC_STATUS write FCCC_STATUS;
    const CCC_STATUS_Name = 'CCC_STATUS';

    [Restrictions([NoValidate])]
    [Column('FAT_ID', ftInteger)]
    [Dictionary('FAT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID: Integer read FFAT_ID write FFAT_ID;
    const FAT_ID_Name = 'FAT_ID';

    [Restrictions([NoValidate])]
    [Column('CCC_OBSERVACAO', ftString, 5000)]
    [Dictionary('CCC_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CCC_OBSERVACAO: String read FCCC_OBSERVACAO write FCCC_OBSERVACAO;
    const CCC_OBSERVACAO_Name = 'CCC_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('CCC_DATAALTERACAO', ftDateTime)]
    [Dictionary('CCC_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CCC_DATAALTERACAO: TDateTime read FCCC_DATAALTERACAO write FCCC_DATAALTERACAO;
    const CCC_DATAALTERACAO_Name = 'CCC_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CCC_ID_OLD', ftInteger)]
    [Dictionary('CCC_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCC_ID_OLD: Integer read FCCC_ID_OLD write FCCC_ID_OLD;
    const CCC_ID_OLD_Name = 'CCC_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CCC_01_ID_OLD', ftInteger)]
    [Dictionary('CCC_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCC_01_ID_OLD: Integer read FCCC_01_ID_OLD write FCCC_01_ID_OLD;
    const CCC_01_ID_OLD_Name = 'CCC_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('FAT_ID_OLD', ftInteger)]
    [Dictionary('FAT_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID_OLD: Integer read FFAT_ID_OLD write FFAT_ID_OLD;
    const FAT_ID_OLD_Name = 'FAT_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCCC_00_01)

end.
