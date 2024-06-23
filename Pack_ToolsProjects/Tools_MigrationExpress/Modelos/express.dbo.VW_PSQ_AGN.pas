unit express.dbo.VW_PSQ_AGN;

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
  [Table('VW_PSQ_AGN', '')]
  TDtoVW_PSQ_AGN = class
  private
    { Private declarations } 
    FAGN_ID: Integer;
    FCOM_CODIGO: Integer;
    FVEI_CODIGO: Integer;
    FVEI_PLACA: String;
    FPES_CODIGO: Integer;
    FAGN_NOMECLIENTE: String;
    FAGN_DATAAGENDAMENTO: TDateTime;
    FAGN_HORAAGENDAMENTO: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_AGN';

    [Restrictions([NoValidate, NotNull])]
    [Column('AGN_ID', ftInteger)]
    [Dictionary('AGN_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property AGN_ID: Integer read FAGN_ID write FAGN_ID;
    const AGN_ID_Name = 'AGN_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VEI_CODIGO', ftInteger)]
    [Dictionary('VEI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEI_CODIGO: Integer read FVEI_CODIGO write FVEI_CODIGO;
    const VEI_CODIGO_Name = 'VEI_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VEI_PLACA', ftString, 7)]
    [Dictionary('VEI_PLACA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_PLACA: String read FVEI_PLACA write FVEI_PLACA;
    const VEI_PLACA_Name = 'VEI_PLACA';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('AGN_NOMECLIENTE', ftString, 100)]
    [Dictionary('AGN_NOMECLIENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AGN_NOMECLIENTE: String read FAGN_NOMECLIENTE write FAGN_NOMECLIENTE;
    const AGN_NOMECLIENTE_Name = 'AGN_NOMECLIENTE';

    [Restrictions([NoValidate])]
    [Column('AGN_DATAAGENDAMENTO', ftDateTime)]
    [Dictionary('AGN_DATAAGENDAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property AGN_DATAAGENDAMENTO: TDateTime read FAGN_DATAAGENDAMENTO write FAGN_DATAAGENDAMENTO;
    const AGN_DATAAGENDAMENTO_Name = 'AGN_DATAAGENDAMENTO';

    [Restrictions([NoValidate])]
    [Column('AGN_HORAAGENDAMENTO', ftString, 8)]
    [Dictionary('AGN_HORAAGENDAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property AGN_HORAAGENDAMENTO: String read FAGN_HORAAGENDAMENTO write FAGN_HORAAGENDAMENTO;
    const AGN_HORAAGENDAMENTO_Name = 'AGN_HORAAGENDAMENTO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_AGN)

end.
