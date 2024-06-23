unit express.dbo.REL_V01_CCC;

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
  [Table('REL_V01_CCC', '')]
  TDtoREL_V01_CCC = class
  private
    { Private declarations } 
    FCCC_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FVND_CODIGO: Integer;
    FVND_NOME: String;
    FCCC_DATALANCAMENTO: TDateTime;
    FCCC_DIASRETORNO: Integer;
    FCCC_STATUS: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_CCC';

    [Restrictions([NoValidate, NotNull])]
    [Column('CCC_ID', ftInteger)]
    [Dictionary('CCC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCC_ID: Integer read FCCC_ID write FCCC_ID;
    const CCC_ID_Name = 'CCC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VND_NOME', ftString, 100)]
    [Dictionary('VND_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VND_NOME: String read FVND_NOME write FVND_NOME;
    const VND_NOME_Name = 'VND_NOME';

    [Restrictions([NoValidate])]
    [Column('CCC_DATALANCAMENTO', ftDateTime)]
    [Dictionary('CCC_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CCC_DATALANCAMENTO: TDateTime read FCCC_DATALANCAMENTO write FCCC_DATALANCAMENTO;
    const CCC_DATALANCAMENTO_Name = 'CCC_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('CCC_DIASRETORNO', ftInteger)]
    [Dictionary('CCC_DIASRETORNO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCC_DIASRETORNO: Integer read FCCC_DIASRETORNO write FCCC_DIASRETORNO;
    const CCC_DIASRETORNO_Name = 'CCC_DIASRETORNO';

    [Restrictions([NoValidate])]
    [Column('CCC_STATUS', ftString, 1)]
    [Dictionary('CCC_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CCC_STATUS: String read FCCC_STATUS write FCCC_STATUS;
    const CCC_STATUS_Name = 'CCC_STATUS';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_CCC)

end.
