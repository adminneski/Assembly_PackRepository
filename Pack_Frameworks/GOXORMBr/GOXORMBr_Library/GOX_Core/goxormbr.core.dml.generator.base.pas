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

unit goxormbr.core.dml.generator.base;

interface

uses
  DB,
  Rtti,
  SysUtils,
  Classes,
  StrUtils,
  Variants,
  TypInfo,
  Generics.Collections,
  // GOXORMBr
  goxormbr.core.criteria,
//  goxorm.core.dml.interfaces,
//  goxorm.core.dml.commands,
 // goxorm.core.dml.cache,
  goxormbr.core.types.blob,
//  goxorm.core.register.middleware,
  goxormbr.core.rtti.helper,
//  goxorm.core.factory.interfaces,
  goxormbr.core.mapping.classes,
  goxormbr.core.mapping.explorer,
  goxormbr.core.types.mapping,
  goxormbr.core.types;

type

  TDMLCommandAutoInc = class
  private
    FSequence: TSequenceMapping;
    FPrimaryKey: TPrimaryKeyMapping;
    FExistSequence: Boolean;
  public
    property Sequence: TSequenceMapping read FSequence write FSequence;
    property PrimaryKey: TPrimaryKeyMapping read FPrimaryKey write FPrimaryKey;
    property ExistSequence: Boolean read FExistSequence write FExistSequence;
  end;


  // Classe de conexões abstract
  TDMLGeneratorCommandBase = class//(TInterfacedObject, IDMLGeneratorCommand)
  private
    function GetPropertyValue(AObject: TObject; AProperty: TRttiProperty; AFieldType: TFieldType): Variant;
  protected
    FGOXORMEngine: TGOXDBConnection;
    FDateFormat: string;
    FTimeFormat: string;
    procedure GenerateJoinColumn(AClass: TClass; ATable: TTableMapping; var ACriteria: ICriteria);
    procedure GenerateJoinNoColumn(AClass: TClass; ATable: TTableMapping; var ACriteria: ICriteria);
    //
    function GetCriteriaSelect(AClass: TClass; AID: Variant): ICriteria;
    function GetGeneratorSelect(const ACriteria: ICriteria): string; virtual; abstract;
    function GetGeneratorWhere(const AClass: TClass; const ATableName: String; const AID: Variant): String;


    function GetGeneratorOrderBy(const AClass: TClass; const ATableName: String; const AID: Variant): String;
//    function GetGeneratorQueryScopeWhere(const AClass: TClass): String;
//    function GetGeneratorQueryScopeOrderBy(const AClass: TClass): String;
    function ExecuteSequence(const ASQL: string): Int64;
  public
    procedure SetConnection(const AGOXORMEngine: TGOXDBConnection);
    function GeneratorSelectAll(AClass: TClass; APageSize: Integer; AID: Variant): string; virtual; abstract;
    function GeneratorSelectWhere(AClass: TClass; AWhere: string; AOrderBy: string; APageSize: Integer): string; virtual; abstract;

    function GeneratorSelectByPackage(AClass: TClass; const APageNumber:Integer; const ARowsByPage:Integer; const AWhere: String; AOrderBy: String):String; virtual; abstract;
    function GeneratorPackagePageCount(AClass: TClass; const AWhere: String; const ARowsByPage:Integer):String; virtual; abstract;

    function GenerateSelectOneToOne(AOwner: TObject; AClass: TClass; AAssociation: TAssociationMapping): string;
    function GenerateSelectOneToOneMany(AOwner: TObject; AClass: TClass; AAssociation: TAssociationMapping): string;
    function GeneratorUpdate(AObject: TObject; AParams: TParams; AModifiedFields: TDictionary<string, string>): string;
    function GeneratorInsert(AObject: TObject): string;
    function GeneratorDelete(AObject: TObject; AParams: TParams): string;

    function GeneratorAutoIncCurrentValue(AObject: TObject; AAutoInc: TDMLCommandAutoInc): Int64; virtual; abstract;
    function GeneratorAutoIncNextValue(AObject: TObject; AAutoInc: TDMLCommandAutoInc): Int64; virtual; abstract;

    function GeneratorPageNext(const ACommandSelect: string; APageSize, APageNext: Integer): string; virtual; abstract;
  end;

