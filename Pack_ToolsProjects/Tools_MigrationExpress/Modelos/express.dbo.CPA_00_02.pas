unit express.dbo.CPA_00_02;

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
  [Table('CPA_00_02', '')]
  [PrimaryKey('CPA_02_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CPA_02_ID')]
  TDtoCPA_00_02 = class
  private
    { Private declarations } 
    FCPA_02_ID: Integer;
    FCOM_CODIGO: Integer;
    FCPA_ID: Integer;
    FCPA_STATUS: String;
    FCPA_HISTORICO: String;
    FCPA_DATAMOVIMENTO: TDateTime;
    FCPA_DATAALTERACAO: TDateTime;
    FCPA_02_ID_OLD: Integer;
    FCPA_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'CPA_00_02';
    const PrimaryKey = 'CPA_02_ID';
    const Sequence   = 'SEQ_CPA_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_02_ID', ftInteger)]
    [Dictionary('CPA_02_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPA_02_ID: Integer read FCPA_02_ID write FCPA_02_ID;
    const CPA_02_ID_Name = 'CPA_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_ID', ftInteger)]
    [ForeignKey('CPA_00_02_fk', 'CPA_ID', 'CPA_00', 'CPA_ID', SetNull, SetNull)]
    [Dictionary('CPA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPA_ID: Integer read FCPA_ID write FCPA_ID;
    const CPA_ID_Name = 'CPA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_STATUS', ftString, 1)]
    [Dictionary('CPA_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_STATUS: String read FCPA_STATUS write FCPA_STATUS;
    const CPA_STATUS_Name = 'CPA_STATUS';

    [Restrictions([NoValidate])]
    [Column('CPA_HISTORICO', ftString, 300)]
    [Dictionary('CPA_HISTORICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_HISTORICO: String read FCPA_HISTORICO write FCPA_HISTORICO;
    const CPA_HISTORICO_Name = 'CPA_HISTORICO';

    [Restrictions([NoValidate])]
    [Column('CPA_DATAMOVIMENTO', ftDateTime)]
    [Dictionary('CPA_DATAMOVIMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CPA_DATAMOVIMENTO: TDateTime read FCPA_DATAMOVIMENTO write FCPA_DATAMOVIMENTO;
    const CPA_DATAMOVIMENTO_Name = 'CPA_DATAMOVIMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_DATAALTERACAO', ftDateTime)]
    [Dictionary('CPA_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CPA_DATAALTERACAO: TDateTime read FCPA_DATAALTERACAO write FCPA_DATAALTERACAO;
    const CPA_DATAALTERACAO_Name = 'CPA_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CPA_02_ID_OLD', ftInteger)]
    [Dictionary('CPA_02_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPA_02_ID_OLD: Integer read FCPA_02_ID_OLD write FCPA_02_ID_OLD;
    const CPA_02_ID_OLD_Name = 'CPA_02_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CPA_ID_OLD', ftInteger)]
    [Dictionary('CPA_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPA_ID_OLD: Integer read FCPA_ID_OLD write FCPA_ID_OLD;
    const CPA_ID_OLD_Name = 'CPA_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCPA_00_02)

end.
