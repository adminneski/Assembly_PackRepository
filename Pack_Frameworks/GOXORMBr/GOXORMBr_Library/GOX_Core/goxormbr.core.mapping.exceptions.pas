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

unit goxormbr.core.mapping.exceptions;
interface
uses
  SysUtils,
  Rtti;
type
  EClassNotRegistered = class(Exception)
  public
    constructor Create(AClass: TClass);
  end;
  EFieldNotNull = class(Exception)
  public
    constructor Create(const ADisplayLabel: String);
  end;
  EFieldValidate = class(Exception)
  public
    constructor Create(const AField: string; const AMensagem: string);
  end;
  EMinimumValueConstraint = class(Exception)
  public
    constructor Create(const ADisplayLabel: String;
      const AValue: Double);
  end;
  EMaximumValueConstraint = class(Exception)
  public
    constructor Create(const ADisplayLabel: String; const AValue: Double);
  end;
  ENotEmptyConstraint = class(Exception)
  public
    constructor Create(const ADisplayLabel: String);
  end;
  EMaxLengthConstraint = class(Exception)
  public
    constructor Create(const ADisplayLabel: String; const MaxLength: Integer);
  end;
  EMinLengthConstraint = class(Exception)
  public
    constructor Create(const ADisplayLabel: String; const MinLength: Integer);
  end;
  EDefaultExpression = class(Exception)
  public
    constructor Create(const ADefault, AColumnName, AClassName: string);
  end;
implementation

{ EClassNotRegistered }
constructor EClassNotRegistered.Create(AClass: TClass);
begin
   inherited CreateFmt('Classe %s não registrada. Registre no Initialization usando TRegisterClasses.GetInstance.RegisterClass(%s)',
                       [AClass.ClassName]);
end;
{ EFieldNotNull }
constructor EFieldNotNull.Create(const ADisplayLabel: String);
begin
  inherited CreateFmt('Campo [ %s ] não pode ser vazio',
                      [ADisplayLabel]);
end;
{ EHighestConstraint }
constructor EMinimumValueConstraint.Create(const ADisplayLabel: String;
  const AValue: Double);
begin
  inherited CreateFmt('O valor mínimo do campo [ %s ] permitido é [ %s ]!',
                      [ADisplayLabel, FloatToStr(AValue)]);
end;
{ EFieldValidate }
constructor EFieldValidate.Create(const AField: string; const AMensagem: string);
begin
  inherited CreateFmt('[ %s ] %s',
                      [AField, AMensagem]);
end;
{ EDefaultExpression }
constructor EDefaultExpression.Create(const ADefault, AColumnName, AClassName: string);
begin
  inherited CreateFmt('O valor Default [ %s ] do campo [ %s ] na classe [ %s ], é inválido!',
                      [ADefault, AColumnName, AClassName]);
end;
{ EMaximumValueConstraint }
constructor EMaximumValueConstraint.Create(const ADisplayLabel: String; const AValue: Double);
begin
  inherited CreateFmt('O valor máximo do campo [ %s ] permitido é [ %s ]!',
                      [ADisplayLabel, FloatToStr(AValue)]);
end;
{ ENotEmptyConstraint }
constructor ENotEmptyConstraint.Create(const ADisplayLabel: String);
begin
  inherited CreateFmt('O campo [ %s ] não pode ser vazio!', [ADisplayLabel]);
end;
{ EMaxLengthConstraint }
constructor EMaxLengthConstraint.Create(const ADisplayLabel: String; const MaxLength: Integer);
begin
  inherited CreateFmt('O campo [ %s ] não pode ter o tamanho maior que %s!', [ADisplayLabel, IntToStr(MaxLength)]);
end;
{ EMinLengthConstraint }
constructor EMinLengthConstraint.Create(const ADisplayLabel: String; const MinLength: Integer);
begin
  inherited CreateFmt('O campo [ %s ] não pode ter o tamanho menor que %s!', [ADisplayLabel, IntToStr(MinLength)]);
end;
end.
