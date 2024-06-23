unit express.dbo.VW_PSQ_SFH;

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
  [Table('VW_PSQ_SFH', '')]
  TDtoVW_PSQ_SFH = class
  private
    { Private declarations } 
    FSFH_CODIGO: Integer;
    FSFH_RAZAO: String;
    FSFH_CNPJ: String;
    FSFH_IE: String;
    FSFH_DDD_TELEFONE: String;
    FSFH_DDD_CELULAR: String;
    FSFH_DDD_FAX: String;
    FSFH_DESATIVADO: String;
    FSFH_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_SFH';

    [Restrictions([NoValidate, NotNull])]
    [Column('SFH_CODIGO', ftInteger)]
    [Dictionary('SFH_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property SFH_CODIGO: Integer read FSFH_CODIGO write FSFH_CODIGO;
    const SFH_CODIGO_Name = 'SFH_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SFH_RAZAO', ftString, 50)]
    [Dictionary('SFH_RAZAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SFH_RAZAO: String read FSFH_RAZAO write FSFH_RAZAO;
    const SFH_RAZAO_Name = 'SFH_RAZAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SFH_CNPJ', ftString, 14)]
    [Dictionary('SFH_CNPJ', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SFH_CNPJ: String read FSFH_CNPJ write FSFH_CNPJ;
    const SFH_CNPJ_Name = 'SFH_CNPJ';

    [Restrictions([NoValidate])]
    [Column('SFH_IE', ftString, 16)]
    [Dictionary('SFH_IE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SFH_IE: String read FSFH_IE write FSFH_IE;
    const SFH_IE_Name = 'SFH_IE';

    [Restrictions([NoValidate])]
    [Column('SFH_DDD_TELEFONE', ftString, 11)]
    [Dictionary('SFH_DDD_TELEFONE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SFH_DDD_TELEFONE: String read FSFH_DDD_TELEFONE write FSFH_DDD_TELEFONE;
    const SFH_DDD_TELEFONE_Name = 'SFH_DDD_TELEFONE';

    [Restrictions([NoValidate])]
    [Column('SFH_DDD_CELULAR', ftString, 11)]
    [Dictionary('SFH_DDD_CELULAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SFH_DDD_CELULAR: String read FSFH_DDD_CELULAR write FSFH_DDD_CELULAR;
    const SFH_DDD_CELULAR_Name = 'SFH_DDD_CELULAR';

    [Restrictions([NoValidate])]
    [Column('SFH_DDD_FAX', ftString, 11)]
    [Dictionary('SFH_DDD_FAX', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SFH_DDD_FAX: String read FSFH_DDD_FAX write FSFH_DDD_FAX;
    const SFH_DDD_FAX_Name = 'SFH_DDD_FAX';

    [Restrictions([NoValidate, NotNull])]
    [Column('SFH_DESATIVADO', ftString, 1)]
    [Dictionary('SFH_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SFH_DESATIVADO: String read FSFH_DESATIVADO write FSFH_DESATIVADO;
    const SFH_DESATIVADO_Name = 'SFH_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('SFH_DATAALTERACAO', ftDateTime)]
    [Dictionary('SFH_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property SFH_DATAALTERACAO: TDateTime read FSFH_DATAALTERACAO write FSFH_DATAALTERACAO;
    const SFH_DATAALTERACAO_Name = 'SFH_DATAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_SFH)

end.
