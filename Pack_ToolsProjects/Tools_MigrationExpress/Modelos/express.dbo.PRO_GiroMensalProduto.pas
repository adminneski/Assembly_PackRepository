unit express.dbo.PRO_GIROMENSALPRODUTO;

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
  [Table('PRO_GiroMensalProduto', '')]
  TDtoPRO_GiroMensalProduto = class
  private
    { Private declarations } 
    FPRO_TIPOMOVTO: String;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FPRO_MES: Integer;
    FPRO_ANO: Integer;
    FPRO_TOTALGIROMENSAL: Double;
  public 
    { Public declarations } 
     const Table      = 'PRO_GiroMensalProduto';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_TIPOMOVTO', ftString, 11)]
    [Dictionary('PRO_TIPOMOVTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_TIPOMOVTO: String read FPRO_TIPOMOVTO write FPRO_TIPOMOVTO;
    const PRO_TIPOMOVTO_Name = 'PRO_TIPOMOVTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_MES', ftInteger)]
    [Dictionary('PRO_MES', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_MES: Integer read FPRO_MES write FPRO_MES;
    const PRO_MES_Name = 'PRO_MES';

    [Restrictions([NoValidate])]
    [Column('PRO_ANO', ftInteger)]
    [Dictionary('PRO_ANO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_ANO: Integer read FPRO_ANO write FPRO_ANO;
    const PRO_ANO_Name = 'PRO_ANO';

    [Restrictions([NoValidate])]
    [Column('PRO_TOTALGIROMENSAL', ftBCD)]
    [Dictionary('PRO_TOTALGIROMENSAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_TOTALGIROMENSAL: Double read FPRO_TOTALGIROMENSAL write FPRO_TOTALGIROMENSAL;
    const PRO_TOTALGIROMENSAL_Name = 'PRO_TOTALGIROMENSAL';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPRO_GiroMensalProduto)

end.
