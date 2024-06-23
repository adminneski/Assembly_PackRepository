unit express.dbo.MTL_00_02;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.mtl_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('MTL_00_02', '')]
  [PrimaryKey('MTL_02_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_MTL_02_ID')]
  TDtoMTL_00_02 = class
  private
    { Private declarations } 
    FMTL_02_ID: Integer;
    FCOM_CODIGO: Integer;
    FMTL_ID: Integer;
    FTLN_ID: Integer;
    FCTA_CODIGO: Integer;
    FTLN_NUMEROCHEQUE: String;
    FTLN_VALORCHEQUE: Double;
    FCTA_CODIGOTRANSFERENCIA: Integer;
    FMTL_DATAALTERACAO: TDateTime;
    FMTL_02_ID_OLD: Integer;
    FMTL_ID_OLD: Integer;
    FTLN_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'MTL_00_02';
    const PrimaryKey = 'MTL_02_ID';
    const Sequence   = 'SEQ_MTL_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('MTL_02_ID', ftInteger)]
    [Dictionary('MTL_02_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MTL_02_ID: Integer read FMTL_02_ID write FMTL_02_ID;
    const MTL_02_ID_Name = 'MTL_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MTL_ID', ftInteger)]
    [ForeignKey('MTL_00_02_fk', 'MTL_ID', 'MTL_00', 'MTL_ID', SetNull, SetNull)]
    [Dictionary('MTL_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MTL_ID: Integer read FMTL_ID write FMTL_ID;
    const MTL_ID_Name = 'MTL_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('TLN_ID', ftInteger)]
    [Dictionary('TLN_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property TLN_ID: Integer read FTLN_ID write FTLN_ID;
    const TLN_ID_Name = 'TLN_ID';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGO', ftInteger)]
    [Dictionary('CTA_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGO: Integer read FCTA_CODIGO write FCTA_CODIGO;
    const CTA_CODIGO_Name = 'CTA_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TLN_NUMEROCHEQUE', ftString, 6)]
    [Dictionary('TLN_NUMEROCHEQUE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TLN_NUMEROCHEQUE: String read FTLN_NUMEROCHEQUE write FTLN_NUMEROCHEQUE;
    const TLN_NUMEROCHEQUE_Name = 'TLN_NUMEROCHEQUE';

    [Restrictions([NoValidate, NotNull])]
    [Column('TLN_VALORCHEQUE', ftBCD)]
    [Dictionary('TLN_VALORCHEQUE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TLN_VALORCHEQUE: Double read FTLN_VALORCHEQUE write FTLN_VALORCHEQUE;
    const TLN_VALORCHEQUE_Name = 'TLN_VALORCHEQUE';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGOTRANSFERENCIA', ftInteger)]
    [Dictionary('CTA_CODIGOTRANSFERENCIA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGOTRANSFERENCIA: Integer read FCTA_CODIGOTRANSFERENCIA write FCTA_CODIGOTRANSFERENCIA;
    const CTA_CODIGOTRANSFERENCIA_Name = 'CTA_CODIGOTRANSFERENCIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('MTL_DATAALTERACAO', ftDateTime)]
    [Dictionary('MTL_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MTL_DATAALTERACAO: TDateTime read FMTL_DATAALTERACAO write FMTL_DATAALTERACAO;
    const MTL_DATAALTERACAO_Name = 'MTL_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('MTL_02_ID_OLD', ftInteger)]
    [Dictionary('MTL_02_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property MTL_02_ID_OLD: Integer read FMTL_02_ID_OLD write FMTL_02_ID_OLD;
    const MTL_02_ID_OLD_Name = 'MTL_02_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('MTL_ID_OLD', ftInteger)]
    [Dictionary('MTL_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property MTL_ID_OLD: Integer read FMTL_ID_OLD write FMTL_ID_OLD;
    const MTL_ID_OLD_Name = 'MTL_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('TLN_ID_OLD', ftInteger)]
    [Dictionary('TLN_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property TLN_ID_OLD: Integer read FTLN_ID_OLD write FTLN_ID_OLD;
    const TLN_ID_OLD_Name = 'TLN_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoMTL_00_02)

end.
