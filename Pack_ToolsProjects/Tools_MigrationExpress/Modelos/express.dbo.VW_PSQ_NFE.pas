unit express.dbo.VW_PSQ_NFE;

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
  [Table('VW_PSQ_NFE', '')]
  TDtoVW_PSQ_NFE = class
  private
    { Private declarations } 
    FNFE_ID: Integer;
    FCOM_CODIGO: Integer;
    FNFE_DATAENTRADA: TDateTime;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FNFE_TOTALPRODUTOS: Double;
    FNFE_TOTALNOTAFISCAL: Double;
    FNFE_NOTAFISCAL: String;
    FNFE_PROCESSADO: String;
    FNFE_LIVROFISCAL: String;
    FNFE_CANCELADA: String;
    FNTO_CODIGO: Integer;
    FNTO_DESCRICAO: String;
    FNTO_NAOGERARLIVROFISCAL: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_NFE';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_ID', ftInteger)]
    [Dictionary('NFE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_ID: Integer read FNFE_ID write FNFE_ID;
    const NFE_ID_Name = 'NFE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NFE_DATAENTRADA', ftDateTime)]
    [Dictionary('NFE_DATAENTRADA', 'Mensagem de validação', '', '', '', taCenter)]
    property NFE_DATAENTRADA: TDateTime read FNFE_DATAENTRADA write FNFE_DATAENTRADA;
    const NFE_DATAENTRADA_Name = 'NFE_DATAENTRADA';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALPRODUTOS', ftBCD)]
    [Dictionary('NFE_TOTALPRODUTOS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALPRODUTOS: Double read FNFE_TOTALPRODUTOS write FNFE_TOTALPRODUTOS;
    const NFE_TOTALPRODUTOS_Name = 'NFE_TOTALPRODUTOS';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('NFE_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_TOTALNOTAFISCAL: Double read FNFE_TOTALNOTAFISCAL write FNFE_TOTALNOTAFISCAL;
    const NFE_TOTALNOTAFISCAL_Name = 'NFE_TOTALNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('NFE_NOTAFISCAL', ftString, 9)]
    [Dictionary('NFE_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_NOTAFISCAL: String read FNFE_NOTAFISCAL write FNFE_NOTAFISCAL;
    const NFE_NOTAFISCAL_Name = 'NFE_NOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_PROCESSADO', ftString, 1)]
    [Dictionary('NFE_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_PROCESSADO: String read FNFE_PROCESSADO write FNFE_PROCESSADO;
    const NFE_PROCESSADO_Name = 'NFE_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('NFE_LIVROFISCAL', ftString, 1)]
    [Dictionary('NFE_LIVROFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_LIVROFISCAL: String read FNFE_LIVROFISCAL write FNFE_LIVROFISCAL;
    const NFE_LIVROFISCAL_Name = 'NFE_LIVROFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_CANCELADA', ftString, 1)]
    [Dictionary('NFE_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_CANCELADA: String read FNFE_CANCELADA write FNFE_CANCELADA;
    const NFE_CANCELADA_Name = 'NFE_CANCELADA';

    [Restrictions([NoValidate])]
    [Column('NTO_CODIGO', ftInteger)]
    [Dictionary('NTO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NTO_CODIGO: Integer read FNTO_CODIGO write FNTO_CODIGO;
    const NTO_CODIGO_Name = 'NTO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NTO_DESCRICAO', ftString, 50)]
    [Dictionary('NTO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_DESCRICAO: String read FNTO_DESCRICAO write FNTO_DESCRICAO;
    const NTO_DESCRICAO_Name = 'NTO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('NTO_NAOGERARLIVROFISCAL', ftString, 1)]
    [Dictionary('NTO_NAOGERARLIVROFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NTO_NAOGERARLIVROFISCAL: String read FNTO_NAOGERARLIVROFISCAL write FNTO_NAOGERARLIVROFISCAL;
    const NTO_NAOGERARLIVROFISCAL_Name = 'NTO_NAOGERARLIVROFISCAL';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_NFE)

end.
