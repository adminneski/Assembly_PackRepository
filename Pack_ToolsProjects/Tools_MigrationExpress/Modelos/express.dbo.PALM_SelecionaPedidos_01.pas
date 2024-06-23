unit express.dbo.PALM_SELECIONAPEDIDOS_01;

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
  [Table('PALM_SelecionaPedidos_01', '')]
  TDtoPALM_SelecionaPedidos_01 = class
  private
    { Private declarations } 
    FPALM_ID: Integer;
    FPALM_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FPALM_QTDPEDIDA: Double;
    FPALM_QTDATENDIDA: Double;
    FPALM_PRECOORIGINAL: Double;
    FPALM_PRECOVENDA: Double;
    FPALM_PRECOTABELA: Double;
    FPALM_PRECODIFERENCA: Currency;
    FPALM_TOTALVENDA: Double;
    FPRO_DESCRICAO: String;
    FPALM_VALORCRESCIMO: Currency;
    FPALM_VALORDESCONTO: Double;
    FPALM_PERCENTUALACRESCIMO: Double;
    FPALM_PERCENTUALDESCONTO: Double;
  public 
    { Public declarations } 
     const Table      = 'PALM_SelecionaPedidos_01';

    [Restrictions([NoValidate, NotNull])]
    [Column('PALM_ID', ftInteger)]
    [Dictionary('PALM_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PALM_ID: Integer read FPALM_ID write FPALM_ID;
    const PALM_ID_Name = 'PALM_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PALM_01_ID', ftInteger)]
    [Dictionary('PALM_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PALM_01_ID: Integer read FPALM_01_ID write FPALM_01_ID;
    const PALM_01_ID_Name = 'PALM_01_ID';

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
    [Column('PALM_QTDPEDIDA', ftBCD)]
    [Dictionary('PALM_QTDPEDIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PALM_QTDPEDIDA: Double read FPALM_QTDPEDIDA write FPALM_QTDPEDIDA;
    const PALM_QTDPEDIDA_Name = 'PALM_QTDPEDIDA';

    [Restrictions([NoValidate])]
    [Column('PALM_QTDATENDIDA', ftBCD)]
    [Dictionary('PALM_QTDATENDIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PALM_QTDATENDIDA: Double read FPALM_QTDATENDIDA write FPALM_QTDATENDIDA;
    const PALM_QTDATENDIDA_Name = 'PALM_QTDATENDIDA';

    [Restrictions([NoValidate])]
    [Column('PALM_PRECOORIGINAL', ftBCD, 18, 4)]
    [Dictionary('PALM_PRECOORIGINAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PALM_PRECOORIGINAL: Double read FPALM_PRECOORIGINAL write FPALM_PRECOORIGINAL;
    const PALM_PRECOORIGINAL_Name = 'PALM_PRECOORIGINAL';

    [Restrictions([NoValidate])]
    [Column('PALM_PRECOVENDA', ftBCD, 18, 4)]
    [Dictionary('PALM_PRECOVENDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PALM_PRECOVENDA: Double read FPALM_PRECOVENDA write FPALM_PRECOVENDA;
    const PALM_PRECOVENDA_Name = 'PALM_PRECOVENDA';

    [Restrictions([NoValidate])]
    [Column('PALM_PRECOTABELA', ftBCD, 18, 4)]
    [Dictionary('PALM_PRECOTABELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PALM_PRECOTABELA: Double read FPALM_PRECOTABELA write FPALM_PRECOTABELA;
    const PALM_PRECOTABELA_Name = 'PALM_PRECOTABELA';

    [Restrictions([NoValidate])]
    [Column('PALM_PRECODIFERENCA', ftCurrency)]
    [Dictionary('PALM_PRECODIFERENCA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PALM_PRECODIFERENCA: Currency read FPALM_PRECODIFERENCA write FPALM_PRECODIFERENCA;
    const PALM_PRECODIFERENCA_Name = 'PALM_PRECODIFERENCA';

    [Restrictions([NoValidate])]
    [Column('PALM_TOTALVENDA', ftBCD)]
    [Dictionary('PALM_TOTALVENDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PALM_TOTALVENDA: Double read FPALM_TOTALVENDA write FPALM_TOTALVENDA;
    const PALM_TOTALVENDA_Name = 'PALM_TOTALVENDA';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('PALM_VALORCRESCIMO', ftCurrency)]
    [Dictionary('PALM_VALORCRESCIMO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PALM_VALORCRESCIMO: Currency read FPALM_VALORCRESCIMO write FPALM_VALORCRESCIMO;
    const PALM_VALORCRESCIMO_Name = 'PALM_VALORCRESCIMO';

    [Restrictions([NoValidate])]
    [Column('PALM_VALORDESCONTO', ftBCD)]
    [Dictionary('PALM_VALORDESCONTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PALM_VALORDESCONTO: Double read FPALM_VALORDESCONTO write FPALM_VALORDESCONTO;
    const PALM_VALORDESCONTO_Name = 'PALM_VALORDESCONTO';

    [Restrictions([NoValidate])]
    [Column('PALM_PERCENTUALACRESCIMO', ftBCD, 48, 16)]
    [Dictionary('PALM_PERCENTUALACRESCIMO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PALM_PERCENTUALACRESCIMO: Double read FPALM_PERCENTUALACRESCIMO write FPALM_PERCENTUALACRESCIMO;
    const PALM_PERCENTUALACRESCIMO_Name = 'PALM_PERCENTUALACRESCIMO';

    [Restrictions([NoValidate])]
    [Column('PALM_PERCENTUALDESCONTO', ftBCD)]
    [Dictionary('PALM_PERCENTUALDESCONTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PALM_PERCENTUALDESCONTO: Double read FPALM_PERCENTUALDESCONTO write FPALM_PERCENTUALDESCONTO;
    const PALM_PERCENTUALDESCONTO_Name = 'PALM_PERCENTUALDESCONTO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPALM_SelecionaPedidos_01)

end.
