unit express.dbo.LFS_00_05;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.lfs_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('LFS_00_05', '')]
  [PrimaryKey('LFS_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_LFS_ID')]
  TDtoLFS_00_05 = class
  private
    { Private declarations } 
    FCOM_CODIGO: Integer;
    FLFS_ID: Integer;
    FLFS_DATAENTREGA: TDateTime;
    FLFS_TIPOCTE: String;
    FLFS_TIPOSERVICO: String;
    FLFS_EMITENTE: String;
    FLFS_APOLICE: String;
    FLFS_NUMEROCIOT: String;
    FCST_CODIGOCTR: String;
    FVEI_CODIGO: Integer;
    FFOR_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FPES_CLIENTEDESTINATARIO: Integer;
    FPES_CLIENTECONSIGNATARIO: Integer;
    FPES_CLIENTEREDESPACHO: Integer;
    FPES_CLIENTEOUTROS: Integer;
    FLFS_TOTALPEDAGIO: Double;
    FLFS_TOTALDESPACHO: Double;
    FLFS_PERCENTUALICMS: Double;
    FLFS_TOTALNOTAFISCAL: Double;
    FLFS_TOTALMERCADORIASEGURADA: Double;
    FLFS_NUMEROLIBERACAOSEGURO: String;
    FLFS_SERIELIBERACAOSEGURO: String;
    FLFS_COBRADORA: String;
    FLFS_NATUREZA: String;
    FLFS_NATUREZACARGA: String;
    FLFS_CHAVEACESSOSUBSTITUIDO: String;
    FLFS_TOMADORCONTRIBUINTEICMS: String;
    FLFS_CHAVEACESSOTOMADOR: String;
    FLFS_CNPJTOMADOR: String;
    FLFS_CPFTOMADOR: String;
    FMNF_CODIGOTOMADOR: String;
    FLFS_SERIETOMADOR: String;
    FLFS_SUBSERIETOMADOR: String;
    FLFS_NOTAFISCALTOMADOR: String;
    FLFS_VALORNOTAFISCALTOMADOR: Double;
    FLFS_DATAEMISSAONFTOMADOR: TDateTime;
    FLFS_CHAVEACESSOCOMPLEMENTO: String;
    FLFS_CHAVEACESSOANULACAO: String;
    FLFS_DATAEMISSAODECLARACAO: TDateTime;
    FLFS_DATAALTERACAO: TDateTime;
    FCID_IBGEORIGEM: Integer;
    FCID_IBGEDESTINO: Integer;
    FLFS_CIDADEORIGEM: String;
    FLFS_UFORIGEM: String;
    FLFS_CIDADEDESTINO: String;
    FLFS_UFDESTINO: String;
    FLFS_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'LFS_00_05';
    const PrimaryKey = 'LFS_ID';
    const Sequence   = 'SEQ_LFS_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_ID', ftInteger)]
    [ForeignKey('LFS_00_05_fk', 'LFS_ID', 'LFS_00', 'LFS_ID', SetNull, SetNull)]
    [Dictionary('LFS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ID: Integer read FLFS_ID write FLFS_ID;
    const LFS_ID_Name = 'LFS_ID';

    [Restrictions([NoValidate])]
    [Column('LFS_DATAENTREGA', ftDateTime)]
    [Dictionary('LFS_DATAENTREGA', 'Mensagem de validação', '', '', '', taCenter)]
    property LFS_DATAENTREGA: TDateTime read FLFS_DATAENTREGA write FLFS_DATAENTREGA;
    const LFS_DATAENTREGA_Name = 'LFS_DATAENTREGA';

    [Restrictions([NoValidate])]
    [Column('LFS_TIPOCTE', ftString, 1)]
    [Dictionary('LFS_TIPOCTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_TIPOCTE: String read FLFS_TIPOCTE write FLFS_TIPOCTE;
    const LFS_TIPOCTE_Name = 'LFS_TIPOCTE';

    [Restrictions([NoValidate])]
    [Column('LFS_TIPOSERVICO', ftString, 1)]
    [Dictionary('LFS_TIPOSERVICO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_TIPOSERVICO: String read FLFS_TIPOSERVICO write FLFS_TIPOSERVICO;
    const LFS_TIPOSERVICO_Name = 'LFS_TIPOSERVICO';

    [Restrictions([NoValidate])]
    [Column('LFS_EMITENTE', ftString, 1)]
    [Dictionary('LFS_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_EMITENTE: String read FLFS_EMITENTE write FLFS_EMITENTE;
    const LFS_EMITENTE_Name = 'LFS_EMITENTE';

    [Restrictions([NoValidate])]
    [Column('LFS_APOLICE', ftString, 20)]
    [Dictionary('LFS_APOLICE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_APOLICE: String read FLFS_APOLICE write FLFS_APOLICE;
    const LFS_APOLICE_Name = 'LFS_APOLICE';

    [Restrictions([NoValidate])]
    [Column('LFS_NUMEROCIOT', ftString, 12)]
    [Dictionary('LFS_NUMEROCIOT', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_NUMEROCIOT: String read FLFS_NUMEROCIOT write FLFS_NUMEROCIOT;
    const LFS_NUMEROCIOT_Name = 'LFS_NUMEROCIOT';

    [Restrictions([NoValidate])]
    [Column('CST_CODIGOCTR', ftString, 2)]
    [Dictionary('CST_CODIGOCTR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CST_CODIGOCTR: String read FCST_CODIGOCTR write FCST_CODIGOCTR;
    const CST_CODIGOCTR_Name = 'CST_CODIGOCTR';

    [Restrictions([NoValidate])]
    [Column('VEI_CODIGO', ftInteger)]
    [Dictionary('VEI_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEI_CODIGO: Integer read FVEI_CODIGO write FVEI_CODIGO;
    const VEI_CODIGO_Name = 'VEI_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FOR_CODIGO', ftInteger)]
    [Dictionary('FOR_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FOR_CODIGO: Integer read FFOR_CODIGO write FFOR_CODIGO;
    const FOR_CODIGO_Name = 'FOR_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_CLIENTEDESTINATARIO', ftInteger)]
    [Dictionary('PES_CLIENTEDESTINATARIO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CLIENTEDESTINATARIO: Integer read FPES_CLIENTEDESTINATARIO write FPES_CLIENTEDESTINATARIO;
    const PES_CLIENTEDESTINATARIO_Name = 'PES_CLIENTEDESTINATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_CLIENTECONSIGNATARIO', ftInteger)]
    [Dictionary('PES_CLIENTECONSIGNATARIO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CLIENTECONSIGNATARIO: Integer read FPES_CLIENTECONSIGNATARIO write FPES_CLIENTECONSIGNATARIO;
    const PES_CLIENTECONSIGNATARIO_Name = 'PES_CLIENTECONSIGNATARIO';

    [Restrictions([NoValidate])]
    [Column('PES_CLIENTEREDESPACHO', ftInteger)]
    [Dictionary('PES_CLIENTEREDESPACHO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CLIENTEREDESPACHO: Integer read FPES_CLIENTEREDESPACHO write FPES_CLIENTEREDESPACHO;
    const PES_CLIENTEREDESPACHO_Name = 'PES_CLIENTEREDESPACHO';

    [Restrictions([NoValidate])]
    [Column('PES_CLIENTEOUTROS', ftInteger)]
    [Dictionary('PES_CLIENTEOUTROS', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CLIENTEOUTROS: Integer read FPES_CLIENTEOUTROS write FPES_CLIENTEOUTROS;
    const PES_CLIENTEOUTROS_Name = 'PES_CLIENTEOUTROS';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALPEDAGIO', ftBCD)]
    [Dictionary('LFS_TOTALPEDAGIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALPEDAGIO: Double read FLFS_TOTALPEDAGIO write FLFS_TOTALPEDAGIO;
    const LFS_TOTALPEDAGIO_Name = 'LFS_TOTALPEDAGIO';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALDESPACHO', ftBCD)]
    [Dictionary('LFS_TOTALDESPACHO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALDESPACHO: Double read FLFS_TOTALDESPACHO write FLFS_TOTALDESPACHO;
    const LFS_TOTALDESPACHO_Name = 'LFS_TOTALDESPACHO';

    [Restrictions([NoValidate])]
    [Column('LFS_PERCENTUALICMS', ftBCD)]
    [Dictionary('LFS_PERCENTUALICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_PERCENTUALICMS: Double read FLFS_PERCENTUALICMS write FLFS_PERCENTUALICMS;
    const LFS_PERCENTUALICMS_Name = 'LFS_PERCENTUALICMS';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALNOTAFISCAL', ftBCD)]
    [Dictionary('LFS_TOTALNOTAFISCAL', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALNOTAFISCAL: Double read FLFS_TOTALNOTAFISCAL write FLFS_TOTALNOTAFISCAL;
    const LFS_TOTALNOTAFISCAL_Name = 'LFS_TOTALNOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALMERCADORIASEGURADA', ftBCD)]
    [Dictionary('LFS_TOTALMERCADORIASEGURADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALMERCADORIASEGURADA: Double read FLFS_TOTALMERCADORIASEGURADA write FLFS_TOTALMERCADORIASEGURADA;
    const LFS_TOTALMERCADORIASEGURADA_Name = 'LFS_TOTALMERCADORIASEGURADA';

    [Restrictions([NoValidate])]
    [Column('LFS_NUMEROLIBERACAOSEGURO', ftString, 20)]
    [Dictionary('LFS_NUMEROLIBERACAOSEGURO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_NUMEROLIBERACAOSEGURO: String read FLFS_NUMEROLIBERACAOSEGURO write FLFS_NUMEROLIBERACAOSEGURO;
    const LFS_NUMEROLIBERACAOSEGURO_Name = 'LFS_NUMEROLIBERACAOSEGURO';

    [Restrictions([NoValidate])]
    [Column('LFS_SERIELIBERACAOSEGURO', ftString, 2)]
    [Dictionary('LFS_SERIELIBERACAOSEGURO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_SERIELIBERACAOSEGURO: String read FLFS_SERIELIBERACAOSEGURO write FLFS_SERIELIBERACAOSEGURO;
    const LFS_SERIELIBERACAOSEGURO_Name = 'LFS_SERIELIBERACAOSEGURO';

    [Restrictions([NoValidate])]
    [Column('LFS_COBRADORA', ftString, 15)]
    [Dictionary('LFS_COBRADORA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_COBRADORA: String read FLFS_COBRADORA write FLFS_COBRADORA;
    const LFS_COBRADORA_Name = 'LFS_COBRADORA';

    [Restrictions([NoValidate])]
    [Column('LFS_NATUREZA', ftString, 20)]
    [Dictionary('LFS_NATUREZA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_NATUREZA: String read FLFS_NATUREZA write FLFS_NATUREZA;
    const LFS_NATUREZA_Name = 'LFS_NATUREZA';

    [Restrictions([NoValidate])]
    [Column('LFS_NATUREZACARGA', ftString, 15)]
    [Dictionary('LFS_NATUREZACARGA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_NATUREZACARGA: String read FLFS_NATUREZACARGA write FLFS_NATUREZACARGA;
    const LFS_NATUREZACARGA_Name = 'LFS_NATUREZACARGA';

    [Restrictions([NoValidate])]
    [Column('LFS_CHAVEACESSOSUBSTITUIDO', ftString, 44)]
    [Dictionary('LFS_CHAVEACESSOSUBSTITUIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_CHAVEACESSOSUBSTITUIDO: String read FLFS_CHAVEACESSOSUBSTITUIDO write FLFS_CHAVEACESSOSUBSTITUIDO;
    const LFS_CHAVEACESSOSUBSTITUIDO_Name = 'LFS_CHAVEACESSOSUBSTITUIDO';

    [Restrictions([NoValidate])]
    [Column('LFS_TOMADORCONTRIBUINTEICMS', ftString, 1)]
    [Dictionary('LFS_TOMADORCONTRIBUINTEICMS', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_TOMADORCONTRIBUINTEICMS: String read FLFS_TOMADORCONTRIBUINTEICMS write FLFS_TOMADORCONTRIBUINTEICMS;
    const LFS_TOMADORCONTRIBUINTEICMS_Name = 'LFS_TOMADORCONTRIBUINTEICMS';

    [Restrictions([NoValidate])]
    [Column('LFS_CHAVEACESSOTOMADOR', ftString, 44)]
    [Dictionary('LFS_CHAVEACESSOTOMADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_CHAVEACESSOTOMADOR: String read FLFS_CHAVEACESSOTOMADOR write FLFS_CHAVEACESSOTOMADOR;
    const LFS_CHAVEACESSOTOMADOR_Name = 'LFS_CHAVEACESSOTOMADOR';

    [Restrictions([NoValidate])]
    [Column('LFS_CNPJTOMADOR', ftString, 14)]
    [Dictionary('LFS_CNPJTOMADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_CNPJTOMADOR: String read FLFS_CNPJTOMADOR write FLFS_CNPJTOMADOR;
    const LFS_CNPJTOMADOR_Name = 'LFS_CNPJTOMADOR';

    [Restrictions([NoValidate])]
    [Column('LFS_CPFTOMADOR', ftString, 11)]
    [Dictionary('LFS_CPFTOMADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_CPFTOMADOR: String read FLFS_CPFTOMADOR write FLFS_CPFTOMADOR;
    const LFS_CPFTOMADOR_Name = 'LFS_CPFTOMADOR';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGOTOMADOR', ftString, 2)]
    [Dictionary('MNF_CODIGOTOMADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGOTOMADOR: String read FMNF_CODIGOTOMADOR write FMNF_CODIGOTOMADOR;
    const MNF_CODIGOTOMADOR_Name = 'MNF_CODIGOTOMADOR';

    [Restrictions([NoValidate])]
    [Column('LFS_SERIETOMADOR', ftString, 3)]
    [Dictionary('LFS_SERIETOMADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_SERIETOMADOR: String read FLFS_SERIETOMADOR write FLFS_SERIETOMADOR;
    const LFS_SERIETOMADOR_Name = 'LFS_SERIETOMADOR';

    [Restrictions([NoValidate])]
    [Column('LFS_SUBSERIETOMADOR', ftString, 3)]
    [Dictionary('LFS_SUBSERIETOMADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_SUBSERIETOMADOR: String read FLFS_SUBSERIETOMADOR write FLFS_SUBSERIETOMADOR;
    const LFS_SUBSERIETOMADOR_Name = 'LFS_SUBSERIETOMADOR';

    [Restrictions([NoValidate])]
    [Column('LFS_NOTAFISCALTOMADOR', ftString, 6)]
    [Dictionary('LFS_NOTAFISCALTOMADOR', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_NOTAFISCALTOMADOR: String read FLFS_NOTAFISCALTOMADOR write FLFS_NOTAFISCALTOMADOR;
    const LFS_NOTAFISCALTOMADOR_Name = 'LFS_NOTAFISCALTOMADOR';

    [Restrictions([NoValidate])]
    [Column('LFS_VALORNOTAFISCALTOMADOR', ftBCD, 1650, 2)]
    [Dictionary('LFS_VALORNOTAFISCALTOMADOR', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_VALORNOTAFISCALTOMADOR: Double read FLFS_VALORNOTAFISCALTOMADOR write FLFS_VALORNOTAFISCALTOMADOR;
    const LFS_VALORNOTAFISCALTOMADOR_Name = 'LFS_VALORNOTAFISCALTOMADOR';

    [Restrictions([NoValidate])]
    [Column('LFS_DATAEMISSAONFTOMADOR', ftDateTime)]
    [Dictionary('LFS_DATAEMISSAONFTOMADOR', 'Mensagem de validação', '', '', '', taCenter)]
    property LFS_DATAEMISSAONFTOMADOR: TDateTime read FLFS_DATAEMISSAONFTOMADOR write FLFS_DATAEMISSAONFTOMADOR;
    const LFS_DATAEMISSAONFTOMADOR_Name = 'LFS_DATAEMISSAONFTOMADOR';

    [Restrictions([NoValidate])]
    [Column('LFS_CHAVEACESSOCOMPLEMENTO', ftString, 44)]
    [Dictionary('LFS_CHAVEACESSOCOMPLEMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_CHAVEACESSOCOMPLEMENTO: String read FLFS_CHAVEACESSOCOMPLEMENTO write FLFS_CHAVEACESSOCOMPLEMENTO;
    const LFS_CHAVEACESSOCOMPLEMENTO_Name = 'LFS_CHAVEACESSOCOMPLEMENTO';

    [Restrictions([NoValidate])]
    [Column('LFS_CHAVEACESSOANULACAO', ftString, 44)]
    [Dictionary('LFS_CHAVEACESSOANULACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_CHAVEACESSOANULACAO: String read FLFS_CHAVEACESSOANULACAO write FLFS_CHAVEACESSOANULACAO;
    const LFS_CHAVEACESSOANULACAO_Name = 'LFS_CHAVEACESSOANULACAO';

    [Restrictions([NoValidate])]
    [Column('LFS_DATAEMISSAODECLARACAO', ftDateTime)]
    [Dictionary('LFS_DATAEMISSAODECLARACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property LFS_DATAEMISSAODECLARACAO: TDateTime read FLFS_DATAEMISSAODECLARACAO write FLFS_DATAEMISSAODECLARACAO;
    const LFS_DATAEMISSAODECLARACAO_Name = 'LFS_DATAEMISSAODECLARACAO';

    [Restrictions([NoValidate])]
    [Column('LFS_DATAALTERACAO', ftDateTime)]
    [Dictionary('LFS_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property LFS_DATAALTERACAO: TDateTime read FLFS_DATAALTERACAO write FLFS_DATAALTERACAO;
    const LFS_DATAALTERACAO_Name = 'LFS_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CID_IBGEORIGEM', ftInteger)]
    [Dictionary('CID_IBGEORIGEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property CID_IBGEORIGEM: Integer read FCID_IBGEORIGEM write FCID_IBGEORIGEM;
    const CID_IBGEORIGEM_Name = 'CID_IBGEORIGEM';

    [Restrictions([NoValidate])]
    [Column('CID_IBGEDESTINO', ftInteger)]
    [Dictionary('CID_IBGEDESTINO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CID_IBGEDESTINO: Integer read FCID_IBGEDESTINO write FCID_IBGEDESTINO;
    const CID_IBGEDESTINO_Name = 'CID_IBGEDESTINO';

    [Restrictions([NoValidate])]
    [Column('LFS_CIDADEORIGEM', ftString, 100)]
    [Dictionary('LFS_CIDADEORIGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_CIDADEORIGEM: String read FLFS_CIDADEORIGEM write FLFS_CIDADEORIGEM;
    const LFS_CIDADEORIGEM_Name = 'LFS_CIDADEORIGEM';

    [Restrictions([NoValidate])]
    [Column('LFS_UFORIGEM', ftString, 2)]
    [Dictionary('LFS_UFORIGEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_UFORIGEM: String read FLFS_UFORIGEM write FLFS_UFORIGEM;
    const LFS_UFORIGEM_Name = 'LFS_UFORIGEM';

    [Restrictions([NoValidate])]
    [Column('LFS_CIDADEDESTINO', ftString, 100)]
    [Dictionary('LFS_CIDADEDESTINO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_CIDADEDESTINO: String read FLFS_CIDADEDESTINO write FLFS_CIDADEDESTINO;
    const LFS_CIDADEDESTINO_Name = 'LFS_CIDADEDESTINO';

    [Restrictions([NoValidate])]
    [Column('LFS_UFDESTINO', ftString, 2)]
    [Dictionary('LFS_UFDESTINO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_UFDESTINO: String read FLFS_UFDESTINO write FLFS_UFDESTINO;
    const LFS_UFDESTINO_Name = 'LFS_UFDESTINO';

    [Restrictions([NoValidate])]
    [Column('LFS_ID_OLD', ftInteger)]
    [Dictionary('LFS_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ID_OLD: Integer read FLFS_ID_OLD write FLFS_ID_OLD;
    const LFS_ID_OLD_Name = 'LFS_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoLFS_00_05)

end.
