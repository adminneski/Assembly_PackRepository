unit express.dbo.REL_V07_LFS;

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
  [Table('REL_V07_LFS', '')]
  TDtoREL_V07_LFS = class
  private
    { Private declarations } 
    FLFS_TIPO: String;
    FLFS_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FLFS_SERIEECF: String;
    FLFS_SERIE: String;
    FMNF_CODIGO: String;
    FLFS_NOTAFISCAL: String;
    FLFS_DATASAIDA: TDateTime;
    FLFS_DATALANCAMENTO: TDateTime;
    FLFS_DATAEMISSAO: TDateTime;
    FPES_UF: String;
    FPES_NOME: String;
    FCFOP_CODIGO: String;
    FCSTPC_CODIGO: String;
    FLEF_CODIGO: Integer;
    FLEF_DESCRICAO: String;
    FLFS_TOTALDESCTOITEM: Double;
    FLFS_TOTALSEGUROITEM: Double;
    FLFS_TOTALFRETENFITEM: Double;
    FLFS_TOTALDESPACESSORIAITEM: Double;
    FLFS_TOTALITEMBRUTO: Double;
    FLFS_TOTALITEM: Double;
    FLFS_TOTALBCALCULOPISCOFINSITEM: Double;
    FLFS_TOTALPISITEM: Double;
    FLFS_TOTALCOFINSITEM: Double;
    FLFS_TOTALBASECALCULOISENTO: Double;
    FLFS_CANCELADO: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V07_LFS';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_TIPO', ftString, 3)]
    [Dictionary('LFS_TIPO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_TIPO: String read FLFS_TIPO write FLFS_TIPO;
    const LFS_TIPO_Name = 'LFS_TIPO';

    [Restrictions([NoValidate, NotNull])]
    [Column('LFS_ID', ftInteger)]
    [Dictionary('LFS_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property LFS_ID: Integer read FLFS_ID write FLFS_ID;
    const LFS_ID_Name = 'LFS_ID';

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
    [Column('LFS_SERIEECF', ftString, 3)]
    [Dictionary('LFS_SERIEECF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_SERIEECF: String read FLFS_SERIEECF write FLFS_SERIEECF;
    const LFS_SERIEECF_Name = 'LFS_SERIEECF';

    [Restrictions([NoValidate])]
    [Column('LFS_SERIE', ftString, 3)]
    [Dictionary('LFS_SERIE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_SERIE: String read FLFS_SERIE write FLFS_SERIE;
    const LFS_SERIE_Name = 'LFS_SERIE';

    [Restrictions([NoValidate])]
    [Column('MNF_CODIGO', ftString, 2)]
    [Dictionary('MNF_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MNF_CODIGO: String read FMNF_CODIGO write FMNF_CODIGO;
    const MNF_CODIGO_Name = 'MNF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LFS_NOTAFISCAL', ftString, 9)]
    [Dictionary('LFS_NOTAFISCAL', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_NOTAFISCAL: String read FLFS_NOTAFISCAL write FLFS_NOTAFISCAL;
    const LFS_NOTAFISCAL_Name = 'LFS_NOTAFISCAL';

    [Restrictions([NoValidate])]
    [Column('LFS_DATASAIDA', ftDateTime)]
    [Dictionary('LFS_DATASAIDA', 'Mensagem de validação', '', '', '', taCenter)]
    property LFS_DATASAIDA: TDateTime read FLFS_DATASAIDA write FLFS_DATASAIDA;
    const LFS_DATASAIDA_Name = 'LFS_DATASAIDA';

    [Restrictions([NoValidate])]
    [Column('LFS_DATALANCAMENTO', ftDateTime)]
    [Dictionary('LFS_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property LFS_DATALANCAMENTO: TDateTime read FLFS_DATALANCAMENTO write FLFS_DATALANCAMENTO;
    const LFS_DATALANCAMENTO_Name = 'LFS_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('LFS_DATAEMISSAO', ftDateTime)]
    [Dictionary('LFS_DATAEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property LFS_DATAEMISSAO: TDateTime read FLFS_DATAEMISSAO write FLFS_DATAEMISSAO;
    const LFS_DATAEMISSAO_Name = 'LFS_DATAEMISSAO';

    [Restrictions([NoValidate])]
    [Column('PES_UF', ftString, 2)]
    [Dictionary('PES_UF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_UF: String read FPES_UF write FPES_UF;
    const PES_UF_Name = 'PES_UF';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate, NotNull])]
    [Column('CFOP_CODIGO', ftString, 4)]
    [Dictionary('CFOP_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CFOP_CODIGO: String read FCFOP_CODIGO write FCFOP_CODIGO;
    const CFOP_CODIGO_Name = 'CFOP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CSTPC_CODIGO', ftString, 2)]
    [Dictionary('CSTPC_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CSTPC_CODIGO: String read FCSTPC_CODIGO write FCSTPC_CODIGO;
    const CSTPC_CODIGO_Name = 'CSTPC_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LEF_CODIGO', ftInteger)]
    [Dictionary('LEF_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LEF_CODIGO: Integer read FLEF_CODIGO write FLEF_CODIGO;
    const LEF_CODIGO_Name = 'LEF_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LEF_DESCRICAO', ftString, 100)]
    [Dictionary('LEF_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LEF_DESCRICAO: String read FLEF_DESCRICAO write FLEF_DESCRICAO;
    const LEF_DESCRICAO_Name = 'LEF_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALDESCTOITEM', ftBCD)]
    [Dictionary('LFS_TOTALDESCTOITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALDESCTOITEM: Double read FLFS_TOTALDESCTOITEM write FLFS_TOTALDESCTOITEM;
    const LFS_TOTALDESCTOITEM_Name = 'LFS_TOTALDESCTOITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALSEGUROITEM', ftBCD)]
    [Dictionary('LFS_TOTALSEGUROITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALSEGUROITEM: Double read FLFS_TOTALSEGUROITEM write FLFS_TOTALSEGUROITEM;
    const LFS_TOTALSEGUROITEM_Name = 'LFS_TOTALSEGUROITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALFRETENFITEM', ftBCD)]
    [Dictionary('LFS_TOTALFRETENFITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALFRETENFITEM: Double read FLFS_TOTALFRETENFITEM write FLFS_TOTALFRETENFITEM;
    const LFS_TOTALFRETENFITEM_Name = 'LFS_TOTALFRETENFITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALDESPACESSORIAITEM', ftBCD)]
    [Dictionary('LFS_TOTALDESPACESSORIAITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALDESPACESSORIAITEM: Double read FLFS_TOTALDESPACESSORIAITEM write FLFS_TOTALDESPACESSORIAITEM;
    const LFS_TOTALDESPACESSORIAITEM_Name = 'LFS_TOTALDESPACESSORIAITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALITEMBRUTO', ftBCD)]
    [Dictionary('LFS_TOTALITEMBRUTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALITEMBRUTO: Double read FLFS_TOTALITEMBRUTO write FLFS_TOTALITEMBRUTO;
    const LFS_TOTALITEMBRUTO_Name = 'LFS_TOTALITEMBRUTO';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALITEM', ftBCD, 10, 2)]
    [Dictionary('LFS_TOTALITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALITEM: Double read FLFS_TOTALITEM write FLFS_TOTALITEM;
    const LFS_TOTALITEM_Name = 'LFS_TOTALITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALBCALCULOPISCOFINSITEM', ftBCD)]
    [Dictionary('LFS_TOTALBCALCULOPISCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALBCALCULOPISCOFINSITEM: Double read FLFS_TOTALBCALCULOPISCOFINSITEM write FLFS_TOTALBCALCULOPISCOFINSITEM;
    const LFS_TOTALBCALCULOPISCOFINSITEM_Name = 'LFS_TOTALBCALCULOPISCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALPISITEM', ftBCD)]
    [Dictionary('LFS_TOTALPISITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALPISITEM: Double read FLFS_TOTALPISITEM write FLFS_TOTALPISITEM;
    const LFS_TOTALPISITEM_Name = 'LFS_TOTALPISITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALCOFINSITEM', ftBCD)]
    [Dictionary('LFS_TOTALCOFINSITEM', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALCOFINSITEM: Double read FLFS_TOTALCOFINSITEM write FLFS_TOTALCOFINSITEM;
    const LFS_TOTALCOFINSITEM_Name = 'LFS_TOTALCOFINSITEM';

    [Restrictions([NoValidate])]
    [Column('LFS_TOTALBASECALCULOISENTO', ftBCD)]
    [Dictionary('LFS_TOTALBASECALCULOISENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property LFS_TOTALBASECALCULOISENTO: Double read FLFS_TOTALBASECALCULOISENTO write FLFS_TOTALBASECALCULOISENTO;
    const LFS_TOTALBASECALCULOISENTO_Name = 'LFS_TOTALBASECALCULOISENTO';

    [Restrictions([NoValidate])]
    [Column('LFS_CANCELADO', ftString, 1)]
    [Dictionary('LFS_CANCELADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LFS_CANCELADO: String read FLFS_CANCELADO write FLFS_CANCELADO;
    const LFS_CANCELADO_Name = 'LFS_CANCELADO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V07_LFS)

end.
