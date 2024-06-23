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

{$INCLUDE ..\goxorm.inc}

unit goxormbr.core.session.abstract;

interface

uses
  DB,
  Rtti,
  TypInfo,
  SysUtils,
  Generics.Collections,
  ///GOXORMBr
  goxormbr.core.objects.manager.abstract,
  goxormbr.core.consts,
  goxormbr.core.types,
  goxormbr.core.rtti.helper,
  goxormbr.core.types.blob,
  goxormbr.core.mapping.attributes;

type
  // M - Sessão Abstract
  TSessionAbstract<M: class, constructor> = class
  private
  protected
    FPageSize: Integer;
    FPageNext: Integer;
    FModifiedFields: TDictionary<string, TDictionary<string, string>>;
    FDeleteList: TObjectList<M>;
    FManager: TObjectManagerAbstract<M>;
    FResultParams: TParams;
    FFindWhereUsed: Boolean;
    FFindWhereRefreshUsed: Boolean;
    FFetchingRecords: Boolean;
    FWhere: String;
    FOrderBy: String;
  public
    constructor Create(const APageSize: Integer = -1); overload; virtual;
    destructor Destroy; override;
    function ExistSequence: Boolean; virtual;
    function ModifiedFields: TDictionary<string, TDictionary<string, string>>; virtual;
    // ObjectSet
    procedure Insert(const AObject: M); overload; virtual;
    procedure Insert(const AObjectList: TObjectList<M>); overload; virtual;
    procedure Update(const AObject: M; const AKey: string); overload; virtual;
    procedure Update(const AObjectList: TObjectList<M>); overload;  virtual;
    procedure Delete(const APK: Int64); overload;  virtual;
    procedure Delete(const AObject: M); overload; virtual;

    // DataSet
    procedure Open; virtual;
    procedure OpenID(const APK: Variant); virtual;
    procedure OpenSQL(const ASQL: string); virtual;

    procedure OpenWhere(const AWhere: string; const AOrderBy: string = ''); overload; virtual;
    procedure OpenWhere(const AWhere: String; AOrderBy: String; const APageNumber:Integer; const ARowsByPage:Integer); overload; virtual;
    //
    procedure RefreshRecord(const AColumns: TParams); virtual;
    function SelectAssociation(const AObject: TObject): String; virtual;
    function ResultParams: TParams;
    // DataSet e ObjectSet
    procedure ModifyFieldsCompare(const AKey: string; const AObjectSource, AObjectUpdate: TObject); virtual;
    //
    function Find: TObjectList<M>; overload; virtual;
    function Find(const APK: Int64): M; overload; virtual;
    function Find(const APK: string): M; overload; virtual;
    function FindWhere(const AWhere: string; const AOrderBy: string): TObjectList<M>; overload; virtual;
    function FindWhere(const AWhere: String; const AOrderBy: String; const APageNumber:Integer; const ARowsByPage:Integer):TObjectList<M>;overload; virtual;

    //Method REST Froms
    function FindFrom(const ASubResourceName: String): TObjectList<M>; virtual;
    procedure InsertFrom(const ASubResourceName: String); virtual;
    procedure UpdateFrom(const ASubResourceName: String); virtual;
    procedure DeleteFrom(const ASubResourceName: String); virtual;
    //
    function GetPackagePageCount(const AWhere: String; const ARowsByPage:Integer):Integer; virtual;
    function DeleteList: TObjectList<M>; virtual;
    function PrepareWhereFieldAll(AValue: String): String;
    function Response:TRESTResponseInfo; virtual;
    property FetchingRecords: Boolean read FFetchingRecords write FFetchingRecords;
  end;

implementation

uses
  goxormbr.core.objects.helper,
  goxormbr.core.mapping.explorer,
  goxormbr.core.mapping.classes;

{ TSessionAbstract<M> }

constructor TSessionAbstract<M>.Create(const APageSize: Integer = -1);
begin
  FPageSize := APageSize;
  FModifiedFields := TObjectDictionary<string, TDictionary<string, string>>.Create([doOwnsValues]);
  FDeleteList := TObjectList<M>.Create;
  FResultParams := TParams.Create;
  FFetchingRecords := False;
  // Inicia uma lista interna para gerenciar campos alterados
  FModifiedFields.Clear;
  FModifiedFields.TrimExcess;
  FModifiedFields.Add(M.ClassName, TDictionary<string, string>.Create);
end;

destructor TSessionAbstract<M>.Destroy;
begin
  FDeleteList.Clear;
  FDeleteList.Free;
  FModifiedFields.Clear;
  FModifiedFields.Free;
  FResultParams.Clear;
  FResultParams.Free;
  inherited;
end;


function TSessionAbstract<M>.PrepareWhereFieldAll(AValue: String): String;
const
  cPropertyTypes = [tkUnknown, tkInterface, tkClassRef, tkPointer, tkProcedure];
