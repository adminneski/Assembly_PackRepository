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

unit goxormbr.manager.objectset.db.adapter;

interface

uses
  Rtti,
  TypInfo,
  Classes,
  Variants,
  SysUtils,
  Generics.Collections,
  // GOXORMBr
  goxormbr.manager.objectset.db.adapter.base,
  goxormbr.core.objects.helper,
  //dbebr.factory.interfaces,
  goxormbr.core.mapping.classes,
  goxormbr.core.types.mapping,
  goxormbr.core.types;

type
  // M - Object M
  TGOXManagerObjectSetAdapter<M: class, constructor> = class(TGOXManagerObjectSetAdapterBase<M>)
  private
    FConnection: TGOXDBConnection;
  public
    constructor Create(const AConnection: TGOXDBConnection; const APageSize: Integer = -1); overload;
    destructor Destroy; override;
    function Find: TObjectList<M>; overload; override;
    function Find(const APK: Int64): M; overload; override;
    function Find(const APK: string): M; overload; override;
    function FindWhere(const AWhere: string; const AOrderBy: string = ''): TObjectList<M>; overload; override;
    function FindWhere(const AWhere: String; const AOrderBy: String; const APageNumber:Integer; const ARowsByPage:Integer):TObjectList<M>; overload; override;

    procedure Insert(const AObject: M); override;
    procedure Update(const AObject: M); override;
    procedure Delete(const AObject: M); override;
    //
    function GetPackagePageCount(const AWhere: String; const ARowsByPage:Integer):Integer; override;
  end;

implementation

uses
  goxormbr.manager.objectset.db.session,
  goxormbr.core.consts,
  goxormbr.core.mapping.explorer;

{ TGOXManagerObjectSetAdapter<M> }

constructor TGOXManagerObjectSetAdapter<M>.Create(const AConnection: TGOXDBConnection; const APageSize: Integer);
begin
  inherited Create;
  FConnection := AConnection;
  FSession := TSessionObjectSet<M>.Create(AConnection, APageSize);
end;

destructor TGOXManagerObjectSetAdapter<M>.Destroy;
begin
  FreeAndNil(FSession);
  inherited;
end;

procedure TGOXManagerObjectSetAdapter<M>.Delete(const AObject: M);
var
  LInTransaction: Boolean;
  LIsConnected: Boolean;
begin
  inherited;
  // Controle de transação externa, controlada pelo desenvolvedor
  LInTransaction := FConnection.InTransaction;
  LIsConnected := FConnection.IsConnected;
  if not LIsConnected then
    FConnection.Connect;
  try
    if not LInTransaction then
      FConnection.StartTransaction;
    try
      // Executa comando delete em cascade
      CascadeActionsExecute(AObject, CascadeDelete);
      // Executa comando delete master
      FSession.Delete(AObject);
      ///
      if not LInTransaction then
        FConnection.Commit;
    except
      on E: Exception do
      begin
        if not LInTransaction then
          FConnection.Rollback;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    if not LIsConnected then
      FConnection.Disconnect;
  end;
end;

function TGOXManagerObjectSetAdapter<M>.FindWhere(const AWhere, AOrderBy: string): TObjectList<M>;
var
  LIsConnected: Boolean;
begin
  inherited;
  LIsConnected := FConnection.IsConnected;
  if not LIsConnected then
    FConnection.Connect;
  try
    Result := FSession.FindWhere(AWhere, AOrderBy);
  finally
    if not LIsConnected then
      FConnection.Disconnect;
  end;
end;

function TGOXManagerObjectSetAdapter<M>.Find(const APK: Int64): M;
var
  LIsConnected: Boolean;
begin
  inherited;
  LIsConnected := FConnection.IsConnected;
  if not LIsConnected then
    FConnection.Connect;
  try
    Result := FSession.Find(APK);
  finally
    if not LIsConnected then
      FConnection.Disconnect;
  end;
end;

function TGOXManagerObjectSetAdapter<M>.Find: TObjectList<M>;
var
  LIsConnected: Boolean;
