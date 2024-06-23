unit express.dbo.PRZ_SELECIONAFORMAPAGAMENTO;

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
  [Table('PRZ_SelecionaFormaPagamento', '')]
  TDtoPRZ_SelecionaFormaPagamento = class
  private
    { Private declarations } 
    FFPG_CODIGO: Integer;
    FPRZ_CODIGO: Integer;
    FFPG_DESCRICAO: String;
    FFPG_DESATIVADO: String;
    FPRZ_PERCENTUALFINANCEIRO: Double;
    FPRZ_PERCENTUALDESCONTO: Double;
    FPRZ_PERCENTUALDESCONTOMAXIMO: Double;
  public 
    { Public declarations } 
     const Table      = 'PRZ_SelecionaFormaPagamento';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRZ_CODIGO', ftInteger)]
    [Dictionary('PRZ_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRZ_CODIGO: Integer read FPRZ_CODIGO write FPRZ_CODIGO;
    const PRZ_CODIGO_Name = 'PRZ_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FPG_DESCRICAO', ftString, 30)]
    [Dictionary('FPG_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FPG_DESCRICAO: String read FFPG_DESCRICAO write FFPG_DESCRICAO;
    const FPG_DESCRICAO_Name = 'FPG_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('FPG_DESATIVADO', ftString, 1)]
    [Dictionary('FPG_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FPG_DESATIVADO: String read FFPG_DESATIVADO write FFPG_DESATIVADO;
    const FPG_DESATIVADO_Name = 'FPG_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('PRZ_PERCENTUALFINANCEIRO', ftBCD)]
    [Dictionary('PRZ_PERCENTUALFINANCEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRZ_PERCENTUALFINANCEIRO: Double read FPRZ_PERCENTUALFINANCEIRO write FPRZ_PERCENTUALFINANCEIRO;
    const PRZ_PERCENTUALFINANCEIRO_Name = 'PRZ_PERCENTUALFINANCEIRO';

    [Restrictions([NoValidate])]
    [Column('PRZ_PERCENTUALDESCONTO', ftBCD)]
    [Dictionary('PRZ_PERCENTUALDESCONTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRZ_PERCENTUALDESCONTO: Double read FPRZ_PERCENTUALDESCONTO write FPRZ_PERCENTUALDESCONTO;
    const PRZ_PERCENTUALDESCONTO_Name = 'PRZ_PERCENTUALDESCONTO';

    [Restrictions([NoValidate])]
    [Column('PRZ_PERCENTUALDESCONTOMAXIMO', ftBCD)]
    [Dictionary('PRZ_PERCENTUALDESCONTOMAXIMO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRZ_PERCENTUALDESCONTOMAXIMO: Double read FPRZ_PERCENTUALDESCONTOMAXIMO write FPRZ_PERCENTUALDESCONTOMAXIMO;
    const PRZ_PERCENTUALDESCONTOMAXIMO_Name = 'PRZ_PERCENTUALDESCONTOMAXIMO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPRZ_SelecionaFormaPagamento)

end.
