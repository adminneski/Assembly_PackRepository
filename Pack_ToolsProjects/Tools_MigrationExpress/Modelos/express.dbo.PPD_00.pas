unit express.dbo.PPD_00;

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
  [Table('PPD_00', '')]
  [PrimaryKey('PPD_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PPD_ID')]
  TDtoPPD_00 = class
  private
    { Private declarations } 
    FPPD_ID: Integer;
    FCOM_CODIGO: Integer;
    FFSP_CODIGO: Integer;
    FNLP_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FPPD_NUMERODOCTO: String;
    FPPD_DATALANCAMENTO: TDateTime;
    FPPD_DATAINICIAL: TDateTime;
    FPPD_DATAFINAL: TDateTime;
    FPPD_QTDHORAS: Double;
    FPPD_TOTALPESOLIQUIDO: Double;
    FPPD_TOTALQTDPRODUCAO: Double;
    FPPD_TOTALPRODUTOFINAL: Double;
    FPPD_TOTALGASTOSGERAIS: Double;
    FPPD_TOTALPRODUTOPRIMARIO: Double;
    FPPD_TOTALPRODUTOEMBALAGEM: Double;
    FPPD_OBSERVACAO: String;
    FPPD_PROCESSADO: String;
    FPPD_DATAALTERACAO: TDateTime;
    FPPD_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'PPD_00';
     const PrimaryKey = 'PPD_ID';
     const Sequence   = 'SEQ_PPD_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PPD_ID', ftInteger)]
    [Dictionary('PPD_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PPD_ID: Integer read FPPD_ID write FPPD_ID;
    const PPD_ID_Name = 'PPD_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FSP_CODIGO', ftInteger)]
    [Dictionary('FSP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FSP_CODIGO: Integer read FFSP_CODIGO write FFSP_CODIGO;
    const FSP_CODIGO_Name = 'FSP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NLP_CODIGO', ftInteger)]
    [Dictionary('NLP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property NLP_CODIGO: Integer read FNLP_CODIGO write FNLP_CODIGO;
    const NLP_CODIGO_Name = 'NLP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PPD_NUMERODOCTO', ftString, 15)]
    [Dictionary('PPD_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PPD_NUMERODOCTO: String read FPPD_NUMERODOCTO write FPPD_NUMERODOCTO;
    const PPD_NUMERODOCTO_Name = 'PPD_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('PPD_DATALANCAMENTO', ftDateTime)]
    [Dictionary('PPD_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property PPD_DATALANCAMENTO: TDateTime read FPPD_DATALANCAMENTO write FPPD_DATALANCAMENTO;
    const PPD_DATALANCAMENTO_Name = 'PPD_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('PPD_DATAINICIAL', ftDateTime)]
    [Dictionary('PPD_DATAINICIAL', 'Mensagem de validação', '', '', '', taCenter)]
    property PPD_DATAINICIAL: TDateTime read FPPD_DATAINICIAL write FPPD_DATAINICIAL;
    const PPD_DATAINICIAL_Name = 'PPD_DATAINICIAL';

    [Restrictions([NoValidate])]
    [Column('PPD_DATAFINAL', ftDateTime)]
    [Dictionary('PPD_DATAFINAL', 'Mensagem de validação', '', '', '', taCenter)]
    property PPD_DATAFINAL: TDateTime read FPPD_DATAFINAL write FPPD_DATAFINAL;
    const PPD_DATAFINAL_Name = 'PPD_DATAFINAL';

    [Restrictions([NoValidate])]
    [Column('PPD_QTDHORAS', ftBCD, 18, 4)]
    [Dictionary('PPD_QTDHORAS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PPD_QTDHORAS: Double read FPPD_QTDHORAS write FPPD_QTDHORAS;
    const PPD_QTDHORAS_Name = 'PPD_QTDHORAS';

    [Restrictions([NoValidate, NotNull])]
    [Column('PPD_TOTALPESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('PPD_TOTALPESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PPD_TOTALPESOLIQUIDO: Double read FPPD_TOTALPESOLIQUIDO write FPPD_TOTALPESOLIQUIDO;
    const PPD_TOTALPESOLIQUIDO_Name = 'PPD_TOTALPESOLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PPD_TOTALQTDPRODUCAO', ftBCD, 539780974, 3)]
    [Dictionary('PPD_TOTALQTDPRODUCAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PPD_TOTALQTDPRODUCAO: Double read FPPD_TOTALQTDPRODUCAO write FPPD_TOTALQTDPRODUCAO;
    const PPD_TOTALQTDPRODUCAO_Name = 'PPD_TOTALQTDPRODUCAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PPD_TOTALPRODUTOFINAL', ftBCD, 18, 4)]
    [Dictionary('PPD_TOTALPRODUTOFINAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PPD_TOTALPRODUTOFINAL: Double read FPPD_TOTALPRODUTOFINAL write FPPD_TOTALPRODUTOFINAL;
    const PPD_TOTALPRODUTOFINAL_Name = 'PPD_TOTALPRODUTOFINAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('PPD_TOTALGASTOSGERAIS', ftBCD, 18, 4)]
    [Dictionary('PPD_TOTALGASTOSGERAIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PPD_TOTALGASTOSGERAIS: Double read FPPD_TOTALGASTOSGERAIS write FPPD_TOTALGASTOSGERAIS;
    const PPD_TOTALGASTOSGERAIS_Name = 'PPD_TOTALGASTOSGERAIS';

    [Restrictions([NoValidate, NotNull])]
    [Column('PPD_TOTALPRODUTOPRIMARIO', ftBCD, 18, 4)]
    [Dictionary('PPD_TOTALPRODUTOPRIMARIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PPD_TOTALPRODUTOPRIMARIO: Double read FPPD_TOTALPRODUTOPRIMARIO write FPPD_TOTALPRODUTOPRIMARIO;
    const PPD_TOTALPRODUTOPRIMARIO_Name = 'PPD_TOTALPRODUTOPRIMARIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PPD_TOTALPRODUTOEMBALAGEM', ftBCD, 18, 4)]
    [Dictionary('PPD_TOTALPRODUTOEMBALAGEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PPD_TOTALPRODUTOEMBALAGEM: Double read FPPD_TOTALPRODUTOEMBALAGEM write FPPD_TOTALPRODUTOEMBALAGEM;
    const PPD_TOTALPRODUTOEMBALAGEM_Name = 'PPD_TOTALPRODUTOEMBALAGEM';

    [Restrictions([NoValidate])]
    [Column('PPD_OBSERVACAO', ftString, 300)]
    [Dictionary('PPD_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PPD_OBSERVACAO: String read FPPD_OBSERVACAO write FPPD_OBSERVACAO;
    const PPD_OBSERVACAO_Name = 'PPD_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('PPD_PROCESSADO', ftString, 1)]
    [Dictionary('PPD_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PPD_PROCESSADO: String read FPPD_PROCESSADO write FPPD_PROCESSADO;
    const PPD_PROCESSADO_Name = 'PPD_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('PPD_DATAALTERACAO', ftDateTime)]
    [Dictionary('PPD_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property PPD_DATAALTERACAO: TDateTime read FPPD_DATAALTERACAO write FPPD_DATAALTERACAO;
    const PPD_DATAALTERACAO_Name = 'PPD_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('PPD_ID_OLD', ftInteger)]
    [Dictionary('PPD_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PPD_ID_OLD: Integer read FPPD_ID_OLD write FPPD_ID_OLD;
    const PPD_ID_OLD_Name = 'PPD_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPPD_00)

end.
