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

unit goxormbr.core.fields;

interface
uses
  DB,
  Math,
  Classes,
  SysUtils,
  Variants,
  //GOXORM
  goxormbr.core.types;

type

  //Classe Base Query
//  TGOXDBQueryBase = class(TInterfacedObject,IGOXDBQuery)
//  protected
//    FDataSet: TDataSet;
//    FField: TAsField;
//    FFieldNameInternal: string;
//    FRecordCount: Integer;
//    FFetchingAll: Boolean;
//    FFirstNext: Boolean;
//    //
//    function GetFetchingAll: Boolean; virtual; abstract;
//    procedure SetFetchingAll(const Value: Boolean); virtual; abstract;
//    function GetCommandText: string; virtual; abstract;
//    procedure SetCommandText(ACommandText: string); virtual; abstract;
//  public
//    procedure Close; virtual; abstract;
//    procedure OpenSQL; overload; virtual; abstract;
//    procedure OpenSQL(ASQL:String); overload; virtual; abstract;
//    function NotEof: Boolean; virtual; abstract;
//    function FieldByName(const AFieldName: string): TAsField; virtual; abstract;
//    function GetFieldValue(const AFieldName: string): Variant; overload; virtual; abstract;
//    function GetFieldValue(const AFieldIndex: Integer): Variant; overload; virtual; abstract;
//    function GetFieldType(const AFieldName: string): TFieldType; overload; virtual; abstract;
//    function GetField(const AFieldName: string): TField; virtual; abstract;
//    function RecordCount: Integer; virtual; abstract;
//    function FieldDefs: TFieldDefs; virtual; abstract;
//    //
//    function ExecuteDirect:Integer; virtual; abstract;
//    function ExecSQL:Integer; overload; virtual; abstract;
//    function ExecSQL(ASQL:String):Integer; overload; virtual; abstract;
//    function ExecuteQuery: IGOXDBQuery; virtual; abstract;
//    function DataSet: TDataSet; virtual; abstract;
//    //
//    property CommandText: string read GetCommandText write SetCommandText;
//    property FetchingAll: Boolean read GetFetchingAll write SetFetchingAll;
//  end;

//  // Connection
//  TGOXDBConnectionBase = class(TInterfacedObject,IGOXDBConnection)
//  protected
//    FDriverName: TDriverName;
//  public
//    procedure StartTransaction; virtual; abstract;
//    procedure Commit; virtual; abstract;
//    procedure Rollback; virtual; abstract;
//    procedure Connect; virtual; abstract;
//    procedure Disconnect; virtual; abstract;
//    procedure ExecuteDirect(const ASQL: string); overload; virtual; abstract;
//    procedure ExecuteDirect(const ASQL: string; const AParams: TParams); overload; virtual; abstract;
//    procedure ExecuteScript(const ASQL: string); virtual; abstract;
//    procedure AddScript(const ASQL: string); virtual; abstract;
//    procedure ExecuteScripts; virtual; abstract;
//    function IsConnected: Boolean; virtual; abstract;
//    function InTransaction: Boolean; virtual; abstract;
//    function CreateQuery: IGOXDBQuery; virtual; abstract;
//    function OpenSQL(const ASQL: string): IGOXDBQuery; virtual; abstract;
//    function DriverName: TDriverName; virtual; abstract;
//  end;
//
  TDBEBrField = class(TAsField)
  private
    FOwner: TGOXDBQuery;
  public
    constructor Create(AOwner: TGOXDBQuery);
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
   // function AsFieldName(AAsFieldName:String): String; override;
  end;


implementation

{ TAsField }
constructor TDBEBrField.Create(AOwner: TGOXDBQuery);
begin
  FOwner := AOwner;
end;
destructor TDBEBrField.Destroy;
begin
  FOwner := nil;
  inherited;
end;
function TDBEBrField.AsBlob: TMemoryStream;
begin
//  Result := TMemoryStream( FOwner.GetFieldValue(FAsFieldName) );
  Result := nil;
end;
function TDBEBrField.AsBlobPtr(out iNumBytes: Integer): Pointer;
begin
//  Result := Pointer( FOwner.GetFieldValue(FAsFieldName) );
  Result := nil;
end;
function TDBEBrField.AsBlobText: string;
var
  LResult: Variant;
begin
  Result := '';
//  LResult := FOwner.GetFieldValue(FAsFieldName);
  if LResult <> Null then
    Result := String(LResult);
end;
function TDBEBrField.AsBlobTextDef(const Def: string): string;
begin
  try
 //   Result := String(FOwner.GetFieldValue(FAsFieldName));
  except
    Result := Def;
  end;
