unit express.dbo.PCH_00;

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
  [Table('PCH_00', '')]
  [PrimaryKey('PCH_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PCH_ID')]
  TDtoPCH_00 = class
  private
    { Private declarations } 
    FPCH_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FVND_CODIGO: Integer;
    FPCH_CARENCIA: Integer;
    FPCH_TOTALJUROS: Double;
    FPCH_PROCESSADO: String;
    FPCH_HISTORICO: String;
    FPCH_TOTALCHEQUES: Double;
    FPCH_DATALANCAMENTO: TDateTime;
    FPCH_DATAALTERACAO: TDateTime;
    FPCH_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'PCH_00';
     const PrimaryKey = 'PCH_ID';
     const Sequence   = 'SEQ_PCH_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PCH_ID', ftInteger)]
    [Dictionary('PCH_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PCH_ID: Integer read FPCH_ID write FPCH_ID;
    const PCH_ID_Name = 'PCH_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PCH_CARENCIA', ftInteger)]
    [Dictionary('PCH_CARENCIA', 'Mensagem de validação', '0', '', '', taCenter)]
    property PCH_CARENCIA: Integer read FPCH_CARENCIA write FPCH_CARENCIA;
    const PCH_CARENCIA_Name = 'PCH_CARENCIA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PCH_TOTALJUROS', ftBCD, 7274610, 2)]
    [Dictionary('PCH_TOTALJUROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PCH_TOTALJUROS: Double read FPCH_TOTALJUROS write FPCH_TOTALJUROS;
    const PCH_TOTALJUROS_Name = 'PCH_TOTALJUROS';

    [Restrictions([NoValidate, NotNull])]
    [Column('PCH_PROCESSADO', ftString, 1)]
    [Dictionary('PCH_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PCH_PROCESSADO: String read FPCH_PROCESSADO write FPCH_PROCESSADO;
    const PCH_PROCESSADO_Name = 'PCH_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('PCH_HISTORICO', ftString, 300)]
    [Dictionary('PCH_HISTORICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PCH_HISTORICO: String read FPCH_HISTORICO write FPCH_HISTORICO;
    const PCH_HISTORICO_Name = 'PCH_HISTORICO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PCH_TOTALCHEQUES', ftBCD, 5374017, 2)]
    [Dictionary('PCH_TOTALCHEQUES', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PCH_TOTALCHEQUES: Double read FPCH_TOTALCHEQUES write FPCH_TOTALCHEQUES;
    const PCH_TOTALCHEQUES_Name = 'PCH_TOTALCHEQUES';

    [Restrictions([NoValidate, NotNull])]
    [Column('PCH_DATALANCAMENTO', ftDateTime)]
    [Dictionary('PCH_DATALANCAMENTO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PCH_DATALANCAMENTO: TDateTime read FPCH_DATALANCAMENTO write FPCH_DATALANCAMENTO;
    const PCH_DATALANCAMENTO_Name = 'PCH_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('PCH_DATAALTERACAO', ftDateTime)]
    [Dictionary('PCH_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property PCH_DATAALTERACAO: TDateTime read FPCH_DATAALTERACAO write FPCH_DATAALTERACAO;
    const PCH_DATAALTERACAO_Name = 'PCH_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('PCH_ID_OLD', ftInteger)]
    [Dictionary('PCH_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PCH_ID_OLD: Integer read FPCH_ID_OLD write FPCH_ID_OLD;
    const PCH_ID_OLD_Name = 'PCH_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPCH_00)

end.
