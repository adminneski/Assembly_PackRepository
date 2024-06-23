unit express.dbo.STG_REGISTRO61R;

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
  [Table('STG_REGISTRO61R', '')]
  TDtoSTG_REGISTRO61R = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FSTG_ID: Integer;
    FSTG_MODELO: String;
    FSTG_MES: Integer;
    FSTG_ANO: Integer;
    FPRO_CODIGO: Integer;
    FSTG_QTDSAIDA: Double;
    FSTG_VALORBRUTOPRODUTO: Double;
    FSTG_VALORBASECALCULOICMSITEM: Double;
    FSTG_PERCENTUALICMSITEM: Double;
  public 
    { Public declarations } 
     const Table      = 'STG_REGISTRO61R';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('STG_ID', ftInteger)]
    [Dictionary('STG_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property STG_ID: Integer read FSTG_ID write FSTG_ID;
    const STG_ID_Name = 'STG_ID';

    [Restrictions([NoValidate])]
    [Column('STG_MODELO', ftString, 2)]
    [Dictionary('STG_MODELO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property STG_MODELO: String read FSTG_MODELO write FSTG_MODELO;
    const STG_MODELO_Name = 'STG_MODELO';

    [Restrictions([NoValidate])]
    [Column('STG_MES', ftInteger)]
    [Dictionary('STG_MES', 'Mensagem de validação', '0', '', '', taCenter)]
    property STG_MES: Integer read FSTG_MES write FSTG_MES;
    const STG_MES_Name = 'STG_MES';

    [Restrictions([NoValidate])]
    [Column('STG_ANO', ftInteger)]
    [Dictionary('STG_ANO', 'Mensagem de validação', '0', '', '', taCenter)]
    property STG_ANO: Integer read FSTG_ANO write FSTG_ANO;
    const STG_ANO_Name = 'STG_ANO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('STG_QTDSAIDA', ftBCD, 18, 4)]
    [Dictionary('STG_QTDSAIDA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_QTDSAIDA: Double read FSTG_QTDSAIDA write FSTG_QTDSAIDA;
    const STG_QTDSAIDA_Name = 'STG_QTDSAIDA';

    [Restrictions([NoValidate])]
    [Column('STG_VALORBRUTOPRODUTO', ftBCD)]
    [Dictionary('STG_VALORBRUTOPRODUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_VALORBRUTOPRODUTO: Double read FSTG_VALORBRUTOPRODUTO write FSTG_VALORBRUTOPRODUTO;
    const STG_VALORBRUTOPRODUTO_Name = 'STG_VALORBRUTOPRODUTO';

    [Restrictions([NoValidate])]
    [Column('STG_VALORBASECALCULOICMSITEM', ftBCD)]
    [Dictionary('STG_VALORBASECALCULOICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_VALORBASECALCULOICMSITEM: Double read FSTG_VALORBASECALCULOICMSITEM write FSTG_VALORBASECALCULOICMSITEM;
    const STG_VALORBASECALCULOICMSITEM_Name = 'STG_VALORBASECALCULOICMSITEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('STG_PERCENTUALICMSITEM', ftBCD, 10, 6)]
    [Dictionary('STG_PERCENTUALICMSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_PERCENTUALICMSITEM: Double read FSTG_PERCENTUALICMSITEM write FSTG_PERCENTUALICMSITEM;
    const STG_PERCENTUALICMSITEM_Name = 'STG_PERCENTUALICMSITEM';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSTG_REGISTRO61R)

end.
