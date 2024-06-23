unit express.dbo.CRB_00;

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
  [Table('CRB_00', '')]
  [PrimaryKey('CRB_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CRB_ID')]
  TDtoCRB_00 = class
  private
    { Private declarations } 
    FCRB_ID: Integer;
    FCOM_CODIGO: Integer;
    FTRP_CODIGO: Integer;
    FVEI_CODIGO: Integer;
    FPLC_CODIGO: Integer;
    FCCU_CODIGO: Integer;
    FCRB_DATASAIDA: TDateTime;
    FCRB_NUMEROCONTRATO: String;
    FPES_CODIGOCONTRATANTE: Integer;
    FPES_CODIGOCONTRATADO: Integer;
    FCID_IBGEORIGEM: String;
    FCID_IBGEDESTINO: String;
    FCRB_CONDICAOESPECIAL: String;
    FCRB_MERCADORIATRANSPORTADA: String;
    FCRB_TOTALPESO: Double;
    FCRB_TOTALIRRF: Double;
    FCRB_TOTALINSS: Double;
    FCRB_TOTALFRETE: Double;
    FCRB_TOTALMULTA: Double;
    FCRB_TOTALPEDAGIO: Double;
    FCRB_TOTALOUTROS: Double;
    FCRB_TOTALREEMBOLSO: Double;
    FCRB_TOTALSEST_SENAT: Double;
    FCRB_TOTALADIANTAMENTO: Double;
    FCRB_TOTALCONTRATO: Double;
    FCRB_PROCESSADO: String;
    FCRB_CANCELADO: String;
    FCRB_DATACANCELAMENTO: TDateTime;
    FCRB_OBSERVACAOCANCELAMENTO: String;
    FCRB_INTEGRACAO: String;
    FCRB_DATAALTERACAO: TDateTime;
    FCRB_TIPOMOVTO: String;
    FCRB_NOTAFISCAL: String;
    FCRB_TOTALAJUSTE: Double;
    FCRB_ESPECIEVOLUMES: String;
    FCRB_TOTALNUMEROVOLUMES: Double;
    FCRB_DATAEMISSAO: TDateTime;
    FCRB_CIDADEORIGEM: String;
    FCRB_UFORIGEM: String;
    FCRB_CIDADEDESTINO: String;
    FCRB_UFDESTINO: String;
    FCRB_ID_OLD: Integer;
    FCRB_INTEGRACAO_OLD: String;
  public 
    { Public declarations } 
     const Table      = 'CRB_00';
     const PrimaryKey = 'CRB_ID';
     const Sequence   = 'SEQ_CRB_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_ID', ftInteger)]
    [Dictionary('CRB_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRB_ID: Integer read FCRB_ID write FCRB_ID;
    const CRB_ID_Name = 'CRB_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('TRP_CODIGO', ftInteger)]
    [Dictionary('TRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TRP_CODIGO: Integer read FTRP_CODIGO write FTRP_CODIGO;
    const TRP_CODIGO_Name = 'TRP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VEI_CODIGO', ftInteger)]
    [Dictionary('VEI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEI_CODIGO: Integer read FVEI_CODIGO write FVEI_CODIGO;
    const VEI_CODIGO_Name = 'VEI_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGO', ftInteger)]
    [Dictionary('PLC_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGO: Integer read FPLC_CODIGO write FPLC_CODIGO;
    const PLC_CODIGO_Name = 'PLC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGO', ftInteger)]
    [Dictionary('CCU_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGO: Integer read FCCU_CODIGO write FCCU_CODIGO;
    const CCU_CODIGO_Name = 'CCU_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_DATASAIDA', ftDateTime)]
    [Dictionary('CRB_DATASAIDA', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRB_DATASAIDA: TDateTime read FCRB_DATASAIDA write FCRB_DATASAIDA;
    const CRB_DATASAIDA_Name = 'CRB_DATASAIDA';

    [Restrictions([NoValidate])]
    [Column('CRB_NUMEROCONTRATO', ftString, 6)]
    [Dictionary('CRB_NUMEROCONTRATO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_NUMEROCONTRATO: String read FCRB_NUMEROCONTRATO write FCRB_NUMEROCONTRATO;
    const CRB_NUMEROCONTRATO_Name = 'CRB_NUMEROCONTRATO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGOCONTRATANTE', ftInteger)]
    [Dictionary('PES_CODIGOCONTRATANTE', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGOCONTRATANTE: Integer read FPES_CODIGOCONTRATANTE write FPES_CODIGOCONTRATANTE;
    const PES_CODIGOCONTRATANTE_Name = 'PES_CODIGOCONTRATANTE';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGOCONTRATADO', ftInteger)]
    [Dictionary('PES_CODIGOCONTRATADO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGOCONTRATADO: Integer read FPES_CODIGOCONTRATADO write FPES_CODIGOCONTRATADO;
    const PES_CODIGOCONTRATADO_Name = 'PES_CODIGOCONTRATADO';

    [Restrictions([NoValidate])]
    [Column('CID_IBGEORIGEM', ftString, 7)]
    [Dictionary('CID_IBGEORIGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGEORIGEM: String read FCID_IBGEORIGEM write FCID_IBGEORIGEM;
    const CID_IBGEORIGEM_Name = 'CID_IBGEORIGEM';

    [Restrictions([NoValidate])]
    [Column('CID_IBGEDESTINO', ftString, 7)]
    [Dictionary('CID_IBGEDESTINO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGEDESTINO: String read FCID_IBGEDESTINO write FCID_IBGEDESTINO;
    const CID_IBGEDESTINO_Name = 'CID_IBGEDESTINO';

    [Restrictions([NoValidate])]
    [Column('CRB_CONDICAOESPECIAL', ftString, 300)]
    [Dictionary('CRB_CONDICAOESPECIAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_CONDICAOESPECIAL: String read FCRB_CONDICAOESPECIAL write FCRB_CONDICAOESPECIAL;
    const CRB_CONDICAOESPECIAL_Name = 'CRB_CONDICAOESPECIAL';

    [Restrictions([NoValidate])]
    [Column('CRB_MERCADORIATRANSPORTADA', ftString, 300)]
    [Dictionary('CRB_MERCADORIATRANSPORTADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_MERCADORIATRANSPORTADA: String read FCRB_MERCADORIATRANSPORTADA write FCRB_MERCADORIATRANSPORTADA;
    const CRB_MERCADORIATRANSPORTADA_Name = 'CRB_MERCADORIATRANSPORTADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_TOTALPESO', ftBCD)]
    [Dictionary('CRB_TOTALPESO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRB_TOTALPESO: Double read FCRB_TOTALPESO write FCRB_TOTALPESO;
    const CRB_TOTALPESO_Name = 'CRB_TOTALPESO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_TOTALIRRF', ftBCD)]
    [Dictionary('CRB_TOTALIRRF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRB_TOTALIRRF: Double read FCRB_TOTALIRRF write FCRB_TOTALIRRF;
    const CRB_TOTALIRRF_Name = 'CRB_TOTALIRRF';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_TOTALINSS', ftBCD)]
    [Dictionary('CRB_TOTALINSS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRB_TOTALINSS: Double read FCRB_TOTALINSS write FCRB_TOTALINSS;
    const CRB_TOTALINSS_Name = 'CRB_TOTALINSS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_TOTALFRETE', ftBCD)]
    [Dictionary('CRB_TOTALFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRB_TOTALFRETE: Double read FCRB_TOTALFRETE write FCRB_TOTALFRETE;
    const CRB_TOTALFRETE_Name = 'CRB_TOTALFRETE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_TOTALMULTA', ftBCD)]
    [Dictionary('CRB_TOTALMULTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRB_TOTALMULTA: Double read FCRB_TOTALMULTA write FCRB_TOTALMULTA;
    const CRB_TOTALMULTA_Name = 'CRB_TOTALMULTA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_TOTALPEDAGIO', ftBCD)]
    [Dictionary('CRB_TOTALPEDAGIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRB_TOTALPEDAGIO: Double read FCRB_TOTALPEDAGIO write FCRB_TOTALPEDAGIO;
    const CRB_TOTALPEDAGIO_Name = 'CRB_TOTALPEDAGIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_TOTALOUTROS', ftBCD)]
    [Dictionary('CRB_TOTALOUTROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRB_TOTALOUTROS: Double read FCRB_TOTALOUTROS write FCRB_TOTALOUTROS;
    const CRB_TOTALOUTROS_Name = 'CRB_TOTALOUTROS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_TOTALREEMBOLSO', ftBCD)]
    [Dictionary('CRB_TOTALREEMBOLSO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRB_TOTALREEMBOLSO: Double read FCRB_TOTALREEMBOLSO write FCRB_TOTALREEMBOLSO;
    const CRB_TOTALREEMBOLSO_Name = 'CRB_TOTALREEMBOLSO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_TOTALSEST_SENAT', ftBCD)]
    [Dictionary('CRB_TOTALSEST_SENAT', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRB_TOTALSEST_SENAT: Double read FCRB_TOTALSEST_SENAT write FCRB_TOTALSEST_SENAT;
    const CRB_TOTALSEST_SENAT_Name = 'CRB_TOTALSEST_SENAT';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_TOTALADIANTAMENTO', ftBCD)]
    [Dictionary('CRB_TOTALADIANTAMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRB_TOTALADIANTAMENTO: Double read FCRB_TOTALADIANTAMENTO write FCRB_TOTALADIANTAMENTO;
    const CRB_TOTALADIANTAMENTO_Name = 'CRB_TOTALADIANTAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_TOTALCONTRATO', ftBCD)]
    [Dictionary('CRB_TOTALCONTRATO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRB_TOTALCONTRATO: Double read FCRB_TOTALCONTRATO write FCRB_TOTALCONTRATO;
    const CRB_TOTALCONTRATO_Name = 'CRB_TOTALCONTRATO';

    [Restrictions([NoValidate])]
    [Column('CRB_PROCESSADO', ftString, 1)]
    [Dictionary('CRB_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_PROCESSADO: String read FCRB_PROCESSADO write FCRB_PROCESSADO;
    const CRB_PROCESSADO_Name = 'CRB_PROCESSADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_CANCELADO', ftString, 1)]
    [Dictionary('CRB_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_CANCELADO: String read FCRB_CANCELADO write FCRB_CANCELADO;
    const CRB_CANCELADO_Name = 'CRB_CANCELADO';

    [Restrictions([NoValidate])]
    [Column('CRB_DATACANCELAMENTO', ftDateTime)]
    [Dictionary('CRB_DATACANCELAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CRB_DATACANCELAMENTO: TDateTime read FCRB_DATACANCELAMENTO write FCRB_DATACANCELAMENTO;
    const CRB_DATACANCELAMENTO_Name = 'CRB_DATACANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('CRB_OBSERVACAOCANCELAMENTO', ftString, 300)]
    [Dictionary('CRB_OBSERVACAOCANCELAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_OBSERVACAOCANCELAMENTO: String read FCRB_OBSERVACAOCANCELAMENTO write FCRB_OBSERVACAOCANCELAMENTO;
    const CRB_OBSERVACAOCANCELAMENTO_Name = 'CRB_OBSERVACAOCANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('CRB_INTEGRACAO', ftString, 20)]
    [Dictionary('CRB_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_INTEGRACAO: String read FCRB_INTEGRACAO write FCRB_INTEGRACAO;
    const CRB_INTEGRACAO_Name = 'CRB_INTEGRACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_DATAALTERACAO', ftDateTime)]
    [Dictionary('CRB_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRB_DATAALTERACAO: TDateTime read FCRB_DATAALTERACAO write FCRB_DATAALTERACAO;
    const CRB_DATAALTERACAO_Name = 'CRB_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CRB_TIPOMOVTO', ftString, 3)]
    [Dictionary('CRB_TIPOMOVTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_TIPOMOVTO: String read FCRB_TIPOMOVTO write FCRB_TIPOMOVTO;
    const CRB_TIPOMOVTO_Name = 'CRB_TIPOMOVTO';

    [Restrictions([NoValidate])]
    [Column('CRB_NOTAFISCAL', ftString, 500)]
    [Dictionary('CRB_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_NOTAFISCAL: String read FCRB_NOTAFISCAL write FCRB_NOTAFISCAL;
    const CRB_NOTAFISCAL_Name = 'CRB_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CRB_TOTALAJUSTE', ftBCD)]
    [Dictionary('CRB_TOTALAJUSTE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRB_TOTALAJUSTE: Double read FCRB_TOTALAJUSTE write FCRB_TOTALAJUSTE;
    const CRB_TOTALAJUSTE_Name = 'CRB_TOTALAJUSTE';

    [Restrictions([NoValidate])]
    [Column('CRB_ESPECIEVOLUMES', ftString, 15)]
    [Dictionary('CRB_ESPECIEVOLUMES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_ESPECIEVOLUMES: String read FCRB_ESPECIEVOLUMES write FCRB_ESPECIEVOLUMES;
    const CRB_ESPECIEVOLUMES_Name = 'CRB_ESPECIEVOLUMES';

    [Restrictions([NoValidate])]
    [Column('CRB_TOTALNUMEROVOLUMES', ftBCD)]
    [Dictionary('CRB_TOTALNUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRB_TOTALNUMEROVOLUMES: Double read FCRB_TOTALNUMEROVOLUMES write FCRB_TOTALNUMEROVOLUMES;
    const CRB_TOTALNUMEROVOLUMES_Name = 'CRB_TOTALNUMEROVOLUMES';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRB_DATAEMISSAO', ftDateTime)]
    [Dictionary('CRB_DATAEMISSAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRB_DATAEMISSAO: TDateTime read FCRB_DATAEMISSAO write FCRB_DATAEMISSAO;
    const CRB_DATAEMISSAO_Name = 'CRB_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('CRB_CIDADEORIGEM', ftString, 100)]
    [Dictionary('CRB_CIDADEORIGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_CIDADEORIGEM: String read FCRB_CIDADEORIGEM write FCRB_CIDADEORIGEM;
    const CRB_CIDADEORIGEM_Name = 'CRB_CIDADEORIGEM';

    [Restrictions([NoValidate])]
    [Column('CRB_UFORIGEM', ftString, 2)]
    [Dictionary('CRB_UFORIGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_UFORIGEM: String read FCRB_UFORIGEM write FCRB_UFORIGEM;
    const CRB_UFORIGEM_Name = 'CRB_UFORIGEM';

    [Restrictions([NoValidate])]
    [Column('CRB_CIDADEDESTINO', ftString, 100)]
    [Dictionary('CRB_CIDADEDESTINO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_CIDADEDESTINO: String read FCRB_CIDADEDESTINO write FCRB_CIDADEDESTINO;
    const CRB_CIDADEDESTINO_Name = 'CRB_CIDADEDESTINO';

    [Restrictions([NoValidate])]
    [Column('CRB_UFDESTINO', ftString, 2)]
    [Dictionary('CRB_UFDESTINO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_UFDESTINO: String read FCRB_UFDESTINO write FCRB_UFDESTINO;
    const CRB_UFDESTINO_Name = 'CRB_UFDESTINO';

    [Restrictions([NoValidate])]
    [Column('CRB_ID_OLD', ftInteger)]
    [Dictionary('CRB_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRB_ID_OLD: Integer read FCRB_ID_OLD write FCRB_ID_OLD;
    const CRB_ID_OLD_Name = 'CRB_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('CRB_INTEGRACAO_OLD', ftString, 50)]
    [Dictionary('CRB_INTEGRACAO_OLD', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRB_INTEGRACAO_OLD: String read FCRB_INTEGRACAO_OLD write FCRB_INTEGRACAO_OLD;
    const CRB_INTEGRACAO_OLD_Name = 'CRB_INTEGRACAO_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCRB_00)

end.
