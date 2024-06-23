unit express.dbo.MFC_CONSULTACONHECIMENTO;

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
  [Table('MFC_ConsultaConhecimento', '')]
  TDtoMFC_ConsultaConhecimento = class
  private
    { Private declarations } 
    FCTR_ID: Integer;
    FCOM_CODIGO: Integer;
    FCTR_DATAEMISSAO: TDateTime;
    FCTR_NUMERODOCTO: String;
    FCTR_NOTAFISCAL: String;
    FPES_CLIENTEREMETENTE: Integer;
    FPES_NOME: String;
    FMFC_ID: Integer;
    FMNF_CODIGO: String;
    FMFC_NUMERODOCTO: String;
    FCTR_CANCELADO: String;
    FPES_CLIENTEDESTINATARIO: Integer;
    FPES_NOMECLIENTEDESTINATARIO: String;
    FPES_UF_CLIENTEDESTINATARIO: String;
    FTRP_CODIGO: Integer;
    FTRP_NOME: String;
    FCTR_TOTALNOTAFISCAL: Double;
  public 
    { Public declarations } 
     const Table      = 'MFC_ConsultaConhecimento';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_DATAEMISSAO', ftDateTime)]
    [Dictionary('CTR_DATAEMISSAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CTR_DATAEMISSAO: TDateTime read FCTR_DATAEMISSAO write FCTR_DATAEMISSAO;
    const CTR_DATAEMISSAO_Name = 'CTR_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('CTR_NUMERODOCTO', ftString, 6)]
    [Dictionary('CTR_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NUMERODOCTO: String read FCTR_NUMERODOCTO write FCTR_NUMERODOCTO;
    const CTR_NUMERODOCTO_Name = 'CTR_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('CTR_NOTAFISCAL', ftString, 9)]
    [Dictionary('CTR_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NOTAFISCAL: String read FCTR_NOTAFISCAL write FCTR_NOTAFISCAL;
    const CTR_NOTAFISCAL_Name = 'CTR_NOTAFISCAL';

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
    [Column('MFC_ID', ftInteger)]
    [Dictionary('MFC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_ID: Integer read FMFC_ID write FMFC_ID;
    const MFC_ID_Name = 'MFC_ID';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('MFC_NUMERODOCTO', ftString, 6)]
    [Dictionary('MFC_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_NUMERODOCTO: String read FMFC_NUMERODOCTO write FMFC_NUMERODOCTO;
    const MFC_NUMERODOCTO_Name = 'MFC_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('CTR_CANCELADO', ftString, 1)]
    [Dictionary('CTR_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_CANCELADO: String read FCTR_CANCELADO write FCTR_CANCELADO;
    const CTR_CANCELADO_Name = 'CTR_CANCELADO';

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
    [Column('PES_UF_CLIENTEDESTINATARIO', ftString, 2)]
    [Dictionary('PES_UF_CLIENTEDESTINATARIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF_CLIENTEDESTINATARIO: String read FPES_UF_CLIENTEDESTINATARIO write FPES_UF_CLIENTEDESTINATARIO;
    const PES_UF_CLIENTEDESTINATARIO_Name = 'PES_UF_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('TRP_CODIGO', ftInteger)]
    [Dictionary('TRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TRP_CODIGO: Integer read FTRP_CODIGO write FTRP_CODIGO;
    const TRP_CODIGO_Name = 'TRP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('TRP_NOME', ftString, 100)]
    [Dictionary('TRP_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TRP_NOME: String read FTRP_NOME write FTRP_NOME;
    const TRP_NOME_Name = 'TRP_NOME';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('CTR_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CTR_TOTALNOTAFISCAL: Double read FCTR_TOTALNOTAFISCAL write FCTR_TOTALNOTAFISCAL;
    const CTR_TOTALNOTAFISCAL_Name = 'CTR_TOTALNOTAFISCAL';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoMFC_ConsultaConhecimento)

end.
