unit express.dbo.VW_PSQ_DSP;

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
  [Table('VW_PSQ_DSP', '')]
  TDtoVW_PSQ_DSP = class
  private
    { Private declarations } 
    FDSP_CODIGO: Integer;
    FDSP_DESCRICAO: String;
    FDSP_TIPODESPESA: Integer;
    FDSP_DESATIVADO: String;
    FDSP_DC: String;
    FDSP_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_DSP';

    [Restrictions([NoValidate, NotNull])]
    [Column('DSP_CODIGO', ftInteger)]
    [Dictionary('DSP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property DSP_CODIGO: Integer read FDSP_CODIGO write FDSP_CODIGO;
    const DSP_CODIGO_Name = 'DSP_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DSP_DESCRICAO', ftString, 300)]
    [Dictionary('DSP_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DSP_DESCRICAO: String read FDSP_DESCRICAO write FDSP_DESCRICAO;
    const DSP_DESCRICAO_Name = 'DSP_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('DSP_TIPODESPESA', ftInteger)]
    [Dictionary('DSP_TIPODESPESA', 'Mensagem de validação', '0', '', '', taCenter)]
    property DSP_TIPODESPESA: Integer read FDSP_TIPODESPESA write FDSP_TIPODESPESA;
    const DSP_TIPODESPESA_Name = 'DSP_TIPODESPESA';

    [Restrictions([NoValidate, NotNull])]
    [Column('DSP_DESATIVADO', ftString, 1)]
    [Dictionary('DSP_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DSP_DESATIVADO: String read FDSP_DESATIVADO write FDSP_DESATIVADO;
    const DSP_DESATIVADO_Name = 'DSP_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('DSP_DC', ftString, 1)]
    [Dictionary('DSP_DC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DSP_DC: String read FDSP_DC write FDSP_DC;
    const DSP_DC_Name = 'DSP_DC';

    [Restrictions([NoValidate, NotNull])]
    [Column('DSP_DATAALTERACAO', ftDateTime)]
    [Dictionary('DSP_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property DSP_DATAALTERACAO: TDateTime read FDSP_DATAALTERACAO write FDSP_DATAALTERACAO;
    const DSP_DATAALTERACAO_Name = 'DSP_DATAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_DSP)

end.
