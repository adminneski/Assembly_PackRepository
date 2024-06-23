unit express.dbo.CONFIG_00_05;

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
  [Table('CONFIG_00_05', '')]
  [PrimaryKey('CFG_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CFG_CODIGO')]
  TDtoCONFIG_00_05 = class
  private
    { Private declarations } 
    FCFG_CODIGO: Integer;
    FPLC_CODIGOPADRAOJUROSCRE: Integer;
    FPLC_CODIGOPADRAOMULTACRE: Integer;
    FPLC_CODIGOPADRAODESPESASCRE: Integer;
    FPLC_CODIGOPADRAOCARTORIOCRE: Integer;
    FPLC_CODIGOPADRAODESCONTOCRE: Integer;
    FPLC_CODIGOPADRAODESPCARTAOCRE: Integer;
    FCCU_CODIGOPADRAOFINANCEIROCRE: Integer;
    FPLC_CODIGOPADRAOJUROSCPA: Integer;
    FPLC_CODIGOPADRAOMULTACPA: Integer;
    FPLC_CODIGOPADRAODESCONTOCPA: Integer;
    FPLC_CODIGOPADRAODESPESASCPA: Integer;
    FCCU_CODIGOPADRAOFINANCEIROCPA: Integer;
    FCCU_CODIGOPADRAOPRODUCAO: Integer;
    FPLC_CODIGOPADRAOPRODUCAO: Integer;
    FPLC_CODIGOPADRAOTRANSFERENCIA: Integer;
    FCCU_CODIGOPADRAOTRANSFERENCIA: Integer;
    FPLC_CODIGOPADRAOBCX: Integer;
    FCCU_CODIGOPADRAOBCX: Integer;
    FPLC_CODIGOPADRAONFE: Integer;
    FCCU_CODIGOPADRAONFE: Integer;
    FPLC_CODIGOPADRAOSEE: Integer;
    FCCU_CODIGOPADRAOSEE: Integer;
    FCFG_DATAALTERACAO: TDateTime;
    FPLC_CODIGOPADRAOTARIFABOLETOCRE: Integer;
    FCCU_CODIGOPADRAOUNICO: Integer;
    FPLC_CODIGOPADRAOANTECIPACAOFOR: Integer;
    FCCU_CODIGOPADRAOANTECIPACAOFOR: Integer;
    FPLC_CODIGOPADRAOANTECIPACAOCLI: Integer;
    FCCU_CODIGOPADRAOANTECIPACAOCLI: Integer;
  public 
    { Public declarations } 
     const Table      = 'CONFIG_00_05';
     const PrimaryKey = 'CFG_CODIGO';
     const Sequence   = 'SEQ_CFG_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CFG_CODIGO', ftInteger)]
    [Dictionary('CFG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CFG_CODIGO: Integer read FCFG_CODIGO write FCFG_CODIGO;
    const CFG_CODIGO_Name = 'CFG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAOJUROSCRE', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAOJUROSCRE', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAOJUROSCRE: Integer read FPLC_CODIGOPADRAOJUROSCRE write FPLC_CODIGOPADRAOJUROSCRE;
    const PLC_CODIGOPADRAOJUROSCRE_Name = 'PLC_CODIGOPADRAOJUROSCRE';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAOMULTACRE', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAOMULTACRE', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAOMULTACRE: Integer read FPLC_CODIGOPADRAOMULTACRE write FPLC_CODIGOPADRAOMULTACRE;
    const PLC_CODIGOPADRAOMULTACRE_Name = 'PLC_CODIGOPADRAOMULTACRE';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAODESPESASCRE', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAODESPESASCRE', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAODESPESASCRE: Integer read FPLC_CODIGOPADRAODESPESASCRE write FPLC_CODIGOPADRAODESPESASCRE;
    const PLC_CODIGOPADRAODESPESASCRE_Name = 'PLC_CODIGOPADRAODESPESASCRE';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAOCARTORIOCRE', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAOCARTORIOCRE', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAOCARTORIOCRE: Integer read FPLC_CODIGOPADRAOCARTORIOCRE write FPLC_CODIGOPADRAOCARTORIOCRE;
    const PLC_CODIGOPADRAOCARTORIOCRE_Name = 'PLC_CODIGOPADRAOCARTORIOCRE';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAODESCONTOCRE', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAODESCONTOCRE', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAODESCONTOCRE: Integer read FPLC_CODIGOPADRAODESCONTOCRE write FPLC_CODIGOPADRAODESCONTOCRE;
    const PLC_CODIGOPADRAODESCONTOCRE_Name = 'PLC_CODIGOPADRAODESCONTOCRE';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAODESPCARTAOCRE', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAODESPCARTAOCRE', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAODESPCARTAOCRE: Integer read FPLC_CODIGOPADRAODESPCARTAOCRE write FPLC_CODIGOPADRAODESPCARTAOCRE;
    const PLC_CODIGOPADRAODESPCARTAOCRE_Name = 'PLC_CODIGOPADRAODESPCARTAOCRE';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGOPADRAOFINANCEIROCRE', ftInteger)]
    [Dictionary('CCU_CODIGOPADRAOFINANCEIROCRE', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGOPADRAOFINANCEIROCRE: Integer read FCCU_CODIGOPADRAOFINANCEIROCRE write FCCU_CODIGOPADRAOFINANCEIROCRE;
    const CCU_CODIGOPADRAOFINANCEIROCRE_Name = 'CCU_CODIGOPADRAOFINANCEIROCRE';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAOJUROSCPA', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAOJUROSCPA', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAOJUROSCPA: Integer read FPLC_CODIGOPADRAOJUROSCPA write FPLC_CODIGOPADRAOJUROSCPA;
    const PLC_CODIGOPADRAOJUROSCPA_Name = 'PLC_CODIGOPADRAOJUROSCPA';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAOMULTACPA', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAOMULTACPA', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAOMULTACPA: Integer read FPLC_CODIGOPADRAOMULTACPA write FPLC_CODIGOPADRAOMULTACPA;
    const PLC_CODIGOPADRAOMULTACPA_Name = 'PLC_CODIGOPADRAOMULTACPA';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAODESCONTOCPA', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAODESCONTOCPA', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAODESCONTOCPA: Integer read FPLC_CODIGOPADRAODESCONTOCPA write FPLC_CODIGOPADRAODESCONTOCPA;
    const PLC_CODIGOPADRAODESCONTOCPA_Name = 'PLC_CODIGOPADRAODESCONTOCPA';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAODESPESASCPA', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAODESPESASCPA', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAODESPESASCPA: Integer read FPLC_CODIGOPADRAODESPESASCPA write FPLC_CODIGOPADRAODESPESASCPA;
    const PLC_CODIGOPADRAODESPESASCPA_Name = 'PLC_CODIGOPADRAODESPESASCPA';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGOPADRAOFINANCEIROCPA', ftInteger)]
    [Dictionary('CCU_CODIGOPADRAOFINANCEIROCPA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGOPADRAOFINANCEIROCPA: Integer read FCCU_CODIGOPADRAOFINANCEIROCPA write FCCU_CODIGOPADRAOFINANCEIROCPA;
    const CCU_CODIGOPADRAOFINANCEIROCPA_Name = 'CCU_CODIGOPADRAOFINANCEIROCPA';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGOPADRAOPRODUCAO', ftInteger)]
    [Dictionary('CCU_CODIGOPADRAOPRODUCAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGOPADRAOPRODUCAO: Integer read FCCU_CODIGOPADRAOPRODUCAO write FCCU_CODIGOPADRAOPRODUCAO;
    const CCU_CODIGOPADRAOPRODUCAO_Name = 'CCU_CODIGOPADRAOPRODUCAO';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAOPRODUCAO', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAOPRODUCAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAOPRODUCAO: Integer read FPLC_CODIGOPADRAOPRODUCAO write FPLC_CODIGOPADRAOPRODUCAO;
    const PLC_CODIGOPADRAOPRODUCAO_Name = 'PLC_CODIGOPADRAOPRODUCAO';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAOTRANSFERENCIA', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAOTRANSFERENCIA', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAOTRANSFERENCIA: Integer read FPLC_CODIGOPADRAOTRANSFERENCIA write FPLC_CODIGOPADRAOTRANSFERENCIA;
    const PLC_CODIGOPADRAOTRANSFERENCIA_Name = 'PLC_CODIGOPADRAOTRANSFERENCIA';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGOPADRAOTRANSFERENCIA', ftInteger)]
    [Dictionary('CCU_CODIGOPADRAOTRANSFERENCIA', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGOPADRAOTRANSFERENCIA: Integer read FCCU_CODIGOPADRAOTRANSFERENCIA write FCCU_CODIGOPADRAOTRANSFERENCIA;
    const CCU_CODIGOPADRAOTRANSFERENCIA_Name = 'CCU_CODIGOPADRAOTRANSFERENCIA';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAOBCX', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAOBCX', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAOBCX: Integer read FPLC_CODIGOPADRAOBCX write FPLC_CODIGOPADRAOBCX;
    const PLC_CODIGOPADRAOBCX_Name = 'PLC_CODIGOPADRAOBCX';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGOPADRAOBCX', ftInteger)]
    [Dictionary('CCU_CODIGOPADRAOBCX', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGOPADRAOBCX: Integer read FCCU_CODIGOPADRAOBCX write FCCU_CODIGOPADRAOBCX;
    const CCU_CODIGOPADRAOBCX_Name = 'CCU_CODIGOPADRAOBCX';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAONFE', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAONFE', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAONFE: Integer read FPLC_CODIGOPADRAONFE write FPLC_CODIGOPADRAONFE;
    const PLC_CODIGOPADRAONFE_Name = 'PLC_CODIGOPADRAONFE';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGOPADRAONFE', ftInteger)]
    [Dictionary('CCU_CODIGOPADRAONFE', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGOPADRAONFE: Integer read FCCU_CODIGOPADRAONFE write FCCU_CODIGOPADRAONFE;
    const CCU_CODIGOPADRAONFE_Name = 'CCU_CODIGOPADRAONFE';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAOSEE', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAOSEE', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAOSEE: Integer read FPLC_CODIGOPADRAOSEE write FPLC_CODIGOPADRAOSEE;
    const PLC_CODIGOPADRAOSEE_Name = 'PLC_CODIGOPADRAOSEE';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGOPADRAOSEE', ftInteger)]
    [Dictionary('CCU_CODIGOPADRAOSEE', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGOPADRAOSEE: Integer read FCCU_CODIGOPADRAOSEE write FCCU_CODIGOPADRAOSEE;
    const CCU_CODIGOPADRAOSEE_Name = 'CCU_CODIGOPADRAOSEE';

    [Restrictions([NoValidate])]
    [Column('CFG_DATAALTERACAO', ftDateTime)]
    [Dictionary('CFG_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property CFG_DATAALTERACAO: TDateTime read FCFG_DATAALTERACAO write FCFG_DATAALTERACAO;
    const CFG_DATAALTERACAO_Name = 'CFG_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAOTARIFABOLETOCRE', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAOTARIFABOLETOCRE', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAOTARIFABOLETOCRE: Integer read FPLC_CODIGOPADRAOTARIFABOLETOCRE write FPLC_CODIGOPADRAOTARIFABOLETOCRE;
    const PLC_CODIGOPADRAOTARIFABOLETOCRE_Name = 'PLC_CODIGOPADRAOTARIFABOLETOCRE';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGOPADRAOUNICO', ftInteger)]
    [Dictionary('CCU_CODIGOPADRAOUNICO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGOPADRAOUNICO: Integer read FCCU_CODIGOPADRAOUNICO write FCCU_CODIGOPADRAOUNICO;
    const CCU_CODIGOPADRAOUNICO_Name = 'CCU_CODIGOPADRAOUNICO';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAOANTECIPACAOFOR', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAOANTECIPACAOFOR', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAOANTECIPACAOFOR: Integer read FPLC_CODIGOPADRAOANTECIPACAOFOR write FPLC_CODIGOPADRAOANTECIPACAOFOR;
    const PLC_CODIGOPADRAOANTECIPACAOFOR_Name = 'PLC_CODIGOPADRAOANTECIPACAOFOR';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGOPADRAOANTECIPACAOFOR', ftInteger)]
    [Dictionary('CCU_CODIGOPADRAOANTECIPACAOFOR', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGOPADRAOANTECIPACAOFOR: Integer read FCCU_CODIGOPADRAOANTECIPACAOFOR write FCCU_CODIGOPADRAOANTECIPACAOFOR;
    const CCU_CODIGOPADRAOANTECIPACAOFOR_Name = 'CCU_CODIGOPADRAOANTECIPACAOFOR';

    [Restrictions([NoValidate])]
    [Column('PLC_CODIGOPADRAOANTECIPACAOCLI', ftInteger)]
    [Dictionary('PLC_CODIGOPADRAOANTECIPACAOCLI', 'Mensagem de validação', '0', '', '', taCenter)]
    property PLC_CODIGOPADRAOANTECIPACAOCLI: Integer read FPLC_CODIGOPADRAOANTECIPACAOCLI write FPLC_CODIGOPADRAOANTECIPACAOCLI;
    const PLC_CODIGOPADRAOANTECIPACAOCLI_Name = 'PLC_CODIGOPADRAOANTECIPACAOCLI';

    [Restrictions([NoValidate])]
    [Column('CCU_CODIGOPADRAOANTECIPACAOCLI', ftInteger)]
    [Dictionary('CCU_CODIGOPADRAOANTECIPACAOCLI', 'Mensagem de validação', '0', '', '', taCenter)]
    property CCU_CODIGOPADRAOANTECIPACAOCLI: Integer read FCCU_CODIGOPADRAOANTECIPACAOCLI write FCCU_CODIGOPADRAOANTECIPACAOCLI;
    const CCU_CODIGOPADRAOANTECIPACAOCLI_Name = 'CCU_CODIGOPADRAOANTECIPACAOCLI';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCONFIG_00_05)

end.
