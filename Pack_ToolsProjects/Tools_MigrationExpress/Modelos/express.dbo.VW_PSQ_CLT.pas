unit express.dbo.VW_PSQ_CLT;

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
  [Table('VW_PSQ_CLT', '')]
  TDtoVW_PSQ_CLT = class
  private
    { Private declarations } 
    FCLT_ID: Integer;
    FCOM_CODIGO: Integer;
    FCLT_SERIE: String;
    FPES_CLIENTEREMETENTE: Integer;
    FPES_NOME: String;
    FPES_CLIENTEDESTINATARIO: Integer;
    FPES_NOMEDESTINATARIO: String;
    FMNF_CODIGO: String;
    FCFOP_CODIGO: String;
    FCLT_DATACOLETA: TDateTime;
    FCLT_DATAEMISSAO: TDateTime;
    FCLT_NOTAFISCAL: String;
    FCLT_CHAVEACESSO: String;
    FCLT_NUMEROVOLUMES: Double;
    FCLT_PESOLIQUIDO: Double;
    FCLT_TOTALICMS: Double;
    FCLT_TOTALPRODUTOS: Double;
    FCLT_TOTALNOTAFISCAL: Double;
    FCLT_TOTALBASECALCULOICMS: Double;
    FCLT_TOTALBASECALCULOMVA: Double;
    FCLT_TOTALSUBSTRIBUTARIA: Double;
    FCLT_STATUS: String;
    FCLT_DESATIVADO: String;
    FPES_CIDADEDESTINATARIO: String;
    FPES_UF_DESTINATARIO: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_CLT';

    [Restrictions([NoValidate, NotNull])]
    [Column('CLT_ID', ftInteger)]
    [Dictionary('CLT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CLT_ID: Integer read FCLT_ID write FCLT_ID;
    const CLT_ID_Name = 'CLT_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CLT_SERIE', ftString, 3)]
    [Dictionary('CLT_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLT_SERIE: String read FCLT_SERIE write FCLT_SERIE;
    const CLT_SERIE_Name = 'CLT_SERIE';

    [Restrictions([NoValidate])]
    [Column('PES_CLIENTEREMETENTE', ftInteger)]
    [Dictionary('PES_CLIENTEREMETENTE', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CLIENTEREMETENTE: Integer read FPES_CLIENTEREMETENTE write FPES_CLIENTEREMETENTE;
    const PES_CLIENTEREMETENTE_Name = 'PES_CLIENTEREMETENTE';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('PES_CLIENTEDESTINATARIO', ftInteger)]
    [Dictionary('PES_CLIENTEDESTINATARIO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CLIENTEDESTINATARIO: Integer read FPES_CLIENTEDESTINATARIO write FPES_CLIENTEDESTINATARIO;
    const PES_CLIENTEDESTINATARIO_Name = 'PES_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_NOMEDESTINATARIO', ftString, 100)]
    [Dictionary('PES_NOMEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOMEDESTINATARIO: String read FPES_NOMEDESTINATARIO write FPES_NOMEDESTINATARIO;
    const PES_NOMEDESTINATARIO_Name = 'PES_NOMEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CLT_DATACOLETA', ftDateTime)]
    [Dictionary('CLT_DATACOLETA', 'Mensagem de validação', '', '', '', taCenter)]
    property CLT_DATACOLETA: TDateTime read FCLT_DATACOLETA write FCLT_DATACOLETA;
    const CLT_DATACOLETA_Name = 'CLT_DATACOLETA';

    [Restrictions([NoValidate])]
    [Column('CLT_DATAEMISSAO', ftDateTime)]
    [Dictionary('CLT_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CLT_DATAEMISSAO: TDateTime read FCLT_DATAEMISSAO write FCLT_DATAEMISSAO;
    const CLT_DATAEMISSAO_Name = 'CLT_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('CLT_NOTAFISCAL', ftString, 9)]
    [Dictionary('CLT_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLT_NOTAFISCAL: String read FCLT_NOTAFISCAL write FCLT_NOTAFISCAL;
    const CLT_NOTAFISCAL_Name = 'CLT_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('CLT_CHAVEACESSO', ftString, 44)]
    [Dictionary('CLT_CHAVEACESSO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLT_CHAVEACESSO: String read FCLT_CHAVEACESSO write FCLT_CHAVEACESSO;
    const CLT_CHAVEACESSO_Name = 'CLT_CHAVEACESSO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CLT_NUMEROVOLUMES', ftBCD)]
    [Dictionary('CLT_NUMEROVOLUMES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CLT_NUMEROVOLUMES: Double read FCLT_NUMEROVOLUMES write FCLT_NUMEROVOLUMES;
    const CLT_NUMEROVOLUMES_Name = 'CLT_NUMEROVOLUMES';

    [Restrictions([NoValidate, NotNull])]
    [Column('CLT_PESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('CLT_PESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CLT_PESOLIQUIDO: Double read FCLT_PESOLIQUIDO write FCLT_PESOLIQUIDO;
    const CLT_PESOLIQUIDO_Name = 'CLT_PESOLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CLT_TOTALICMS', ftBCD)]
    [Dictionary('CLT_TOTALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CLT_TOTALICMS: Double read FCLT_TOTALICMS write FCLT_TOTALICMS;
    const CLT_TOTALICMS_Name = 'CLT_TOTALICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CLT_TOTALPRODUTOS', ftBCD)]
    [Dictionary('CLT_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CLT_TOTALPRODUTOS: Double read FCLT_TOTALPRODUTOS write FCLT_TOTALPRODUTOS;
    const CLT_TOTALPRODUTOS_Name = 'CLT_TOTALPRODUTOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CLT_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('CLT_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CLT_TOTALNOTAFISCAL: Double read FCLT_TOTALNOTAFISCAL write FCLT_TOTALNOTAFISCAL;
    const CLT_TOTALNOTAFISCAL_Name = 'CLT_TOTALNOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('CLT_TOTALBASECALCULOICMS', ftBCD, 48, 2)]
    [Dictionary('CLT_TOTALBASECALCULOICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CLT_TOTALBASECALCULOICMS: Double read FCLT_TOTALBASECALCULOICMS write FCLT_TOTALBASECALCULOICMS;
    const CLT_TOTALBASECALCULOICMS_Name = 'CLT_TOTALBASECALCULOICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CLT_TOTALBASECALCULOMVA', ftBCD)]
    [Dictionary('CLT_TOTALBASECALCULOMVA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CLT_TOTALBASECALCULOMVA: Double read FCLT_TOTALBASECALCULOMVA write FCLT_TOTALBASECALCULOMVA;
    const CLT_TOTALBASECALCULOMVA_Name = 'CLT_TOTALBASECALCULOMVA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CLT_TOTALSUBSTRIBUTARIA', ftBCD)]
    [Dictionary('CLT_TOTALSUBSTRIBUTARIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CLT_TOTALSUBSTRIBUTARIA: Double read FCLT_TOTALSUBSTRIBUTARIA write FCLT_TOTALSUBSTRIBUTARIA;
    const CLT_TOTALSUBSTRIBUTARIA_Name = 'CLT_TOTALSUBSTRIBUTARIA';

    [Restrictions([NoValidate])]
    [Column('CLT_STATUS', ftString, 1)]
    [Dictionary('CLT_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLT_STATUS: String read FCLT_STATUS write FCLT_STATUS;
    const CLT_STATUS_Name = 'CLT_STATUS';

    [Restrictions([NoValidate])]
    [Column('CLT_DESATIVADO', ftString, 1)]
    [Dictionary('CLT_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CLT_DESATIVADO: String read FCLT_DESATIVADO write FCLT_DESATIVADO;
    const CLT_DESATIVADO_Name = 'CLT_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('PES_CIDADEDESTINATARIO', ftString, 100)]
    [Dictionary('PES_CIDADEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CIDADEDESTINATARIO: String read FPES_CIDADEDESTINATARIO write FPES_CIDADEDESTINATARIO;
    const PES_CIDADEDESTINATARIO_Name = 'PES_CIDADEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_UF_DESTINATARIO', ftString, 2)]
    [Dictionary('PES_UF_DESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF_DESTINATARIO: String read FPES_UF_DESTINATARIO write FPES_UF_DESTINATARIO;
    const PES_UF_DESTINATARIO_Name = 'PES_UF_DESTINATARIO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_CLT)

end.
