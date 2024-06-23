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

unit goxormbr.core.types.mapping;
interface
type
  TRuleAction = (None, Cascade, SetNull, SetDefault);
  TSortingOrder = (NoSort, Ascending, Descending);
  TMultiplicity = (OneToOne, OneToMany, ManyToOne, ManyToMany);
  TGenerated = (Never, Insert, Always);
  TJoin = (InnerJoin, LeftJoin, RightJoin, FullJoin);
  TSequenceType = (NotInc, AutoInc, TableInc, GuidInc);
  TRestriction = (NotNull, NoInsert, NoUpdate, NoValidate, Unique, Hidden, VirtualData);
  TRestrictions = set of TRestriction;
  TCascadeAction = (CascadeNone, CascadeAutoInc, CascadeInsert, CascadeUpdate, CascadeDelete);
  TCascadeActions = set of TCascadeAction;
  TMasterEvent = (AutoPost, AutoEdit, AutoInsert);
  TMasterEvents = set of TMasterEvent;
  TEnumType = (etChar, etString, etInteger, etBoolean);
  TFieldEvent = (onChange, onGetText, onSetText, onValidate);
  TFieldEvents = set of TFieldEvent;
implementation
end.
