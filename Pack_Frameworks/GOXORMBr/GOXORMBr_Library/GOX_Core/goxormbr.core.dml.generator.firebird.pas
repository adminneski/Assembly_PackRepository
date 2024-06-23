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

unit goxormbr.core.dml.generator.firebird;
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
  // Classe de banco de dados Firebird
  TDMLGeneratorFirebird = class(TDMLGeneratorCommandBase)
  protected
    function GetGeneratorSelect(const ACriteria: ICriteria): string; override;
  public
    constructor Create;
    destructor Destroy; override;
    function GeneratorSelectAll(AClass: TClass; APageSize: Integer; AID: Variant): string; override;
    function GeneratorSelectWhere(AClass: TClass; AWhere: string; AOrderBy: string; APageSize: Integer): string; override;
    function GeneratorAutoIncCurrentValue(AObject: TObject; AAutoInc: TDMLCommandAutoInc): Int64; override;
    function GeneratorAutoIncNextValue(AObject: TObject; AAutoInc: TDMLCommandAutoInc): Int64; override;
  end;
implementation
{ TDMLGeneratorFirebird }
constructor TDMLGeneratorFirebird.Create;
begin
  inherited;
  FDateFormat := 'MM/dd/yyyy';
  FTimeFormat := 'HH:MM:SS';
end;
destructor TDMLGeneratorFirebird.Destroy;
begin
  inherited;
end;
function TDMLGeneratorFirebird.GetGeneratorSelect(const ACriteria: ICriteria): string;
begin
  inherited;
  ACriteria.AST.Select
           .Columns
           .Columns[0].Name := 'FIRST %s SKIP %s ' + ACriteria.AST.Select
                                                              .Columns
                                                              .Columns[0].Name;
  Result := ACriteria.AsString;
end;
function TDMLGeneratorFirebird.GeneratorSelectAll(AClass: TClass;
  APageSize: Integer; AID: Variant): string;
var
  LCriteria: ICriteria;
  LTable: TTableMapping;
begin
  // Pesquisa se já existe o SQL padrão no cache, não tendo que montar toda vez
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
function TDMLGeneratorFirebird.GeneratorSelectWhere(AClass: TClass;

  AWhere: string; AOrderBy: string; APageSize: Integer): string;
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
function TDMLGeneratorFirebird.GeneratorAutoIncCurrentValue(AObject: TObject;

  AAutoInc: TDMLCommandAutoInc): Int64;

begin
  Result := ExecuteSequence(Format('SELECT GEN_ID(%s, 0) FROM RDB$DATABASE;',
                                   [AAutoInc.Sequence.Name]));
end;

function TDMLGeneratorFirebird.GeneratorAutoIncNextValue(AObject: TObject;

  AAutoInc: TDMLCommandAutoInc): Int64;

begin
  Result := ExecuteSequence(Format('SELECT GEN_ID(%s, %s) FROM RDB$DATABASE;',
                                   [AAutoInc.Sequence.Name,
                           IntToStr(AAutoInc.Sequence.Increment)]));
end;

end.
