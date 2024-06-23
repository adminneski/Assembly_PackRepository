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
unit goxormbr.core.command.abstract;

{$INCLUDE ..\goxorm.inc}

interface

uses
  system.SysUtils,
  DB,
  Rtti,
  {$IFDEF USE_ENGINE_DAC_FIREDAC}
   FireDAC.Comp.Client,
   FireDAC.Stan.Param,
  {$ENDIF}
  goxormbr.core.dml.generator.base,
  goxormbr.core.types;

type

  TDMLCommandAbstract = class
  protected
    FGOXORMEngine: TGOXDBConnection;
    FGeneratorCommand_SQLServer: TDMLGeneratorCommandBase;
    FGeneratorCommand_PostgreSQL: TDMLGeneratorCommandBase;
    FGeneratorCommand_Firebird: TDMLGeneratorCommandBase;
    FGeneratorCommand_SQLite: TDMLGeneratorCommandBase;
    //
    FGeneratorCommand: TDMLGeneratorCommandBase;

    FParams:{$IFDEF USE_ENGINE_DAC_FIREDAC}TParams{$ELSE}TParams{$ENDIF};

    FResultCommand: string;
  public
    constructor Create(AGOXORMEngine: TGOXDBConnection; ADriverType: TDriverType; AObject: TObject); virtual;
    destructor Destroy; override;
    function GetDMLCommand: string;
    function Params: {$IFDEF USE_ENGINE_DAC_FIREDAC}TParams{$ELSE}TParams{$ENDIF};
  end;

implementation

{ TDMLCommandAbstract }

uses   goxormbr.core.dml.generator.mssql,
       goxormbr.core.dml.generator.postgresql,
       goxormbr.core.dml.generator.sqlite,
       goxormbr.core.dml.generator.firebird;

constructor TDMLCommandAbstract.Create(AGOXORMEngine: TGOXDBConnection; ADriverType: TDriverType; AObject: TObject);
begin
  // Driver de Conexão
  FGOXORMEngine := AGOXORMEngine;
  // Driver do banco de dados
  FGeneratorCommand_SQLServer := TDMLGeneratorMSSql.Create;
  FGeneratorCommand_SQLServer.SetConnection(AGOXORMEngine);
  FGeneratorCommand_PostgreSQL  := TDMLGeneratorPostgreSQL.Create;
  FGeneratorCommand_PostgreSQL.SetConnection(AGOXORMEngine);
  FGeneratorCommand_Firebird  := TDMLGeneratorFirebird.Create;
  FGeneratorCommand_Firebird.SetConnection(AGOXORMEngine);
  FGeneratorCommand_SQLite    := TDMLGeneratorSQLite.Create;
  FGeneratorCommand_SQLite.SetConnection(AGOXORMEngine);

  if ADriverType = dnMSSQL then
  FGeneratorCommand := FGeneratorCommand_SQLServer
  else if ADriverType = dnPostgreSQL then
  FGeneratorCommand := FGeneratorCommand_PostgreSQL
  else if ADriverType = dnFirebird then
  FGeneratorCommand := FGeneratorCommand_Firebird
  else if ADriverType = dnSQLite then
  FGeneratorCommand := FGeneratorCommand_SQLite;

  // Lista de parâmetros
  FParams := {$IFDEF USE_ENGINE_DAC_FIREDAC}TParams.Create{$ELSE}TParams.Create{$ENDIF};
end;

destructor TDMLCommandAbstract.Destroy;
begin
  FreeAndNil(FGeneratorCommand_SQLServer);
  FreeAndNil(FGeneratorCommand_Firebird);
  FreeAndNil(FGeneratorCommand_PostgreSQL);
  FreeAndNil(FGeneratorCommand_SQLite);
  FGeneratorCommand := nil;
  FreeAndNil(FParams);
  inherited;
end;

function TDMLCommandAbstract.GetDMLCommand: string;
begin
  Result := FResultCommand;
end;

function TDMLCommandAbstract.Params:{$IFDEF USE_ENGINE_DAC_FIREDAC}TParams{$ELSE}TParams{$ENDIF};
begin
  Result := FParams;
end;

end.
