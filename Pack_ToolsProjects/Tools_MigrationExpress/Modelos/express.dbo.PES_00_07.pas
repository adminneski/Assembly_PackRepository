unit express.dbo.PES_00_07;

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
  [Table('PES_00_07', '')]
  [PrimaryKey('PES_07_ID', AutoInc, NoSort, False, 'Chave primária')]
  [PrimaryKey('COM_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PES_07_ID')]
  [Sequence('SEQ_COM_CODIGO')]
  TDtoPES_00_07 = class
  private
    { Private declarations } 
    FPES_07_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FPES_VALORMOVIMENTO: Double;
    FPES_DATALANCAMENTO: TDateTime;
    FUSERS_LOGIN: String;
    FPES_INTEGRACAO: String;
    FPES_DATAALTERACAO: TDateTime;
    FPES_TIPOPARCELA: String;
  public 
    { Public declarations } 
     const Table      = 'PES_00_07';
     const PrimaryKey = 'PES_07_ID';
     const Sequence   = 'SEQ_PES_07_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_07_ID', ftInteger)]
    [Dictionary('PES_07_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_07_ID: Integer read FPES_07_ID write FPES_07_ID;
    const PES_07_ID_Name = 'PES_07_ID';

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
    [Column('PES_VALORMOVIMENTO', ftBCD, 1981834596, 2)]
    [Dictionary('PES_VALORMOVIMENTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PES_VALORMOVIMENTO: Double read FPES_VALORMOVIMENTO write FPES_VALORMOVIMENTO;
    const PES_VALORMOVIMENTO_Name = 'PES_VALORMOVIMENTO';

    [Restrictions([NoValidate])]
    [Column('PES_DATALANCAMENTO', ftDateTime)]
    [Dictionary('PES_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property PES_DATALANCAMENTO: TDateTime read FPES_DATALANCAMENTO write FPES_DATALANCAMENTO;
    const PES_DATALANCAMENTO_Name = 'PES_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('USERS_LOGIN', ftString, 20)]
    [Dictionary('USERS_LOGIN', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property USERS_LOGIN: String read FUSERS_LOGIN write FUSERS_LOGIN;
    const USERS_LOGIN_Name = 'USERS_LOGIN';

    [Restrictions([NoValidate])]
    [Column('PES_INTEGRACAO', ftString, 50)]
    [Dictionary('PES_INTEGRACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_INTEGRACAO: String read FPES_INTEGRACAO write FPES_INTEGRACAO;
    const PES_INTEGRACAO_Name = 'PES_INTEGRACAO';

    [Restrictions([NoValidate])]
    [Column('PES_DATAALTERACAO', ftDateTime)]
    [Dictionary('PES_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property PES_DATAALTERACAO: TDateTime read FPES_DATAALTERACAO write FPES_DATAALTERACAO;
    const PES_DATAALTERACAO_Name = 'PES_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOPARCELA', ftString, 1)]
    [Dictionary('PES_TIPOPARCELA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOPARCELA: String read FPES_TIPOPARCELA write FPES_TIPOPARCELA;
    const PES_TIPOPARCELA_Name = 'PES_TIPOPARCELA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPES_00_07)

end.
