unit express.dbo.MEG_SELECIONANOTAFISCAL;

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
  [Table('MEG_SelecionaNotaFiscal', '')]
  TDtoMEG_SelecionaNotaFiscal = class
  private
    { Private declarations } 
    FNFE_TIPOMOVTO: String;
    FNFE_SIGLA: String;
    FNFE_ID: Integer;
    FCOM_CODIGO: Integer;
    FNFE_DATAENTRADA: TDateTime;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FNFE_SERIE: String;
    FMNF_CODIGO: String;
    FNFE_NOTAFISCAL: String;
    FNFE_TOTALPRODUTOS: Double;
    FNFE_TOTALNOTAFISCAL: Double;
  public 
    { Public declarations } 
     const Table      = 'MEG_SelecionaNotaFiscal';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TIPOMOVTO', ftString, 25)]
    [Dictionary('NFE_TIPOMOVTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_TIPOMOVTO: String read FNFE_TIPOMOVTO write FNFE_TIPOMOVTO;
    const NFE_TIPOMOVTO_Name = 'NFE_TIPOMOVTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_SIGLA', ftString, 3)]
    [Dictionary('NFE_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_SIGLA: String read FNFE_SIGLA write FNFE_SIGLA;
    const NFE_SIGLA_Name = 'NFE_SIGLA';

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

    [Restrictions([NoValidate])]
    [Column('NFE_SERIE', ftString, 3)]
    [Dictionary('NFE_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_SERIE: String read FNFE_SERIE write FNFE_SERIE;
    const NFE_SERIE_Name = 'NFE_SERIE';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NFE_NOTAFISCAL', ftString, 9)]
    [Dictionary('NFE_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_NOTAFISCAL: String read FNFE_NOTAFISCAL write FNFE_NOTAFISCAL;
    const NFE_NOTAFISCAL_Name = 'NFE_NOTAFISCAL';

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
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoMEG_SelecionaNotaFiscal)

end.
