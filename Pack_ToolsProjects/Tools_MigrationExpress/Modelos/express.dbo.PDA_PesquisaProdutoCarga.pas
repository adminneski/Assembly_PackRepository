unit express.dbo.PDA_PESQUISAPRODUTOCARGA;

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
  [Table('PDA_PesquisaProdutoCarga', '')]
  TDtoPDA_PesquisaProdutoCarga = class
  private
    { Private declarations } 
    FPDA_ID: Integer;
    FCGA_ID: Integer;
    FCOM_CODIGO: Integer;
    FPDA_NUMERODOCTO: String;
    FPDA_NUMERODOCTOREPRESENTANTE: String;
    FPES_NOME: String;
    FPDA_DATALANCAMENTO: TDateTime;
    FPDA_TOTALLIQUIDO: Double;
    FPRO_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'PDA_PesquisaProdutoCarga';

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
    [Column('PDA_NUMERODOCTOREPRESENTANTE', ftString, 20)]
    [Dictionary('PDA_NUMERODOCTOREPRESENTANTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_NUMERODOCTOREPRESENTANTE: String read FPDA_NUMERODOCTOREPRESENTANTE write FPDA_NUMERODOCTOREPRESENTANTE;
    const PDA_NUMERODOCTOREPRESENTANTE_Name = 'PDA_NUMERODOCTOREPRESENTANTE';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_DATALANCAMENTO', ftDateTime)]
    [Dictionary('PDA_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PDA_DATALANCAMENTO: TDateTime read FPDA_DATALANCAMENTO write FPDA_DATALANCAMENTO;
    const PDA_DATALANCAMENTO_Name = 'PDA_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_TOTALLIQUIDO', ftBCD)]
    [Dictionary('PDA_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_TOTALLIQUIDO: Double read FPDA_TOTALLIQUIDO write FPDA_TOTALLIQUIDO;
    const PDA_TOTALLIQUIDO_Name = 'PDA_TOTALLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPDA_PesquisaProdutoCarga)

end.
