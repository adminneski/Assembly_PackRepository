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

unit goxormbr.core.command.factory;

interface

uses
  DB,
  Rtti,
  Generics.Collections,
  goxormbr.core.command.selecter,
  goxormbr.core.command.inserter,
  goxormbr.core.command.deleter,
  goxormbr.core.command.updater,
  goxormbr.core.mapping.classes,
  goxormbr.core.types.mapping,
  goxormbr.core.types,
  System.SysUtils;

type
  TDMLCommandFactoryAbstract = class abstract
  protected
    FDMLCommand: string;
  public
    function GeneratorSelectAll(AClass: TClass; APageSize: Integer): TGOXDBQuery; virtual; abstract;
    function GeneratorSelectID(AClass: TClass; AID: Variant): TGOXDBQuery; virtual; abstract;
    function GeneratorSelect(ASQL: String; APageSize: Integer): TGOXDBQuery; virtual; abstract;
    function GeneratorSelectOneToOne(const AOwner: TObject; const AClass: TClass;  const AAssociation: TAssociationMapping): TGOXDBQuery; virtual; abstract;
    function GeneratorSelectOneToMany(const AOwner: TObject; const AClass: TClass; const AAssociation: TAssociationMapping): TGOXDBQuery; virtual; abstract;
    function GeneratorSelectWhere(const AClass: TClass; const AWhere: string; const AOrderBy: string; const APageSize: Integer): String; virtual; abstract;

    function GeneratorSelectByPackage(AClass: TClass; const APageNumber:Integer; const ARowsByPage:Integer; const AWhere: String; AOrderBy: String):TGOXDBQuery; virtual; abstract;
    function GeneratorPackagePageCount(AClass: TClass; const AWhere: String; const ARowsByPage:Integer):TGOXDBQuery; virtual; abstract;

    function GeneratorNextPacket: TGOXDBQuery; overload; virtual; abstract;
    function GeneratorNextPacket(const AClass: TClass; const APageSize, APageNext: Integer): TGOXDBQuery; overload; virtual; abstract;
    function GeneratorNextPacket(const AClass: TClass; const AWhere, AOrderBy: String; const APageSize, APageNext: Integer): TGOXDBQuery; overload; virtual; abstract;
    function GetDMLCommand: string; virtual; abstract;
    function ExistSequence: Boolean; virtual; abstract;
    function GeneratorSelectAssociation(const AOwner: TObject; const AClass: TClass; const AAssociation: TAssociationMapping): String; virtual; abstract;
    procedure GeneratorUpdate(const AObject: TObject;  const AModifiedFields: TDictionary<string, string>); virtual; abstract;
    procedure GeneratorInsert(const AObject: TObject); virtual; abstract;
    procedure GeneratorDelete(const AObject: TObject); virtual; abstract;
  end;

  TDMLCommandFactory = class(TDMLCommandFactoryAbstract)
  protected
    FGOXORMEngine: TGOXDBConnection;
    FCommandSelecter: TCommandSelecter;
    FCommandInserter: TCommandInserter;
    FCommandUpdater: TCommandUpdater;
    FCommandDeleter: TCommandDeleter;
  public
    constructor Create(const AObject: TObject; const AGOXORMEngine: TGOXDBConnection;  const ADriverType: TDriverType);
    destructor Destroy; override;

    function GeneratorSelectAll(AClass: TClass; APageSize: Integer): TGOXDBQuery; override;
    function GeneratorSelectID(AClass: TClass; AID: Variant): TGOXDBQuery; override;
    function GeneratorSelect(ASQL: String; APageSize: Integer): TGOXDBQuery; override;
    function GeneratorSelectOneToOne(const AOwner: TObject; const AClass: TClass; const AAssociation: TAssociationMapping): TGOXDBQuery; override;
    function GeneratorSelectOneToMany(const AOwner: TObject; const AClass: TClass; const AAssociation: TAssociationMapping): TGOXDBQuery; override;
    function GeneratorSelectWhere(const AClass: TClass; const AWhere: string; const AOrderBy: string; const APageSize: Integer): string; override;

    function GeneratorSelectByPackage(AClass: TClass; const APageNumber:Integer; const ARowsByPage:Integer; const AWhere: String; AOrderBy: String):TGOXDBQuery; override;
    function GeneratorPackagePageCount(AClass: TClass; const AWhere: String; const ARowsByPage:Integer):TGOXDBQuery; override;

    function GeneratorNextPacket: TGOXDBQuery; overload; override;
    function GeneratorNextPacket(const AClass: TClass; const APageSize, APageNext: Integer): TGOXDBQuery; overload; override;
    function GeneratorNextPacket(const AClass: TClass; const AWhere, AOrderBy: String; const APageSize, APageNext: Integer): TGOXDBQuery; overload; override;
    function GetDMLCommand: string; override;
    function ExistSequence: Boolean; override;
    function GeneratorSelectAssociation(const AOwner: TObject; const AClass: TClass; const AAssociation: TAssociationMapping): String; override;
    procedure GeneratorUpdate(const AObject: TObject; const AModifiedFields: TDictionary<string, string>); override;
    procedure GeneratorInsert(const AObject: TObject); override;
    procedure GeneratorDelete(const AObject: TObject); override;
  end;

