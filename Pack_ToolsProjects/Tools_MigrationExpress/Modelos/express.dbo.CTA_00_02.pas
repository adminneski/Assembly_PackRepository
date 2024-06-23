unit express.dbo.CTA_00_02;

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
  [Table('CTA_00_02', '')]
  [PrimaryKey('CTA_02_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CTA_02_ID')]
  TDtoCTA_00_02 = class
  private
    { Private declarations } 
    FCTA_02_ID: Integer;
    FCTA_CODIGO: Integer;
    FCTA_CODIGOCARTEIRA: String;
    FCTA_DESCRICAOCARTEIRA: String;
    FCTA_REGISTRADA: String;
    FCTA_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'CTA_00_02';
     const PrimaryKey = 'CTA_02_ID';
     const Sequence   = 'SEQ_CTA_02_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTA_02_ID', ftInteger)]
    [Dictionary('CTA_02_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_02_ID: Integer read FCTA_02_ID write FCTA_02_ID;
    const CTA_02_ID_Name = 'CTA_02_ID';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGO', ftInteger)]
    [Dictionary('CTA_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CTA_CODIGO: Integer read FCTA_CODIGO write FCTA_CODIGO;
    const CTA_CODIGO_Name = 'CTA_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CTA_CODIGOCARTEIRA', ftString, 3)]
    [Dictionary('CTA_CODIGOCARTEIRA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_CODIGOCARTEIRA: String read FCTA_CODIGOCARTEIRA write FCTA_CODIGOCARTEIRA;
    const CTA_CODIGOCARTEIRA_Name = 'CTA_CODIGOCARTEIRA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTA_DESCRICAOCARTEIRA', ftString, 50)]
    [Dictionary('CTA_DESCRICAOCARTEIRA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_DESCRICAOCARTEIRA: String read FCTA_DESCRICAOCARTEIRA write FCTA_DESCRICAOCARTEIRA;
    const CTA_DESCRICAOCARTEIRA_Name = 'CTA_DESCRICAOCARTEIRA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTA_REGISTRADA', ftString, 1)]
    [Dictionary('CTA_REGISTRADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CTA_REGISTRADA: String read FCTA_REGISTRADA write FCTA_REGISTRADA;
    const CTA_REGISTRADA_Name = 'CTA_REGISTRADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CTA_DATAALTERACAO', ftDateTime)]
    [Dictionary('CTA_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CTA_DATAALTERACAO: TDateTime read FCTA_DATAALTERACAO write FCTA_DATAALTERACAO;
    const CTA_DATAALTERACAO_Name = 'CTA_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCTA_00_02)

end.
