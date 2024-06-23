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

unit goxormbr.engine.connection;

interface

uses
  Classes,
  sysutils,
  DB,
  Variants,
  StrUtils,
  {$IFDEF USE_ENGINE_DAC_FIREDAC}
   FireDAC.Comp.Client,
   goxormbr.engine.dbconnection.firedac,
  {$ENDIF}
  {$IFDEF USE_ENGINE_DAC_ZEOS}
  {$ENDIF}
  //
  {$IFDEF USE_ENGINE_REST_WIRL}
   goxormbr.engine.restconnection.wirl,
  {$ENDIF}
  {$IFDEF USE_ENGINE_REST_HORSE}
  {$ENDIF}
  goxormbr.core.types;

type
  // GOXORM Engine DAC
  TGOXDBConnectionEngine = class({$IFDEF USE_ENGINE_DAC_FIREDAC}TGOXDBConnectionFireDAC{$ENDIF}
                                 {$IFDEF USE_ENGINE_DAC_ZEOS}                          {$ENDIF})
  private
  public
    constructor Create(const AOwner: TComponent; const ADriverType: TDriverType);
  end;


  // GOXORM Engine REST
  TGOXRESTConnectionEngine = class({$IFDEF USE_ENGINE_REST_WIRL}TGOXRESTConnectionWiRL{$ENDIF}
                                   {$IFDEF USE_ENGINE_REST_HORSE}                     {$ENDIF})
  private
  public
    constructor Create(const AURLBase:String = '');
    destructor Destroy; override;
  end;




implementation

{ TGOXDBConnectionEngine }
constructor TGOXDBConnectionEngine.Create(const AOwner: TComponent; const ADriverType: TDriverType);
begin
   inherited Create(AOwner, ADriverType);
end;


{ TGOXRESTConnectionEngine }
constructor TGOXRESTConnectionEngine.Create(const AURLBase:String);
begin
  Inherited Create(AURLBase);
end;

destructor TGOXRESTConnectionEngine.Destroy;
begin
  inherited;
end;



end.
