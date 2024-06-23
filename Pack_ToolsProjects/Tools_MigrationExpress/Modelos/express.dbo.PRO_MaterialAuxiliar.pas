unit express.dbo.PRO_MATERIALAUXILIAR;

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
  [Table('PRO_MaterialAuxiliar', '')]
  TDtoPRO_MaterialAuxiliar = class
  private
    { Private declarations } 
    FCPF_ID: Integer;
    FCOM_CODIGO: Integer;
    FPRO_CODIGO: Integer;
    FPRM_CODIGO: Integer;
    FPRM_DESCRICAO: String;
    FCPF_QTDCOMPOSICAO: Double;
    FSGM_CODIGO: String;
    FSGM_SIGLA: String;
    FGRP_CODIGO: Integer;
    FGRP_DESCRICAO: String;
    FLCZ_CODIGO: Integer;
    FLCZ_DESCRICAO: String;
  public 
    { Public declarations } 
     const Table      = 'PRO_MaterialAuxiliar';

    [Restrictions([NoValidate, NotNull])]
    [Column('CPF_ID', ftInteger)]
    [Dictionary('CPF_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CPF_ID: Integer read FCPF_ID write FCPF_ID;
    const CPF_ID_Name = 'CPF_ID';

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
    [Column('PRM_CODIGO', ftInteger)]
    [Dictionary('PRM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRM_CODIGO: Integer read FPRM_CODIGO write FPRM_CODIGO;
    const PRM_CODIGO_Name = 'PRM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('PRM_DESCRICAO', ftString, 100)]
    [Dictionary('PRM_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRM_DESCRICAO: String read FPRM_DESCRICAO write FPRM_DESCRICAO;
    const PRM_DESCRICAO_Name = 'PRM_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('CPF_QTDCOMPOSICAO', ftBCD, 18, 4)]
    [Dictionary('CPF_QTDCOMPOSICAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property CPF_QTDCOMPOSICAO: Double read FCPF_QTDCOMPOSICAO write FCPF_QTDCOMPOSICAO;
    const CPF_QTDCOMPOSICAO_Name = 'CPF_QTDCOMPOSICAO';

    [Restrictions([NoValidate])]
    [Column('SGM_CODIGO', ftString, 2)]
    [Dictionary('SGM_CODIGO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_CODIGO: String read FSGM_CODIGO write FSGM_CODIGO;
    const SGM_CODIGO_Name = 'SGM_CODIGO';

    [Restrictions([NoValidate])]
    [Column('SGM_SIGLA', ftString, 2)]
    [Dictionary('SGM_SIGLA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SGM_SIGLA: String read FSGM_SIGLA write FSGM_SIGLA;
    const SGM_SIGLA_Name = 'SGM_SIGLA';

    [Restrictions([NoValidate])]
    [Column('GRP_CODIGO', ftInteger)]
    [Dictionary('GRP_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property GRP_CODIGO: Integer read FGRP_CODIGO write FGRP_CODIGO;
    const GRP_CODIGO_Name = 'GRP_CODIGO';

    [Restrictions([NoValidate])]
    [Column('GRP_DESCRICAO', ftString, 50)]
    [Dictionary('GRP_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property GRP_DESCRICAO: String read FGRP_DESCRICAO write FGRP_DESCRICAO;
    const GRP_DESCRICAO_Name = 'GRP_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('LCZ_CODIGO', ftInteger)]
    [Dictionary('LCZ_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property LCZ_CODIGO: Integer read FLCZ_CODIGO write FLCZ_CODIGO;
    const LCZ_CODIGO_Name = 'LCZ_CODIGO';

    [Restrictions([NoValidate])]
    [Column('LCZ_DESCRICAO', ftString, 30)]
    [Dictionary('LCZ_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property LCZ_DESCRICAO: String read FLCZ_DESCRICAO write FLCZ_DESCRICAO;
    const LCZ_DESCRICAO_Name = 'LCZ_DESCRICAO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPRO_MaterialAuxiliar)

end.
