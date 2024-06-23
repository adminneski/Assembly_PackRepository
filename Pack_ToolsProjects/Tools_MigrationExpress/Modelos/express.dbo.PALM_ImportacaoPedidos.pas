unit express.dbo.PALM_IMPORTACAOPEDIDOS;

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
  [Table('PALM_ImportacaoPedidos', '')]
  TDtoPALM_ImportacaoPedidos = class
  private
    { Private declarations } 
    FPALM_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FVND_CODIGO: Integer;
    FPALM_DATALANCAMENTO: TDateTime;
    FPALM_NUMERODOCTO: Integer;
    FPRZ_CODIGO: Integer;
    FFPG_CODIGO: Integer;
    FNTO_CODIGO: Integer;
    FPALM_OBSERVACAO: String;
    FPALM_IMPORTADO: String;
    FPALM_EXPORTADO: String;
    FPALM_OBSERVACAO_ERP: String;
    FPALM_NUMERODOCTO_ERP: String;
    FPALM_STATUS: String;
    FPALM_EMAIL_1: String;
    FPALM_EMAIL_2: String;
    FPALM_TOTALPEDIDO: Double;
    FPALM_DATADIGITACAO: String;
    FPALM_HORADIGITACAO: String;
    FPALM_TOTALPESOBRUTO: Double;
    FPALM_TOTALQTDPEDIDA: Double;
    FPALM_TOTALNUMEROVOLUMES: Double;
    FPES_TIPOCOMISSAO: String;
    FPES_PERCENTUALCOMISSAO: Double;
    FCTB_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'PALM_ImportacaoPedidos';

    [Restrictions([NoValidate, NotNull])]
    [Column('PALM_ID', ftInteger)]
    [Dictionary('PALM_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PALM_ID: Integer read FPALM_ID write FPALM_ID;
    const PALM_ID_Name = 'PALM_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

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
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PALM_DATALANCAMENTO', ftDateTime)]
    [Dictionary('PALM_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property PALM_DATALANCAMENTO: TDateTime read FPALM_DATALANCAMENTO write FPALM_DATALANCAMENTO;
    const PALM_DATALANCAMENTO_Name = 'PALM_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('PALM_NUMERODOCTO', ftInteger)]
    [Dictionary('PALM_NUMERODOCTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PALM_NUMERODOCTO: Integer read FPALM_NUMERODOCTO write FPALM_NUMERODOCTO;
    const PALM_NUMERODOCTO_Name = 'PALM_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('PRZ_CODIGO', ftInteger)]
    [Dictionary('PRZ_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRZ_CODIGO: Integer read FPRZ_CODIGO write FPRZ_CODIGO;
    const PRZ_CODIGO_Name = 'PRZ_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NTO_CODIGO', ftInteger)]
    [Dictionary('NTO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NTO_CODIGO: Integer read FNTO_CODIGO write FNTO_CODIGO;
    const NTO_CODIGO_Name = 'NTO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PALM_OBSERVACAO', ftString, 300)]
    [Dictionary('PALM_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PALM_OBSERVACAO: String read FPALM_OBSERVACAO write FPALM_OBSERVACAO;
    const PALM_OBSERVACAO_Name = 'PALM_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('PALM_IMPORTADO', ftString, 1)]
    [Dictionary('PALM_IMPORTADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PALM_IMPORTADO: String read FPALM_IMPORTADO write FPALM_IMPORTADO;
    const PALM_IMPORTADO_Name = 'PALM_IMPORTADO';

    [Restrictions([NoValidate])]
    [Column('PALM_EXPORTADO', ftString, 1)]
    [Dictionary('PALM_EXPORTADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PALM_EXPORTADO: String read FPALM_EXPORTADO write FPALM_EXPORTADO;
    const PALM_EXPORTADO_Name = 'PALM_EXPORTADO';

    [Restrictions([NoValidate])]
    [Column('PALM_OBSERVACAO_ERP', ftString, 300)]
    [Dictionary('PALM_OBSERVACAO_ERP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PALM_OBSERVACAO_ERP: String read FPALM_OBSERVACAO_ERP write FPALM_OBSERVACAO_ERP;
    const PALM_OBSERVACAO_ERP_Name = 'PALM_OBSERVACAO_ERP';

    [Restrictions([NoValidate])]
    [Column('PALM_NUMERODOCTO_ERP', ftString, 10)]
    [Dictionary('PALM_NUMERODOCTO_ERP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PALM_NUMERODOCTO_ERP: String read FPALM_NUMERODOCTO_ERP write FPALM_NUMERODOCTO_ERP;
    const PALM_NUMERODOCTO_ERP_Name = 'PALM_NUMERODOCTO_ERP';

    [Restrictions([NoValidate])]
    [Column('PALM_STATUS', ftString, 1)]
    [Dictionary('PALM_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PALM_STATUS: String read FPALM_STATUS write FPALM_STATUS;
    const PALM_STATUS_Name = 'PALM_STATUS';

    [Restrictions([NoValidate])]
    [Column('PALM_EMAIL_1', ftString, 50)]
    [Dictionary('PALM_EMAIL_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PALM_EMAIL_1: String read FPALM_EMAIL_1 write FPALM_EMAIL_1;
    const PALM_EMAIL_1_Name = 'PALM_EMAIL_1';

    [Restrictions([NoValidate])]
    [Column('PALM_EMAIL_2', ftString, 50)]
    [Dictionary('PALM_EMAIL_2', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PALM_EMAIL_2: String read FPALM_EMAIL_2 write FPALM_EMAIL_2;
    const PALM_EMAIL_2_Name = 'PALM_EMAIL_2';

    [Restrictions([NoValidate])]
    [Column('PALM_TOTALPEDIDO', ftBCD)]
    [Dictionary('PALM_TOTALPEDIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PALM_TOTALPEDIDO: Double read FPALM_TOTALPEDIDO write FPALM_TOTALPEDIDO;
    const PALM_TOTALPEDIDO_Name = 'PALM_TOTALPEDIDO';

    [Restrictions([NoValidate])]
    [Column('PALM_DATADIGITACAO', ftString, 10)]
    [Dictionary('PALM_DATADIGITACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PALM_DATADIGITACAO: String read FPALM_DATADIGITACAO write FPALM_DATADIGITACAO;
    const PALM_DATADIGITACAO_Name = 'PALM_DATADIGITACAO';

    [Restrictions([NoValidate])]
    [Column('PALM_HORADIGITACAO', ftString, 10)]
    [Dictionary('PALM_HORADIGITACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PALM_HORADIGITACAO: String read FPALM_HORADIGITACAO write FPALM_HORADIGITACAO;
    const PALM_HORADIGITACAO_Name = 'PALM_HORADIGITACAO';

    [Restrictions([NoValidate])]
    [Column('PALM_TOTALPESOBRUTO', ftBCD, 18, 4)]
    [Dictionary('PALM_TOTALPESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PALM_TOTALPESOBRUTO: Double read FPALM_TOTALPESOBRUTO write FPALM_TOTALPESOBRUTO;
    const PALM_TOTALPESOBRUTO_Name = 'PALM_TOTALPESOBRUTO';

    [Restrictions([NoValidate])]
    [Column('PALM_TOTALQTDPEDIDA', ftBCD, 18, 4)]
    [Dictionary('PALM_TOTALQTDPEDIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PALM_TOTALQTDPEDIDA: Double read FPALM_TOTALQTDPEDIDA write FPALM_TOTALQTDPEDIDA;
    const PALM_TOTALQTDPEDIDA_Name = 'PALM_TOTALQTDPEDIDA';

    [Restrictions([NoValidate])]
    [Column('PALM_TOTALNUMEROVOLUMES', ftBCD)]
    [Dictionary('PALM_TOTALNUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PALM_TOTALNUMEROVOLUMES: Double read FPALM_TOTALNUMEROVOLUMES write FPALM_TOTALNUMEROVOLUMES;
    const PALM_TOTALNUMEROVOLUMES_Name = 'PALM_TOTALNUMEROVOLUMES';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOCOMISSAO', ftString, 1)]
    [Dictionary('PES_TIPOCOMISSAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOCOMISSAO: String read FPES_TIPOCOMISSAO write FPES_TIPOCOMISSAO;
    const PES_TIPOCOMISSAO_Name = 'PES_TIPOCOMISSAO';

    [Restrictions([NoValidate])]
    [Column('PES_PERCENTUALCOMISSAO', ftBCD)]
    [Dictionary('PES_PERCENTUALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PES_PERCENTUALCOMISSAO: Double read FPES_PERCENTUALCOMISSAO write FPES_PERCENTUALCOMISSAO;
    const PES_PERCENTUALCOMISSAO_Name = 'PES_PERCENTUALCOMISSAO';

    [Restrictions([NoValidate])]
    [Column('CTB_CODIGO', ftInteger)]
    [Dictionary('CTB_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTB_CODIGO: Integer read FCTB_CODIGO write FCTB_CODIGO;
    const CTB_CODIGO_Name = 'CTB_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPALM_ImportacaoPedidos)

end.
