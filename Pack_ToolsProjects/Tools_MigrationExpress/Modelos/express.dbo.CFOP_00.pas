unit express.dbo.CFOP_00;

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
  [Table('CFOP_00', '')]
  [PrimaryKey('CFOP_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CFOP_CODIGO')]
  TDtoCFOP_00 = class
  private
    { Private declarations } 
    FCFOP_CODIGO: String;
    FCFOP_TIPO: String;
    FCFOP_DESCRICAO: String;
    FCFOP_NOMEAPELIDO: String;
    FCFOP_OBSERVACAO: String;
    FCFOP_DESATIVADO: String;
    FCFOP_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'CFOP_00';
     const PrimaryKey = 'CFOP_CODIGO';
     const Sequence   = 'SEQ_CFOP_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CFOP_TIPO', ftString, 1)]
    [Dictionary('CFOP_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_TIPO: String read FCFOP_TIPO write FCFOP_TIPO;
    const CFOP_TIPO_Name = 'CFOP_TIPO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CFOP_DESCRICAO', ftString, 300)]
    [Dictionary('CFOP_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_DESCRICAO: String read FCFOP_DESCRICAO write FCFOP_DESCRICAO;
    const CFOP_DESCRICAO_Name = 'CFOP_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('CFOP_NOMEAPELIDO', ftString, 25)]
    [Dictionary('CFOP_NOMEAPELIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_NOMEAPELIDO: String read FCFOP_NOMEAPELIDO write FCFOP_NOMEAPELIDO;
    const CFOP_NOMEAPELIDO_Name = 'CFOP_NOMEAPELIDO';

    [Restrictions([NoValidate])]
    [Column('CFOP_OBSERVACAO', ftString, 1000)]
    [Dictionary('CFOP_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_OBSERVACAO: String read FCFOP_OBSERVACAO write FCFOP_OBSERVACAO;
    const CFOP_OBSERVACAO_Name = 'CFOP_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CFOP_DESATIVADO', ftString, 1)]
    [Dictionary('CFOP_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_DESATIVADO: String read FCFOP_DESATIVADO write FCFOP_DESATIVADO;
    const CFOP_DESATIVADO_Name = 'CFOP_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CFOP_DATAALTERACAO', ftDateTime)]
    [Dictionary('CFOP_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CFOP_DATAALTERACAO: TDateTime read FCFOP_DATAALTERACAO write FCFOP_DATAALTERACAO;
    const CFOP_DATAALTERACAO_Name = 'CFOP_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCFOP_00)

end.
