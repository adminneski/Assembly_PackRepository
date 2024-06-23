unit express.dbo.SPEDPC_R_0200;

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
  [Table('SPEDPC_R_0200', '')]
  TDtoSPEDPC_R_0200 = class
  private
    { Private declarations } 
    FDT_DOC: TDateTime;
    FCOM_CODIGO: Integer;
    FCOD_ITEM: Integer;
    FDESCR_ITEM: String;
    FCOD_BARRA: String;
    FCOD_ANT_ITEM: String;
    FUNID_INV: String;
    FTIPO_ITEM: String;
    FCOD_NCM: String;
    FEX_IPI: String;
    FCOD_GEN: String;
    FCOD_LST: String;
    FALIQ_ICMS: Double;
  public 
    { Public declarations } 
     const Table      = 'SPEDPC_R_0200';

    [Restrictions([NoValidate])]
    [Column('DT_DOC', ftDateTime)]
    [Dictionary('DT_DOC', 'Mensagem de validação', '', '', '', taCenter)]
    property DT_DOC: TDateTime read FDT_DOC write FDT_DOC;
    const DT_DOC_Name = 'DT_DOC';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COD_ITEM', ftInteger)]
    [Dictionary('COD_ITEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property COD_ITEM: Integer read FCOD_ITEM write FCOD_ITEM;
    const COD_ITEM_Name = 'COD_ITEM';

    [Restrictions([NoValidate])]
    [Column('DESCR_ITEM', ftString, 300)]
    [Dictionary('DESCR_ITEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property DESCR_ITEM: String read FDESCR_ITEM write FDESCR_ITEM;
    const DESCR_ITEM_Name = 'DESCR_ITEM';

    [Restrictions([NoValidate])]
    [Column('COD_BARRA', ftString, 15)]
    [Dictionary('COD_BARRA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_BARRA: String read FCOD_BARRA write FCOD_BARRA;
    const COD_BARRA_Name = 'COD_BARRA';

    [Restrictions([NoValidate, NotNull])]
    [Column('COD_ANT_ITEM', ftString, 1)]
    [Dictionary('COD_ANT_ITEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_ANT_ITEM: String read FCOD_ANT_ITEM write FCOD_ANT_ITEM;
    const COD_ANT_ITEM_Name = 'COD_ANT_ITEM';

    [Restrictions([NoValidate])]
    [Column('UNID_INV', ftString, 2)]
    [Dictionary('UNID_INV', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property UNID_INV: String read FUNID_INV write FUNID_INV;
    const UNID_INV_Name = 'UNID_INV';

    [Restrictions([NoValidate])]
    [Column('TIPO_ITEM', ftString, 5)]
    [Dictionary('TIPO_ITEM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property TIPO_ITEM: String read FTIPO_ITEM write FTIPO_ITEM;
    const TIPO_ITEM_Name = 'TIPO_ITEM';

    [Restrictions([NoValidate])]
    [Column('COD_NCM', ftString, 8)]
    [Dictionary('COD_NCM', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_NCM: String read FCOD_NCM write FCOD_NCM;
    const COD_NCM_Name = 'COD_NCM';

    [Restrictions([NoValidate, NotNull])]
    [Column('EX_IPI', ftString, 1)]
    [Dictionary('EX_IPI', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property EX_IPI: String read FEX_IPI write FEX_IPI;
    const EX_IPI_Name = 'EX_IPI';

    [Restrictions([NoValidate])]
    [Column('COD_GEN', ftString, 2)]
    [Dictionary('COD_GEN', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_GEN: String read FCOD_GEN write FCOD_GEN;
    const COD_GEN_Name = 'COD_GEN';

    [Restrictions([NoValidate, NotNull])]
    [Column('COD_LST', ftString, 1)]
    [Dictionary('COD_LST', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COD_LST: String read FCOD_LST write FCOD_LST;
    const COD_LST_Name = 'COD_LST';

    [Restrictions([NoValidate])]
    [Column('ALIQ_ICMS', ftBCD)]
    [Dictionary('ALIQ_ICMS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ALIQ_ICMS: Double read FALIQ_ICMS write FALIQ_ICMS;
    const ALIQ_ICMS_Name = 'ALIQ_ICMS';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoSPEDPC_R_0200)

end.
