unit express.dbo.PALM_MSE_00_01;

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
  [Table('PALM_MSE_00_01', '')]
  [PrimaryKey('MSE_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [PrimaryKey('COM_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_MSE_01_ID')]
  [Sequence('SEQ_COM_CODIGO')]
  TDtoPALM_MSE_00_01 = class
  private
    { Private declarations } 
    FMSE_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FMSE_ID: Integer;
    FPES_CODIGODESTINATARIO: Integer;
  public 
    { Public declarations } 
     const Table      = 'PALM_MSE_00_01';
     const PrimaryKey = 'MSE_01_ID';
     const Sequence   = 'SEQ_MSE_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('MSE_01_ID', ftInteger)]
    [Dictionary('MSE_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MSE_01_ID: Integer read FMSE_01_ID write FMSE_01_ID;
    const MSE_01_ID_Name = 'MSE_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MSE_ID', ftInteger)]
    [Dictionary('MSE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MSE_ID: Integer read FMSE_ID write FMSE_ID;
    const MSE_ID_Name = 'MSE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGODESTINATARIO', ftInteger)]
    [Dictionary('PES_CODIGODESTINATARIO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGODESTINATARIO: Integer read FPES_CODIGODESTINATARIO write FPES_CODIGODESTINATARIO;
    const PES_CODIGODESTINATARIO_Name = 'PES_CODIGODESTINATARIO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPALM_MSE_00_01)

end.
