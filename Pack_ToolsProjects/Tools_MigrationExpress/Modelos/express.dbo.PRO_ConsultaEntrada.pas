unit express.dbo.PRO_CONSULTAENTRADA;

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
  [Table('PRO_ConsultaEntrada', '')]
  TDtoPRO_ConsultaEntrada = class
  private
    { Private declarations } 
    FNFE_SIGLA: String;
    FNFE_TIPOMOVTO: String;
    FNFE_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FNFE_QTDENTRADA: Double;
    FNFE_VALORCUSTOCOMPRANFE: Double;
    FNFE_VALORCUSTOLIQUIDONFE: Double;
    FNFE_VALORCUSTOINVENTARIONFE: Double;
    FNFE_VALORCUSTOCOMPRAMEDIO: Double;
    FNFE_VALORCUSTOLIQUIDOMEDIO: Double;
    FNFE_VALORCUSTOINVENTARIOMEDIO: Double;
    FPES_CODIGO: Integer;
    FNFE_NOTAFISCAL: String;
    FNFE_DATALANCAMENTO: TDateTime;
    FPES_NOME: String;
    FPRO_DESCRICAO: String;
    FPRO_DESCRICAOADICIONAL: String;
  public 
    { Public declarations } 
     const Table      = 'PRO_ConsultaEntrada';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_SIGLA', ftString, 7)]
    [Dictionary('NFE_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_SIGLA: String read FNFE_SIGLA write FNFE_SIGLA;
    const NFE_SIGLA_Name = 'NFE_SIGLA';

    [Restrictions([NoValidate, NotNull])]
    [Column('NFE_TIPOMOVTO', ftString, 52)]
    [Dictionary('NFE_TIPOMOVTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_TIPOMOVTO: String read FNFE_TIPOMOVTO write FNFE_TIPOMOVTO;
    const NFE_TIPOMOVTO_Name = 'NFE_TIPOMOVTO';

    [Restrictions([NoValidate])]
    [Column('NFE_ID', ftInteger)]
    [Dictionary('NFE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property NFE_ID: Integer read FNFE_ID write FNFE_ID;
    const NFE_ID_Name = 'NFE_ID';

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
    [Column('NFE_QTDENTRADA', ftBCD)]
    [Dictionary('NFE_QTDENTRADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_QTDENTRADA: Double read FNFE_QTDENTRADA write FNFE_QTDENTRADA;
    const NFE_QTDENTRADA_Name = 'NFE_QTDENTRADA';

    [Restrictions([NoValidate])]
    [Column('NFE_VALORCUSTOCOMPRANFE', ftBCD, 48, 5)]
    [Dictionary('NFE_VALORCUSTOCOMPRANFE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORCUSTOCOMPRANFE: Double read FNFE_VALORCUSTOCOMPRANFE write FNFE_VALORCUSTOCOMPRANFE;
    const NFE_VALORCUSTOCOMPRANFE_Name = 'NFE_VALORCUSTOCOMPRANFE';

    [Restrictions([NoValidate])]
    [Column('NFE_VALORCUSTOLIQUIDONFE', ftBCD, 48, 5)]
    [Dictionary('NFE_VALORCUSTOLIQUIDONFE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORCUSTOLIQUIDONFE: Double read FNFE_VALORCUSTOLIQUIDONFE write FNFE_VALORCUSTOLIQUIDONFE;
    const NFE_VALORCUSTOLIQUIDONFE_Name = 'NFE_VALORCUSTOLIQUIDONFE';

    [Restrictions([NoValidate])]
    [Column('NFE_VALORCUSTOINVENTARIONFE', ftBCD)]
    [Dictionary('NFE_VALORCUSTOINVENTARIONFE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORCUSTOINVENTARIONFE: Double read FNFE_VALORCUSTOINVENTARIONFE write FNFE_VALORCUSTOINVENTARIONFE;
    const NFE_VALORCUSTOINVENTARIONFE_Name = 'NFE_VALORCUSTOINVENTARIONFE';

    [Restrictions([NoValidate])]
    [Column('NFE_VALORCUSTOCOMPRAMEDIO', ftBCD)]
    [Dictionary('NFE_VALORCUSTOCOMPRAMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORCUSTOCOMPRAMEDIO: Double read FNFE_VALORCUSTOCOMPRAMEDIO write FNFE_VALORCUSTOCOMPRAMEDIO;
    const NFE_VALORCUSTOCOMPRAMEDIO_Name = 'NFE_VALORCUSTOCOMPRAMEDIO';

    [Restrictions([NoValidate])]
    [Column('NFE_VALORCUSTOLIQUIDOMEDIO', ftBCD)]
    [Dictionary('NFE_VALORCUSTOLIQUIDOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORCUSTOLIQUIDOMEDIO: Double read FNFE_VALORCUSTOLIQUIDOMEDIO write FNFE_VALORCUSTOLIQUIDOMEDIO;
    const NFE_VALORCUSTOLIQUIDOMEDIO_Name = 'NFE_VALORCUSTOLIQUIDOMEDIO';

    [Restrictions([NoValidate])]
    [Column('NFE_VALORCUSTOINVENTARIOMEDIO', ftBCD)]
    [Dictionary('NFE_VALORCUSTOINVENTARIOMEDIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property NFE_VALORCUSTOINVENTARIOMEDIO: Double read FNFE_VALORCUSTOINVENTARIOMEDIO write FNFE_VALORCUSTOINVENTARIOMEDIO;
    const NFE_VALORCUSTOINVENTARIOMEDIO_Name = 'NFE_VALORCUSTOINVENTARIOMEDIO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('NFE_NOTAFISCAL', ftString, 20)]
    [Dictionary('NFE_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property NFE_NOTAFISCAL: String read FNFE_NOTAFISCAL write FNFE_NOTAFISCAL;
    const NFE_NOTAFISCAL_Name = 'NFE_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('NFE_DATALANCAMENTO', ftDateTime)]
    [Dictionary('NFE_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property NFE_DATALANCAMENTO: TDateTime read FNFE_DATALANCAMENTO write FNFE_DATALANCAMENTO;
    const NFE_DATALANCAMENTO_Name = 'NFE_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAOADICIONAL', ftString, 300)]
    [Dictionary('PRO_DESCRICAOADICIONAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAOADICIONAL: String read FPRO_DESCRICAOADICIONAL write FPRO_DESCRICAOADICIONAL;
    const PRO_DESCRICAOADICIONAL_Name = 'PRO_DESCRICAOADICIONAL';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPRO_ConsultaEntrada)

end.
