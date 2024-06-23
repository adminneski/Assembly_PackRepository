unit express.dbo.STG_REGISTRO50X;

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
  [Table('STG_REGISTRO50X', '')]
  TDtoSTG_REGISTRO50X = class
  private
    { Private declarations } 
    FSTG_TIPO: String;
    FSTG_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FMNF_CODIGO: String;
    FCFOP_CODIGO: String;
    FSTG_DATAENTRADA: TDateTime;
    FSTG_SITUACAO: String;
    FSTG_SERIE: String;
    FSTG_EMITENTE: String;
    FSTG_NOTAFISCAL: String;
    FSTG_TOTALSEGURO: Double;
    FSTG_TOTALSERVICO: Double;
    FSTG_TOTALFRETENF: Double;
    FSTG_TOTALPISCOFINS: Double;
    FSTG_TOTALCOMPLEMENTONFICMS: Double;
    FSTG_TOTALDESPACESSORIA: Double;
    FSTG_TOTALBASECALCULOICMSFRETENF: Double;
    FSTG_PERCENTUALICMSFRETENF: Double;
    FSTG_TOTALBCICMSDESPACESSORIA: Double;
    FSTG_PERCENTUALICMSDESPACESSORIA: Double;
    FPES_CNPJ: String;
    FPES_IE: String;
    FPES_UF: String;
    FSTG_TIPOFRETE: String;
  public 
    { Public declarations } 
     const Table      = 'STG_REGISTRO50X';

    [Restrictions([NoValidate, NotNull])]
    [Column('STG_TIPO', ftString, 3)]
    [Dictionary('STG_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property STG_TIPO: String read FSTG_TIPO write FSTG_TIPO;
    const STG_TIPO_Name = 'STG_TIPO';

    [Restrictions([NoValidate, NotNull])]
    [Column('STG_ID', ftInteger)]
    [Dictionary('STG_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property STG_ID: Integer read FSTG_ID write FSTG_ID;
    const STG_ID_Name = 'STG_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('STG_DATAENTRADA', ftDateTime)]
    [Dictionary('STG_DATAENTRADA', 'Mensagem de validação', '', '', '', taCenter)]
    property STG_DATAENTRADA: TDateTime read FSTG_DATAENTRADA write FSTG_DATAENTRADA;
    const STG_DATAENTRADA_Name = 'STG_DATAENTRADA';

    [Restrictions([NoValidate])]
    [Column('STG_SITUACAO', ftString, 1)]
    [Dictionary('STG_SITUACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property STG_SITUACAO: String read FSTG_SITUACAO write FSTG_SITUACAO;
    const STG_SITUACAO_Name = 'STG_SITUACAO';

    [Restrictions([NoValidate])]
    [Column('STG_SERIE', ftString, 3)]
    [Dictionary('STG_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property STG_SERIE: String read FSTG_SERIE write FSTG_SERIE;
    const STG_SERIE_Name = 'STG_SERIE';

    [Restrictions([NoValidate, NotNull])]
    [Column('STG_EMITENTE', ftString, 1)]
    [Dictionary('STG_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property STG_EMITENTE: String read FSTG_EMITENTE write FSTG_EMITENTE;
    const STG_EMITENTE_Name = 'STG_EMITENTE';

    [Restrictions([NoValidate])]
    [Column('STG_NOTAFISCAL', ftString, 9)]
    [Dictionary('STG_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property STG_NOTAFISCAL: String read FSTG_NOTAFISCAL write FSTG_NOTAFISCAL;
    const STG_NOTAFISCAL_Name = 'STG_NOTAFISCAL';

    [Restrictions([NoValidate, NotNull])]
    [Column('STG_TOTALSEGURO', ftBCD)]
    [Dictionary('STG_TOTALSEGURO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_TOTALSEGURO: Double read FSTG_TOTALSEGURO write FSTG_TOTALSEGURO;
    const STG_TOTALSEGURO_Name = 'STG_TOTALSEGURO';

    [Restrictions([NoValidate, NotNull])]
    [Column('STG_TOTALSERVICO', ftBCD)]
    [Dictionary('STG_TOTALSERVICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_TOTALSERVICO: Double read FSTG_TOTALSERVICO write FSTG_TOTALSERVICO;
    const STG_TOTALSERVICO_Name = 'STG_TOTALSERVICO';

    [Restrictions([NoValidate, NotNull])]
    [Column('STG_TOTALFRETENF', ftBCD)]
    [Dictionary('STG_TOTALFRETENF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_TOTALFRETENF: Double read FSTG_TOTALFRETENF write FSTG_TOTALFRETENF;
    const STG_TOTALFRETENF_Name = 'STG_TOTALFRETENF';

    [Restrictions([NoValidate])]
    [Column('STG_TOTALPISCOFINS', ftBCD)]
    [Dictionary('STG_TOTALPISCOFINS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_TOTALPISCOFINS: Double read FSTG_TOTALPISCOFINS write FSTG_TOTALPISCOFINS;
    const STG_TOTALPISCOFINS_Name = 'STG_TOTALPISCOFINS';

    [Restrictions([NoValidate, NotNull])]
    [Column('STG_TOTALCOMPLEMENTONFICMS', ftBCD)]
    [Dictionary('STG_TOTALCOMPLEMENTONFICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_TOTALCOMPLEMENTONFICMS: Double read FSTG_TOTALCOMPLEMENTONFICMS write FSTG_TOTALCOMPLEMENTONFICMS;
    const STG_TOTALCOMPLEMENTONFICMS_Name = 'STG_TOTALCOMPLEMENTONFICMS';

    [Restrictions([NoValidate, NotNull])]
    [Column('STG_TOTALDESPACESSORIA', ftBCD)]
    [Dictionary('STG_TOTALDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_TOTALDESPACESSORIA: Double read FSTG_TOTALDESPACESSORIA write FSTG_TOTALDESPACESSORIA;
    const STG_TOTALDESPACESSORIA_Name = 'STG_TOTALDESPACESSORIA';

    [Restrictions([NoValidate])]
    [Column('STG_TOTALBASECALCULOICMSFRETENF', ftBCD)]
    [Dictionary('STG_TOTALBASECALCULOICMSFRETENF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_TOTALBASECALCULOICMSFRETENF: Double read FSTG_TOTALBASECALCULOICMSFRETENF write FSTG_TOTALBASECALCULOICMSFRETENF;
    const STG_TOTALBASECALCULOICMSFRETENF_Name = 'STG_TOTALBASECALCULOICMSFRETENF';

    [Restrictions([NoValidate])]
    [Column('STG_PERCENTUALICMSFRETENF', ftBCD, 10, 2)]
    [Dictionary('STG_PERCENTUALICMSFRETENF', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_PERCENTUALICMSFRETENF: Double read FSTG_PERCENTUALICMSFRETENF write FSTG_PERCENTUALICMSFRETENF;
    const STG_PERCENTUALICMSFRETENF_Name = 'STG_PERCENTUALICMSFRETENF';

    [Restrictions([NoValidate])]
    [Column('STG_TOTALBCICMSDESPACESSORIA', ftBCD, 18, 4)]
    [Dictionary('STG_TOTALBCICMSDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_TOTALBCICMSDESPACESSORIA: Double read FSTG_TOTALBCICMSDESPACESSORIA write FSTG_TOTALBCICMSDESPACESSORIA;
    const STG_TOTALBCICMSDESPACESSORIA_Name = 'STG_TOTALBCICMSDESPACESSORIA';

    [Restrictions([NoValidate])]
    [Column('STG_PERCENTUALICMSDESPACESSORIA', ftBCD, 48, 2)]
    [Dictionary('STG_PERCENTUALICMSDESPACESSORIA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property STG_PERCENTUALICMSDESPACESSORIA: Double read FSTG_PERCENTUALICMSDESPACESSORIA write FSTG_PERCENTUALICMSDESPACESSORIA;
    const STG_PERCENTUALICMSDESPACESSORIA_Name = 'STG_PERCENTUALICMSDESPACESSORIA';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ', ftString, 14)]
    [Dictionary('PES_CNPJ', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ: String read FPES_CNPJ write FPES_CNPJ;
    const PES_CNPJ_Name = 'PES_CNPJ';

    [Restrictions([NoValidate])]
    [Column('PES_IE', ftString, 16)]
    [Dictionary('PES_IE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_IE: String read FPES_IE write FPES_IE;
    const PES_IE_Name = 'PES_IE';

    [Restrictions([NoValidate])]
    [Column('PES_UF', ftString, 2)]
    [Dictionary('PES_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF: String read FPES_UF write FPES_UF;
    const PES_UF_Name = 'PES_UF';

    [Restrictions([NoValidate])]
    [Column('STG_TIPOFRETE', ftString, 1)]
    [Dictionary('STG_TIPOFRETE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property STG_TIPOFRETE: String read FSTG_TIPOFRETE write FSTG_TIPOFRETE;
    const STG_TIPOFRETE_Name = 'STG_TIPOFRETE';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSTG_REGISTRO50X)

end.
