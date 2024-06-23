{******************************************************************************}
{                                  GOXORMBr                                     }
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

unit goxormbr.core.objects.utils;

interface

uses
  Classes,
  SysUtils,
  Rtti,
  DB,
  TypInfo,
  Math,
  StrUtils,
  Types,
  Variants,
  Generics.Collections,
  /// orm
  goxormbr.core.mapping.attributes,
  goxormbr.core.mapping.classes,
  goxormbr.core.types.mapping;

type
  IRttiSingleton = interface
    ['{AF40524E-2027-46C3-AAAE-5F4267689CD8}']
    function GetRttiType(AClass: TClass): TRttiType;
    function RunValidade(AObject: TObject): Boolean;
    function Clone(AObject: TObject): TObject;
    function CreateObject(ARttiType: TRttiType): TObject;
    procedure CopyObject(ASourceObject, ATargetObject: TObject);
  end;

  TRttiSingleton = class(TInterfacedObject, IRttiSingleton)
  private
    class var FInstance: IRttiSingleton;
  private
    FContext: TRttiContext;
    constructor CreatePrivate;
  protected
    constructor Create;
  public
    { Public declarations }
    destructor Destroy; override;
    class function GetInstance: IRttiSingleton;
    function GetRttiType(AClass: TClass): TRttiType;
    function RunValidade(AObject: TObject): Boolean;
    function Clone(AObject: TObject): TObject;
    function CreateObject(ARttiType: TRttiType): TObject;
    procedure CopyObject(ASourceObject, ATargetObject: TObject);
  end;

implementation

uses
  goxormbr.core.mapping.explorer,
  goxormbr.core.rtti.helper,
  goxormbr.core.objects.helper;

{ TRttiSingleton }

constructor TRttiSingleton.Create;
begin
  raise Exception.Create('Para usar o IRttiSingleton use o método TRttiSingleton.GetInstance()');
end;

constructor TRttiSingleton.CreatePrivate;
begin
  inherited;
  FContext := TRttiContext.Create;
end;

destructor TRttiSingleton.Destroy;
begin
  FContext.Free;
  inherited;
end;

function TRttiSingleton.Clone(AObject: TObject): TObject;
var
  LRttiType: TRttiType;
  LProperty: TRttiProperty;
  LCloned: TObject;
  LValue: TObject;
  LSourceStream: TStream;
  LSavedPosition: Int64;
  LTargetStream: TStream;
  LSourceObject: TObject;
  LTargetObject: TObject;
  LTargetList: TObjectList<TObject>;
  LSourceList: TObjectList<TObject>;
  LFor: Integer;
begin
  Result := nil;
  if not Assigned(AObject) then
    Exit;

  LRttiType := FContext.GetType(AObject.ClassType);
  LCloned := CreateObject(LRttiType);
  for LProperty in LRttiType.GetProperties do
  begin
    if not LProperty.PropertyType.IsInstance then
    begin
      if LProperty.IsWritable then
        LProperty.SetValue(LCloned, LProperty.GetValue(AObject));
    end
    else
    begin
      LValue := LProperty.GetNullableValue(AObject).AsObject;
      if LValue is TStream then
      begin
        LSourceStream := TStream(LValue);
        LSavedPosition := LSourceStream.Position;
        LSourceStream.Position := 0;
        if LProperty.GetValue(LCloned).AsType<Variant> = Null then
        begin
          LTargetStream := TMemoryStream.Create;
          LProperty.SetValue(LCloned, LTargetStream);
        end
        else
          LTargetStream := LProperty.GetValue(LCloned).AsObject as TStream;
        LTargetStream.Position := 0;
        LTargetStream.CopyFrom(LSourceStream, LSourceStream.Size);
        LTargetStream.Position := LSavedPosition;
        LSourceStream.Position := LSavedPosition;
      end
      else
      if LProperty.IsList then
      begin
        LSourceList := TObjectList<TObject>(LValue);
        if LProperty.GetValue(LCloned).AsType<Variant> = Null then
        begin
          LTargetList := TObjectList<TObject>.Create;
          LProperty.SetValue(LCloned, LTargetList);
        end
        else
          LTargetList := TObjectList<TObject>(LProperty.GetValue(LCloned).AsObject);

        for LFor := 0 to LSourceList.Count - 1 do
          LTargetList.Add(Clone(LSourceList[LFor]));
      end
      else
      begin
        LSourceObject := LValue;
        if LProperty.GetValue(LCloned).AsType<Variant> = Null then
        begin
          LTargetObject := Clone(LSourceObject);
          LProperty.SetValue(LCloned, LTargetObject);
        end
        else
        begin
          LTargetObject := LProperty.GetValue(LCloned).AsObject;
          CopyObject(LSourceObject, LTargetObject);
        end;
        LProperty.SetValue(LCloned, LTargetObject);
      end;
    end;
  end;
  Result := LCloned;
end;

procedure TRttiSingleton.CopyObject(ASourceObject, ATargetObject: TObject);
var
  LRttiType: TRttiType;
  LProperty: TRttiProperty;
  LCloned: TObject;
  LValue: TObject;
  LSourceStream: TStream;
  LSavedPosition: Int64;
  LTargetStream: TStream;
  LSourceObject: TObject;
  LTargetObject: TObject;
  LTargetList: TObjectList<TObject>;
  LSourceList: TObjectList<TObject>;
  LFor: Integer;
