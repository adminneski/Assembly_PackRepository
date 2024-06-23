unit express.dbo.COMPANY_LICENSE;

interface

uses
  DB, 
  Classes, 
  SysUtils, 
  Generics.Collections, 

  //goxormbr 
  express.dbo.company,
  goxormbr.core.types.blob,
  goxormbr.core.types.mapping,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.register,
  goxormbr.core.mapping.attributes;

type
  [Entity]
  [Table('COMPANY_LICENSE', '')]
  [PrimaryKey('COM_01_ID', AutoInc, NoSort, False, 'Chave primária')]
  [Sequence('SEQ_COM_01_ID')]
  TDtoCOMPANY_LICENSE = class
  private
    { Private declarations } 
    FCOM_01_ID: Integer;
    FCOM_CODIGO: Integer;
    FCOM_CNPJ_CPF: String;
    FSER_CODIGO: Integer;
    FSER_CHAVE: String;
    FCOM_MODELOLICENCA: String;
    FCOM_VALORCONTRATOMANUTENCAO: Double;
    FCOM_DATACONTRATOMANUTENCAO: TDateTime;
    FCOM_DIASVALIDADECONTRATOMANUTENCAO: Integer;
    FCOM_DATAATIVACAOCONTRATOMANUTENCAO: TDateTime;
    FCOM_USUARIOSIMULTANEO: Integer;
    FCOM_LICENCAMANUTENCAO: String;
    FCOM_DATAHORAULTIMOACESSO: TDateTime;
    FCOM_LICENCAAPROVADA: String;
    FCOM_STATUSLICENCA: String;
    FCART_ID: Integer;

    FCOMPANY_0:  TCOMPANY  ;
  public 
    { Public declarations } 
    constructor Create;
    destructor Destroy; override;

     const Table      = 'COMPANY_LICENSE';
     const PrimaryKey = 'COM_01_ID';
     const Sequence   = 'SEQ_COM_01_ID';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_01_ID', ftInteger)]
    [Dictionary('COM_01_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_01_ID: Integer read FCOM_01_ID write FCOM_01_ID;
    const COM_01_ID_Name = 'COM_01_ID';

    [Restrictions([NoValidate])]
    [Column('COM_CODIGO', ftInteger)]
    [ForeignKey('COMPANY_LICENSE_fk', 'COM_CODIGO', 'COMPANY', 'COM_CODIGO', SetNull, SetNull)]
    [Dictionary('COM_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_CODIGO: Integer read FCOM_CODIGO write FCOM_CODIGO;
    const COM_CODIGO_Name = 'COM_CODIGO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_CNPJ_CPF', ftString, 14)]
    [Dictionary('COM_CNPJ_CPF', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_CNPJ_CPF: String read FCOM_CNPJ_CPF write FCOM_CNPJ_CPF;
    const COM_CNPJ_CPF_Name = 'COM_CNPJ_CPF';

    [Restrictions([NoValidate, NotNull])]
    [Column('SER_CODIGO', ftInteger)]
    [Dictionary('SER_CODIGO', 'Mensagem de validação', '0', '', '', taCenter)]
    property SER_CODIGO: Integer read FSER_CODIGO write FSER_CODIGO;
    const SER_CODIGO_Name = 'SER_CODIGO';

    [Restrictions([NoValidate])]
    [Column('SER_CHAVE', ftString, 30)]
    [Dictionary('SER_CHAVE', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property SER_CHAVE: String read FSER_CHAVE write FSER_CHAVE;
    const SER_CHAVE_Name = 'SER_CHAVE';

    [Restrictions([NoValidate])]
    [Column('COM_MODELOLICENCA', ftString, 5)]
    [Dictionary('COM_MODELOLICENCA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_MODELOLICENCA: String read FCOM_MODELOLICENCA write FCOM_MODELOLICENCA;
    const COM_MODELOLICENCA_Name = 'COM_MODELOLICENCA';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_VALORCONTRATOMANUTENCAO', ftBCD)]
    [Dictionary('COM_VALORCONTRATOMANUTENCAO', 'Mensagem de validação', '0', '', '', taRightJustify)]
    property COM_VALORCONTRATOMANUTENCAO: Double read FCOM_VALORCONTRATOMANUTENCAO write FCOM_VALORCONTRATOMANUTENCAO;
    const COM_VALORCONTRATOMANUTENCAO_Name = 'COM_VALORCONTRATOMANUTENCAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_DATACONTRATOMANUTENCAO', ftDateTime)]
    [Dictionary('COM_DATACONTRATOMANUTENCAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property COM_DATACONTRATOMANUTENCAO: TDateTime read FCOM_DATACONTRATOMANUTENCAO write FCOM_DATACONTRATOMANUTENCAO;
    const COM_DATACONTRATOMANUTENCAO_Name = 'COM_DATACONTRATOMANUTENCAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_DIASVALIDADECONTRATOMANUTENCAO', ftInteger)]
    [Dictionary('COM_DIASVALIDADECONTRATOMANUTENCAO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_DIASVALIDADECONTRATOMANUTENCAO: Integer read FCOM_DIASVALIDADECONTRATOMANUTENCAO write FCOM_DIASVALIDADECONTRATOMANUTENCAO;
    const COM_DIASVALIDADECONTRATOMANUTENCAO_Name = 'COM_DIASVALIDADECONTRATOMANUTENCAO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_DATAATIVACAOCONTRATOMANUTENCAO', ftDateTime)]
    [Dictionary('COM_DATAATIVACAOCONTRATOMANUTENCAO', 'Mensagem de validação', 'Date', '', '!##/##/####;1;_', taCenter)]
    property COM_DATAATIVACAOCONTRATOMANUTENCAO: TDateTime read FCOM_DATAATIVACAOCONTRATOMANUTENCAO write FCOM_DATAATIVACAOCONTRATOMANUTENCAO;
    const COM_DATAATIVACAOCONTRATOMANUTENCAO_Name = 'COM_DATAATIVACAOCONTRATOMANUTENCAO';

    [Restrictions([NoValidate])]
    [Column('COM_USUARIOSIMULTANEO', ftInteger)]
    [Dictionary('COM_USUARIOSIMULTANEO', 'Mensagem de validação', '0', '', '', taCenter)]
    property COM_USUARIOSIMULTANEO: Integer read FCOM_USUARIOSIMULTANEO write FCOM_USUARIOSIMULTANEO;
    const COM_USUARIOSIMULTANEO_Name = 'COM_USUARIOSIMULTANEO';

    [Restrictions([NoValidate])]
    [Column('COM_LICENCAMANUTENCAO', ftString, 1)]
    [Dictionary('COM_LICENCAMANUTENCAO', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_LICENCAMANUTENCAO: String read FCOM_LICENCAMANUTENCAO write FCOM_LICENCAMANUTENCAO;
    const COM_LICENCAMANUTENCAO_Name = 'COM_LICENCAMANUTENCAO';

    [Restrictions([NoValidate])]
    [Column('COM_DATAHORAULTIMOACESSO', ftDateTime)]
    [Dictionary('COM_DATAHORAULTIMOACESSO', 'Mensagem de validação', '', '', '', taCenter)]
    property COM_DATAHORAULTIMOACESSO: TDateTime read FCOM_DATAHORAULTIMOACESSO write FCOM_DATAHORAULTIMOACESSO;
    const COM_DATAHORAULTIMOACESSO_Name = 'COM_DATAHORAULTIMOACESSO';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_LICENCAAPROVADA', ftString, 1)]
    [Dictionary('COM_LICENCAAPROVADA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_LICENCAAPROVADA: String read FCOM_LICENCAAPROVADA write FCOM_LICENCAAPROVADA;
    const COM_LICENCAAPROVADA_Name = 'COM_LICENCAAPROVADA';

    [Restrictions([NoValidate, NotNull])]
    [Column('COM_STATUSLICENCA', ftString, 1)]
    [Dictionary('COM_STATUSLICENCA', 'Mensagem de validação', '', '', '', taLeftJustify)]
    property COM_STATUSLICENCA: String read FCOM_STATUSLICENCA write FCOM_STATUSLICENCA;
    const COM_STATUSLICENCA_Name = 'COM_STATUSLICENCA';

    [Restrictions([NoValidate, NotNull])]
    [Column('CART_ID', ftInteger)]
    [Dictionary('CART_ID', 'Mensagem de validação', '0', '', '', taCenter)]
    property CART_ID: Integer read FCART_ID write FCART_ID;
    const CART_ID_Name = 'CART_ID';

    [Association(OneToOne,'COM_CODIGO','COMPANY','COM_CODIGO')]
    property COMPANY: TCOMPANY read FCOMPANY_0 write FCOMPANY_0;

  end;

implementation

constructor TCOMPANY_LICENSE.Create;
begin
  FCOMPANY_0 := TCOMPANY.Create;
end;

destructor TCOMPANY_LICENSE.Destroy;
begin
  if Assigned(FCOMPANY_0) then
    FCOMPANY_0.Free;

  inherited;
end;

initialization
  TRegisterClass.RegisterEntity(TDtoCOMPANY_LICENSE)

end.
