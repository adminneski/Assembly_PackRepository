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


unit goxormbr.core.command.selecter;

interface

uses
  SysUtils,
  Rtti,
  DB,
  goxormbr.core.command.abstract,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.explorer,
  goxormbr.core.types;

type
  TCommandSelecter = class(TDMLCommandAbstract)
  private
    FPageSize: Integer;
    FPageNext: Integer;
    FSelectCommand: string;
  public
    constructor Create(AGOXORMEngine: TGOXDBConnection; ADriverType: TDriverType; AObject: TObject); override;
    procedure SetPageSize(const APageSize: Integer);
    function GenerateSelectAll(const AClass: TClass): string;
    function GeneratorSelectWhere(const AClass: TClass; const AWhere, AOrderBy: string): string;
    function GenerateSelectID(const AClass: TClass; const AID: Variant): string;
    function GenerateSelectOneToOne(const AOwner: TObject; const AClass: TClass; const AAssociation: TAssociationMapping): string;
    function GenerateSelectOneToMany(const AOwner: TObject;const AClass: TClass; const AAssociation: TAssociationMapping): string;

    function GenerateSelectByPackage(AClass: TClass; const APageNumber, ARowsByPage: Integer; const AWhere: String; AOrderBy: String): String;
    function GeneratorPackagePageCount(AClass: TClass; const AWhere: String; const ARowsByPage:Integer):String;

    function GenerateNextPacket: string; overload;
    function GenerateNextPacket(const AClass: TClass; const APageSize, APageNext: Integer): string; overload;
    function GenerateNextPacket(const AClass: TClass; const AWhere, AOrderBy: String; const APageSize, APageNext: Integer): string; overload;
  end;

implementation

{ TCommandSelecter }

constructor TCommandSelecter.Create(AGOXORMEngine: TGOXDBConnection;  ADriverType: TDriverType; AObject: TObject);
begin
  inherited Create(AGOXORMEngine, ADriverType, AObject);
  FSelectCommand := '';
  FResultCommand := '';
  FPageSize := -1;
  FPageNext := 0;
end;

function TCommandSelecter.GenerateNextPacket: string;
begin
  FPageNext := FPageNext + FPageSize;
  FResultCommand := FGeneratorCommand.GeneratorPageNext(FSelectCommand, FPageSize, FPageNext);
  Result := FResultCommand;
end;

procedure TCommandSelecter.SetPageSize(const APageSize: Integer);
begin
  FPageSize := APageSize;
end;

function TCommandSelecter.GenerateSelectAll(const AClass: TClass): string;
begin
  FPageNext := 0;
  FSelectCommand := FGeneratorCommand.GeneratorSelectAll(AClass, FPageSize, -1);
  FResultCommand := FGeneratorCommand.GeneratorPageNext(FSelectCommand, FPageSize, FPageNext);
  Result := FResultCommand;
end;

function TCommandSelecter.GenerateSelectByPackage(AClass: TClass; const APageNumber, ARowsByPage: Integer; const AWhere: String; AOrderBy: String): String;
begin
  FPageNext := 0;
  FResultCommand := FGeneratorCommand.GeneratorSelectByPackage(AClass,APageNumber,ARowsByPage,AWhere,AOrderBy);
  Result := FResultCommand;
end;

function TCommandSelecter.GenerateSelectOneToMany(const AOwner: TObject;
  const AClass: TClass; const AAssociation: TAssociationMapping): string;
begin
  FResultCommand := FGeneratorCommand.GenerateSelectOneToOneMany(AOwner, AClass, AAssociation);
  Result := FResultCommand;
end;

function TCommandSelecter.GenerateSelectOneToOne(const AOwner: TObject;
  const AClass: TClass; const AAssociation: TAssociationMapping): string;
begin
  FResultCommand := FGeneratorCommand.GenerateSelectOneToOne(AOwner, AClass, AAssociation);
  Result := FResultCommand;
end;

function TCommandSelecter.GeneratorSelectWhere(const AClass: TClass;
  const AWhere, AOrderBy: string): string;
var
  LWhere: String;
begin
  FPageNext := 0;
  LWhere := StringReplace(AWhere,'%', '$', [rfReplaceAll]);
  FSelectCommand := FGeneratorCommand.GeneratorSelectWhere(AClass, LWhere, AOrderBy, FPageSize);
  FResultCommand := FGeneratorCommand.GeneratorPageNext(FSelectCommand, FPageSize, FPageNext);
  FResultCommand := StringReplace(FResultCommand, '$', '%', [rfReplaceAll]);
  Result := FResultCommand;
end;

function TCommandSelecter.GeneratorPackagePageCount(AClass: TClass; const AWhere: String; const ARowsByPage: Integer): String;
begin
  Result := FGeneratorCommand.GeneratorPackagePageCount(AClass, AWhere, ARowsByPage);
end;

function TCommandSelecter.GenerateSelectID(const AClass: TClass;
  const AID: Variant): string;
begin
  FPageNext := 0;
  FSelectCommand := FGeneratorCommand.GeneratorSelectAll(AClass, -1, AID);
  FResultCommand := FSelectCommand;
  Result := FResultCommand;
end;

function TCommandSelecter.GenerateNextPacket(const AClass: TClass;
  const APageSize, APageNext: Integer): string;
begin
  FSelectCommand := FGeneratorCommand.GeneratorSelectAll(AClass, APageSize, -1);
  FResultCommand := FGeneratorCommand.GeneratorPageNext(FSelectCommand, APageSize, APageNext);
  Result := FResultCommand;
end;

function TCommandSelecter.GenerateNextPacket(const AClass: TClass; const AWhere,
  AOrderBy: String; const APageSize, APageNext: Integer): string;
var
  LWhere: String;
  LCommandSelect: String;
begin
  LWhere := StringReplace(AWhere,'%', '$', [rfReplaceAll]);
  LCommandSelect := FGeneratorCommand.GeneratorSelectWhere(AClass, LWhere, AOrderBy, APageSize);
  FResultCommand := FGeneratorCommand.GeneratorPageNext(LCommandSelect, APageSize, APageNext);
  FResultCommand := StringReplace(FResultCommand, '$', '%', [rfReplaceAll]);
  Result := FResultCommand;
end;

end.
