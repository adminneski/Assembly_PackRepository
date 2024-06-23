unit express.dbo.CONFIG_00_04;

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
  [Table('CONFIG_00_04', '')]
  [PrimaryKey('CFG_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CFG_CODIGO')]
  TDtoCONFIG_00_04 = class
  private
    { Private declarations } 
    FCFG_CODIGO: Integer;
    FCFG_IND_ATIV: String;
    FCFG_TIPO_ESCRIT: String;
    FCFG_IND_NAT_PJ: String;
    FCFG_COD_INC_TRIB: String;
    FCFG_IND_APRO_CRED: String;
    FCFG_IND_REG_CUM: String;
    FCFG_IND_ESCRI: String;
    FCFG_DATAALTERACAO: TDateTime;
    FCFG_IND_SIT_ESP: String;
    FCFG_COD_TIPO_CONT: String;
    FCFG_GERASPED: String;
    FCFG_ALIQ_CONT: Double;
    FCFG_COD_REC: String;
    FCFG_COD_INC_TRIB_0145: String;
    FCFG_ACPREVIDENCIARIARECEITAB: String;
    FCFG_COD_REC_FISCAL: String;
    FCFG_COD_VER_FISCAL: String;
    FCFG_NUM_CAMPO: String;
    FCFG_COD_REC_M205: String;
    FCFG_COD_REC_M605: String;
    FCFG_CONFIGURACOES: String;
    FCFG_COD_1400_PRODUTOR: String;
    FCFG_COD_1400_VEICULO: String;
    FCFG_COD_1400_TRANSPORTE: String;
    FCFG_COD_VER_SPEDPC: String;
    FCFG_CLAS_ESTAB_IND: String;
  public 
    { Public declarations } 
     const Table      = 'CONFIG_00_04';
     const PrimaryKey = 'CFG_CODIGO';
     const Sequence   = 'SEQ_CFG_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CFG_CODIGO', ftInteger)]
    [Dictionary('CFG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CFG_CODIGO: Integer read FCFG_CODIGO write FCFG_CODIGO;
    const CFG_CODIGO_Name = 'CFG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CFG_IND_ATIV', ftString, 1)]
    [Dictionary('CFG_IND_ATIV', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_IND_ATIV: String read FCFG_IND_ATIV write FCFG_IND_ATIV;
    const CFG_IND_ATIV_Name = 'CFG_IND_ATIV';

    [Restrictions([NoValidate])]
    [Column('CFG_TIPO_ESCRIT', ftString, 1)]
    [Dictionary('CFG_TIPO_ESCRIT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_TIPO_ESCRIT: String read FCFG_TIPO_ESCRIT write FCFG_TIPO_ESCRIT;
    const CFG_TIPO_ESCRIT_Name = 'CFG_TIPO_ESCRIT';

    [Restrictions([NoValidate])]
    [Column('CFG_IND_NAT_PJ', ftString, 2)]
    [Dictionary('CFG_IND_NAT_PJ', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_IND_NAT_PJ: String read FCFG_IND_NAT_PJ write FCFG_IND_NAT_PJ;
    const CFG_IND_NAT_PJ_Name = 'CFG_IND_NAT_PJ';

    [Restrictions([NoValidate])]
    [Column('CFG_COD_INC_TRIB', ftString, 1)]
    [Dictionary('CFG_COD_INC_TRIB', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_COD_INC_TRIB: String read FCFG_COD_INC_TRIB write FCFG_COD_INC_TRIB;
    const CFG_COD_INC_TRIB_Name = 'CFG_COD_INC_TRIB';

    [Restrictions([NoValidate])]
    [Column('CFG_IND_APRO_CRED', ftString, 1)]
    [Dictionary('CFG_IND_APRO_CRED', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_IND_APRO_CRED: String read FCFG_IND_APRO_CRED write FCFG_IND_APRO_CRED;
    const CFG_IND_APRO_CRED_Name = 'CFG_IND_APRO_CRED';

    [Restrictions([NoValidate])]
    [Column('CFG_IND_REG_CUM', ftString, 1)]
    [Dictionary('CFG_IND_REG_CUM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_IND_REG_CUM: String read FCFG_IND_REG_CUM write FCFG_IND_REG_CUM;
    const CFG_IND_REG_CUM_Name = 'CFG_IND_REG_CUM';

    [Restrictions([NoValidate])]
    [Column('CFG_IND_ESCRI', ftString, 1)]
    [Dictionary('CFG_IND_ESCRI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_IND_ESCRI: String read FCFG_IND_ESCRI write FCFG_IND_ESCRI;
    const CFG_IND_ESCRI_Name = 'CFG_IND_ESCRI';

    [Restrictions([NoValidate])]
    [Column('CFG_DATAALTERACAO', ftDateTime)]
    [Dictionary('CFG_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CFG_DATAALTERACAO: TDateTime read FCFG_DATAALTERACAO write FCFG_DATAALTERACAO;
    const CFG_DATAALTERACAO_Name = 'CFG_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CFG_IND_SIT_ESP', ftString, 1)]
    [Dictionary('CFG_IND_SIT_ESP', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_IND_SIT_ESP: String read FCFG_IND_SIT_ESP write FCFG_IND_SIT_ESP;
    const CFG_IND_SIT_ESP_Name = 'CFG_IND_SIT_ESP';

    [Restrictions([NoValidate])]
    [Column('CFG_COD_TIPO_CONT', ftString, 1)]
    [Dictionary('CFG_COD_TIPO_CONT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_COD_TIPO_CONT: String read FCFG_COD_TIPO_CONT write FCFG_COD_TIPO_CONT;
    const CFG_COD_TIPO_CONT_Name = 'CFG_COD_TIPO_CONT';

    [Restrictions([NoValidate])]
    [Column('CFG_GERASPED', ftString, 1)]
    [Dictionary('CFG_GERASPED', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_GERASPED: String read FCFG_GERASPED write FCFG_GERASPED;
    const CFG_GERASPED_Name = 'CFG_GERASPED';

    [Restrictions([NoValidate])]
    [Column('CFG_ALIQ_CONT', ftBCD)]
    [Dictionary('CFG_ALIQ_CONT', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CFG_ALIQ_CONT: Double read FCFG_ALIQ_CONT write FCFG_ALIQ_CONT;
    const CFG_ALIQ_CONT_Name = 'CFG_ALIQ_CONT';

    [Restrictions([NoValidate])]
    [Column('CFG_COD_REC', ftString, 6)]
    [Dictionary('CFG_COD_REC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_COD_REC: String read FCFG_COD_REC write FCFG_COD_REC;
    const CFG_COD_REC_Name = 'CFG_COD_REC';

    [Restrictions([NoValidate])]
    [Column('CFG_COD_INC_TRIB_0145', ftString, 1)]
    [Dictionary('CFG_COD_INC_TRIB_0145', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_COD_INC_TRIB_0145: String read FCFG_COD_INC_TRIB_0145 write FCFG_COD_INC_TRIB_0145;
    const CFG_COD_INC_TRIB_0145_Name = 'CFG_COD_INC_TRIB_0145';

    [Restrictions([NoValidate])]
    [Column('CFG_ACPREVIDENCIARIARECEITAB', ftString, 1)]
    [Dictionary('CFG_ACPREVIDENCIARIARECEITAB', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_ACPREVIDENCIARIARECEITAB: String read FCFG_ACPREVIDENCIARIARECEITAB write FCFG_ACPREVIDENCIARIARECEITAB;
    const CFG_ACPREVIDENCIARIARECEITAB_Name = 'CFG_ACPREVIDENCIARIARECEITAB';

    [Restrictions([NoValidate])]
    [Column('CFG_COD_REC_FISCAL', ftString, 6)]
    [Dictionary('CFG_COD_REC_FISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_COD_REC_FISCAL: String read FCFG_COD_REC_FISCAL write FCFG_COD_REC_FISCAL;
    const CFG_COD_REC_FISCAL_Name = 'CFG_COD_REC_FISCAL';

    [Restrictions([NoValidate])]
    [Column('CFG_COD_VER_FISCAL', ftString, 3)]
    [Dictionary('CFG_COD_VER_FISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_COD_VER_FISCAL: String read FCFG_COD_VER_FISCAL write FCFG_COD_VER_FISCAL;
    const CFG_COD_VER_FISCAL_Name = 'CFG_COD_VER_FISCAL';

    [Restrictions([NoValidate])]
    [Column('CFG_NUM_CAMPO', ftString, 2)]
    [Dictionary('CFG_NUM_CAMPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_NUM_CAMPO: String read FCFG_NUM_CAMPO write FCFG_NUM_CAMPO;
    const CFG_NUM_CAMPO_Name = 'CFG_NUM_CAMPO';

    [Restrictions([NoValidate])]
    [Column('CFG_COD_REC_M205', ftString, 6)]
    [Dictionary('CFG_COD_REC_M205', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_COD_REC_M205: String read FCFG_COD_REC_M205 write FCFG_COD_REC_M205;
    const CFG_COD_REC_M205_Name = 'CFG_COD_REC_M205';

    [Restrictions([NoValidate])]
    [Column('CFG_COD_REC_M605', ftString, 6)]
    [Dictionary('CFG_COD_REC_M605', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_COD_REC_M605: String read FCFG_COD_REC_M605 write FCFG_COD_REC_M605;
    const CFG_COD_REC_M605_Name = 'CFG_COD_REC_M605';

    [Restrictions([NoValidate])]
    [Column('CFG_CONFIGURACOES', ftString, 100)]
    [Dictionary('CFG_CONFIGURACOES', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_CONFIGURACOES: String read FCFG_CONFIGURACOES write FCFG_CONFIGURACOES;
    const CFG_CONFIGURACOES_Name = 'CFG_CONFIGURACOES';

    [Restrictions([NoValidate])]
    [Column('CFG_COD_1400_PRODUTOR', ftString, 60)]
    [Dictionary('CFG_COD_1400_PRODUTOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_COD_1400_PRODUTOR: String read FCFG_COD_1400_PRODUTOR write FCFG_COD_1400_PRODUTOR;
    const CFG_COD_1400_PRODUTOR_Name = 'CFG_COD_1400_PRODUTOR';

    [Restrictions([NoValidate])]
    [Column('CFG_COD_1400_VEICULO', ftString, 60)]
    [Dictionary('CFG_COD_1400_VEICULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_COD_1400_VEICULO: String read FCFG_COD_1400_VEICULO write FCFG_COD_1400_VEICULO;
    const CFG_COD_1400_VEICULO_Name = 'CFG_COD_1400_VEICULO';

    [Restrictions([NoValidate])]
    [Column('CFG_COD_1400_TRANSPORTE', ftString, 60)]
    [Dictionary('CFG_COD_1400_TRANSPORTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_COD_1400_TRANSPORTE: String read FCFG_COD_1400_TRANSPORTE write FCFG_COD_1400_TRANSPORTE;
    const CFG_COD_1400_TRANSPORTE_Name = 'CFG_COD_1400_TRANSPORTE';

    [Restrictions([NoValidate])]
    [Column('CFG_COD_VER_SPEDPC', ftString, 3)]
    [Dictionary('CFG_COD_VER_SPEDPC', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_COD_VER_SPEDPC: String read FCFG_COD_VER_SPEDPC write FCFG_COD_VER_SPEDPC;
    const CFG_COD_VER_SPEDPC_Name = 'CFG_COD_VER_SPEDPC';

    [Restrictions([NoValidate])]
    [Column('CFG_CLAS_ESTAB_IND', ftString, 2)]
    [Dictionary('CFG_CLAS_ESTAB_IND', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFG_CLAS_ESTAB_IND: String read FCFG_CLAS_ESTAB_IND write FCFG_CLAS_ESTAB_IND;
    const CFG_CLAS_ESTAB_IND_Name = 'CFG_CLAS_ESTAB_IND';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCONFIG_00_04)

end.
