unit express.dbo.CPA_LOTEBAIXA;

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
  [Table('CPA_LoteBaixa', '')]
  TDtoCPA_LoteBaixa = class
  private
    { Private declarations } 
    FCPA_ID: Integer;
    FCOM_CODIGO: Integer;
    FCOM_RAZAO: String;
    FCPA_NOTAFISCAL: String;
    FCPA_NUMERODOCTO: String;
    FCPA_DESATIVADO: String;
    FBCO_CODIGO: Integer;
    FBCO_NOME: String;
    FPES_CODIGO: Integer;
    FCPA_OBSERVACAO: String;
    FCPA_HISTORICO: String;
    FCPA_DATALANCAMENTO: TDateTime;
    FCPA_DATAEMISSAO: TDateTime;
    FCPA_DATAVENCTO: TDateTime;
    FCPA_TOTALVALOR: Double;
    FCPA_TOTALVALORBAIXA: Double;
    FCPA_PERCENTUALDESCTO: Double;
    FCPA_DATAULTIMOPAGTO: TDateTime;
    FCPA_DATADESCTO: TDateTime;
    FCPA_VALORDESCTO: Double;
    FCPA_PERCENTUALMULTA: Double;
    FCPA_DATAMULTA: TDateTime;
    FCPA_VALORMULTA: Double;
    FCPA_TOTALOUTRASDESPESAS: Double;
    FCPA_PERCENTUALMORADIARIA: Double;
    FCPA_VALORMORADIARIA: Double;
    FCPA_PLANOCONTARATEIO: Double;
    FCPA_DC: String;
    FCPA_STATUS: String;
    FCPA_TIPODOCUMENTO: String;
    FCPA_CHEQUEVINCULADO: String;
    FPES_NOME: String;
    FCPA_DATAALTERACAO: TDateTime;
    FPES_DDD_TELEFONE_1: String;
    FPES_DDD_TELEFONE_2: String;
    FPES_DDD_TELEFONE_3: String;
    FPES_DDD_CELULAR_1: String;
    FCPA_INTEGRACAO: String;
    FCPA_DIAATRASO: Integer;
  public 
    { Public declarations } 
     const Table      = 'CPA_LoteBaixa';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPA_ID', ftInteger)]
    [Dictionary('CPA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPA_ID: Integer read FCPA_ID write FCPA_ID;
    const CPA_ID_Name = 'CPA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('COM_RAZAO', ftString, 100)]
    [Dictionary('COM_RAZAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_RAZAO: String read FCOM_RAZAO write FCOM_RAZAO;
    const COM_RAZAO_Name = 'COM_RAZAO';

    [Restrictions([NoValidate])]
    [Column('CPA_NOTAFISCAL', ftString, 9)]
    [Dictionary('CPA_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_NOTAFISCAL: String read FCPA_NOTAFISCAL write FCPA_NOTAFISCAL;
    const CPA_NOTAFISCAL_Name = 'CPA_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CPA_NUMERODOCTO', ftString, 20)]
    [Dictionary('CPA_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_NUMERODOCTO: String read FCPA_NUMERODOCTO write FCPA_NUMERODOCTO;
    const CPA_NUMERODOCTO_Name = 'CPA_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('CPA_DESATIVADO', ftString, 1)]
    [Dictionary('CPA_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_DESATIVADO: String read FCPA_DESATIVADO write FCPA_DESATIVADO;
    const CPA_DESATIVADO_Name = 'CPA_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('BCO_CODIGO', ftInteger)]
    [Dictionary('BCO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCO_CODIGO: Integer read FBCO_CODIGO write FBCO_CODIGO;
    const BCO_CODIGO_Name = 'BCO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('BCO_NOME', ftString, 50)]
    [Dictionary('BCO_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property BCO_NOME: String read FBCO_NOME write FBCO_NOME;
    const BCO_NOME_Name = 'BCO_NOME';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CPA_OBSERVACAO', ftString, 300)]
    [Dictionary('CPA_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_OBSERVACAO: String read FCPA_OBSERVACAO write FCPA_OBSERVACAO;
    const CPA_OBSERVACAO_Name = 'CPA_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('CPA_HISTORICO', ftString, 300)]
    [Dictionary('CPA_HISTORICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_HISTORICO: String read FCPA_HISTORICO write FCPA_HISTORICO;
    const CPA_HISTORICO_Name = 'CPA_HISTORICO';

    [Restrictions([NoValidate])]
    [Column('CPA_DATALANCAMENTO', ftDateTime)]
    [Dictionary('CPA_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CPA_DATALANCAMENTO: TDateTime read FCPA_DATALANCAMENTO write FCPA_DATALANCAMENTO;
    const CPA_DATALANCAMENTO_Name = 'CPA_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('CPA_DATAEMISSAO', ftDateTime)]
    [Dictionary('CPA_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CPA_DATAEMISSAO: TDateTime read FCPA_DATAEMISSAO write FCPA_DATAEMISSAO;
    const CPA_DATAEMISSAO_Name = 'CPA_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('CPA_DATAVENCTO', ftDateTime)]
    [Dictionary('CPA_DATAVENCTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CPA_DATAVENCTO: TDateTime read FCPA_DATAVENCTO write FCPA_DATAVENCTO;
    const CPA_DATAVENCTO_Name = 'CPA_DATAVENCTO';

    [Restrictions([NoValidate])]
    [Column('CPA_TOTALVALOR', ftBCD)]
    [Dictionary('CPA_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALVALOR: Double read FCPA_TOTALVALOR write FCPA_TOTALVALOR;
    const CPA_TOTALVALOR_Name = 'CPA_TOTALVALOR';

    [Restrictions([NoValidate])]
    [Column('CPA_TOTALVALORBAIXA', ftBCD)]
    [Dictionary('CPA_TOTALVALORBAIXA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALVALORBAIXA: Double read FCPA_TOTALVALORBAIXA write FCPA_TOTALVALORBAIXA;
    const CPA_TOTALVALORBAIXA_Name = 'CPA_TOTALVALORBAIXA';

    [Restrictions([NoValidate])]
    [Column('CPA_PERCENTUALDESCTO', ftBCD)]
    [Dictionary('CPA_PERCENTUALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_PERCENTUALDESCTO: Double read FCPA_PERCENTUALDESCTO write FCPA_PERCENTUALDESCTO;
    const CPA_PERCENTUALDESCTO_Name = 'CPA_PERCENTUALDESCTO';

    [Restrictions([NoValidate])]
    [Column('CPA_DATAULTIMOPAGTO', ftDateTime)]
    [Dictionary('CPA_DATAULTIMOPAGTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CPA_DATAULTIMOPAGTO: TDateTime read FCPA_DATAULTIMOPAGTO write FCPA_DATAULTIMOPAGTO;
    const CPA_DATAULTIMOPAGTO_Name = 'CPA_DATAULTIMOPAGTO';

    [Restrictions([NoValidate])]
    [Column('CPA_DATADESCTO', ftDateTime)]
    [Dictionary('CPA_DATADESCTO', 'Mensagem de validação', '', '', '', taCenter)]
    property CPA_DATADESCTO: TDateTime read FCPA_DATADESCTO write FCPA_DATADESCTO;
    const CPA_DATADESCTO_Name = 'CPA_DATADESCTO';

    [Restrictions([NoValidate])]
    [Column('CPA_VALORDESCTO', ftBCD)]
    [Dictionary('CPA_VALORDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_VALORDESCTO: Double read FCPA_VALORDESCTO write FCPA_VALORDESCTO;
    const CPA_VALORDESCTO_Name = 'CPA_VALORDESCTO';

    [Restrictions([NoValidate])]
    [Column('CPA_PERCENTUALMULTA', ftBCD)]
    [Dictionary('CPA_PERCENTUALMULTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_PERCENTUALMULTA: Double read FCPA_PERCENTUALMULTA write FCPA_PERCENTUALMULTA;
    const CPA_PERCENTUALMULTA_Name = 'CPA_PERCENTUALMULTA';

    [Restrictions([NoValidate])]
    [Column('CPA_DATAMULTA', ftDateTime)]
    [Dictionary('CPA_DATAMULTA', 'Mensagem de validação', '', '', '', taCenter)]
    property CPA_DATAMULTA: TDateTime read FCPA_DATAMULTA write FCPA_DATAMULTA;
    const CPA_DATAMULTA_Name = 'CPA_DATAMULTA';

    [Restrictions([NoValidate])]
    [Column('CPA_VALORMULTA', ftBCD)]
    [Dictionary('CPA_VALORMULTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_VALORMULTA: Double read FCPA_VALORMULTA write FCPA_VALORMULTA;
    const CPA_VALORMULTA_Name = 'CPA_VALORMULTA';

    [Restrictions([NoValidate])]
    [Column('CPA_TOTALOUTRASDESPESAS', ftBCD)]
    [Dictionary('CPA_TOTALOUTRASDESPESAS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_TOTALOUTRASDESPESAS: Double read FCPA_TOTALOUTRASDESPESAS write FCPA_TOTALOUTRASDESPESAS;
    const CPA_TOTALOUTRASDESPESAS_Name = 'CPA_TOTALOUTRASDESPESAS';

    [Restrictions([NoValidate])]
    [Column('CPA_PERCENTUALMORADIARIA', ftBCD)]
    [Dictionary('CPA_PERCENTUALMORADIARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_PERCENTUALMORADIARIA: Double read FCPA_PERCENTUALMORADIARIA write FCPA_PERCENTUALMORADIARIA;
    const CPA_PERCENTUALMORADIARIA_Name = 'CPA_PERCENTUALMORADIARIA';

    [Restrictions([NoValidate])]
    [Column('CPA_VALORMORADIARIA', ftBCD)]
    [Dictionary('CPA_VALORMORADIARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_VALORMORADIARIA: Double read FCPA_VALORMORADIARIA write FCPA_VALORMORADIARIA;
    const CPA_VALORMORADIARIA_Name = 'CPA_VALORMORADIARIA';

    [Restrictions([NoValidate])]
    [Column('CPA_PLANOCONTARATEIO', ftBCD)]
    [Dictionary('CPA_PLANOCONTARATEIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPA_PLANOCONTARATEIO: Double read FCPA_PLANOCONTARATEIO write FCPA_PLANOCONTARATEIO;
    const CPA_PLANOCONTARATEIO_Name = 'CPA_PLANOCONTARATEIO';

    [Restrictions([NoValidate])]
    [Column('CPA_DC', ftString, 1)]
    [Dictionary('CPA_DC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_DC: String read FCPA_DC write FCPA_DC;
    const CPA_DC_Name = 'CPA_DC';

    [Restrictions([NoValidate])]
    [Column('CPA_STATUS', ftString, 1)]
    [Dictionary('CPA_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_STATUS: String read FCPA_STATUS write FCPA_STATUS;
    const CPA_STATUS_Name = 'CPA_STATUS';

    [Restrictions([NoValidate])]
    [Column('CPA_TIPODOCUMENTO', ftString, 1)]
    [Dictionary('CPA_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_TIPODOCUMENTO: String read FCPA_TIPODOCUMENTO write FCPA_TIPODOCUMENTO;
    const CPA_TIPODOCUMENTO_Name = 'CPA_TIPODOCUMENTO';

    [Restrictions([NoValidate])]
    [Column('CPA_CHEQUEVINCULADO', ftString, 1)]
    [Dictionary('CPA_CHEQUEVINCULADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_CHEQUEVINCULADO: String read FCPA_CHEQUEVINCULADO write FCPA_CHEQUEVINCULADO;
    const CPA_CHEQUEVINCULADO_Name = 'CPA_CHEQUEVINCULADO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('CPA_DATAALTERACAO', ftDateTime)]
    [Dictionary('CPA_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CPA_DATAALTERACAO: TDateTime read FCPA_DATAALTERACAO write FCPA_DATAALTERACAO;
    const CPA_DATAALTERACAO_Name = 'CPA_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_TELEFONE_1', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONE_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONE_1: String read FPES_DDD_TELEFONE_1 write FPES_DDD_TELEFONE_1;
    const PES_DDD_TELEFONE_1_Name = 'PES_DDD_TELEFONE_1';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_TELEFONE_2', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONE_2', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONE_2: String read FPES_DDD_TELEFONE_2 write FPES_DDD_TELEFONE_2;
    const PES_DDD_TELEFONE_2_Name = 'PES_DDD_TELEFONE_2';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_TELEFONE_3', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONE_3', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONE_3: String read FPES_DDD_TELEFONE_3 write FPES_DDD_TELEFONE_3;
    const PES_DDD_TELEFONE_3_Name = 'PES_DDD_TELEFONE_3';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_CELULAR_1', ftString, 11)]
    [Dictionary('PES_DDD_CELULAR_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_CELULAR_1: String read FPES_DDD_CELULAR_1 write FPES_DDD_CELULAR_1;
    const PES_DDD_CELULAR_1_Name = 'PES_DDD_CELULAR_1';

    [Restrictions([NoValidate])]
    [Column('CPA_INTEGRACAO', ftString, 20)]
    [Dictionary('CPA_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CPA_INTEGRACAO: String read FCPA_INTEGRACAO write FCPA_INTEGRACAO;
    const CPA_INTEGRACAO_Name = 'CPA_INTEGRACAO';

    [Restrictions([NoValidate])]
    [Column('CPA_DIAATRASO', ftInteger)]
    [Dictionary('CPA_DIAATRASO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPA_DIAATRASO: Integer read FCPA_DIAATRASO write FCPA_DIAATRASO;
    const CPA_DIAATRASO_Name = 'CPA_DIAATRASO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCPA_LoteBaixa)

end.