begin
  if not Assigned(ATargetObject) then
    Exit;

  LRttiType := FContext.GetType(ASourceObject.ClassType);
  LCloned := ATargetObject;
  for LProperty in LRttiType.GetProperties do
  begin
    if not LProperty.PropertyType.IsInstance then
    begin
      if LProperty.IsWritable then
        LProperty.SetValue(LCloned, LProperty.GetValue(ASourceObject));
    end
    else
    begin
      LValue := LProperty.GetValue(ASourceObject).AsObject;
      if LValue is TStream then
      begin
        LSourceStream := TStream(LValue);
        LSavedPosition := LSourceStream.Position;
        LSourceStream.Position := 0;
        if LProperty.GetValue(LCloned).AsType<Variant> = Null then
        begin
          LTargetStream := TMemoryStream.Create;
          LProperty.SetValue(LCloned, LTargetStream);
        end
        else
          LTargetStream := LProperty.GetValue(LCloned).AsObject as TStream;
        LTargetStream.Position := 0;
        LTargetStream.CopyFrom(LSourceStream, LSourceStream.Size);
        LTargetStream.Position := LSavedPosition;
        LSourceStream.Position := LSavedPosition;
      end
      else
      if LProperty.IsList then
      begin
        LSourceList := TObjectList<TObject>(LValue);
        if LProperty.GetValue(LCloned).AsType<Variant> = Null then
        begin
          LTargetList := TObjectList<TObject>.Create;
          LProperty.SetValue(LCloned, LTargetList);
        end
        else
          LTargetList := TObjectList<TObject>(LProperty.GetValue(LCloned).AsObject);

        for LFor := 0 to LSourceList.Count - 1 do
          LTargetList.Add(Clone(LSourceList[LFor]));
      end
      else
      begin
        LSourceObject := LValue;
        if LProperty.GetValue(LCloned).AsType<Variant> = Null then
        begin
          LTargetObject := Clone(LSourceObject);
          LProperty.SetValue(LCloned, LTargetObject);
        end
        else
        begin
          LTargetObject := LProperty.GetValue(LCloned).AsObject;
          CopyObject(LSourceObject, LTargetObject);
        end;
      end;
    end;
  end;
end;

function TRttiSingleton.CreateObject(ARttiType: TRttiType): TObject;
var
  Method: TRttiMethod;
  metaClass: TClass;
begin
  { First solution, clear and slow }
  metaClass := nil;
  Method := nil;
  for Method in ARttiType.GetMethods do
  begin
    if not (Method.HasExtendedInfo and Method.IsConstructor) then
      Continue;

    if Length(Method.GetParameters) > 0 then
      Continue;

    metaClass := ARttiType.AsInstance.MetaclassType;
    Break;
  end;
  if Assigned(metaClass) then
    Result := Method.Invoke(metaClass, []).AsObject
  else
    raise Exception.Create('Cannot find a propert constructor for ' + ARttiType.ToString);
end;

function TRttiSingleton.GetRttiType(AClass: TClass): TRttiType;
begin
  Result := FContext.GetType(AClass);
end;

class function TRttiSingleton.GetInstance: IRttiSingleton;
begin
  if not Assigned(FInstance) then
    FInstance := TRttiSingleton.CreatePrivate;
   Result := FInstance;
end;

function TRttiSingleton.RunValidade(AObject: TObject): Boolean;
var
  LColumn: TColumnMapping;
  LColumns: TColumnMappingList;
  LAttribute: TCustomAttribute;
begin
  Result := False;
  LColumns := TMappingExplorer.GetMappingColumn(AObject.ClassType);
  for LColumn in LColumns do
  begin
     // Valida se o valor é NULO
     LAttribute := LColumn.ColumnProperty.GetNotNullConstraint;
     if LAttribute <> nil then
       NotNullConstraint(LAttribute)
         .Validate(LColumn.ColumnDictionary.ConstraintErrorMessage,
                   LColumn.ColumnProperty.GetNullableValue(AObject));

     // Valida se o valor é menor que ZERO
     LAttribute := LColumn.ColumnProperty.GetMinimumValueConstraint;
     if LAttribute <> nil then
        MinimumValueConstraint(LAttribute)
          .Validate(LColumn.ColumnDictionary.ConstraintErrorMessage,
                    LColumn.ColumnProperty.GetNullableValue(AObject));

     // Valida se o valor é menor que ZERO
     LAttribute := LColumn.ColumnProperty.GetMaximumValueConstraint;
     if LAttribute <> nil then
        MaximumValueConstraint(LAttribute)
          .Validate(LColumn.ColumnDictionary.ConstraintErrorMessage,
                    LColumn.ColumnProperty.GetNullableValue(AObject));

     // Valida se o valor é vazio
     LAttribute := LColumn.ColumnProperty.GetNotEmptyConstraint;
     if LAttribute <> nil then
        NotEmpty(LAttribute)
          .Validate(LColumn.ColumnProperty, AObject);

     // Valida se o tamanho da String é válido
     LAttribute := LColumn.ColumnProperty.GetSizeConstraint;
     if LAttribute <> nil then
        Size(LAttribute)
          .Validate(LColumn.ColumnProperty, AObject);
  end;
  Result := True;
end;

end.

