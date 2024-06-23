unit express.dbo.OMF_00_07;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.omf_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('OMF_00_07', '')]
  [PrimaryKey('OMF_ID', AutoInc, NoSort, False, 'Chave prim�ria')]
  [Sequence('SEQ_OMF_ID')]
  TDtoOMF_00_07 = class
  private
    { Private declarations } 
    FOMF_ID: Integer;
    FCOM_CODIGO: Integer;
    FOMF_TIPOMERCADORIA: String;
    FPRI_CODIGO: Integer;
    FOMF_NIVELCONTA: String;
    FOMF_TIPOCONTA: String;
    FOMF_CODIGOCONTA: String;
    FOMF_NOMECONTA: String;
    FOMF_TOTALNUMEROPARCELAS: Integer;
    FOMF_CODIGONATUREZACONTA: String;
    FOMF_CODIGOCENTROCUSTO: String;
    FOMF_NOMECENTROCUSTO: String;
    FOMF_TIPOEMITENTE: String;
    FOMF_DATAALTERACAO: TDateTime;
    FOMF_INTEGRACAOERP: String;
    FOMF_ID_OLD: Integer;

    FOMF_00_0:  TOMF_00  ;
  public 
    { Public declarations } 
    constructor Create;
    destructor Destroy; override;

     const Table      = 'OMF_00_07';
     const PrimaryKey = 'OMF_ID';
     const Sequence   = 'SEQ_OMF_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('OMF_ID', ftInteger)]
    [ForeignKey('OMF_00_07_fk', 'OMF_ID', 'OMF_00', 'OMF_ID', SetNull, SetNull)]
    [Dictionary('OMF_ID', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property OMF_ID: Integer read FOMF_ID write FOMF_ID;
    const OMF_ID_Name = 'OMF_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('OMF_TIPOMERCADORIA', ftString, 1)]
    [Dictionary('OMF_TIPOMERCADORIA', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property OMF_TIPOMERCADORIA: String read FOMF_TIPOMERCADORIA write FOMF_TIPOMERCADORIA;
    const OMF_TIPOMERCADORIA_Name = 'OMF_TIPOMERCADORIA';

    [Restrictions([NoValidate])]
    [Column('PRI_CODIGO', ftInteger)]
    [Dictionary('PRI_CODIGO', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property PRI_CODIGO: Integer read FPRI_CODIGO write FPRI_CODIGO;
    const PRI_CODIGO_Name = 'PRI_CODIGO';

    [Restrictions([NoValidate])]
    [Column('OMF_NIVELCONTA', ftString, 1)]
    [Dictionary('OMF_NIVELCONTA', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property OMF_NIVELCONTA: String read FOMF_NIVELCONTA write FOMF_NIVELCONTA;
    const OMF_NIVELCONTA_Name = 'OMF_NIVELCONTA';

    [Restrictions([NoValidate])]
    [Column('OMF_TIPOCONTA', ftString, 1)]
    [Dictionary('OMF_TIPOCONTA', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property OMF_TIPOCONTA: String read FOMF_TIPOCONTA write FOMF_TIPOCONTA;
    const OMF_TIPOCONTA_Name = 'OMF_TIPOCONTA';

    [Restrictions([NoValidate])]
    [Column('OMF_CODIGOCONTA', ftString, 60)]
    [Dictionary('OMF_CODIGOCONTA', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property OMF_CODIGOCONTA: String read FOMF_CODIGOCONTA write FOMF_CODIGOCONTA;
    const OMF_CODIGOCONTA_Name = 'OMF_CODIGOCONTA';

    [Restrictions([NoValidate])]
    [Column('OMF_NOMECONTA', ftString, 60)]
    [Dictionary('OMF_NOMECONTA', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property OMF_NOMECONTA: String read FOMF_NOMECONTA write FOMF_NOMECONTA;
    const OMF_NOMECONTA_Name = 'OMF_NOMECONTA';

    [Restrictions([NoValidate])]
    [Column('OMF_TOTALNUMEROPARCELAS', ftInteger)]
    [Dictionary('OMF_TOTALNUMEROPARCELAS', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property OMF_TOTALNUMEROPARCELAS: Integer read FOMF_TOTALNUMEROPARCELAS write FOMF_TOTALNUMEROPARCELAS;
    const OMF_TOTALNUMEROPARCELAS_Name = 'OMF_TOTALNUMEROPARCELAS';

    [Restrictions([NoValidate])]
    [Column('OMF_CODIGONATUREZACONTA', ftString, 2)]
    [Dictionary('OMF_CODIGONATUREZACONTA', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property OMF_CODIGONATUREZACONTA: String read FOMF_CODIGONATUREZACONTA write FOMF_CODIGONATUREZACONTA;
    const OMF_CODIGONATUREZACONTA_Name = 'OMF_CODIGONATUREZACONTA';

    [Restrictions([NoValidate])]
    [Column('OMF_CODIGOCENTROCUSTO', ftString, 60)]
    [Dictionary('OMF_CODIGOCENTROCUSTO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property OMF_CODIGOCENTROCUSTO: String read FOMF_CODIGOCENTROCUSTO write FOMF_CODIGOCENTROCUSTO;
    const OMF_CODIGOCENTROCUSTO_Name = 'OMF_CODIGOCENTROCUSTO';

    [Restrictions([NoValidate])]
    [Column('OMF_NOMECENTROCUSTO', ftString, 60)]
    [Dictionary('OMF_NOMECENTROCUSTO', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property OMF_NOMECENTROCUSTO: String read FOMF_NOMECENTROCUSTO write FOMF_NOMECENTROCUSTO;
    const OMF_NOMECENTROCUSTO_Name = 'OMF_NOMECENTROCUSTO';

    [Restrictions([NoValidate])]
    [Column('OMF_TIPOEMITENTE', ftString, 1)]
    [Dictionary('OMF_TIPOEMITENTE', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property OMF_TIPOEMITENTE: String read FOMF_TIPOEMITENTE write FOMF_TIPOEMITENTE;
    const OMF_TIPOEMITENTE_Name = 'OMF_TIPOEMITENTE';

    [Restrictions([NoValidate])]
    [Column('OMF_DATAALTERACAO', ftDateTime)]
    [Dictionary('OMF_DATAALTERACAO', 'Mensagem de valida��o', '', '', '', taCenter)]
    property OMF_DATAALTERACAO: TDateTime read FOMF_DATAALTERACAO write FOMF_DATAALTERACAO;
    const OMF_DATAALTERACAO_Name = 'OMF_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('OMF_INTEGRACAOERP', ftString, 20)]
    [Dictionary('OMF_INTEGRACAOERP', 'Mensagem de valida��o', '', '', '', taLeftJustify)]
    property OMF_INTEGRACAOERP: String read FOMF_INTEGRACAOERP write FOMF_INTEGRACAOERP;
    const OMF_INTEGRACAOERP_Name = 'OMF_INTEGRACAOERP';

    [Restrictions([NoValidate])]
    [Column('OMF_ID_OLD', ftInteger)]
    [Dictionary('OMF_ID_OLD', 'Mensagem de valida��o', '0', '', '', taCenter)]
    property OMF_ID_OLD: Integer read FOMF_ID_OLD write FOMF_ID_OLD;
    const OMF_ID_OLD_Name = 'OMF_ID_OLD';

    [Association(OneToOne,'OMF_ID','OMF_00','OMF_ID')]
    property OMF_00: TOMF_00 read FOMF_00_0 write FOMF_00_0;

  end;

implementation

constructor TOMF_00_07.Create;
begin
  FOMF_00_0 := TOMF_00.Create;
end;

destructor TOMF_00_07.Destroy;
begin
  if Assigned(FOMF_00_0) then
    FOMF_00_0.Free;

  inherited;
end;

initialization
  TRegisterClass.RegisterEntity(TDtoOMF_00_07)

end.
