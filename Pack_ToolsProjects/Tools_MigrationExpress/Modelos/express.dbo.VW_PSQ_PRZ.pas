unit express.dbo.VW_PSQ_PRZ;

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
  [Table('VW_PSQ_PRZ', '')]
  TDtoVW_PSQ_PRZ = class
  private
    { Private declarations } 
    FPRZ_CODIGO: Integer;
    FPRZ_DESCRICAO: String;
    FPRZ_PERCENTUALFINANCEIRO: Double;
    FPRZ_PERCENTUALDESCONTO: Double;
    FPRZ_PERCENTUALDESCONTOMAXIMO: Double;
    FPRZ_DESATIVADO: String;
    FPRZ_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_PRZ';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRZ_CODIGO', ftInteger)]
    [Dictionary('PRZ_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRZ_CODIGO: Integer read FPRZ_CODIGO write FPRZ_CODIGO;
    const PRZ_CODIGO_Name = 'PRZ_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRZ_DESCRICAO', ftString, 30)]
    [Dictionary('PRZ_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRZ_DESCRICAO: String read FPRZ_DESCRICAO write FPRZ_DESCRICAO;
    const PRZ_DESCRICAO_Name = 'PRZ_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRZ_PERCENTUALFINANCEIRO', ftBCD)]
    [Dictionary('PRZ_PERCENTUALFINANCEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRZ_PERCENTUALFINANCEIRO: Double read FPRZ_PERCENTUALFINANCEIRO write FPRZ_PERCENTUALFINANCEIRO;
    const PRZ_PERCENTUALFINANCEIRO_Name = 'PRZ_PERCENTUALFINANCEIRO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRZ_PERCENTUALDESCONTO', ftBCD)]
    [Dictionary('PRZ_PERCENTUALDESCONTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRZ_PERCENTUALDESCONTO: Double read FPRZ_PERCENTUALDESCONTO write FPRZ_PERCENTUALDESCONTO;
    const PRZ_PERCENTUALDESCONTO_Name = 'PRZ_PERCENTUALDESCONTO';

    [Restrictions([NoValidate])]
    [Column('PRZ_PERCENTUALDESCONTOMAXIMO', ftBCD, 10, 2)]
    [Dictionary('PRZ_PERCENTUALDESCONTOMAXIMO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRZ_PERCENTUALDESCONTOMAXIMO: Double read FPRZ_PERCENTUALDESCONTOMAXIMO write FPRZ_PERCENTUALDESCONTOMAXIMO;
    const PRZ_PERCENTUALDESCONTOMAXIMO_Name = 'PRZ_PERCENTUALDESCONTOMAXIMO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRZ_DESATIVADO', ftString, 1)]
    [Dictionary('PRZ_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRZ_DESATIVADO: String read FPRZ_DESATIVADO write FPRZ_DESATIVADO;
    const PRZ_DESATIVADO_Name = 'PRZ_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRZ_DATAALTERACAO', ftDateTime)]
    [Dictionary('PRZ_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PRZ_DATAALTERACAO: TDateTime read FPRZ_DATAALTERACAO write FPRZ_DATAALTERACAO;
    const PRZ_DATAALTERACAO_Name = 'PRZ_DATAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_PRZ)

end.
