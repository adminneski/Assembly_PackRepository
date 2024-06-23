unit express.dbo.VW_PSQ_OBJ;

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
  [Table('VW_PSQ_OBJ', '')]
  TDtoVW_PSQ_OBJ = class
  private
    { Private declarations } 
    FVEI_CODIGO: Integer;
    FVEI_DESCRICAO: String;
    FVEI_OBSERVACAO: String;
    FVEI_DESATIVADO: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_OBJ';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEI_CODIGO', ftInteger)]
    [Dictionary('VEI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEI_CODIGO: Integer read FVEI_CODIGO write FVEI_CODIGO;
    const VEI_CODIGO_Name = 'VEI_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEI_DESCRICAO', ftString, 40)]
    [Dictionary('VEI_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_DESCRICAO: String read FVEI_DESCRICAO write FVEI_DESCRICAO;
    const VEI_DESCRICAO_Name = 'VEI_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('VEI_OBSERVACAO', ftString, 300)]
    [Dictionary('VEI_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_OBSERVACAO: String read FVEI_OBSERVACAO write FVEI_OBSERVACAO;
    const VEI_OBSERVACAO_Name = 'VEI_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEI_DESATIVADO', ftString, 1)]
    [Dictionary('VEI_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_DESATIVADO: String read FVEI_DESATIVADO write FVEI_DESATIVADO;
    const VEI_DESATIVADO_Name = 'VEI_DESATIVADO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_OBJ)

end.
