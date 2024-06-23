unit express.dbo.XML_MANIFESTOCARGA_CONTRATANTE;

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
  [Table('XML_MANIFESTOCARGA_CONTRATANTE', '')]
  TDtoXML_MANIFESTOCARGA_CONTRATANTE = class
  private
    { Private declarations } 
    FMFC_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CNPJ_CPF: String;
  public 
    { Public declarations } 
     const Table      = 'XML_MANIFESTOCARGA_CONTRATANTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_ID', ftInteger)]
    [Dictionary('MFC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_ID: Integer read FMFC_ID write FMFC_ID;
    const MFC_ID_Name = 'MFC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF: String read FPES_CNPJ_CPF write FPES_CNPJ_CPF;
    const PES_CNPJ_CPF_Name = 'PES_CNPJ_CPF';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoXML_MANIFESTOCARGA_CONTRATANTE)

end.
