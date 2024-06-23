unit express.dbo.MFC_00_06;

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
  [Table('MFC_00_06', '')]
  [PrimaryKey('MFC_06_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_MFC_06_ID')]
  TDtoMFC_00_06 = class
  private
    { Private declarations } 
    FMFC_06_ID: Integer;
    FMFC_ID: Integer;
    FCOM_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FPES_CNPJ_CPF: String;
    FMFC_NUMEROAPOLICE: String;
    FMFC_NUMEROAVERBACAO: String;
    FMFC_DATAALTERACAO: TDateTime;
    FMFC_06_ID_OLD: Integer;
    FMFC_ID_OLD: Integer;
  public
    { Public declarations }
    const Table      = 'MFC_00_06';
    const PrimaryKey = 'MFC_06_ID';
    const Sequence   = 'SEQ_MFC_06_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_06_ID', ftInteger)]
    [Dictionary('MFC_06_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_06_ID: Integer read FMFC_06_ID write FMFC_06_ID;
    const MFC_06_ID_Name = 'MFC_06_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('MFC_ID', ftInteger)]
    [ForeignKey('MFC_00_06_fk', 'MFC_ID', 'MFC_00', 'MFC_ID', SetNull, SetNull)]
    [Dictionary('MFC_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_ID: Integer read FMFC_ID write FMFC_ID;
    const MFC_ID_Name = 'MFC_ID';

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
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate])]
    [Column('PES_CNPJ_CPF', ftString, 18)]
    [Dictionary('PES_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_CNPJ_CPF: String read FPES_CNPJ_CPF write FPES_CNPJ_CPF;
    const PES_CNPJ_CPF_Name = 'PES_CNPJ_CPF';

    [Restrictions([NoValidate])]
    [Column('MFC_NUMEROAPOLICE', ftString, 20)]
    [Dictionary('MFC_NUMEROAPOLICE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_NUMEROAPOLICE: String read FMFC_NUMEROAPOLICE write FMFC_NUMEROAPOLICE;
    const MFC_NUMEROAPOLICE_Name = 'MFC_NUMEROAPOLICE';

    [Restrictions([NoValidate])]
    [Column('MFC_NUMEROAVERBACAO', ftString, 40)]
    [Dictionary('MFC_NUMEROAVERBACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MFC_NUMEROAVERBACAO: String read FMFC_NUMEROAVERBACAO write FMFC_NUMEROAVERBACAO;
    const MFC_NUMEROAVERBACAO_Name = 'MFC_NUMEROAVERBACAO';

    [Restrictions([NoValidate])]
    [Column('MFC_DATAALTERACAO', ftDateTime)]
    [Dictionary('MFC_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property MFC_DATAALTERACAO: TDateTime read FMFC_DATAALTERACAO write FMFC_DATAALTERACAO;
    const MFC_DATAALTERACAO_Name = 'MFC_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('MFC_06_ID_OLD', ftInteger)]
    [Dictionary('MFC_06_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_06_ID_OLD: Integer read FMFC_06_ID_OLD write FMFC_06_ID_OLD;
    const MFC_06_ID_OLD_Name = 'MFC_06_ID_OLD';

    [Restrictions([NoValidate])]
    [Column('MFC_ID_OLD', ftInteger)]
    [Dictionary('MFC_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property MFC_ID_OLD: Integer read FMFC_ID_OLD write FMFC_ID_OLD;
    const MFC_ID_OLD_Name = 'MFC_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoMFC_00_06)

end.
