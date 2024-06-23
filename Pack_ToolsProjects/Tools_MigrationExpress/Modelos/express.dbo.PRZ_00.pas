unit express.dbo.PRZ_00;

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
  [Table('PRZ_00', '')]
  [PrimaryKey('PRZ_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PRZ_CODIGO')]
  TDtoPRZ_00 = class
  private
    { Private declarations } 
    FPRZ_CODIGO: Integer;
    FPRZ_DESCRICAO: String;
    FPRZ_NOMEAPELIDO: String;
    FPRZ_PERCENTUALFINANCEIRO: Double;
    FPRZ_PERCENTUALDESCONTO: Double;
    FPRZ_PERCENTUALDESCONTOMAXIMO: Double;
    FPRZ_GERARPALM: String;
    FPRZ_DESATIVADO: String;
    FPRZ_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'PRZ_00';
     const PrimaryKey = 'PRZ_CODIGO';
     const Sequence   = 'SEQ_PRZ_CODIGO';

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

    [Restrictions([NoValidate])]
    [Column('PRZ_NOMEAPELIDO', ftString, 10)]
    [Dictionary('PRZ_NOMEAPELIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRZ_NOMEAPELIDO: String read FPRZ_NOMEAPELIDO write FPRZ_NOMEAPELIDO;
    const PRZ_NOMEAPELIDO_Name = 'PRZ_NOMEAPELIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRZ_PERCENTUALFINANCEIRO', ftBCD, 539780974, 2)]
    [Dictionary('PRZ_PERCENTUALFINANCEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRZ_PERCENTUALFINANCEIRO: Double read FPRZ_PERCENTUALFINANCEIRO write FPRZ_PERCENTUALFINANCEIRO;
    const PRZ_PERCENTUALFINANCEIRO_Name = 'PRZ_PERCENTUALFINANCEIRO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRZ_PERCENTUALDESCONTO', ftBCD, 1869770784, 2)]
    [Dictionary('PRZ_PERCENTUALDESCONTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRZ_PERCENTUALDESCONTO: Double read FPRZ_PERCENTUALDESCONTO write FPRZ_PERCENTUALDESCONTO;
    const PRZ_PERCENTUALDESCONTO_Name = 'PRZ_PERCENTUALDESCONTO';

    [Restrictions([NoValidate])]
    [Column('PRZ_PERCENTUALDESCONTOMAXIMO', ftBCD, 1529377646, 2)]
    [Dictionary('PRZ_PERCENTUALDESCONTOMAXIMO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRZ_PERCENTUALDESCONTOMAXIMO: Double read FPRZ_PERCENTUALDESCONTOMAXIMO write FPRZ_PERCENTUALDESCONTOMAXIMO;
    const PRZ_PERCENTUALDESCONTOMAXIMO_Name = 'PRZ_PERCENTUALDESCONTOMAXIMO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRZ_GERARPALM', ftString, 1)]
    [Dictionary('PRZ_GERARPALM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRZ_GERARPALM: String read FPRZ_GERARPALM write FPRZ_GERARPALM;
    const PRZ_GERARPALM_Name = 'PRZ_GERARPALM';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPRZ_00)

end.
