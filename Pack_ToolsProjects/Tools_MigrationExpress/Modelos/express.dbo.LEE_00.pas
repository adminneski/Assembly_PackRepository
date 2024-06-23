unit express.dbo.LEE_00;

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
  [Table('LEE_00', '')]
  [PrimaryKey('LEE_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_LEE_CODIGO')]
  TDtoLEE_00 = class
  private
    { Private declarations } 
    FLEE_CODIGO: Integer;
    FLEE_DESCRICAO: String;
    FLEE_TIPOCLIENTE: String;
    FLEE_TIPOEMPRESA: String;
    FLEE_SIMBOLO: String;
    FLEE_COMENTARIO: String;
    FLEE_DATAINICIAL: TDateTime;
    FLEE_DATAFINAL: TDateTime;
    FLEE_DESTAQUE_NF: String;
    FLEE_UF: String;
    FLEE_DESATIVADO: String;
    FLEE_DATAALTERACAO: TDateTime;
    FLEE_DESCTO_CONV_10097: String;
    FLEE_INFADFISCO: String;
    FLEE_ABATEDESCTOBCST: String;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'LEE_00';
     const PrimaryKey = 'LEE_CODIGO';
     const Sequence   = 'SEQ_LEE_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LEE_CODIGO', ftInteger)]
    [Dictionary('LEE_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEE_CODIGO: Integer read FLEE_CODIGO write FLEE_CODIGO;
    const LEE_CODIGO_Name = 'LEE_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LEE_DESCRICAO', ftString, 100)]
    [Dictionary('LEE_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEE_DESCRICAO: String read FLEE_DESCRICAO write FLEE_DESCRICAO;
    const LEE_DESCRICAO_Name = 'LEE_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LEE_TIPOCLIENTE', ftString, 4)]
    [Dictionary('LEE_TIPOCLIENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEE_TIPOCLIENTE: String read FLEE_TIPOCLIENTE write FLEE_TIPOCLIENTE;
    const LEE_TIPOCLIENTE_Name = 'LEE_TIPOCLIENTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('LEE_TIPOEMPRESA', ftString, 4)]
    [Dictionary('LEE_TIPOEMPRESA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEE_TIPOEMPRESA: String read FLEE_TIPOEMPRESA write FLEE_TIPOEMPRESA;
    const LEE_TIPOEMPRESA_Name = 'LEE_TIPOEMPRESA';

    [Restrictions([NoValidate, NotNull])]
    [Column('LEE_SIMBOLO', ftString, 1)]
    [Dictionary('LEE_SIMBOLO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEE_SIMBOLO: String read FLEE_SIMBOLO write FLEE_SIMBOLO;
    const LEE_SIMBOLO_Name = 'LEE_SIMBOLO';

    [Restrictions([NoValidate])]
    [Column('LEE_COMENTARIO', ftString, 300)]
    [Dictionary('LEE_COMENTARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEE_COMENTARIO: String read FLEE_COMENTARIO write FLEE_COMENTARIO;
    const LEE_COMENTARIO_Name = 'LEE_COMENTARIO';

    [Restrictions([NoValidate])]
    [Column('LEE_DATAINICIAL', ftDateTime)]
    [Dictionary('LEE_DATAINICIAL', 'Mensagem de validação', '', '', '', taCenter)]
    property LEE_DATAINICIAL: TDateTime read FLEE_DATAINICIAL write FLEE_DATAINICIAL;
    const LEE_DATAINICIAL_Name = 'LEE_DATAINICIAL';

    [Restrictions([NoValidate])]
    [Column('LEE_DATAFINAL', ftDateTime)]
    [Dictionary('LEE_DATAFINAL', 'Mensagem de validação', '', '', '', taCenter)]
    property LEE_DATAFINAL: TDateTime read FLEE_DATAFINAL write FLEE_DATAFINAL;
    const LEE_DATAFINAL_Name = 'LEE_DATAFINAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('LEE_DESTAQUE_NF', ftString, 1)]
    [Dictionary('LEE_DESTAQUE_NF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEE_DESTAQUE_NF: String read FLEE_DESTAQUE_NF write FLEE_DESTAQUE_NF;
    const LEE_DESTAQUE_NF_Name = 'LEE_DESTAQUE_NF';

    [Restrictions([NoValidate])]
    [Column('LEE_UF', ftString, 2)]
    [Dictionary('LEE_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEE_UF: String read FLEE_UF write FLEE_UF;
    const LEE_UF_Name = 'LEE_UF';

    [Restrictions([NoValidate, NotNull])]
    [Column('LEE_DESATIVADO', ftString, 1)]
    [Dictionary('LEE_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEE_DESATIVADO: String read FLEE_DESATIVADO write FLEE_DESATIVADO;
    const LEE_DESATIVADO_Name = 'LEE_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LEE_DATAALTERACAO', ftDateTime)]
    [Dictionary('LEE_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property LEE_DATAALTERACAO: TDateTime read FLEE_DATAALTERACAO write FLEE_DATAALTERACAO;
    const LEE_DATAALTERACAO_Name = 'LEE_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('LEE_DESCTO_CONV_10097', ftString, 1)]
    [Dictionary('LEE_DESCTO_CONV_10097', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEE_DESCTO_CONV_10097: String read FLEE_DESCTO_CONV_10097 write FLEE_DESCTO_CONV_10097;
    const LEE_DESCTO_CONV_10097_Name = 'LEE_DESCTO_CONV_10097';

    [Restrictions([NoValidate])]
    [Column('LEE_INFADFISCO', ftString, 2000)]
    [Dictionary('LEE_INFADFISCO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEE_INFADFISCO: String read FLEE_INFADFISCO write FLEE_INFADFISCO;
    const LEE_INFADFISCO_Name = 'LEE_INFADFISCO';

    [Restrictions([NoValidate])]
    [Column('LEE_ABATEDESCTOBCST', ftString, 1)]
    [Dictionary('LEE_ABATEDESCTOBCST', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEE_ABATEDESCTOBCST: String read FLEE_ABATEDESCTOBCST write FLEE_ABATEDESCTOBCST;
    const LEE_ABATEDESCTOBCST_Name = 'LEE_ABATEDESCTOBCST';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoLEE_00)

end.
