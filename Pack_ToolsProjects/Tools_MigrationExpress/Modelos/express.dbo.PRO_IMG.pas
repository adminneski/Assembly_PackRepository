unit express.dbo.PRO_IMG;

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
  [Table('PRO_IMG', '')]
  [PrimaryKey('PRO_IMG_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PRO_IMG_ID')]
  TDtoPRO_IMG = class
  private
    { Private declarations } 
    FPRO_IMG_ID: Integer;
    FPRO_CODIGO: Integer;
    FPRO_IMAGEM: TBlob;
    FPRO_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'PRO_IMG';
     const PrimaryKey = 'PRO_IMG_ID';
     const Sequence   = 'SEQ_PRO_IMG_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_IMG_ID', ftInteger)]
    [Dictionary('PRO_IMG_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_IMG_ID: Integer read FPRO_IMG_ID write FPRO_IMG_ID;
    const PRO_IMG_ID_Name = 'PRO_IMG_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_IMAGEM', ftBlob)]
    [Dictionary('PRO_IMAGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_IMAGEM: TBlob read FPRO_IMAGEM write FPRO_IMAGEM;
    const PRO_IMAGEM_Name = 'PRO_IMAGEM';

    [Restrictions([NoValidate])]
    [Column('PRO_DATAALTERACAO', ftDateTime)]
    [Dictionary('PRO_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property PRO_DATAALTERACAO: TDateTime read FPRO_DATAALTERACAO write FPRO_DATAALTERACAO;
    const PRO_DATAALTERACAO_Name = 'PRO_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPRO_IMG)

end.
