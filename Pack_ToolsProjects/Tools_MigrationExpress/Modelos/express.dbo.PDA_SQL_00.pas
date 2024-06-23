unit express.dbo.PDA_SQL_00;

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
  [Table('PDA_SQL_00', '')]
  TDtoPDA_SQL_00 = class
  private
    { Private declarations } 
    FPDA_ID: Integer;
    FCGA_ID: Integer;
    FCOM_CODIGO: Integer;
    FPDA_NUMERODOCTO: String;
    FPDA_TIPODOCUMENTO: String;
    FPES_CODIGO: Integer;
    FPDA_DESATIVADO: String;
    FPDA_FATURADO: String;
    FPDA_CANCELADA: String;
    FPDA_DATALANCAMENTO: TDateTime;
    FPDA_TOTALLIQUIDO: Double;
    FPES_NOME: String;
    FCID_IBGE: String;
    FPES_CIDADE: String;
    FPES_BAIRRO: String;
    FCGA_LACRADA: String;
    FVND_CODIGO: Integer;
    FVND_NOME: String;
  public 
    { Public declarations } 
     const Table      = 'PDA_SQL_00';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_ID', ftInteger)]
    [Dictionary('PDA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDA_ID: Integer read FPDA_ID write FPDA_ID;
    const PDA_ID_Name = 'PDA_ID';

    [Restrictions([NoValidate])]
    [Column('CGA_ID', ftInteger)]
    [Dictionary('CGA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CGA_ID: Integer read FCGA_ID write FCGA_ID;
    const CGA_ID_Name = 'CGA_ID';

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
    [Column('PDA_TIPODOCUMENTO', ftString, 3)]
    [Dictionary('PDA_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_TIPODOCUMENTO: String read FPDA_TIPODOCUMENTO write FPDA_TIPODOCUMENTO;
    const PDA_TIPODOCUMENTO_Name = 'PDA_TIPODOCUMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_DESATIVADO', ftString, 1)]
    [Dictionary('PDA_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_DESATIVADO: String read FPDA_DESATIVADO write FPDA_DESATIVADO;
    const PDA_DESATIVADO_Name = 'PDA_DESATIVADO';

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
    [Column('PDA_DATALANCAMENTO', ftDateTime)]
    [Dictionary('PDA_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PDA_DATALANCAMENTO: TDateTime read FPDA_DATALANCAMENTO write FPDA_DATALANCAMENTO;
    const PDA_DATALANCAMENTO_Name = 'PDA_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_TOTALLIQUIDO', ftBCD, 48, 2)]
    [Dictionary('PDA_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALLIQUIDO: Double read FPDA_TOTALLIQUIDO write FPDA_TOTALLIQUIDO;
    const PDA_TOTALLIQUIDO_Name = 'PDA_TOTALLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

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
    [Column('PES_BAIRRO', ftString, 50)]
    [Dictionary('PES_BAIRRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_BAIRRO: String read FPES_BAIRRO write FPES_BAIRRO;
    const PES_BAIRRO_Name = 'PES_BAIRRO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CGA_LACRADA', ftString, 1)]
    [Dictionary('CGA_LACRADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CGA_LACRADA: String read FCGA_LACRADA write FCGA_LACRADA;
    const CGA_LACRADA_Name = 'CGA_LACRADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VND_NOME', ftString, 100)]
    [Dictionary('VND_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VND_NOME: String read FVND_NOME write FVND_NOME;
    const VND_NOME_Name = 'VND_NOME';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPDA_SQL_00)

end.