implementation

uses
  goxormbr.core.objects.helper,
  goxormbr.core.rtti.helper;

{ TDMLCommandFactory }

constructor TDMLCommandFactory.Create(const AObject: TObject;  const AGOXORMEngine: TGOXDBConnection; const ADriverType: TDriverType);
begin
  FGOXORMEngine := AGOXORMEngine;
  FCommandSelecter := TCommandSelecter.Create(AGOXORMEngine, ADriverType, AObject);
  FCommandInserter := TCommandInserter.Create(AGOXORMEngine, ADriverType, AObject);
  FCommandUpdater  := TCommandUpdater.Create(AGOXORMEngine, ADriverType, AObject);
  FCommandDeleter  := TCommandDeleter.Create(AGOXORMEngine, ADriverType, AObject);
end;


destructor TDMLCommandFactory.Destroy;
begin
  FreeAndNil(FCommandSelecter);
  FreeAndNil(FCommandDeleter);
  FreeAndNil(FCommandInserter);
  FreeAndNil(FCommandUpdater);
  inherited;
end;

function TDMLCommandFactory.GetDMLCommand: string;
begin
  Result := FDMLCommand;
end;

function TDMLCommandFactory.GeneratorPackagePageCount(AClass: TClass; const AWhere: String; const ARowsByPage: Integer): TGOXDBQuery;
begin
  FDMLCommand := FCommandSelecter.GeneratorPackagePageCount(AClass, AWhere,ARowsByPage);
  Result := FGOXORMEngine.OpenSQL(FDMLCommand);
end;

function TDMLCommandFactory.ExistSequence: Boolean;
begin
  Result := False;
  if FCommandInserter.AutoInc <> nil then
    Exit(FCommandInserter.AutoInc.ExistSequence);
end;

procedure TDMLCommandFactory.GeneratorDelete(const AObject: TObject);
begin
  FDMLCommand := FCommandDeleter.GenerateDelete(AObject);
  FGOXORMEngine.ExecuteSQL(FDMLCommand, FCommandDeleter.Params);
end;

procedure TDMLCommandFactory.GeneratorInsert(const AObject: TObject);
begin
  try
   FDMLCommand := FCommandInserter.GenerateInsert(AObject);
  except on E: Exception do
    raise Exception.Create('FCommandInserter.GenerateInsert :'+E.Message);
  end;
  FGOXORMEngine.ExecuteSQL(FDMLCommand, FCommandInserter.Params);
end;

function TDMLCommandFactory.GeneratorNextPacket(const AClass: TClass;
  const AWhere, AOrderBy: String; const APageSize, APageNext: Integer): TGOXDBQuery;
begin
  FDMLCommand := FCommandSelecter.GenerateNextPacket(AClass, AWhere, AOrderBy, APageSize, APageNext);
  Result := FGOXORMEngine.OpenSQL(FDMLCommand);
