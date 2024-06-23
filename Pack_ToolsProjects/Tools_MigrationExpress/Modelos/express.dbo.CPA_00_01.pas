unit express.dbo.CPA_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.cpa_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('CPA_00_01', '')]
  [PrimaryKey('CPA_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CPA_01_ID')]
  TDtoCPA_00_01 = class
  private
    { Private declarations } 
    FCPA_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FCPA_ID: Integer;
    FTLN_ID: Integer;
    FCTA_CODIGO: Integer;
    FTLN_NUMEROCHEQUE: String;
    FTLN_VALORCHEQUE: Double;
    FTLN_OBSERVACAO: String;
    FCPA_INTEGRACAO: String;
    FCPA_DATAALTERACAO: TDateTime;
    FCPA_01_ID_OLD: Integer;
    FCPA_ID_OLD: Integer;
    FCPA_INTEGRACAO_OLD: String;
    FTLN_ID_OLD: Integer;
  public
    { Public declarations }

    const Table      = 'CPA_00_01';
    const PrimaryKey = 'CPA_01_ID';
    const Sequence   = 'SEQ_CPA_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_01_ID', ftInteger)]
    [Dictionary('CPA_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPA_01_ID: Integer read FCPA_01_ID write FCPA_01_ID;
    const CPA_01_ID_Name = 'CPA_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_ID', ftInteger)]
    [ForeignKey('CPA_00_01_fk', 'CPA_ID', 'CPA_00', 'CPA_ID', SetNull, SetNull)]
    [Dictionary('CPA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPA_ID: Integer read FCPA_ID write FCPA_ID;
    const CPA_ID_Name = 'CPA_ID';

    [Restrictions([NoValidate])]
    [Column('TLN_ID', ftInteger)]
    [Dictionary('TLN_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property TLN_ID: Integer read FTLN_ID write FTLN_ID;
    const TLN_ID_Name = 'TLN_ID';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGO', ftInteger)]
    [Dictionary('CTA_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGO: Integer read FCTA_CODIGO write FCTA_CODIGO;
    const CTA_CODIGO_Name = 'CTA_CODIGO';

    [Restrictions([NoValidate])]
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
    [Column('TLN_OBSERVACAO', ftString, 300)]
    [Dictionary('TLN_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TLN_OBSERVACAO: String read FTLN_OBSERVACAO write FTLN_OBSERVACAO;
    const TLN_OBSERVACAO_Name = 'TLN_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('CPA_INTEGRACAO', ftString, 20)]
    [Dictionary('CPA_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_INTEGRACAO: String read FCPA_INTEGRACAO write FCPA_INTEGRACAO;
    const CPA_INTEGRACAO_Name = 'CPA_INTEGRACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_DATAALTERACAO', ftDateTime)]
    [Dictionary('CPA_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CPA_DATAALTERACAO: TDateTime read FCPA_DATAALTERACAO write FCPA_DATAALTERACAO;
    const CPA_DATAALTERACAO_Name = 'CPA_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CPA_01_ID_OLD', ftInteger)]
    [Dictionary('CPA_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPA_01_ID_OLD: Integer read FCPA_01_ID_OLD write FCPA_01_ID_OLD;
    const CPA_01_ID_OLD_Name = 'CPA_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CPA_ID_OLD', ftInteger)]
    [Dictionary('CPA_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPA_ID_OLD: Integer read FCPA_ID_OLD write FCPA_ID_OLD;
    const CPA_ID_OLD_Name = 'CPA_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CPA_INTEGRACAO_OLD', ftString, 50)]
    [Dictionary('CPA_INTEGRACAO_OLD', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_INTEGRACAO_OLD: String read FCPA_INTEGRACAO_OLD write FCPA_INTEGRACAO_OLD;
    const CPA_INTEGRACAO_OLD_Name = 'CPA_INTEGRACAO_OLD';

    [Restrictions([NoValidate])]
    [Column('TLN_ID_OLD', ftInteger)]
    [Dictionary('TLN_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property TLN_ID_OLD: Integer read FTLN_ID_OLD write FTLN_ID_OLD;
    const TLN_ID_OLD_Name = 'TLN_ID_OLD';
  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoCPA_00_01)

end.