implementation

{ TDMLGeneratorCommandBase }

function TDMLGeneratorCommandBase.ExecuteSequence(const ASQL: string): Int64;
var
  LDBResultSet: TGOXDBQuery;
begin
  Result := 0;
  //JEICKSON
//  LDBResultSet := FGOXORMEngine.OpenSQL(ASQL);
  try
    LDBResultSet := TGOXDBQuery.Create(nil);
    LDBResultSet.Connection := FGOXORMEngine;
    LDBResultSet.SQL.Text := ASQL;
    LDBResultSet.Open;
    //Rever como Pegar valor do primeiro campo se nao  funcionar assim
    if LDBResultSet.RecordCount > 0 then
      Result := LDBResultSet.FieldByName('SEQ').AsLargeInt;
  finally
    FreeAndNil(LDBResultSet);
  end;

//  try
    // forma antiga
   // if LDBResultSet.RecordCount > 0 then
   //   Result := VarAsType(LDBResultSet.GetFieldValue(0), varInt64);

    //Rever como Pegar valor do primeiro campo se nao  funcionar assim
//    if LDBResultSet.RecordCount > 0 then
//      Result := VarAsType(LDBResultSet.Fields[0].Value, varInt64);
//
//  finally
//    LDBResultSet.Close;
//    FreeAndNil(LDBResultSet);
//  end;
end;

function TDMLGeneratorCommandBase.GenerateSelectOneToOne(AOwner: TObject;  AClass: TClass; AAssociation: TAssociationMapping): string;

  function GetValue(AIndex: Integer): Variant;
  var
    LColumn: TColumnMapping;
    LColumns: TColumnMappingList;
  begin
    Result := Null;
    LColumns := TMappingExplorer.GetMappingColumn(AOwner.ClassType);
    for LColumn in LColumns do
      if LColumn.ColumnName = AAssociation.ColumnsName[AIndex] then
        Exit(GetPropertyValue(AOwner, LColumn.ColumnProperty, LColumn.FieldType));
  end;

var
  LCriteria: ICriteria;
  LTable: TTableMapping;
  LOrderBy: TOrderByMapping;
  LOrderByList: TStringList;
  LFor: Integer;
begin
  LCriteria := GetCriteriaSelect(AClass, '-1');
  Result := LCriteria.AsString;
  //
  LTable := TMappingExplorer.GetMappingTable(AClass);
  // Association Multi-Columns
  for LFor := 0 to AAssociation.ColumnsNameRef.Count -1 do
  begin
    Result := Result + ' WHERE '
                     + LTable.Name + '.' + AAssociation.ColumnsNameRef[LFor]
                     + ' = ' + GetValue(LFor);
  end;
  // OrderBy
  LOrderBy := TMappingExplorer.GetMappingOrderBy(AClass);
  if LOrderBy <> nil then
  begin
    Result := Result + ' ORDER BY ';
    LOrderByList := TStringList.Create;
    try
      LOrderByList.Duplicates := dupError;
      ExtractStrings([',', ';'], [' '], PChar(LOrderBy.ColumnsName), LOrderByList);
      for LFor := 0 to LOrderByList.Count -1 do
      begin
        Result := Result + LTable.Name + '.' + LOrderByList[LFor];
        if LFor < LOrderByList.Count -1 then
          Result := Result + ', ';
      end;
    finally
     FreeAndNil(LOrderByList);
    end;
  end;
end;

function TDMLGeneratorCommandBase.GenerateSelectOneToOneMany(AOwner: TObject;
  AClass: TClass; AAssociation: TAssociationMapping): string;

  function GetValue(Aindex: Integer): Variant;
  var
    LColumn: TColumnMapping;
    LColumns: TColumnMappingList;
  begin
    Result := Null;
    LColumns := TMappingExplorer.GetMappingColumn(AOwner.ClassType);
    for LColumn in LColumns do
      if LColumn.ColumnName = AAssociation.ColumnsName[Aindex] then
        Exit(GetPropertyValue(AOwner, LColumn.ColumnProperty, LColumn.FieldType));
  end;

