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

unit goxormbr.core.utils;

interface

uses
  Rtti,
  Classes,
  SysUtils,
  StrUtils,
  Variants,
  Generics.Collections;

type
  TStrArray = array of String;
  PIInterface = ^IInterface;

  IUtilSingleton = interface
    ['{D41BA6C1-EFDB-4C58-937A-59B864A8F0F4}']
    function DateTimeToIso8601(const AValue: TDateTime): string;
    function Iso8601ToDateTime(const AValue: string): TDateTime;
    function ParseCommandNoSQL(const ASubStr, ACommandText: string;

      const ADefault: String = ''): string;

  end;

  TUtilSingleton = class sealed(TInterfacedObject, IUtilSingleton)
  private
  class var
    FInstance: IUtilSingleton;
  private
    constructor CreatePrivate;
  protected
    constructor Create;
  public
    { Public declarations }
    class function GetInstance: IUtilSingleton;
    function DateTimeToIso8601(const AValue: TDateTime): string;
    function Iso8601ToDateTime(const AValue: string): TDateTime;
    function ParseCommandNoSQL(const ASubStr, ASQL: string;
      const ADefault: String): string;
    function IfThen<T>(ACondition: Boolean; ATrue: T; AFalse: T): T;
    procedure SetWeak(AInterfaceField: PIInterface; const AValue: IInterface);
  end;

implementation

{ TUtilSingleton }

procedure TUtilSingleton.SetWeak(AInterfaceField: PIInterface; const AValue: IInterface);
begin
  PPointer(AInterfaceField)^ := Pointer(AValue);
end;

constructor TUtilSingleton.Create;
begin
  raise Exception.Create('Para usar o IUtilSingleton use o método TUtilSingleton.GetInstance()');
end;

constructor TUtilSingleton.CreatePrivate;
begin
  inherited;
end;

/// <summary>
/// YYYY-MM-DD Thh:mm:ss or YYYY-MM-DDThh:mm:ss
/// </summary>
function TUtilSingleton.DateTimeToIso8601(const AValue: TDateTime): string;
begin
  if AValue = 0 then
    Result := ''
  else
  if Frac(AValue) = 0 then
    Result := FormatDateTime('yyyy"-"mm"-"dd', AValue)
  else
  if Trunc(AValue) = 0 then
    Result := FormatDateTime('"T"hh":"nn":"ss', AValue)
  else
    Result := FormatDateTime('yyyy"-"mm"-"dd"T"hh":"nn":"ss', AValue);
end;

class function TUtilSingleton.GetInstance: IUtilSingleton;
begin
  if not Assigned(FInstance) then
    FInstance := TUtilSingleton.CreatePrivate;
   Result := FInstance;
end;

function TUtilSingleton.IfThen<T>(ACondition: Boolean; ATrue, AFalse: T): T;
begin
  Result := AFalse;
  if ACondition then
    Result := ATrue;
end;

function TUtilSingleton.Iso8601ToDateTime(const AValue: string): TDateTime;
var
  Y, M, D, HH, MI, SS: Cardinal;
begin
  // YYYY-MM-DD   Thh:mm:ss  or  YYYY-MM-DDThh:mm:ss
  // 1234567890   123456789      1234567890123456789
  Result := StrToDateTimeDef(AValue, 0);
  case Length(AValue) of
    9:
      if (AValue[1] = 'T') and (AValue[4] = ':') and (AValue[7] = ':') then
      begin
        HH := Ord(AValue[2]) * 10 + Ord(AValue[3]) - (48 + 480);
        MI := Ord(AValue[5]) * 10 + Ord(AValue[6]) - (48 + 480);
        SS := Ord(AValue[8]) * 10 + Ord(AValue[9]) - (48 + 480);
        if (HH < 24) and (MI < 60) and (SS < 60) then
          Result := EncodeTime(HH, MI, SS, 0);
      end;
    10:
      if (AValue[5] = AValue[8]) and (Ord(AValue[8]) in [Ord('-'), Ord('/')]) then
      begin
        Y := Ord(AValue[1]) * 1000 + Ord(AValue[2]) * 100 + Ord(AValue[3]) * 10 + Ord(AValue[4]) - (48 + 480 + 4800 + 48000);
        M := Ord(AValue[6]) * 10 + Ord(AValue[7]) - (48 + 480);
        D := Ord(AValue[9]) * 10 + Ord(AValue[10]) - (48 + 480);
        if (Y <= 9999) and ((M - 1) < 12) and ((D - 1) < 31) then
          Result := EncodeDate(Y, M, D);
      end;
    19,24:
      if (AValue[5] = AValue[8]) and
         (Ord(AValue[8]) in [Ord('-'), Ord('/')]) and
         (Ord(AValue[11]) in [Ord(' '), Ord('T')]) and
         (AValue[14] = ':') and
         (AValue[17] = ':') then
      begin
        Y := Ord(AValue[1]) * 1000 + Ord(AValue[2]) * 100 + Ord(AValue[3]) * 10 + Ord(AValue[4]) - (48 + 480 + 4800 + 48000);
        M := Ord(AValue[6]) * 10 + Ord(AValue[7]) - (48 + 480);
        D := Ord(AValue[9]) * 10 + Ord(AValue[10]) - (48 + 480);
        HH := Ord(AValue[12]) * 10 + Ord(AValue[13]) - (48 + 480);
        MI := Ord(AValue[15]) * 10 + Ord(AValue[16]) - (48 + 480);
        SS := Ord(AValue[18]) * 10 + Ord(AValue[19]) - (48 + 480);
        if (Y <= 9999) and ((M - 1) < 12) and ((D - 1) < 31) and (HH < 24) and (MI < 60) and (SS < 60) then
          Result := EncodeDate(Y, M, D) + EncodeTime(HH, MI, SS, 0);
      end;
  end;
end;

function TUtilSingleton.ParseCommandNoSQL(const ASubStr, ASQL: string;
  const ADefault: String): string;
var
  LFor: Integer;
  LPosI: Integer;
  LPosF: Integer;
begin
  Result := '';
  LPosI := Pos(ASubStr + '=', ASQL);
  try
    if LPosI > 0 then
    begin
      LPosI := LPosI + Length(ASubStr);
      for LFor := LPosI to Length(ASQL) do
      begin
        case ASQL[LFor] of
          '=': LPosI := LFor;
          '&': begin
                 if (not MatchText(ASubStr, ['values','json'])) then
                   Break;
               end;
        end;
//        if (ASQL[LFor] = '=') then
//          LPosI := LFor
//        else
//        if (ASQL[LFor] = ',') and
//           (not MatchText(ASubStr, ['values','json'])) then
//          Break;
      end;
      LPosF  := LFor - LPosI;
      Result := Copy(ASQL, LPosI+1, LPosF-1);
    end;
  finally
    if (Result = '') and (ADefault <> '') then
      Result := ADefault
  end;
end;

end.
