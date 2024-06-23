unit express.dbo.CRF_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.crf_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('CRF_00_01', '')]
  [PrimaryKey('CRF_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CRF_01_ID')]
  TDtoCRF_00_01 = class
  private
    { Private declarations } 
    FCRF_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FCRF_ID: Integer;
    FFAT_ID: Integer;
    FFAT_01_ID: Integer;
    FPRO_CODIGO: Integer;
    FCRF_QTDRECOLHIDA: Double;
    FCRF_QTDFATURADA: Double;
    FCRF_DATAALTERACAO: TDateTime;
    FCRF_01_ID_OLD: Integer;
    FCRF_ID_OLD: Integer;
    FFAT_ID_OLD: Integer;
    FFAT_01_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'CRF_00_01';
    const PrimaryKey = 'CRF_01_ID';
    const Sequence   = 'SEQ_CRF_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRF_01_ID', ftInteger)]
    [Dictionary('CRF_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRF_01_ID: Integer read FCRF_01_ID write FCRF_01_ID;
    const CRF_01_ID_Name = 'CRF_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRF_ID', ftInteger)]
    [ForeignKey('CRF_00_01_fk', 'CRF_ID', 'CRF_00', 'CRF_ID', SetNull, SetNull)]
    [Dictionary('CRF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRF_ID: Integer read FCRF_ID write FCRF_ID;
    const CRF_ID_Name = 'CRF_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_ID', ftInteger)]
    [Dictionary('FAT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID: Integer read FFAT_ID write FFAT_ID;
    const FAT_ID_Name = 'FAT_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_01_ID', ftInteger)]
    [Dictionary('FAT_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_01_ID: Integer read FFAT_01_ID write FFAT_01_ID;
    const FAT_01_ID_Name = 'FAT_01_ID';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRF_QTDRECOLHIDA', ftBCD)]
    [Dictionary('CRF_QTDRECOLHIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRF_QTDRECOLHIDA: Double read FCRF_QTDRECOLHIDA write FCRF_QTDRECOLHIDA;
    const CRF_QTDRECOLHIDA_Name = 'CRF_QTDRECOLHIDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRF_QTDFATURADA', ftBCD)]
    [Dictionary('CRF_QTDFATURADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRF_QTDFATURADA: Double read FCRF_QTDFATURADA write FCRF_QTDFATURADA;
    const CRF_QTDFATURADA_Name = 'CRF_QTDFATURADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRF_DATAALTERACAO', ftDateTime)]
    [Dictionary('CRF_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRF_DATAALTERACAO: TDateTime read FCRF_DATAALTERACAO write FCRF_DATAALTERACAO;
    const CRF_DATAALTERACAO_Name = 'CRF_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CRF_01_ID_OLD', ftInteger)]
    [Dictionary('CRF_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRF_01_ID_OLD: Integer read FCRF_01_ID_OLD write FCRF_01_ID_OLD;
    const CRF_01_ID_OLD_Name = 'CRF_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CRF_ID_OLD', ftInteger)]
    [Dictionary('CRF_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRF_ID_OLD: Integer read FCRF_ID_OLD write FCRF_ID_OLD;
    const CRF_ID_OLD_Name = 'CRF_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('FAT_ID_OLD', ftInteger)]
    [Dictionary('FAT_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID_OLD: Integer read FFAT_ID_OLD write FFAT_ID_OLD;
    const FAT_ID_OLD_Name = 'FAT_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('FAT_01_ID_OLD', ftInteger)]
    [Dictionary('FAT_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_01_ID_OLD: Integer read FFAT_01_ID_OLD write FFAT_01_ID_OLD;
    const FAT_01_ID_OLD_Name = 'FAT_01_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCRF_00_01)

end.
