unit express.dbo.VW_PSQ_CLF;

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
  [Table('VW_PSQ_CLF', '')]
  TDtoVW_PSQ_CLF = class
  private
    { Private declarations } 
    FCLF_CODIGO: String;
    FCLF_CODIGOSH: String;
    FCLF_DESCRICAO: String;
    FCLF_ORDEM: Integer;
    FCLF_DESATIVADO: String;
    FCLF_DATAALTERACAO: TDateTime;
    FCLF_PERCENTUALIBPTNACIONAL: Double;
    FCLF_PERCENTUALIBPTIMPORTADO: Double;
    FCLF_PERCENTUALIBPTMUNICIPAL: Double;
    FCLF_PERCENTUALIBPTESTADUAL: Double;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_CLF';

    [Restrictions([NoValidate, NotNull])]
    [Column('CLF_CODIGO', ftString, 8)]
    [Dictionary('CLF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLF_CODIGO: String read FCLF_CODIGO write FCLF_CODIGO;
    const CLF_CODIGO_Name = 'CLF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CLF_CODIGOSH', ftString, 10)]
    [Dictionary('CLF_CODIGOSH', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLF_CODIGOSH: String read FCLF_CODIGOSH write FCLF_CODIGOSH;
    const CLF_CODIGOSH_Name = 'CLF_CODIGOSH';

    [Restrictions([NoValidate])]
    [Column('CLF_DESCRICAO', ftString, 300)]
    [Dictionary('CLF_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLF_DESCRICAO: String read FCLF_DESCRICAO write FCLF_DESCRICAO;
    const CLF_DESCRICAO_Name = 'CLF_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('CLF_ORDEM', ftInteger)]
    [Dictionary('CLF_ORDEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property CLF_ORDEM: Integer read FCLF_ORDEM write FCLF_ORDEM;
    const CLF_ORDEM_Name = 'CLF_ORDEM';

    [Restrictions([NoValidate])]
    [Column('CLF_DESATIVADO', ftString, 1)]
    [Dictionary('CLF_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLF_DESATIVADO: String read FCLF_DESATIVADO write FCLF_DESATIVADO;
    const CLF_DESATIVADO_Name = 'CLF_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('CLF_DATAALTERACAO', ftDateTime)]
    [Dictionary('CLF_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CLF_DATAALTERACAO: TDateTime read FCLF_DATAALTERACAO write FCLF_DATAALTERACAO;
    const CLF_DATAALTERACAO_Name = 'CLF_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CLF_PERCENTUALIBPTNACIONAL', ftBCD)]
    [Dictionary('CLF_PERCENTUALIBPTNACIONAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CLF_PERCENTUALIBPTNACIONAL: Double read FCLF_PERCENTUALIBPTNACIONAL write FCLF_PERCENTUALIBPTNACIONAL;
    const CLF_PERCENTUALIBPTNACIONAL_Name = 'CLF_PERCENTUALIBPTNACIONAL';

    [Restrictions([NoValidate])]
    [Column('CLF_PERCENTUALIBPTIMPORTADO', ftBCD, 48, 2)]
    [Dictionary('CLF_PERCENTUALIBPTIMPORTADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CLF_PERCENTUALIBPTIMPORTADO: Double read FCLF_PERCENTUALIBPTIMPORTADO write FCLF_PERCENTUALIBPTIMPORTADO;
    const CLF_PERCENTUALIBPTIMPORTADO_Name = 'CLF_PERCENTUALIBPTIMPORTADO';

    [Restrictions([NoValidate])]
    [Column('CLF_PERCENTUALIBPTMUNICIPAL', ftBCD)]
    [Dictionary('CLF_PERCENTUALIBPTMUNICIPAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CLF_PERCENTUALIBPTMUNICIPAL: Double read FCLF_PERCENTUALIBPTMUNICIPAL write FCLF_PERCENTUALIBPTMUNICIPAL;
    const CLF_PERCENTUALIBPTMUNICIPAL_Name = 'CLF_PERCENTUALIBPTMUNICIPAL';

    [Restrictions([NoValidate])]
    [Column('CLF_PERCENTUALIBPTESTADUAL', ftBCD)]
    [Dictionary('CLF_PERCENTUALIBPTESTADUAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CLF_PERCENTUALIBPTESTADUAL: Double read FCLF_PERCENTUALIBPTESTADUAL write FCLF_PERCENTUALIBPTESTADUAL;
    const CLF_PERCENTUALIBPTESTADUAL_Name = 'CLF_PERCENTUALIBPTESTADUAL';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_CLF)

end.
