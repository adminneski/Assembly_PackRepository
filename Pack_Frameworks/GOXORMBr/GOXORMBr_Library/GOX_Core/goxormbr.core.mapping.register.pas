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

unit goxormbr.core.mapping.register;
interface
uses
  SysUtils,
  Rtti,
  Generics.Collections;
type
  TRegisterClass = class
  strict private
    class var
    FEntitys: TList<TClass>;
    FViews: TList<TClass>;
    FTriggers: TList<TClass>;
  public
    class constructor Create;
    class destructor Destroy;
    ///
    class function GetAllEntityClass: TArray<TClass>;
    class function GetAllViewClass: TArray<TClass>;
    class function GetAllTriggerClass: TArray<TClass>;
    ///
    class procedure RegisterEntity(AClass: TClass);
    class procedure RegisterView(AClass: TClass);
    class procedure RegisterTrigger(AClass: TClass);
    ///
    class property EntityList: TList<TClass> read FEntitys;
    class property ViewList: TList<TClass> read FViews;
    class property TriggerList: TList<TClass> read FTriggers;
  end;
implementation
{ TMappedClasses }
class constructor TRegisterClass.Create;
begin
  FEntitys := TList<TClass>.Create;
  FViews := TList<TClass>.Create;
  FTriggers := TList<TClass>.Create;
end;
class destructor TRegisterClass.Destroy;
begin
  FEntitys.Free;
  FViews.Free;
  FTriggers.Free;
end;
class function TRegisterClass.GetAllEntityClass: TArray<TClass>;
var
  LFor: Integer;
begin
  try
    SetLength(Result, FEntitys.Count);
    for LFor := 0 to FEntitys.Count -1 do
      Result[LFor] := FEntitys[LFor];
  finally
    FEntitys.Clear;
  end;
end;
class function TRegisterClass.GetAllTriggerClass: TArray<TClass>;
var
  LFor: Integer;
begin
  try
    SetLength(Result, FTriggers.Count);
    for LFor := 0 to FTriggers.Count -1 do
      Result[LFor] := FTriggers[LFor];
  finally
    FTriggers.Clear;
  end;
end;
class function TRegisterClass.GetAllViewClass: TArray<TClass>;
var
  LFor: Integer;
begin
  try
    SetLength(Result, FViews.Count);
    for LFor := 0 to FViews.Count -1 do
      Result[LFor] := FViews[LFor];
  finally
    FViews.Clear;
  end;
end;
class procedure TRegisterClass.RegisterEntity(AClass: TClass);
begin
  if not FEntitys.Contains(AClass) then
    FEntitys.Add(AClass);
end;
class procedure TRegisterClass.RegisterTrigger(AClass: TClass);
begin
  if not FTriggers.Contains(AClass) then
    FTriggers.Add(AClass);
end;
class procedure TRegisterClass.RegisterView(AClass: TClass);
begin
  if not FViews.Contains(AClass) then
    FViews.Add(AClass);
end;
end.



