unit express.dbo.PALM_V01_PRZ;

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
  [Table('PALM_V01_PRZ', '')]
  TDtoPALM_V01_PRZ = class
  private
    { Private declarations } 
    FPRZ_CODIGO: Integer;
    FPRZ_DESCRICAO: String;
    FPRZ_NOMEAPELIDO: String;
    FPRZ_PERCENTUALFINANCEIRO: Double;
    FPRZ_PERCENTUALDESCONTO: Double;
  public 
    { Public declarations } 
     const Table      = 'PALM_V01_PRZ';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRZ_CODIGO', ftInteger)]
    [Dictionary('PRZ_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property PRZ_CODIGO: Integer read FPRZ_CODIGO write FPRZ_CODIGO;
    const PRZ_CODIGO_Name = 'PRZ_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRZ_DESCRICAO', ftString, 30)]
    [Dictionary('PRZ_DESCRICAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRZ_DESCRICAO: String read FPRZ_DESCRICAO write FPRZ_DESCRICAO;
    const PRZ_DESCRICAO_Name = 'PRZ_DESCRICAO';

    [Restrictions([NoValidate])]
    [Column('PRZ_NOMEAPELIDO', ftString, 10)]
    [Dictionary('PRZ_NOMEAPELIDO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property PRZ_NOMEAPELIDO: String read FPRZ_NOMEAPELIDO write FPRZ_NOMEAPELIDO;
    const PRZ_NOMEAPELIDO_Name = 'PRZ_NOMEAPELIDO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRZ_PERCENTUALFINANCEIRO', ftBCD, 48, 2)]
    [Dictionary('PRZ_PERCENTUALFINANCEIRO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRZ_PERCENTUALFINANCEIRO: Double read FPRZ_PERCENTUALFINANCEIRO write FPRZ_PERCENTUALFINANCEIRO;
    const PRZ_PERCENTUALFINANCEIRO_Name = 'PRZ_PERCENTUALFINANCEIRO';

    [Restrictions([NoValidate, NotNull])]
    [Column('PRZ_PERCENTUALDESCONTO', ftBCD)]
    [Dictionary('PRZ_PERCENTUALDESCONTO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property PRZ_PERCENTUALDESCONTO: Double read FPRZ_PERCENTUALDESCONTO write FPRZ_PERCENTUALDESCONTO;
    const PRZ_PERCENTUALDESCONTO_Name = 'PRZ_PERCENTUALDESCONTO';
  end;

implementation

initialization
  TRegisterClass.RegisterEntity(TDtoPALM_V01_PRZ)

end.
