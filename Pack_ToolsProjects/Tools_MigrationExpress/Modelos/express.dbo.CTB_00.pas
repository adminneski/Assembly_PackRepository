unit express.dbo.CTB_00;

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
  [Table('CTB_00', '')]
  [PrimaryKey('CTB_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CTB_CODIGO')]
  TDtoCTB_00 = class
  private
    { Private declarations } 
    FCTB_CODIGO: Integer;
    FCTB_DESCRICAO: String;
    FCTB_DESATIVADO: String;
    FCTB_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'CTB_00';
     const PrimaryKey = 'CTB_CODIGO';
     const Sequence   = 'SEQ_CTB_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTB_CODIGO', ftInteger)]
    [Dictionary('CTB_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTB_CODIGO: Integer read FCTB_CODIGO write FCTB_CODIGO;
    const CTB_CODIGO_Name = 'CTB_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTB_DESCRICAO', ftString, 50)]
    [Dictionary('CTB_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTB_DESCRICAO: String read FCTB_DESCRICAO write FCTB_DESCRICAO;
    const CTB_DESCRICAO_Name = 'CTB_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('CTB_DESATIVADO', ftString, 1)]
    [Dictionary('CTB_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTB_DESATIVADO: String read FCTB_DESATIVADO write FCTB_DESATIVADO;
    const CTB_DESATIVADO_Name = 'CTB_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTB_DATAALTERACAO', ftDateTime)]
    [Dictionary('CTB_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CTB_DATAALTERACAO: TDateTime read FCTB_DATAALTERACAO write FCTB_DATAALTERACAO;
    const CTB_DATAALTERACAO_Name = 'CTB_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCTB_00)

end.
