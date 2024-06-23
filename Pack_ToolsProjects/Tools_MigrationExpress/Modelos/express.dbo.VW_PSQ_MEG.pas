unit express.dbo.VW_PSQ_MEG;

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
  [Table('VW_PSQ_MEG', '')]
  TDtoVW_PSQ_MEG = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FMEG_ID: Integer;
    FNFE_ID: Integer;
    FNFE_SIGLA: String;
    FNFE_NOTAFISCAL: String;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FMEG_DATALANCAMENTO: TDateTime;
    FMEG_PROCESSADO: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_MEG';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MEG_ID', ftInteger)]
    [Dictionary('MEG_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MEG_ID: Integer read FMEG_ID write FMEG_ID;
    const MEG_ID_Name = 'MEG_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_ID', ftInteger)]
    [Dictionary('NFE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_ID: Integer read FNFE_ID write FNFE_ID;
    const NFE_ID_Name = 'NFE_ID';

    [Restrictions([NoValidate])]
    [Column('NFE_SIGLA', ftString, 3)]
    [Dictionary('NFE_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_SIGLA: String read FNFE_SIGLA write FNFE_SIGLA;
    const NFE_SIGLA_Name = 'NFE_SIGLA';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_NOTAFISCAL', ftString, 9)]
    [Dictionary('NFE_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_NOTAFISCAL: String read FNFE_NOTAFISCAL write FNFE_NOTAFISCAL;
    const NFE_NOTAFISCAL_Name = 'NFE_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate, NotNull])]
    [Column('MEG_DATALANCAMENTO', ftDateTime)]
    [Dictionary('MEG_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MEG_DATALANCAMENTO: TDateTime read FMEG_DATALANCAMENTO write FMEG_DATALANCAMENTO;
    const MEG_DATALANCAMENTO_Name = 'MEG_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MEG_PROCESSADO', ftString, 1)]
    [Dictionary('MEG_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MEG_PROCESSADO: String read FMEG_PROCESSADO write FMEG_PROCESSADO;
    const MEG_PROCESSADO_Name = 'MEG_PROCESSADO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_MEG)

end.