begin
  inherited;
  LIsConnected := FConnection.IsConnected;
  if not LIsConnected then
    FConnection.Connect;
  try
    Result := FSession.Find;
  finally
    if not LIsConnected then
      FConnection.Disconnect;
  end;
end;

procedure TGOXManagerObjectSetAdapter<M>.Insert(const AObject: M);
var
  LPrimaryKey: TPrimaryKeyColumnsMapping;
  LColumn: TColumnMapping;
  LInTransaction: Boolean;
  LIsConnected: Boolean;
begin
  inherited;
  // Controle de transação externa, controlada pelo desenvolvedor
  LInTransaction := FConnection.InTransaction;
  LIsConnected := FConnection.IsConnected;
  if not LIsConnected then
    FConnection.Connect;
  try
    if not LInTransaction then
      FConnection.StartTransaction;
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
      // Executa comando insert em cascade
      CascadeActionsExecute(AObject, CascadeInsert);
      //
      if not LInTransaction then
        FConnection.Commit;
    except
      on E: Exception do
      begin
        if not LInTransaction then
          FConnection.Rollback;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    if not LIsConnected then
      FConnection.Disconnect;
  end;
end;

procedure TGOXManagerObjectSetAdapter<M>.Update(const AObject: M);
var
  LRttiType: TRttiType;
  LProperty: TRttiProperty;
  LObjectKey: TObject;
  LKey: string;
  LInTransaction: Boolean;
  LIsConnected: Boolean;
begin
  inherited;
  // Controle de transação externa, controlada pelo desenvolvedor
  LInTransaction := FConnection.InTransaction;
  LIsConnected := FConnection.IsConnected;
  if not LIsConnected then
    FConnection.Connect;
  try
    if not LInTransaction then
      FConnection.StartTransaction;
    try
      // Executa comando update em cascade
      CascadeActionsExecute(AObject, CascadeUpdate);
      // Gera a lista com as propriedades que foram alteradas
      if TObject(AObject).GetType(LRttiType) then
      begin
        LKey := GenerateKey(AObject);
        if FObjectState.TryGetValue(LKey, LObjectKey) then
        begin
          FSession.ModifyFieldsCompare(LKey, LObjectKey, AObject);
          FSession.Update(AObject, LKey);
          FObjectState.Remove(LKey);
          FObjectState.TrimExcess;
        end;
        // Remove o item excluído em Update Mestre-Detalhe
        for LObjectKey in FObjectState.Values do
          FSession.Delete(LObjectKey);
      end;
      if not LInTransaction then
        FConnection.Commit;
    except
      on E: Exception do
      begin
        if not LInTransaction then
          FConnection.Rollback;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    if not LIsConnected then
      FConnection.Disconnect;
    FObjectState.Clear;
    // Após executar o comando SQL Update, limpa a lista de campos alterados.
    FSession.ModifiedFields.Clear;
    FSession.ModifiedFields.TrimExcess;
    FSession.DeleteList.Clear;
    FSession.DeleteList.TrimExcess;
  end;
end;

function TGOXManagerObjectSetAdapter<M>.Find(const APK: string): M;
var
  LIsConnected: Boolean;
begin
  inherited;
  LIsConnected := FConnection.IsConnected;
  if not LIsConnected then
    FConnection.Connect;
  try
    Result := FSession.Find(APK);
  finally
    if not LIsConnected then
      FConnection.Disconnect;
  end;
end;

function TGOXManagerObjectSetAdapter<M>.FindWhere(const AWhere, AOrderBy: String; const APageNumber, ARowsByPage: Integer): TObjectList<M>;
var
  LIsConnected: Boolean;
begin
  inherited;
  LIsConnected := FConnection.IsConnected;
  if not LIsConnected then
    FConnection.Connect;
  try
    Result := FSession.FindWhere(AWhere, AOrderBy, APageNumber, ARowsByPage);
  finally
    if not LIsConnected then
      FConnection.Disconnect;
  end;
end;

function TGOXManagerObjectSetAdapter<M>.GetPackagePageCount(const AWhere: String; const ARowsByPage: Integer): Integer;
begin
  inherited;
  Result := FSession.GetPackagePageCount(AWhere,ARowsByPage);
end;

end.
