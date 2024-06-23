unit express.dbo.SRV_MAXNUMEROPARCELASMOVTOS;

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
  [Table('SRV_MaxNumeroParcelasMovtos', '')]
  TDtoSRV_MaxNumeroParcelasMovtos = class
  private
    { Private declarations } 
    FSRV_SIGLA: String;
    FSRV_ID: Integer;
    FCOM_CODIGO: Integer;
    FSRV_TOTALPARCELA: Integer;
  public 
    { Public declarations } 
     const Table      = 'SRV_MaxNumeroParcelasMovtos';

    [Restrictions([NoValidate, NotNull])]
    [Column('SRV_SIGLA', ftString, 3)]
    [Dictionary('SRV_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SRV_SIGLA: String read FSRV_SIGLA write FSRV_SIGLA;
    const SRV_SIGLA_Name = 'SRV_SIGLA';

    [Restrictions([NoValidate, NotNull])]
    [Column('SRV_ID', ftInteger)]
    [Dictionary('SRV_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property SRV_ID: Integer read FSRV_ID write FSRV_ID;
    const SRV_ID_Name = 'SRV_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('SRV_TOTALPARCELA', ftInteger)]
    [Dictionary('SRV_TOTALPARCELA', 'Mensagem de validação', '0', '', '', taCenter)]
    property SRV_TOTALPARCELA: Integer read FSRV_TOTALPARCELA write FSRV_TOTALPARCELA;
    const SRV_TOTALPARCELA_Name = 'SRV_TOTALPARCELA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSRV_MaxNumeroParcelasMovtos)

end.
