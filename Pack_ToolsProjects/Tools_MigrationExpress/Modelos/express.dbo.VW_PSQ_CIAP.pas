unit express.dbo.VW_PSQ_CIAP;

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
  [Table('VW_PSQ_CIAP', '')]
  TDtoVW_PSQ_CIAP = class
  private
    { Private declarations } 
    FCIAP_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FPRO_DESCRICAO: String;
    FPRI_CODIGO: Integer;
    FPRI_DESCRICAO: String;
    FCIAP_NOTAFISCAL: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_CIAP';

    [Restrictions([NoValidate, NotNull])]
    [Column('CIAP_ID', ftInteger)]
    [Dictionary('CIAP_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CIAP_ID: Integer read FCIAP_ID write FCIAP_ID;
    const CIAP_ID_Name = 'CIAP_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('PRI_CODIGO', ftInteger)]
    [Dictionary('PRI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRI_CODIGO: Integer read FPRI_CODIGO write FPRI_CODIGO;
    const PRI_CODIGO_Name = 'PRI_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRI_DESCRICAO', ftString, 100)]
    [Dictionary('PRI_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRI_DESCRICAO: String read FPRI_DESCRICAO write FPRI_DESCRICAO;
    const PRI_DESCRICAO_Name = 'PRI_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('CIAP_NOTAFISCAL', ftString, 9)]
    [Dictionary('CIAP_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIAP_NOTAFISCAL: String read FCIAP_NOTAFISCAL write FCIAP_NOTAFISCAL;
    const CIAP_NOTAFISCAL_Name = 'CIAP_NOTAFISCAL';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_CIAP)

end.
