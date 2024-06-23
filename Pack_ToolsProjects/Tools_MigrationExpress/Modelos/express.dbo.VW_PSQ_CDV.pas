unit express.dbo.VW_PSQ_CDV;

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
  [Table('VW_PSQ_CDV', '')]
  TDtoVW_PSQ_CDV = class
  private
    { Private declarations } 
    FCDV_ID: Integer;
    FCOM_CODIGO: Integer;
    FCDV_NUMERODOCTO: String;
    FCDV_DATALANCAMENTO: TDateTime;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FCDV_PROCESSADO: String;
    FCDV_TOTALLIQUIDO: Double;
    FCDV_TOTALLIQUIDOTRANSPORTADOR: Double;
    FVEI_CODIGO: Integer;
    FVEI_PLACA: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_CDV';

    [Restrictions([NoValidate, NotNull])]
    [Column('CDV_ID', ftInteger)]
    [Dictionary('CDV_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CDV_ID: Integer read FCDV_ID write FCDV_ID;
    const CDV_ID_Name = 'CDV_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CDV_NUMERODOCTO', ftString, 10)]
    [Dictionary('CDV_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CDV_NUMERODOCTO: String read FCDV_NUMERODOCTO write FCDV_NUMERODOCTO;
    const CDV_NUMERODOCTO_Name = 'CDV_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('CDV_DATALANCAMENTO', ftDateTime)]
    [Dictionary('CDV_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CDV_DATALANCAMENTO: TDateTime read FCDV_DATALANCAMENTO write FCDV_DATALANCAMENTO;
    const CDV_DATALANCAMENTO_Name = 'CDV_DATALANCAMENTO';

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
    [Column('CDV_PROCESSADO', ftString, 1)]
    [Dictionary('CDV_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CDV_PROCESSADO: String read FCDV_PROCESSADO write FCDV_PROCESSADO;
    const CDV_PROCESSADO_Name = 'CDV_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('CDV_TOTALLIQUIDO', ftBCD)]
    [Dictionary('CDV_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CDV_TOTALLIQUIDO: Double read FCDV_TOTALLIQUIDO write FCDV_TOTALLIQUIDO;
    const CDV_TOTALLIQUIDO_Name = 'CDV_TOTALLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('CDV_TOTALLIQUIDOTRANSPORTADOR', ftBCD)]
    [Dictionary('CDV_TOTALLIQUIDOTRANSPORTADOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CDV_TOTALLIQUIDOTRANSPORTADOR: Double read FCDV_TOTALLIQUIDOTRANSPORTADOR write FCDV_TOTALLIQUIDOTRANSPORTADOR;
    const CDV_TOTALLIQUIDOTRANSPORTADOR_Name = 'CDV_TOTALLIQUIDOTRANSPORTADOR';

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
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_CDV)

end.
