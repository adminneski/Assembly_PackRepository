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


unit goxormbr.core.dbread;

interface
uses
  DB,
  Classes,
  SysUtils,
  Variants,
  goxormbr.core.types;
type

  IDBRead = interface
   ['{A5404B75-3D81-4D74-B971-FC9B3613A32E}']
    function GetFetchingAll: Boolean;
    procedure SetFetchingAll(const Value: Boolean);
    procedure Close;
    procedure Open(ASQL:String);
    function NotEof: Boolean;
    function RecordCount: Integer;
    function FieldDefs: TFieldDefs;
    function GetFieldValue(const AFieldName: string): Variant; overload;
    function GetFieldValue(const AFieldIndex: Integer): Variant; overload;
    function GetField(const AFieldName: string): TField;
    function GetFieldType(const AFieldName: string): TFieldType;
    function FieldByName(const AFieldName: string): TAsField;
    function DataSet: TDataSet;
    property FetchingAll: Boolean read GetFetchingAll write SetFetchingAll;
  end;

  TDBRead = class(TInterfacedObject, IDBRead)
  private
    FDBConnection: TGOXDBConnection;
    FDBQuery   : TGOXDBQuery;
    function GetFetchingAll: Boolean;
    procedure SetFetchingAll(const Value: Boolean);
  protected
    FField: TAsField;
    FFieldNameInternal: string;
    FRecordCount: Integer;
    FFetchingAll: Boolean;
    FFirstNext: Boolean;
  public
    constructor Create(ADBConnection: TGOXDBConnection);
    destructor Destroy; override;
    class function New(ADBConnection: TGOXDBConnection): IDBRead;
    procedure Close;
    procedure Open(ASQL:String);
    function NotEof: Boolean;
    function GetFieldValue(const AFieldName: string): Variant; overload;
    function GetFieldValue(const AFieldIndex: Integer): Variant; overload;
    function GetFieldType(const AFieldName: string): TFieldType;
    function GetField(const AFieldName: string): TField;
    function FieldByName(const AFieldName: string): TAsField;
    function RecordCount: Integer;
    function FieldDefs: TFieldDefs;
    function DataSet: TDataSet;
    property FetchingAll: Boolean read GetFetchingAll write SetFetchingAll;
  end;

  TDBReadField = class(TAsField)
  private
    FOwner: TDBRead;
  public
    constructor Create(AOwner: TDBRead);
    destructor Destroy; override;
    function IsNull: Boolean; override;
    function AsBlob: TMemoryStream; override;
    function AsBlobPtr(out iNumBytes: Integer): Pointer; override;
    function AsBlobText: string; override;
    function AsBlobTextDef(const Def: string = ''): string; override;
    function AsDateTime: TDateTime; override;
    function AsDateTimeDef(const Def: TDateTime = 0.0): TDateTime; override;
    function AsDouble: Double; override;
    function AsDoubleDef(const Def: Double = 0.0): Double; override;
    function AsInteger: Int64; override;
    function AsIntegerDef(const Def: Int64 = 0): Int64; override;
    function AsString: string; override;
    function AsStringDef(const Def: string = ''): string; override;
    function AsFloat: Double; override;
    function AsFloatDef(const Def: Double = 0): Double; override;
    function AsCurrency: Currency; override;
    function AsCurrencyDef(const Def: Currency = 0): Currency; override;
    function AsExtended: Extended; override;
    function AsExtendedDef(const Def: Extended = 0): Extended; override;
    function AsVariant: Variant; override;
    function AsVariantDef(const Def: Variant): Variant; override;
    function AsBoolean: Boolean; override;
    function AsBooleanDef(const Def: Boolean = False): Boolean; override;
    function Value: Variant; override;
    function ValueDef(const Def: Variant): Variant; override;
  end;
implementation

{ TDBRead }
function TDBRead.RecordCount: Integer;
begin
  Result := FDBQuery.RecordCount;
end;
procedure TDBRead.Close;
begin
  FDBQuery.Close;