var
  LCriteria: ICriteria;
  LTable: TTableMapping;
  LOrderBy: TOrderByMapping;
  LOrderByList: TStringList;
  LFor: Integer;
begin
  LCriteria := GetCriteriaSelect(AClass, '-1');
  Result := LCriteria.AsString;
  //
  LTable := TMappingExplorer.GetMappingTable(AClass);
  // Association Multi-Columns
  for LFor := 0 to AAssociation.ColumnsNameRef.Count -1 do
  begin
    Result := Result + ifThen(LFor = 0, ' WHERE ', ' AND ');
    Result := Result + LTable.Name
                     + '.' + AAssociation.ColumnsNameRef[LFor]
                     + ' = ' + GetValue(LFor)
  end;
  // OrderBy
  LOrderBy := TMappingExplorer.GetMappingOrderBy(AClass);
  if LOrderBy <> nil then
  begin
    Result := Result + ' ORDER BY ';
    LOrderByList := TStringList.Create;
    try
      LOrderByList.Duplicates := dupError;
      ExtractStrings([',', ';'], [' '], PChar(LOrderBy.ColumnsName), LOrderByList);
      for LFor := 0 to LOrderByList.Count -1 do
      begin
        Result := Result + LOrderByList[LFor];
        if LFor < LOrderByList.Count -1 then
          Result := Result + ', ';
      end;
    finally
      FreeAndNil(LOrderByList);
    end;
  end;
end;

function TDMLGeneratorCommandBase.GeneratorDelete(AObject: TObject;
  AParams: TParams): string;
var
  LFor: Integer;
  LTable: TTableMapping;
  LCriteria: ICriteria;
begin
  Result := '';
  LTable := TMappingExplorer.GetMappingTable(AObject.ClassType);
  LCriteria := CreateCriteria.Delete;
  LCriteria.From(LTable.Name);
  /// <exception cref="LTable.Name + '.'"></exception>
  for LFor := 0 to AParams.Count -1 do
    LCriteria.Where(AParams.Items[LFor].Name + ' = :' +
                    AParams.Items[LFor].Name);
  Result := LCriteria.AsString;
end;

function TDMLGeneratorCommandBase.GeneratorInsert(AObject: TObject): string;
var
  LTable: TTableMapping;
  LColumn: TColumnMapping;
  LColumns: TColumnMappingList;
  LCriteria: ICriteria;
 // LKey: String;
begin
  Result := '';
 // LKey := AObject.ClassType.ClassName + '-INSERT';
  // Pesquisa se já existe o SQL padrão no cache, não tendo que montar novamente
//  if TQueryCache.Get.TryGetValue(LKey, Result) then
//    Exit;
  LTable := TMappingExplorer.GetMappingTable(AObject.ClassType);
  LColumns := TMappingExplorer.GetMappingColumn(AObject.ClassType);
  LCriteria := CreateCriteria.Insert.Into(LTable.Name);
  for LColumn in LColumns do
  begin
    if LColumn.ColumnProperty.IsNullValue(AObject) then
      Continue;
    // Restrictions
    if LColumn.IsNoInsert then
      Continue;
    // Set(Campo=Value)
    // <exception cref="LTable.Name + '.'"></exception>
    LCriteria.&Set(LColumn.ColumnName, ':' +
                   LColumn.ColumnName);
  end;
  Result := LCriteria.AsString;
  // Adiciona o comando a lista fazendo cache para não ter que gerar novamente
//  TQueryCache.Get.AddOrSetValue(LKey, Result);
end;

function TDMLGeneratorCommandBase.GetGeneratorOrderBy(const AClass: TClass; const ATableName: String; const AID: Variant): String;
var
  LOrderBy: TOrderByMapping;
  LOrderByList: TStringList;
  LFor: Integer;
  LScopeOrderBy: String;
