unit express.dbo.REL_V01_ORS;

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
  [Table('REL_V01_ORS', '')]
  TDtoREL_V01_ORS = class
  private
    { Private declarations } 
    FORS_ID: Integer;
    FCOM_CODIGO: Integer;
    FORS_NUMEROOS: Integer;
    FORS_NUMEROOC: Integer;
    FORS_NUMERODOCTO: String;
    FORS_NOTAFISCAL: String;
    FORS_NOTAFISCALSERVICO: String;
    FORS_DATAEMISSAO: TDateTime;
    FORS_DATARETORNO: TDateTime;
    FORS_DATAFECHAMENTO: TDateTime;
    FORS_DIASRETORNO: Integer;
    FORS_DIASVALIDADEORCAMENTO: Integer;
    FPES_CODIGO: Integer;
    FORS_OBSERVACAO: String;
    FORS_SOLICITACOES: String;
    FORS_OBSERVACAOENTRADA: String;
    FORS_OBSERVACAOFECHAMENTO: String;
    FORS_TOTALACRESCIMOITEM: Double;
    FORS_TOTALDESCTOAVULSO: Double;
    FORS_TOTALDESCTOITEM: Double;
    FORS_TOTALDESCTOSERVICOS: Double;
    FORS_TOTALLIQUIDO: Double;
    FORS_TOTALPRODUTOS: Double;
    FORS_TOTALQTDHORAS: Integer;
    FORS_TOTALQTDPEDIDA: Double;
    FORS_TOTALSERVICOS: Double;
    FPES_NOME: String;
    FPES_DDD_TELEFONE_1: String;
    FVND_CODIGO: Integer;
    FPES_NOMEVENDEDOR: String;
    FROT_CODIGO: Integer;
    FSEG_CODIGO: Integer;
    FORS_MESCLADO: String;
    FORS_TIPODOCUMENTO: String;
    FVEI_CODIGO: Integer;
    FVEI_PLACA: String;
    FVEI_DESCRICAO: String;
    FVEI_TIPODOCUMENTO: String;
    FVEI_COR: String;
    FMAR_CODIGO: Integer;
    FMAR_NOME: String;
    FVEI_ANO_MODELO: String;
    FVEI_NUMEROCHASSI: String;
    FVEI_TIPOCOMBUSTIVEL: String;
    FORS_FATURADO: String;
    FORS_STATUS: String;
    FPES_CNPJ_CPF: String;
    FPES_IE_CI: String;
    FORS_TOTALACRESCIMOAVULSO: Double;
    FPES_TIPOPESSOA: String;
    FPES_ENDERECO: String;
    FPES_NUMEROENDERECO: String;
    FPES_BAIRRO: String;
    FCEP_CODIGO: String;
    FPES_PONTOREFERENCIA: String;
    FPES_DDD_CELULAR_1: String;
    FCID_IBGE: String;
    FPES_CIDADE: String;
    FPES_UF: String;
    FORS_TOTALKMVEICULO: Integer;
    FORS_NUMEROITENS: Integer;
    FORS_NUMEROSERVICOS: Integer;
    FORS_FECHADO: String;
    FORS_TOTALPRODUTOSLIQUIDO: Double;
    FORS_OBSERVACAOVEICULO: String;
    FORS_STATUSFECHAMENTO: String;
    FORS_CANCELADA: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V01_ORS';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_ID', ftInteger)]
    [Dictionary('ORS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_ID: Integer read FORS_ID write FORS_ID;
    const ORS_ID_Name = 'ORS_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('ORS_NUMEROOS', ftInteger)]
    [Dictionary('ORS_NUMEROOS', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_NUMEROOS: Integer read FORS_NUMEROOS write FORS_NUMEROOS;
    const ORS_NUMEROOS_Name = 'ORS_NUMEROOS';

    [Restrictions([NoValidate])]
    [Column('ORS_NUMEROOC', ftInteger)]
    [Dictionary('ORS_NUMEROOC', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_NUMEROOC: Integer read FORS_NUMEROOC write FORS_NUMEROOC;
    const ORS_NUMEROOC_Name = 'ORS_NUMEROOC';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_NUMERODOCTO', ftString, 10)]
    [Dictionary('ORS_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_NUMERODOCTO: String read FORS_NUMERODOCTO write FORS_NUMERODOCTO;
    const ORS_NUMERODOCTO_Name = 'ORS_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('ORS_NOTAFISCAL', ftString, 9)]
    [Dictionary('ORS_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_NOTAFISCAL: String read FORS_NOTAFISCAL write FORS_NOTAFISCAL;
    const ORS_NOTAFISCAL_Name = 'ORS_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('ORS_NOTAFISCALSERVICO', ftString, 9)]
    [Dictionary('ORS_NOTAFISCALSERVICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_NOTAFISCALSERVICO: String read FORS_NOTAFISCALSERVICO write FORS_NOTAFISCALSERVICO;
    const ORS_NOTAFISCALSERVICO_Name = 'ORS_NOTAFISCALSERVICO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_DATAEMISSAO', ftDateTime)]
    [Dictionary('ORS_DATAEMISSAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property ORS_DATAEMISSAO: TDateTime read FORS_DATAEMISSAO write FORS_DATAEMISSAO;
    const ORS_DATAEMISSAO_Name = 'ORS_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('ORS_DATARETORNO', ftDateTime)]
    [Dictionary('ORS_DATARETORNO', 'Mensagem de validação', '', '', '', taCenter)]
    property ORS_DATARETORNO: TDateTime read FORS_DATARETORNO write FORS_DATARETORNO;
    const ORS_DATARETORNO_Name = 'ORS_DATARETORNO';

    [Restrictions([NoValidate])]
    [Column('ORS_DATAFECHAMENTO', ftDateTime)]
    [Dictionary('ORS_DATAFECHAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property ORS_DATAFECHAMENTO: TDateTime read FORS_DATAFECHAMENTO write FORS_DATAFECHAMENTO;
    const ORS_DATAFECHAMENTO_Name = 'ORS_DATAFECHAMENTO';

    [Restrictions([NoValidate])]
    [Column('ORS_DIASRETORNO', ftInteger)]
    [Dictionary('ORS_DIASRETORNO', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_DIASRETORNO: Integer read FORS_DIASRETORNO write FORS_DIASRETORNO;
    const ORS_DIASRETORNO_Name = 'ORS_DIASRETORNO';

    [Restrictions([NoValidate])]
    [Column('ORS_DIASVALIDADEORCAMENTO', ftInteger)]
    [Dictionary('ORS_DIASVALIDADEORCAMENTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_DIASVALIDADEORCAMENTO: Integer read FORS_DIASVALIDADEORCAMENTO write FORS_DIASVALIDADEORCAMENTO;
    const ORS_DIASVALIDADEORCAMENTO_Name = 'ORS_DIASVALIDADEORCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('ORS_OBSERVACAO', ftString, 5000)]
    [Dictionary('ORS_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_OBSERVACAO: String read FORS_OBSERVACAO write FORS_OBSERVACAO;
    const ORS_OBSERVACAO_Name = 'ORS_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('ORS_SOLICITACOES', ftString, 5000)]
    [Dictionary('ORS_SOLICITACOES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_SOLICITACOES: String read FORS_SOLICITACOES write FORS_SOLICITACOES;
    const ORS_SOLICITACOES_Name = 'ORS_SOLICITACOES';

    [Restrictions([NoValidate])]
    [Column('ORS_OBSERVACAOENTRADA', ftString, 5000)]
    [Dictionary('ORS_OBSERVACAOENTRADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_OBSERVACAOENTRADA: String read FORS_OBSERVACAOENTRADA write FORS_OBSERVACAOENTRADA;
    const ORS_OBSERVACAOENTRADA_Name = 'ORS_OBSERVACAOENTRADA';

    [Restrictions([NoValidate])]
    [Column('ORS_OBSERVACAOFECHAMENTO', ftString, 5000)]
    [Dictionary('ORS_OBSERVACAOFECHAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_OBSERVACAOFECHAMENTO: String read FORS_OBSERVACAOFECHAMENTO write FORS_OBSERVACAOFECHAMENTO;
    const ORS_OBSERVACAOFECHAMENTO_Name = 'ORS_OBSERVACAOFECHAMENTO';

    [Restrictions([NoValidate])]
    [Column('ORS_TOTALACRESCIMOITEM', ftBCD)]
    [Dictionary('ORS_TOTALACRESCIMOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALACRESCIMOITEM: Double read FORS_TOTALACRESCIMOITEM write FORS_TOTALACRESCIMOITEM;
    const ORS_TOTALACRESCIMOITEM_Name = 'ORS_TOTALACRESCIMOITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_TOTALDESCTOAVULSO', ftBCD)]
    [Dictionary('ORS_TOTALDESCTOAVULSO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALDESCTOAVULSO: Double read FORS_TOTALDESCTOAVULSO write FORS_TOTALDESCTOAVULSO;
    const ORS_TOTALDESCTOAVULSO_Name = 'ORS_TOTALDESCTOAVULSO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_TOTALDESCTOITEM', ftBCD)]
    [Dictionary('ORS_TOTALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALDESCTOITEM: Double read FORS_TOTALDESCTOITEM write FORS_TOTALDESCTOITEM;
    const ORS_TOTALDESCTOITEM_Name = 'ORS_TOTALDESCTOITEM';

    [Restrictions([NoValidate])]
    [Column('ORS_TOTALDESCTOSERVICOS', ftBCD)]
    [Dictionary('ORS_TOTALDESCTOSERVICOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALDESCTOSERVICOS: Double read FORS_TOTALDESCTOSERVICOS write FORS_TOTALDESCTOSERVICOS;
    const ORS_TOTALDESCTOSERVICOS_Name = 'ORS_TOTALDESCTOSERVICOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_TOTALLIQUIDO', ftBCD, 10, 2)]
    [Dictionary('ORS_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALLIQUIDO: Double read FORS_TOTALLIQUIDO write FORS_TOTALLIQUIDO;
    const ORS_TOTALLIQUIDO_Name = 'ORS_TOTALLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_TOTALPRODUTOS', ftBCD)]
    [Dictionary('ORS_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALPRODUTOS: Double read FORS_TOTALPRODUTOS write FORS_TOTALPRODUTOS;
    const ORS_TOTALPRODUTOS_Name = 'ORS_TOTALPRODUTOS';

    [Restrictions([NoValidate])]
    [Column('ORS_TOTALQTDHORAS', ftInteger)]
    [Dictionary('ORS_TOTALQTDHORAS', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_TOTALQTDHORAS: Integer read FORS_TOTALQTDHORAS write FORS_TOTALQTDHORAS;
    const ORS_TOTALQTDHORAS_Name = 'ORS_TOTALQTDHORAS';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_TOTALQTDPEDIDA', ftBCD, 18, 4)]
    [Dictionary('ORS_TOTALQTDPEDIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALQTDPEDIDA: Double read FORS_TOTALQTDPEDIDA write FORS_TOTALQTDPEDIDA;
    const ORS_TOTALQTDPEDIDA_Name = 'ORS_TOTALQTDPEDIDA';

    [Restrictions([NoValidate])]
    [Column('ORS_TOTALSERVICOS', ftBCD)]
    [Dictionary('ORS_TOTALSERVICOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALSERVICOS: Double read FORS_TOTALSERVICOS write FORS_TOTALSERVICOS;
    const ORS_TOTALSERVICOS_Name = 'ORS_TOTALSERVICOS';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('PES_DDD_TELEFONE_1', ftString, 11)]
    [Dictionary('PES_DDD_TELEFONE_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_TELEFONE_1: String read FPES_DDD_TELEFONE_1 write FPES_DDD_TELEFONE_1;
    const PES_DDD_TELEFONE_1_Name = 'PES_DDD_TELEFONE_1';

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
    [Column('ORS_MESCLADO', ftString, 1)]
    [Dictionary('ORS_MESCLADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_MESCLADO: String read FORS_MESCLADO write FORS_MESCLADO;
    const ORS_MESCLADO_Name = 'ORS_MESCLADO';

    [Restrictions([NoValidate])]
    [Column('ORS_TIPODOCUMENTO', ftString, 3)]
    [Dictionary('ORS_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_TIPODOCUMENTO: String read FORS_TIPODOCUMENTO write FORS_TIPODOCUMENTO;
    const ORS_TIPODOCUMENTO_Name = 'ORS_TIPODOCUMENTO';

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
    [Column('VEI_COR', ftString, 15)]
    [Dictionary('VEI_COR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_COR: String read FVEI_COR write FVEI_COR;
    const VEI_COR_Name = 'VEI_COR';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('VEI_TIPOCOMBUSTIVEL', ftString, 8)]
    [Dictionary('VEI_TIPOCOMBUSTIVEL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_TIPOCOMBUSTIVEL: String read FVEI_TIPOCOMBUSTIVEL write FVEI_TIPOCOMBUSTIVEL;
    const VEI_TIPOCOMBUSTIVEL_Name = 'VEI_TIPOCOMBUSTIVEL';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_FATURADO', ftString, 1)]
    [Dictionary('ORS_FATURADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_FATURADO: String read FORS_FATURADO write FORS_FATURADO;
    const ORS_FATURADO_Name = 'ORS_FATURADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_STATUS', ftString, 36)]
    [Dictionary('ORS_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_STATUS: String read FORS_STATUS write FORS_STATUS;
    const ORS_STATUS_Name = 'ORS_STATUS';

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
    [Column('ORS_TOTALACRESCIMOAVULSO', ftBCD)]
    [Dictionary('ORS_TOTALACRESCIMOAVULSO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALACRESCIMOAVULSO: Double read FORS_TOTALACRESCIMOAVULSO write FORS_TOTALACRESCIMOAVULSO;
    const ORS_TOTALACRESCIMOAVULSO_Name = 'ORS_TOTALACRESCIMOAVULSO';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOPESSOA', ftString, 1)]
    [Dictionary('PES_TIPOPESSOA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPESSOA: String read FPES_TIPOPESSOA write FPES_TIPOPESSOA;
    const PES_TIPOPESSOA_Name = 'PES_TIPOPESSOA';

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
    [Column('ORS_TOTALKMVEICULO', ftInteger)]
    [Dictionary('ORS_TOTALKMVEICULO', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_TOTALKMVEICULO: Integer read FORS_TOTALKMVEICULO write FORS_TOTALKMVEICULO;
    const ORS_TOTALKMVEICULO_Name = 'ORS_TOTALKMVEICULO';

    [Restrictions([NoValidate])]
    [Column('ORS_NUMEROITENS', ftInteger)]
    [Dictionary('ORS_NUMEROITENS', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_NUMEROITENS: Integer read FORS_NUMEROITENS write FORS_NUMEROITENS;
    const ORS_NUMEROITENS_Name = 'ORS_NUMEROITENS';

    [Restrictions([NoValidate])]
    [Column('ORS_NUMEROSERVICOS', ftInteger)]
    [Dictionary('ORS_NUMEROSERVICOS', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_NUMEROSERVICOS: Integer read FORS_NUMEROSERVICOS write FORS_NUMEROSERVICOS;
    const ORS_NUMEROSERVICOS_Name = 'ORS_NUMEROSERVICOS';

    [Restrictions([NoValidate])]
    [Column('ORS_FECHADO', ftString, 1)]
    [Dictionary('ORS_FECHADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_FECHADO: String read FORS_FECHADO write FORS_FECHADO;
    const ORS_FECHADO_Name = 'ORS_FECHADO';

    [Restrictions([NoValidate])]
    [Column('ORS_TOTALPRODUTOSLIQUIDO', ftBCD)]
    [Dictionary('ORS_TOTALPRODUTOSLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALPRODUTOSLIQUIDO: Double read FORS_TOTALPRODUTOSLIQUIDO write FORS_TOTALPRODUTOSLIQUIDO;
    const ORS_TOTALPRODUTOSLIQUIDO_Name = 'ORS_TOTALPRODUTOSLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('ORS_OBSERVACAOVEICULO', ftString, 5000)]
    [Dictionary('ORS_OBSERVACAOVEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_OBSERVACAOVEICULO: String read FORS_OBSERVACAOVEICULO write FORS_OBSERVACAOVEICULO;
    const ORS_OBSERVACAOVEICULO_Name = 'ORS_OBSERVACAOVEICULO';

    [Restrictions([NoValidate])]
    [Column('ORS_STATUSFECHAMENTO', ftString, 1)]
    [Dictionary('ORS_STATUSFECHAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_STATUSFECHAMENTO: String read FORS_STATUSFECHAMENTO write FORS_STATUSFECHAMENTO;
    const ORS_STATUSFECHAMENTO_Name = 'ORS_STATUSFECHAMENTO';

    [Restrictions([NoValidate])]
    [Column('ORS_CANCELADA', ftString, 1)]
    [Dictionary('ORS_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_CANCELADA: String read FORS_CANCELADA write FORS_CANCELADA;
    const ORS_CANCELADA_Name = 'ORS_CANCELADA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V01_ORS)

end.