end;

constructor TDBRead.Create(ADBConnection: TGOXDBConnection);
begin
  FDBConnection := ADBConnection;
  FField := TDBReadField.Create(Self);
  FFetchingAll := true;
  //
  if ADBConnection = nil then
    Exit;
end;

function TDBRead.DataSet: TDataSet;
begin
  Result := FDBQuery;
end;

destructor TDBRead.Destroy;
begin
  FField.Free;
  if Assigned(FDBQuery) then FreeAndNil(FDBQuery);
  inherited;
end;
function TDBRead.FieldByName(const AFieldName: string): TAsField;
begin
  FField.AsFieldName := AFieldName;
  Result := FField;
end;
function TDBRead.FieldDefs: TFieldDefs;
begin
 Result := FDBQuery.FieldDefs;
end;

Function TDBRead.GetFetchingAll: Boolean;
begin
  Result := FFetchingAll;
end;
function TDBRead.GetField(const AFieldName: string): TField;
begin
 Result := FDBQuery.FieldByName(AFieldName);
end;

function TDBRead.GetFieldType(const AFieldName: string): TFieldType;
begin
 Result := FDBQuery.FieldByName(AFieldName).DataType;
end;

function TDBRead.GetFieldValue(const AFieldIndex: Integer): Variant;
begin
  if AFieldIndex > FDBQuery.FieldCount -1  then
    Exit(Variants.Null);

  if FDBQuery.Fields[AFieldIndex].IsNull then
    Result := Variants.Null
  else
    Result := FDBQuery.Fields[AFieldIndex].Value;
end;

function TDBRead.GetFieldValue(const AFieldName: string): Variant;
var
  LField: TField;
begin
  LField := FDBQuery.FieldByName(AFieldName);
  Result := GetFieldValue(LField.Index);
end;

class function TDBRead.New(ADBConnection: TGOXDBConnection): IDBRead;
begin
  Result := TDBRead.Create(ADBConnection);
end;

function TDBRead.NotEof: Boolean;
begin
 if not FFirstNext then
    FFirstNext := True
  else
    FDBQuery.Next;
  Result := not FDBQuery.Eof;
end;

procedure TDBRead.Open(ASQL: String);
begin
  FDBQuery := FDBConnection.CreateGOXDBQuery(ASQL);
  if FFetchingAll then
   FDBQuery.FetchAll;
end;

procedure TDBRead.SetFetchingAll(const Value: Boolean);
begin
  FFetchingAll := Value;
end;

{ TAsField }
constructor TDBReadField.Create(AOwner: TDBRead);
begin
  FOwner := AOwner;
end;
destructor TDBReadField.Destroy;
begin
  FOwner := nil;
  inherited;
end;
function TDBReadField.AsBlob: TMemoryStream;
begin
//  Result := TMemoryStream( FOwner.GetFieldValue(FAsFieldName) );
  Result := nil;
end;
function TDBReadField.AsBlobPtr(out iNumBytes: Integer): Pointer;
begin
//  Result := Pointer( FOwner.GetFieldValue(FAsFieldName) );
  Result := nil;
end;
function TDBReadField.AsBlobText: string;
var
  LResult: Variant;
begin
  Result := '';
  LResult := FOwner.GetFieldValue(FAsFieldName);
  if LResult <> Null then
    Result := String(LResult);
end;
function TDBReadField.AsBlobTextDef(const Def: string): string;
begin
  try
    Result := String(FOwner.GetFieldValue(FAsFieldName));
  except
    Result := Def;
  end;
end;
function TDBReadField.AsBoolean: Boolean;
var
  LResult: Variant;
begin
  Result := False;
  LResult := FOwner.GetFieldValue(FAsFieldName);
  if LResult <> Null then
    Result := Boolean(Value);
end;
function TDBReadField.AsBooleanDef(const Def: Boolean): Boolean;
begin
  try
    Result := Boolean(FOwner.GetFieldValue(FAsFieldName));
  except
    Result := Def;
  end;