begin
  Result := '';
  LScopeOrderBy := ''; //GetGeneratorQueryScopeOrderBy(AClass);
  if LScopeOrderBy <> '' then
    Result := ' ORDER BY ' + LScopeOrderBy;
  LOrderBy := TMappingExplorer.GetMappingOrderBy(AClass);
  if LOrderBy = nil then
    Exit;
  Result := Result + IfThen(LScopeOrderBy = '', ' ORDER BY ', ', ');
  LOrderByList := TStringList.Create;
  try
    LOrderByList.Duplicates := dupError;
    ExtractStrings([',', ';'], [' '], PChar(LOrderBy.ColumnsName), LOrderByList);
    for LFor := 0 to LOrderByList.Count -1 do
    begin
      Result := Result + ATableName + '.' + LOrderByList[LFor];
      if LFor < LOrderByList.Count -1 then
        Result := Result + ', ';
    end;
  finally
    LOrderByList.Free;
  end;
end;

//function TDMLGeneratorCommandBase.GetGeneratorQueryScopeOrderBy(const AClass: TClass): String;
//var
//  LFor: Integer;
//  LFuncs: TQueryScopeList;
//  LFunc: TFunc<String>;
//begin
//  Result := '';
//  LFuncs := TORMBrMiddlewares.ExecuteQueryScopeCallback(AClass, 'GetOrderBy');
//  if LFuncs = nil then
//    Exit;
//  for LFunc in LFuncs.Values do
//  begin
//    Result := Result + LFunc();
//    if LFor < LFuncs.Count -1 then
//      Result := Result + ', ';
//  end;
//end;

//function TDMLGeneratorCommandBase.GetGeneratorQueryScopeWhere(const AClass: TClass): String;
//var
//  LFor: Integer;
//  LFuncs: TQueryScopeList;
//  LFunc: TFunc<String>;
//begin
//  Result := '';
//  LFuncs := TORMBrMiddlewares.ExecuteQueryScopeCallback(AClass, 'GetWhere');
//  if LFuncs = nil then
//    Exit;
//  for LFunc in LFuncs.Values do
//  begin
//    Result := Result + LFunc();
//    if LFor < LFuncs.Count -1 then
//      Result := Result + ' AND ';
//  end;
//end;

function TDMLGeneratorCommandBase.GetGeneratorWhere(const AClass: TClass; const ATableName: String; const AID: Variant): String;
var
  LPrimaryKey: TPrimaryKeyMapping;
  LColumnName: String;
  LFor: Integer;
  LScopeWhere: String;
  LID: string;
begin
  {essa funcao tem que ser reavalida por jeickson para fazer uma limpeza }

  Result := '';
  LScopeWhere := '';// GetGeneratorQueryScopeWhere(AClass);
  if LScopeWhere <> '' then
    Result := ' WHERE ' + LScopeWhere;

  if VarToStr(AID) = '-1' then
    Exit;

  LPrimaryKey := TMappingExplorer.GetMappingPrimaryKey(AClass);
  if LPrimaryKey <> nil then
  begin
    Result := Result + IfThen(LScopeWhere = '', ' WHERE ', ' AND ');
    for LFor := 0 to LPrimaryKey.Columns.Count -1 do
    begin
      if LFor > 0 then
       Continue;
      LColumnName := ATableName + '.' + LPrimaryKey.Columns[LFor];
      if (TVarData(AID).VType = varInteger)or
         (TVarData(AID).VType = varSingle)or
         (TVarData(AID).VType = varUInt32)or
         (TVarData(AID).VType = varInt64)or
         (TVarData(AID).VType = varUInt64)then
        Result := Result + LColumnName + ' = ' + IntToStr(AID)
      else
      begin
//        if LPrimaryKey.GuidIncrement and FGOXORMEngine.DBOptions.StoreGUIDAsOctet then
//        begin
//          LID := AID;
//          LID := LID.Trim(['{', '}']);
//          Result := Result + Format('UUID_TO_CHAR(%s) = %s', [LColumnName, QuotedStr(LID)])
//        end
//        else
          Result := Result + LColumnName + ' = ' + QuotedStr(AID);
      end;
    end;
  end;
end;

function TDMLGeneratorCommandBase.GetCriteriaSelect(AClass: TClass; AID: Variant): ICriteria;
var
  LTable: TTableMapping;
  LColumns: TColumnMappingList;
  LColumn: TColumnMapping;
