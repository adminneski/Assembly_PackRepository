unit express.dbo.CST_00;

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
  [Table('CST_00', '')]
  [PrimaryKey('CST_CODIGO', AutoInc, NoSort, False, 'Chave prim�ria')]
  [Sequence('SEQ_CST_CODIGO')]
  TDtoCST_00 = class
  private
    { Private declarations } 
    FCST_CODIGO: String;
    FCST_DESCRICAO: String;
    FCST_ISENTO: String;
    FCST_SERVICO: String;
    FCST_SUBSTITUICAO: String;
    FCST_REDUCAO: String;
    FCST_DESCONTO: String;
    FCST_TRIBUTADO: String;
    FCST_SUSPENSODIFERIDO: String;
    FCST_DATAALTERACAO: TDateTime;
    FCST_DESATIVADO: String;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'CST_00';
     const PrimaryKey = 'CST_CODIGO';
     const Sequence   = 'SEQ_CST_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CST_CODIGO', ftString, 2)]
    [Dictionary('CST_CODIGO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property CST_CODIGO: String read FCST_CODIGO write FCST_CODIGO;
    const CST_CODIGO_Name = 'CST_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CST_DESCRICAO', ftString, 50)]
    [Dictionary('CST_DESCRICAO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property CST_DESCRICAO: String read FCST_DESCRICAO write FCST_DESCRICAO;
    const CST_DESCRICAO_Name = 'CST_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CST_ISENTO', ftString, 1)]
    [Dictionary('CST_ISENTO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property CST_ISENTO: String read FCST_ISENTO write FCST_ISENTO;
    const CST_ISENTO_Name = 'CST_ISENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CST_SERVICO', ftString, 1)]
    [Dictionary('CST_SERVICO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property CST_SERVICO: String read FCST_SERVICO write FCST_SERVICO;
    const CST_SERVICO_Name = 'CST_SERVICO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CST_SUBSTITUICAO', ftString, 1)]
    [Dictionary('CST_SUBSTITUICAO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property CST_SUBSTITUICAO: String read FCST_SUBSTITUICAO write FCST_SUBSTITUICAO;
    const CST_SUBSTITUICAO_Name = 'CST_SUBSTITUICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CST_REDUCAO', ftString, 1)]
    [Dictionary('CST_REDUCAO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property CST_REDUCAO: String read FCST_REDUCAO write FCST_REDUCAO;
    const CST_REDUCAO_Name = 'CST_REDUCAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CST_DESCONTO', ftString, 1)]
    [Dictionary('CST_DESCONTO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property CST_DESCONTO: String read FCST_DESCONTO write FCST_DESCONTO;
    const CST_DESCONTO_Name = 'CST_DESCONTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CST_TRIBUTADO', ftString, 1)]
    [Dictionary('CST_TRIBUTADO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property CST_TRIBUTADO: String read FCST_TRIBUTADO write FCST_TRIBUTADO;
    const CST_TRIBUTADO_Name = 'CST_TRIBUTADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CST_SUSPENSODIFERIDO', ftString, 1)]
    [Dictionary('CST_SUSPENSODIFERIDO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property CST_SUSPENSODIFERIDO: String read FCST_SUSPENSODIFERIDO write FCST_SUSPENSODIFERIDO;
    const CST_SUSPENSODIFERIDO_Name = 'CST_SUSPENSODIFERIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CST_DATAALTERACAO', ftDateTime)]
    [Dictionary('CST_DATAALTERACAO', 'Mensagem de valida��o', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CST_DATAALTERACAO: TDateTime read FCST_DATAALTERACAO write FCST_DATAALTERACAO;
    const CST_DATAALTERACAO_Name = 'CST_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CST_DESATIVADO', ftString, 1)]
    [Dictionary('CST_DESATIVADO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property CST_DESATIVADO: String read FCST_DESATIVADO write FCST_DESATIVADO;
    const CST_DESATIVADO_Name = 'CST_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCST_00)

end.
