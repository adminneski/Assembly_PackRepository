unit express.dbo.PALM_IMPORTACAOPEDIDOSITEM;

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
  [Table('PALM_ImportacaoPedidosItem', '')]
  TDtoPALM_ImportacaoPedidosItem = class
  private
    { Private declarations } 
    FPALM_ID: Integer;
    FPALM_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FTAB_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FPALM_QTDPEDIDA: Double;
    FPALM_QTDATENDIDA: Double;
    FPALM_PRECOVENDA: Double;
    FPALM_PRECOTABELA: Double;
    FPALM_PRECOORIGINAL: Double;
    FPRO_PERCENTUALCOMISSAO: Double;
    FPALM_PRECOCUSTO: Double;
    FPRO_NUMEROVOLUMES: Double;
    FPRO_PESOBRUTO: Double;
    FPRO_PESOLIQUIDO: Double;
    FPRO_TOTALNUMEROVOLUMES: Double;
    FPRO_TOTALPESOBRUTO: Double;
    FPRO_TOTALPESOLIQUIDO: Double;
  public 
    { Public declarations } 
     const Table      = 'PALM_ImportacaoPedidosItem';

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
    [Column('TAB_CODIGO', ftInteger)]
    [Dictionary('TAB_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TAB_CODIGO: Integer read FTAB_CODIGO write FTAB_CODIGO;
    const TAB_CODIGO_Name = 'TAB_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PALM_QTDPEDIDA', ftBCD, 10, 3)]
    [Dictionary('PALM_QTDPEDIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PALM_QTDPEDIDA: Double read FPALM_QTDPEDIDA write FPALM_QTDPEDIDA;
    const PALM_QTDPEDIDA_Name = 'PALM_QTDPEDIDA';

    [Restrictions([NoValidate])]
    [Column('PALM_QTDATENDIDA', ftBCD)]
    [Dictionary('PALM_QTDATENDIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PALM_QTDATENDIDA: Double read FPALM_QTDATENDIDA write FPALM_QTDATENDIDA;
    const PALM_QTDATENDIDA_Name = 'PALM_QTDATENDIDA';

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
    [Column('PALM_PRECOORIGINAL', ftBCD, 18, 4)]
    [Dictionary('PALM_PRECOORIGINAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PALM_PRECOORIGINAL: Double read FPALM_PRECOORIGINAL write FPALM_PRECOORIGINAL;
    const PALM_PRECOORIGINAL_Name = 'PALM_PRECOORIGINAL';

    [Restrictions([NoValidate])]
    [Column('PRO_PERCENTUALCOMISSAO', ftBCD)]
    [Dictionary('PRO_PERCENTUALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PERCENTUALCOMISSAO: Double read FPRO_PERCENTUALCOMISSAO write FPRO_PERCENTUALCOMISSAO;
    const PRO_PERCENTUALCOMISSAO_Name = 'PRO_PERCENTUALCOMISSAO';

    [Restrictions([NoValidate])]
    [Column('PALM_PRECOCUSTO', ftBCD, 18, 4)]
    [Dictionary('PALM_PRECOCUSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PALM_PRECOCUSTO: Double read FPALM_PRECOCUSTO write FPALM_PRECOCUSTO;
    const PALM_PRECOCUSTO_Name = 'PALM_PRECOCUSTO';

    [Restrictions([NoValidate])]
    [Column('PRO_NUMEROVOLUMES', ftBCD)]
    [Dictionary('PRO_NUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_NUMEROVOLUMES: Double read FPRO_NUMEROVOLUMES write FPRO_NUMEROVOLUMES;
    const PRO_NUMEROVOLUMES_Name = 'PRO_NUMEROVOLUMES';

    [Restrictions([NoValidate])]
    [Column('PRO_PESOBRUTO', ftBCD, 18, 4)]
    [Dictionary('PRO_PESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PESOBRUTO: Double read FPRO_PESOBRUTO write FPRO_PESOBRUTO;
    const PRO_PESOBRUTO_Name = 'PRO_PESOBRUTO';

    [Restrictions([NoValidate])]
    [Column('PRO_PESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('PRO_PESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_PESOLIQUIDO: Double read FPRO_PESOLIQUIDO write FPRO_PESOLIQUIDO;
    const PRO_PESOLIQUIDO_Name = 'PRO_PESOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('PRO_TOTALNUMEROVOLUMES', ftBCD, 48, 5)]
    [Dictionary('PRO_TOTALNUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_TOTALNUMEROVOLUMES: Double read FPRO_TOTALNUMEROVOLUMES write FPRO_TOTALNUMEROVOLUMES;
    const PRO_TOTALNUMEROVOLUMES_Name = 'PRO_TOTALNUMEROVOLUMES';

    [Restrictions([NoValidate])]
    [Column('PRO_TOTALPESOBRUTO', ftBCD)]
    [Dictionary('PRO_TOTALPESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_TOTALPESOBRUTO: Double read FPRO_TOTALPESOBRUTO write FPRO_TOTALPESOBRUTO;
    const PRO_TOTALPESOBRUTO_Name = 'PRO_TOTALPESOBRUTO';

    [Restrictions([NoValidate])]
    [Column('PRO_TOTALPESOLIQUIDO', ftBCD)]
    [Dictionary('PRO_TOTALPESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRO_TOTALPESOLIQUIDO: Double read FPRO_TOTALPESOLIQUIDO write FPRO_TOTALPESOLIQUIDO;
    const PRO_TOTALPESOLIQUIDO_Name = 'PRO_TOTALPESOLIQUIDO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPALM_ImportacaoPedidosItem)

end.
