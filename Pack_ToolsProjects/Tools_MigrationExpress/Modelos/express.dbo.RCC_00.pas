unit express.dbo.RCC_00;

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
  [Table('RCC_00', '')]
  [PrimaryKey('RCC_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_RCC_ID')]
  TDtoRCC_00 = class
  private
    { Private declarations } 
    FRCC_ID: Integer;
    FCCU_CODIGO: Integer;
    FPLC_CODIGO: Integer;
    FRCC_ANO: String;
    FRCC_DATALANCAMENTO: TDateTime;
    FRCC_DATAALTERACAO: TDateTime;
    FRCC_DESATIVADO: String;
    FRCC_ID_OLD: Integer;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'RCC_00';
     const PrimaryKey = 'RCC_ID';
     const Sequence   = 'SEQ_RCC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('RCC_ID', ftInteger)]
    [Dictionary('RCC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property RCC_ID: Integer read FRCC_ID write FRCC_ID;
    const RCC_ID_Name = 'RCC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CCU_CODIGO', ftInteger)]
    [Dictionary('CCU_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGO: Integer read FCCU_CODIGO write FCCU_CODIGO;
    const CCU_CODIGO_Name = 'CCU_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PLC_CODIGO', ftInteger)]
    [Dictionary('PLC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGO: Integer read FPLC_CODIGO write FPLC_CODIGO;
    const PLC_CODIGO_Name = 'PLC_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RCC_ANO', ftString, 4)]
    [Dictionary('RCC_ANO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RCC_ANO: String read FRCC_ANO write FRCC_ANO;
    const RCC_ANO_Name = 'RCC_ANO';

    [Restrictions([NoValidate])]
    [Column('RCC_DATALANCAMENTO', ftDateTime)]
    [Dictionary('RCC_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property RCC_DATALANCAMENTO: TDateTime read FRCC_DATALANCAMENTO write FRCC_DATALANCAMENTO;
    const RCC_DATALANCAMENTO_Name = 'RCC_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RCC_DATAALTERACAO', ftDateTime)]
    [Dictionary('RCC_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property RCC_DATAALTERACAO: TDateTime read FRCC_DATAALTERACAO write FRCC_DATAALTERACAO;
    const RCC_DATAALTERACAO_Name = 'RCC_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RCC_DESATIVADO', ftString, 1)]
    [Dictionary('RCC_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RCC_DESATIVADO: String read FRCC_DESATIVADO write FRCC_DESATIVADO;
    const RCC_DESATIVADO_Name = 'RCC_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('RCC_ID_OLD', ftInteger)]
    [Dictionary('RCC_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property RCC_ID_OLD: Integer read FRCC_ID_OLD write FRCC_ID_OLD;
    const RCC_ID_OLD_Name = 'RCC_ID_OLD';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoRCC_00)

end.
