unit express.dbo.VW_PSQ_RCC;

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
  [Table('VW_PSQ_RCC', '')]
  TDtoVW_PSQ_RCC = class
  private
    { Private declarations } 
    FRCC_ID: Integer;
    FRCC_ANO: String;
    FPLC_CODIGO: Integer;
    FCCU_CODIGO: Integer;
    FPLC_DESCRICAO: String;
    FCCU_DESCRICAO: String;
    FRCC_DESATIVADO: String;
    FRCC_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_RCC';

    [Restrictions([NoValidate, NotNull])]
    [Column('RCC_ID', ftInteger)]
    [Dictionary('RCC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property RCC_ID: Integer read FRCC_ID write FRCC_ID;
    const RCC_ID_Name = 'RCC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('RCC_ANO', ftString, 4)]
    [Dictionary('RCC_ANO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RCC_ANO: String read FRCC_ANO write FRCC_ANO;
    const RCC_ANO_Name = 'RCC_ANO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PLC_CODIGO', ftInteger)]
    [Dictionary('PLC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGO: Integer read FPLC_CODIGO write FPLC_CODIGO;
    const PLC_CODIGO_Name = 'PLC_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CCU_CODIGO', ftInteger)]
    [Dictionary('CCU_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGO: Integer read FCCU_CODIGO write FCCU_CODIGO;
    const CCU_CODIGO_Name = 'CCU_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PLC_DESCRICAO', ftString, 30)]
    [Dictionary('PLC_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PLC_DESCRICAO: String read FPLC_DESCRICAO write FPLC_DESCRICAO;
    const PLC_DESCRICAO_Name = 'PLC_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('CCU_DESCRICAO', ftString, 50)]
    [Dictionary('CCU_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CCU_DESCRICAO: String read FCCU_DESCRICAO write FCCU_DESCRICAO;
    const CCU_DESCRICAO_Name = 'CCU_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RCC_DESATIVADO', ftString, 1)]
    [Dictionary('RCC_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RCC_DESATIVADO: String read FRCC_DESATIVADO write FRCC_DESATIVADO;
    const RCC_DESATIVADO_Name = 'RCC_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RCC_DATAALTERACAO', ftDateTime)]
    [Dictionary('RCC_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property RCC_DATAALTERACAO: TDateTime read FRCC_DATAALTERACAO write FRCC_DATAALTERACAO;
    const RCC_DATAALTERACAO_Name = 'RCC_DATAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_RCC)

end.
