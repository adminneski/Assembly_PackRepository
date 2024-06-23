unit express.dbo.TLN_00;

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
  [Table('TLN_00', '')]
  [PrimaryKey('TLN_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_TLN_ID')]
  TDtoTLN_00 = class
  private
    { Private declarations } 
    FTLN_ID: Integer;
    FCOM_CODIGO: Integer;
    FCTA_CODIGO: Integer;
    FCTA_CODIGOBAIXA: Integer;
    FTLN_DATABAIXA: TDateTime;
    FTLN_DATAEMISSAO: TDateTime;
    FTLN_DATABOMPARA: TDateTime;
    FTLN_DATACOMPENSACAO: TDateTime;
    FTLN_STATUS: String;
    FTLN_ASSINADO: String;
    FTLN_PREDATADO: String;
    FTLN_NUMEROCHEQUE: String;
    FTLN_VALORCHEQUE: Double;
    FTLN_OBSERVACAO: String;
    FTLN_DESATIVADO: String;
    FTLN_CHEQUEVINCULADO: String;
    FTLN_DATAALTERACAO: TDateTime;
    FTLN_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'TLN_00';
     const PrimaryKey = 'TLN_ID';
     const Sequence   = 'SEQ_TLN_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('TLN_ID', ftInteger)]
    [Dictionary('TLN_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property TLN_ID: Integer read FTLN_ID write FTLN_ID;
    const TLN_ID_Name = 'TLN_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGO', ftInteger)]
    [Dictionary('CTA_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGO: Integer read FCTA_CODIGO write FCTA_CODIGO;
    const CTA_CODIGO_Name = 'CTA_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGOBAIXA', ftInteger)]
    [Dictionary('CTA_CODIGOBAIXA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGOBAIXA: Integer read FCTA_CODIGOBAIXA write FCTA_CODIGOBAIXA;
    const CTA_CODIGOBAIXA_Name = 'CTA_CODIGOBAIXA';

    [Restrictions([NoValidate])]
    [Column('TLN_DATABAIXA', ftDateTime)]
    [Dictionary('TLN_DATABAIXA', 'Mensagem de validação', '', '', '', taCenter)]
    property TLN_DATABAIXA: TDateTime read FTLN_DATABAIXA write FTLN_DATABAIXA;
    const TLN_DATABAIXA_Name = 'TLN_DATABAIXA';

    [Restrictions([NoValidate, NotNull])]
    [Column('TLN_DATAEMISSAO', ftDateTime)]
    [Dictionary('TLN_DATAEMISSAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property TLN_DATAEMISSAO: TDateTime read FTLN_DATAEMISSAO write FTLN_DATAEMISSAO;
    const TLN_DATAEMISSAO_Name = 'TLN_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('TLN_DATABOMPARA', ftDateTime)]
    [Dictionary('TLN_DATABOMPARA', 'Mensagem de validação', '', '', '', taCenter)]
    property TLN_DATABOMPARA: TDateTime read FTLN_DATABOMPARA write FTLN_DATABOMPARA;
    const TLN_DATABOMPARA_Name = 'TLN_DATABOMPARA';

    [Restrictions([NoValidate])]
    [Column('TLN_DATACOMPENSACAO', ftDateTime)]
    [Dictionary('TLN_DATACOMPENSACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property TLN_DATACOMPENSACAO: TDateTime read FTLN_DATACOMPENSACAO write FTLN_DATACOMPENSACAO;
    const TLN_DATACOMPENSACAO_Name = 'TLN_DATACOMPENSACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TLN_STATUS', ftString, 1)]
    [Dictionary('TLN_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TLN_STATUS: String read FTLN_STATUS write FTLN_STATUS;
    const TLN_STATUS_Name = 'TLN_STATUS';

    [Restrictions([NoValidate, NotNull])]
    [Column('TLN_ASSINADO', ftString, 1)]
    [Dictionary('TLN_ASSINADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TLN_ASSINADO: String read FTLN_ASSINADO write FTLN_ASSINADO;
    const TLN_ASSINADO_Name = 'TLN_ASSINADO';

    [Restrictions([NoValidate])]
    [Column('TLN_PREDATADO', ftString, 1)]
    [Dictionary('TLN_PREDATADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TLN_PREDATADO: String read FTLN_PREDATADO write FTLN_PREDATADO;
    const TLN_PREDATADO_Name = 'TLN_PREDATADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TLN_NUMEROCHEQUE', ftString, 6)]
    [Dictionary('TLN_NUMEROCHEQUE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TLN_NUMEROCHEQUE: String read FTLN_NUMEROCHEQUE write FTLN_NUMEROCHEQUE;
    const TLN_NUMEROCHEQUE_Name = 'TLN_NUMEROCHEQUE';

    [Restrictions([NoValidate, NotNull])]
    [Column('TLN_VALORCHEQUE', ftBCD, 7077999, 2)]
    [Dictionary('TLN_VALORCHEQUE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TLN_VALORCHEQUE: Double read FTLN_VALORCHEQUE write FTLN_VALORCHEQUE;
    const TLN_VALORCHEQUE_Name = 'TLN_VALORCHEQUE';

    [Restrictions([NoValidate])]
    [Column('TLN_OBSERVACAO', ftString, 300)]
    [Dictionary('TLN_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TLN_OBSERVACAO: String read FTLN_OBSERVACAO write FTLN_OBSERVACAO;
    const TLN_OBSERVACAO_Name = 'TLN_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TLN_DESATIVADO', ftString, 1)]
    [Dictionary('TLN_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TLN_DESATIVADO: String read FTLN_DESATIVADO write FTLN_DESATIVADO;
    const TLN_DESATIVADO_Name = 'TLN_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('TLN_CHEQUEVINCULADO', ftString, 1)]
    [Dictionary('TLN_CHEQUEVINCULADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TLN_CHEQUEVINCULADO: String read FTLN_CHEQUEVINCULADO write FTLN_CHEQUEVINCULADO;
    const TLN_CHEQUEVINCULADO_Name = 'TLN_CHEQUEVINCULADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('TLN_DATAALTERACAO', ftDateTime)]
    [Dictionary('TLN_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property TLN_DATAALTERACAO: TDateTime read FTLN_DATAALTERACAO write FTLN_DATAALTERACAO;
    const TLN_DATAALTERACAO_Name = 'TLN_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('TLN_ID_OLD', ftInteger)]
    [Dictionary('TLN_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property TLN_ID_OLD: Integer read FTLN_ID_OLD write FTLN_ID_OLD;
    const TLN_ID_OLD_Name = 'TLN_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoTLN_00)

end.