end;
function TDBEBrField.AsBoolean: Boolean;
var
  LResult: Variant;
begin
  Result := False;
 // LResult := FOwner.GetFieldValue(FAsFieldName);
  if LResult <> Null then
    Result := Boolean(Value);
end;
function TDBEBrField.AsBooleanDef(const Def: Boolean): Boolean;
begin
  try
  //  Result := Boolean(FOwner.GetFieldValue(FAsFieldName));
  except
    Result := Def;
  end;
end;
function TDBEBrField.AsCurrency: Currency;
var
  LResult: Variant;
begin
  Result := 0;
 // LResult := FOwner.GetFieldValue(FAsFieldName);
  if LResult <> Null then
    Result := Currency(LResult);
end;
function TDBEBrField.AsCurrencyDef(const Def: Currency): Currency;
begin
  try
  //  Result := Currency(FOwner.GetFieldValue(FAsFieldName));
  except
    Result := Def;
  end;
end;
function TDBEBrField.AsDateTime: TDateTime;
var
  LResult: Variant;
begin
  Result := 0;
 // LResult := FOwner.GetFieldValue(FAsFieldName);
  if LResult <> Null then
    Result := TDateTime(LResult);
end;
function TDBEBrField.AsDateTimeDef(const Def: TDateTime): TDateTime;
begin
  try
   // Result := TDateTime( FOwner.GetFieldValue(FAsFieldName) );
  except
    Result := Def;
  end;
end;
function TDBEBrField.AsDouble: Double;
var
  LResult: Variant;
begin
  Result := 0;
 // LResult := FOwner.GetFieldValue(FAsFieldName);
  if LResult <> Null then
    Result := Double(LResult);
end;
function TDBEBrField.AsDoubleDef(const Def: Double): Double;
begin
  try
  //  Result := Double(FOwner.GetFieldValue(FAsFieldName));
  except
    Result := Def;
  end;
end;
function TDBEBrField.AsExtended: Extended;
var
  LResult: Variant;
begin
  Result := 0;
 // LResult := FOwner.GetFieldValue(FAsFieldName);
  if LResult <> Null then
    Result := Extended(LResult);
end;
function TDBEBrField.AsExtendedDef(const Def: Extended): Extended;
begin
  try
   // Result := Extended(FOwner.GetFieldValue(FAsFieldName));
  except
    Result := Def;
  end;
end;

//function TDBEBrField.AsFieldName(AAsFieldName: String): String;
//begin
//  FAsFieldName := AAsFieldName;
//end;

function TDBEBrField.AsFloat: Double;
var
  LResult: Variant;
begin
  Result := 0;
 // LResult := FOwner.GetFieldValue(FAsFieldName);
  if LResult <> Null then
    Result := Double(LResult);
end;
function TDBEBrField.AsFloatDef(const Def: Double): Double;
begin
  try
  //  Result := Double(FOwner.GetFieldValue(FAsFieldName));
  except
    Result := Def;
  end;
end;
function TDBEBrField.AsInteger: Int64;
var
  LResult: Variant;
begin
  Result := 0;
 // LResult := FOwner.GetFieldValue(FAsFieldName);
  if LResult <> Null then
    Result := LResult;
end;
function TDBEBrField.AsIntegerDef(const Def: Int64): Int64;
begin
  try
  //  Result := FOwner.GetFieldValue(FAsFieldName);
  except
    Result := Def;
  end;
end;
function TDBEBrField.AsString: string;
var
  LResult: Variant;
begin
  Result := '';
 // LResult := FOwner.GetFieldValue(FAsFieldName);
  if LResult <> Null then
    Result := String(LResult);
end;
function TDBEBrField.AsStringDef(const Def: string): string;
begin
  try
 //   Result := String(FOwner.GetFieldValue(FAsFieldName));
  except
    Result := Def;
  end;
end;
function TDBEBrField.AsVariant: Variant;
begin
//  Result := FOwner.GetFieldValue(FAsFieldName);
end;
function TDBEBrField.AsVariantDef(const Def: Variant): Variant;
begin
  try
 //   Result := FOwner.GetFieldValue(FAsFieldName);
  except
    Result := Def;
  end;
end;
function TDBEBrField.IsNull: Boolean;
begin
 // Result := FOwner.GetFieldValue(FAsFieldName) = Null;
end;
function TDBEBrField.Value: Variant;
begin
 // Result := FOwner.GetFieldValue(FAsFieldName);
end;
function TDBEBrField.ValueDef(const Def: Variant): Variant;
begin
  try
  //  Result := FOwner.GetFieldValue(FAsFieldName);
  except
    Result := Def;
  end;
end;


end.
