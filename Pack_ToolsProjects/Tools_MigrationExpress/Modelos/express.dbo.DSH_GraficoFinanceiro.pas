unit express.dbo.DSH_GRAFICOFINANCEIRO;

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
  [Table('DSH_GraficoFinanceiro', '')]
  TDtoDSH_GraficoFinanceiro = class
  private
    { Private declarations } 
    FFIN_TIPODC: String;
    FFIN_STATUS: String;
    FCOM_CODIGO: Integer;
    FFIN_COMPETENCIA: String;
    FFIN_DATAEMISSAO: TDateTime;
    FFIN_DATAVENCIMENTO: TDateTime;
    FFIN_TOTALVALOR: Double;
  public 
    { Public declarations } 
     const Table      = 'DSH_GraficoFinanceiro';

    [Restrictions([NoValidate])]
    [Column('FIN_TIPODC', ftString, 1)]
    [Dictionary('FIN_TIPODC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FIN_TIPODC: String read FFIN_TIPODC write FFIN_TIPODC;
    const FIN_TIPODC_Name = 'FIN_TIPODC';

    [Restrictions([NoValidate])]
    [Column('FIN_STATUS', ftString, 1)]
    [Dictionary('FIN_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FIN_STATUS: String read FFIN_STATUS write FFIN_STATUS;
    const FIN_STATUS_Name = 'FIN_STATUS';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FIN_COMPETENCIA', ftString, 6)]
    [Dictionary('FIN_COMPETENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FIN_COMPETENCIA: String read FFIN_COMPETENCIA write FFIN_COMPETENCIA;
    const FIN_COMPETENCIA_Name = 'FIN_COMPETENCIA';

    [Restrictions([NoValidate])]
    [Column('FIN_DATAEMISSAO', ftDateTime)]
    [Dictionary('FIN_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property FIN_DATAEMISSAO: TDateTime read FFIN_DATAEMISSAO write FFIN_DATAEMISSAO;
    const FIN_DATAEMISSAO_Name = 'FIN_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('FIN_DATAVENCIMENTO', ftDateTime)]
    [Dictionary('FIN_DATAVENCIMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property FIN_DATAVENCIMENTO: TDateTime read FFIN_DATAVENCIMENTO write FFIN_DATAVENCIMENTO;
    const FIN_DATAVENCIMENTO_Name = 'FIN_DATAVENCIMENTO';

    [Restrictions([NoValidate])]
    [Column('FIN_TOTALVALOR', ftBCD)]
    [Dictionary('FIN_TOTALVALOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FIN_TOTALVALOR: Double read FFIN_TOTALVALOR write FFIN_TOTALVALOR;
    const FIN_TOTALVALOR_Name = 'FIN_TOTALVALOR';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoDSH_GraficoFinanceiro)

end.
