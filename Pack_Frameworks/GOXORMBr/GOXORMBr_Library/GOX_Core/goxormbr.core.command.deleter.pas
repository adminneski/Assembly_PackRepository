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

unit goxormbr.core.command.deleter;

interface

uses
  DB,
  Rtti,
  SysUtils,
  Types,
  goxormbr.core.command.abstract,
  goxormbr.core.rtti.helper,
  goxormbr.core.types;

type
  TCommandDeleter = class(TDMLCommandAbstract)
  public
    constructor Create(AGOXORMEngine: TGOXDBConnection; ADriverType: TDriverType; AObject: TObject); override;
    function GenerateDelete(AObject: TObject): string;
  end;

implementation

uses
  goxormbr.core.objects.helper,
  goxormbr.core.consts,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.explorer;

{ TCommandDeleter }

constructor TCommandDeleter.Create(AGOXORMEngine: TGOXDBConnection; ADriverType: TDriverType; AObject: TObject);
begin
  inherited Create(AGOXORMEngine, ADriverType, AObject);
end;

function TCommandDeleter.GenerateDelete(AObject: TObject): string;
var
  LColumn: TColumnMapping;
  LPrimaryKeyCols: TPrimaryKeyColumnsMapping;
  LPrimaryKey: TPrimaryKeyMapping;
begin
  FParams.Clear;
  LPrimaryKey := TMappingExplorer.GetMappingPrimaryKey(AObject.ClassType);
  LPrimaryKeyCols := TMappingExplorer
                     .GetMappingPrimaryKeyColumns(AObject.ClassType);
  if LPrimaryKey = nil then
    raise Exception.Create(cMESSAGEPKNOTFOUND);

  for LColumn in LPrimaryKeyCols.Columns do
  begin
    with FParams.Add as TParam do
    begin
      Name := LColumn.ColumnName;
      DataType := LColumn.FieldType;
      ParamType := ptUnknown;
      if LPrimaryKey.GuidIncrement then
       AsBytes := StringToGUID(Format('{%s}', [LColumn.ColumnProperty.GetNullableValue(AObject).AsType<string>.Trim(['{', '}'])])).ToByteArray(TEndian.Big)
      else
        Value := LColumn.ColumnProperty.GetNullableValue(AObject).AsVariant;
    end;
  end;
  FResultCommand := FGeneratorCommand.GeneratorDelete(AObject, FParams);
  Result := FResultCommand;
end;

end.
