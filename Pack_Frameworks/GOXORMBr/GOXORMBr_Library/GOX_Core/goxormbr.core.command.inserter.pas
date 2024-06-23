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

unit goxormbr.core.command.inserter;

interface

uses
  DB,
  Rtti,
  Math,
  StrUtils,
  SysUtils,
  TypInfo,
  Variants,
  Types,
  goxormbr.core.command.abstract,
//  goxormbr.core.dml.commands,
  goxormbr.core.dml.generator.base,
  goxormbr.core.consts,
  goxormbr.core.types.blob,
  goxormbr.core.objects.helper,
  goxormbr.core.objects.utils,
  goxormbr.core.mapping.classes,
  goxormbr.core.rtti.helper,
  goxormbr.core.mapping.explorer,
  goxormbr.core.types;

type
  TCommandInserter = class(TDMLCommandAbstract)
  private
    FDMLAutoInc: TDMLCommandAutoInc;
    function GetParamValue(AInstance: TObject; AProperty: TRttiProperty; AFieldType: TFieldType): Variant;
  public
    constructor Create(AGOXORMEngine: TGOXDBConnection; ADriverType: TDriverType; AObject: TObject); override;
    destructor Destroy; override;
    function GenerateInsert(AObject: TObject): string;
    function AutoInc: TDMLCommandAutoInc;
  end;

implementation

{ TCommandInserter }

constructor TCommandInserter.Create(AGOXORMEngine: TGOXDBConnection; ADriverType: TDriverType; AObject: TObject);
begin
  inherited Create(AGOXORMEngine, ADriverType, AObject);
  FDMLAutoInc := TDMLCommandAutoInc.Create;
end;

destructor TCommandInserter.Destroy;
begin
  FreeAndNil(FDMLAutoInc);
  inherited;
end;

function TCommandInserter.GenerateInsert(AObject: TObject): string;
var
  LColumns: TColumnMappingList;
  LColumn: TColumnMapping;
  LPrimaryKey: TPrimaryKeyMapping;
  LBooleanValue: Integer;
begin

  FResultCommand := FGeneratorCommand.GeneratorInsert(AObject);
  Result := FResultCommand;
  FParams.Clear;
  // Alimenta a lista de parâmetros do comando Insert com os valores do Objeto.
  LColumns := TMappingExplorer.GetMappingColumn(AObject.ClassType);
  if LColumns = nil then
    raise Exception.CreateFmt(cMESSAGECOLUMNNOTFOUND, [AObject.ClassName]);

  LPrimaryKey := TMappingExplorer.GetMappingPrimaryKey(AObject.ClassType);

  for LColumn in LColumns do
  begin
    if LColumn.ColumnProperty.IsNullValue(AObject) then
      Continue;
    if LColumn.IsNoInsert then
      Continue;
    if LColumn.IsJoinColumn then
      Continue;
    // Verifica se existe PK, pois autoinc só é usado se existir.
    if LPrimaryKey <> nil then
    begin
      if LPrimaryKey.Columns.IndexOf(LColumn.ColumnName) > -1 then
      begin
        if LPrimaryKey.AutoIncrement then
        begin

          FDMLAutoInc.Sequence := TMappingExplorer
                                  .GetMappingSequence(AObject.ClassType);

          FDMLAutoInc.ExistSequence := (FDMLAutoInc.Sequence <> nil);
          FDMLAutoInc.PrimaryKey := LPrimaryKey;
          try
          // Popula o campo como o valor gerado pelo AutoInc
          LColumn.ColumnProperty.SetValue(AObject,
                                          FGeneratorCommand.GeneratorAutoIncNextValue(AObject, FDMLAutoInc));
          except on E: Exception do
            raise Exception.Create(E.Message);
          end;

        end;
        if LPrimaryKey.GuidIncrement then
        begin
          LColumn.ColumnProperty.SetValue(AObject, TGuid.NewGuid.ToString);
        end;
      end;
    end;

    // Alimenta cada parâmetro com o valor de cada propriedade do objeto.
    with FParams.Add as TParam do
    begin
      Name := LColumn.ColumnName;
      DataType := LColumn.FieldType;
      ParamType := ptInput;
      if LColumn.FieldType = ftGuid then
        AsBytes := GetParamValue(AObject, LColumn.ColumnProperty, LColumn.FieldType)
      else
        Value := GetParamValue(AObject, LColumn.ColumnProperty, LColumn.FieldType);

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

end;

function TCommandInserter.GetParamValue(AInstance: TObject;
  AProperty: TRttiProperty; AFieldType: TFieldType): Variant;
var
  LTeste: string;
begin
  Result := Null;
  case AProperty.PropertyType.TypeKind of
    tkEnumeration:
      Result := AProperty.GetEnumToFieldValue(AInstance, AFieldType).AsVariant;
  else
    if AFieldType = ftBlob then
      Result := AProperty.GetNullableValue(AInstance).AsType<TBlob>.ToBytes
    else if AFieldType = ftGuid then
    begin
      LTeste := AProperty.GetValue(AInstance).AsString;
      Result := StringToGUID(Format('{%s}', [AProperty.GetNullableValue(AInstance).AsType<string>.Trim(['{', '}'])])).ToByteArray(TEndian.Big)
    end
    else
      Result := AProperty.GetNullableValue(AInstance).AsVariant;
  end;
end;

function TCommandInserter.AutoInc: TDMLCommandAutoInc;
begin
  Result := FDMLAutoInc;
end;

end.