var
  LContext : TRttiContext;
  LKey: string;
  TypObject:  TRttiType;
  LProperty: TRttiProperty;
  LAttribute:  TCustomAttribute;
  LAttributeLoop:  TCustomAttribute;
  LWhere:  TStringBuilder;
  //
  LDate: TDate;
  LObject:M;
  LAttrib: TCustomAttribute;
  LTableName: string;
  //
  LInSearch :Boolean;
  LJoinColumn : TCustomAttribute;
  LCalcField : TCustomAttribute;
begin
  try
    try
      LContext := TRttiContext.Create;
      //Converte RttiType
      TypObject := LContext.GetType(M.ClassInfo);

      for LAttrib in TypObject.GetAttributes do
      begin
        if LAttrib is Table then
          LTableName := Table(LAttrib).Name+'.';
      end;
      LWhere := TStringBuilder.Create;
      //Loop nas property do Source
      for LProperty in TypObject.GetProperties do
      begin
        // Validação para entrar no IF somente propriedades que o tipo não esteja na lista
        if (LProperty.PropertyType.TypeKind in cPropertyTypes) then Continue;
        //------------------------------------------------------------------
        LCalcField := Nil;
        for var LAttribFor in LProperty.GetAttributes do
        begin
          if LAttribFor is CalcField then
          begin
            LCalcField := LAttribFor
          end;
        end;
        if LCalcField <> nil then Continue;
        //------------------------------------------------------------------
        LJoinColumn := Nil;
        for var LAttribFor in LProperty.GetAttributes do
        begin
          if LAttribFor is JoinColumn then
          begin
            LJoinColumn := LAttribFor
          end;
        end;
        if LJoinColumn <> nil then Continue;
        //------------------------------------------------------------------
        //
        //------------------------------------------------------------------
        for LAttribute in LProperty.GetAttributes do
        begin
          if LAttribute is Column then
          begin
            if Column(LAttribute).FieldType in [ftString] then
            begin
              if LWhere.Length > 0 then
                LWhere.Append(' OR ');
              //
              LWhere.Append(LTableName+LProperty.Name+' LIKE '+QuotedStr('%'+AValue+'%'));
            end
            else
            if Column(LAttribute).FieldType in [ftInteger,ftSmallint] then
            begin
              if LWhere.Length > 0 then
                LWhere.Append(' OR ');
              LWhere.Append(LTableName+LProperty.Name+' LIKE '+QuotedStr('%'+AValue+'%'));
            end
            else
            if Column(LAttribute).FieldType in [ftBCD,ftFMTBcd,ftCurrency] then
            begin
               if LWhere.Length > 0 then
                  LWhere.Append(' OR ');
                LWhere.Append(LTableName+LProperty.Name+' LIKE '+QuotedStr('%'+AValue+'%'));
            end;
//            else
//            if Column(LAttribute).FieldType in [ftDate] then
//            begin
//              if LWhere.Length > 0 then
//                LWhere.Append(' OR ');
//                LDate := StrToDateDef(ReplaceStr(ASearchValue,'-','/'),StrToDate('01/01/1500'));
//                LWhere.Append(LTableName+LProperty.Name+' = '+QuotedStr(FormatDateTime('YYYY-MM-DD',LDate)));
//            end;
          end;
        end;
      end;
    finally
      LContext.Free;
      Result := LWhere.ToString;
      FreeAndNil(LWhere);
    end;
  except on E: Exception do
    begin
      raise Exception.Create('GetWhereFieldAll:'+M.ClassName+':'+E.Message);
    end;
  end;
end;



function TSessionAbstract<M>.ModifiedFields: TDictionary<string, TDictionary<string, string>>;
begin
  Result := FModifiedFields;
end;

procedure TSessionAbstract<M>.Delete(const AObject: M);
begin
  FManager.DeleteInternal(AObject);
end;

procedure TSessionAbstract<M>.Delete(const APK: Int64);
begin
 // abstract;
end;

procedure TSessionAbstract<M>.DeleteFrom(const ASubResourceName: String);
begin
 // abstract;
end;

function TSessionAbstract<M>.DeleteList: TObjectList<M>;
begin
  Result := FDeleteList;
end;

function TSessionAbstract<M>.ExistSequence: Boolean;
begin
  Result := FManager.ExistSequence;
end;

function TSessionAbstract<M>.Find(const APK: string): M;
begin
  FFindWhereUsed := False;
  FFetchingRecords := False;
  Result := FManager.Find(APK);
end;

function TSessionAbstract<M>.FindWhere(const AWhere: String; const AOrderBy: String; const APageNumber, ARowsByPage: Integer): TObjectList<M>;
begin
 // abstract;
end;

function TSessionAbstract<M>.GetPackagePageCount(const AWhere: String; const ARowsByPage: Integer): Integer;
begin
  //abstract;
end;

function TSessionAbstract<M>.FindFrom(const ASubResourceName: String): TObjectList<M>;
begin
  //Abstract;
end;

