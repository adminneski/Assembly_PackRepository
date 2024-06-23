unit express.dbo.PDC_00_02;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.pdc_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('PDC_00_02', '')]
  [PrimaryKey('PDC_02_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PDC_02_ID')]
  TDtoPDC_00_02 = class
  private
    { Private declarations } 
    FPDC_02_ID: Integer;
    FCOM_CODIGO: Integer;
    FPDC_ID: Integer;
    FPRO_CODIGO: Integer;
    FPDC_QTDPRODUCAO: Double;
    FPDC_PESOLIQUIDO: Double;
    FPDC_PRECOCUSTO: Double;
    FPDC_VALORMATERIALAUXILIAR: Double;
    FPDC_ULTIMOCUSTOCOMPRA: Double;
    FPDC_ULTIMOCUSTOLIQUIDO: Double;
    FPDC_ULTIMOCUSTOINVENTARIO: Double;
    FPDC_ULTIMOCUSTOCOMPRAMEDIO: Double;
    FPDC_ULTIMOCUSTOLIQUIDOMEDIO: Double;
    FPDC_ULTIMOCUSTOINVENTARIOMEDIO: Double;
    FPDC_DATAALTERACAO: TDateTime;
    FPDC_02_ID_OLD: Integer;
    FPDC_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'PDC_00_02';
    const PrimaryKey = 'PDC_02_ID';
    const Sequence   = 'SEQ_PDC_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDC_02_ID', ftInteger)]
    [Dictionary('PDC_02_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDC_02_ID: Integer read FPDC_02_ID write FPDC_02_ID;
    const PDC_02_ID_Name = 'PDC_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDC_ID', ftInteger)]
    [ForeignKey('PDC_00_02_fk', 'PDC_ID', 'PDC_00', 'PDC_ID', SetNull, SetNull)]
    [Dictionary('PDC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDC_ID: Integer read FPDC_ID write FPDC_ID;
    const PDC_ID_Name = 'PDC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDC_QTDPRODUCAO', ftBCD, 18, 4)]
    [Dictionary('PDC_QTDPRODUCAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDC_QTDPRODUCAO: Double read FPDC_QTDPRODUCAO write FPDC_QTDPRODUCAO;
    const PDC_QTDPRODUCAO_Name = 'PDC_QTDPRODUCAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDC_PESOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('PDC_PESOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDC_PESOLIQUIDO: Double read FPDC_PESOLIQUIDO write FPDC_PESOLIQUIDO;
    const PDC_PESOLIQUIDO_Name = 'PDC_PESOLIQUIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDC_PRECOCUSTO', ftBCD, 18, 4)]
    [Dictionary('PDC_PRECOCUSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDC_PRECOCUSTO: Double read FPDC_PRECOCUSTO write FPDC_PRECOCUSTO;
    const PDC_PRECOCUSTO_Name = 'PDC_PRECOCUSTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDC_VALORMATERIALAUXILIAR', ftBCD, 18, 4)]
    [Dictionary('PDC_VALORMATERIALAUXILIAR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDC_VALORMATERIALAUXILIAR: Double read FPDC_VALORMATERIALAUXILIAR write FPDC_VALORMATERIALAUXILIAR;
    const PDC_VALORMATERIALAUXILIAR_Name = 'PDC_VALORMATERIALAUXILIAR';

    [Restrictions([NoValidate])]
    [Column('PDC_ULTIMOCUSTOCOMPRA', ftBCD, 18, 4)]
    [Dictionary('PDC_ULTIMOCUSTOCOMPRA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDC_ULTIMOCUSTOCOMPRA: Double read FPDC_ULTIMOCUSTOCOMPRA write FPDC_ULTIMOCUSTOCOMPRA;
    const PDC_ULTIMOCUSTOCOMPRA_Name = 'PDC_ULTIMOCUSTOCOMPRA';

    [Restrictions([NoValidate])]
    [Column('PDC_ULTIMOCUSTOLIQUIDO', ftBCD, 18, 4)]
    [Dictionary('PDC_ULTIMOCUSTOLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDC_ULTIMOCUSTOLIQUIDO: Double read FPDC_ULTIMOCUSTOLIQUIDO write FPDC_ULTIMOCUSTOLIQUIDO;
    const PDC_ULTIMOCUSTOLIQUIDO_Name = 'PDC_ULTIMOCUSTOLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('PDC_ULTIMOCUSTOINVENTARIO', ftBCD, 18, 4)]
    [Dictionary('PDC_ULTIMOCUSTOINVENTARIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDC_ULTIMOCUSTOINVENTARIO: Double read FPDC_ULTIMOCUSTOINVENTARIO write FPDC_ULTIMOCUSTOINVENTARIO;
    const PDC_ULTIMOCUSTOINVENTARIO_Name = 'PDC_ULTIMOCUSTOINVENTARIO';

    [Restrictions([NoValidate])]
    [Column('PDC_ULTIMOCUSTOCOMPRAMEDIO', ftBCD, 18, 4)]
    [Dictionary('PDC_ULTIMOCUSTOCOMPRAMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDC_ULTIMOCUSTOCOMPRAMEDIO: Double read FPDC_ULTIMOCUSTOCOMPRAMEDIO write FPDC_ULTIMOCUSTOCOMPRAMEDIO;
    const PDC_ULTIMOCUSTOCOMPRAMEDIO_Name = 'PDC_ULTIMOCUSTOCOMPRAMEDIO';

    [Restrictions([NoValidate])]
    [Column('PDC_ULTIMOCUSTOLIQUIDOMEDIO', ftBCD, 18, 4)]
    [Dictionary('PDC_ULTIMOCUSTOLIQUIDOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDC_ULTIMOCUSTOLIQUIDOMEDIO: Double read FPDC_ULTIMOCUSTOLIQUIDOMEDIO write FPDC_ULTIMOCUSTOLIQUIDOMEDIO;
    const PDC_ULTIMOCUSTOLIQUIDOMEDIO_Name = 'PDC_ULTIMOCUSTOLIQUIDOMEDIO';

    [Restrictions([NoValidate])]
    [Column('PDC_ULTIMOCUSTOINVENTARIOMEDIO', ftBCD, 18, 4)]
    [Dictionary('PDC_ULTIMOCUSTOINVENTARIOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PDC_ULTIMOCUSTOINVENTARIOMEDIO: Double read FPDC_ULTIMOCUSTOINVENTARIOMEDIO write FPDC_ULTIMOCUSTOINVENTARIOMEDIO;
    const PDC_ULTIMOCUSTOINVENTARIOMEDIO_Name = 'PDC_ULTIMOCUSTOINVENTARIOMEDIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PDC_DATAALTERACAO', ftDateTime)]
    [Dictionary('PDC_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PDC_DATAALTERACAO: TDateTime read FPDC_DATAALTERACAO write FPDC_DATAALTERACAO;
    const PDC_DATAALTERACAO_Name = 'PDC_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('PDC_02_ID_OLD', ftInteger)]
    [Dictionary('PDC_02_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDC_02_ID_OLD: Integer read FPDC_02_ID_OLD write FPDC_02_ID_OLD;
    const PDC_02_ID_OLD_Name = 'PDC_02_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('PDC_ID_OLD', ftInteger)]
    [Dictionary('PDC_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property PDC_ID_OLD: Integer read FPDC_ID_OLD write FPDC_ID_OLD;
    const PDC_ID_OLD_Name = 'PDC_ID_OLD';
  end;

implementation


initialization
  TRegisterClass.RegisterEntity(TDtoPDC_00_02)

end.
