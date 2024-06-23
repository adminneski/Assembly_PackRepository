unit express.dbo.REL_V01_FAT_02;

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
  [Table('REL_V01_FAT_02', '')]
  TDtoREL_V01_FAT_02 = class
  private
    { Private declarations } 
    FFAT_TIPO: String;
    FCGA_ID: Integer;
    FFAT_ID: Integer;
    FCOM_CODIGO: Integer;
    FFAT_DATALANCAMENTO: TDateTime;
    FPES_CODIGO: Integer;
    FPES_TIPOPESSOA: String;
    FVND_CODIGO: Integer;
    FROT_CODIGO: Integer;
    FSEG_CODIGO: Integer;
    FFPG_CODIGO: Integer;
    FFPG_DESCRICAO: String;
    FFPG_TIPOPAGAMENTO: Integer;
    FFAT_VALORPARCELA: Double;
    FPRZ_CODIGO: Integer;
    FPRZ_DESCRICAO: String;
    FFAT_DATAVENCIMENTO: TDateTime;
    FFAT_DIA: Integer;
    FFAT_CANCELADA: String;
    FFAT_PROCESSADO: String;
    FPES_NOME: String;
    FFAT_NUMEROPARCELA: Integer;
    FFAT_NUMERODOCTO: String;
    FFAT_TOTALLIQUIDO: Double;
    FMNF_CODIGO: String;
    FFAT_NOTAFISCAL: String;
    FFAT_NFCUPOM: String;
    FFAT_INTEGRACAO: String;
    FNTO_MODELOOPERACAO: String;
    FPES_ORDEMENTREGA: String;
    FPES_CIDADE: String;
    FUSERS_LOGIN: String;
    FFAT_NUMERODOCTOPARCELA: String;
    FFAT_NUMEROCHEQUE: String;
    FFAT_EMITENTE: String;
    FFAT_VALORPARCELAAVISTA: Double;
    FFAT_VALORPARCELAPRAZO: Double;
    FPES_CNPJ_CPF: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_FAT_02';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TIPO', ftString, 3)]
    [Dictionary('FAT_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_TIPO: String read FFAT_TIPO write FFAT_TIPO;
    const FAT_TIPO_Name = 'FAT_TIPO';

    [Restrictions([NoValidate])]
    [Column('CGA_ID', ftInteger)]
    [Dictionary('CGA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CGA_ID: Integer read FCGA_ID write FCGA_ID;
    const CGA_ID_Name = 'CGA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_ID', ftInteger)]
    [Dictionary('FAT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_ID: Integer read FFAT_ID write FFAT_ID;
    const FAT_ID_Name = 'FAT_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAT_DATALANCAMENTO', ftDateTime)]
    [Dictionary('FAT_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property FAT_DATALANCAMENTO: TDateTime read FFAT_DATALANCAMENTO write FFAT_DATALANCAMENTO;
    const FAT_DATALANCAMENTO_Name = 'FAT_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOPESSOA', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA: String read FPES_TIPOPESSOA write FPES_TIPOPESSOA;
    const PES_TIPOPESSOA_Name = 'PES_TIPOPESSOA';

    [Restrictions([NoValidate])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('ROT_CODIGO', ftInteger)]
    [Dictionary('ROT_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property ROT_CODIGO: Integer read FROT_CODIGO write FROT_CODIGO;
    const ROT_CODIGO_Name = 'ROT_CODIGO';

    [Restrictions([NoValidate])]
    [Column('SEG_CODIGO', ftInteger)]
    [Dictionary('SEG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property SEG_CODIGO: Integer read FSEG_CODIGO write FSEG_CODIGO;
    const SEG_CODIGO_Name = 'SEG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FPG_DESCRICAO', ftString, 30)]
    [Dictionary('FPG_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FPG_DESCRICAO: String read FFPG_DESCRICAO write FFPG_DESCRICAO;
    const FPG_DESCRICAO_Name = 'FPG_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('FPG_TIPOPAGAMENTO', ftInteger)]
    [Dictionary('FPG_TIPOPAGAMENTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_TIPOPAGAMENTO: Integer read FFPG_TIPOPAGAMENTO write FFPG_TIPOPAGAMENTO;
    const FPG_TIPOPAGAMENTO_Name = 'FPG_TIPOPAGAMENTO';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORPARCELA', ftBCD, 48, 2)]
    [Dictionary('FAT_VALORPARCELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORPARCELA: Double read FFAT_VALORPARCELA write FFAT_VALORPARCELA;
    const FAT_VALORPARCELA_Name = 'FAT_VALORPARCELA';

    [Restrictions([NoValidate])]
    [Column('PRZ_CODIGO', ftInteger)]
    [Dictionary('PRZ_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRZ_CODIGO: Integer read FPRZ_CODIGO write FPRZ_CODIGO;
    const PRZ_CODIGO_Name = 'PRZ_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRZ_DESCRICAO', ftString, 30)]
    [Dictionary('PRZ_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRZ_DESCRICAO: String read FPRZ_DESCRICAO write FPRZ_DESCRICAO;
    const PRZ_DESCRICAO_Name = 'PRZ_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('FAT_DATAVENCIMENTO', ftDateTime)]
    [Dictionary('FAT_DATAVENCIMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property FAT_DATAVENCIMENTO: TDateTime read FFAT_DATAVENCIMENTO write FFAT_DATAVENCIMENTO;
    const FAT_DATAVENCIMENTO_Name = 'FAT_DATAVENCIMENTO';

    [Restrictions([NoValidate])]
    [Column('FAT_DIA', ftInteger)]
    [Dictionary('FAT_DIA', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_DIA: Integer read FFAT_DIA write FFAT_DIA;
    const FAT_DIA_Name = 'FAT_DIA';

    [Restrictions([NoValidate])]
    [Column('FAT_CANCELADA', ftString, 1)]
    [Dictionary('FAT_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_CANCELADA: String read FFAT_CANCELADA write FFAT_CANCELADA;
    const FAT_CANCELADA_Name = 'FAT_CANCELADA';

    [Restrictions([NoValidate])]
    [Column('FAT_PROCESSADO', ftString, 1)]
    [Dictionary('FAT_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_PROCESSADO: String read FFAT_PROCESSADO write FFAT_PROCESSADO;
    const FAT_PROCESSADO_Name = 'FAT_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('FAT_NUMEROPARCELA', ftInteger)]
    [Dictionary('FAT_NUMEROPARCELA', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_NUMEROPARCELA: Integer read FFAT_NUMEROPARCELA write FFAT_NUMEROPARCELA;
    const FAT_NUMEROPARCELA_Name = 'FAT_NUMEROPARCELA';

    [Restrictions([NoValidate])]
    [Column('FAT_NUMERODOCTO', ftString, 20)]
    [Dictionary('FAT_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NUMERODOCTO: String read FFAT_NUMERODOCTO write FFAT_NUMERODOCTO;
    const FAT_NUMERODOCTO_Name = 'FAT_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALLIQUIDO', ftBCD)]
    [Dictionary('FAT_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALLIQUIDO: Double read FFAT_TOTALLIQUIDO write FFAT_TOTALLIQUIDO;
    const FAT_TOTALLIQUIDO_Name = 'FAT_TOTALLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAT_NOTAFISCAL', ftString, 6)]
    [Dictionary('FAT_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NOTAFISCAL: String read FFAT_NOTAFISCAL write FFAT_NOTAFISCAL;
    const FAT_NOTAFISCAL_Name = 'FAT_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('FAT_NFCUPOM', ftString, 10)]
    [Dictionary('FAT_NFCUPOM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NFCUPOM: String read FFAT_NFCUPOM write FFAT_NFCUPOM;
    const FAT_NFCUPOM_Name = 'FAT_NFCUPOM';

    [Restrictions([NoValidate])]
    [Column('FAT_INTEGRACAO', ftString, 3)]
    [Dictionary('FAT_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_INTEGRACAO: String read FFAT_INTEGRACAO write FFAT_INTEGRACAO;
    const FAT_INTEGRACAO_Name = 'FAT_INTEGRACAO';

    [Restrictions([NoValidate])]
    [Column('NTO_MODELOOPERACAO', ftString, 1)]
    [Dictionary('NTO_MODELOOPERACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_MODELOOPERACAO: String read FNTO_MODELOOPERACAO write FNTO_MODELOOPERACAO;
    const NTO_MODELOOPERACAO_Name = 'NTO_MODELOOPERACAO';

    [Restrictions([NoValidate])]
    [Column('PES_ORDEMENTREGA', ftString, 6)]
    [Dictionary('PES_ORDEMENTREGA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ORDEMENTREGA: String read FPES_ORDEMENTREGA write FPES_ORDEMENTREGA;
    const PES_ORDEMENTREGA_Name = 'PES_ORDEMENTREGA';

    [Restrictions([NoValidate])]
    [Column('PES_CIDADE', ftString, 100)]
    [Dictionary('PES_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADE: String read FPES_CIDADE write FPES_CIDADE;
    const PES_CIDADE_Name = 'PES_CIDADE';

    [Restrictions([NoValidate])]
    [Column('USERS_LOGIN', ftString, 250)]
    [Dictionary('USERS_LOGIN', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property USERS_LOGIN: String read FUSERS_LOGIN write FUSERS_LOGIN;
    const USERS_LOGIN_Name = 'USERS_LOGIN';

    [Restrictions([NoValidate])]
    [Column('FAT_NUMERODOCTOPARCELA', ftString, 20)]
    [Dictionary('FAT_NUMERODOCTOPARCELA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NUMERODOCTOPARCELA: String read FFAT_NUMERODOCTOPARCELA write FFAT_NUMERODOCTOPARCELA;
    const FAT_NUMERODOCTOPARCELA_Name = 'FAT_NUMERODOCTOPARCELA';

    [Restrictions([NoValidate])]
    [Column('FAT_NUMEROCHEQUE', ftString, 6)]
    [Dictionary('FAT_NUMEROCHEQUE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NUMEROCHEQUE: String read FFAT_NUMEROCHEQUE write FFAT_NUMEROCHEQUE;
    const FAT_NUMEROCHEQUE_Name = 'FAT_NUMEROCHEQUE';

    [Restrictions([NoValidate])]
    [Column('FAT_EMITENTE', ftString, 50)]
    [Dictionary('FAT_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_EMITENTE: String read FFAT_EMITENTE write FFAT_EMITENTE;
    const FAT_EMITENTE_Name = 'FAT_EMITENTE';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORPARCELAAVISTA', ftBCD)]
    [Dictionary('FAT_VALORPARCELAAVISTA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORPARCELAAVISTA: Double read FFAT_VALORPARCELAAVISTA write FFAT_VALORPARCELAAVISTA;
    const FAT_VALORPARCELAAVISTA_Name = 'FAT_VALORPARCELAAVISTA';

    [Restrictions([NoValidate])]
    [Column('FAT_VALORPARCELAPRAZO', ftBCD)]
    [Dictionary('FAT_VALORPARCELAPRAZO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_VALORPARCELAPRAZO: Double read FFAT_VALORPARCELAPRAZO write FFAT_VALORPARCELAPRAZO;
    const FAT_VALORPARCELAPRAZO_Name = 'FAT_VALORPARCELAPRAZO';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF: String read FPES_CNPJ_CPF write FPES_CNPJ_CPF;
    const PES_CNPJ_CPF_Name = 'PES_CNPJ_CPF';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_FAT_02)

end.
