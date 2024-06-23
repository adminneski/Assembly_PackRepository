unit express.dbo.REL_V01_RPA;

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
  [Table('REL_V01_RPA', '')]
  TDtoREL_V01_RPA = class
  private
    { Private declarations } 
    FRPA_ID: Integer;
    FCOM_CODIGO: Integer;
    FRPA_NUMERODOCTO: String;
    FRPA_PROCESSADO: String;
    FRPA_CANCELADO: String;
    FRPA_DATALANCAMENTO: TDateTime;
    FRPA_DATAVENCTO: TDateTime;
    FRPA_COMPETENCIA: String;
    FRPA_TOTALLIQUIDO: Double;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FRPA_NOTAFISCAL: String;
    FRPA_TIPOSERVICO: String;
    FRPA_TOTALIRF: Double;
    FRPA_TOTALSEST_SENAT: Double;
    FRPA_TOTALINSSSEGURO: Double;
    FRPA_TOTALINSS: Double;
    FRPA_PERCENTUALINSS: Double;
    FRPA_TOTALBCSERVICOPRESTADO: Double;
    FRPA_TOTALBASECALCULOINSS: Double;
    FRPA_TOTALPENSAOALIMENTICIA: Double;
    FRPA_TOTALSERVICOPRESTADO: Double;
    FRPA_CAMPOLIVRE_1: String;
    FRPA_TOTALCAMPOLIVRE_1: Double;
    FRPA_CAMPOLIVRE_2: String;
    FRPA_TOTALCAMPOLIVRE_2: Double;
    FRPA_CAMPOLIVRE_3: String;
    FRPA_TOTALCAMPOLIVRE_3: Double;
    FRPA_DATACANCELAMENTO: TDateTime;
    FRPA_OBSERVACAOCANCELAMENTO: String;
    FRPA_DATAALTERACAO: TDateTime;
    FPES_CNPJ_CPF: String;
    FPES_IE_CI: String;
    FPES_TIPOPESSOA: String;
    FPES_INSCRICAOINSS: String;
    FCOM_CNPJ_CPF: String;
    FCOM_RAZAO: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_RPA';

    [Restrictions([NoValidate, NotNull])]
    [Column('RPA_ID', ftInteger)]
    [Dictionary('RPA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property RPA_ID: Integer read FRPA_ID write FRPA_ID;
    const RPA_ID_Name = 'RPA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('RPA_NUMERODOCTO', ftString, 6)]
    [Dictionary('RPA_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RPA_NUMERODOCTO: String read FRPA_NUMERODOCTO write FRPA_NUMERODOCTO;
    const RPA_NUMERODOCTO_Name = 'RPA_NUMERODOCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RPA_PROCESSADO', ftString, 1)]
    [Dictionary('RPA_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RPA_PROCESSADO: String read FRPA_PROCESSADO write FRPA_PROCESSADO;
    const RPA_PROCESSADO_Name = 'RPA_PROCESSADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RPA_CANCELADO', ftString, 1)]
    [Dictionary('RPA_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RPA_CANCELADO: String read FRPA_CANCELADO write FRPA_CANCELADO;
    const RPA_CANCELADO_Name = 'RPA_CANCELADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RPA_DATALANCAMENTO', ftDateTime)]
    [Dictionary('RPA_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property RPA_DATALANCAMENTO: TDateTime read FRPA_DATALANCAMENTO write FRPA_DATALANCAMENTO;
    const RPA_DATALANCAMENTO_Name = 'RPA_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('RPA_DATAVENCTO', ftDateTime)]
    [Dictionary('RPA_DATAVENCTO', 'Mensagem de validação', '', '', '', taCenter)]
    property RPA_DATAVENCTO: TDateTime read FRPA_DATAVENCTO write FRPA_DATAVENCTO;
    const RPA_DATAVENCTO_Name = 'RPA_DATAVENCTO';

    [Restrictions([NoValidate])]
    [Column('RPA_COMPETENCIA', ftString, 7)]
    [Dictionary('RPA_COMPETENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RPA_COMPETENCIA: String read FRPA_COMPETENCIA write FRPA_COMPETENCIA;
    const RPA_COMPETENCIA_Name = 'RPA_COMPETENCIA';

    [Restrictions([NoValidate])]
    [Column('RPA_TOTALLIQUIDO', ftBCD)]
    [Dictionary('RPA_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RPA_TOTALLIQUIDO: Double read FRPA_TOTALLIQUIDO write FRPA_TOTALLIQUIDO;
    const RPA_TOTALLIQUIDO_Name = 'RPA_TOTALLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('RPA_NOTAFISCAL', ftString, 100)]
    [Dictionary('RPA_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RPA_NOTAFISCAL: String read FRPA_NOTAFISCAL write FRPA_NOTAFISCAL;
    const RPA_NOTAFISCAL_Name = 'RPA_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('RPA_TIPOSERVICO', ftString, 100)]
    [Dictionary('RPA_TIPOSERVICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RPA_TIPOSERVICO: String read FRPA_TIPOSERVICO write FRPA_TIPOSERVICO;
    const RPA_TIPOSERVICO_Name = 'RPA_TIPOSERVICO';

    [Restrictions([NoValidate])]
    [Column('RPA_TOTALIRF', ftBCD, 10, 2)]
    [Dictionary('RPA_TOTALIRF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RPA_TOTALIRF: Double read FRPA_TOTALIRF write FRPA_TOTALIRF;
    const RPA_TOTALIRF_Name = 'RPA_TOTALIRF';

    [Restrictions([NoValidate])]
    [Column('RPA_TOTALSEST_SENAT', ftBCD)]
    [Dictionary('RPA_TOTALSEST_SENAT', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RPA_TOTALSEST_SENAT: Double read FRPA_TOTALSEST_SENAT write FRPA_TOTALSEST_SENAT;
    const RPA_TOTALSEST_SENAT_Name = 'RPA_TOTALSEST_SENAT';

    [Restrictions([NoValidate])]
    [Column('RPA_TOTALINSSSEGURO', ftBCD)]
    [Dictionary('RPA_TOTALINSSSEGURO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RPA_TOTALINSSSEGURO: Double read FRPA_TOTALINSSSEGURO write FRPA_TOTALINSSSEGURO;
    const RPA_TOTALINSSSEGURO_Name = 'RPA_TOTALINSSSEGURO';

    [Restrictions([NoValidate])]
    [Column('RPA_TOTALINSS', ftBCD)]
    [Dictionary('RPA_TOTALINSS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RPA_TOTALINSS: Double read FRPA_TOTALINSS write FRPA_TOTALINSS;
    const RPA_TOTALINSS_Name = 'RPA_TOTALINSS';

    [Restrictions([NoValidate])]
    [Column('RPA_PERCENTUALINSS', ftBCD)]
    [Dictionary('RPA_PERCENTUALINSS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RPA_PERCENTUALINSS: Double read FRPA_PERCENTUALINSS write FRPA_PERCENTUALINSS;
    const RPA_PERCENTUALINSS_Name = 'RPA_PERCENTUALINSS';

    [Restrictions([NoValidate])]
    [Column('RPA_TOTALBCSERVICOPRESTADO', ftBCD)]
    [Dictionary('RPA_TOTALBCSERVICOPRESTADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RPA_TOTALBCSERVICOPRESTADO: Double read FRPA_TOTALBCSERVICOPRESTADO write FRPA_TOTALBCSERVICOPRESTADO;
    const RPA_TOTALBCSERVICOPRESTADO_Name = 'RPA_TOTALBCSERVICOPRESTADO';

    [Restrictions([NoValidate])]
    [Column('RPA_TOTALBASECALCULOINSS', ftBCD)]
    [Dictionary('RPA_TOTALBASECALCULOINSS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RPA_TOTALBASECALCULOINSS: Double read FRPA_TOTALBASECALCULOINSS write FRPA_TOTALBASECALCULOINSS;
    const RPA_TOTALBASECALCULOINSS_Name = 'RPA_TOTALBASECALCULOINSS';

    [Restrictions([NoValidate])]
    [Column('RPA_TOTALPENSAOALIMENTICIA', ftBCD)]
    [Dictionary('RPA_TOTALPENSAOALIMENTICIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RPA_TOTALPENSAOALIMENTICIA: Double read FRPA_TOTALPENSAOALIMENTICIA write FRPA_TOTALPENSAOALIMENTICIA;
    const RPA_TOTALPENSAOALIMENTICIA_Name = 'RPA_TOTALPENSAOALIMENTICIA';

    [Restrictions([NoValidate])]
    [Column('RPA_TOTALSERVICOPRESTADO', ftBCD)]
    [Dictionary('RPA_TOTALSERVICOPRESTADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RPA_TOTALSERVICOPRESTADO: Double read FRPA_TOTALSERVICOPRESTADO write FRPA_TOTALSERVICOPRESTADO;
    const RPA_TOTALSERVICOPRESTADO_Name = 'RPA_TOTALSERVICOPRESTADO';

    [Restrictions([NoValidate])]
    [Column('RPA_CAMPOLIVRE_1', ftString, 50)]
    [Dictionary('RPA_CAMPOLIVRE_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RPA_CAMPOLIVRE_1: String read FRPA_CAMPOLIVRE_1 write FRPA_CAMPOLIVRE_1;
    const RPA_CAMPOLIVRE_1_Name = 'RPA_CAMPOLIVRE_1';

    [Restrictions([NoValidate])]
    [Column('RPA_TOTALCAMPOLIVRE_1', ftBCD, 66260064, 2)]
    [Dictionary('RPA_TOTALCAMPOLIVRE_1', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RPA_TOTALCAMPOLIVRE_1: Double read FRPA_TOTALCAMPOLIVRE_1 write FRPA_TOTALCAMPOLIVRE_1;
    const RPA_TOTALCAMPOLIVRE_1_Name = 'RPA_TOTALCAMPOLIVRE_1';

    [Restrictions([NoValidate])]
    [Column('RPA_CAMPOLIVRE_2', ftString, 50)]
    [Dictionary('RPA_CAMPOLIVRE_2', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RPA_CAMPOLIVRE_2: String read FRPA_CAMPOLIVRE_2 write FRPA_CAMPOLIVRE_2;
    const RPA_CAMPOLIVRE_2_Name = 'RPA_CAMPOLIVRE_2';

    [Restrictions([NoValidate])]
    [Column('RPA_TOTALCAMPOLIVRE_2', ftBCD)]
    [Dictionary('RPA_TOTALCAMPOLIVRE_2', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RPA_TOTALCAMPOLIVRE_2: Double read FRPA_TOTALCAMPOLIVRE_2 write FRPA_TOTALCAMPOLIVRE_2;
    const RPA_TOTALCAMPOLIVRE_2_Name = 'RPA_TOTALCAMPOLIVRE_2';

    [Restrictions([NoValidate])]
    [Column('RPA_CAMPOLIVRE_3', ftString, 50)]
    [Dictionary('RPA_CAMPOLIVRE_3', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RPA_CAMPOLIVRE_3: String read FRPA_CAMPOLIVRE_3 write FRPA_CAMPOLIVRE_3;
    const RPA_CAMPOLIVRE_3_Name = 'RPA_CAMPOLIVRE_3';

    [Restrictions([NoValidate])]
    [Column('RPA_TOTALCAMPOLIVRE_3', ftBCD, 48, 2)]
    [Dictionary('RPA_TOTALCAMPOLIVRE_3', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property RPA_TOTALCAMPOLIVRE_3: Double read FRPA_TOTALCAMPOLIVRE_3 write FRPA_TOTALCAMPOLIVRE_3;
    const RPA_TOTALCAMPOLIVRE_3_Name = 'RPA_TOTALCAMPOLIVRE_3';

    [Restrictions([NoValidate])]
    [Column('RPA_DATACANCELAMENTO', ftDateTime)]
    [Dictionary('RPA_DATACANCELAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property RPA_DATACANCELAMENTO: TDateTime read FRPA_DATACANCELAMENTO write FRPA_DATACANCELAMENTO;
    const RPA_DATACANCELAMENTO_Name = 'RPA_DATACANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('RPA_OBSERVACAOCANCELAMENTO', ftString, 300)]
    [Dictionary('RPA_OBSERVACAOCANCELAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property RPA_OBSERVACAOCANCELAMENTO: String read FRPA_OBSERVACAOCANCELAMENTO write FRPA_OBSERVACAOCANCELAMENTO;
    const RPA_OBSERVACAOCANCELAMENTO_Name = 'RPA_OBSERVACAOCANCELAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('RPA_DATAALTERACAO', ftDateTime)]
    [Dictionary('RPA_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property RPA_DATAALTERACAO: TDateTime read FRPA_DATAALTERACAO write FRPA_DATAALTERACAO;
    const RPA_DATAALTERACAO_Name = 'RPA_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF: String read FPES_CNPJ_CPF write FPES_CNPJ_CPF;
    const PES_CNPJ_CPF_Name = 'PES_CNPJ_CPF';

    [Restrictions([NoValidate])]
    [Column('PES_IE_CI', ftString, 16)]
    [Dictionary('PES_IE_CI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE_CI: String read FPES_IE_CI write FPES_IE_CI;
    const PES_IE_CI_Name = 'PES_IE_CI';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_TIPOPESSOA', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA: String read FPES_TIPOPESSOA write FPES_TIPOPESSOA;
    const PES_TIPOPESSOA_Name = 'PES_TIPOPESSOA';

    [Restrictions([NoValidate])]
    [Column('PES_INSCRICAOINSS', ftString, 20)]
    [Dictionary('PES_INSCRICAOINSS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_INSCRICAOINSS: String read FPES_INSCRICAOINSS write FPES_INSCRICAOINSS;
    const PES_INSCRICAOINSS_Name = 'PES_INSCRICAOINSS';

    [Restrictions([NoValidate])]
    [Column('COM_CNPJ_CPF', ftString, 14)]
    [Dictionary('COM_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CNPJ_CPF: String read FCOM_CNPJ_CPF write FCOM_CNPJ_CPF;
    const COM_CNPJ_CPF_Name = 'COM_CNPJ_CPF';

    [Restrictions([NoValidate])]
    [Column('COM_RAZAO', ftString, 100)]
    [Dictionary('COM_RAZAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_RAZAO: String read FCOM_RAZAO write FCOM_RAZAO;
    const COM_RAZAO_Name = 'COM_RAZAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_RPA)

end.
