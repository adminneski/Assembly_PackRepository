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

unit goxormbr.core.types;

{$INCLUDE ..\goxorm.inc}

interface

uses
  DB,
  Classes,
  SysUtils,
  system.JSON,
  {$IFDEF USE_ENGINE_DAC_FIREDAC}
   FireDAC.Comp.Client,
  {$ENDIF}
  Variants;

type
  TDriverType = (dnMSSQL, dnPostgreSQL, dnFirebird, dnSQLite);
  TRESTRequestMethodType = (rtPOST, rtPUT, rtGET, rtDELETE, rtPATCH);
  TRESTProtocol = (Http, Https);

//  TBeforeCommandEvent = procedure (ARequestMethod: String) of object;
//  TAfterCommandEvent = procedure (AStatusCode: Integer;
//                                  var AResponseString: String;
//                                  ARequestMethod: String) of object;

  TErrorCommandEvent = procedure (const AURLBase: String;
                                  const AResource: String;
                                  const ASubResource: String;
                                  const ARequestMethod: String;
                                  const AMessage: String;
                                  const AResponseCode: Integer) of object;
  //
  TRESTAuthenticator = class
  private
  protected
    FUsername: String;
    FPassword: String;
    FToken: String;
  public
    property Token: String read FToken write FToken;
    property Username: String read FUsername write FUsername;
    property Password: String read FPassword write FPassword;
  end;
  //
  TRESTProxyInfo = class
  private
  protected
    FProxyPort: Integer;
    FPassword: string;
    FUsername: string;
    FProxyServer: string;
  public
    property ProxyPassword: string read FPassword write FPassword;
    property ProxyPort: Integer read FProxyPort write FProxyPort;
    property ProxyServer: string read FProxyServer write FProxyServer;
    property ProxyUsername: string read FUsername write FUserName;
  end;
  //
  TRESTResponseInfo = class
  private
  protected
    FStatus          :Integer;
    FStatusType      :String;
    FMessage         :String;
    FUnitName        :String;
    FClassName       :String;
    FFunctionName    :String;
    FExceptionMessage:String;
    FPackageCount    :Integer;
    FJSONResponse    :String;
    FData            :String;
  public
    property Status: Integer read FStatus write FStatus;
    property StatusType: String read FStatusType write FStatusType;
    property &Message: String read FMessage write FMessage;
    property UnitName: String read FUnitName write FUnitName;
    property ClassName: String read FClassName write FClassName;
    property FunctionName: String read FFunctionName write FFunctionName;
    property ExceptionMessage: String read FExceptionMessage write FExceptionMessage;
    property PackageCount: Integer read FPackageCount write FPackageCount;
    property JSONResponse: String read FJSONResponse write FJSONResponse;
    property Data: String read FData write FData;
  end;


  //Object GOXMemTable Somente herdado apenas para
  //diminuir aclopamento das tabelas em Memorias dos Engine
  TGOXMemTable = class({$IFDEF USE_FDMEMTABLE}TFDMemTable{$ENDIF}
                       {$IFDEF USE_CLIENTDATASET}TClientDataSet{$ENDIF})
  end;


  TGOXDBQuery = Class({$IFDEF USE_ENGINE_DAC_FIREDAC}TFDQuery{$ENDIF}
                      {$IFDEF USE_ENGINE_DAC_ZEOS}                {$ENDIF})
  private
  protected
  public
    function ToJSON: String;
  End;

  TGOXDBConnection = Class({$IFDEF USE_ENGINE_DAC_FIREDAC}TFDConnection{$ENDIF}
                           {$IFDEF USE_ENGINE_DAC_ZEOS}                {$ENDIF})
  private
  protected
  public
    procedure Connect; virtual; abstract;
    procedure Disconnect; virtual; abstract;
    function IsConnected: Boolean; virtual; abstract;
    procedure ExecuteSQL(const ASQL: string); overload; virtual; abstract;
    procedure ExecuteSQL(const ASQL: string; const AParams: TParams);overload; virtual; abstract;
    function DriverType: TDriverType; virtual; abstract;
    //
    function OpenSQL(const ASQL: string): TGOXDBQuery; virtual; abstract;
    function CreateGOXDBQuery(const ASQL: string = ''): TGOXDBQuery; virtual; abstract;
  End;
  //
  //
  TGOXRESTConnection = Class
  private
  protected
//  FRESTConnection: TGOXRESTConnection;
    FErrorCommand: TErrorCommandEvent;
