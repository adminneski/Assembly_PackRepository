unit express.dbo.ETQ_CHECKESTOQUEPROCESSADO;

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
  [Table('ETQ_CheckEstoqueProcessado', '')]
  TDtoETQ_CheckEstoqueProcessado = class
  private
    { Private declarations } 
    FETQ_SIGLA: String;
    FETQ_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FPRO_DESCRICAO: String;
    FETQ_QTDDIGITADA: Double;
  public 
    { Public declarations } 
     const Table      = 'ETQ_CheckEstoqueProcessado';

    [Restrictions([NoValidate, NotNull])]
    [Column('ETQ_SIGLA', ftString, 6)]
    [Dictionary('ETQ_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property ETQ_SIGLA: String read FETQ_SIGLA write FETQ_SIGLA;
    const ETQ_SIGLA_Name = 'ETQ_SIGLA';

    [Restrictions([NoValidate])]
    [Column('ETQ_ID', ftInteger)]
    [Dictionary('ETQ_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property ETQ_ID: Integer read FETQ_ID write FETQ_ID;
    const ETQ_ID_Name = 'ETQ_ID';

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
    [Column('ETQ_QTDDIGITADA', ftBCD)]
    [Dictionary('ETQ_QTDDIGITADA', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property ETQ_QTDDIGITADA: Double read FETQ_QTDDIGITADA write FETQ_QTDDIGITADA;
    const ETQ_QTDDIGITADA_Name = 'ETQ_QTDDIGITADA';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoETQ_CheckEstoqueProcessado)

end.
