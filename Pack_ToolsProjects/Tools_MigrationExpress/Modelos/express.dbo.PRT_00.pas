unit express.dbo.PRT_00;

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
  [Table('PRT_00', '')]
  [PrimaryKey('PRT_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PRT_ID')]
  TDtoPRT_00 = class
  private
    { Private declarations } 
    FPRT_ID: Integer;
    FCOM_CODIGO: Integer;
    FFOR_CODIGO: Integer;
    FPRT_DATALANCAMENTO: TDateTime;
    FPRT_VEICULODESCRICAO: String;
    FPRT_DESCRICAOSIMPLIFICADA: String;
    FPRT_KILOMETRAGEMANTERIOR: Integer;
    FPRT_KILOMETRAGEM: Integer;
    FPRT_VALORESTIMADOFRETE: Double;
    FPRT_QUANTIDADETOTAL: Double;
    FPRT_VALORTOTAL: Double;
    FPRT_NUMERODOCUMENTO: String;
    FPRT_VEICULOPLACA: String;
    FPRT_DESATIVADO: String;
    FPRT_DATAALTERACAO: TDateTime;
    FPRT_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'PRT_00';
     const PrimaryKey = 'PRT_ID';
     const Sequence   = 'SEQ_PRT_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRT_ID', ftInteger)]
    [Dictionary('PRT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRT_ID: Integer read FPRT_ID write FPRT_ID;
    const PRT_ID_Name = 'PRT_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FOR_CODIGO', ftInteger)]
    [Dictionary('FOR_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FOR_CODIGO: Integer read FFOR_CODIGO write FFOR_CODIGO;
    const FOR_CODIGO_Name = 'FOR_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRT_DATALANCAMENTO', ftDateTime)]
    [Dictionary('PRT_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property PRT_DATALANCAMENTO: TDateTime read FPRT_DATALANCAMENTO write FPRT_DATALANCAMENTO;
    const PRT_DATALANCAMENTO_Name = 'PRT_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('PRT_VEICULODESCRICAO', ftString, 100)]
    [Dictionary('PRT_VEICULODESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRT_VEICULODESCRICAO: String read FPRT_VEICULODESCRICAO write FPRT_VEICULODESCRICAO;
    const PRT_VEICULODESCRICAO_Name = 'PRT_VEICULODESCRICAO';

    [Restrictions([NoValidate])]
    [Column('PRT_DESCRICAOSIMPLIFICADA', ftString, 100)]
    [Dictionary('PRT_DESCRICAOSIMPLIFICADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRT_DESCRICAOSIMPLIFICADA: String read FPRT_DESCRICAOSIMPLIFICADA write FPRT_DESCRICAOSIMPLIFICADA;
    const PRT_DESCRICAOSIMPLIFICADA_Name = 'PRT_DESCRICAOSIMPLIFICADA';

    [Restrictions([NoValidate])]
    [Column('PRT_KILOMETRAGEMANTERIOR', ftInteger)]
    [Dictionary('PRT_KILOMETRAGEMANTERIOR', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRT_KILOMETRAGEMANTERIOR: Integer read FPRT_KILOMETRAGEMANTERIOR write FPRT_KILOMETRAGEMANTERIOR;
    const PRT_KILOMETRAGEMANTERIOR_Name = 'PRT_KILOMETRAGEMANTERIOR';

    [Restrictions([NoValidate])]
    [Column('PRT_KILOMETRAGEM', ftInteger)]
    [Dictionary('PRT_KILOMETRAGEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRT_KILOMETRAGEM: Integer read FPRT_KILOMETRAGEM write FPRT_KILOMETRAGEM;
    const PRT_KILOMETRAGEM_Name = 'PRT_KILOMETRAGEM';

    [Restrictions([NoValidate])]
    [Column('PRT_VALORESTIMADOFRETE', ftBCD, 539780974, 2)]
    [Dictionary('PRT_VALORESTIMADOFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRT_VALORESTIMADOFRETE: Double read FPRT_VALORESTIMADOFRETE write FPRT_VALORESTIMADOFRETE;
    const PRT_VALORESTIMADOFRETE_Name = 'PRT_VALORESTIMADOFRETE';

    [Restrictions([NoValidate])]
    [Column('PRT_QUANTIDADETOTAL', ftBCD, 1869770784, 2)]
    [Dictionary('PRT_QUANTIDADETOTAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRT_QUANTIDADETOTAL: Double read FPRT_QUANTIDADETOTAL write FPRT_QUANTIDADETOTAL;
    const PRT_QUANTIDADETOTAL_Name = 'PRT_QUANTIDADETOTAL';

    [Restrictions([NoValidate])]
    [Column('PRT_VALORTOTAL', ftBCD, 1529377646, 2)]
    [Dictionary('PRT_VALORTOTAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRT_VALORTOTAL: Double read FPRT_VALORTOTAL write FPRT_VALORTOTAL;
    const PRT_VALORTOTAL_Name = 'PRT_VALORTOTAL';

    [Restrictions([NoValidate])]
    [Column('PRT_NUMERODOCUMENTO', ftString, 9)]
    [Dictionary('PRT_NUMERODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRT_NUMERODOCUMENTO: String read FPRT_NUMERODOCUMENTO write FPRT_NUMERODOCUMENTO;
    const PRT_NUMERODOCUMENTO_Name = 'PRT_NUMERODOCUMENTO';

    [Restrictions([NoValidate])]
    [Column('PRT_VEICULOPLACA', ftString, 7)]
    [Dictionary('PRT_VEICULOPLACA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRT_VEICULOPLACA: String read FPRT_VEICULOPLACA write FPRT_VEICULOPLACA;
    const PRT_VEICULOPLACA_Name = 'PRT_VEICULOPLACA';

    [Restrictions([NoValidate])]
    [Column('PRT_DESATIVADO', ftString, 1)]
    [Dictionary('PRT_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRT_DESATIVADO: String read FPRT_DESATIVADO write FPRT_DESATIVADO;
    const PRT_DESATIVADO_Name = 'PRT_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('PRT_DATAALTERACAO', ftDateTime)]
    [Dictionary('PRT_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property PRT_DATAALTERACAO: TDateTime read FPRT_DATAALTERACAO write FPRT_DATAALTERACAO;
    const PRT_DATAALTERACAO_Name = 'PRT_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('PRT_ID_OLD', ftInteger)]
    [Dictionary('PRT_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRT_ID_OLD: Integer read FPRT_ID_OLD write FPRT_ID_OLD;
    const PRT_ID_OLD_Name = 'PRT_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPRT_00)

end.
