unit Dto.GROUP_COMPANY;

interface

uses
  System.SysUtils, 
  System.Classes, 
  Vcl.Graphics, 
  Data.DB, 
  Generics.Collections, 

  //goxormbr 
  goxormbr.core.consts,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes,
  //Application 
  Core.Mapping.Attributes;

type
  [Entity]
  [Table('GROUP_COMPANY', '')]
  [PrimaryKey('GRC_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_GRC_CODIGO')]
  TDtoGROUP_COMPANY = class
  private
    { Private declarations } 
    FGRC_CODIGO: Integer;
    FGRC_DESCRICAO: String;
    FACC_CODIGO_PROPRIETARIO: Integer;
    FGRC_DATAHORAALTERACAO: TDateTime;
  public 
    { Public declarations } 
    const Table      = 'GROUP_COMPANY';
    const PrimaryKey = 'GRC_CODIGO';
    const Sequence   = 'SEQ_GRC_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('GRC_CODIGO', ftInteger)]
    [ColumnDBGrid('GRC_CODIGO', 'GRC_CODIGO', 50, 'Arial', 12, clWindowText, taCenter)]
    [Dictionary('GRC_CODIGO', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property GRC_CODIGO: Integer read FGRC_CODIGO write FGRC_CODIGO;

    [Restrictions([NoValidate])]
    [Column('GRC_DESCRICAO', ftString, 100)]
    [ColumnDBGrid('GRC_DESCRICAO', 'GRC_DESCRICAO', 50, 'Arial', 12, clWindowText, taLeftJustify)]
    [Dictionary('GRC_DESCRICAO', 'Divergente do valor esperado.', '', '', '', taLeftJustify)]
    property GRC_DESCRICAO: String read FGRC_DESCRICAO write FGRC_DESCRICAO;

    [Restrictions([NoValidate, NotNull])]
    [Column('ACC_CODIGO_PROPRIETARIO', ftInteger)]
    [ColumnDBGrid('ACC_CODIGO_PROPRIETARIO', 'ACC_CODIGO_PROPRIETARIO', 50, 'Arial', 12, clWindowText, taCenter)]
    [Dictionary('ACC_CODIGO_PROPRIETARIO', 'Divergente do valor esperado.', '0', '', '', taCenter)]
    property ACC_CODIGO_PROPRIETARIO: Integer read FACC_CODIGO_PROPRIETARIO write FACC_CODIGO_PROPRIETARIO;

    [Restrictions([NoValidate])]
    [Column('GRC_DATAHORAALTERACAO', ftDateTime)]
    [ColumnDBGrid('GRC_DATAHORAALTERACAO', 'GRC_DATAHORAALTERACAO', 50, 'Arial', 12, clWindowText, taCenter)]
    [Dictionary('GRC_DATAHORAALTERACAO', 'Divergente do valor esperado.', '', '', '', taCenter)]
    property GRC_DATAHORAALTERACAO: TDateTime read FGRC_DATAHORAALTERACAO write FGRC_DATAHORAALTERACAO;
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoGROUP_COMPANY)

end.
