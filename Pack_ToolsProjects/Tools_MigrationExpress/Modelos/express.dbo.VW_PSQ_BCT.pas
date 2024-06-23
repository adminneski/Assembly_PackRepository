unit express.dbo.VW_PSQ_BCT;

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
  [Table('VW_PSQ_BCT', '')]
  TDtoVW_PSQ_BCT = class
  private
    { Private declarations } 
    FBCT_ID: Integer;
    FCOM_CODIGO: Integer;
    FCTR_ID: Integer;
    FCTR_NUMERODOCTO: String;
    FBCT_DATALACAMENTO: TDateTime;
    FTRP_CODIGO: Integer;
    FPES_NOME: String;
  public 
    { Public declarations } 
     const Table      = 'VW_PSQ_BCT';

    [Restrictions([NoValidate, NotNull])]
    [Column('BCT_ID', ftInteger)]
    [Dictionary('BCT_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCT_ID: Integer read FBCT_ID write FBCT_ID;
    const BCT_ID_Name = 'BCT_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTR_ID', ftInteger)]
    [Dictionary('CTR_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTR_ID: Integer read FCTR_ID write FCTR_ID;
    const CTR_ID_Name = 'CTR_ID';

    [Restrictions([NoValidate])]
    [Column('CTR_NUMERODOCTO', ftString, 6)]
    [Dictionary('CTR_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTR_NUMERODOCTO: String read FCTR_NUMERODOCTO write FCTR_NUMERODOCTO;
    const CTR_NUMERODOCTO_Name = 'CTR_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('BCT_DATALACAMENTO', ftDateTime)]
    [Dictionary('BCT_DATALACAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property BCT_DATALACAMENTO: TDateTime read FBCT_DATALACAMENTO write FBCT_DATALACAMENTO;
    const BCT_DATALACAMENTO_Name = 'BCT_DATALACAMENTO';

    [Restrictions([NoValidate])]
    [Column('TRP_CODIGO', ftInteger)]
    [Dictionary('TRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property TRP_CODIGO: Integer read FTRP_CODIGO write FTRP_CODIGO;
    const TRP_CODIGO_Name = 'TRP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoVW_PSQ_BCT)

end.
