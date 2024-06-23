unit express.dbo.EXP_CTR_ITATIAIA;

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
  [Table('EXP_CTR_Itatiaia', '')]
  TDtoEXP_CTR_Itatiaia = class
  private
    { Private declarations } 
    FMFC_ID: Integer;
    FCTR_ID: Integer;
    FCOM_CODIGO: Integer;
    FCTR_CHAVEACESSO: String;
    FVEI_PLACA: String;
    FMFC_NOTAFISCAL: String;
    FCTR_TOTALBASECALCULOICMS: Double;
    FCTR_PERCENTUALICMS: Double;
    FCTR_TOTALICMS: Double;
    FCTR_TOTALBASECALCULOSUBSTITUICAO: Double;
    FCTR_TOTALSUBSTITUICAO: Double;
    FCTR_TIPOFRETE: String;
    FCTR_TOTALFRETE: Double;
    FCTR_DATAEMISSAO: TDateTime;
    FCTR_NOTAFISCAL: String;
    FCTR_SERIE: String;
    FCTR_VALORNOTAFISCAL: Double;
    FCTR_PESOBRUTO: Double;
    FCTR_PESOLIQUIDO: Double;
    FCTR_VALORPRODUTOS: Double;
    FCTR_NUMEROVOLUMES: Double;
    FPES_CLIENTEREMETENTE: Integer;
    FPES_NOMECLIENTEREMETENTE: String;
    FPES_CNPJ_CLIENTEREMETENTE: String;
    FCID_IBGE_CLIENTEREMETENTE: String;
    FPES_CLIENTEDESTINATARIO: Integer;
    FPES_NOMECLIENTEDESTINATARIO: String;
    FPES_CNPJ_CLIENTEDESTINATARIO: String;
    FPES_IE_CLIENTEDESTINATARIO: String;
    FCID_IBGE_CLIENTEDESTINATARIO: String;
    FPES_UF_CLIENTEDESTINATARIO: String;
    FPES_ENDERECO_CLIENTEDESTINATARIO: String;
    FPES_NUMEROENDERECO_CLIENTEDESTINATARIO: String;
    FPES_BAIRRO_CLIENTEDESTINATARIO: String;
    FPES_PONTOREFERENCIA_CLIENTEDESTINATARIO: String;
    FCEP_CODIGO_CLIENTEDESTINATARIO: String;
  public 
    { Public declarations } 
     const Table      = 'EXP_CTR_Itatiaia';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_ID', ftInteger)]
    [Dictionary('MFC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_ID: Integer read FMFC_ID write FMFC_ID;
    const MFC_ID_Name = 'MFC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_ID', ftInteger)]
    [Dictionary('CTR_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_ID: Integer read FCTR_ID write FCTR_ID;
    const CTR_ID_Name = 'CTR_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTR_CHAVEACESSO', ftString, 44)]
    [Dictionary('CTR_CHAVEACESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_CHAVEACESSO: String read FCTR_CHAVEACESSO write FCTR_CHAVEACESSO;
    const CTR_CHAVEACESSO_Name = 'CTR_CHAVEACESSO';

    [Restrictions([NoValidate])]
    [Column('VEI_PLACA', ftString, 7)]
    [Dictionary('VEI_PLACA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEI_PLACA: String read FVEI_PLACA write FVEI_PLACA;
    const VEI_PLACA_Name = 'VEI_PLACA';

    [Restrictions([NoValidate])]
    [Column('MFC_NOTAFISCAL', ftString, 9)]
    [Dictionary('MFC_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_NOTAFISCAL: String read FMFC_NOTAFISCAL write FMFC_NOTAFISCAL;
    const MFC_NOTAFISCAL_Name = 'MFC_NOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TOTALBASECALCULOICMS', ftBCD)]
    [Dictionary('CTR_TOTALBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALBASECALCULOICMS: Double read FCTR_TOTALBASECALCULOICMS write FCTR_TOTALBASECALCULOICMS;
    const CTR_TOTALBASECALCULOICMS_Name = 'CTR_TOTALBASECALCULOICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_PERCENTUALICMS', ftBCD)]
    [Dictionary('CTR_PERCENTUALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PERCENTUALICMS: Double read FCTR_PERCENTUALICMS write FCTR_PERCENTUALICMS;
    const CTR_PERCENTUALICMS_Name = 'CTR_PERCENTUALICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TOTALICMS', ftBCD)]
    [Dictionary('CTR_TOTALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALICMS: Double read FCTR_TOTALICMS write FCTR_TOTALICMS;
    const CTR_TOTALICMS_Name = 'CTR_TOTALICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TOTALBASECALCULOSUBSTITUICAO', ftBCD)]
    [Dictionary('CTR_TOTALBASECALCULOSUBSTITUICAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALBASECALCULOSUBSTITUICAO: Double read FCTR_TOTALBASECALCULOSUBSTITUICAO write FCTR_TOTALBASECALCULOSUBSTITUICAO;
    const CTR_TOTALBASECALCULOSUBSTITUICAO_Name = 'CTR_TOTALBASECALCULOSUBSTITUICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TOTALSUBSTITUICAO', ftBCD)]
    [Dictionary('CTR_TOTALSUBSTITUICAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALSUBSTITUICAO: Double read FCTR_TOTALSUBSTITUICAO write FCTR_TOTALSUBSTITUICAO;
    const CTR_TOTALSUBSTITUICAO_Name = 'CTR_TOTALSUBSTITUICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TIPOFRETE', ftString, 1)]
    [Dictionary('CTR_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_TIPOFRETE: String read FCTR_TIPOFRETE write FCTR_TIPOFRETE;
    const CTR_TIPOFRETE_Name = 'CTR_TIPOFRETE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TOTALFRETE', ftBCD)]
    [Dictionary('CTR_TOTALFRETE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALFRETE: Double read FCTR_TOTALFRETE write FCTR_TOTALFRETE;
    const CTR_TOTALFRETE_Name = 'CTR_TOTALFRETE';

    [Restrictions([NoValidate])]
    [Column('CTR_DATAEMISSAO', ftDateTime)]
    [Dictionary('CTR_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CTR_DATAEMISSAO: TDateTime read FCTR_DATAEMISSAO write FCTR_DATAEMISSAO;
    const CTR_DATAEMISSAO_Name = 'CTR_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('CTR_NOTAFISCAL', ftString, 9)]
    [Dictionary('CTR_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NOTAFISCAL: String read FCTR_NOTAFISCAL write FCTR_NOTAFISCAL;
    const CTR_NOTAFISCAL_Name = 'CTR_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CTR_SERIE', ftString, 3)]
    [Dictionary('CTR_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_SERIE: String read FCTR_SERIE write FCTR_SERIE;
    const CTR_SERIE_Name = 'CTR_SERIE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_VALORNOTAFISCAL', ftBCD)]
    [Dictionary('CTR_VALORNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_VALORNOTAFISCAL: Double read FCTR_VALORNOTAFISCAL write FCTR_VALORNOTAFISCAL;
    const CTR_VALORNOTAFISCAL_Name = 'CTR_VALORNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CTR_PESOBRUTO', ftBCD, 18, 4)]
    [Dictionary('CTR_PESOBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PESOBRUTO: Double read FCTR_PESOBRUTO write FCTR_PESOBRUTO;
    const CTR_PESOBRUTO_Name = 'CTR_PESOBRUTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_PESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('CTR_PESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_PESOLIQUIDO: Double read FCTR_PESOLIQUIDO write FCTR_PESOLIQUIDO;
    const CTR_PESOLIQUIDO_Name = 'CTR_PESOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('CTR_VALORPRODUTOS', ftBCD)]
    [Dictionary('CTR_VALORPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_VALORPRODUTOS: Double read FCTR_VALORPRODUTOS write FCTR_VALORPRODUTOS;
    const CTR_VALORPRODUTOS_Name = 'CTR_VALORPRODUTOS';

    [Restrictions([NoValidate])]
    [Column('CTR_NUMEROVOLUMES', ftBCD)]
    [Dictionary('CTR_NUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_NUMEROVOLUMES: Double read FCTR_NUMEROVOLUMES write FCTR_NUMEROVOLUMES;
    const CTR_NUMEROVOLUMES_Name = 'CTR_NUMEROVOLUMES';

    [Restrictions([NoValidate])]
    [Column('PES_CLIENTEREMETENTE', ftInteger)]
    [Dictionary('PES_CLIENTEREMETENTE', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CLIENTEREMETENTE: Integer read FPES_CLIENTEREMETENTE write FPES_CLIENTEREMETENTE;
    const PES_CLIENTEREMETENTE_Name = 'PES_CLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_NOMECLIENTEREMETENTE', ftString, 100)]
    [Dictionary('PES_NOMECLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMECLIENTEREMETENTE: String read FPES_NOMECLIENTEREMETENTE write FPES_NOMECLIENTEREMETENTE;
    const PES_NOMECLIENTEREMETENTE_Name = 'PES_NOMECLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CLIENTEREMETENTE', ftString, 14)]
    [Dictionary('PES_CNPJ_CLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CLIENTEREMETENTE: String read FPES_CNPJ_CLIENTEREMETENTE write FPES_CNPJ_CLIENTEREMETENTE;
    const PES_CNPJ_CLIENTEREMETENTE_Name = 'PES_CNPJ_CLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('CID_IBGE_CLIENTEREMETENTE', ftString, 7)]
    [Dictionary('CID_IBGE_CLIENTEREMETENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE_CLIENTEREMETENTE: String read FCID_IBGE_CLIENTEREMETENTE write FCID_IBGE_CLIENTEREMETENTE;
    const CID_IBGE_CLIENTEREMETENTE_Name = 'CID_IBGE_CLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_CLIENTEDESTINATARIO', ftInteger)]
    [Dictionary('PES_CLIENTEDESTINATARIO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CLIENTEDESTINATARIO: Integer read FPES_CLIENTEDESTINATARIO write FPES_CLIENTEDESTINATARIO;
    const PES_CLIENTEDESTINATARIO_Name = 'PES_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_NOMECLIENTEDESTINATARIO', ftString, 100)]
    [Dictionary('PES_NOMECLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMECLIENTEDESTINATARIO: String read FPES_NOMECLIENTEDESTINATARIO write FPES_NOMECLIENTEDESTINATARIO;
    const PES_NOMECLIENTEDESTINATARIO_Name = 'PES_NOMECLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CLIENTEDESTINATARIO', ftString, 14)]
    [Dictionary('PES_CNPJ_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CLIENTEDESTINATARIO: String read FPES_CNPJ_CLIENTEDESTINATARIO write FPES_CNPJ_CLIENTEDESTINATARIO;
    const PES_CNPJ_CLIENTEDESTINATARIO_Name = 'PES_CNPJ_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_IE_CLIENTEDESTINATARIO', ftString, 16)]
    [Dictionary('PES_IE_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE_CLIENTEDESTINATARIO: String read FPES_IE_CLIENTEDESTINATARIO write FPES_IE_CLIENTEDESTINATARIO;
    const PES_IE_CLIENTEDESTINATARIO_Name = 'PES_IE_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('CID_IBGE_CLIENTEDESTINATARIO', ftString, 7)]
    [Dictionary('CID_IBGE_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CID_IBGE_CLIENTEDESTINATARIO: String read FCID_IBGE_CLIENTEDESTINATARIO write FCID_IBGE_CLIENTEDESTINATARIO;
    const CID_IBGE_CLIENTEDESTINATARIO_Name = 'CID_IBGE_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_UF_CLIENTEDESTINATARIO', ftString, 2)]
    [Dictionary('PES_UF_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF_CLIENTEDESTINATARIO: String read FPES_UF_CLIENTEDESTINATARIO write FPES_UF_CLIENTEDESTINATARIO;
    const PES_UF_CLIENTEDESTINATARIO_Name = 'PES_UF_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_ENDERECO_CLIENTEDESTINATARIO', ftString, 100)]
    [Dictionary('PES_ENDERECO_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ENDERECO_CLIENTEDESTINATARIO: String read FPES_ENDERECO_CLIENTEDESTINATARIO write FPES_ENDERECO_CLIENTEDESTINATARIO;
    const PES_ENDERECO_CLIENTEDESTINATARIO_Name = 'PES_ENDERECO_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_NUMEROENDERECO_CLIENTEDESTINATARIO', ftString, 5)]
    [Dictionary('PES_NUMEROENDERECO_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NUMEROENDERECO_CLIENTEDESTINATARIO: String read FPES_NUMEROENDERECO_CLIENTEDESTINATARIO write FPES_NUMEROENDERECO_CLIENTEDESTINATARIO;
    const PES_NUMEROENDERECO_CLIENTEDESTINATARIO_Name = 'PES_NUMEROENDERECO_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_BAIRRO_CLIENTEDESTINATARIO', ftString, 50)]
    [Dictionary('PES_BAIRRO_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_BAIRRO_CLIENTEDESTINATARIO: String read FPES_BAIRRO_CLIENTEDESTINATARIO write FPES_BAIRRO_CLIENTEDESTINATARIO;
    const PES_BAIRRO_CLIENTEDESTINATARIO_Name = 'PES_BAIRRO_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_PONTOREFERENCIA_CLIENTEDESTINATARIO', ftString, 500)]
    [Dictionary('PES_PONTOREFERENCIA_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_PONTOREFERENCIA_CLIENTEDESTINATARIO: String read FPES_PONTOREFERENCIA_CLIENTEDESTINATARIO write FPES_PONTOREFERENCIA_CLIENTEDESTINATARIO;
    const PES_PONTOREFERENCIA_CLIENTEDESTINATARIO_Name = 'PES_PONTOREFERENCIA_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('CEP_CODIGO_CLIENTEDESTINATARIO', ftString, 8)]
    [Dictionary('CEP_CODIGO_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CEP_CODIGO_CLIENTEDESTINATARIO: String read FCEP_CODIGO_CLIENTEDESTINATARIO write FCEP_CODIGO_CLIENTEDESTINATARIO;
    const CEP_CODIGO_CLIENTEDESTINATARIO_Name = 'CEP_CODIGO_CLIENTEDESTINATARIO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoEXP_CTR_Itatiaia)

end.
