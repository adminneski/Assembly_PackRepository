unit express.dbo.CRE_00_01;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.cre_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('CRE_00_01', '')]
  [PrimaryKey('CRE_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CRE_ID')]
  TDtoCRE_00_01 = class
  private
    { Private declarations } 
    FCRE_ID: Integer;
    FCOM_CODIGO: Integer;
    FBCO_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FCTA_CODIGO: Integer;
    FCRE_TIPOBAIXA: String;
    FCRE_NOSSONUMERO: String;
    FCRE_DIGITONOSSONUMERO: String;
    FCRE_DATAEMISSAOORIGINAL: TDateTime;
    FCRE_DATAVENCTOORIGINAL: TDateTime;
    FCRE_TOTALVALORORIGINAL: Double;
    FCRE_TOTALJUROS: Double;
    FCRE_TOTALMULTA: Double;
    FCRE_TOTALCARTORIO: Double;
    FCRE_TOTALOUTRASDESPESAS: Double;
    FCRE_PERCENTUALDESCTO: Double;
    FCRE_TOTALDESCTO: Double;
    FCRE_DATADESCTO: TDateTime;
    FCRE_VALORDESCTO: Double;
    FCRE_PERCENTUALMULTA: Double;
    FCRE_DATAMULTA: TDateTime;
    FCRE_VALORMULTA: Double;
    FCRE_PERCENTUALMORADIARIA: Double;
    FCRE_VALORMORADIARIA: Double;
    FCRE_LIGARNOVENCTO: String;
    FCRE_OBSERVACAOBOLETO: String;
    FCRE_PROTESTAR: String;
    FCRE_DATAALTERACAO: TDateTime;
    FCRE_PES_CODIGO: Integer;
    FCRE_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'CRE_00_01';
    const PrimaryKey = 'CRE_ID';
    const Sequence   = 'SEQ_CRE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_ID', ftInteger)]
    [ForeignKey('CRE_00_01_fk', 'CRE_ID', 'CRE_00', 'CRE_ID', SetNull, SetNull)]
    [Dictionary('CRE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ID: Integer read FCRE_ID write FCRE_ID;
    const CRE_ID_Name = 'CRE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('BCO_CODIGO', ftInteger)]
    [Dictionary('BCO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCO_CODIGO: Integer read FBCO_CODIGO write FBCO_CODIGO;
    const BCO_CODIGO_Name = 'BCO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGO', ftInteger)]
    [Dictionary('CTA_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGO: Integer read FCTA_CODIGO write FCTA_CODIGO;
    const CTA_CODIGO_Name = 'CTA_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CRE_TIPOBAIXA', ftString, 1)]
    [Dictionary('CRE_TIPOBAIXA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_TIPOBAIXA: String read FCRE_TIPOBAIXA write FCRE_TIPOBAIXA;
    const CRE_TIPOBAIXA_Name = 'CRE_TIPOBAIXA';

    [Restrictions([NoValidate])]
    [Column('CRE_NOSSONUMERO', ftString, 20)]
    [Dictionary('CRE_NOSSONUMERO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_NOSSONUMERO: String read FCRE_NOSSONUMERO write FCRE_NOSSONUMERO;
    const CRE_NOSSONUMERO_Name = 'CRE_NOSSONUMERO';

    [Restrictions([NoValidate])]
    [Column('CRE_DIGITONOSSONUMERO', ftString, 1)]
    [Dictionary('CRE_DIGITONOSSONUMERO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_DIGITONOSSONUMERO: String read FCRE_DIGITONOSSONUMERO write FCRE_DIGITONOSSONUMERO;
    const CRE_DIGITONOSSONUMERO_Name = 'CRE_DIGITONOSSONUMERO';

    [Restrictions([NoValidate])]
    [Column('CRE_DATAEMISSAOORIGINAL', ftDateTime)]
    [Dictionary('CRE_DATAEMISSAOORIGINAL', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATAEMISSAOORIGINAL: TDateTime read FCRE_DATAEMISSAOORIGINAL write FCRE_DATAEMISSAOORIGINAL;
    const CRE_DATAEMISSAOORIGINAL_Name = 'CRE_DATAEMISSAOORIGINAL';

    [Restrictions([NoValidate])]
    [Column('CRE_DATAVENCTOORIGINAL', ftDateTime)]
    [Dictionary('CRE_DATAVENCTOORIGINAL', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATAVENCTOORIGINAL: TDateTime read FCRE_DATAVENCTOORIGINAL write FCRE_DATAVENCTOORIGINAL;
    const CRE_DATAVENCTOORIGINAL_Name = 'CRE_DATAVENCTOORIGINAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALVALORORIGINAL', ftBCD)]
    [Dictionary('CRE_TOTALVALORORIGINAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALVALORORIGINAL: Double read FCRE_TOTALVALORORIGINAL write FCRE_TOTALVALORORIGINAL;
    const CRE_TOTALVALORORIGINAL_Name = 'CRE_TOTALVALORORIGINAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALJUROS', ftBCD)]
    [Dictionary('CRE_TOTALJUROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALJUROS: Double read FCRE_TOTALJUROS write FCRE_TOTALJUROS;
    const CRE_TOTALJUROS_Name = 'CRE_TOTALJUROS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALMULTA', ftBCD)]
    [Dictionary('CRE_TOTALMULTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALMULTA: Double read FCRE_TOTALMULTA write FCRE_TOTALMULTA;
    const CRE_TOTALMULTA_Name = 'CRE_TOTALMULTA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALCARTORIO', ftBCD)]
    [Dictionary('CRE_TOTALCARTORIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALCARTORIO: Double read FCRE_TOTALCARTORIO write FCRE_TOTALCARTORIO;
    const CRE_TOTALCARTORIO_Name = 'CRE_TOTALCARTORIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALOUTRASDESPESAS', ftBCD)]
    [Dictionary('CRE_TOTALOUTRASDESPESAS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALOUTRASDESPESAS: Double read FCRE_TOTALOUTRASDESPESAS write FCRE_TOTALOUTRASDESPESAS;
    const CRE_TOTALOUTRASDESPESAS_Name = 'CRE_TOTALOUTRASDESPESAS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_PERCENTUALDESCTO', ftBCD)]
    [Dictionary('CRE_PERCENTUALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_PERCENTUALDESCTO: Double read FCRE_PERCENTUALDESCTO write FCRE_PERCENTUALDESCTO;
    const CRE_PERCENTUALDESCTO_Name = 'CRE_PERCENTUALDESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALDESCTO', ftBCD)]
    [Dictionary('CRE_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALDESCTO: Double read FCRE_TOTALDESCTO write FCRE_TOTALDESCTO;
    const CRE_TOTALDESCTO_Name = 'CRE_TOTALDESCTO';

    [Restrictions([NoValidate])]
    [Column('CRE_DATADESCTO', ftDateTime)]
    [Dictionary('CRE_DATADESCTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATADESCTO: TDateTime read FCRE_DATADESCTO write FCRE_DATADESCTO;
    const CRE_DATADESCTO_Name = 'CRE_DATADESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_VALORDESCTO', ftBCD)]
    [Dictionary('CRE_VALORDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_VALORDESCTO: Double read FCRE_VALORDESCTO write FCRE_VALORDESCTO;
    const CRE_VALORDESCTO_Name = 'CRE_VALORDESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_PERCENTUALMULTA', ftBCD)]
    [Dictionary('CRE_PERCENTUALMULTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_PERCENTUALMULTA: Double read FCRE_PERCENTUALMULTA write FCRE_PERCENTUALMULTA;
    const CRE_PERCENTUALMULTA_Name = 'CRE_PERCENTUALMULTA';

    [Restrictions([NoValidate])]
    [Column('CRE_DATAMULTA', ftDateTime)]
    [Dictionary('CRE_DATAMULTA', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATAMULTA: TDateTime read FCRE_DATAMULTA write FCRE_DATAMULTA;
    const CRE_DATAMULTA_Name = 'CRE_DATAMULTA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_VALORMULTA', ftBCD)]
    [Dictionary('CRE_VALORMULTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_VALORMULTA: Double read FCRE_VALORMULTA write FCRE_VALORMULTA;
    const CRE_VALORMULTA_Name = 'CRE_VALORMULTA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_PERCENTUALMORADIARIA', ftBCD)]
    [Dictionary('CRE_PERCENTUALMORADIARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_PERCENTUALMORADIARIA: Double read FCRE_PERCENTUALMORADIARIA write FCRE_PERCENTUALMORADIARIA;
    const CRE_PERCENTUALMORADIARIA_Name = 'CRE_PERCENTUALMORADIARIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_VALORMORADIARIA', ftBCD)]
    [Dictionary('CRE_VALORMORADIARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_VALORMORADIARIA: Double read FCRE_VALORMORADIARIA write FCRE_VALORMORADIARIA;
    const CRE_VALORMORADIARIA_Name = 'CRE_VALORMORADIARIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_LIGARNOVENCTO', ftString, 1)]
    [Dictionary('CRE_LIGARNOVENCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_LIGARNOVENCTO: String read FCRE_LIGARNOVENCTO write FCRE_LIGARNOVENCTO;
    const CRE_LIGARNOVENCTO_Name = 'CRE_LIGARNOVENCTO';

    [Restrictions([NoValidate])]
    [Column('CRE_OBSERVACAOBOLETO', ftString, 5000)]
    [Dictionary('CRE_OBSERVACAOBOLETO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_OBSERVACAOBOLETO: String read FCRE_OBSERVACAOBOLETO write FCRE_OBSERVACAOBOLETO;
    const CRE_OBSERVACAOBOLETO_Name = 'CRE_OBSERVACAOBOLETO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_PROTESTAR', ftString, 1)]
    [Dictionary('CRE_PROTESTAR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_PROTESTAR: String read FCRE_PROTESTAR write FCRE_PROTESTAR;
    const CRE_PROTESTAR_Name = 'CRE_PROTESTAR';

    [Restrictions([NoValidate])]
    [Column('CRE_DATAALTERACAO', ftDateTime)]
    [Dictionary('CRE_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CRE_DATAALTERACAO: TDateTime read FCRE_DATAALTERACAO write FCRE_DATAALTERACAO;
    const CRE_DATAALTERACAO_Name = 'CRE_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CRE_PES_CODIGO', ftInteger)]
    [Dictionary('CRE_PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_PES_CODIGO: Integer read FCRE_PES_CODIGO write FCRE_PES_CODIGO;
    const CRE_PES_CODIGO_Name = 'CRE_PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CRE_ID_OLD', ftInteger)]
    [Dictionary('CRE_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ID_OLD: Integer read FCRE_ID_OLD write FCRE_ID_OLD;
    const CRE_ID_OLD_Name = 'CRE_ID_OLD';

  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoCRE_00_01)

end.
