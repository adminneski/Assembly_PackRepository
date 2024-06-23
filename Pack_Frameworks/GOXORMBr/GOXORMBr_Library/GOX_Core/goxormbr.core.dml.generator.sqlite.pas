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

unit goxormbr.core.dml.generator.sqlite;
interface
uses
  Classes,
  SysUtils,
  StrUtils,
  Variants,
  Rtti,
  goxormbr.core.dml.generator.base,
//  goxormbr.core.dml.commands,
  goxormbr.core.criteria,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.explorer,
  goxormbr.core.types;
type
  // Classe de conexão concreta com dbExpress
  TDMLGeneratorSQLite = class(TDMLGeneratorCommandBase)
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
{ TDMLGeneratorSQLite }
constructor TDMLGeneratorSQLite.Create;
begin
  inherited;
  FDateFormat := 'yyyy-MM-dd';
  FTimeFormat := 'HH:MM:SS';
end;
destructor TDMLGeneratorSQLite.Destroy;
begin
  inherited;
end;
function TDMLGeneratorSQLite.GeneratorSelectAll(AClass: TClass;
  APageSize: Integer; AID: Variant): string;
var
  LCriteria: ICriteria;
  LTable: TTableMapping;
begin
  LCriteria := GetCriteriaSelect(AClass, AID);
  Result := LCriteria.AsString;
  //
  LTable := TMappingExplorer.GetMappingTable(AClass);
  // Where
  Result := Result + GetGeneratorWhere(AClass, LTable.Name, AID);
  // OrderBy
  Result := Result + GetGeneratorOrderBy(AClass, LTable.Name, AID);
  // Monta SQL para paginação
  if APageSize > -1 then
    Result := Result + GetGeneratorSelect(LCriteria);
end;
function TDMLGeneratorSQLite.GeneratorSelectWhere(AClass: TClass;

  AWhere: string; AOrderBy: string; APageSize: Integer): string;
var
  LCriteria: ICriteria;
  LScopeWhere: String;
  LScopeOrderBy: String;
begin
  LCriteria := GetCriteriaSelect(AClass, -1);
  Result := LCriteria.AsString;
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
  // Monta SQL para paginação
  if APageSize > -1 then
    Result := Result + GetGeneratorSelect(LCriteria);
end;
function TDMLGeneratorSQLite.GetGeneratorSelect(const ACriteria: ICriteria): string;

begin
  Result := ' LIMIT %s OFFSET %s';
end;

function TDMLGeneratorSQLite.GeneratorAutoIncCurrentValue(AObject: TObject;

  AAutoInc: TDMLCommandAutoInc): Int64;

var
  LSQL: String;
begin
  Result := ExecuteSequence(Format('SELECT SEQ AS SEQUENCE FROM SQLITE_SEQUENCE ' +
                                   'WHERE NAME = ''%s''', [AAutoInc.Sequence.Name]));
  if Result = 0 then
  begin
    LSQL := Format('INSERT INTO SQLITE_SEQUENCE (NAME, SEQ) VALUES (''%s'', 0)',
                   [AAutoInc.Sequence.Name]);
    FGOXORMEngine.ExecSQL(LSQL);
  end;
end;

function TDMLGeneratorSQLite.GeneratorAutoIncNextValue(AObject: TObject;

  AAutoInc: TDMLCommandAutoInc): Int64;

var
  LSQL: String;
begin
  Result := GeneratorAutoIncCurrentValue(AObject, AAutoInc);
  LSQL := Format('UPDATE SQLITE_SEQUENCE SET SEQ = SEQ + %s WHERE NAME = ''%s''',
                 [IntToStr(AAutoInc.Sequence.Increment), AAutoInc.Sequence.Name]);
  FGOXORMEngine.ExecSQL(LSQL);
  Result := Result + AAutoInc.Sequence.Increment;
end;


end.
