unit express.dbo.CRE_00_02;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.cre_00,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('CRE_00_02', '')]
  [PrimaryKey('CRE_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_CRE_ID')]
  TDtoCRE_00_02 = class
  private
    { Private declarations } 
    FCRE_ID: Integer;
    FCOM_CODIGO: Integer;
    FBCO_CODIGO: Integer;
    FPES_CODIGO: Integer;
    FCRE_CONTA: String;
    FCRE_AGENCIA: String;
    FCRE_EMITENTE: String;
    FCRE_NUMEROCHEQUE: String;
    FCRE_DOCTOEMITENTE: String;
    FCRE_TOTALJUROS: Double;
    FCRE_DATAALTERACAO: TDateTime;
    FCRE_PES_CODIGO: Integer;
    FCRE_ID_OLD: Integer;
  public
    { Public declarations }
    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_ID', ftInteger)]
    [ForeignKey('CRE_00_02_fk', 'CRE_ID', 'CRE_00', 'CRE_ID', SetNull, SetNull)]
    [Dictionary('CRE_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ID: Integer read FCRE_ID write FCRE_ID;
    const CRE_ID_Name = 'CRE_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('BCO_CODIGO', ftInteger)]
    [Dictionary('BCO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property BCO_CODIGO: Integer read FBCO_CODIGO write FBCO_CODIGO;
    const BCO_CODIGO_Name = 'BCO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CRE_CONTA', ftString, 15)]
    [Dictionary('CRE_CONTA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_CONTA: String read FCRE_CONTA write FCRE_CONTA;
    const CRE_CONTA_Name = 'CRE_CONTA';

    [Restrictions([NoValidate])]
    [Column('CRE_AGENCIA', ftString, 6)]
    [Dictionary('CRE_AGENCIA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_AGENCIA: String read FCRE_AGENCIA write FCRE_AGENCIA;
    const CRE_AGENCIA_Name = 'CRE_AGENCIA';

    [Restrictions([NoValidate])]
    [Column('CRE_EMITENTE', ftString, 50)]
    [Dictionary('CRE_EMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_EMITENTE: String read FCRE_EMITENTE write FCRE_EMITENTE;
    const CRE_EMITENTE_Name = 'CRE_EMITENTE';

    [Restrictions([NoValidate])]
    [Column('CRE_NUMEROCHEQUE', ftString, 6)]
    [Dictionary('CRE_NUMEROCHEQUE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_NUMEROCHEQUE: String read FCRE_NUMEROCHEQUE write FCRE_NUMEROCHEQUE;
    const CRE_NUMEROCHEQUE_Name = 'CRE_NUMEROCHEQUE';

    [Restrictions([NoValidate])]
    [Column('CRE_DOCTOEMITENTE', ftString, 18)]
    [Dictionary('CRE_DOCTOEMITENTE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property CRE_DOCTOEMITENTE: String read FCRE_DOCTOEMITENTE write FCRE_DOCTOEMITENTE;
    const CRE_DOCTOEMITENTE_Name = 'CRE_DOCTOEMITENTE';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_TOTALJUROS', ftBCD)]
    [Dictionary('CRE_TOTALJUROS', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CRE_TOTALJUROS: Double read FCRE_TOTALJUROS write FCRE_TOTALJUROS;
    const CRE_TOTALJUROS_Name = 'CRE_TOTALJUROS';

    [Restrictions([NoValidate, NotNull])]
    [Column('CRE_DATAALTERACAO', ftDateTime)]
    [Dictionary('CRE_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property CRE_DATAALTERACAO: TDateTime read FCRE_DATAALTERACAO write FCRE_DATAALTERACAO;
    const CRE_DATAALTERACAO_Name = 'CRE_DATAALTERACAO';

    [Restrictions([NoValidate])]
    [Column('CRE_PES_CODIGO', ftInteger)]
    [Dictionary('CRE_PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_PES_CODIGO: Integer read FCRE_PES_CODIGO write FCRE_PES_CODIGO;
    const CRE_PES_CODIGO_Name = 'CRE_PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('CRE_ID_OLD', ftInteger)]
    [Dictionary('CRE_ID_OLD', 'Mensagem de validação', '0', '', '', taCenter)]
    property CRE_ID_OLD: Integer read FCRE_ID_OLD write FCRE_ID_OLD;
    const CRE_ID_OLD_Name = 'CRE_ID_OLD';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoCRE_00_02)

end.
