unit express.dbo.ORS_SELECIONARATEIOTECNICO;

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
  [Table('ORS_SelecionaRateioTecnico', '')]
  TDtoORS_SelecionaRateioTecnico = class
  private
    { Private declarations } 
    FORS_SIGLA: String;
    FORS_01_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FORS_ID: Integer;
    FORS_01_ID: Integer;
    FPRO_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FORS_PERCENTUALRATEIO: Double;
    FORS_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'ORS_SelecionaRateioTecnico';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_SIGLA', ftString, 3)]
    [Dictionary('ORS_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_SIGLA: String read FORS_SIGLA write FORS_SIGLA;
    const ORS_SIGLA_Name = 'ORS_SIGLA';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_01_01_ID', ftInteger)]
    [Dictionary('ORS_01_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_01_01_ID: Integer read FORS_01_01_ID write FORS_01_01_ID;
    const ORS_01_01_ID_Name = 'ORS_01_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('ORS_ID', ftInteger)]
    [Dictionary('ORS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_ID: Integer read FORS_ID write FORS_ID;
    const ORS_ID_Name = 'ORS_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_01_ID', ftInteger)]
    [Dictionary('ORS_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_01_ID: Integer read FORS_01_ID write FORS_01_ID;
    const ORS_01_ID_Name = 'ORS_01_ID';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('ORS_PERCENTUALRATEIO', ftBCD)]
    [Dictionary('ORS_PERCENTUALRATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_PERCENTUALRATEIO: Double read FORS_PERCENTUALRATEIO write FORS_PERCENTUALRATEIO;
    const ORS_PERCENTUALRATEIO_Name = 'ORS_PERCENTUALRATEIO';

    [Restrictions([NoValidate])]
    [Column('ORS_DATAALTERACAO', ftDateTime)]
    [Dictionary('ORS_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property ORS_DATAALTERACAO: TDateTime read FORS_DATAALTERACAO write FORS_DATAALTERACAO;
    const ORS_DATAALTERACAO_Name = 'ORS_DATAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoORS_SelecionaRateioTecnico)

end.