begin
  // Table
  LTable := TMappingExplorer.GetMappingTable(AClass);
  try
    Result := CreateCriteria.Select.From(LTable.Name);
    // Columns
    LColumns := TMappingExplorer.GetMappingColumn(AClass);
    for LColumn in LColumns do
    begin
      if LColumn.IsVirtualData then
        Continue;
      if LColumn.IsJoinColumn then
        Continue;
      Result.Column(LTable.Name + '.' + LColumn.ColumnName);
    end;
    // Joins - INNERJOIN, LEFTJOIN, RIGHTJOIN, FULLJOIN
    GenerateJoinColumn(AClass, LTable, Result);
  finally
    Result.Where.Clear;
    Result.OrderBy.Clear;
  end;
end;

function TDMLGeneratorCommandBase.GetPropertyValue(AObject: TObject;
  AProperty: TRttiProperty; AFieldType: TFieldType): Variant;
begin
  case AFieldType of
     ftString, ftWideString, ftMemo, ftWideMemo, ftFmtMemo:
        Result := QuotedStr(VarToStr(AProperty.GetNullableValue(AObject).AsVariant));
     ftLargeint:
        Result := VarToStr(AProperty.GetNullableValue(AObject).AsVariant);
     ftInteger, ftWord, ftSmallint:
        Result := VarToStr(AProperty.GetNullableValue(AObject).AsVariant);
     ftVariant:
        Result := VarToStr(AProperty.GetNullableValue(AObject).AsVariant);
     ftDateTime, ftDate:
        Result := QuotedStr(FormatDateTime(FDateFormat,
                             VarToDateTime(AProperty.GetNullableValue(AObject).AsVariant)));
     ftTime, ftTimeStamp, ftOraTimeStamp:
        Result := QuotedStr(FormatDateTime(FTimeFormat,
                             VarToDateTime(AProperty.GetNullableValue(AObject).AsVariant)));
     ftCurrency, ftBCD, ftFMTBcd:
       begin
         Result := VarToStr(AProperty.GetNullableValue(AObject).AsVariant);
         Result := ReplaceStr(Result, ',', '.');
       end;
     ftFloat:
       begin
         Result := VarToStr(AProperty.GetNullableValue(AObject).AsVariant);
         Result := ReplaceStr(Result, ',', '.');
       end;
     ftBlob, ftGraphic, ftOraBlob, ftOraClob:
       Result := AProperty.GetNullableValue(AObject).AsType<TBlob>.ToBytes;
  else
     Result := '';
  end;
end;

procedure TDMLGeneratorCommandBase.SetConnection(const AGOXORMEngine: TGOXDBConnection);
begin
  FGOXORMEngine := AGOXORMEngine;
end;

procedure TDMLGeneratorCommandBase.GenerateJoinColumn(AClass: TClass;
  ATable: TTableMapping; var ACriteria: ICriteria);
var
  LJoinList: TJoinColumnMappingList;
  LJoin: TJoinColumnMapping;
  LJoinExist: TList<string>;
begin
  LJoinExist := TList<string>.Create;
  try
    // JoinColumn
    LJoinList := TMappingExplorer.GetMappingJoinColumn(AClass);
    if LJoinList = nil then
      Exit;

    for LJoin in LJoinList do
    begin
      if Length(LJoin.AliasColumn) > 0 then
        ACriteria.Column(LJoin.AliasRefTable + '.'
                       + LJoin.RefColumnNameSelect).&As(LJoin.AliasColumn)
      else
        ACriteria.Column(LJoin.AliasRefTable + '.'
                       + LJoin.RefColumnNameSelect);
    end;
    for LJoin in LJoinList do
    begin
      if LJoinExist.IndexOf(LJoin.AliasRefTable) = -1 then
      begin
        LJoinExist.Add(LJoin.RefTableName);
        // Join Inner, Left, Right, Full
        if LJoin.Join = InnerJoin then
          ACriteria.InnerJoin(LJoin.RefTableName)
                     .&As(LJoin.AliasRefTable)
                     .&On([LJoin.AliasRefTable + '.' +
                           LJoin.RefColumnName,' = ',ATable.Name + '.' +
                           LJoin.ColumnName])
        else
        if LJoin.Join = LeftJoin then
          ACriteria.LeftJoin(LJoin.RefTableName)
                     .&As(LJoin.AliasRefTable)
                     .&On([LJoin.AliasRefTable + '.' +
                           LJoin.RefColumnName,' = ',ATable.Name + '.' +
                           LJoin.ColumnName])
        else
        if LJoin.Join = RightJoin then
          ACriteria.RightJoin(LJoin.RefTableName)
                     .&As(LJoin.AliasRefTable)
                     .&On([LJoin.AliasRefTable + '.' +
                           LJoin.RefColumnName,' = ',ATable.Name + '.' +
                           LJoin.ColumnName])
        else
        if LJoin.Join = FullJoin then
          ACriteria.FullJoin(LJoin.RefTableName)
                     .&As(LJoin.AliasRefTable)
                     .&On([LJoin.AliasRefTable + '.' +
                           LJoin.RefColumnName,' = ',ATable.Name + '.' +
                           LJoin.ColumnName]);
      end;
    end;
  finally
    LJoinExist.Free;
  end;
