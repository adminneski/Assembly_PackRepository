unit express.dbo.PPD_00_01_01;

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
  [Table('PPD_00_01_01', '')]
  [PrimaryKey('PPD_01_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PPD_01_01_ID')]
  TDtoPPD_00_01_01 = class
  private
    { Private declarations } 
    FPPD_01_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FPPD_01_ID: Integer;
    FPPD_ID: Integer;
    FPRO_CODIGO: Integer;
    FPRM_CODIGO: Integer;
    FPPD_QTDCOMPOSICAO: Double;
    FPPD_VALORCUSTOCOMPRA: Double;
    FPPD_VALORCUSTOLIQUIDO: Double;
    FPPD_VALORCUSTOINVENTARIO: Double;
    FPPD_VALORCUSTOCOMPRAMEDIO: Double;
    FPPD_VALORCUSTOLIQUIDOMEDIO: Double;
    FPPD_VALORCUSTOINVENTARIOMEDIO: Double;
    FPPD_DATAALTERACAO: TDateTime;
    FPPD_01_01_ID_OLD: Integer;
    FPPD_01_ID_OLD: Integer;
    FPPD_ID_OLD: Integer;
  public 
    { Public declarations } 
     const Table      = 'PPD_00_01_01';
     const PrimaryKey = 'PPD_01_01_ID';
     const Sequence   = 'SEQ_PPD_01_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PPD_01_01_ID', ftInteger)]
    [Dictionary('PPD_01_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PPD_01_01_ID: Integer read FPPD_01_01_ID write FPPD_01_01_ID;
    const PPD_01_01_ID_Name = 'PPD_01_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PPD_01_ID', ftInteger)]
    [Dictionary('PPD_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PPD_01_ID: Integer read FPPD_01_ID write FPPD_01_ID;
    const PPD_01_ID_Name = 'PPD_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PPD_ID', ftInteger)]
    [Dictionary('PPD_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PPD_ID: Integer read FPPD_ID write FPPD_ID;
    const PPD_ID_Name = 'PPD_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRM_CODIGO', ftInteger)]
    [Dictionary('PRM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRM_CODIGO: Integer read FPRM_CODIGO write FPRM_CODIGO;
    const PRM_CODIGO_Name = 'PRM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PPD_QTDCOMPOSICAO', ftBCD, 18, 4)]
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

    [Restrictions([NoValidate, NotNull])]
    [Column('PPD_DATAALTERACAO', ftDateTime)]
    [Dictionary('PPD_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PPD_DATAALTERACAO: TDateTime read FPPD_DATAALTERACAO write FPPD_DATAALTERACAO;
    const PPD_DATAALTERACAO_Name = 'PPD_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('PPD_01_01_ID_OLD', ftInteger)]
    [Dictionary('PPD_01_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PPD_01_01_ID_OLD: Integer read FPPD_01_01_ID_OLD write FPPD_01_01_ID_OLD;
    const PPD_01_01_ID_OLD_Name = 'PPD_01_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('PPD_01_ID_OLD', ftInteger)]
    [Dictionary('PPD_01_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PPD_01_ID_OLD: Integer read FPPD_01_ID_OLD write FPPD_01_ID_OLD;
    const PPD_01_ID_OLD_Name = 'PPD_01_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('PPD_ID_OLD', ftInteger)]
    [Dictionary('PPD_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PPD_ID_OLD: Integer read FPPD_ID_OLD write FPPD_ID_OLD;
    const PPD_ID_OLD_Name = 'PPD_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPPD_00_01_01)

end.
