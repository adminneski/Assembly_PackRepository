unit express.dbo.MIF_00;

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
  [Table('MIF_00', '')]
  [PrimaryKey('MIF_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_MIF_ID')]
  TDtoMIF_00 = class
  private
    { Private declarations } 
    FMIF_ID: Integer;
    FMIF_CODIGOMARCA: String;
    FMIF_CODIGOMODELO: String;
    FMIF_CODIGOVERSAO: String;
    FMIF_TIPOECF: String;
    FMIF_MARCAECF: String;
    FMIF_MODELOECF: String;
    FMIF_VERSAOECF: String;
    FMIF_MEMORIAFITADETALHE: String;
    FMIF_QTDLACREEXTERNO: Integer;
    FMIF_QTDLACREEXTERNOFABRICA: Integer;
    FMIF_LACREMEMORIAFITADETALHE: String;
    FMIF_DOCUMENTO: String;
    FMIF_DESATIVADO: String;
    FMIF_DATAALTERACAO: TDateTime;
  public 
    { Public declarations } 
     const Table      = 'MIF_00';
     const PrimaryKey = 'MIF_ID';
     const Sequence   = 'SEQ_MIF_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('MIF_ID', ftInteger)]
    [Dictionary('MIF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property MIF_ID: Integer read FMIF_ID write FMIF_ID;
    const MIF_ID_Name = 'MIF_ID';

    [Restrictions([NoValidate])]
    [Column('MIF_CODIGOMARCA', ftString, 2)]
    [Dictionary('MIF_CODIGOMARCA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MIF_CODIGOMARCA: String read FMIF_CODIGOMARCA write FMIF_CODIGOMARCA;
    const MIF_CODIGOMARCA_Name = 'MIF_CODIGOMARCA';

    [Restrictions([NoValidate])]
    [Column('MIF_CODIGOMODELO', ftString, 2)]
    [Dictionary('MIF_CODIGOMODELO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MIF_CODIGOMODELO: String read FMIF_CODIGOMODELO write FMIF_CODIGOMODELO;
    const MIF_CODIGOMODELO_Name = 'MIF_CODIGOMODELO';

    [Restrictions([NoValidate])]
    [Column('MIF_CODIGOVERSAO', ftString, 2)]
    [Dictionary('MIF_CODIGOVERSAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MIF_CODIGOVERSAO: String read FMIF_CODIGOVERSAO write FMIF_CODIGOVERSAO;
    const MIF_CODIGOVERSAO_Name = 'MIF_CODIGOVERSAO';

    [Restrictions([NoValidate])]
    [Column('MIF_TIPOECF', ftString, 6)]
    [Dictionary('MIF_TIPOECF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MIF_TIPOECF: String read FMIF_TIPOECF write FMIF_TIPOECF;
    const MIF_TIPOECF_Name = 'MIF_TIPOECF';

    [Restrictions([NoValidate])]
    [Column('MIF_MARCAECF', ftString, 30)]
    [Dictionary('MIF_MARCAECF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MIF_MARCAECF: String read FMIF_MARCAECF write FMIF_MARCAECF;
    const MIF_MARCAECF_Name = 'MIF_MARCAECF';

    [Restrictions([NoValidate])]
    [Column('MIF_MODELOECF', ftString, 30)]
    [Dictionary('MIF_MODELOECF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MIF_MODELOECF: String read FMIF_MODELOECF write FMIF_MODELOECF;
    const MIF_MODELOECF_Name = 'MIF_MODELOECF';

    [Restrictions([NoValidate])]
    [Column('MIF_VERSAOECF', ftString, 30)]
    [Dictionary('MIF_VERSAOECF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MIF_VERSAOECF: String read FMIF_VERSAOECF write FMIF_VERSAOECF;
    const MIF_VERSAOECF_Name = 'MIF_VERSAOECF';

    [Restrictions([NoValidate])]
    [Column('MIF_MEMORIAFITADETALHE', ftString, 1)]
    [Dictionary('MIF_MEMORIAFITADETALHE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MIF_MEMORIAFITADETALHE: String read FMIF_MEMORIAFITADETALHE write FMIF_MEMORIAFITADETALHE;
    const MIF_MEMORIAFITADETALHE_Name = 'MIF_MEMORIAFITADETALHE';

    [Restrictions([NoValidate])]
    [Column('MIF_QTDLACREEXTERNO', ftInteger)]
    [Dictionary('MIF_QTDLACREEXTERNO', 'Mensagem de validação', '0', '', '', taCenter)]
    property MIF_QTDLACREEXTERNO: Integer read FMIF_QTDLACREEXTERNO write FMIF_QTDLACREEXTERNO;
    const MIF_QTDLACREEXTERNO_Name = 'MIF_QTDLACREEXTERNO';

    [Restrictions([NoValidate])]
    [Column('MIF_QTDLACREEXTERNOFABRICA', ftInteger)]
    [Dictionary('MIF_QTDLACREEXTERNOFABRICA', 'Mensagem de validação', '0', '', '', taCenter)]
    property MIF_QTDLACREEXTERNOFABRICA: Integer read FMIF_QTDLACREEXTERNOFABRICA write FMIF_QTDLACREEXTERNOFABRICA;
    const MIF_QTDLACREEXTERNOFABRICA_Name = 'MIF_QTDLACREEXTERNOFABRICA';

    [Restrictions([NoValidate])]
    [Column('MIF_LACREMEMORIAFITADETALHE', ftString, 1)]
    [Dictionary('MIF_LACREMEMORIAFITADETALHE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MIF_LACREMEMORIAFITADETALHE: String read FMIF_LACREMEMORIAFITADETALHE write FMIF_LACREMEMORIAFITADETALHE;
    const MIF_LACREMEMORIAFITADETALHE_Name = 'MIF_LACREMEMORIAFITADETALHE';

    [Restrictions([NoValidate])]
    [Column('MIF_DOCUMENTO', ftString, 30)]
    [Dictionary('MIF_DOCUMENTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MIF_DOCUMENTO: String read FMIF_DOCUMENTO write FMIF_DOCUMENTO;
    const MIF_DOCUMENTO_Name = 'MIF_DOCUMENTO';

    [Restrictions([NoValidate])]
    [Column('MIF_DESATIVADO', ftString, 1)]
    [Dictionary('MIF_DESATIVADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property MIF_DESATIVADO: String read FMIF_DESATIVADO write FMIF_DESATIVADO;
    const MIF_DESATIVADO_Name = 'MIF_DESATIVADO';

    [Restrictions([NoValidate])]
    [Column('MIF_DATAALTERACAO', ftDateTime)]
    [Dictionary('MIF_DATAALTERACAO', 'Mensagem de validação', '', '', '', taCenter)]
    property MIF_DATAALTERACAO: TDateTime read FMIF_DATAALTERACAO write FMIF_DATAALTERACAO;
    const MIF_DATAALTERACAO_Name = 'MIF_DATAALTERACAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoMIF_00)

end.
