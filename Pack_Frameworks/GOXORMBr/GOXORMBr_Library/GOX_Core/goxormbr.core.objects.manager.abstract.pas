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

unit goxormbr.core.objects.manager.abstract;

interface

uses
  Rtti,
  Generics.Collections,
  // ORMBr
  goxormbr.core.mapping.explorer,
  goxormbr.core.mapping.classes,
  goxormbr.core.types;

type
  TObjectManagerAbstract<M: class, constructor> = class abstract
  protected
    procedure FillAssociation(const AObject: M);  virtual; abstract;

    // Instancia a class que mapea todas as class do tipo Entity
    function FindSQLInternal(const ASQL: String): TObjectList<M>; virtual; abstract;
    procedure ExecuteOneToOne(AObject: TObject; AProperty: TRttiProperty; AAssociation: TAssociationMapping); virtual; abstract;
    procedure ExecuteOneToMany(AObject: TObject; AProperty: TRttiProperty; AAssociation: TAssociationMapping); virtual; abstract;
  public
    constructor Create(const AOwner: TObject; const AGOXORMEngine: TGOXDBConnection; const APageSize: Integer); virtual;
    destructor Destroy; override;
    // Procedures
    procedure InsertInternal(const AObject: M);  virtual; abstract;
    procedure UpdateInternal(const AObject: TObject; const AModifiedFields: TDictionary<string, string>);  virtual; abstract;
    procedure DeleteInternal(const AObject: M);  virtual; abstract;

    // Functions
    function GetDMLCommand: string;  virtual; abstract;
    function ExistSequence: Boolean;  virtual; abstract;
    // DataSet
    function SelectInternalWhere(const AWhere: string; const AOrderBy: string): string;  virtual; abstract;
    function SelectInternalAll: TGOXDBQuery;  virtual; abstract;
    function SelectInternalID(const APK: Variant): TGOXDBQuery;  virtual; abstract;
    function SelectInternal(const ASQL: String): TGOXDBQuery;  virtual; abstract;
    function SelectInternalAssociation(const AObject: TObject): String;  virtual; abstract;
    function SelectInternalByPackage(const APageNumber:Integer; const ARowsByPage:Integer; const AWhere: String; AOrderBy: String):TGOXDBQuery;  virtual; abstract;
    function SelectByPackage(const APageNumber:Integer; const ARowsByPage:Integer; const AWhere: String; AOrderBy: String):TObjectList<M>;  virtual; abstract;    function GetPackagePageCount(const AWhere: String; const ARowsByPage:Integer):Integer; virtual; abstract;

    // ObjectSet
    function Find: TObjectList<M>; overload;  virtual; abstract;
    function Find(const APK: Variant): M; overload;  virtual; abstract;
    function FindWhere(const AWhere: string;  const AOrderBy: string): TObjectList<M>;  virtual; abstract;
    //

  end;

implementation

{ TObjectManagerAbstract<M> }

constructor TObjectManagerAbstract<M>.Create(const AOwner: TObject; const AGOXORMEngine: TGOXDBConnection; const APageSize: Integer);
begin
  // Popula todas classes modelos na lista
  TMappingExplorer.GetRepositoryMapping;
end;


destructor TObjectManagerAbstract<M>.Destroy;
begin
  inherited;
end;

end.
