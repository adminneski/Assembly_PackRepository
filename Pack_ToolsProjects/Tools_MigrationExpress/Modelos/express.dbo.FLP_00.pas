unit express.dbo.FLP_00;

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
  [Table('FLP_00', '')]
  [PrimaryKey('FLP_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_FLP_ID')]
  TDtoFLP_00 = class
  private
    { Private declarations } 
    FFLP_ID: Integer;
    FCOM_CODIGO: Integer;
    FFLP_MES_ANO: String;
    FPES_CODIGO: Integer;
    FFLP_TOTALSALARIO: Double;
    FFLP_TOTALCREDITO: Double;
    FFLP_TOTALDEBITO: Double;
    FFLP_TOTALLIQUIDO: Double;
    FFLP_DATAALTERACAO: TDateTime;
    FFLP_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'FLP_00';
     const PrimaryKey = 'FLP_ID';
     const Sequence   = 'SEQ_FLP_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('FLP_ID', ftInteger)]
    [Dictionary('FLP_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property FLP_ID: Integer read FFLP_ID write FFLP_ID;
    const FLP_ID_Name = 'FLP_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FLP_MES_ANO', ftString, 6)]
    [Dictionary('FLP_MES_ANO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property FLP_MES_ANO: String read FFLP_MES_ANO write FFLP_MES_ANO;
    const FLP_MES_ANO_Name = 'FLP_MES_ANO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FLP_TOTALSALARIO', ftBCD)]
    [Dictionary('FLP_TOTALSALARIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FLP_TOTALSALARIO: Double read FFLP_TOTALSALARIO write FFLP_TOTALSALARIO;
    const FLP_TOTALSALARIO_Name = 'FLP_TOTALSALARIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FLP_TOTALCREDITO', ftBCD)]
    [Dictionary('FLP_TOTALCREDITO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FLP_TOTALCREDITO: Double read FFLP_TOTALCREDITO write FFLP_TOTALCREDITO;
    const FLP_TOTALCREDITO_Name = 'FLP_TOTALCREDITO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FLP_TOTALDEBITO', ftBCD)]
    [Dictionary('FLP_TOTALDEBITO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FLP_TOTALDEBITO: Double read FFLP_TOTALDEBITO write FFLP_TOTALDEBITO;
    const FLP_TOTALDEBITO_Name = 'FLP_TOTALDEBITO';

    [Restrictions([NoValidate, NotNull])]
    [Column('FLP_TOTALLIQUIDO', ftBCD)]
    [Dictionary('FLP_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property FLP_TOTALLIQUIDO: Double read FFLP_TOTALLIQUIDO write FFLP_TOTALLIQUIDO;
    const FLP_TOTALLIQUIDO_Name = 'FLP_TOTALLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('FLP_DATAALTERACAO', ftDateTime)]
    [Dictionary('FLP_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property FLP_DATAALTERACAO: TDateTime read FFLP_DATAALTERACAO write FFLP_DATAALTERACAO;
    const FLP_DATAALTERACAO_Name = 'FLP_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('FLP_ID_OLD', ftInteger)]
    [Dictionary('FLP_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property FLP_ID_OLD: Integer read FFLP_ID_OLD write FFLP_ID_OLD;
    const FLP_ID_OLD_Name = 'FLP_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoFLP_00)

end.
