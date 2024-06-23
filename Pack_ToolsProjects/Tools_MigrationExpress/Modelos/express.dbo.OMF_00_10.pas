unit express.dbo.OMF_00_10;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.omf_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('OMF_00_10', '')]
  [PrimaryKey('OMF_10_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_OMF_10_ID')]
  TDtoOMF_00_10 = class
  private
    { Private declarations } 
    FOMF_10_ID: Integer;
    FCOM_CODIGO: Integer;
    FOMF_ID: Integer;
    FCRE_ID: Integer;
    FOMF_GERARCREDITO: Double;
    FOMF_DESCTODEVOLUCAO: Double;
    FOMF_TOTALVALORORIGINALCRE: Double;
    FOMF_DESATIVAR: String;
    FOMF_DATAALTERACAO: TDateTime;
  public
    { Public declarations }
    const Table      = 'OMF_00_10';
    const PrimaryKey = 'OMF_10_ID';
    const Sequence   = 'SEQ_OMF_10_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_10_ID', ftInteger)]
    [Dictionary('OMF_10_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_10_ID: Integer read FOMF_10_ID write FOMF_10_ID;
    const OMF_10_ID_Name = 'OMF_10_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_ID', ftInteger)]
    [ForeignKey('OMF_00_10_fk', 'OMF_ID', 'OMF_00', 'OMF_ID', SetNull, SetNull)]
    [Dictionary('OMF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_ID: Integer read FOMF_ID write FOMF_ID;
    const OMF_ID_Name = 'OMF_ID';

    [Restrictions([NoValidate])]
    [Column('CRE_ID', ftInteger)]
    [Dictionary('CRE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ID: Integer read FCRE_ID write FCRE_ID;
    const CRE_ID_Name = 'CRE_ID';

    [Restrictions([NoValidate])]
    [Column('OMF_GERARCREDITO', ftBCD)]
    [Dictionary('OMF_GERARCREDITO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_GERARCREDITO: Double read FOMF_GERARCREDITO write FOMF_GERARCREDITO;
    const OMF_GERARCREDITO_Name = 'OMF_GERARCREDITO';

    [Restrictions([NoValidate])]
    [Column('OMF_DESCTODEVOLUCAO', ftBCD)]
    [Dictionary('OMF_DESCTODEVOLUCAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_DESCTODEVOLUCAO: Double read FOMF_DESCTODEVOLUCAO write FOMF_DESCTODEVOLUCAO;
    const OMF_DESCTODEVOLUCAO_Name = 'OMF_DESCTODEVOLUCAO';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALVALORORIGINALCRE', ftBCD)]
    [Dictionary('OMF_TOTALVALORORIGINALCRE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property OMF_TOTALVALORORIGINALCRE: Double read FOMF_TOTALVALORORIGINALCRE write FOMF_TOTALVALORORIGINALCRE;
    const OMF_TOTALVALORORIGINALCRE_Name = 'OMF_TOTALVALORORIGINALCRE';

    [Restrictions([NoValidate])]
    [Column('OMF_DESATIVAR', ftString, 1)]
    [Dictionary('OMF_DESATIVAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_DESATIVAR: String read FOMF_DESATIVAR write FOMF_DESATIVAR;
    const OMF_DESATIVAR_Name = 'OMF_DESATIVAR';

    [Restrictions([NoValidate])]
    [Column('OMF_DATAALTERACAO', ftDateTime)]
    [Dictionary('OMF_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property OMF_DATAALTERACAO: TDateTime read FOMF_DATAALTERACAO write FOMF_DATAALTERACAO;
    const OMF_DATAALTERACAO_Name = 'OMF_DATAALTERACAO';
  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoOMF_00_10)

end.
