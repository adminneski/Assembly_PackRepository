unit express.dbo.PES_00_02;

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
  [Table('PES_00_02', '')]
  [PrimaryKey('PES_CODIGO', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_PES_CODIGO')]
  TDtoPES_00_02 = class
  private
    { Private declarations } 
    FPES_CODIGO: Integer;
    FPES_TIPOCOMISSAO: String;
    FPES_PERCENTUALCOMISSAO: Double;
    FPES_PERCENTUALDESCTOPERMITIDO: Double;
    FPES_PERCENTUALAJUDACUSTO: Double;
    FPES_PERCENTUALCOMISSAOTECNICO: Double;
    FPES_ENVIAPALMVND: String;
    FPES_VALORSALARIO: Double;
    FPES_FUNCAO: String;
    FPES_DATAADMISSAO: TDateTime;
    FPES_DATADEMISSAO: TDateTime;
    FPES_DATAULTIMOEXAME: TDateTime;
    FPES_ULTIMOEXAME: String;
    FPES_TAMANHOUNIFORME: String;
    FPES_DATAENTREGAUNIFORME: TDateTime;
    FPES_USUARIOVINCULADO: String;
    FPES_DATAALTERACAO: TDateTime;
    FCOM_CODIGO: Integer;
  public 
    { Public declarations } 
     const Table      = 'PES_00_02';
     const PrimaryKey = 'PES_CODIGO';
     const Sequence   = 'SEQ_PES_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_TIPOCOMISSAO', ftString, 1)]
    [Dictionary('PES_TIPOCOMISSAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TIPOCOMISSAO: String read FPES_TIPOCOMISSAO write FPES_TIPOCOMISSAO;
    const PES_TIPOCOMISSAO_Name = 'PES_TIPOCOMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_PERCENTUALCOMISSAO', ftBCD, 5177428, 2)]
    [Dictionary('PES_PERCENTUALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PES_PERCENTUALCOMISSAO: Double read FPES_PERCENTUALCOMISSAO write FPES_PERCENTUALCOMISSAO;
    const PES_PERCENTUALCOMISSAO_Name = 'PES_PERCENTUALCOMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_PERCENTUALDESCTOPERMITIDO', ftBCD, 1952531540, 2)]
    [Dictionary('PES_PERCENTUALDESCTOPERMITIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PES_PERCENTUALDESCTOPERMITIDO: Double read FPES_PERCENTUALDESCTOPERMITIDO write FPES_PERCENTUALDESCTOPERMITIDO;
    const PES_PERCENTUALDESCTOPERMITIDO_Name = 'PES_PERCENTUALDESCTOPERMITIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_PERCENTUALAJUDACUSTO', ftBCD, 1981834596, 2)]
    [Dictionary('PES_PERCENTUALAJUDACUSTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PES_PERCENTUALAJUDACUSTO: Double read FPES_PERCENTUALAJUDACUSTO write FPES_PERCENTUALAJUDACUSTO;
    const PES_PERCENTUALAJUDACUSTO_Name = 'PES_PERCENTUALAJUDACUSTO';

    [Restrictions([NoValidate])]
    [Column('PES_PERCENTUALCOMISSAOTECNICO', ftBCD, 7077999, 2)]
    [Dictionary('PES_PERCENTUALCOMISSAOTECNICO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PES_PERCENTUALCOMISSAOTECNICO: Double read FPES_PERCENTUALCOMISSAOTECNICO write FPES_PERCENTUALCOMISSAOTECNICO;
    const PES_PERCENTUALCOMISSAOTECNICO_Name = 'PES_PERCENTUALCOMISSAOTECNICO';

    [Restrictions([NoValidate])]
    [Column('PES_ENVIAPALMVND', ftString, 1)]
    [Dictionary('PES_ENVIAPALMVND', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ENVIAPALMVND: String read FPES_ENVIAPALMVND write FPES_ENVIAPALMVND;
    const PES_ENVIAPALMVND_Name = 'PES_ENVIAPALMVND';

    [Restrictions([NoValidate])]
    [Column('PES_VALORSALARIO', ftBCD, 2097273, 2)]
    [Dictionary('PES_VALORSALARIO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PES_VALORSALARIO: Double read FPES_VALORSALARIO write FPES_VALORSALARIO;
    const PES_VALORSALARIO_Name = 'PES_VALORSALARIO';

    [Restrictions([NoValidate])]
    [Column('PES_FUNCAO', ftString, 100)]
    [Dictionary('PES_FUNCAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_FUNCAO: String read FPES_FUNCAO write FPES_FUNCAO;
    const PES_FUNCAO_Name = 'PES_FUNCAO';

    [Restrictions([NoValidate])]
    [Column('PES_DATAADMISSAO', ftDateTime)]
    [Dictionary('PES_DATAADMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property PES_DATAADMISSAO: TDateTime read FPES_DATAADMISSAO write FPES_DATAADMISSAO;
    const PES_DATAADMISSAO_Name = 'PES_DATAADMISSAO';

    [Restrictions([NoValidate])]
    [Column('PES_DATADEMISSAO', ftDateTime)]
    [Dictionary('PES_DATADEMISSAO', 'Mensagem de validação', '', '', '', taCenter)]
    property PES_DATADEMISSAO: TDateTime read FPES_DATADEMISSAO write FPES_DATADEMISSAO;
    const PES_DATADEMISSAO_Name = 'PES_DATADEMISSAO';

    [Restrictions([NoValidate])]
    [Column('PES_DATAULTIMOEXAME', ftDateTime)]
    [Dictionary('PES_DATAULTIMOEXAME', 'Mensagem de validação', '', '', '', taCenter)]
    property PES_DATAULTIMOEXAME: TDateTime read FPES_DATAULTIMOEXAME write FPES_DATAULTIMOEXAME;
    const PES_DATAULTIMOEXAME_Name = 'PES_DATAULTIMOEXAME';

    [Restrictions([NoValidate])]
    [Column('PES_ULTIMOEXAME', ftString, 1)]
    [Dictionary('PES_ULTIMOEXAME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_ULTIMOEXAME: String read FPES_ULTIMOEXAME write FPES_ULTIMOEXAME;
    const PES_ULTIMOEXAME_Name = 'PES_ULTIMOEXAME';

    [Restrictions([NoValidate])]
    [Column('PES_TAMANHOUNIFORME', ftString, 10)]
    [Dictionary('PES_TAMANHOUNIFORME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_TAMANHOUNIFORME: String read FPES_TAMANHOUNIFORME write FPES_TAMANHOUNIFORME;
    const PES_TAMANHOUNIFORME_Name = 'PES_TAMANHOUNIFORME';

    [Restrictions([NoValidate])]
    [Column('PES_DATAENTREGAUNIFORME', ftDateTime)]
    [Dictionary('PES_DATAENTREGAUNIFORME', 'Mensagem de validação', '', '', '', taCenter)]
    property PES_DATAENTREGAUNIFORME: TDateTime read FPES_DATAENTREGAUNIFORME write FPES_DATAENTREGAUNIFORME;
    const PES_DATAENTREGAUNIFORME_Name = 'PES_DATAENTREGAUNIFORME';

    [Restrictions([NoValidate])]
    [Column('PES_USUARIOVINCULADO', ftString, 250)]
    [Dictionary('PES_USUARIOVINCULADO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_USUARIOVINCULADO: String read FPES_USUARIOVINCULADO write FPES_USUARIOVINCULADO;
    const PES_USUARIOVINCULADO_Name = 'PES_USUARIOVINCULADO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_DATAALTERACAO', ftDateTime)]
    [Dictionary('PES_DATAALTERACAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property PES_DATAALTERACAO: TDateTime read FPES_DATAALTERACAO write FPES_DATAALTERACAO;
    const PES_DATAALTERACAO_Name = 'PES_DATAALTERACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPES_00_02)

end.
