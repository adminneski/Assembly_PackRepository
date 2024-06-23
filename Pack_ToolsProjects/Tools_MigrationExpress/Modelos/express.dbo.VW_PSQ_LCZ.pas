unit express.dbo.VW_PSQ_LCZ;

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
  [Table('VW_PSQ_LCZ', '')]
  TDtoVW_PSQ_LCZ = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FLCZ_CODIGO: Integer;
    FLCZ_DESCRICAO: String;
    FLCZ_ETIQUETALOCALIZACAO: String;
    FLCZ_DESATIVADO: String;
    FLCZ_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_LCZ';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LCZ_CODIGO', ftInteger)]
    [Dictionary('LCZ_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LCZ_CODIGO: Integer read FLCZ_CODIGO write FLCZ_CODIGO;
    const LCZ_CODIGO_Name = 'LCZ_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LCZ_DESCRICAO', ftString, 30)]
    [Dictionary('LCZ_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LCZ_DESCRICAO: String read FLCZ_DESCRICAO write FLCZ_DESCRICAO;
    const LCZ_DESCRICAO_Name = 'LCZ_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('LCZ_ETIQUETALOCALIZACAO', ftString, 10)]
    [Dictionary('LCZ_ETIQUETALOCALIZACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LCZ_ETIQUETALOCALIZACAO: String read FLCZ_ETIQUETALOCALIZACAO write FLCZ_ETIQUETALOCALIZACAO;
    const LCZ_ETIQUETALOCALIZACAO_Name = 'LCZ_ETIQUETALOCALIZACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LCZ_DESATIVADO', ftString, 1)]
    [Dictionary('LCZ_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LCZ_DESATIVADO: String read FLCZ_DESATIVADO write FLCZ_DESATIVADO;
    const LCZ_DESATIVADO_Name = 'LCZ_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LCZ_DATAALTERACAO', ftDateTime)]
    [Dictionary('LCZ_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property LCZ_DATAALTERACAO: TDateTime read FLCZ_DATAALTERACAO write FLCZ_DATAALTERACAO;
    const LCZ_DATAALTERACAO_Name = 'LCZ_DATAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_LCZ)

end.
