unit express.dbo.CSTPC_00;

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
  [Table('CSTPC_00', '')]
  [PrimaryKey('CSTPC_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CSTPC_CODIGO')]
  TDtoCSTPC_00 = class
  private
    { Private declarations } 
    FCSTPC_CODIGO: String;
    FCSTPC_DESCRICAO: String;
    FCSTPC_DESATIVADO: String;
    FCSTPC_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
    FCSTPC_TRIBUTADO: String;
  public 
    { Public declarations } 
     const Table      = 'CSTPC_00';
     const PrimaryKey = 'CSTPC_CODIGO';
     const Sequence   = 'SEQ_CSTPC_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CSTPC_CODIGO', ftString, 2)]
    [Dictionary('CSTPC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_CODIGO: String read FCSTPC_CODIGO write FCSTPC_CODIGO;
    const CSTPC_CODIGO_Name = 'CSTPC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CSTPC_DESCRICAO', ftString, 300)]
    [Dictionary('CSTPC_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_DESCRICAO: String read FCSTPC_DESCRICAO write FCSTPC_DESCRICAO;
    const CSTPC_DESCRICAO_Name = 'CSTPC_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('CSTPC_DESATIVADO', ftString, 1)]
    [Dictionary('CSTPC_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_DESATIVADO: String read FCSTPC_DESATIVADO write FCSTPC_DESATIVADO;
    const CSTPC_DESATIVADO_Name = 'CSTPC_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('CSTPC_DATAALTERACAO', ftDateTime)]
    [Dictionary('CSTPC_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CSTPC_DATAALTERACAO: TDateTime read FCSTPC_DATAALTERACAO write FCSTPC_DATAALTERACAO;
    const CSTPC_DATAALTERACAO_Name = 'CSTPC_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CSTPC_TRIBUTADO', ftString, 1)]
    [Dictionary('CSTPC_TRIBUTADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_TRIBUTADO: String read FCSTPC_TRIBUTADO write FCSTPC_TRIBUTADO;
    const CSTPC_TRIBUTADO_Name = 'CSTPC_TRIBUTADO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCSTPC_00)

end.
