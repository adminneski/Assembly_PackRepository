unit express.dbo.STG_REGISTRO85;

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
  [Table('STG_REGISTRO85', '')]
  TDtoSTG_REGISTRO85 = class
  private
    { Private declarations } 
    FSTG_ID: Integer;
    FCOM_CODIGO: Integer;
    FSTG_NATUREZAOPERACAO: String;
    FSTG_TIPOCONHECIMENTO: String;
    FSTG_DECLARACAOEXPORTACAO: String;
    FSTG_DATADECLARACAOEXPORTACAO: TDateTime;
    FSTG_REGISTROEXPORTACAO: String;
    FSTG_DATAREGISTROEXPORTACAO: TDateTime;
    FSTG_CONHECIMENTOEMBARQUE: String;
    FSTG_DATACONHECIMENTOEMBARQUE: TDateTime;
    FSTG_DATAAVERBACAODECLARACAO: TDateTime;
    FPAI_CODIGOSISCOMEX: String;
    FLFS_DATAEMISSAO: TDateTime;
    FSTG_NOTAFISCAL: String;
    FSTG_SERIE: String;
    FMNF_CODIGO: String;
  public 
    { Public declarations } 
     const Table      = 'STG_REGISTRO85';

    [Restrictions([NoValidate, NotNull])]
    [Column('STG_ID', ftInteger)]
    [Dictionary('STG_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property STG_ID: Integer read FSTG_ID write FSTG_ID;
    const STG_ID_Name = 'STG_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('STG_NATUREZAOPERACAO', ftString, 1)]
    [Dictionary('STG_NATUREZAOPERACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property STG_NATUREZAOPERACAO: String read FSTG_NATUREZAOPERACAO write FSTG_NATUREZAOPERACAO;
    const STG_NATUREZAOPERACAO_Name = 'STG_NATUREZAOPERACAO';

    [Restrictions([NoValidate])]
    [Column('STG_TIPOCONHECIMENTO', ftString, 2)]
    [Dictionary('STG_TIPOCONHECIMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property STG_TIPOCONHECIMENTO: String read FSTG_TIPOCONHECIMENTO write FSTG_TIPOCONHECIMENTO;
    const STG_TIPOCONHECIMENTO_Name = 'STG_TIPOCONHECIMENTO';

    [Restrictions([NoValidate])]
    [Column('STG_DECLARACAOEXPORTACAO', ftString, 11)]
    [Dictionary('STG_DECLARACAOEXPORTACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property STG_DECLARACAOEXPORTACAO: String read FSTG_DECLARACAOEXPORTACAO write FSTG_DECLARACAOEXPORTACAO;
    const STG_DECLARACAOEXPORTACAO_Name = 'STG_DECLARACAOEXPORTACAO';

    [Restrictions([NoValidate])]
    [Column('STG_DATADECLARACAOEXPORTACAO', ftDateTime)]
    [Dictionary('STG_DATADECLARACAOEXPORTACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property STG_DATADECLARACAOEXPORTACAO: TDateTime read FSTG_DATADECLARACAOEXPORTACAO write FSTG_DATADECLARACAOEXPORTACAO;
    const STG_DATADECLARACAOEXPORTACAO_Name = 'STG_DATADECLARACAOEXPORTACAO';

    [Restrictions([NoValidate])]
    [Column('STG_REGISTROEXPORTACAO', ftString, 12)]
    [Dictionary('STG_REGISTROEXPORTACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property STG_REGISTROEXPORTACAO: String read FSTG_REGISTROEXPORTACAO write FSTG_REGISTROEXPORTACAO;
    const STG_REGISTROEXPORTACAO_Name = 'STG_REGISTROEXPORTACAO';

    [Restrictions([NoValidate])]
    [Column('STG_DATAREGISTROEXPORTACAO', ftDateTime)]
    [Dictionary('STG_DATAREGISTROEXPORTACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property STG_DATAREGISTROEXPORTACAO: TDateTime read FSTG_DATAREGISTROEXPORTACAO write FSTG_DATAREGISTROEXPORTACAO;
    const STG_DATAREGISTROEXPORTACAO_Name = 'STG_DATAREGISTROEXPORTACAO';

    [Restrictions([NoValidate])]
    [Column('STG_CONHECIMENTOEMBARQUE', ftString, 16)]
    [Dictionary('STG_CONHECIMENTOEMBARQUE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property STG_CONHECIMENTOEMBARQUE: String read FSTG_CONHECIMENTOEMBARQUE write FSTG_CONHECIMENTOEMBARQUE;
    const STG_CONHECIMENTOEMBARQUE_Name = 'STG_CONHECIMENTOEMBARQUE';

    [Restrictions([NoValidate])]
    [Column('STG_DATACONHECIMENTOEMBARQUE', ftDateTime)]
    [Dictionary('STG_DATACONHECIMENTOEMBARQUE', 'Mensagem de validação', '', '', '', taCenter)]
    property STG_DATACONHECIMENTOEMBARQUE: TDateTime read FSTG_DATACONHECIMENTOEMBARQUE write FSTG_DATACONHECIMENTOEMBARQUE;
    const STG_DATACONHECIMENTOEMBARQUE_Name = 'STG_DATACONHECIMENTOEMBARQUE';

    [Restrictions([NoValidate])]
    [Column('STG_DATAAVERBACAODECLARACAO', ftDateTime)]
    [Dictionary('STG_DATAAVERBACAODECLARACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property STG_DATAAVERBACAODECLARACAO: TDateTime read FSTG_DATAAVERBACAODECLARACAO write FSTG_DATAAVERBACAODECLARACAO;
    const STG_DATAAVERBACAODECLARACAO_Name = 'STG_DATAAVERBACAODECLARACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PAI_CODIGOSISCOMEX', ftString, 1)]
    [Dictionary('PAI_CODIGOSISCOMEX', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PAI_CODIGOSISCOMEX: String read FPAI_CODIGOSISCOMEX write FPAI_CODIGOSISCOMEX;
    const PAI_CODIGOSISCOMEX_Name = 'PAI_CODIGOSISCOMEX';

    [Restrictions([NoValidate])]
    [Column('LFS_DATAEMISSAO', ftDateTime)]
    [Dictionary('LFS_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property LFS_DATAEMISSAO: TDateTime read FLFS_DATAEMISSAO write FLFS_DATAEMISSAO;
    const LFS_DATAEMISSAO_Name = 'LFS_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('STG_NOTAFISCAL', ftString, 9)]
    [Dictionary('STG_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property STG_NOTAFISCAL: String read FSTG_NOTAFISCAL write FSTG_NOTAFISCAL;
    const STG_NOTAFISCAL_Name = 'STG_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('STG_SERIE', ftString, 3)]
    [Dictionary('STG_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property STG_SERIE: String read FSTG_SERIE write FSTG_SERIE;
    const STG_SERIE_Name = 'STG_SERIE';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSTG_REGISTRO85)

end.
