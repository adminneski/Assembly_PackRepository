unit express.dbo.REL_V02_ORS;

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
  [Table('REL_V02_ORS', '')]
  TDtoREL_V02_ORS = class
  private
    { Private declarations } 
    FORS_ID: Integer;
    FCOM_CODIGO: Integer;
    FORS_NUMEROOS: Integer;
    FORS_NUMERODOCTO: String;
    FORS_NOTAFISCAL: String;
    FORS_NOTAFISCALSERVICO: String;
    FORS_DATAEMISSAO: TDateTime;
    FPES_CODIGO: Integer;
    FORS_OBSERVACAO: String;
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
    FPES_DDD_CELULAR_1: String;
    FVND_CODIGO: Integer;
    FPES_NOMEVENDEDOR: String;
    FROT_CODIGO: Integer;
    FSEG_CODIGO: Integer;
    FORS_MESCLADO: String;
    FORS_TIPODOCUMENTO: String;
    FVEI_CODIGO: Integer;
    FVEI_PLACA: String;
    FORS_FATURADO: String;
    FORS_STATUS: String;
    FORS_ID_LOG: Integer;
    FORS_DATALOG: TDateTime;
    FORS_HORALOG: String;
    FORS_LOG: Integer;
    FPRO_CODIGO: Integer;
    FORS_QTDPEDIDA: Double;
    FUSERS_LOGIN: String;
    FORS_TIPOLOG: String;
    FORS_TIPOPRODUTO: String;
    FPRO_DESCRICAO: String;
    FPRO_DESCRICAOADICIONAL: String;
    FPRO_EMBALAGEM: String;
    FPRO_REFERENCIAINTERNA: String;
    FPES_NOMEFABRICANTE: String;
    FORS_CANCELADA: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V02_ORS';

    [Restrictions([NoValidate])]
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

    [Restrictions([NoValidate])]
    [Column('ORS_DATAEMISSAO', ftDateTime)]
    [Dictionary('ORS_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property ORS_DATAEMISSAO: TDateTime read FORS_DATAEMISSAO write FORS_DATAEMISSAO;
    const ORS_DATAEMISSAO_Name = 'ORS_DATAEMISSAO';

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
    [Column('ORS_TOTALACRESCIMOITEM', ftBCD, 48, 2)]
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
    [Column('ORS_TOTALDESCTOSERVICOS', ftBCD, 10, 2)]
    [Dictionary('ORS_TOTALDESCTOSERVICOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_TOTALDESCTOSERVICOS: Double read FORS_TOTALDESCTOSERVICOS write FORS_TOTALDESCTOSERVICOS;
    const ORS_TOTALDESCTOSERVICOS_Name = 'ORS_TOTALDESCTOSERVICOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_TOTALLIQUIDO', ftBCD)]
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

    [Restrictions([NoValidate])]
    [Column('PES_DDD_CELULAR_1', ftString, 11)]
    [Dictionary('PES_DDD_CELULAR_1', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_DDD_CELULAR_1: String read FPES_DDD_CELULAR_1 write FPES_DDD_CELULAR_1;
    const PES_DDD_CELULAR_1_Name = 'PES_DDD_CELULAR_1';

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
    [Column('ORS_TIPODOCUMENTO', ftString, 5)]
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

    [Restrictions([NoValidate, NotNull])]
    [Column('ORS_ID_LOG', ftInteger)]
    [Dictionary('ORS_ID_LOG', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_ID_LOG: Integer read FORS_ID_LOG write FORS_ID_LOG;
    const ORS_ID_LOG_Name = 'ORS_ID_LOG';

    [Restrictions([NoValidate])]
    [Column('ORS_DATALOG', ftDateTime)]
    [Dictionary('ORS_DATALOG', 'Mensagem de validação', '', '', '', taCenter)]
    property ORS_DATALOG: TDateTime read FORS_DATALOG write FORS_DATALOG;
    const ORS_DATALOG_Name = 'ORS_DATALOG';

    [Restrictions([NoValidate])]
    [Column('ORS_HORALOG', ftString, 8)]
    [Dictionary('ORS_HORALOG', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_HORALOG: String read FORS_HORALOG write FORS_HORALOG;
    const ORS_HORALOG_Name = 'ORS_HORALOG';

    [Restrictions([NoValidate])]
    [Column('ORS_LOG', ftInteger)]
    [Dictionary('ORS_LOG', 'Mensagem de validação', '0', '', '', taCenter)]
    property ORS_LOG: Integer read FORS_LOG write FORS_LOG;
    const ORS_LOG_Name = 'ORS_LOG';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('ORS_QTDPEDIDA', ftBCD)]
    [Dictionary('ORS_QTDPEDIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ORS_QTDPEDIDA: Double read FORS_QTDPEDIDA write FORS_QTDPEDIDA;
    const ORS_QTDPEDIDA_Name = 'ORS_QTDPEDIDA';

    [Restrictions([NoValidate])]
    [Column('USERS_LOGIN', ftString, 250)]
    [Dictionary('USERS_LOGIN', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property USERS_LOGIN: String read FUSERS_LOGIN write FUSERS_LOGIN;
    const USERS_LOGIN_Name = 'USERS_LOGIN';

    [Restrictions([NoValidate])]
    [Column('ORS_TIPOLOG', ftString, 3)]
    [Dictionary('ORS_TIPOLOG', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_TIPOLOG: String read FORS_TIPOLOG write FORS_TIPOLOG;
    const ORS_TIPOLOG_Name = 'ORS_TIPOLOG';

    [Restrictions([NoValidate])]
    [Column('ORS_TIPOPRODUTO', ftString, 3)]
    [Dictionary('ORS_TIPOPRODUTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_TIPOPRODUTO: String read FORS_TIPOPRODUTO write FORS_TIPOPRODUTO;
    const ORS_TIPOPRODUTO_Name = 'ORS_TIPOPRODUTO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 300)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAOADICIONAL', ftString, 300)]
    [Dictionary('PRO_DESCRICAOADICIONAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAOADICIONAL: String read FPRO_DESCRICAOADICIONAL write FPRO_DESCRICAOADICIONAL;
    const PRO_DESCRICAOADICIONAL_Name = 'PRO_DESCRICAOADICIONAL';

    [Restrictions([NoValidate])]
    [Column('PRO_EMBALAGEM', ftString, 15)]
    [Dictionary('PRO_EMBALAGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_EMBALAGEM: String read FPRO_EMBALAGEM write FPRO_EMBALAGEM;
    const PRO_EMBALAGEM_Name = 'PRO_EMBALAGEM';

    [Restrictions([NoValidate])]
    [Column('PRO_REFERENCIAINTERNA', ftString, 20)]
    [Dictionary('PRO_REFERENCIAINTERNA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_REFERENCIAINTERNA: String read FPRO_REFERENCIAINTERNA write FPRO_REFERENCIAINTERNA;
    const PRO_REFERENCIAINTERNA_Name = 'PRO_REFERENCIAINTERNA';

    [Restrictions([NoValidate])]
    [Column('PES_NOMEFABRICANTE', ftString, 100)]
    [Dictionary('PES_NOMEFABRICANTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMEFABRICANTE: String read FPES_NOMEFABRICANTE write FPES_NOMEFABRICANTE;
    const PES_NOMEFABRICANTE_Name = 'PES_NOMEFABRICANTE';

    [Restrictions([NoValidate])]
    [Column('ORS_CANCELADA', ftString, 1)]
    [Dictionary('ORS_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ORS_CANCELADA: String read FORS_CANCELADA write FORS_CANCELADA;
    const ORS_CANCELADA_Name = 'ORS_CANCELADA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V02_ORS)

end.
