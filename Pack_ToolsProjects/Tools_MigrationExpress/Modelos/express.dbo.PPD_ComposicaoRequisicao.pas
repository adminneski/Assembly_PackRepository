unit express.dbo.PPD_COMPOSICAOREQUISICAO;

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
  [Table('PPD_ComposicaoRequisicao', '')]
  TDtoPPD_ComposicaoRequisicao = class
  private
    { Private declarations } 
    FPPD_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FPPD_QTDCOMPOSICAO: Double;
    FPPD_VALORCUSTOCOMPRA: Double;
    FPPD_VALORCUSTOLIQUIDO: Double;
    FPPD_VALORCUSTOINVENTARIO: Double;
    FPPD_VALORCUSTOCOMPRAMEDIO: Double;
    FPPD_VALORCUSTOLIQUIDOMEDIO: Double;
    FPPD_VALORCUSTOINVENTARIOMEDIO: Double;
    FNLP_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FPPD_NUMERODOCTO: String;
    FPPD_DATALANCAMENTO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'PPD_ComposicaoRequisicao';

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
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PPD_QTDCOMPOSICAO', ftBCD)]
    [Dictionary('PPD_QTDCOMPOSICAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PPD_QTDCOMPOSICAO: Double read FPPD_QTDCOMPOSICAO write FPPD_QTDCOMPOSICAO;
    const PPD_QTDCOMPOSICAO_Name = 'PPD_QTDCOMPOSICAO';

    [Restrictions([NoValidate])]
    [Column('PPD_VALORCUSTOCOMPRA', ftBCD, 18, 4)]
    [Dictionary('PPD_VALORCUSTOCOMPRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PPD_VALORCUSTOCOMPRA: Double read FPPD_VALORCUSTOCOMPRA write FPPD_VALORCUSTOCOMPRA;
    const PPD_VALORCUSTOCOMPRA_Name = 'PPD_VALORCUSTOCOMPRA';

    [Restrictions([NoValidate])]
    [Column('PPD_VALORCUSTOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('PPD_VALORCUSTOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PPD_VALORCUSTOLIQUIDO: Double read FPPD_VALORCUSTOLIQUIDO write FPPD_VALORCUSTOLIQUIDO;
    const PPD_VALORCUSTOLIQUIDO_Name = 'PPD_VALORCUSTOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('PPD_VALORCUSTOINVENTARIO', ftBCD, 18, 4)]
    [Dictionary('PPD_VALORCUSTOINVENTARIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PPD_VALORCUSTOINVENTARIO: Double read FPPD_VALORCUSTOINVENTARIO write FPPD_VALORCUSTOINVENTARIO;
    const PPD_VALORCUSTOINVENTARIO_Name = 'PPD_VALORCUSTOINVENTARIO';

    [Restrictions([NoValidate])]
    [Column('PPD_VALORCUSTOCOMPRAMEDIO', ftBCD, 18, 4)]
    [Dictionary('PPD_VALORCUSTOCOMPRAMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PPD_VALORCUSTOCOMPRAMEDIO: Double read FPPD_VALORCUSTOCOMPRAMEDIO write FPPD_VALORCUSTOCOMPRAMEDIO;
    const PPD_VALORCUSTOCOMPRAMEDIO_Name = 'PPD_VALORCUSTOCOMPRAMEDIO';

    [Restrictions([NoValidate])]
    [Column('PPD_VALORCUSTOLIQUIDOMEDIO', ftBCD, 18, 4)]
    [Dictionary('PPD_VALORCUSTOLIQUIDOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PPD_VALORCUSTOLIQUIDOMEDIO: Double read FPPD_VALORCUSTOLIQUIDOMEDIO write FPPD_VALORCUSTOLIQUIDOMEDIO;
    const PPD_VALORCUSTOLIQUIDOMEDIO_Name = 'PPD_VALORCUSTOLIQUIDOMEDIO';

    [Restrictions([NoValidate])]
    [Column('PPD_VALORCUSTOINVENTARIOMEDIO', ftBCD, 18, 4)]
    [Dictionary('PPD_VALORCUSTOINVENTARIOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PPD_VALORCUSTOINVENTARIOMEDIO: Double read FPPD_VALORCUSTOINVENTARIOMEDIO write FPPD_VALORCUSTOINVENTARIOMEDIO;
    const PPD_VALORCUSTOINVENTARIOMEDIO_Name = 'PPD_VALORCUSTOINVENTARIOMEDIO';

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
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPPD_ComposicaoRequisicao)

end.
