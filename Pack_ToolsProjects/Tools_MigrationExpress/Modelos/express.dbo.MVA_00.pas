unit express.dbo.MVA_00;

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
  [Table('MVA_00', '')]
  [PrimaryKey('MVA_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_MVA_CODIGO')]
  TDtoMVA_00 = class
  private
    { Private declarations } 
    FMVA_CODIGO: Integer;
    FMVA_DESCRICAO: String;
    FMVA_VALORPAUTA: Double;
    FMVA_PERCENTUALACRESCIMO: Double;
    FMVA_DESATIVADO: String;
    FMVA_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'MVA_00';
     const PrimaryKey = 'MVA_CODIGO';
     const Sequence   = 'SEQ_MVA_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MVA_CODIGO', ftInteger)]
    [Dictionary('MVA_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property MVA_CODIGO: Integer read FMVA_CODIGO write FMVA_CODIGO;
    const MVA_CODIGO_Name = 'MVA_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MVA_DESCRICAO', ftString, 30)]
    [Dictionary('MVA_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MVA_DESCRICAO: String read FMVA_DESCRICAO write FMVA_DESCRICAO;
    const MVA_DESCRICAO_Name = 'MVA_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MVA_VALORPAUTA', ftBCD)]
    [Dictionary('MVA_VALORPAUTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MVA_VALORPAUTA: Double read FMVA_VALORPAUTA write FMVA_VALORPAUTA;
    const MVA_VALORPAUTA_Name = 'MVA_VALORPAUTA';

    [Restrictions([NoValidate, NotNull])]
    [Column('MVA_PERCENTUALACRESCIMO', ftBCD, 18, 4)]
    [Dictionary('MVA_PERCENTUALACRESCIMO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MVA_PERCENTUALACRESCIMO: Double read FMVA_PERCENTUALACRESCIMO write FMVA_PERCENTUALACRESCIMO;
    const MVA_PERCENTUALACRESCIMO_Name = 'MVA_PERCENTUALACRESCIMO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MVA_DESATIVADO', ftString, 1)]
    [Dictionary('MVA_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MVA_DESATIVADO: String read FMVA_DESATIVADO write FMVA_DESATIVADO;
    const MVA_DESATIVADO_Name = 'MVA_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MVA_DATAALTERACAO', ftDateTime)]
    [Dictionary('MVA_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MVA_DATAALTERACAO: TDateTime read FMVA_DATAALTERACAO write FMVA_DATAALTERACAO;
    const MVA_DATAALTERACAO_Name = 'MVA_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoMVA_00)

end.
