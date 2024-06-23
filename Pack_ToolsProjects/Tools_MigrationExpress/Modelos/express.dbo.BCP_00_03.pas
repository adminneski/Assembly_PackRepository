unit express.dbo.BCP_00_03;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.bcp_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('BCP_00_03', '')]
  [PrimaryKey('BCP_03_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_BCP_03_ID')]
  TDtoBCP_00_03 = class
  private
    { Private declarations } 
    FBCP_03_ID: Integer;
    FCOM_CODIGO: Integer;
    FBCP_ID: Integer;
    FTLN_ID: Integer;
    FCTA_CODIGO: Integer;
    FTLN_NUMEROCHEQUE: String;
    FTLN_VALORCHEQUE: Double;
    FCTA_CODIGOTRANSFERENCIA: Integer;
    FBCP_DATAALTERACAO: TDateTime;
    FBCP_ID_OLD: Integer;
    FTLN_ID_OLD: Integer;
    FBCP_03_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'BCP_00_03';
    const PrimaryKey = 'BCP_03_ID';
    const Sequence   = 'SEQ_BCP_03_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCP_03_ID', ftInteger)]
    [Dictionary('BCP_03_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCP_03_ID: Integer read FBCP_03_ID write FBCP_03_ID;
    const BCP_03_ID_Name = 'BCP_03_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCP_ID', ftInteger)]
    [ForeignKey('BCP_00_03_fk', 'BCP_ID', 'BCP_00', 'BCP_ID', SetNull, SetNull)]
    [Dictionary('BCP_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCP_ID: Integer read FBCP_ID write FBCP_ID;
    const BCP_ID_Name = 'BCP_ID';

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
    [Column('BCP_DATAALTERACAO', ftDateTime)]
    [Dictionary('BCP_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property BCP_DATAALTERACAO: TDateTime read FBCP_DATAALTERACAO write FBCP_DATAALTERACAO;
    const BCP_DATAALTERACAO_Name = 'BCP_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('BCP_ID_OLD', ftInteger)]
    [Dictionary('BCP_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCP_ID_OLD: Integer read FBCP_ID_OLD write FBCP_ID_OLD;
    const BCP_ID_OLD_Name = 'BCP_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('TLN_ID_OLD', ftInteger)]
    [Dictionary('TLN_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property TLN_ID_OLD: Integer read FTLN_ID_OLD write FTLN_ID_OLD;
    const TLN_ID_OLD_Name = 'TLN_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('BCP_03_ID_OLD', ftInteger)]
    [Dictionary('BCP_03_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCP_03_ID_OLD: Integer read FBCP_03_ID_OLD write FBCP_03_ID_OLD;
    const BCP_03_ID_OLD_Name = 'BCP_03_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoBCP_00_03)

end.