end;

function TDMLCommandFactory.GeneratorNextPacket(const AClass: TClass;
  const APageSize, APageNext: Integer): TGOXDBQuery;
begin
  FDMLCommand := FCommandSelecter.GenerateNextPacket(AClass, APageSize, APageNext);
  Result := FGOXORMEngine.OpenSQL(FDMLCommand);
end;

function TDMLCommandFactory.GeneratorSelect(ASQL: String; APageSize: Integer): TGOXDBQuery;
begin
  FCommandSelecter.SetPageSize(APageSize);
  FDMLCommand := ASQL;
//  // Envia comando para tela do monitor.
//  if FConnection.CommandMonitor <> nil then
//    FConnection.CommandMonitor.Command(FDMLCommand, FCommandSelecter.Params);
  Result := FGOXORMEngine.OpenSQL(ASQL);
end;

function TDMLCommandFactory.GeneratorSelectAll(AClass: TClass; APageSize: Integer): TGOXDBQuery;
begin
  FCommandSelecter.SetPageSize(APageSize);
  FDMLCommand := FCommandSelecter.GenerateSelectAll(AClass);
  Result := FGOXORMEngine.OpenSQL(FDMLCommand);
end;

function TDMLCommandFactory.GeneratorSelectAssociation(const AOwner: TObject;
  const AClass: TClass; const AAssociation: TAssociationMapping): String;
begin
  Result := FCommandSelecter.GenerateSelectOneToOne(AOwner, AClass, AAssociation);
end;

function TDMLCommandFactory.GeneratorSelectByPackage(AClass: TClass; const APageNumber, ARowsByPage: Integer; const AWhere: String;
  AOrderBy: String): TGOXDBQuery;
begin
  FDMLCommand := FCommandSelecter.GenerateSelectByPackage(AClass,APageNumber,ARowsByPage,AWhere,AOrderBy);
  Result := FGOXORMEngine.OpenSQL(FDMLCommand);
end;

function TDMLCommandFactory.GeneratorSelectOneToOne(const AOwner: TObject;
  const AClass: TClass; const AAssociation: TAssociationMapping): TGOXDBQuery;
begin
  FDMLCommand := FCommandSelecter.GenerateSelectOneToOne(AOwner, AClass, AAssociation);
  Result := FGOXORMEngine.OpenSQL(FDMLCommand);
end;

function TDMLCommandFactory.GeneratorSelectOneToMany(const AOwner: TObject;
  const AClass: TClass; const AAssociation: TAssociationMapping): TGOXDBQuery;
begin
  FDMLCommand := FCommandSelecter.GenerateSelectOneToMany(AOwner, AClass, AAssociation);
  Result := FGOXORMEngine.OpenSQL(FDMLCommand);
end;

function TDMLCommandFactory.GeneratorSelectWhere(const AClass: TClass;
  const AWhere: string; const AOrderBy: string; const APageSize: Integer): string;
begin
  FCommandSelecter.SetPageSize(APageSize);
  Result := FCommandSelecter.GeneratorSelectWhere(AClass, AWhere, AOrderBy);
end;

function TDMLCommandFactory.GeneratorSelectID(AClass: TClass;
  AID: Variant): TGOXDBQuery;
begin
  FDMLCommand := FCommandSelecter.GenerateSelectID(AClass, AID);
  Result := FGOXORMEngine.OpenSQL(FDMLCommand);
end;

function TDMLCommandFactory.GeneratorNextPacket: TGOXDBQuery;
begin
  FDMLCommand := FCommandSelecter.GenerateNextPacket;
  Result := FGOXORMEngine.OpenSQL(FDMLCommand);
end;

procedure TDMLCommandFactory.GeneratorUpdate(const AObject: TObject;  const AModifiedFields: TDictionary<string, string>);
begin
  FDMLCommand := FCommandUpdater.GenerateUpdate(AObject, AModifiedFields);
  if FDMLCommand = '' then
    Exit;
  FGOXORMEngine.ExecuteSQL(FDMLCommand, FCommandUpdater.Params);
end;

end.
