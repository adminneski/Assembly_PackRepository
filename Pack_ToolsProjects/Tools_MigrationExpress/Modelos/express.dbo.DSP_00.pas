unit express.dbo.DSP_00;

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
  [Table('DSP_00', '')]
  [PrimaryKey('DSP_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_DSP_CODIGO')]
  TDtoDSP_00 = class
  private
    { Private declarations } 
    FDSP_CODIGO: Integer;
    FDSP_DESCRICAO: String;
    FDSP_DESATIVADO: String;
    FDSP_DATAALTERACAO: TDateTime;
    FDSP_DC: String;
    FDSP_TIPODESPESA: Integer;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'DSP_00';
     const PrimaryKey = 'DSP_CODIGO';
     const Sequence   = 'SEQ_DSP_CODIGO';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('DSP_DESATIVADO', ftString, 1)]
    [Dictionary('DSP_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DSP_DESATIVADO: String read FDSP_DESATIVADO write FDSP_DESATIVADO;
    const DSP_DESATIVADO_Name = 'DSP_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('DSP_DATAALTERACAO', ftDateTime)]
    [Dictionary('DSP_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property DSP_DATAALTERACAO: TDateTime read FDSP_DATAALTERACAO write FDSP_DATAALTERACAO;
    const DSP_DATAALTERACAO_Name = 'DSP_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('DSP_DC', ftString, 1)]
    [Dictionary('DSP_DC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DSP_DC: String read FDSP_DC write FDSP_DC;
    const DSP_DC_Name = 'DSP_DC';

    [Restrictions([NoValidate])]
    [Column('DSP_TIPODESPESA', ftInteger)]
    [Dictionary('DSP_TIPODESPESA', 'Mensagem de validação', '0', '', '', taCenter)]
    property DSP_TIPODESPESA: Integer read FDSP_TIPODESPESA write FDSP_TIPODESPESA;
    const DSP_TIPODESPESA_Name = 'DSP_TIPODESPESA';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoDSP_00)

end.
