unit express.dbo.CRE_00_02_02;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.cre_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('CRE_00_02_02', '')]
  [PrimaryKey('CRE_02_02_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CRE_02_02_ID')]
  TDtoCRE_00_02_02 = class
  private
    { Private declarations } 
    FCRE_02_02_ID: Integer;
    FCOM_CODIGO: Integer;
    FCRE_ID: Integer;
    FMDV_ID: Integer;
    FCRE_DATADEVOLUCAO: TDateTime;
    FCRE_HISTORICO: String;
    FCRE_INTEGRACAO: String;
    FCRE_DATAALTERACAO: TDateTime;
    FCRE_ID_OLD: Integer;
    FCRE_02_02_ID_OLD: Integer;
    FCRE_INTEGRACAO_OLD: String;
  public
    { Public declarations }
    const Table      = 'CRE_00_02_02';
    const PrimaryKey = 'CRE_02_02_ID';
    const Sequence   = 'SEQ_CRE_02_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_02_02_ID', ftInteger)]
    [Dictionary('CRE_02_02_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_02_02_ID: Integer read FCRE_02_02_ID write FCRE_02_02_ID;
    const CRE_02_02_ID_Name = 'CRE_02_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_ID', ftInteger)]
    [ForeignKey('CRE_00_02_02_fk', 'CRE_ID', 'CRE_00', 'CRE_ID', SetNull, SetNull)]
    [Dictionary('CRE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ID: Integer read FCRE_ID write FCRE_ID;
    const CRE_ID_Name = 'CRE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('MDV_ID', ftInteger)]
    [Dictionary('MDV_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MDV_ID: Integer read FMDV_ID write FMDV_ID;
    const MDV_ID_Name = 'MDV_ID';

    [Restrictions([NoValidate])]
    [Column('CRE_DATADEVOLUCAO', ftDateTime)]
    [Dictionary('CRE_DATADEVOLUCAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATADEVOLUCAO: TDateTime read FCRE_DATADEVOLUCAO write FCRE_DATADEVOLUCAO;
    const CRE_DATADEVOLUCAO_Name = 'CRE_DATADEVOLUCAO';

    [Restrictions([NoValidate])]
    [Column('CRE_HISTORICO', ftString, 300)]
    [Dictionary('CRE_HISTORICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_HISTORICO: String read FCRE_HISTORICO write FCRE_HISTORICO;
    const CRE_HISTORICO_Name = 'CRE_HISTORICO';

    [Restrictions([NoValidate])]
    [Column('CRE_INTEGRACAO', ftString, 20)]
    [Dictionary('CRE_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_INTEGRACAO: String read FCRE_INTEGRACAO write FCRE_INTEGRACAO;
    const CRE_INTEGRACAO_Name = 'CRE_INTEGRACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_DATAALTERACAO', ftDateTime)]
    [Dictionary('CRE_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRE_DATAALTERACAO: TDateTime read FCRE_DATAALTERACAO write FCRE_DATAALTERACAO;
    const CRE_DATAALTERACAO_Name = 'CRE_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CRE_ID_OLD', ftInteger)]
    [Dictionary('CRE_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ID_OLD: Integer read FCRE_ID_OLD write FCRE_ID_OLD;
    const CRE_ID_OLD_Name = 'CRE_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CRE_02_02_ID_OLD', ftInteger)]
    [Dictionary('CRE_02_02_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_02_02_ID_OLD: Integer read FCRE_02_02_ID_OLD write FCRE_02_02_ID_OLD;
    const CRE_02_02_ID_OLD_Name = 'CRE_02_02_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CRE_INTEGRACAO_OLD', ftString, 50)]
    [Dictionary('CRE_INTEGRACAO_OLD', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_INTEGRACAO_OLD: String read FCRE_INTEGRACAO_OLD write FCRE_INTEGRACAO_OLD;
    const CRE_INTEGRACAO_OLD_Name = 'CRE_INTEGRACAO_OLD';
  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoCRE_00_02_02)

end.
