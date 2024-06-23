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

unit goxormbr.core.command.updater;

interface

uses
  DB,
  Rtti,
  Math,
  Classes,
  SysUtils,
  StrUtils,
  Variants,
  TypInfo,
  Generics.Collections,
  /// ORMBr
  goxormbr.core.command.abstract,
  goxormbr.core.utils,
  goxormbr.core.consts,
  goxormbr.core.types.blob,
  goxormbr.core.rtti.helper,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.attributes,
  goxormbr.core.mapping.explorer,
  goxormbr.core.types;

type
  TCommandUpdater = class(TDMLCommandAbstract)
  private
    function GetParamValue(AInstance: TObject; AProperty: TRttiProperty; AFieldType: TFieldType): Variant;
  public
    constructor Create(AGOXORMEngine: TGOXDBConnection; ADriverType: TDriverType; AObject: TObject); override;
    function GenerateUpdate(AObject: TObject; AModifiedFields: TDictionary<string, string>): string;
  end;

implementation

uses
  goxormbr.core.objects.helper;

{ TCommandUpdater }

constructor TCommandUpdater.Create(AGOXORMEngine: TGOXDBConnection; ADriverType: TDriverType; AObject: TObject);
var
  LColumns: TPrimaryKeyColumnsMapping;
  LColumn: TColumnMapping;
begin
  inherited Create(AGOXORMEngine, ADriverType, AObject);
  LColumns := TMappingExplorer
                  .GetMappingPrimaryKeyColumns(AObject.ClassType);
  for LColumn in LColumns.Columns do
  begin
    with FParams.Add as TParam do
    begin
      Name := LColumn.ColumnName;
      DataType := LColumn.FieldType;
    end;
  end;
end;

function TCommandUpdater.GenerateUpdate(AObject: TObject;
  AModifiedFields: TDictionary<string, string>): string;
var
  LPrimaryKey: TPrimaryKeyColumnsMapping;
  LFor: Integer;
  LParams: TParams;
  LColumn: TColumnMapping;
  LObjectType: TRttiType;
  LProperty: TRttiProperty;
  LKey: String;
  LFieldType: Column;
  LBooleanValue: Integer;
begin
  Result := '';
  FResultCommand := '';
  if AModifiedFields.Count = 0 then
    Exit;
  // Variavel local é usado como parâmetro para montar o script só com os
  // campos PrimaryKey.
  LParams := TParams.Create(nil);
  try
    LPrimaryKey := TMappingExplorer
                     .GetMappingPrimaryKeyColumns(AObject.ClassType);
    if LPrimaryKey = nil then
      raise Exception.Create(cMESSAGEPKNOTFOUND);

    for LColumn in LPrimaryKey.Columns do
    begin
      with LParams.Add as TParam do
      begin
        Name := LColumn.ColumnName;
        DataType := LColumn.FieldType;
        ParamType := ptUnknown;
        Value := LColumn.ColumnProperty.GetNullableValue(AObject).AsVariant;
      end;
    end;
    FResultCommand := FGeneratorCommand.GeneratorUpdate(AObject, LParams, AModifiedFields);
    Result := FResultCommand;
    // Gera todos os parâmetros, sendo os campos alterados primeiro e o do
    // PrimaryKey por último, usando LParams criado local.
    AObject.GetType(LObjectType);
    for LKey in AModifiedFields.Keys do
    begin
      LProperty := LObjectType.GetProperty(LKey);
      if LProperty = nil then
        Continue;
      if LProperty.IsNoUpdate then
        Continue;
      LFieldType := LProperty.GetColumn;
      if LFieldType = nil then
        Continue;

      with LParams.Add as TParam do
      begin
        Name := LFieldType.ColumnName;
        DataType := LFieldType.FieldType;
        ParamType := ptInput;
        Value := GetParamValue(AObject, LProperty, DataType);

    	// Tratamento para o tipo ftBoolean nativo, indo como Integer
        // para gravar no banco.
        if DataType in [ftBoolean] then
        begin
          LBooleanValue := IfThen(Boolean(Value), 1, 0);
          DataType := ftInteger;
          Value := LBooleanValue;
        end;
      end;
    end;
    FParams.Clear;
    for LFor := LParams.Count -1 downto 0 do
    begin
      with FParams.Add as TParam do
      begin
        Name := LParams.Items[LFor].Name;
        DataType := LParams.Items[LFor].DataType;
        Value := LParams.Items[LFor].Value;
        ParamType := LParams.Items[LFor].ParamType;
      end;
    end;
  finally
    LParams.Free;
  end;
end;

function TCommandUpdater.GetParamValue(AInstance: TObject;
  AProperty: TRttiProperty; AFieldType: TFieldType): Variant;
begin
  Result := Null;
  if AProperty.IsNullValue(AInstance) then
    Exit;

  case AProperty.PropertyType.TypeKind of
    tkEnumeration:
      Result := AProperty.GetEnumToFieldValue(AInstance, AFieldType).AsType<Variant>;
    tkRecord:
      begin
        if AProperty.IsBlob then
          Result := AProperty.GetNullableValue(AInstance).AsType<TBlob>.ToBytes
        else
        if AProperty.IsNullable then
          Result := AProperty.GetNullableValue(AInstance).AsType<Variant>;
      end
  else
    Result := AProperty.GetValue(AInstance).AsType<Variant>;
  end;
end;

end.
