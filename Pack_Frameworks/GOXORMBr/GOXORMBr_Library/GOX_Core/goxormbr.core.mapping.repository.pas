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

unit goxormbr.core.mapping.repository;
interface
uses
  Rtti,
  SysUtils,
  Generics.Collections,
  goxormbr.core.mapping.exceptions;
type
  TRepository = class
  private
    FEntitys: TObjectDictionary<TClass, TList<TClass>>;
    FViews: TObjectDictionary<TClass, TList<TClass>>;
    FTriggers: TObjectDictionary<TClass, TList<TClass>>;
    function GetEntity: TEnumerable<TClass>;
    function GetView: TEnumerable<TClass>;
    function GetTrigger: TEnumerable<TClass>;
  protected
    property EntityList: TObjectDictionary<TClass, TList<TClass>> read FEntitys;
    property ViewList: TObjectDictionary<TClass, TList<TClass>> read FViews;
    property TriggerList: TObjectDictionary<TClass, TList<TClass>> read FTriggers;
  public
    constructor Create;
    destructor Destroy; override;
    property Entitys: TEnumerable<TClass> read GetEntity;
    property Views: TEnumerable<TClass> read GetView;
    property Trigger: TEnumerable<TClass> read GetTrigger;
  end;
  TMappingRepository = class
  private
    FRepository: TRepository;
    function FindEntity(AClass: TClass): TList<TClass>;
  public
    constructor Create(AEntity, AView: TArray<TClass>);
    destructor Destroy; override;
    function GetEntity(AClass: TClass): TEnumerable<TClass>;
    function FindEntityByName(const ClassName: string): TClass;
    property List: TRepository read FRepository;
  end;
implementation
{ TMappingRepository }
constructor TMappingRepository.Create(AEntity, AView: TArray<TClass>);
var
  LClass: TClass;
begin
  FRepository := TRepository.Create;
  // Entitys
  if AEntity <> nil then
    for LClass in AEntity do
      if not FRepository.EntityList.ContainsKey(LClass) then
        FRepository.EntityList.Add(LClass, TList<TClass>.Create);
  for LClass in FRepository.Entitys do
    if FRepository.EntityList.ContainsKey(LClass.ClassParent) then
      FRepository.EntityList[LClass.ClassParent].Add(LClass);
  // Views
  if AView <> nil then
    for LClass in AView do
      if not FRepository.ViewList.ContainsKey(LClass) then
        FRepository.ViewList.Add(LClass, TList<TClass>.Create);
  for LClass in FRepository.Views do
    if FRepository.ViewList.ContainsKey(LClass.ClassParent) then
      FRepository.ViewList[LClass.ClassParent].Add(LClass);
end;
destructor TMappingRepository.Destroy;
begin
  FRepository.Free;
  inherited;
end;
function TMappingRepository.FindEntityByName(const ClassName: string): TClass;
var
  LClass: TClass;
begin
  Result := nil;
  for LClass in List.Entitys do
    if SameText(LClass.ClassName, ClassName) then
      Exit(LClass);
end;
function TMappingRepository.FindEntity(AClass: TClass): TList<TClass>;
var
  LClass: TClass;
  LListClass: TList<TClass>;
begin
  Result := TList<TClass>.Create;
  Result.AddRange(GetEntity(AClass));
  for LClass in GetEntity(AClass) do
  begin
    LListClass := FindEntity(LClass);
    try
      Result.AddRange(LListClass);
    finally
      LListClass.Free;
    end;
  end;
end;
function TMappingRepository.GetEntity(AClass: TClass): TEnumerable<TClass>;
begin
  if not FRepository.EntityList.ContainsKey(AClass) then
     EClassNotRegistered.Create(AClass);
  Result := FRepository.EntityList[AClass];
end;
{ TRepository }
constructor TRepository.Create;
begin
  FEntitys := TObjectDictionary<TClass, TList<TClass>>.Create([doOwnsValues]);
  FViews := TObjectDictionary<TClass, TList<TClass>>.Create([doOwnsValues]);
end;
destructor TRepository.Destroy;
begin
  FEntitys.Free;
  FViews.Free;
  inherited;
end;
function TRepository.GetEntity: TEnumerable<TClass>;
begin
  Result := FEntitys.Keys;
end;
function TRepository.GetTrigger: TEnumerable<TClass>;
begin
  Result := FTriggers.Keys;
end;
function TRepository.GetView: TEnumerable<TClass>;
begin
  Result := FViews.Keys;
end;
end.
