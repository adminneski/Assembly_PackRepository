unit express.dbo.REL_V01_FAT;

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
  [Table('REL_V01_FAT', '')]
  TDtoREL_V01_FAT = class
  private
    { Private declarations } 
    FFAT_TIPO: String;
    FFAT_ID: Integer;
    FCOM_CODIGO: Integer;
    FFAT_NUMERODOCTO: String;
    FMNF_CODIGO: String;
    FFAT_NOTAFISCAL: String;
    FFAT_NOTAFISCALSERVICO: String;
    FFAT_NUMERODOCTOREPRESENTANTE: String;
    FFAT_DATALANCAMENTO: TDateTime;
    FFAT_DATAENTREGA: TDateTime;
    FFAT_TOTALLIQUIDO: Double;
    FFAT_TOTALPRODUTOS: Double;
    FFAT_TOTALPRODUTOSLIQUIDO: Double;
    FFAT_TOTALSERVICO: Double;
    FFAT_TOTALPRECOBASEVENDA: Double;
    FPES_CODIGO: Integer;
    FFAT_CANCELADA: String;
    FFAT_PROCESSADO: String;
    FFAT_DATACANCELAMENTO: TDateTime;
    FFAT_OBSERVACAOCANCELAMENTO: String;
    FFAT_OBSERVACAO: String;
    FFAT_TOTALDESCTO: Double;
    FFAT_PERCENTUALDESCTO: Double;
    FFAT_TOTALFRETE: Double;
    FFAT_TOTALDESPACESSORIA: Double;
    FFAT_DESATIVADO: String;
    FNTO_CODIGO: Integer;
    FPES_NOME: String;
    FPES_NOMECLIENTE: String;
    FPES_TIPOPESSOA: String;
    FPES_FANTASIA_OU_APELIDO: String;
    FPES_ENDERECO: String;
    FPES_NUMEROENDERECO: String;
    FPES_BAIRRO: String;
    FCEP_CODIGO: String;
    FPES_PONTOREFERENCIA: String;
    FPES_DDD_TELEFONE_1: String;
    FPES_DDD_TELEFONE_2: String;
    FPES_DDD_TELEFONE_3: String;
    FPES_DDD_CELULAR_1: String;
    FCID_IBGE: String;
    FPES_CIDADE: String;
    FPES_UF: String;
    FPES_DESATIVADO: String;
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
    FPES_CLIENTE: String;
    FROT_CODIGO: Integer;
    FROT_DESCRICAO: String;
    FCGA_NUMEROORDEMENTREGA: Integer;
    FPES_ORDEMENTREGA: String;
    FNTO_MODELOOPERACAO: String;
    FFAT_TOTALFINANCEIROPRAZO: Double;
    FFAT_TOTALADICIONAL: Double;
    FFAT_TIPOFRETE: String;
    FTDC_CODIGO: String;
    FSEG_CODIGO: Integer;
    FVEI_CODIGO: Integer;
    FVEI_PLACA: String;
    FVEI_DESCRICAO: String;
    FVEI_TIPODOCUMENTO: String;
    FFAT_OBSERVACAOVEICULO: String;
    FMAR_CODIGO: Integer;
    FMAR_NOME: String;
    FVEI_ANO_MODELO: String;
    FVEI_NUMEROCHASSI: String;
    FFAT_NF: String;
    FFAT_NFS: String;
    FFAT_INTEGRACAO: String;
    FFAT_TOTALPRECOTABELA: Double;
    FFAT_TOTALPRECOCUSTO: Double;
    FFAT_TOTALPRECODIGITADO: Double;
    FFAT_POSVENDA: String;
    FFAT_OBSSOLICITACAOCLIENTE: String;
    FFAT_OBSENTRADAVEICULO: String;
    FFAT_OBSFECHAMENTOORDEMSERVICO: String;
    FCCU_CODIGO: Integer;
    FFAT_TIPODOCUMENTO: String;
    FFAT_KMVEICULO: Integer;
    FFAT_DIASRETORNO: Integer;
    FVEI_NUMERORENAVAM: String;
    FVEI_COR: String;
    FVEI_TIPOCOMBUSTIVEL: String;
    FVEI_COMBUSTIVEL: String;
    FUSERS_LOGIN: String;
    FFAT_TOTALTROCO: Double;
    FFAT_NSV: Integer;
    FFAT_TIPOMOVTO: String;
    FFAT_RESERVARESTOQUE: String;
    FFAT_FATURADOPRODUTOS: String;
    FFAT_FATURADOSERVICOS: String;
    FFAT_TOTALQTDHORAS: Double;
    FFAT_TOTALQTDPEDIDA: Double;
    FFAT_NUMEROOC: Integer;
    FFAT_NUMEROLICITACAO: String;
    FFAT_TOTALPESOBRUTO: Double;
    FFAT_TOTALPESOLIQUIDO: Double;
    FFAT_TIPOFRETEDESC: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_FAT';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TIPO', ftString, 3)]
    [Dictionary('FAT_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_TIPO: String read FFAT_TIPO write FFAT_TIPO;
    const FAT_TIPO_Name = 'FAT_TIPO';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_NUMERODOCTO', ftString, 20)]
    [Dictionary('FAT_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NUMERODOCTO: String read FFAT_NUMERODOCTO write FFAT_NUMERODOCTO;
    const FAT_NUMERODOCTO_Name = 'FAT_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAT_NOTAFISCAL', ftString, 9)]
    [Dictionary('FAT_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NOTAFISCAL: String read FFAT_NOTAFISCAL write FFAT_NOTAFISCAL;
    const FAT_NOTAFISCAL_Name = 'FAT_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('FAT_NOTAFISCALSERVICO', ftString, 9)]
    [Dictionary('FAT_NOTAFISCALSERVICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NOTAFISCALSERVICO: String read FFAT_NOTAFISCALSERVICO write FFAT_NOTAFISCALSERVICO;
    const FAT_NOTAFISCALSERVICO_Name = 'FAT_NOTAFISCALSERVICO';

    [Restrictions([NoValidate])]
    [Column('FAT_NUMERODOCTOREPRESENTANTE', ftString, 20)]
    [Dictionary('FAT_NUMERODOCTOREPRESENTANTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NUMERODOCTOREPRESENTANTE: String read FFAT_NUMERODOCTOREPRESENTANTE write FFAT_NUMERODOCTOREPRESENTANTE;
    const FAT_NUMERODOCTOREPRESENTANTE_Name = 'FAT_NUMERODOCTOREPRESENTANTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_DATALANCAMENTO', ftDateTime)]
    [Dictionary('FAT_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property FAT_DATALANCAMENTO: TDateTime read FFAT_DATALANCAMENTO write FFAT_DATALANCAMENTO;
    const FAT_DATALANCAMENTO_Name = 'FAT_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('FAT_DATAENTREGA', ftDateTime)]
    [Dictionary('FAT_DATAENTREGA', 'Mensagem de validação', '', '', '', taCenter)]
    property FAT_DATAENTREGA: TDateTime read FFAT_DATAENTREGA write FFAT_DATAENTREGA;
    const FAT_DATAENTREGA_Name = 'FAT_DATAENTREGA';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALLIQUIDO', ftBCD)]
    [Dictionary('FAT_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALLIQUIDO: Double read FFAT_TOTALLIQUIDO write FFAT_TOTALLIQUIDO;
    const FAT_TOTALLIQUIDO_Name = 'FAT_TOTALLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALPRODUTOS', ftBCD)]
    [Dictionary('FAT_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPRODUTOS: Double read FFAT_TOTALPRODUTOS write FFAT_TOTALPRODUTOS;
    const FAT_TOTALPRODUTOS_Name = 'FAT_TOTALPRODUTOS';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPRODUTOSLIQUIDO', ftBCD)]
    [Dictionary('FAT_TOTALPRODUTOSLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPRODUTOSLIQUIDO: Double read FFAT_TOTALPRODUTOSLIQUIDO write FFAT_TOTALPRODUTOSLIQUIDO;
    const FAT_TOTALPRODUTOSLIQUIDO_Name = 'FAT_TOTALPRODUTOSLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALSERVICO', ftBCD)]
    [Dictionary('FAT_TOTALSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALSERVICO: Double read FFAT_TOTALSERVICO write FFAT_TOTALSERVICO;
    const FAT_TOTALSERVICO_Name = 'FAT_TOTALSERVICO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPRECOBASEVENDA', ftBCD, 48, 2)]
    [Dictionary('FAT_TOTALPRECOBASEVENDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPRECOBASEVENDA: Double read FFAT_TOTALPRECOBASEVENDA write FFAT_TOTALPRECOBASEVENDA;
    const FAT_TOTALPRECOBASEVENDA_Name = 'FAT_TOTALPRECOBASEVENDA';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_CANCELADA', ftString, 1)]
    [Dictionary('FAT_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_CANCELADA: String read FFAT_CANCELADA write FFAT_CANCELADA;
    const FAT_CANCELADA_Name = 'FAT_CANCELADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_PROCESSADO', ftString, 1)]
    [Dictionary('FAT_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_PROCESSADO: String read FFAT_PROCESSADO write FFAT_PROCESSADO;
    const FAT_PROCESSADO_Name = 'FAT_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('FAT_DATACANCELAMENTO', ftDateTime)]
    [Dictionary('FAT_DATACANCELAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property FAT_DATACANCELAMENTO: TDateTime read FFAT_DATACANCELAMENTO write FFAT_DATACANCELAMENTO;
    const FAT_DATACANCELAMENTO_Name = 'FAT_DATACANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('FAT_OBSERVACAOCANCELAMENTO', ftString, 300)]
    [Dictionary('FAT_OBSERVACAOCANCELAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_OBSERVACAOCANCELAMENTO: String read FFAT_OBSERVACAOCANCELAMENTO write FFAT_OBSERVACAOCANCELAMENTO;
    const FAT_OBSERVACAOCANCELAMENTO_Name = 'FAT_OBSERVACAOCANCELAMENTO';

    [Restrictions([NoValidate])]
    [Column('FAT_OBSERVACAO', ftString, 5000)]
    [Dictionary('FAT_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_OBSERVACAO: String read FFAT_OBSERVACAO write FFAT_OBSERVACAO;
    const FAT_OBSERVACAO_Name = 'FAT_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALDESCTO', ftBCD)]
    [Dictionary('FAT_TOTALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALDESCTO: Double read FFAT_TOTALDESCTO write FFAT_TOTALDESCTO;
    const FAT_TOTALDESCTO_Name = 'FAT_TOTALDESCTO';

    [Restrictions([NoValidate])]
    [Column('FAT_PERCENTUALDESCTO', ftBCD)]
    [Dictionary('FAT_PERCENTUALDESCTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_PERCENTUALDESCTO: Double read FFAT_PERCENTUALDESCTO write FFAT_PERCENTUALDESCTO;
    const FAT_PERCENTUALDESCTO_Name = 'FAT_PERCENTUALDESCTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALFRETE', ftBCD)]
    [Dictionary('FAT_TOTALFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALFRETE: Double read FFAT_TOTALFRETE write FFAT_TOTALFRETE;
    const FAT_TOTALFRETE_Name = 'FAT_TOTALFRETE';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALDESPACESSORIA', ftBCD)]
    [Dictionary('FAT_TOTALDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALDESPACESSORIA: Double read FFAT_TOTALDESPACESSORIA write FFAT_TOTALDESPACESSORIA;
    const FAT_TOTALDESPACESSORIA_Name = 'FAT_TOTALDESPACESSORIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_DESATIVADO', ftString, 1)]
    [Dictionary('FAT_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_DESATIVADO: String read FFAT_DESATIVADO write FFAT_DESATIVADO;
    const FAT_DESATIVADO_Name = 'FAT_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('NTO_CODIGO', ftInteger)]
    [Dictionary('NTO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NTO_CODIGO: Integer read FNTO_CODIGO write FNTO_CODIGO;
    const NTO_CODIGO_Name = 'NTO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('PES_NOMECLIENTE', ftString, 100)]
    [Dictionary('PES_NOMECLIENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMECLIENTE: String read FPES_NOMECLIENTE write FPES_NOMECLIENTE;
    const PES_NOMECLIENTE_Name = 'PES_NOMECLIENTE';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOPESSOA', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA: String read FPES_TIPOPESSOA write FPES_TIPOPESSOA;
    const PES_TIPOPESSOA_Name = 'PES_TIPOPESSOA';

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
    [Column('PES_DESATIVADO', ftString, 1)]
    [Dictionary('PES_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DESATIVADO: String read FPES_DESATIVADO write FPES_DESATIVADO;
    const PES_DESATIVADO_Name = 'PES_DESATIVADO';

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

    [Restrictions([NoValidate])]
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
    [Column('PES_CLIENTE', ftString, 1)]
    [Dictionary('PES_CLIENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CLIENTE: String read FPES_CLIENTE write FPES_CLIENTE;
    const PES_CLIENTE_Name = 'PES_CLIENTE';

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
    [Column('CGA_NUMEROORDEMENTREGA', ftInteger)]
    [Dictionary('CGA_NUMEROORDEMENTREGA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CGA_NUMEROORDEMENTREGA: Integer read FCGA_NUMEROORDEMENTREGA write FCGA_NUMEROORDEMENTREGA;
    const CGA_NUMEROORDEMENTREGA_Name = 'CGA_NUMEROORDEMENTREGA';

    [Restrictions([NoValidate])]
    [Column('PES_ORDEMENTREGA', ftString, 6)]
    [Dictionary('PES_ORDEMENTREGA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ORDEMENTREGA: String read FPES_ORDEMENTREGA write FPES_ORDEMENTREGA;
    const PES_ORDEMENTREGA_Name = 'PES_ORDEMENTREGA';

    [Restrictions([NoValidate])]
    [Column('NTO_MODELOOPERACAO', ftString, 1)]
    [Dictionary('NTO_MODELOOPERACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_MODELOOPERACAO: String read FNTO_MODELOOPERACAO write FNTO_MODELOOPERACAO;
    const NTO_MODELOOPERACAO_Name = 'NTO_MODELOOPERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALFINANCEIROPRAZO', ftBCD)]
    [Dictionary('FAT_TOTALFINANCEIROPRAZO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALFINANCEIROPRAZO: Double read FFAT_TOTALFINANCEIROPRAZO write FFAT_TOTALFINANCEIROPRAZO;
    const FAT_TOTALFINANCEIROPRAZO_Name = 'FAT_TOTALFINANCEIROPRAZO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALADICIONAL', ftBCD)]
    [Dictionary('FAT_TOTALADICIONAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALADICIONAL: Double read FFAT_TOTALADICIONAL write FFAT_TOTALADICIONAL;
    const FAT_TOTALADICIONAL_Name = 'FAT_TOTALADICIONAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TIPOFRETE', ftString, 1)]
    [Dictionary('FAT_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_TIPOFRETE: String read FFAT_TIPOFRETE write FFAT_TIPOFRETE;
    const FAT_TIPOFRETE_Name = 'FAT_TIPOFRETE';

    [Restrictions([NoValidate])]
    [Column('TDC_CODIGO', ftString, 4)]
    [Dictionary('TDC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TDC_CODIGO: String read FTDC_CODIGO write FTDC_CODIGO;
    const TDC_CODIGO_Name = 'TDC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('SEG_CODIGO', ftInteger)]
    [Dictionary('SEG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property SEG_CODIGO: Integer read FSEG_CODIGO write FSEG_CODIGO;
    const SEG_CODIGO_Name = 'SEG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VEI_CODIGO', ftInteger)]
    [Dictionary('VEI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEI_CODIGO: Integer read FVEI_CODIGO write FVEI_CODIGO;
    const VEI_CODIGO_Name = 'VEI_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VEI_PLACA', ftString, 7)]
    [Dictionary('VEI_PLACA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_PLACA: String read FVEI_PLACA write FVEI_PLACA;
    const VEI_PLACA_Name = 'VEI_PLACA';

    [Restrictions([NoValidate])]
    [Column('VEI_DESCRICAO', ftString, 40)]
    [Dictionary('VEI_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_DESCRICAO: String read FVEI_DESCRICAO write FVEI_DESCRICAO;
    const VEI_DESCRICAO_Name = 'VEI_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('VEI_TIPODOCUMENTO', ftString, 3)]
    [Dictionary('VEI_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_TIPODOCUMENTO: String read FVEI_TIPODOCUMENTO write FVEI_TIPODOCUMENTO;
    const VEI_TIPODOCUMENTO_Name = 'VEI_TIPODOCUMENTO';

    [Restrictions([NoValidate])]
    [Column('FAT_OBSERVACAOVEICULO', ftString, 300)]
    [Dictionary('FAT_OBSERVACAOVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_OBSERVACAOVEICULO: String read FFAT_OBSERVACAOVEICULO write FFAT_OBSERVACAOVEICULO;
    const FAT_OBSERVACAOVEICULO_Name = 'FAT_OBSERVACAOVEICULO';

    [Restrictions([NoValidate])]
    [Column('MAR_CODIGO', ftInteger)]
    [Dictionary('MAR_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property MAR_CODIGO: Integer read FMAR_CODIGO write FMAR_CODIGO;
    const MAR_CODIGO_Name = 'MAR_CODIGO';

    [Restrictions([NoValidate])]
    [Column('MAR_NOME', ftString, 30)]
    [Dictionary('MAR_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MAR_NOME: String read FMAR_NOME write FMAR_NOME;
    const MAR_NOME_Name = 'MAR_NOME';

    [Restrictions([NoValidate])]
    [Column('VEI_ANO_MODELO', ftString, 9)]
    [Dictionary('VEI_ANO_MODELO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_ANO_MODELO: String read FVEI_ANO_MODELO write FVEI_ANO_MODELO;
    const VEI_ANO_MODELO_Name = 'VEI_ANO_MODELO';

    [Restrictions([NoValidate])]
    [Column('VEI_NUMEROCHASSI', ftString, 30)]
    [Dictionary('VEI_NUMEROCHASSI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_NUMEROCHASSI: String read FVEI_NUMEROCHASSI write FVEI_NUMEROCHASSI;
    const VEI_NUMEROCHASSI_Name = 'VEI_NUMEROCHASSI';

    [Restrictions([NoValidate])]
    [Column('FAT_NF', ftString, 12)]
    [Dictionary('FAT_NF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NF: String read FFAT_NF write FFAT_NF;
    const FAT_NF_Name = 'FAT_NF';

    [Restrictions([NoValidate])]
    [Column('FAT_NFS', ftString, 13)]
    [Dictionary('FAT_NFS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NFS: String read FFAT_NFS write FFAT_NFS;
    const FAT_NFS_Name = 'FAT_NFS';

    [Restrictions([NoValidate])]
    [Column('FAT_INTEGRACAO', ftString, 3)]
    [Dictionary('FAT_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_INTEGRACAO: String read FFAT_INTEGRACAO write FFAT_INTEGRACAO;
    const FAT_INTEGRACAO_Name = 'FAT_INTEGRACAO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPRECOTABELA', ftBCD, 48, 2)]
    [Dictionary('FAT_TOTALPRECOTABELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPRECOTABELA: Double read FFAT_TOTALPRECOTABELA write FFAT_TOTALPRECOTABELA;
    const FAT_TOTALPRECOTABELA_Name = 'FAT_TOTALPRECOTABELA';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPRECOCUSTO', ftBCD)]
    [Dictionary('FAT_TOTALPRECOCUSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPRECOCUSTO: Double read FFAT_TOTALPRECOCUSTO write FFAT_TOTALPRECOCUSTO;
    const FAT_TOTALPRECOCUSTO_Name = 'FAT_TOTALPRECOCUSTO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPRECODIGITADO', ftBCD)]
    [Dictionary('FAT_TOTALPRECODIGITADO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPRECODIGITADO: Double read FFAT_TOTALPRECODIGITADO write FFAT_TOTALPRECODIGITADO;
    const FAT_TOTALPRECODIGITADO_Name = 'FAT_TOTALPRECODIGITADO';

    [Restrictions([NoValidate])]
    [Column('FAT_POSVENDA', ftString, 1)]
    [Dictionary('FAT_POSVENDA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_POSVENDA: String read FFAT_POSVENDA write FFAT_POSVENDA;
    const FAT_POSVENDA_Name = 'FAT_POSVENDA';

    [Restrictions([NoValidate])]
    [Column('FAT_OBSSOLICITACAOCLIENTE', ftString, 5000)]
    [Dictionary('FAT_OBSSOLICITACAOCLIENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_OBSSOLICITACAOCLIENTE: String read FFAT_OBSSOLICITACAOCLIENTE write FFAT_OBSSOLICITACAOCLIENTE;
    const FAT_OBSSOLICITACAOCLIENTE_Name = 'FAT_OBSSOLICITACAOCLIENTE';

    [Restrictions([NoValidate])]
    [Column('FAT_OBSENTRADAVEICULO', ftString, 5000)]
    [Dictionary('FAT_OBSENTRADAVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_OBSENTRADAVEICULO: String read FFAT_OBSENTRADAVEICULO write FFAT_OBSENTRADAVEICULO;
    const FAT_OBSENTRADAVEICULO_Name = 'FAT_OBSENTRADAVEICULO';

    [Restrictions([NoValidate])]
    [Column('FAT_OBSFECHAMENTOORDEMSERVICO', ftString, 5000)]
    [Dictionary('FAT_OBSFECHAMENTOORDEMSERVICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_OBSFECHAMENTOORDEMSERVICO: String read FFAT_OBSFECHAMENTOORDEMSERVICO write FFAT_OBSFECHAMENTOORDEMSERVICO;
    const FAT_OBSFECHAMENTOORDEMSERVICO_Name = 'FAT_OBSFECHAMENTOORDEMSERVICO';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGO', ftInteger)]
    [Dictionary('CCU_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGO: Integer read FCCU_CODIGO write FCCU_CODIGO;
    const CCU_CODIGO_Name = 'CCU_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FAT_TIPODOCUMENTO', ftString, 3)]
    [Dictionary('FAT_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_TIPODOCUMENTO: String read FFAT_TIPODOCUMENTO write FFAT_TIPODOCUMENTO;
    const FAT_TIPODOCUMENTO_Name = 'FAT_TIPODOCUMENTO';

    [Restrictions([NoValidate])]
    [Column('FAT_KMVEICULO', ftInteger)]
    [Dictionary('FAT_KMVEICULO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_KMVEICULO: Integer read FFAT_KMVEICULO write FFAT_KMVEICULO;
    const FAT_KMVEICULO_Name = 'FAT_KMVEICULO';

    [Restrictions([NoValidate])]
    [Column('FAT_DIASRETORNO', ftInteger)]
    [Dictionary('FAT_DIASRETORNO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_DIASRETORNO: Integer read FFAT_DIASRETORNO write FFAT_DIASRETORNO;
    const FAT_DIASRETORNO_Name = 'FAT_DIASRETORNO';

    [Restrictions([NoValidate])]
    [Column('VEI_NUMERORENAVAM', ftString, 15)]
    [Dictionary('VEI_NUMERORENAVAM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_NUMERORENAVAM: String read FVEI_NUMERORENAVAM write FVEI_NUMERORENAVAM;
    const VEI_NUMERORENAVAM_Name = 'VEI_NUMERORENAVAM';

    [Restrictions([NoValidate])]
    [Column('VEI_COR', ftString, 15)]
    [Dictionary('VEI_COR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_COR: String read FVEI_COR write FVEI_COR;
    const VEI_COR_Name = 'VEI_COR';

    [Restrictions([NoValidate])]
    [Column('VEI_TIPOCOMBUSTIVEL', ftString, 1)]
    [Dictionary('VEI_TIPOCOMBUSTIVEL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_TIPOCOMBUSTIVEL: String read FVEI_TIPOCOMBUSTIVEL write FVEI_TIPOCOMBUSTIVEL;
    const VEI_TIPOCOMBUSTIVEL_Name = 'VEI_TIPOCOMBUSTIVEL';

    [Restrictions([NoValidate])]
    [Column('VEI_COMBUSTIVEL', ftString, 8)]
    [Dictionary('VEI_COMBUSTIVEL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_COMBUSTIVEL: String read FVEI_COMBUSTIVEL write FVEI_COMBUSTIVEL;
    const VEI_COMBUSTIVEL_Name = 'VEI_COMBUSTIVEL';

    [Restrictions([NoValidate])]
    [Column('USERS_LOGIN', ftString, 250)]
    [Dictionary('USERS_LOGIN', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property USERS_LOGIN: String read FUSERS_LOGIN write FUSERS_LOGIN;
    const USERS_LOGIN_Name = 'USERS_LOGIN';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALTROCO', ftBCD)]
    [Dictionary('FAT_TOTALTROCO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALTROCO: Double read FFAT_TOTALTROCO write FFAT_TOTALTROCO;
    const FAT_TOTALTROCO_Name = 'FAT_TOTALTROCO';

    [Restrictions([NoValidate])]
    [Column('FAT_NSV', ftInteger)]
    [Dictionary('FAT_NSV', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_NSV: Integer read FFAT_NSV write FFAT_NSV;
    const FAT_NSV_Name = 'FAT_NSV';

    [Restrictions([NoValidate])]
    [Column('FAT_TIPOMOVTO', ftString, 3)]
    [Dictionary('FAT_TIPOMOVTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_TIPOMOVTO: String read FFAT_TIPOMOVTO write FFAT_TIPOMOVTO;
    const FAT_TIPOMOVTO_Name = 'FAT_TIPOMOVTO';

    [Restrictions([NoValidate])]
    [Column('FAT_RESERVARESTOQUE', ftString, 1)]
    [Dictionary('FAT_RESERVARESTOQUE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_RESERVARESTOQUE: String read FFAT_RESERVARESTOQUE write FFAT_RESERVARESTOQUE;
    const FAT_RESERVARESTOQUE_Name = 'FAT_RESERVARESTOQUE';

    [Restrictions([NoValidate])]
    [Column('FAT_FATURADOPRODUTOS', ftString, 1)]
    [Dictionary('FAT_FATURADOPRODUTOS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_FATURADOPRODUTOS: String read FFAT_FATURADOPRODUTOS write FFAT_FATURADOPRODUTOS;
    const FAT_FATURADOPRODUTOS_Name = 'FAT_FATURADOPRODUTOS';

    [Restrictions([NoValidate])]
    [Column('FAT_FATURADOSERVICOS', ftString, 1)]
    [Dictionary('FAT_FATURADOSERVICOS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_FATURADOSERVICOS: String read FFAT_FATURADOSERVICOS write FFAT_FATURADOSERVICOS;
    const FAT_FATURADOSERVICOS_Name = 'FAT_FATURADOSERVICOS';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALQTDHORAS', ftBCD)]
    [Dictionary('FAT_TOTALQTDHORAS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALQTDHORAS: Double read FFAT_TOTALQTDHORAS write FFAT_TOTALQTDHORAS;
    const FAT_TOTALQTDHORAS_Name = 'FAT_TOTALQTDHORAS';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALQTDPEDIDA', ftBCD)]
    [Dictionary('FAT_TOTALQTDPEDIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALQTDPEDIDA: Double read FFAT_TOTALQTDPEDIDA write FFAT_TOTALQTDPEDIDA;
    const FAT_TOTALQTDPEDIDA_Name = 'FAT_TOTALQTDPEDIDA';

    [Restrictions([NoValidate])]
    [Column('FAT_NUMEROOC', ftInteger)]
    [Dictionary('FAT_NUMEROOC', 'Mensagem de validação', '0', '', '', taCenter)]
    property FAT_NUMEROOC: Integer read FFAT_NUMEROOC write FFAT_NUMEROOC;
    const FAT_NUMEROOC_Name = 'FAT_NUMEROOC';

    [Restrictions([NoValidate])]
    [Column('FAT_NUMEROLICITACAO', ftString, 20)]
    [Dictionary('FAT_NUMEROLICITACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_NUMEROLICITACAO: String read FFAT_NUMEROLICITACAO write FFAT_NUMEROLICITACAO;
    const FAT_NUMEROLICITACAO_Name = 'FAT_NUMEROLICITACAO';

    [Restrictions([NoValidate])]
    [Column('FAT_TOTALPESOBRUTO', ftBCD, 18, 4)]
    [Dictionary('FAT_TOTALPESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPESOBRUTO: Double read FFAT_TOTALPESOBRUTO write FFAT_TOTALPESOBRUTO;
    const FAT_TOTALPESOBRUTO_Name = 'FAT_TOTALPESOBRUTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TOTALPESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('FAT_TOTALPESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FAT_TOTALPESOLIQUIDO: Double read FFAT_TOTALPESOLIQUIDO write FFAT_TOTALPESOLIQUIDO;
    const FAT_TOTALPESOLIQUIDO_Name = 'FAT_TOTALPESOLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FAT_TIPOFRETEDESC', ftString, 3)]
    [Dictionary('FAT_TIPOFRETEDESC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FAT_TIPOFRETEDESC: String read FFAT_TIPOFRETEDESC write FFAT_TIPOFRETEDESC;
    const FAT_TIPOFRETEDESC_Name = 'FAT_TIPOFRETEDESC';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_FAT)

end.
