unit express.dbo.VW_PSQ_CFG;

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
  [Table('VW_PSQ_CFG', '')]
  TDtoVW_PSQ_CFG = class
  private
    { Private declarations } 
    FCFG_CODIGO: Integer;
    FCOM_CODIGO: Integer;
    FCOM_CNPJ_CPF: String;
    FCOM_RAZAO: String;
    FCFG_DATAALTERACAO: TDateTime;
    FCFG_DESATIVADO: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_CFG';

    [Restrictions([NoValidate, NotNull])]
    [Column('CFG_CODIGO', ftInteger)]
    [Dictionary('CFG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CFG_CODIGO: Integer read FCFG_CODIGO write FCFG_CODIGO;
    const CFG_CODIGO_Name = 'CFG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('COM_CNPJ_CPF', ftString, 14)]
    [Dictionary('COM_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CNPJ_CPF: String read FCOM_CNPJ_CPF write FCOM_CNPJ_CPF;
    const COM_CNPJ_CPF_Name = 'COM_CNPJ_CPF';

    [Restrictions([NoValidate])]
    [Column('COM_RAZAO', ftString, 100)]
    [Dictionary('COM_RAZAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_RAZAO: String read FCOM_RAZAO write FCOM_RAZAO;
    const COM_RAZAO_Name = 'COM_RAZAO';

    [Restrictions([NoValidate])]
    [Column('CFG_DATAALTERACAO', ftDateTime)]
    [Dictionary('CFG_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CFG_DATAALTERACAO: TDateTime read FCFG_DATAALTERACAO write FCFG_DATAALTERACAO;
    const CFG_DATAALTERACAO_Name = 'CFG_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CFG_DESATIVADO', ftString, 1)]
    [Dictionary('CFG_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_DESATIVADO: String read FCFG_DESATIVADO write FCFG_DESATIVADO;
    const CFG_DESATIVADO_Name = 'CFG_DESATIVADO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_CFG)

end.
