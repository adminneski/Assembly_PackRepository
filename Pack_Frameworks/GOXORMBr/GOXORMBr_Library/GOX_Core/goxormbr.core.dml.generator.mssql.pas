{******************************************************************************}
{                                  GOXORMBr                                    }
{                                                                              }
{  Um ORM simples que simplifica a persistência de dados, oferecendo           }
{  funcionalidades para mapear tabelas de banco de dados como objetos          }
{  relacionais, facilitando a manipulação e a gestão de dados.                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo no repositório abaixo         }
{  https://github.com/jeicksongobeti/goxormbr                                  }
{                                                                              }
{******************************************************************************}
{                   Copyright (c) 2016, Isaque Pinheiro                        }
{                            All rights reserved.                              }
{                                                                              }
{                   Copyright (c) 2020, Jeickson Gobeti                        }
{                          All Modifications Reserved.                         }
{                                                                              }
{                    GNU Lesser General Public License                         }
{                                                                              }
{  Esta biblioteca é software livre; você pode redistribuí-la e/ou modificá-la }
{ sob os termos da Licença Pública Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a versão 2.1 da Licença, ou (a seu critério) }
{ qualquer versão posterior.                                                   }
{                                                                              }
{  Esta biblioteca é distribuída na expectativa de que seja útil, porém, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia implícita de COMERCIABILIDADE OU      }
{ ADEQUAÇÃO A UMA FINALIDADE ESPECÍFICA. Consulte a Licença Pública Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICENÇA.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Você deve ter recebido uma cópia da Licença Pública Geral Menor do GNU junto}
{ com esta biblioteca; se não, escreva para a Free Software Foundation, Inc.,  }
{ no endereço 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Você também pode obter uma copia da licença em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{       Jeickson Gobeti - jeickson.gobeti@gmail.com - www.goxcode.com.br       }
{                                                                              }
{******************************************************************************}

unit goxormbr.core.dml.generator.mssql;
interface
uses
  Classes,
  SysUtils,
  StrUtils,
  Variants,
  Rtti,
  goxormbr.core.dml.generator.base,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.explorer,
//  goxormbr.core.dml.commands,
  goxormbr.core.criteria,
  goxormbr.core.types;
type
  TDMLGeneratorMSSql = class(TDMLGeneratorCommandBase)
  protected
    function GetGeneratorSelect(const ACriteria: ICriteria): string; override;
  public
    constructor Create;
    destructor Destroy; override;
    function GeneratorSelectAll(AClass: TClass; APageSize: Integer; AID: Variant): string; override;
    function GeneratorSelectWhere(AClass: TClass; AWhere: string; AOrderBy: string; APageSize: Integer): string; override;
    function GeneratorAutoIncCurrentValue(AObject: TObject; AAutoInc: TDMLCommandAutoInc): Int64; override;
    function GeneratorAutoIncNextValue(AObject: TObject; AAutoInc: TDMLCommandAutoInc): Int64; override;

    //function nova pacote
    function GeneratorSelectByPackage(AClass: TClass; const APageNumber:Integer; const ARowsByPage:Integer; const AWhere: String; AOrderBy: String):String; override;
    function GeneratorPackagePageCount(AClass: TClass; const AWhere: String; const ARowsByPage:Integer):String; override;

    function GeneratorPageNext(const ACommandSelect: string; APageSize, APageNext: Integer): string; override;
  end;
implementation

{ TDMLGeneratorMSSql }
constructor TDMLGeneratorMSSql.Create;
begin
  inherited;
  FDateFormat := 'dd/MM/yyyy';
  FTimeFormat := 'HH:MM:SS';
end;
destructor TDMLGeneratorMSSql.Destroy;
begin
  inherited;
end;
function TDMLGeneratorMSSql.GetGeneratorSelect(const ACriteria: ICriteria): string;
const
  cSQL = 'SELECT * FROM (%s) AS %s WHERE %s';
  cCOLUMN = 'ROW_NUMBER() OVER(ORDER BY CURRENT_TIMESTAMP) AS ROWNUMBER';
var
  LTable: String;
  LWhere: String;
begin
  inherited;
  LTable := ACriteria.AST.Select.TableNames.Columns[0].Name;
  LWhere := '(ROWNUMBER <= %s) AND (ROWNUMBER > %s)';
//  ACriteria.SelectSection(secSelect);
  ACriteria.Column(cCOLUMN);
  Result := Format(cSQL, [ACriteria.AsString, LTable, LWhere]);
end;

function TDMLGeneratorMSSql.GeneratorPackagePageCount(AClass: TClass; const AWhere: String; const ARowsByPage: Integer): String;
var
  LCriteria: ICriteria;
  LTable: TTableMapping;
  LPrimaryKey: TPrimaryKeyMapping;
begin
  LTable := TMappingExplorer.GetMappingTable(AClass);
  LPrimaryKey := TMappingExplorer.GetMappingPrimaryKey(AClass);
  //
  if LPrimaryKey <> nil then
  LCriteria := CreateCriteria.Select('COUNT('+LTable.Name + '.' + LPrimaryKey.Columns[0]+') PACKAGECOUNT').From(LTable.Name)
  else
  LCriteria := CreateCriteria.Select('COUNT(*) PACKAGECOUNT').From(LTable.Name);
  // Joins - INNERJOIN, LEFTJOIN, RIGHTJOIN, FULLJOIN
  GenerateJoinNoColumn(AClass, LTable, LCriteria);
  //
  Result :=  LCriteria.AsString;
  // Params Where
  if Length(AWhere) > 0 then
  begin
    Result := Result + ' WHERE ';
    Result := Result + AWhere;
  end;
end;

function TDMLGeneratorMSSql.GeneratorPageNext(const ACommandSelect: string; APageSize, APageNext: Integer): string;
begin
  if APageSize > -1 then
    Result := Format(ACommandSelect, [IntToStr(APageNext + APageSize), IntToStr(APageNext)])
  else
    Result := ACommandSelect;
end;

function TDMLGeneratorMSSql.GeneratorSelectAll(AClass: TClass; APageSize: Integer; AID: Variant): string;
var
  LCriteria: ICriteria;
  LTable: TTableMapping;
begin
  LCriteria := GetCriteriaSelect(AClass, AID);
  Result := LCriteria.AsString;
  // Atualiza o comando SQL com paginação e atualiza a lista de cache.
  if APageSize > -1 then
    Result := GetGeneratorSelect(LCriteria);
  //
  LTable := TMappingExplorer.GetMappingTable(AClass);
  // Where
  Result := Result + GetGeneratorWhere(AClass, LTable.Name, AID);
  // OrderBy
  Result := Result + GetGeneratorOrderBy(AClass, LTable.Name, AID);

end;

function TDMLGeneratorMSSql.GeneratorSelectByPackage(AClass: TClass; const APageNumber, ARowsByPage: Integer; const AWhere: String; AOrderBy: String): String;
var
  LCriteria: ICriteria;
  LScopeWhere: String;
  LScopeOrderBy: String;
  //
  LTable: TTableMapping;
  LPrimaryKey: TPrimaryKeyMapping;
  LColumnName: String;
begin
  LCriteria := GetCriteriaSelect(AClass, -1);
  Result := LCriteria.AsString;

  // Params Where and OrderBy
  if Length(AWhere) > 0 then
  begin
    Result := Result + ' WHERE ';
    Result := Result + AWhere;
  end;
  if Length(AOrderBy) > 0 then
  begin
    Result := Result + ' ORDER BY ';
    Result := Result + AOrderBy;
  end
  else
  begin
    //
    LTable := TMappingExplorer.GetMappingTable(AClass);
    LPrimaryKey := TMappingExplorer.GetMappingPrimaryKey(AClass);
    if LPrimaryKey <> nil then
    begin
      for var LFor := 0 to LPrimaryKey.Columns.Count -1 do
      begin
        if LFor > 0 then
          Continue;
        LColumnName := LTable.Name + '.' + LPrimaryKey.Columns[LFor];
      end;
      Result := Result + ' ORDER BY ';
      Result := Result + LColumnName;
    end;
    Result := Result + ' ORDER BY (SELECT NULL)';
  end;
  if ARowsByPage > 0 then
  begin
    Result := Result +' OFFSET '+IntToStr(((APageNumber - 1) * ARowsByPage))+' ROWS FETCH NEXT '+IntToStr(ARowsByPage)+' ROWS ONLY';
  end;

end;

function TDMLGeneratorMSSql.GeneratorSelectWhere(AClass: TClass; AWhere: string; AOrderBy: string; APageSize: Integer): string;
var
  LCriteria: ICriteria;
  LScopeWhere: String;
  LScopeOrderBy: String;
begin
  LCriteria := GetCriteriaSelect(AClass, -1);
  Result := LCriteria.AsString;
  // Atualiza o comando SQL com paginação e atualiza a lista de cache.
  if APageSize > -1 then
    Result := GetGeneratorSelect(LCriteria);
  //
//  // Scope
//  LScopeWhere := GetGeneratorQueryScopeWhere(AClass);
//  if LScopeWhere <> '' then
//    Result := ' WHERE ' + LScopeWhere;
//  LScopeOrderBy := GetGeneratorQueryScopeOrderBy(AClass);
//  if LScopeOrderBy <> '' then
//    Result := ' ORDER BY ' + LScopeOrderBy;

  // Params Where and OrderBy
  if Length(AWhere) > 0 then
  begin
    Result := Result + IfThen(LScopeWhere = '', ' WHERE ', ' AND ');
    Result := Result + AWhere;
  end;
  if Length(AOrderBy) > 0 then
  begin
    Result := Result + IfThen(LScopeOrderBy = '', ' ORDER BY ', ', ');
    Result := Result + AOrderBy;
  end;
end;
function TDMLGeneratorMSSql.GeneratorAutoIncCurrentValue(AObject: TObject; AAutoInc: TDMLCommandAutoInc): Int64;
begin
  Result := ExecuteSequence(Format('SELECT CURRENT_VALUE FROM SYS.SEQUENCES WHERE NAME = ''%s''',
                                   [AAutoInc.Sequence.Name+' SEQ']) );
end;

function TDMLGeneratorMSSql.GeneratorAutoIncNextValue(AObject: TObject; AAutoInc: TDMLCommandAutoInc): Int64;
begin
  Result := ExecuteSequence(Format('SELECT NEXT VALUE FOR %s ',
                                   [AAutoInc.Sequence.Name+' SEQ']));
end;

end.
