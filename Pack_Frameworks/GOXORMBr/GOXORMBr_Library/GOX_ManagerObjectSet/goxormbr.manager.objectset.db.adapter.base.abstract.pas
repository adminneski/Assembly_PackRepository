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


unit goxormbr.manager.objectset.db.adapter.base.abstract;

interface

uses
  Rtti,
  Variants,
  Generics.Collections,
  goxormbr.core.session.abstract;

type
  /// <summary>
  /// M - Object M
  /// </summary>
  TGOXManagerObjectSetAdapterBaseAbstract<M: class, constructor> = class
  protected
    FSession: TSessionAbstract<M>;
    FObjectState: TObjectDictionary<string, TObject>;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function ExistSequence: Boolean; virtual; abstract;
    function ModifiedFields: TDictionary<string, TDictionary<string, string>>; virtual; abstract;
    function Find: TObjectList<M>; overload; virtual; abstract;
    function Find(const APK: Int64): M; overload; virtual; abstract;
    function Find(const APK: string): M; overload; virtual; abstract;
    function FindWhere(const AWhere: string; const AOrderBy: string = ''): TObjectList<M>; overload; virtual; abstract;
    function FindWhere(const AWhere: String; const AOrderBy: String; const APageNumber:Integer; const ARowsByPage:Integer):TObjectList<M>; overload; virtual; abstract;


    procedure Insert(const AObject: M); virtual; abstract;
    procedure Update(const AObject: M); virtual; abstract;
    procedure Delete(const AObject: M); virtual; abstract;
    procedure Modify(const AObject: M); virtual; abstract;
    procedure New(var AObject: M); virtual; abstract;
    //
    function GetPackagePageCount(const AWhere: String; const ARowsByPage:Integer):Integer; virtual; abstract;
  end;

implementation

{ TGOXManagerObjectSetAdapterBaseAbstract<M> }

constructor TGOXManagerObjectSetAdapterBaseAbstract<M>.Create;
begin
  //
end;

destructor TGOXManagerObjectSetAdapterBaseAbstract<M>.Destroy;
begin
  //
  inherited;
end;

end.
