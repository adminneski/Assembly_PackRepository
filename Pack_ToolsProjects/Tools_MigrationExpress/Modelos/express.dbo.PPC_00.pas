unit express.dbo.PPC_00;

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
  [Table('PPC_00', '')]
  [PrimaryKey('PPC_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PPC_ID')]
  TDtoPPC_00 = class
  private
    { Private declarations } 
    FPPC_ID: Integer;
    FCOM_CODIGO: Integer;
    FNLP_CODIGO: Integer;
    FPPC_NUMERODOCTO: String;
    FPPC_DATALANCAMENTO: TDateTime;
    FPPC_DATAINICIAL: TDateTime;
    FPPC_DATAFINAL: TDateTime;
    FPPC_TOTALPERDAPRODUCAO: Double;
    FPPC_TOTALQTDPERDAPRODUCAO: Double;
    FPPC_OBSERVACAO: String;
    FPPC_PROCESSADO: String;
    FPPC_DATAALTERACAO: TDateTime;
    FPPC_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'PPC_00';
     const PrimaryKey = 'PPC_ID';
     const Sequence   = 'SEQ_PPC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PPC_ID', ftInteger)]
    [Dictionary('PPC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PPC_ID: Integer read FPPC_ID write FPPC_ID;
    const PPC_ID_Name = 'PPC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NLP_CODIGO', ftInteger)]
    [Dictionary('NLP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NLP_CODIGO: Integer read FNLP_CODIGO write FNLP_CODIGO;
    const NLP_CODIGO_Name = 'NLP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PPC_NUMERODOCTO', ftString, 15)]
    [Dictionary('PPC_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PPC_NUMERODOCTO: String read FPPC_NUMERODOCTO write FPPC_NUMERODOCTO;
    const PPC_NUMERODOCTO_Name = 'PPC_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('PPC_DATALANCAMENTO', ftDateTime)]
    [Dictionary('PPC_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property PPC_DATALANCAMENTO: TDateTime read FPPC_DATALANCAMENTO write FPPC_DATALANCAMENTO;
    const PPC_DATALANCAMENTO_Name = 'PPC_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('PPC_DATAINICIAL', ftDateTime)]
    [Dictionary('PPC_DATAINICIAL', 'Mensagem de validação', '', '', '', taCenter)]
    property PPC_DATAINICIAL: TDateTime read FPPC_DATAINICIAL write FPPC_DATAINICIAL;
    const PPC_DATAINICIAL_Name = 'PPC_DATAINICIAL';

    [Restrictions([NoValidate])]
    [Column('PPC_DATAFINAL', ftDateTime)]
    [Dictionary('PPC_DATAFINAL', 'Mensagem de validação', '', '', '', taCenter)]
    property PPC_DATAFINAL: TDateTime read FPPC_DATAFINAL write FPPC_DATAFINAL;
    const PPC_DATAFINAL_Name = 'PPC_DATAFINAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('PPC_TOTALPERDAPRODUCAO', ftBCD, 1952531540, 2)]
    [Dictionary('PPC_TOTALPERDAPRODUCAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PPC_TOTALPERDAPRODUCAO: Double read FPPC_TOTALPERDAPRODUCAO write FPPC_TOTALPERDAPRODUCAO;
    const PPC_TOTALPERDAPRODUCAO_Name = 'PPC_TOTALPERDAPRODUCAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PPC_TOTALQTDPERDAPRODUCAO', ftBCD, 2097273, 2)]
    [Dictionary('PPC_TOTALQTDPERDAPRODUCAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PPC_TOTALQTDPERDAPRODUCAO: Double read FPPC_TOTALQTDPERDAPRODUCAO write FPPC_TOTALQTDPERDAPRODUCAO;
    const PPC_TOTALQTDPERDAPRODUCAO_Name = 'PPC_TOTALQTDPERDAPRODUCAO';

    [Restrictions([NoValidate])]
    [Column('PPC_OBSERVACAO', ftString, 300)]
    [Dictionary('PPC_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PPC_OBSERVACAO: String read FPPC_OBSERVACAO write FPPC_OBSERVACAO;
    const PPC_OBSERVACAO_Name = 'PPC_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('PPC_PROCESSADO', ftString, 1)]
    [Dictionary('PPC_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PPC_PROCESSADO: String read FPPC_PROCESSADO write FPPC_PROCESSADO;
    const PPC_PROCESSADO_Name = 'PPC_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('PPC_DATAALTERACAO', ftDateTime)]
    [Dictionary('PPC_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property PPC_DATAALTERACAO: TDateTime read FPPC_DATAALTERACAO write FPPC_DATAALTERACAO;
    const PPC_DATAALTERACAO_Name = 'PPC_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('PPC_ID_OLD', ftInteger)]
    [Dictionary('PPC_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PPC_ID_OLD: Integer read FPPC_ID_OLD write FPPC_ID_OLD;
    const PPC_ID_OLD_Name = 'PPC_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPPC_00)

end.