//    FProtocol: TRESTProtocol;
    FResponseInfo : TRESTResponseInfo;
    FProxyParams: TRESTProxyInfo;
    FAuthenticator: TRESTAuthenticator;
    //
    FPathParams: TParams;
    FBodyParams: TParams;
    FQueryParams: TParams;
    //
    FURLBase: String;
    FProtocol: String;
    FHost: String;
    FPort: String;
    //
    FMethodSelect: String;
    FMethodSelectID: String;
    FMethodSelectWhere: String;
    FMethodSelectWherePackage: String;
    FMethodInsert: String;
    FMethodUpdate: String;
    FMethodDelete: String;
    //
    FMethodToken: String;
    FStatusCode:Integer;
    /// <summary> Variables the Events </summary>
    FRequestMethod: String;
    FResponseString: String;

  public
    function GetErrorCommand: TErrorCommandEvent; virtual; abstract;
    procedure SetErrorCommand(const Value: TErrorCommandEvent); virtual; abstract;
    //
    function Execute(const AResource, ASubResource: String; const ARequestMethod: TRESTRequestMethodType; const AParams: String = ''): String; virtual; abstract;
    //
    procedure AddPathParam(const AValue: String); virtual; abstract;
    procedure AddQueryParam(const AKeyName:String; const AValue: String); virtual; abstract;
    procedure AddBodyParam(AValue: String); virtual; abstract;
    //
    property Protocol: String  read FProtocol;
    property Host: String      read FHost;
    property Port: String      read FPort;
    //
    property MethodGET: String read FMethodSelect write FMethodSelect;
    property MethodGETId: String read FMethodSelectID write FMethodSelectID;
    property MethodGETWhere: String read FMethodSelectWhere write FMethodSelectWhere;
    property MethodGETWherePackage: String read FMethodSelectWherePackage write FMethodSelectWherePackage;
    property MethodPOST: String read FMethodInsert write FMethodInsert;
    property MethodPUT: String read FMethodUpdate write FMethodUpdate;
    property MethodDELETE: String read FMethodDelete write FMethodDelete;
    property MethodToken: String read FMethodToken write FMethodToken;
    //
//    property Protocol     : TRESTProtocol      read FProtocol      write FProtocol;
    property ProxyParams  : TRESTProxyInfo     read FProxyParams   write FProxyParams;
    property Authenticator: TRESTAuthenticator read FAuthenticator write FAuthenticator;
    property Response     : TRESTResponseInfo  read FResponseInfo  write FResponseInfo;
    //
    property OnErrorCommand: TErrorCommandEvent read GetErrorCommand write SetErrorCommand;

  End;
  //
  //--
  TAsField = class abstract
  protected
    FAsFieldName: String;
  public
    function IsNull: Boolean; virtual; abstract;
    function AsBlob: TMemoryStream; virtual; abstract;
    function AsBlobPtr(out iNumBytes: Integer): Pointer; virtual; abstract;
    function AsBlobText: string; virtual; abstract;
    function AsBlobTextDef(const Def: string = ''): string; virtual; abstract;
    function AsDateTime: TDateTime; virtual; abstract;
    function AsDateTimeDef(const Def: TDateTime = 0.0): TDateTime; virtual; abstract;
    function AsDouble: Double; virtual; abstract;
    function AsDoubleDef(const Def: Double = 0.0): Double; virtual; abstract;
    function AsInteger: Int64; virtual; abstract;
    function AsIntegerDef(const Def: Int64 = 0): Int64; virtual; abstract;
    function AsString: string; virtual; abstract;
    function AsStringDef(const Def: string = ''): string; virtual; abstract;
    function AsFloat: Double; virtual; abstract;
    function AsFloatDef(const Def: Double = 0): Double; virtual; abstract;
    function AsCurrency: Currency; virtual; abstract;
    function AsCurrencyDef(const Def: Currency = 0): Currency; virtual; abstract;
    function AsExtended: Extended; virtual; abstract;
    function AsExtendedDef(const Def: Extended = 0): Extended; virtual; abstract;
    function AsVariant: Variant; virtual; abstract;
    function AsVariantDef(const Def: Variant): Variant; virtual; abstract;
    function AsBoolean: Boolean; virtual; abstract;
    function AsBooleanDef(const Def: Boolean = False): Boolean; virtual; abstract;
    function Value: Variant; virtual; abstract;
    function ValueDef(const Def: Variant): Variant; virtual; abstract;
    //function AsFieldName(AAsFieldName:String): String; virtual; abstract;
    property AsFieldName: String read FAsFieldName write FAsFieldName;
  end;

const
  TStrDriverName: array[dnMSSQL..dnSQLite] of string = ('MSSQL','PostgreSQL','Firebird','SQLite');

implementation


{ TGOXDBQuery }

function TGOXDBQuery.ToJSON:String;
var
 Field_name, ColumnName, ColumnValue : String;
 I: Integer;
 LJSONObject:TJsonObject;
begin
  try
    LJSONObject:= TJSONObject.Create;
    while (not Self.EOF) do
    begin
      for I := 0 to Self.FieldDefs.Count-1 do
      begin
        ColumnName  := Self.FieldDefs[I].Name;
        Case Self.FieldDefs[I].Datatype of
           ftBoolean:
           begin
             IF Self.FieldByName(Self.FieldDefs[I].Name).Value = True then
               LJSONObject.AddPair(TJSONPair.Create(TJSONString.Create( ColumnName),TJSONTrue.Create)) else
               LJSONObject.AddPair(TJSONPair.Create(TJSONString.Create( ColumnName),TJSONFalse.Create));
           end;
           ftInteger,ftFloat,ftSmallint,ftWord,ftCurrency :
           Begin
              LJSONObject.AddPair(TJSONPair.Create(TJSONString.Create( ColumnName),TJSONNumber.Create(Self.FieldByName(Self.FieldDefs[I].Name).AsFloat)));
           End;
           ftDate,ftDatetime,ftTime:
           begin
              LJSONObject.AddPair(TJSONPair.Create(TJSONString.Create( ColumnName),TJSONString.Create(Self.FieldByName(Self.FieldDefs[I].Name).AsString)));
           end
           else
             LJSONObject.AddPair(TJSONPair.Create(TJSONString.Create( ColumnName),TJSONString.Create(Self.FieldByName(Self.FieldDefs[I].Name).AsString)));
         End;
        Self.Next;
      end;
      Self.EndBatch;
    end;
  finally
    Result := LJSonObject.ToJSON;
  end;
end;

end.
