unit express.dbo.LIC_00;

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
  [Table('LIC_00', '')]
  [PrimaryKey('LIC_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_LIC_ID')]
  TDtoLIC_00 = class
  private
    { Private declarations } 
    FLIC_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FLIC_DATACADASTRO: TDateTime;
    FLIC_VALORMENSALIDADE: Double;
    FLIC_VALORNOTAFISCAL: Double;
    FLIC_DIAPAGAMENTO: String;
    FLIC_RESPONSAVELFINANCEIRO: String;
    FLIC_MODULO: String;
    FLIC_STATUSLICENCA: String;
    FLIC_ROTINAS: String;
    FLIC_QTDCONEXOES: Integer;
    FLIC_VALORMENSALIDADE2013: Double;
    FLIC_VALORMENSALIDADE2014: Double;
    FLIC_VALORMENSALIDADE2015: Double;
    FLIC_VALORMENSALIDADE2016: Double;
    FLIC_VALORMENSALIDADE2017: Double;
    FLIC_VALORMENSALIDADE2018: Double;
    FLIC_VALORMENSALIDADE2019: Double;
    FLIC_VALORMENSALIDADE2020: Double;
    FLIC_VALORMENSALIDADE2021: Double;
    FLIC_VALORMENSALIDADE2022: Double;
    FLIC_OBSERVACAO: String;
    FLIC_BLOQUEADO: String;
    FLIC_OBSERVACAOBLOQUEIO: String;
    FLIC_DESATIVADO: String;
    FLIC_DATAALTERACAO: TDateTime;
    FLIC_DIASCARENCIABLOQUEIO: Integer;
    FLIC_STATUS: String;
    FLIC_STATUSMOTIVO: String;
    FLIC_PORTEFEDERAL: String;
    FLIC_QTDDIASEXPIRAR: Integer;
    FLIC_PARAMETROS: String;
    FTST: Double;
    FLIC_PES_CODIGO: String;
    FLIC_ID_OLD: Integer;
    FLIC_VALORMENSAL_ATUALBKP: Double;
  public 
    { Public declarations } 
     const Table      = 'LIC_00';
     const PrimaryKey = 'LIC_ID';
     const Sequence   = 'SEQ_LIC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('LIC_ID', ftInteger)]
    [Dictionary('LIC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LIC_ID: Integer read FLIC_ID write FLIC_ID;
    const LIC_ID_Name = 'LIC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LIC_DATACADASTRO', ftDateTime)]
    [Dictionary('LIC_DATACADASTRO', 'Mensagem de validação', '', '', '', taCenter)]
    property LIC_DATACADASTRO: TDateTime read FLIC_DATACADASTRO write FLIC_DATACADASTRO;
    const LIC_DATACADASTRO_Name = 'LIC_DATACADASTRO';

    [Restrictions([NoValidate])]
    [Column('LIC_VALORMENSALIDADE', ftBCD)]
    [Dictionary('LIC_VALORMENSALIDADE', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LIC_VALORMENSALIDADE: Double read FLIC_VALORMENSALIDADE write FLIC_VALORMENSALIDADE;
    const LIC_VALORMENSALIDADE_Name = 'LIC_VALORMENSALIDADE';

    [Restrictions([NoValidate])]
    [Column('LIC_VALORNOTAFISCAL', ftBCD)]
    [Dictionary('LIC_VALORNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LIC_VALORNOTAFISCAL: Double read FLIC_VALORNOTAFISCAL write FLIC_VALORNOTAFISCAL;
    const LIC_VALORNOTAFISCAL_Name = 'LIC_VALORNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('LIC_DIAPAGAMENTO', ftString, 2)]
    [Dictionary('LIC_DIAPAGAMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LIC_DIAPAGAMENTO: String read FLIC_DIAPAGAMENTO write FLIC_DIAPAGAMENTO;
    const LIC_DIAPAGAMENTO_Name = 'LIC_DIAPAGAMENTO';

    [Restrictions([NoValidate])]
    [Column('LIC_RESPONSAVELFINANCEIRO', ftString, 50)]
    [Dictionary('LIC_RESPONSAVELFINANCEIRO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LIC_RESPONSAVELFINANCEIRO: String read FLIC_RESPONSAVELFINANCEIRO write FLIC_RESPONSAVELFINANCEIRO;
    const LIC_RESPONSAVELFINANCEIRO_Name = 'LIC_RESPONSAVELFINANCEIRO';

    [Restrictions([NoValidate])]
    [Column('LIC_MODULO', ftString, 3)]
    [Dictionary('LIC_MODULO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LIC_MODULO: String read FLIC_MODULO write FLIC_MODULO;
    const LIC_MODULO_Name = 'LIC_MODULO';

    [Restrictions([NoValidate])]
    [Column('LIC_STATUSLICENCA', ftString, 1)]
    [Dictionary('LIC_STATUSLICENCA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LIC_STATUSLICENCA: String read FLIC_STATUSLICENCA write FLIC_STATUSLICENCA;
    const LIC_STATUSLICENCA_Name = 'LIC_STATUSLICENCA';

    [Restrictions([NoValidate])]
    [Column('LIC_ROTINAS', ftString, 30)]
    [Dictionary('LIC_ROTINAS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LIC_ROTINAS: String read FLIC_ROTINAS write FLIC_ROTINAS;
    const LIC_ROTINAS_Name = 'LIC_ROTINAS';

    [Restrictions([NoValidate])]
    [Column('LIC_QTDCONEXOES', ftInteger)]
    [Dictionary('LIC_QTDCONEXOES', 'Mensagem de validação', '0', '', '', taCenter)]
    property LIC_QTDCONEXOES: Integer read FLIC_QTDCONEXOES write FLIC_QTDCONEXOES;
    const LIC_QTDCONEXOES_Name = 'LIC_QTDCONEXOES';

    [Restrictions([NoValidate])]
    [Column('LIC_VALORMENSALIDADE2013', ftBCD)]
    [Dictionary('LIC_VALORMENSALIDADE2013', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LIC_VALORMENSALIDADE2013: Double read FLIC_VALORMENSALIDADE2013 write FLIC_VALORMENSALIDADE2013;
    const LIC_VALORMENSALIDADE2013_Name = 'LIC_VALORMENSALIDADE2013';

    [Restrictions([NoValidate])]
    [Column('LIC_VALORMENSALIDADE2014', ftBCD)]
    [Dictionary('LIC_VALORMENSALIDADE2014', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LIC_VALORMENSALIDADE2014: Double read FLIC_VALORMENSALIDADE2014 write FLIC_VALORMENSALIDADE2014;
    const LIC_VALORMENSALIDADE2014_Name = 'LIC_VALORMENSALIDADE2014';

    [Restrictions([NoValidate])]
    [Column('LIC_VALORMENSALIDADE2015', ftBCD)]
    [Dictionary('LIC_VALORMENSALIDADE2015', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LIC_VALORMENSALIDADE2015: Double read FLIC_VALORMENSALIDADE2015 write FLIC_VALORMENSALIDADE2015;
    const LIC_VALORMENSALIDADE2015_Name = 'LIC_VALORMENSALIDADE2015';

    [Restrictions([NoValidate])]
    [Column('LIC_VALORMENSALIDADE2016', ftBCD)]
    [Dictionary('LIC_VALORMENSALIDADE2016', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LIC_VALORMENSALIDADE2016: Double read FLIC_VALORMENSALIDADE2016 write FLIC_VALORMENSALIDADE2016;
    const LIC_VALORMENSALIDADE2016_Name = 'LIC_VALORMENSALIDADE2016';

    [Restrictions([NoValidate])]
    [Column('LIC_VALORMENSALIDADE2017', ftBCD)]
    [Dictionary('LIC_VALORMENSALIDADE2017', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LIC_VALORMENSALIDADE2017: Double read FLIC_VALORMENSALIDADE2017 write FLIC_VALORMENSALIDADE2017;
    const LIC_VALORMENSALIDADE2017_Name = 'LIC_VALORMENSALIDADE2017';

    [Restrictions([NoValidate])]
    [Column('LIC_VALORMENSALIDADE2018', ftBCD)]
    [Dictionary('LIC_VALORMENSALIDADE2018', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LIC_VALORMENSALIDADE2018: Double read FLIC_VALORMENSALIDADE2018 write FLIC_VALORMENSALIDADE2018;
    const LIC_VALORMENSALIDADE2018_Name = 'LIC_VALORMENSALIDADE2018';

    [Restrictions([NoValidate])]
    [Column('LIC_VALORMENSALIDADE2019', ftBCD)]
    [Dictionary('LIC_VALORMENSALIDADE2019', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LIC_VALORMENSALIDADE2019: Double read FLIC_VALORMENSALIDADE2019 write FLIC_VALORMENSALIDADE2019;
    const LIC_VALORMENSALIDADE2019_Name = 'LIC_VALORMENSALIDADE2019';

    [Restrictions([NoValidate])]
    [Column('LIC_VALORMENSALIDADE2020', ftBCD)]
    [Dictionary('LIC_VALORMENSALIDADE2020', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LIC_VALORMENSALIDADE2020: Double read FLIC_VALORMENSALIDADE2020 write FLIC_VALORMENSALIDADE2020;
    const LIC_VALORMENSALIDADE2020_Name = 'LIC_VALORMENSALIDADE2020';

    [Restrictions([NoValidate])]
    [Column('LIC_VALORMENSALIDADE2021', ftBCD)]
    [Dictionary('LIC_VALORMENSALIDADE2021', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LIC_VALORMENSALIDADE2021: Double read FLIC_VALORMENSALIDADE2021 write FLIC_VALORMENSALIDADE2021;
    const LIC_VALORMENSALIDADE2021_Name = 'LIC_VALORMENSALIDADE2021';

    [Restrictions([NoValidate])]
    [Column('LIC_VALORMENSALIDADE2022', ftBCD)]
    [Dictionary('LIC_VALORMENSALIDADE2022', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LIC_VALORMENSALIDADE2022: Double read FLIC_VALORMENSALIDADE2022 write FLIC_VALORMENSALIDADE2022;
    const LIC_VALORMENSALIDADE2022_Name = 'LIC_VALORMENSALIDADE2022';

    [Restrictions([NoValidate])]
    [Column('LIC_OBSERVACAO', ftString, 5000)]
    [Dictionary('LIC_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LIC_OBSERVACAO: String read FLIC_OBSERVACAO write FLIC_OBSERVACAO;
    const LIC_OBSERVACAO_Name = 'LIC_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LIC_BLOQUEADO', ftString, 1)]
    [Dictionary('LIC_BLOQUEADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LIC_BLOQUEADO: String read FLIC_BLOQUEADO write FLIC_BLOQUEADO;
    const LIC_BLOQUEADO_Name = 'LIC_BLOQUEADO';

    [Restrictions([NoValidate])]
    [Column('LIC_OBSERVACAOBLOQUEIO', ftString, 5000)]
    [Dictionary('LIC_OBSERVACAOBLOQUEIO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LIC_OBSERVACAOBLOQUEIO: String read FLIC_OBSERVACAOBLOQUEIO write FLIC_OBSERVACAOBLOQUEIO;
    const LIC_OBSERVACAOBLOQUEIO_Name = 'LIC_OBSERVACAOBLOQUEIO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LIC_DESATIVADO', ftString, 1)]
    [Dictionary('LIC_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LIC_DESATIVADO: String read FLIC_DESATIVADO write FLIC_DESATIVADO;
    const LIC_DESATIVADO_Name = 'LIC_DESATIVADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LIC_DATAALTERACAO', ftDateTime)]
    [Dictionary('LIC_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property LIC_DATAALTERACAO: TDateTime read FLIC_DATAALTERACAO write FLIC_DATAALTERACAO;
    const LIC_DATAALTERACAO_Name = 'LIC_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LIC_DIASCARENCIABLOQUEIO', ftInteger)]
    [Dictionary('LIC_DIASCARENCIABLOQUEIO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LIC_DIASCARENCIABLOQUEIO: Integer read FLIC_DIASCARENCIABLOQUEIO write FLIC_DIASCARENCIABLOQUEIO;
    const LIC_DIASCARENCIABLOQUEIO_Name = 'LIC_DIASCARENCIABLOQUEIO';

    [Restrictions([NoValidate])]
    [Column('LIC_STATUS', ftString, 1)]
    [Dictionary('LIC_STATUS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LIC_STATUS: String read FLIC_STATUS write FLIC_STATUS;
    const LIC_STATUS_Name = 'LIC_STATUS';

    [Restrictions([NoValidate])]
    [Column('LIC_STATUSMOTIVO', ftString, 100)]
    [Dictionary('LIC_STATUSMOTIVO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LIC_STATUSMOTIVO: String read FLIC_STATUSMOTIVO write FLIC_STATUSMOTIVO;
    const LIC_STATUSMOTIVO_Name = 'LIC_STATUSMOTIVO';

    [Restrictions([NoValidate])]
    [Column('LIC_PORTEFEDERAL', ftString, 1)]
    [Dictionary('LIC_PORTEFEDERAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LIC_PORTEFEDERAL: String read FLIC_PORTEFEDERAL write FLIC_PORTEFEDERAL;
    const LIC_PORTEFEDERAL_Name = 'LIC_PORTEFEDERAL';

    [Restrictions([NoValidate])]
    [Column('LIC_QTDDIASEXPIRAR', ftInteger)]
    [Dictionary('LIC_QTDDIASEXPIRAR', 'Mensagem de validação', '0', '', '', taCenter)]
    property LIC_QTDDIASEXPIRAR: Integer read FLIC_QTDDIASEXPIRAR write FLIC_QTDDIASEXPIRAR;
    const LIC_QTDDIASEXPIRAR_Name = 'LIC_QTDDIASEXPIRAR';

    [Restrictions([NoValidate])]
    [Column('LIC_PARAMETROS', ftString, 30)]
    [Dictionary('LIC_PARAMETROS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LIC_PARAMETROS: String read FLIC_PARAMETROS write FLIC_PARAMETROS;
    const LIC_PARAMETROS_Name = 'LIC_PARAMETROS';

    [Restrictions([NoValidate])]
    [Column('TST', ftBCD)]
    [Dictionary('TST', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property TST: Double read FTST write FTST;
    const TST_Name = 'TST';

    [Restrictions([NoValidate])]
    [Column('LIC_PES_CODIGO', ftString, 6)]
    [Dictionary('LIC_PES_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LIC_PES_CODIGO: String read FLIC_PES_CODIGO write FLIC_PES_CODIGO;
    const LIC_PES_CODIGO_Name = 'LIC_PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LIC_ID_OLD', ftInteger)]
    [Dictionary('LIC_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LIC_ID_OLD: Integer read FLIC_ID_OLD write FLIC_ID_OLD;
    const LIC_ID_OLD_Name = 'LIC_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('LIC_VALORMENSAL_ATUALBKP', ftBCD)]
    [Dictionary('LIC_VALORMENSAL_ATUALBKP', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LIC_VALORMENSAL_ATUALBKP: Double read FLIC_VALORMENSAL_ATUALBKP write FLIC_VALORMENSAL_ATUALBKP;
    const LIC_VALORMENSAL_ATUALBKP_Name = 'LIC_VALORMENSAL_ATUALBKP';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoLIC_00)

end.