function TSessionAbstract<M>.FindWhere(const AWhere, AOrderBy: string): TObjectList<M>;
begin
  FFindWhereUsed := True;
  FFetchingRecords := False;
  FWhere := AWhere;
  FOrderBy := AOrderBy;
//  if FPageSize > -1 then
//  begin
//    Result := NextPacketList(FWhere, FOrderBy, FPageSize, FPageNext);
//    Exit;
//  end;
  Result := FManager.FindWhere(FWhere, FOrderBy);
end;

procedure TSessionAbstract<M>.Insert(const AObjectList: TObjectList<M>);
begin
 // abstract;
end;

procedure TSessionAbstract<M>.InsertFrom(const ASubResourceName: String);
begin
 // abstract;
end;

function TSessionAbstract<M>.Find(const APK: Int64): M;
begin
  FFindWhereUsed := False;
  FFetchingRecords := False;
  Result := FManager.Find(APK);
end;

function TSessionAbstract<M>.Find: TObjectList<M>;
begin
  FFindWhereUsed := False;
  FFetchingRecords := False;
  Result := FManager.Find;
end;

procedure TSessionAbstract<M>.Insert(const AObject: M);
begin
  try
    FManager.InsertInternal(AObject);
  except on E: Exception do
    raise Exception.Create('Session Insert :'+E.Message);
  end;

end;

procedure TSessionAbstract<M>.ModifyFieldsCompare(const AKey: string;
  const AObjectSource, AObjectUpdate: TObject);
var
  LColumn: TColumnMapping;
  LColumns: TColumnMappingList;
  LProperty: TRttiProperty;
begin
  LColumns := TMappingExplorer.GetMappingColumn(AObjectSource.ClassType);
  for LColumn in LColumns do
  begin
    LProperty := LColumn.ColumnProperty;
    if LProperty.IsVirtualData then
      Continue;
    if LProperty.IsNoUpdate then
      Continue;
    if LProperty.PropertyType.TypeKind in cPROPERTYTYPES_1 then
      Continue;
    if not FModifiedFields.ContainsKey(AKey) then
      FModifiedFields.Add(AKey, TDictionary<string, string>.Create);
    // Se o tipo da property for tkRecord provavelmente tem Nullable nela
    // Se não for tkRecord entra no ELSE e pega o valor de forma direta
    if LProperty.PropertyType.TypeKind in [tkRecord] then // Nullable ou TBlob
    begin
      if LProperty.IsBlob then
      begin
        if LProperty.GetValue(AObjectSource).AsType<TBlob>.ToSize <>
           LProperty.GetValue(AObjectUpdate).AsType<TBlob>.ToSize then
        begin
          FModifiedFields.Items[AKey].Add(LProperty.Name, LColumn.ColumnName);
        end;
      end
      else
      begin
        if LProperty.GetNullableValue(AObjectSource).AsType<Variant> <>
           LProperty.GetNullableValue(AObjectUpdate).AsType<Variant> then
        begin
          FModifiedFields.Items[AKey].Add(LProperty.Name, LColumn.ColumnName);
        end;
      end;
    end
    else
    begin
      if LProperty.GetValue(AObjectSource).AsType<Variant> <>
         LProperty.GetValue(AObjectUpdate).AsType<Variant> then
      begin
        FModifiedFields.Items[AKey].Add(LProperty.Name, LColumn.ColumnName);
      end;
    end;
  end;
end;

procedure TSessionAbstract<M>.Open;
begin
  FFetchingRecords := False;
end;

procedure TSessionAbstract<M>.OpenWhere(const AWhere: String; AOrderBy: String; const APageNumber, ARowsByPage: Integer);
begin
  FFetchingRecords := False;
end;

procedure TSessionAbstract<M>.OpenID(const APK: Variant);
begin
  FFetchingRecords := False;
end;

procedure TSessionAbstract<M>.OpenSQL(const ASQL: string);
begin
  FFetchingRecords := False;
end;

procedure TSessionAbstract<M>.OpenWhere(const AWhere, AOrderBy: string);
begin
  FFetchingRecords := False;
end;


procedure TSessionAbstract<M>.RefreshRecord(const AColumns: TParams);
begin
 // abstract;
end;

function TSessionAbstract<M>.Response: TRESTResponseInfo;
begin
  //abstract
end;

function TSessionAbstract<M>.ResultParams: TParams;
begin
  Result := FResultParams;
end;

function TSessionAbstract<M>.SelectAssociation(const AObject: TObject): String;
begin
  Result := ''
end;

procedure TSessionAbstract<M>.Update(const AObjectList: TObjectList<M>);
begin
 // abstract;
end;

procedure TSessionAbstract<M>.UpdateFrom(const ASubResourceName: String);
begin
 // abstract;
end;

procedure TSessionAbstract<M>.Update(const AObject: M; const AKey: string);
begin
  FManager.UpdateInternal(AObject, FModifiedFields.Items[AKey]);
end;

end.
