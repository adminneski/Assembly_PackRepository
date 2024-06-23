unit express.dbo.CIAP_00;

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
  [Table('CIAP_00', '')]
  [PrimaryKey('CIAP_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CIAP_ID')]
  TDtoCIAP_00 = class
  private
    { Private declarations } 
    FCIAP_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FPRI_CODIGO: Integer;
    FCIAP_TIPOMERCADORIA: String;
    FCIAP_NIVELCONTA: String;
    FCIAP_TIPOCONTA: String;
    FCIAP_CODIGOCONTA: String;
    FCIAP_NOMECONTA: String;
    FCIAP_TOTALNUMEROPARCELAS: Integer;
    FCIAP_CODIGONATUREZACONTA: String;
    FCIAP_CODIGOCENTROCUSTO: String;
    FCIAP_NOMECENTROCUSTO: String;
    FCIAP_VIDAUTILBEM: Integer;
    FCIAP_FUNCAOBEM: String;
    FCIAP_TIPOEMITENTE: String;
    FPES_CODIGO: Integer;
    FMNF_CODIGO: String;
    FCIAP_SERIE: String;
    FCIAP_NOTAFISCAL: String;
    FCIAP_CHAVEACESSONF: String;
    FCIAP_DATAEMISSAONF: TDateTime;
    FCIAP_DATAINCLUSAOCONTA: TDateTime;
    FCIAP_DESATIVADO: String;
    FCIAP_DATAALTERACAO: TDateTime;
    FCIAP_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'CIAP_00';
     const PrimaryKey = 'CIAP_ID';
     const Sequence   = 'SEQ_CIAP_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CIAP_ID', ftInteger)]
    [Dictionary('CIAP_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CIAP_ID: Integer read FCIAP_ID write FCIAP_ID;
    const CIAP_ID_Name = 'CIAP_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRI_CODIGO', ftInteger)]
    [Dictionary('PRI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRI_CODIGO: Integer read FPRI_CODIGO write FPRI_CODIGO;
    const PRI_CODIGO_Name = 'PRI_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CIAP_TIPOMERCADORIA', ftString, 1)]
    [Dictionary('CIAP_TIPOMERCADORIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIAP_TIPOMERCADORIA: String read FCIAP_TIPOMERCADORIA write FCIAP_TIPOMERCADORIA;
    const CIAP_TIPOMERCADORIA_Name = 'CIAP_TIPOMERCADORIA';

    [Restrictions([NoValidate])]
    [Column('CIAP_NIVELCONTA', ftString, 1)]
    [Dictionary('CIAP_NIVELCONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIAP_NIVELCONTA: String read FCIAP_NIVELCONTA write FCIAP_NIVELCONTA;
    const CIAP_NIVELCONTA_Name = 'CIAP_NIVELCONTA';

    [Restrictions([NoValidate])]
    [Column('CIAP_TIPOCONTA', ftString, 1)]
    [Dictionary('CIAP_TIPOCONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIAP_TIPOCONTA: String read FCIAP_TIPOCONTA write FCIAP_TIPOCONTA;
    const CIAP_TIPOCONTA_Name = 'CIAP_TIPOCONTA';

    [Restrictions([NoValidate])]
    [Column('CIAP_CODIGOCONTA', ftString, 60)]
    [Dictionary('CIAP_CODIGOCONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIAP_CODIGOCONTA: String read FCIAP_CODIGOCONTA write FCIAP_CODIGOCONTA;
    const CIAP_CODIGOCONTA_Name = 'CIAP_CODIGOCONTA';

    [Restrictions([NoValidate])]
    [Column('CIAP_NOMECONTA', ftString, 60)]
    [Dictionary('CIAP_NOMECONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIAP_NOMECONTA: String read FCIAP_NOMECONTA write FCIAP_NOMECONTA;
    const CIAP_NOMECONTA_Name = 'CIAP_NOMECONTA';

    [Restrictions([NoValidate])]
    [Column('CIAP_TOTALNUMEROPARCELAS', ftInteger)]
    [Dictionary('CIAP_TOTALNUMEROPARCELAS', 'Mensagem de validação', '0', '', '', taCenter)]
    property CIAP_TOTALNUMEROPARCELAS: Integer read FCIAP_TOTALNUMEROPARCELAS write FCIAP_TOTALNUMEROPARCELAS;
    const CIAP_TOTALNUMEROPARCELAS_Name = 'CIAP_TOTALNUMEROPARCELAS';

    [Restrictions([NoValidate])]
    [Column('CIAP_CODIGONATUREZACONTA', ftString, 2)]
    [Dictionary('CIAP_CODIGONATUREZACONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIAP_CODIGONATUREZACONTA: String read FCIAP_CODIGONATUREZACONTA write FCIAP_CODIGONATUREZACONTA;
    const CIAP_CODIGONATUREZACONTA_Name = 'CIAP_CODIGONATUREZACONTA';

    [Restrictions([NoValidate])]
    [Column('CIAP_CODIGOCENTROCUSTO', ftString, 60)]
    [Dictionary('CIAP_CODIGOCENTROCUSTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIAP_CODIGOCENTROCUSTO: String read FCIAP_CODIGOCENTROCUSTO write FCIAP_CODIGOCENTROCUSTO;
    const CIAP_CODIGOCENTROCUSTO_Name = 'CIAP_CODIGOCENTROCUSTO';

    [Restrictions([NoValidate])]
    [Column('CIAP_NOMECENTROCUSTO', ftString, 60)]
    [Dictionary('CIAP_NOMECENTROCUSTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIAP_NOMECENTROCUSTO: String read FCIAP_NOMECENTROCUSTO write FCIAP_NOMECENTROCUSTO;
    const CIAP_NOMECENTROCUSTO_Name = 'CIAP_NOMECENTROCUSTO';

    [Restrictions([NoValidate])]
    [Column('CIAP_VIDAUTILBEM', ftInteger)]
    [Dictionary('CIAP_VIDAUTILBEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property CIAP_VIDAUTILBEM: Integer read FCIAP_VIDAUTILBEM write FCIAP_VIDAUTILBEM;
    const CIAP_VIDAUTILBEM_Name = 'CIAP_VIDAUTILBEM';

    [Restrictions([NoValidate])]
    [Column('CIAP_FUNCAOBEM', ftString, 60)]
    [Dictionary('CIAP_FUNCAOBEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIAP_FUNCAOBEM: String read FCIAP_FUNCAOBEM write FCIAP_FUNCAOBEM;
    const CIAP_FUNCAOBEM_Name = 'CIAP_FUNCAOBEM';

    [Restrictions([NoValidate])]
    [Column('CIAP_TIPOEMITENTE', ftString, 1)]
    [Dictionary('CIAP_TIPOEMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIAP_TIPOEMITENTE: String read FCIAP_TIPOEMITENTE write FCIAP_TIPOEMITENTE;
    const CIAP_TIPOEMITENTE_Name = 'CIAP_TIPOEMITENTE';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CIAP_SERIE', ftString, 3)]
    [Dictionary('CIAP_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIAP_SERIE: String read FCIAP_SERIE write FCIAP_SERIE;
    const CIAP_SERIE_Name = 'CIAP_SERIE';

    [Restrictions([NoValidate])]
    [Column('CIAP_NOTAFISCAL', ftString, 9)]
    [Dictionary('CIAP_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIAP_NOTAFISCAL: String read FCIAP_NOTAFISCAL write FCIAP_NOTAFISCAL;
    const CIAP_NOTAFISCAL_Name = 'CIAP_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CIAP_CHAVEACESSONF', ftString, 44)]
    [Dictionary('CIAP_CHAVEACESSONF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIAP_CHAVEACESSONF: String read FCIAP_CHAVEACESSONF write FCIAP_CHAVEACESSONF;
    const CIAP_CHAVEACESSONF_Name = 'CIAP_CHAVEACESSONF';

    [Restrictions([NoValidate])]
    [Column('CIAP_DATAEMISSAONF', ftDateTime)]
    [Dictionary('CIAP_DATAEMISSAONF', 'Mensagem de validação', '', '', '', taCenter)]
    property CIAP_DATAEMISSAONF: TDateTime read FCIAP_DATAEMISSAONF write FCIAP_DATAEMISSAONF;
    const CIAP_DATAEMISSAONF_Name = 'CIAP_DATAEMISSAONF';

    [Restrictions([NoValidate])]
    [Column('CIAP_DATAINCLUSAOCONTA', ftDateTime)]
    [Dictionary('CIAP_DATAINCLUSAOCONTA', 'Mensagem de validação', '', '', '', taCenter)]
    property CIAP_DATAINCLUSAOCONTA: TDateTime read FCIAP_DATAINCLUSAOCONTA write FCIAP_DATAINCLUSAOCONTA;
    const CIAP_DATAINCLUSAOCONTA_Name = 'CIAP_DATAINCLUSAOCONTA';

    [Restrictions([NoValidate])]
    [Column('CIAP_DESATIVADO', ftString, 1)]
    [Dictionary('CIAP_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CIAP_DESATIVADO: String read FCIAP_DESATIVADO write FCIAP_DESATIVADO;
    const CIAP_DESATIVADO_Name = 'CIAP_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('CIAP_DATAALTERACAO', ftDateTime)]
    [Dictionary('CIAP_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CIAP_DATAALTERACAO: TDateTime read FCIAP_DATAALTERACAO write FCIAP_DATAALTERACAO;
    const CIAP_DATAALTERACAO_Name = 'CIAP_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CIAP_ID_OLD', ftInteger)]
    [Dictionary('CIAP_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CIAP_ID_OLD: Integer read FCIAP_ID_OLD write FCIAP_ID_OLD;
    const CIAP_ID_OLD_Name = 'CIAP_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCIAP_00)

end.
