unit express.dbo.PDC_00;

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
  [Table('PDC_00', '')]
  [PrimaryKey('PDC_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PDC_ID')]
  TDtoPDC_00 = class
  private
    { Private declarations } 
    FPDC_ID: Integer;
    FCOM_CODIGO: Integer;
    FFSP_CODIGO: Integer;
    FNLP_CODIGO: Integer;
    FPDC_TIPODOCUMENTO: String;
    FPDC_NUMERODOCTO: String;
    FPDC_DATALANCAMENTO: TDateTime;
    FPDC_DATAINICIAL: TDateTime;
    FPDC_DATAFINAL: TDateTime;
    FPDC_QTDHORAS: Double;
    FPDC_TOTALPESOLIQUIDO: Double;
    FPDC_TOTALQTDPRODUCAO: Double;
    FPDC_TOTALMATERIAPRIMA: Double;
    FPDC_TOTALPRODUTOFINAL: Double;
    FPDC_TOTALGASTOSGERAIS: Double;
    FPDC_TOTALMATERIALAUXILIAR: Double;
    FPDC_TOTALMATERIALSECUNDARIO: Double;
    FPDC_OBSERVACAO: String;
    FPDC_PROCESSADO: String;
    FPDC_DATAALTERACAO: TDateTime;
    FPDC_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'PDC_00';
     const PrimaryKey = 'PDC_ID';
     const Sequence   = 'SEQ_PDC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDC_ID', ftInteger)]
    [Dictionary('PDC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDC_ID: Integer read FPDC_ID write FPDC_ID;
    const PDC_ID_Name = 'PDC_ID';

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
    [Column('PDC_TIPODOCUMENTO', ftString, 1)]
    [Dictionary('PDC_TIPODOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDC_TIPODOCUMENTO: String read FPDC_TIPODOCUMENTO write FPDC_TIPODOCUMENTO;
    const PDC_TIPODOCUMENTO_Name = 'PDC_TIPODOCUMENTO';

    [Restrictions([NoValidate])]
    [Column('PDC_NUMERODOCTO', ftString, 15)]
    [Dictionary('PDC_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDC_NUMERODOCTO: String read FPDC_NUMERODOCTO write FPDC_NUMERODOCTO;
    const PDC_NUMERODOCTO_Name = 'PDC_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('PDC_DATALANCAMENTO', ftDateTime)]
    [Dictionary('PDC_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property PDC_DATALANCAMENTO: TDateTime read FPDC_DATALANCAMENTO write FPDC_DATALANCAMENTO;
    const PDC_DATALANCAMENTO_Name = 'PDC_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('PDC_DATAINICIAL', ftDateTime)]
    [Dictionary('PDC_DATAINICIAL', 'Mensagem de validação', '', '', '', taCenter)]
    property PDC_DATAINICIAL: TDateTime read FPDC_DATAINICIAL write FPDC_DATAINICIAL;
    const PDC_DATAINICIAL_Name = 'PDC_DATAINICIAL';

    [Restrictions([NoValidate])]
    [Column('PDC_DATAFINAL', ftDateTime)]
    [Dictionary('PDC_DATAFINAL', 'Mensagem de validação', '', '', '', taCenter)]
    property PDC_DATAFINAL: TDateTime read FPDC_DATAFINAL write FPDC_DATAFINAL;
    const PDC_DATAFINAL_Name = 'PDC_DATAFINAL';

    [Restrictions([NoValidate])]
    [Column('PDC_QTDHORAS', ftBCD, 539780974, 2)]
    [Dictionary('PDC_QTDHORAS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDC_QTDHORAS: Double read FPDC_QTDHORAS write FPDC_QTDHORAS;
    const PDC_QTDHORAS_Name = 'PDC_QTDHORAS';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDC_TOTALPESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('PDC_TOTALPESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDC_TOTALPESOLIQUIDO: Double read FPDC_TOTALPESOLIQUIDO write FPDC_TOTALPESOLIQUIDO;
    const PDC_TOTALPESOLIQUIDO_Name = 'PDC_TOTALPESOLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDC_TOTALQTDPRODUCAO', ftBCD, 1981834596, 3)]
    [Dictionary('PDC_TOTALQTDPRODUCAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDC_TOTALQTDPRODUCAO: Double read FPDC_TOTALQTDPRODUCAO write FPDC_TOTALQTDPRODUCAO;
    const PDC_TOTALQTDPRODUCAO_Name = 'PDC_TOTALQTDPRODUCAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDC_TOTALMATERIAPRIMA', ftBCD, 18, 4)]
    [Dictionary('PDC_TOTALMATERIAPRIMA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDC_TOTALMATERIAPRIMA: Double read FPDC_TOTALMATERIAPRIMA write FPDC_TOTALMATERIAPRIMA;
    const PDC_TOTALMATERIAPRIMA_Name = 'PDC_TOTALMATERIAPRIMA';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDC_TOTALPRODUTOFINAL', ftBCD, 18, 4)]
    [Dictionary('PDC_TOTALPRODUTOFINAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDC_TOTALPRODUTOFINAL: Double read FPDC_TOTALPRODUTOFINAL write FPDC_TOTALPRODUTOFINAL;
    const PDC_TOTALPRODUTOFINAL_Name = 'PDC_TOTALPRODUTOFINAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDC_TOTALGASTOSGERAIS', ftBCD, 18, 4)]
    [Dictionary('PDC_TOTALGASTOSGERAIS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDC_TOTALGASTOSGERAIS: Double read FPDC_TOTALGASTOSGERAIS write FPDC_TOTALGASTOSGERAIS;
    const PDC_TOTALGASTOSGERAIS_Name = 'PDC_TOTALGASTOSGERAIS';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDC_TOTALMATERIALAUXILIAR', ftBCD, 18, 4)]
    [Dictionary('PDC_TOTALMATERIALAUXILIAR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDC_TOTALMATERIALAUXILIAR: Double read FPDC_TOTALMATERIALAUXILIAR write FPDC_TOTALMATERIALAUXILIAR;
    const PDC_TOTALMATERIALAUXILIAR_Name = 'PDC_TOTALMATERIALAUXILIAR';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDC_TOTALMATERIALSECUNDARIO', ftBCD, 18, 4)]
    [Dictionary('PDC_TOTALMATERIALSECUNDARIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDC_TOTALMATERIALSECUNDARIO: Double read FPDC_TOTALMATERIALSECUNDARIO write FPDC_TOTALMATERIALSECUNDARIO;
    const PDC_TOTALMATERIALSECUNDARIO_Name = 'PDC_TOTALMATERIALSECUNDARIO';

    [Restrictions([NoValidate])]
    [Column('PDC_OBSERVACAO', ftString, 300)]
    [Dictionary('PDC_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDC_OBSERVACAO: String read FPDC_OBSERVACAO write FPDC_OBSERVACAO;
    const PDC_OBSERVACAO_Name = 'PDC_OBSERVACAO';

    [Restrictions([NoValidate])]
    [Column('PDC_PROCESSADO', ftString, 1)]
    [Dictionary('PDC_PROCESSADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PDC_PROCESSADO: String read FPDC_PROCESSADO write FPDC_PROCESSADO;
    const PDC_PROCESSADO_Name = 'PDC_PROCESSADO';

    [Restrictions([NoValidate])]
    [Column('PDC_DATAALTERACAO', ftDateTime)]
    [Dictionary('PDC_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property PDC_DATAALTERACAO: TDateTime read FPDC_DATAALTERACAO write FPDC_DATAALTERACAO;
    const PDC_DATAALTERACAO_Name = 'PDC_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('PDC_ID_OLD', ftInteger)]
    [Dictionary('PDC_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDC_ID_OLD: Integer read FPDC_ID_OLD write FPDC_ID_OLD;
    const PDC_ID_OLD_Name = 'PDC_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPDC_00)

end.
