unit express.dbo.MNF_00;

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
  [Table('MNF_00', '')]
  [PrimaryKey('MNF_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_MNF_CODIGO')]
  TDtoMNF_00 = class
  private
    { Private declarations } 
    FMNF_CODIGO: String;
    FMNF_DESCRICAO: String;
    FMNF_DATAALTERACAO: TDateTime;
    FMNF_DESATIVADO: String;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'MNF_00';
     const PrimaryKey = 'MNF_CODIGO';
     const Sequence   = 'SEQ_MNF_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MNF_DESCRICAO', ftString, 100)]
    [Dictionary('MNF_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_DESCRICAO: String read FMNF_DESCRICAO write FMNF_DESCRICAO;
    const MNF_DESCRICAO_Name = 'MNF_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MNF_DATAALTERACAO', ftDateTime)]
    [Dictionary('MNF_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MNF_DATAALTERACAO: TDateTime read FMNF_DATAALTERACAO write FMNF_DATAALTERACAO;
    const MNF_DATAALTERACAO_Name = 'MNF_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MNF_DESATIVADO', ftString, 1)]
    [Dictionary('MNF_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_DESATIVADO: String read FMNF_DESATIVADO write FMNF_DESATIVADO;
    const MNF_DESATIVADO_Name = 'MNF_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoMNF_00)

end.
