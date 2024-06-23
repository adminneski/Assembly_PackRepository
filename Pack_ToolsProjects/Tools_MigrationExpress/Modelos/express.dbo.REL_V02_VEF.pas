unit express.dbo.REL_V02_VEF;

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
  [Table('REL_V02_VEF', '')]
  TDtoREL_V02_VEF = class
  private
    { Private declarations } 
    FVEF_ORDEM: Integer;
    FVEF_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FPRO_DESCRICAO: String;
    FVEF_NUMERODOCTO: String;
    FVEF_DATALANCAMENTO: TDateTime;
    FVEF_OBSERVACAO: String;
    FPES_CODIGO: Integer;
    FPES_NOME: String;
    FVND_CODIGO: Integer;
    FVND_NOME: String;
    FVEF_TOTALLIQUIDO: Double;
    FVEF_TOTALCOMISSAO: Double;
    FVEF_PERCENTUALCOMISSAO: Double;
    FVEF_TIPOPAGTOCOMISSAO: String;
  public 
    { Public declarations } 
     const Table      = 'REL_V02_VEF';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_ORDEM', ftInteger)]
    [Dictionary('VEF_ORDEM', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEF_ORDEM: Integer read FVEF_ORDEM write FVEF_ORDEM;
    const VEF_ORDEM_Name = 'VEF_ORDEM';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_ID', ftInteger)]
    [Dictionary('VEF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property VEF_ID: Integer read FVEF_ID write FVEF_ID;
    const VEF_ID_Name = 'VEF_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CODIGO', ftInteger)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRO_CODIGO', ftInteger)]
    [Dictionary('PRO_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRO_CODIGO: Integer read FPRO_CODIGO write FPRO_CODIGO;
    const PRO_CODIGO_Name = 'PRO_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRO_DESCRICAO', ftString, 100)]
    [Dictionary('PRO_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRO_DESCRICAO: String read FPRO_DESCRICAO write FPRO_DESCRICAO;
    const PRO_DESCRICAO_Name = 'PRO_DESCRICAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_NUMERODOCTO', ftString, 10)]
    [Dictionary('VEF_NUMERODOCTO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_NUMERODOCTO: String read FVEF_NUMERODOCTO write FVEF_NUMERODOCTO;
    const VEF_NUMERODOCTO_Name = 'VEF_NUMERODOCTO';

    [Restrictions([NoValidate])]
    [Column('VEF_DATALANCAMENTO', ftDateTime)]
    [Dictionary('VEF_DATALANCAMENTO', 'Mensagem de validação', '', '', '', taCenter)]
    property VEF_DATALANCAMENTO: TDateTime read FVEF_DATALANCAMENTO write FVEF_DATALANCAMENTO;
    const VEF_DATALANCAMENTO_Name = 'VEF_DATALANCAMENTO';

    [Restrictions([NoValidate])]
    [Column('VEF_OBSERVACAO', ftString, 5000)]
    [Dictionary('VEF_OBSERVACAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_OBSERVACAO: String read FVEF_OBSERVACAO write FVEF_OBSERVACAO;
    const VEF_OBSERVACAO_Name = 'VEF_OBSERVACAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PES_CODIGO', ftInteger)]
    [Dictionary('PES_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PES_CODIGO: Integer read FPES_CODIGO write FPES_CODIGO;
    const PES_CODIGO_Name = 'PES_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PES_NOME', ftString, 100)]
    [Dictionary('PES_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PES_NOME: String read FPES_NOME write FPES_NOME;
    const PES_NOME_Name = 'PES_NOME';

    [Restrictions([NoValidate, NotNull])]
    [Column('VND_CODIGO', ftInteger)]
    [Dictionary('VND_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property VND_CODIGO: Integer read FVND_CODIGO write FVND_CODIGO;
    const VND_CODIGO_Name = 'VND_CODIGO';

    [Restrictions([NoValidate])]
    [Column('VND_NOME', ftString, 100)]
    [Dictionary('VND_NOME', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VND_NOME: String read FVND_NOME write FVND_NOME;
    const VND_NOME_Name = 'VND_NOME';

    [Restrictions([NoValidate])]
    [Column('VEF_TOTALLIQUIDO', ftBCD, 48, 6)]
    [Dictionary('VEF_TOTALLIQUIDO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_TOTALLIQUIDO: Double read FVEF_TOTALLIQUIDO write FVEF_TOTALLIQUIDO;
    const VEF_TOTALLIQUIDO_Name = 'VEF_TOTALLIQUIDO';

    [Restrictions([NoValidate])]
    [Column('VEF_TOTALCOMISSAO', ftBCD)]
    [Dictionary('VEF_TOTALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_TOTALCOMISSAO: Double read FVEF_TOTALCOMISSAO write FVEF_TOTALCOMISSAO;
    const VEF_TOTALCOMISSAO_Name = 'VEF_TOTALCOMISSAO';

    [Restrictions([NoValidate])]
    [Column('VEF_PERCENTUALCOMISSAO', ftBCD)]
    [Dictionary('VEF_PERCENTUALCOMISSAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property VEF_PERCENTUALCOMISSAO: Double read FVEF_PERCENTUALCOMISSAO write FVEF_PERCENTUALCOMISSAO;
    const VEF_PERCENTUALCOMISSAO_Name = 'VEF_PERCENTUALCOMISSAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('VEF_TIPOPAGTOCOMISSAO', ftString, 3)]
    [Dictionary('VEF_TIPOPAGTOCOMISSAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property VEF_TIPOPAGTOCOMISSAO: String read FVEF_TIPOPAGTOCOMISSAO write FVEF_TIPOPAGTOCOMISSAO;
    const VEF_TIPOPAGTOCOMISSAO_Name = 'VEF_TIPOPAGTOCOMISSAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoREL_V02_VEF)

end.
