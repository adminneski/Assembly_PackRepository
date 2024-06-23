unit express.dbo.REL_V02_PDA;

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
  [Table('REL_V02_PDA', '')]
  TDtoREL_V02_PDA = class
  private
    { Private declarations } 
    FPDA_ID: Integer;
    FCOM_CODIGO: Integer;
    FFPG_CODIGO: Integer;
    FFPG_DESCRICAO: String;
    FPDA_VALORPARCELA: Double;
    FVND_CODIGO: Integer;
    FROT_CODIGO: Integer;
    FSEG_CODIGO: Integer;
    FPDA_DESATIVADO: String;
    FPDA_CANCELADA: String;
    FPDA_INTEGRACAO: String;
    FPDA_DATALANCAMENTO: TDateTime;
    FCGA_FATURADA: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V02_PDA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_ID', ftInteger)]
    [Dictionary('PDA_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDA_ID: Integer read FPDA_ID write FPDA_ID;
    const PDA_ID_Name = 'PDA_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FPG_DESCRICAO', ftString, 30)]
    [Dictionary('FPG_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FPG_DESCRICAO: String read FFPG_DESCRICAO write FFPG_DESCRICAO;
    const FPG_DESCRICAO_Name = 'FPG_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('PDA_VALORPARCELA', ftBCD)]
    [Dictionary('PDA_VALORPARCELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDA_VALORPARCELA: Double read FPDA_VALORPARCELA write FPDA_VALORPARCELA;
    const PDA_VALORPARCELA_Name = 'PDA_VALORPARCELA';

    [Restrictions([NoValidate, NotNull])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

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

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_DESATIVADO', ftString, 1)]
    [Dictionary('PDA_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_DESATIVADO: String read FPDA_DESATIVADO write FPDA_DESATIVADO;
    const PDA_DESATIVADO_Name = 'PDA_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_CANCELADA', ftString, 1)]
    [Dictionary('PDA_CANCELADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_CANCELADA: String read FPDA_CANCELADA write FPDA_CANCELADA;
    const PDA_CANCELADA_Name = 'PDA_CANCELADA';

    [Restrictions([NoValidate])]
    [Column('PDA_INTEGRACAO', ftString, 20)]
    [Dictionary('PDA_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDA_INTEGRACAO: String read FPDA_INTEGRACAO write FPDA_INTEGRACAO;
    const PDA_INTEGRACAO_Name = 'PDA_INTEGRACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDA_DATALANCAMENTO', ftDateTime)]
    [Dictionary('PDA_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PDA_DATALANCAMENTO: TDateTime read FPDA_DATALANCAMENTO write FPDA_DATALANCAMENTO;
    const PDA_DATALANCAMENTO_Name = 'PDA_DATALANCAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CGA_FATURADA', ftString, 1)]
    [Dictionary('CGA_FATURADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CGA_FATURADA: String read FCGA_FATURADA write FCGA_FATURADA;
    const CGA_FATURADA_Name = 'CGA_FATURADA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V02_PDA)

end.
