unit express.dbo.REL_V01_PDA;

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
  [Table('REL_V01_PDA', '')]
  TDtoREL_V01_PDA = class
  private
    { Private declarations } 
    FPDA_ID: Integer;
    FCOM_CODIGO: Integer;
    FPDA_NUMERODOCTO: String;
    FPDA_NUMERODOCTOREPRESENTANTE: String;
    FPDA_DATALANCAMENTO: TDateTime;
    FPDA_DATAENTREGA: TDateTime;
    FPDA_TOTALLIQUIDO: Double;
    FPES_CODIGO: Integer;
    FPDA_FATURADO: String;
    FPDA_CANCELADA: String;
    FPDA_DESATIVADO: String;
    FPES_TIPOPESSOA: String;
    FPES_NOMECLIENTE: String;
    FPES_FANTASIA_OU_APELIDO: String;
    FPES_ENDERECO: String;
    FPES_NUMEROENDERECO: String;
    FPES_BAIRRO: String;
    FCEP_CODIGO: String;
    FPES_PONTOREFERENCIA: String;
    FPES_DDD_TELEFONE_1: String;
    FPES_DDD_CELULAR_1: String;
    FCID_IBGE: String;
    FPES_CIDADE: String;
    FPES_UF: String;
    FCGA_ID: Integer;
    FCGA_TITULOCARGA: String;
    FVND_CODIGO: Integer;
    FPES_NOMEVENDEDOR: String;
    FFPG_CODIGO: Integer;
    FFPG_DESCRICAO: String;
    FPRZ_CODIGO: Integer;
    FPRZ_DESCRICAO: String;
    FPES_CNPJ_CPF: String;
    FPES_IE_CI: String;
    FROT_CODIGO: Integer;
    FROT_DESCRICAO: String;
    FSEG_CODIGO: Integer;
    FPDA_OBSERVACAO: String;
    FPDA_TOTALPESOBRUTO: Double;
    FPDA_TOTALPESOLIQUIDO: Double;
    FPDA_INTEGRACAO: String;
    FPDA_DATADIGITACAOPALM: TDateTime;
    FPDA_HORADIGITACAOPALM: String;
    FCGA_FATURADA: String;
    FPDA_TOTALFRETE: Double;
    FPDA_TOTALDESCTOAVULSO: Double;
    FUSERS_LOGIN: String;
    FPDA_TOTALDESCTO: Double;
    FPDA_TOTALADICIONAL: Double;
    FPDA_TOTALFINANCEIROPRAZO: Double;
    FPDA_TIPOFRETE: String;
    FPDA_TIPOFRETEDESC: String;
    FPDA_TOTALPRODUTOS: Double;
    FPDA_TOTALDESPACESSORIA: Double;
    FNTO_MODELOOPERACAO: String;
    FPES_ORDEMENTREGA: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_PDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_ID', ftInteger)]
    [Dictionary('PDA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDA_ID: Integer read FPDA_ID write FPDA_ID;
    const PDA_ID_Name = 'PDA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_NUMERODOCTO', ftString, 20)]
    [Dictionary('PDA_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_NUMERODOCTO: String read FPDA_NUMERODOCTO write FPDA_NUMERODOCTO;
    const PDA_NUMERODOCTO_Name = 'PDA_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('PDA_NUMERODOCTOREPRESENTANTE', ftString, 20)]
    [Dictionary('PDA_NUMERODOCTOREPRESENTANTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_NUMERODOCTOREPRESENTANTE: String read FPDA_NUMERODOCTOREPRESENTANTE write FPDA_NUMERODOCTOREPRESENTANTE;
    const PDA_NUMERODOCTOREPRESENTANTE_Name = 'PDA_NUMERODOCTOREPRESENTANTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_DATALANCAMENTO', ftDateTime)]
    [Dictionary('PDA_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PDA_DATALANCAMENTO: TDateTime read FPDA_DATALANCAMENTO write FPDA_DATALANCAMENTO;
    const PDA_DATALANCAMENTO_Name = 'PDA_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('PDA_DATAENTREGA', ftDateTime)]
    [Dictionary('PDA_DATAENTREGA', 'Mensagem de validação', '', '', '', taCenter)]
    property PDA_DATAENTREGA: TDateTime read FPDA_DATAENTREGA write FPDA_DATAENTREGA;
    const PDA_DATAENTREGA_Name = 'PDA_DATAENTREGA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_TOTALLIQUIDO', ftBCD)]
    [Dictionary('PDA_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALLIQUIDO: Double read FPDA_TOTALLIQUIDO write FPDA_TOTALLIQUIDO;
    const PDA_TOTALLIQUIDO_Name = 'PDA_TOTALLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_FATURADO', ftString, 1)]
    [Dictionary('PDA_FATURADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_FATURADO: String read FPDA_FATURADO write FPDA_FATURADO;
    const PDA_FATURADO_Name = 'PDA_FATURADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_CANCELADA', ftString, 1)]
    [Dictionary('PDA_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_CANCELADA: String read FPDA_CANCELADA write FPDA_CANCELADA;
    const PDA_CANCELADA_Name = 'PDA_CANCELADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_DESATIVADO', ftString, 1)]
    [Dictionary('PDA_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_DESATIVADO: String read FPDA_DESATIVADO write FPDA_DESATIVADO;
    const PDA_DESATIVADO_Name = 'PDA_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOPESSOA', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA: String read FPES_TIPOPESSOA write FPES_TIPOPESSOA;
    const PES_TIPOPESSOA_Name = 'PES_TIPOPESSOA';

    [Restrictions([NoValidate])]
    [Column('PES_NOMECLIENTE', ftString, 100)]
    [Dictionary('PES_NOMECLIENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMECLIENTE: String read FPES_NOMECLIENTE write FPES_NOMECLIENTE;
    const PES_NOMECLIENTE_Name = 'PES_NOMECLIENTE';

    [Restrictions([NoValidate])]
    [Column('PES_FANTASIA_OU_APELIDO', ftString, 100)]
    [Dictionary('PES_FANTASIA_OU_APELIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_FANTASIA_OU_APELIDO: String read FPES_FANTASIA_OU_APELIDO write FPES_FANTASIA_OU_APELIDO;
    const PES_FANTASIA_OU_APELIDO_Name = 'PES_FANTASIA_OU_APELIDO';

    [Restrictions([NoValidate])]
    [Column('PES_ENDERECO', ftString, 100)]
    [Dictionary('PES_ENDERECO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ENDERECO: String read FPES_ENDERECO write FPES_ENDERECO;
    const PES_ENDERECO_Name = 'PES_ENDERECO';

    [Restrictions([NoValidate])]
    [Column('PES_NUMEROENDERECO', ftString, 5)]
    [Dictionary('PES_NUMEROENDERECO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NUMEROENDERECO: String read FPES_NUMEROENDERECO write FPES_NUMEROENDERECO;
    const PES_NUMEROENDERECO_Name = 'PES_NUMEROENDERECO';

    [Restrictions([NoValidate])]
    [Column('PES_BAIRRO', ftString, 50)]
    [Dictionary('PES_BAIRRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_BAIRRO: String read FPES_BAIRRO write FPES_BAIRRO;
    const PES_BAIRRO_Name = 'PES_BAIRRO';

    [Restrictions([NoValidate])]
    [Column('CEP_CODIGO', ftString, 8)]
    [Dictionary('CEP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEP_CODIGO: String read FCEP_CODIGO write FCEP_CODIGO;
    const CEP_CODIGO_Name = 'CEP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_PONTOREFERENCIA', ftString, 500)]
    [Dictionary('PES_PONTOREFERENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_PONTOREFERENCIA: String read FPES_PONTOREFERENCIA write FPES_PONTOREFERENCIA;
    const PES_PONTOREFERENCIA_Name = 'PES_PONTOREFERENCIA';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_TELEFONE_1', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONE_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONE_1: String read FPES_DDD_TELEFONE_1 write FPES_DDD_TELEFONE_1;
    const PES_DDD_TELEFONE_1_Name = 'PES_DDD_TELEFONE_1';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_CELULAR_1', ftString, 11)]
    [Dictionary('PES_DDD_CELULAR_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_CELULAR_1: String read FPES_DDD_CELULAR_1 write FPES_DDD_CELULAR_1;
    const PES_DDD_CELULAR_1_Name = 'PES_DDD_CELULAR_1';

    [Restrictions([NoValidate])]
    [Column('CID_IBGE', ftString, 7)]
    [Dictionary('CID_IBGE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE: String read FCID_IBGE write FCID_IBGE;
    const CID_IBGE_Name = 'CID_IBGE';

    [Restrictions([NoValidate])]
    [Column('PES_CIDADE', ftString, 100)]
    [Dictionary('PES_CIDADE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADE: String read FPES_CIDADE write FPES_CIDADE;
    const PES_CIDADE_Name = 'PES_CIDADE';

    [Restrictions([NoValidate])]
    [Column('PES_UF', ftString, 2)]
    [Dictionary('PES_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF: String read FPES_UF write FPES_UF;
    const PES_UF_Name = 'PES_UF';

    [Restrictions([NoValidate])]
    [Column('CGA_ID', ftInteger)]
    [Dictionary('CGA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CGA_ID: Integer read FCGA_ID write FCGA_ID;
    const CGA_ID_Name = 'CGA_ID';

    [Restrictions([NoValidate])]
    [Column('CGA_TITULOCARGA', ftString, 40)]
    [Dictionary('CGA_TITULOCARGA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CGA_TITULOCARGA: String read FCGA_TITULOCARGA write FCGA_TITULOCARGA;
    const CGA_TITULOCARGA_Name = 'CGA_TITULOCARGA';

    [Restrictions([NoValidate, NotNull])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_NOMEVENDEDOR', ftString, 100)]
    [Dictionary('PES_NOMEVENDEDOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMEVENDEDOR: String read FPES_NOMEVENDEDOR write FPES_NOMEVENDEDOR;
    const PES_NOMEVENDEDOR_Name = 'PES_NOMEVENDEDOR';

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
    [Column('PES_CNPJ_CPF', ftString, 14)]
    [Dictionary('PES_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF: String read FPES_CNPJ_CPF write FPES_CNPJ_CPF;
    const PES_CNPJ_CPF_Name = 'PES_CNPJ_CPF';

    [Restrictions([NoValidate])]
    [Column('PES_IE_CI', ftString, 16)]
    [Dictionary('PES_IE_CI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE_CI: String read FPES_IE_CI write FPES_IE_CI;
    const PES_IE_CI_Name = 'PES_IE_CI';

    [Restrictions([NoValidate])]
    [Column('ROT_CODIGO', ftInteger)]
    [Dictionary('ROT_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property ROT_CODIGO: Integer read FROT_CODIGO write FROT_CODIGO;
    const ROT_CODIGO_Name = 'ROT_CODIGO';

    [Restrictions([NoValidate])]
    [Column('ROT_DESCRICAO', ftString, 30)]
    [Dictionary('ROT_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ROT_DESCRICAO: String read FROT_DESCRICAO write FROT_DESCRICAO;
    const ROT_DESCRICAO_Name = 'ROT_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('SEG_CODIGO', ftInteger)]
    [Dictionary('SEG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property SEG_CODIGO: Integer read FSEG_CODIGO write FSEG_CODIGO;
    const SEG_CODIGO_Name = 'SEG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PDA_OBSERVACAO', ftString, 5000)]
    [Dictionary('PDA_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_OBSERVACAO: String read FPDA_OBSERVACAO write FPDA_OBSERVACAO;
    const PDA_OBSERVACAO_Name = 'PDA_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALPESOBRUTO', ftBCD, 18, 4)]
    [Dictionary('PDA_TOTALPESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALPESOBRUTO: Double read FPDA_TOTALPESOBRUTO write FPDA_TOTALPESOBRUTO;
    const PDA_TOTALPESOBRUTO_Name = 'PDA_TOTALPESOBRUTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_TOTALPESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('PDA_TOTALPESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALPESOLIQUIDO: Double read FPDA_TOTALPESOLIQUIDO write FPDA_TOTALPESOLIQUIDO;
    const PDA_TOTALPESOLIQUIDO_Name = 'PDA_TOTALPESOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('PDA_INTEGRACAO', ftString, 20)]
    [Dictionary('PDA_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_INTEGRACAO: String read FPDA_INTEGRACAO write FPDA_INTEGRACAO;
    const PDA_INTEGRACAO_Name = 'PDA_INTEGRACAO';

    [Restrictions([NoValidate])]
    [Column('PDA_DATADIGITACAOPALM', ftDateTime)]
    [Dictionary('PDA_DATADIGITACAOPALM', 'Mensagem de validação', '', '', '', taCenter)]
    property PDA_DATADIGITACAOPALM: TDateTime read FPDA_DATADIGITACAOPALM write FPDA_DATADIGITACAOPALM;
    const PDA_DATADIGITACAOPALM_Name = 'PDA_DATADIGITACAOPALM';

    [Restrictions([NoValidate])]
    [Column('PDA_HORADIGITACAOPALM', ftString, 10)]
    [Dictionary('PDA_HORADIGITACAOPALM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_HORADIGITACAOPALM: String read FPDA_HORADIGITACAOPALM write FPDA_HORADIGITACAOPALM;
    const PDA_HORADIGITACAOPALM_Name = 'PDA_HORADIGITACAOPALM';

    [Restrictions([NoValidate, NotNull])]
    [Column('CGA_FATURADA', ftString, 1)]
    [Dictionary('CGA_FATURADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CGA_FATURADA: String read FCGA_FATURADA write FCGA_FATURADA;
    const CGA_FATURADA_Name = 'CGA_FATURADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_TOTALFRETE', ftBCD)]
    [Dictionary('PDA_TOTALFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALFRETE: Double read FPDA_TOTALFRETE write FPDA_TOTALFRETE;
    const PDA_TOTALFRETE_Name = 'PDA_TOTALFRETE';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_TOTALDESCTOAVULSO', ftBCD)]
    [Dictionary('PDA_TOTALDESCTOAVULSO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALDESCTOAVULSO: Double read FPDA_TOTALDESCTOAVULSO write FPDA_TOTALDESCTOAVULSO;
    const PDA_TOTALDESCTOAVULSO_Name = 'PDA_TOTALDESCTOAVULSO';

    [Restrictions([NoValidate])]
    [Column('USERS_LOGIN', ftString, 250)]
    [Dictionary('USERS_LOGIN', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property USERS_LOGIN: String read FUSERS_LOGIN write FUSERS_LOGIN;
    const USERS_LOGIN_Name = 'USERS_LOGIN';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALDESCTO', ftBCD)]
    [Dictionary('PDA_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALDESCTO: Double read FPDA_TOTALDESCTO write FPDA_TOTALDESCTO;
    const PDA_TOTALDESCTO_Name = 'PDA_TOTALDESCTO';

    [Restrictions([NoValidate])]
    [Column('PDA_TOTALADICIONAL', ftBCD)]
    [Dictionary('PDA_TOTALADICIONAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALADICIONAL: Double read FPDA_TOTALADICIONAL write FPDA_TOTALADICIONAL;
    const PDA_TOTALADICIONAL_Name = 'PDA_TOTALADICIONAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_TOTALFINANCEIROPRAZO', ftBCD, 48, 2)]
    [Dictionary('PDA_TOTALFINANCEIROPRAZO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALFINANCEIROPRAZO: Double read FPDA_TOTALFINANCEIROPRAZO write FPDA_TOTALFINANCEIROPRAZO;
    const PDA_TOTALFINANCEIROPRAZO_Name = 'PDA_TOTALFINANCEIROPRAZO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_TIPOFRETE', ftString, 1)]
    [Dictionary('PDA_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_TIPOFRETE: String read FPDA_TIPOFRETE write FPDA_TIPOFRETE;
    const PDA_TIPOFRETE_Name = 'PDA_TIPOFRETE';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_TIPOFRETEDESC', ftString, 3)]
    [Dictionary('PDA_TIPOFRETEDESC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_TIPOFRETEDESC: String read FPDA_TIPOFRETEDESC write FPDA_TIPOFRETEDESC;
    const PDA_TIPOFRETEDESC_Name = 'PDA_TIPOFRETEDESC';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_TOTALPRODUTOS', ftBCD)]
    [Dictionary('PDA_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALPRODUTOS: Double read FPDA_TOTALPRODUTOS write FPDA_TOTALPRODUTOS;
    const PDA_TOTALPRODUTOS_Name = 'PDA_TOTALPRODUTOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_TOTALDESPACESSORIA', ftBCD)]
    [Dictionary('PDA_TOTALDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALDESPACESSORIA: Double read FPDA_TOTALDESPACESSORIA write FPDA_TOTALDESPACESSORIA;
    const PDA_TOTALDESPACESSORIA_Name = 'PDA_TOTALDESPACESSORIA';

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
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_PDA)

end.
