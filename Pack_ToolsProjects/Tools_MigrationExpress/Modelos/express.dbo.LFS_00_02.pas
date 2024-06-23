unit express.dbo.LFS_00_02;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.lfs_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('LFS_00_02', '')]
  [PrimaryKey('LFS_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_LFS_ID')]
  TDtoLFS_00_02 = class
  private
    { Private declarations } 
    FLFS_ID: Integer;
    FCOM_CODIGO: Integer;
    FLFS_NATUREZAOPERACAO: String;
    FLFS_TIPOCONHECIMENTO: String;
    FLFS_DECLARACAOEXPORTACAO: String;
    FLFS_DATADECLARACAOEXPORTACAO: TDateTime;
    FLFS_REGISTROEXPORTACAO: String;
    FLFS_DATAREGISTROEXPORTACAO: TDateTime;
    FLFS_CONHECIMENTOEMBARQUE: String;
    FLFS_DATACONHECIMENTOEMBARQUE: TDateTime;
    FLFS_DATAAVERBACAODECLARACAO: TDateTime;
    FLFS_DATAALTERACAO: TDateTime;
    FLFS_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'LFS_00_02';
    const PrimaryKey = 'LFS_ID';
    const Sequence   = 'SEQ_LFS_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_ID', ftInteger)]
    [ForeignKey('LFS_00_02_fk', 'LFS_ID', 'LFS_00', 'LFS_ID', SetNull, SetNull)]
    [Dictionary('LFS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ID: Integer read FLFS_ID write FLFS_ID;
    const LFS_ID_Name = 'LFS_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LFS_NATUREZAOPERACAO', ftString, 1)]
    [Dictionary('LFS_NATUREZAOPERACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_NATUREZAOPERACAO: String read FLFS_NATUREZAOPERACAO write FLFS_NATUREZAOPERACAO;
    const LFS_NATUREZAOPERACAO_Name = 'LFS_NATUREZAOPERACAO';

    [Restrictions([NoValidate])]
    [Column('LFS_TIPOCONHECIMENTO', ftString, 2)]
    [Dictionary('LFS_TIPOCONHECIMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_TIPOCONHECIMENTO: String read FLFS_TIPOCONHECIMENTO write FLFS_TIPOCONHECIMENTO;
    const LFS_TIPOCONHECIMENTO_Name = 'LFS_TIPOCONHECIMENTO';

    [Restrictions([NoValidate])]
    [Column('LFS_DECLARACAOEXPORTACAO', ftString, 11)]
    [Dictionary('LFS_DECLARACAOEXPORTACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_DECLARACAOEXPORTACAO: String read FLFS_DECLARACAOEXPORTACAO write FLFS_DECLARACAOEXPORTACAO;
    const LFS_DECLARACAOEXPORTACAO_Name = 'LFS_DECLARACAOEXPORTACAO';

    [Restrictions([NoValidate])]
    [Column('LFS_DATADECLARACAOEXPORTACAO', ftDateTime)]
    [Dictionary('LFS_DATADECLARACAOEXPORTACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property LFS_DATADECLARACAOEXPORTACAO: TDateTime read FLFS_DATADECLARACAOEXPORTACAO write FLFS_DATADECLARACAOEXPORTACAO;
    const LFS_DATADECLARACAOEXPORTACAO_Name = 'LFS_DATADECLARACAOEXPORTACAO';

    [Restrictions([NoValidate])]
    [Column('LFS_REGISTROEXPORTACAO', ftString, 12)]
    [Dictionary('LFS_REGISTROEXPORTACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_REGISTROEXPORTACAO: String read FLFS_REGISTROEXPORTACAO write FLFS_REGISTROEXPORTACAO;
    const LFS_REGISTROEXPORTACAO_Name = 'LFS_REGISTROEXPORTACAO';

    [Restrictions([NoValidate])]
    [Column('LFS_DATAREGISTROEXPORTACAO', ftDateTime)]
    [Dictionary('LFS_DATAREGISTROEXPORTACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property LFS_DATAREGISTROEXPORTACAO: TDateTime read FLFS_DATAREGISTROEXPORTACAO write FLFS_DATAREGISTROEXPORTACAO;
    const LFS_DATAREGISTROEXPORTACAO_Name = 'LFS_DATAREGISTROEXPORTACAO';

    [Restrictions([NoValidate])]
    [Column('LFS_CONHECIMENTOEMBARQUE', ftString, 16)]
    [Dictionary('LFS_CONHECIMENTOEMBARQUE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_CONHECIMENTOEMBARQUE: String read FLFS_CONHECIMENTOEMBARQUE write FLFS_CONHECIMENTOEMBARQUE;
    const LFS_CONHECIMENTOEMBARQUE_Name = 'LFS_CONHECIMENTOEMBARQUE';

    [Restrictions([NoValidate])]
    [Column('LFS_DATACONHECIMENTOEMBARQUE', ftDateTime)]
    [Dictionary('LFS_DATACONHECIMENTOEMBARQUE', 'Mensagem de validação', '', '', '', taCenter)]
    property LFS_DATACONHECIMENTOEMBARQUE: TDateTime read FLFS_DATACONHECIMENTOEMBARQUE write FLFS_DATACONHECIMENTOEMBARQUE;
    const LFS_DATACONHECIMENTOEMBARQUE_Name = 'LFS_DATACONHECIMENTOEMBARQUE';

    [Restrictions([NoValidate])]
    [Column('LFS_DATAAVERBACAODECLARACAO', ftDateTime)]
    [Dictionary('LFS_DATAAVERBACAODECLARACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property LFS_DATAAVERBACAODECLARACAO: TDateTime read FLFS_DATAAVERBACAODECLARACAO write FLFS_DATAAVERBACAODECLARACAO;
    const LFS_DATAAVERBACAODECLARACAO_Name = 'LFS_DATAAVERBACAODECLARACAO';

    [Restrictions([NoValidate])]
    [Column('LFS_DATAALTERACAO', ftDateTime)]
    [Dictionary('LFS_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property LFS_DATAALTERACAO: TDateTime read FLFS_DATAALTERACAO write FLFS_DATAALTERACAO;
    const LFS_DATAALTERACAO_Name = 'LFS_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('LFS_ID_OLD', ftInteger)]
    [Dictionary('LFS_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ID_OLD: Integer read FLFS_ID_OLD write FLFS_ID_OLD;
    const LFS_ID_OLD_Name = 'LFS_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoLFS_00_02)

end.