end;

procedure TDMLGeneratorCommandBase.GenerateJoinNoColumn(AClass: TClass; ATable: TTableMapping; var ACriteria: ICriteria);
var
  LJoinList: TJoinColumnMappingList;
  LJoin: TJoinColumnMapping;
  LJoinExist: TList<string>;
begin
  LJoinExist := TList<string>.Create;
  try
    // JoinColumn
    LJoinList := TMappingExplorer.GetMappingJoinColumn(AClass);
    if LJoinList = nil then
      Exit;
    for LJoin in LJoinList do
    begin
      if LJoinExist.IndexOf(LJoin.AliasRefTable) = -1 then
      begin
        LJoinExist.Add(LJoin.RefTableName);
        // Join Inner, Left, Right, Full
        if LJoin.Join = InnerJoin then
          ACriteria.InnerJoin(LJoin.RefTableName)
                     .&As(LJoin.AliasRefTable)
                     .&On([LJoin.AliasRefTable + '.' +
                           LJoin.RefColumnName,' = ',ATable.Name + '.' +
                           LJoin.ColumnName])
        else
        if LJoin.Join = LeftJoin then
          ACriteria.LeftJoin(LJoin.RefTableName)
                     .&As(LJoin.AliasRefTable)
                     .&On([LJoin.AliasRefTable + '.' +
                           LJoin.RefColumnName,' = ',ATable.Name + '.' +
                           LJoin.ColumnName])
        else
        if LJoin.Join = RightJoin then
          ACriteria.RightJoin(LJoin.RefTableName)
                     .&As(LJoin.AliasRefTable)
                     .&On([LJoin.AliasRefTable + '.' +
                           LJoin.RefColumnName,' = ',ATable.Name + '.' +
                           LJoin.ColumnName])
        else
        if LJoin.Join = FullJoin then
          ACriteria.FullJoin(LJoin.RefTableName)
                     .&As(LJoin.AliasRefTable)
                     .&On([LJoin.AliasRefTable + '.' +
                           LJoin.RefColumnName,' = ',ATable.Name + '.' +
                           LJoin.ColumnName]);
      end;
    end;
  finally
    LJoinExist.Free;
  end;
end;

function TDMLGeneratorCommandBase.GeneratorUpdate(AObject: TObject;
  AParams: TParams; AModifiedFields: TDictionary<string, string>): string;
var
  LFor: Integer;
  LTable: TTableMapping;
  LCriteria: ICriteria;
  LColumnName: string;
begin
  Result := '';
  if AModifiedFields.Count = 0 then
    Exit;
  // Varre a lista de campos alterados para montar o UPDATE
  LTable := TMappingExplorer.GetMappingTable(AObject.ClassType);
  LCriteria := CreateCriteria.Update(LTable.Name);
  for LColumnName in AModifiedFields.Values do
  begin
    // SET Field=Value alterado
    // <exception cref="oTable.Name + '.'"></exception>
    LCriteria.&Set(LColumnName, ':' + LColumnName);
  end;
  for LFor := 0 to AParams.Count -1 do
    LCriteria.Where(AParams.Items[LFor].Name + ' = :' + AParams.Items[LFor].Name);
  Result := LCriteria.AsString;
end;

end.
