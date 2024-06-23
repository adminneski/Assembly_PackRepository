unit express.dbo.FAT_PARCELAMENTO;

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
  [Table('FAT_Parcelamento', '')]
  TDtoFAT_Parcelamento = class
  private
    { Private declarations } 
    FPAR_TIPO: String;
    FPAR_00_ID: Integer;
    FPAR_ID: Integer;
    FCOM_CODIGO: Integer;
    FFPG_CODIGO: Integer;
    FPAR_NUMEROPARCELA: Integer;
    FPAR_VALORPARCELA: Double;
    FPAR_DATAVENCIMENTO: TDateTime;
    FPAR_DIA: Integer;
    FFPG_DESCRICAO: String;
    FPRZ_CODIGO: Integer;
    FPRZ_DESCRICAO: String;
  public 
    { Public declarations } 
     const Table      = 'FAT_Parcelamento';

    [Restrictions([NoValidate, NotNull])]
    [Column('PAR_TIPO', ftString, 3)]
    [Dictionary('PAR_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PAR_TIPO: String read FPAR_TIPO write FPAR_TIPO;
    const PAR_TIPO_Name = 'PAR_TIPO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PAR_00_ID', ftInteger)]
    [Dictionary('PAR_00_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PAR_00_ID: Integer read FPAR_00_ID write FPAR_00_ID;
    const PAR_00_ID_Name = 'PAR_00_ID';

    [Restrictions([NoValidate])]
    [Column('PAR_ID', ftInteger)]
    [Dictionary('PAR_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PAR_ID: Integer read FPAR_ID write FPAR_ID;
    const PAR_ID_Name = 'PAR_ID';

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
    [Column('PAR_NUMEROPARCELA', ftInteger)]
    [Dictionary('PAR_NUMEROPARCELA', 'Mensagem de validação', '0', '', '', taCenter)]
    property PAR_NUMEROPARCELA: Integer read FPAR_NUMEROPARCELA write FPAR_NUMEROPARCELA;
    const PAR_NUMEROPARCELA_Name = 'PAR_NUMEROPARCELA';

    [Restrictions([NoValidate])]
    [Column('PAR_VALORPARCELA', ftBCD)]
    [Dictionary('PAR_VALORPARCELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PAR_VALORPARCELA: Double read FPAR_VALORPARCELA write FPAR_VALORPARCELA;
    const PAR_VALORPARCELA_Name = 'PAR_VALORPARCELA';

    [Restrictions([NoValidate])]
    [Column('PAR_DATAVENCIMENTO', ftDateTime)]
    [Dictionary('PAR_DATAVENCIMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property PAR_DATAVENCIMENTO: TDateTime read FPAR_DATAVENCIMENTO write FPAR_DATAVENCIMENTO;
    const PAR_DATAVENCIMENTO_Name = 'PAR_DATAVENCIMENTO';

    [Restrictions([NoValidate])]
    [Column('PAR_DIA', ftInteger)]
    [Dictionary('PAR_DIA', 'Mensagem de validação', '0', '', '', taCenter)]
    property PAR_DIA: Integer read FPAR_DIA write FPAR_DIA;
    const PAR_DIA_Name = 'PAR_DIA';

    [Restrictions([NoValidate])]
    [Column('FPG_DESCRICAO', ftString, 30)]
    [Dictionary('FPG_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FPG_DESCRICAO: String read FFPG_DESCRICAO write FFPG_DESCRICAO;
    const FPG_DESCRICAO_Name = 'FPG_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('PRZ_CODIGO', ftInteger)]
    [Dictionary('PRZ_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRZ_CODIGO: Integer read FPRZ_CODIGO write FPRZ_CODIGO;
    const PRZ_CODIGO_Name = 'PRZ_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRZ_DESCRICAO', ftString, 30)]
    [Dictionary('PRZ_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRZ_DESCRICAO: String read FPRZ_DESCRICAO write FPRZ_DESCRICAO;
    const PRZ_DESCRICAO_Name = 'PRZ_DESCRICAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoFAT_Parcelamento)

end.
