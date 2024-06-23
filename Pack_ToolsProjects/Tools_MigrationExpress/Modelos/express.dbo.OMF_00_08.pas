unit express.dbo.OMF_00_08;

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
  [Table('OMF_00_08', '')]
  [PrimaryKey('OMF_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_OMF_ID')]
  TDtoOMF_00_08 = class
  private
    { Private declarations } 
    FOMF_ID: Integer;
    FCOM_CODIGO: Integer;
    FOMF_DECLARACAOEXPORTACAO: String;
    FOMF_DATADECLARACAOEXPORTACAO: TDateTime;
    FOMF_NATUREZAOPERACAO: String;
    FOMF_REGISTROEXPORTACAO: String;
    FOMF_DATAREGISTROEXPORTACAO: TDateTime;
    FOMF_CONHECIMENTOEMBARQUE: String;
    FOMF_DATACONHECIMENTOEMBARQUE: TDateTime;
    FOMF_TIPOCONHECIMENTO: String;
    FOMF_CODIGOPAIS: String;
    FOMF_COMPROVANTEEXPORTACAO: String;
    FOMF_DATACOMPROVANTEEXPORTACAO: TDateTime;
    FOMF_DATAALTERACAO: TDateTime;
    FOMF_INTEGRACAOERP: String;
    FOMF_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'OMF_00_08';
    const PrimaryKey = 'OMF_ID';
    const Sequence   = 'SEQ_OMF_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_ID', ftInteger)]
    [ForeignKey('OMF_00_08_fk', 'OMF_ID', 'OMF_00', 'OMF_ID', SetNull, SetNull)]
    [Dictionary('OMF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_ID: Integer read FOMF_ID write FOMF_ID;
    const OMF_ID_Name = 'OMF_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('OMF_DECLARACAOEXPORTACAO', ftString, 11)]
    [Dictionary('OMF_DECLARACAOEXPORTACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_DECLARACAOEXPORTACAO: String read FOMF_DECLARACAOEXPORTACAO write FOMF_DECLARACAOEXPORTACAO;
    const OMF_DECLARACAOEXPORTACAO_Name = 'OMF_DECLARACAOEXPORTACAO';

    [Restrictions([NoValidate])]
    [Column('OMF_DATADECLARACAOEXPORTACAO', ftDateTime)]
    [Dictionary('OMF_DATADECLARACAOEXPORTACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property OMF_DATADECLARACAOEXPORTACAO: TDateTime read FOMF_DATADECLARACAOEXPORTACAO write FOMF_DATADECLARACAOEXPORTACAO;
    const OMF_DATADECLARACAOEXPORTACAO_Name = 'OMF_DATADECLARACAOEXPORTACAO';

    [Restrictions([NoValidate])]
    [Column('OMF_NATUREZAOPERACAO', ftString, 1)]
    [Dictionary('OMF_NATUREZAOPERACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_NATUREZAOPERACAO: String read FOMF_NATUREZAOPERACAO write FOMF_NATUREZAOPERACAO;
    const OMF_NATUREZAOPERACAO_Name = 'OMF_NATUREZAOPERACAO';

    [Restrictions([NoValidate])]
    [Column('OMF_REGISTROEXPORTACAO', ftString, 12)]
    [Dictionary('OMF_REGISTROEXPORTACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_REGISTROEXPORTACAO: String read FOMF_REGISTROEXPORTACAO write FOMF_REGISTROEXPORTACAO;
    const OMF_REGISTROEXPORTACAO_Name = 'OMF_REGISTROEXPORTACAO';

    [Restrictions([NoValidate])]
    [Column('OMF_DATAREGISTROEXPORTACAO', ftDateTime)]
    [Dictionary('OMF_DATAREGISTROEXPORTACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property OMF_DATAREGISTROEXPORTACAO: TDateTime read FOMF_DATAREGISTROEXPORTACAO write FOMF_DATAREGISTROEXPORTACAO;
    const OMF_DATAREGISTROEXPORTACAO_Name = 'OMF_DATAREGISTROEXPORTACAO';

    [Restrictions([NoValidate])]
    [Column('OMF_CONHECIMENTOEMBARQUE', ftString, 16)]
    [Dictionary('OMF_CONHECIMENTOEMBARQUE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_CONHECIMENTOEMBARQUE: String read FOMF_CONHECIMENTOEMBARQUE write FOMF_CONHECIMENTOEMBARQUE;
    const OMF_CONHECIMENTOEMBARQUE_Name = 'OMF_CONHECIMENTOEMBARQUE';

    [Restrictions([NoValidate])]
    [Column('OMF_DATACONHECIMENTOEMBARQUE', ftDateTime)]
    [Dictionary('OMF_DATACONHECIMENTOEMBARQUE', 'Mensagem de validação', '', '', '', taCenter)]
    property OMF_DATACONHECIMENTOEMBARQUE: TDateTime read FOMF_DATACONHECIMENTOEMBARQUE write FOMF_DATACONHECIMENTOEMBARQUE;
    const OMF_DATACONHECIMENTOEMBARQUE_Name = 'OMF_DATACONHECIMENTOEMBARQUE';

    [Restrictions([NoValidate])]
    [Column('OMF_TIPOCONHECIMENTO', ftString, 2)]
    [Dictionary('OMF_TIPOCONHECIMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_TIPOCONHECIMENTO: String read FOMF_TIPOCONHECIMENTO write FOMF_TIPOCONHECIMENTO;
    const OMF_TIPOCONHECIMENTO_Name = 'OMF_TIPOCONHECIMENTO';

    [Restrictions([NoValidate])]
    [Column('OMF_CODIGOPAIS', ftString, 4)]
    [Dictionary('OMF_CODIGOPAIS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_CODIGOPAIS: String read FOMF_CODIGOPAIS write FOMF_CODIGOPAIS;
    const OMF_CODIGOPAIS_Name = 'OMF_CODIGOPAIS';

    [Restrictions([NoValidate])]
    [Column('OMF_COMPROVANTEEXPORTACAO', ftString, 8)]
    [Dictionary('OMF_COMPROVANTEEXPORTACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_COMPROVANTEEXPORTACAO: String read FOMF_COMPROVANTEEXPORTACAO write FOMF_COMPROVANTEEXPORTACAO;
    const OMF_COMPROVANTEEXPORTACAO_Name = 'OMF_COMPROVANTEEXPORTACAO';

    [Restrictions([NoValidate])]
    [Column('OMF_DATACOMPROVANTEEXPORTACAO', ftDateTime)]
    [Dictionary('OMF_DATACOMPROVANTEEXPORTACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property OMF_DATACOMPROVANTEEXPORTACAO: TDateTime read FOMF_DATACOMPROVANTEEXPORTACAO write FOMF_DATACOMPROVANTEEXPORTACAO;
    const OMF_DATACOMPROVANTEEXPORTACAO_Name = 'OMF_DATACOMPROVANTEEXPORTACAO';

    [Restrictions([NoValidate])]
    [Column('OMF_DATAALTERACAO', ftDateTime)]
    [Dictionary('OMF_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property OMF_DATAALTERACAO: TDateTime read FOMF_DATAALTERACAO write FOMF_DATAALTERACAO;
    const OMF_DATAALTERACAO_Name = 'OMF_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('OMF_INTEGRACAOERP', ftString, 20)]
    [Dictionary('OMF_INTEGRACAOERP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property OMF_INTEGRACAOERP: String read FOMF_INTEGRACAOERP write FOMF_INTEGRACAOERP;
    const OMF_INTEGRACAOERP_Name = 'OMF_INTEGRACAOERP';

    [Restrictions([NoValidate])]
    [Column('OMF_ID_OLD', ftInteger)]
    [Dictionary('OMF_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property OMF_ID_OLD: Integer read FOMF_ID_OLD write FOMF_ID_OLD;
    const OMF_ID_OLD_Name = 'OMF_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoOMF_00_08)

end.
