unit express.dbo.MFC_00_02;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.mfc_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('MFC_00_02', '')]
  [PrimaryKey('MFC_02_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_MFC_02_ID')]
  TDtoMFC_00_02 = class
  private
    { Private declarations } 
    FMFC_02_ID: Integer;
    FCOM_CODIGO: Integer;
    FMFC_ID: Integer;
    FMFC_DIA: Integer;
    FBCO_CODIGO: Integer;
    FFPG_CODIGO: Integer;
    FMFC_DATAVENCTO: TDateTime;
    FMFC_NUMERODOCTO: String;
    FFPG_TIPOPAGAMENTO: Integer;
    FMFC_NUMEROPARCELA: Integer;
    FMFC_VALORPARCELA: Double;
    FMFC_DATAALTERACAO: TDateTime;
    FMFC_02_ID_OLD: Integer;
    FMFC_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'MFC_00_02';
    const PrimaryKey = 'MFC_02_ID';
    const Sequence   = 'SEQ_MFC_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_02_ID', ftInteger)]
    [Dictionary('MFC_02_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_02_ID: Integer read FMFC_02_ID write FMFC_02_ID;
    const MFC_02_ID_Name = 'MFC_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_ID', ftInteger)]
    [ForeignKey('MFC_00_02_fk', 'MFC_ID', 'MFC_00', 'MFC_ID', SetNull, SetNull)]
    [Dictionary('MFC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_ID: Integer read FMFC_ID write FMFC_ID;
    const MFC_ID_Name = 'MFC_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_DIA', ftInteger)]
    [Dictionary('MFC_DIA', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_DIA: Integer read FMFC_DIA write FMFC_DIA;
    const MFC_DIA_Name = 'MFC_DIA';

    [Restrictions([NoValidate])]
    [Column('BCO_CODIGO', ftInteger)]
    [Dictionary('BCO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCO_CODIGO: Integer read FBCO_CODIGO write FBCO_CODIGO;
    const BCO_CODIGO_Name = 'BCO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('FPG_CODIGO', ftInteger)]
    [Dictionary('FPG_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_CODIGO: Integer read FFPG_CODIGO write FFPG_CODIGO;
    const FPG_CODIGO_Name = 'FPG_CODIGO';

    [Restrictions([NoValidate])]
    [Column('MFC_DATAVENCTO', ftDateTime)]
    [Dictionary('MFC_DATAVENCTO', 'Mensagem de validação', '', '', '', taCenter)]
    property MFC_DATAVENCTO: TDateTime read FMFC_DATAVENCTO write FMFC_DATAVENCTO;
    const MFC_DATAVENCTO_Name = 'MFC_DATAVENCTO';

    [Restrictions([NoValidate])]
    [Column('MFC_NUMERODOCTO', ftString, 15)]
    [Dictionary('MFC_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_NUMERODOCTO: String read FMFC_NUMERODOCTO write FMFC_NUMERODOCTO;
    const MFC_NUMERODOCTO_Name = 'MFC_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('FPG_TIPOPAGAMENTO', ftInteger)]
    [Dictionary('FPG_TIPOPAGAMENTO', 'Mensagem de validação', '0', '', '', taCenter)]
    property FPG_TIPOPAGAMENTO: Integer read FFPG_TIPOPAGAMENTO write FFPG_TIPOPAGAMENTO;
    const FPG_TIPOPAGAMENTO_Name = 'FPG_TIPOPAGAMENTO';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_NUMEROPARCELA', ftInteger)]
    [Dictionary('MFC_NUMEROPARCELA', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_NUMEROPARCELA: Integer read FMFC_NUMEROPARCELA write FMFC_NUMEROPARCELA;
    const MFC_NUMEROPARCELA_Name = 'MFC_NUMEROPARCELA';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_VALORPARCELA', ftBCD)]
    [Dictionary('MFC_VALORPARCELA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property MFC_VALORPARCELA: Double read FMFC_VALORPARCELA write FMFC_VALORPARCELA;
    const MFC_VALORPARCELA_Name = 'MFC_VALORPARCELA';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_DATAALTERACAO', ftDateTime)]
    [Dictionary('MFC_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property MFC_DATAALTERACAO: TDateTime read FMFC_DATAALTERACAO write FMFC_DATAALTERACAO;
    const MFC_DATAALTERACAO_Name = 'MFC_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('MFC_02_ID_OLD', ftInteger)]
    [Dictionary('MFC_02_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_02_ID_OLD: Integer read FMFC_02_ID_OLD write FMFC_02_ID_OLD;
    const MFC_02_ID_OLD_Name = 'MFC_02_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('MFC_ID_OLD', ftInteger)]
    [Dictionary('MFC_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_ID_OLD: Integer read FMFC_ID_OLD write FMFC_ID_OLD;
    const MFC_ID_OLD_Name = 'MFC_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoMFC_00_02)

end.