end;
function TDBReadField.AsCurrency: Currency;
var
  LResult: Variant;
begin
  Result := 0;
  LResult := FOwner.GetFieldValue(FAsFieldName);
  if LResult <> Null then
    Result := Currency(LResult);
end;
function TDBReadField.AsCurrencyDef(const Def: Currency): Currency;
begin
  try
    Result := Currency(FOwner.GetFieldValue(FAsFieldName));
  except
    Result := Def;
  end;
end;
function TDBReadField.AsDateTime: TDateTime;
var
  LResult: Variant;
begin
  Result := 0;
  LResult := FOwner.GetFieldValue(FAsFieldName);
  if LResult <> Null then
    Result := TDateTime(LResult);
end;
function TDBReadField.AsDateTimeDef(const Def: TDateTime): TDateTime;
begin
  try
    Result := TDateTime( FOwner.GetFieldValue(FAsFieldName) );
  except
    Result := Def;
  end;
end;
function TDBReadField.AsDouble: Double;
var
  LResult: Variant;
begin
  Result := 0;
  LResult := FOwner.GetFieldValue(FAsFieldName);
  if LResult <> Null then
    Result := Double(LResult);
end;
function TDBReadField.AsDoubleDef(const Def: Double): Double;
begin
  try
    Result := Double(FOwner.GetFieldValue(FAsFieldName));
  except
    Result := Def;
  end;
end;
function TDBReadField.AsExtended: Extended;
var
  LResult: Variant;
begin
  Result := 0;
  LResult := FOwner.GetFieldValue(FAsFieldName);
  if LResult <> Null then
    Result := Extended(LResult);
end;
function TDBReadField.AsExtendedDef(const Def: Extended): Extended;
begin
  try
    Result := Extended(FOwner.GetFieldValue(FAsFieldName));
  except
    Result := Def;
  end;
end;
function TDBReadField.AsFloat: Double;
var
  LResult: Variant;
begin
  Result := 0;
  LResult := FOwner.GetFieldValue(FAsFieldName);
  if LResult <> Null then
    Result := Double(LResult);
end;
function TDBReadField.AsFloatDef(const Def: Double): Double;
begin
  try
    Result := Double(FOwner.GetFieldValue(FAsFieldName));
  except
    Result := Def;
  end;
end;
function TDBReadField.AsInteger: Int64;
var
  LResult: Variant;
begin
  Result := 0;
  LResult := FOwner.GetFieldValue(FAsFieldName);
  if LResult <> Null then
    Result := LResult;
end;
function TDBReadField.AsIntegerDef(const Def: Int64): Int64;
begin
  try
    Result := FOwner.GetFieldValue(FAsFieldName);
  except
    Result := Def;
  end;
end;
function TDBReadField.AsString: string;
var
  LResult: Variant;
begin
  Result := '';
  LResult := FOwner.GetFieldValue(FAsFieldName);
  if LResult <> Null then
    Result := String(LResult);
end;
function TDBReadField.AsStringDef(const Def: string): string;
begin
  try
    Result := String(FOwner.GetFieldValue(FAsFieldName));
  except
    Result := Def;
  end;
end;
function TDBReadField.AsVariant: Variant;
begin
  Result := FOwner.GetFieldValue(FAsFieldName);
end;
function TDBReadField.AsVariantDef(const Def: Variant): Variant;
begin
  try
    Result := FOwner.GetFieldValue(FAsFieldName);
  except
    Result := Def;
  end;
end;
function TDBReadField.IsNull: Boolean;
begin
  Result := FOwner.GetFieldValue(FAsFieldName) = Null;
end;
function TDBReadField.Value: Variant;
begin
  Result := FOwner.GetFieldValue(FAsFieldName);
end;
function TDBReadField.ValueDef(const Def: Variant): Variant;
begin
  try
    Result := FOwner.GetFieldValue(FAsFieldName);
  except
    Result := Def;
  end;
end;
    end.
