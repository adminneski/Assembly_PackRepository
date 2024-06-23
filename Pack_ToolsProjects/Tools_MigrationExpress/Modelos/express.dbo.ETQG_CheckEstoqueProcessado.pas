unit express.dbo.ETQG_CHECKESTOQUEPROCESSADO;

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
  [Table('ETQG_CheckEstoqueProcessado', '')]
  TDtoETQG_CheckEstoqueProcessado = class
  private
    { Private declarations } 
    FETQG_SIGLA: String;
    FETQG_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FPRO_DESCRICAO: String;
    FGRD_CODIGO: String;
    FETQG_QTDDIGITADA: Double;
  public 
    { Public declarations } 
     const Table      = 'ETQG_CheckEstoqueProcessado';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETQG_SIGLA', ftString, 6)]
    [Dictionary('ETQG_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ETQG_SIGLA: String read FETQG_SIGLA write FETQG_SIGLA;
    const ETQG_SIGLA_Name = 'ETQG_SIGLA';

    [Restrictions([NoValidate])]
    [Column('ETQG_ID', ftInteger)]
    [Dictionary('ETQG_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ETQG_ID: Integer read FETQG_ID write FETQG_ID;
    const ETQG_ID_Name = 'ETQG_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('GRD_CODIGO', ftString, 6)]
    [Dictionary('GRD_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRD_CODIGO: String read FGRD_CODIGO write FGRD_CODIGO;
    const GRD_CODIGO_Name = 'GRD_CODIGO';

    [Restrictions([NoValidate])]
    [Column('ETQG_QTDDIGITADA', ftBCD)]
    [Dictionary('ETQG_QTDDIGITADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQG_QTDDIGITADA: Double read FETQG_QTDDIGITADA write FETQG_QTDDIGITADA;
    const ETQG_QTDDIGITADA_Name = 'ETQG_QTDDIGITADA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoETQG_CheckEstoqueProcessado)

end.
