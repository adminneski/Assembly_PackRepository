{******************************************************************************}
{                                  GOXORMBr                                     }
{                                                                              }
{  Um ORM simples que simplifica a persistência de dados, oferecendo           }
{  funcionalidades para mapear tabelas de banco de dados como objetos          }
{  relacionais, facilitando a manipulação e a gestão de dados.                 }
{                                                                              }
{  Você pode obter a última versão desse arquivo no repositório abaixo         }
{  https://github.com/jeicksongobeti/goxormbr                                   }
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


unit goxormbr.engine.dbconnection.firedac;
interface
uses
  Classes,
  sysutils,
  DB,
  Variants,
  StrUtils,
  //FireDAC
  FireDAC.Comp.Client,
  FireDAC.Comp.Script,
  FireDAC.Comp.ScriptCommands,
  FireDAC.DApt,
  FireDAC.Stan.Param,
  FireDAC.Stan.Option,
  //GOXORM
  goxormbr.core.types;

type

  // DBConnection
  TGOXDBConnectionFireDAC = class(TGOXDBConnection)
  private
    FSQLScript: TFDScript;
  protected
    FDriverType: TDriverType;

  public
    constructor Create(const AOwner: TComponent; const ADriverType: TDriverType);
    destructor Destroy; override;
    procedure Connect; override;
    procedure Disconnect; override;
    function IsConnected: Boolean; override;
    procedure ExecuteSQL(const ASQL: string); overload; override;
    procedure ExecuteSQL(const ASQL: string; const AParams: TParams); overload; override;

   //    function CreateQuery: IGOXDBQuery; override;
    function OpenSQL(const ASQL: string): TGOXDBQuery; override;
    function CreateGOXDBQuery(const ASQL: string = ''): TGOXDBQuery; override;
    function DriverType: TDriverType; override;
  end;
  //

implementation


{ TGOXDBConnectionFireDAC }

procedure TGOXDBConnectionFireDAC.Connect;
begin
  inherited;
  Self.Connected := true;
end;

constructor TGOXDBConnectionFireDAC.Create(const AOwner: TComponent; const ADriverType: TDriverType);
begin
  inherited Create(AOwner);
//  FFDConnection := (AConnection as TFDConnection);
//  FDriverName := ADriverName;
  FSQLScript := TFDScript.Create(nil);
  try
    FSQLScript.Connection := Self;
    FSQLScript.SQLScripts.Add;
    FSQLScript.ScriptOptions.Reset;
    FSQLScript.ScriptOptions.BreakOnError := True;
    FSQLScript.ScriptOptions.RaisePLSQLErrors := True;
    FSQLScript.ScriptOptions.EchoCommands := ecAll;
    FSQLScript.ScriptOptions.CommandSeparator := ';';
    FSQLScript.ScriptOptions.CommitEachNCommands := 9999999;
    FSQLScript.ScriptOptions.DropNonexistObj := True;
  except
    FSQLScript.Free;
    raise;
  end;
end;

function TGOXDBConnectionFireDAC.CreateGOXDBQuery(const ASQL: string): TGOXDBQuery;
var
  LDBQuery: TGOXDBQuery;
begin
  try
   LDBQuery  := TGOXDBQuery.Create(Self);
   LDBQuery.Connection := Self;
   LDBQuery.FetchOptions.Mode := fmAll;
   LDBQuery.SQL.Text := ASQL;
   LDBQuery.Open;
   Result := LDBQuery;

//    Result := TGOXDBQuery.Create(Self);
//    Result.Connection := Self;
//    Result.SQL.Text := ASQL;//ASQL;
//    Result.Open;
  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;

//function TGOXDBConnectionFireDAC.CreateQuery: IGOXDBQuery;
//begin
//  Result := TGOXDBQueryFireDAC.Create(FFDConnection);
//end;

destructor TGOXDBConnectionFireDAC.Destroy;
begin
  FreeAndNil(FSQLScript);
  inherited;
end;


procedure TGOXDBConnectionFireDAC.Disconnect;
begin
  inherited;
  Self.Connected := False;
end;

procedure TGOXDBConnectionFireDAC.ExecuteSQL(const ASQL: string);
begin
   Self.ExecSQL(ASQL);
end;

procedure TGOXDBConnectionFireDAC.ExecuteSQL(const ASQL: string; const AParams: TParams);
var
  LExeSQL: TFDQuery;
  LFor: Integer;
begin
  LExeSQL := TFDQuery.Create(nil);
  try
    LExeSQL.Connection := Self;
    LExeSQL.SQL.Text   := ASQL;
    for LFor := 0 to AParams.Count - 1 do
    begin
      LExeSQL.ParamByName(AParams[LFor].Name).DataType := AParams[LFor].DataType;
      LExeSQL.ParamByName(AParams[LFor].Name).Value := AParams[LFor].Value;
    end;
    try
      LExeSQL.Prepare;
      LExeSQL.ExecSQL;
    except
      raise;
    end;
  finally
    LExeSQL.Free;
  end;
end;


function TGOXDBConnectionFireDAC.IsConnected: Boolean;
begin
  Result := Self.Connected;
end;

function TGOXDBConnectionFireDAC.DriverType: TDriverType;
begin
  Result := FDriverType;
end;

function TGOXDBConnectionFireDAC.OpenSQL(const ASQL: string): TGOXDBQuery;
var
  LDBQuery: TGOXDBQuery;
begin
  try
    LDBQuery := TGOXDBQuery.Create(Self);
    LDBQuery.Connection := Self;
    LDBQuery.FetchOptions.Mode := fmAll;
    LDBQuery.SQL.Text := ASQL;
    LDBQuery.Open;
    Result := LDBQuery;
  except on E: Exception do
    raise Exception.Create(E.Message);
  end;
end;
end.
