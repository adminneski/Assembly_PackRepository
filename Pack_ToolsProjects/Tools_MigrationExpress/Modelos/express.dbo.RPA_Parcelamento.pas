unit express.dbo.RPA_PARCELAMENTO;

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
  [Table('RPA_Parcelamento', '')]
  TDtoRPA_Parcelamento = class
  private
    { Private declarations } 
    FPAR_00_ID: Integer;
    FPAR_ID: Integer;
    FCOM_CODIGO: Integer;
    FFPG_CODIGO: Integer;
    FPAR_NUMEROPARCELA: Integer;
    FPAR_VALORPARCELA: Double;
    FPAR_DATAVENCIMENTO: TDateTime;
    FPAR_DIA: Integer;
    FFPG_DESCRICAO: String;
  public 
    { Public declarations } 
     const Table      = 'RPA_Parcelamento';

    [Restrictions([NoValidate, NotNull])]
    [Column('PAR_00_ID', ftInteger)]
    [Dictionary('PAR_00_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PAR_00_ID: Integer read FPAR_00_ID write FPAR_00_ID;
    const PAR_00_ID_Name = 'PAR_00_ID';

    [Restrictions([NoValidate, NotNull])]
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

    [Restrictions([NoValidate, NotNull])]
    [Column('PAR_NUMEROPARCELA', ftInteger)]
    [Dictionary('PAR_NUMEROPARCELA', 'Mensagem de validação', '0', '', '', taCenter)]
    property PAR_NUMEROPARCELA: Integer read FPAR_NUMEROPARCELA write FPAR_NUMEROPARCELA;
    const PAR_NUMEROPARCELA_Name = 'PAR_NUMEROPARCELA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PAR_VALORPARCELA', ftBCD)]
    [Dictionary('PAR_VALORPARCELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PAR_VALORPARCELA: Double read FPAR_VALORPARCELA write FPAR_VALORPARCELA;
    const PAR_VALORPARCELA_Name = 'PAR_VALORPARCELA';

    [Restrictions([NoValidate])]
    [Column('PAR_DATAVENCIMENTO', ftDateTime)]
    [Dictionary('PAR_DATAVENCIMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property PAR_DATAVENCIMENTO: TDateTime read FPAR_DATAVENCIMENTO write FPAR_DATAVENCIMENTO;
    const PAR_DATAVENCIMENTO_Name = 'PAR_DATAVENCIMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PAR_DIA', ftInteger)]
    [Dictionary('PAR_DIA', 'Mensagem de validação', '0', '', '', taCenter)]
    property PAR_DIA: Integer read FPAR_DIA write FPAR_DIA;
    const PAR_DIA_Name = 'PAR_DIA';

    [Restrictions([NoValidate])]
    [Column('FPG_DESCRICAO', ftString, 30)]
    [Dictionary('FPG_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FPG_DESCRICAO: String read FFPG_DESCRICAO write FFPG_DESCRICAO;
    const FPG_DESCRICAO_Name = 'FPG_DESCRICAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoRPA_Parcelamento)

end.
