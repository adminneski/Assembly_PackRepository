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


{$INCLUDE ..\goxorm.inc}

unit goxormbr.manager.objectset.rest.adapter;

interface

uses
  Rtti,
  TypInfo,
  Classes,
  Variants,
  SysUtils,
  Generics.Collections,
  ///GOXORMBr
  goxormbr.manager.objectset.db.adapter.base,
  goxormbr.core.types,
  goxormbr.core.mapping.classes,
  goxormbr.core.types.mapping,
  goxormbr.core.objects.helper, Data.DB;

type
  TGOXManagerObjectSetAdapterRest<M: class, constructor> = class(TGOXManagerObjectSetAdapterBase<M>)
  private
  protected
    FConnection: TGOXRESTConnection;
  public
    constructor Create(const AConnection: TGOXRESTConnection; const APageSize: Integer = -1); overload;
    destructor Destroy; override;
    //
    function Find: TObjectList<M>; overload; override;
    function Find(const APK: Int64): M; overload; override;
    function Find(const APK: string): M; overload; override;
    function FindWhere(const AWhere: string; const AOrderBy: string = ''): TObjectList<M>; overload; //override;
    function FindWhere(const AWhere: String; const AOrderBy: String; const APageNumber:Integer; const ARowsByPage:Integer):TObjectList<M>; overload; //override;
    function FindFrom(const ASubResourceName: String): TObjectList<M>;
    //
    procedure Insert(const AObject: M); override;
    procedure InsertFrom(const ASubResourceName: String);
    procedure Update(const AObject: M); override;
    procedure UpdateFrom(const ASubResourceName: String);
    procedure Delete(const AObject: M); override;
    procedure DeleteFrom(const ASubResourceName: String);
    //
    function ResultParams: TParams;
    function AddPathParam(AValue: String):TGOXManagerObjectSetAdapterRest<M>;
    function AddQueryParam(AKeyName, AValue: String):TGOXManagerObjectSetAdapterRest<M>;
    function AddBodyParam(AValue: String):TGOXManagerObjectSetAdapterRest<M>;
   end;

implementation

uses
  goxormbr.manager.objectset.rest.session,
  goxormbr.core.mapping.explorer,
  goxormbr.core.consts;

{ TGOXManagerObjectSetAdapterRest<M> }

function TGOXManagerObjectSetAdapterRest<M>.AddBodyParam(AValue: String): TGOXManagerObjectSetAdapterRest<M>;
begin
  Result := Self;
  FConnection.AddBodyParam(AValue);
end;

function TGOXManagerObjectSetAdapterRest<M>.AddPathParam(AValue: String): TGOXManagerObjectSetAdapterRest<M>;
begin
  Result := Self;
  FConnection.AddPathParam(AValue);
end;

function TGOXManagerObjectSetAdapterRest<M>.AddQueryParam(AKeyName, AValue: String): TGOXManagerObjectSetAdapterRest<M>;
begin
  Result := Self;
  FConnection.AddQueryParam(AKeyName,AValue);
end;

constructor TGOXManagerObjectSetAdapterRest<M>.Create(const AConnection: TGOXRESTConnection;
  const APageSize: Integer = -1);
begin
  inherited Create;
  FConnection := AConnection;
  FSession := TSessionObjectSetRest<M>.Create(AConnection, nil, APageSize);
end;

procedure TGOXManagerObjectSetAdapterRest<M>.Delete(const AObject: M);
begin
  inherited;
  try
    /// <summary> Executa comando delete em cascade </summary>
//    CascadeActionsExecute(AObject, CascadeDelete);
    /// <summary> Executa comando delete master </summary>
    FSession.Delete(AObject);
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure TGOXManagerObjectSetAdapterRest<M>.DeleteFrom(const ASubResourceName: String);
begin
  FSession.DeleteFrom(ASubResourceName);
end;

destructor TGOXManagerObjectSetAdapterRest<M>.Destroy;
begin
  FSession.Free;
  inherited;
end;

function TGOXManagerObjectSetAdapterRest<M>.Find: TObjectList<M>;
begin
  inherited;
  Result := FSession.Find;
end;

function TGOXManagerObjectSetAdapterRest<M>.Find(const APK: Int64): M;
begin
  inherited;
  Result := FSession.Find(APK);
end;

function TGOXManagerObjectSetAdapterRest<M>.Find(const APK: string): M;
begin
  inherited;
  Result := FSession.Find(APK);
end;

function TGOXManagerObjectSetAdapterRest<M>.FindWhere(const AWhere, AOrderBy: String; const APageNumber, ARowsByPage: Integer): TObjectList<M>;
begin
  inherited;
  Result := FSession.FindWhere( AWhere, AOrderBy, APageNumber, ARowsByPage);
end;

function TGOXManagerObjectSetAdapterRest<M>.FindWhere(const AWhere, AOrderBy: string): TObjectList<M>;
begin
  inherited;
  Result := FSession.FindWhere(AWhere, AOrderBy);
end;

procedure TGOXManagerObjectSetAdapterRest<M>.Insert(const AObject: M);
var
  LPrimaryKey: TPrimaryKeyColumnsMapping;
  LColumn: TColumnMapping;
begin
  inherited;
  try
    FSession.Insert(AObject);

    if FSession.ExistSequence then
    begin
      LPrimaryKey := TMappingExplorer
                         .GetMappingPrimaryKeyColumns(AObject.ClassType);
      if LPrimaryKey = nil then
        raise Exception.Create(cMESSAGEPKNOTFOUND);

      for LColumn in LPrimaryKey.Columns do
        SetAutoIncValueChilds(AObject, LColumn);
    end;
  except
    on E: Exception do
    begin
      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure TGOXManagerObjectSetAdapterRest<M>.InsertFrom(const ASubResourceName: String);
begin
  inherited;
  FSession.InsertFrom(ASubResourceName);
end;

function TGOXManagerObjectSetAdapterRest<M>.ResultParams: TParams;
begin
  Result := FSession.ResultParams;
end;

procedure TGOXManagerObjectSetAdapterRest<M>.Update(const AObject: M);
var
  LObjectList: TObjectList<M>;
begin
  inherited;
  LObjectList := TObjectList<M>.Create;
  try
    LObjectList.Add(AObject);
    FSession.Update(LObjectList);
  finally
    LObjectList.Clear;
    LObjectList.Free;
  end;
end;

procedure TGOXManagerObjectSetAdapterRest<M>.UpdateFrom(const ASubResourceName: String);
begin
  FSession.UpdateFrom(ASubResourceName);
end;

function TGOXManagerObjectSetAdapterRest<M>.FindFrom(const ASubResourceName: String): TObjectList<M>;
begin
  inherited;
  Result := FSession.FindFrom(ASubResourceName);
end;

end.
