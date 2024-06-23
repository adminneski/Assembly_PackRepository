unit Repository.Manager.db;

interface

uses
  DB,
  SysUtils,
  Variants,
  Generics.Collections,
  FireDAC.Comp.Client,
  //GOXORMBr
  goxormbr.manager.dataset,
  goxormbr.manager.objectset,
  goxormbr.core.abstract.types,
  Core.Database.Connection;

type
  //********************************************************************************
  // Classes Repository Criada para Diminuir o Acoplamento ORM dentro da Aplicação
  //********************************************************************************

  TRepositoryManagerObjectSet = class
  private
  protected
    FGOXDBConnection:TGOXDBConnection;
    FManagerOSet : TGOXManagerObjectSet;
  public
    constructor Create(AGOXDBConnection:TGOXDBConnection);
    destructor Destroy; override;
    //
    function AddObjectSet<T: class, constructor>(const APageSize: Integer = -1): TRepositoryManagerObjectSet;
    // ObjectSet
    function Find<T: class, constructor>: TObjectList<T>; overload;
    function Find<T: class, constructor>(const AID: Integer): T; overload;
    function Find<T: class, constructor>(const AID: String): T; overload;
    function FindWhere<T: class, constructor>(const AWhere: string;const AOrderBy: string = ''): TObjectList<T>;
    //
    // Métodos para serem usados com a propriedade OwnerNestedList := False;
    function Insert<T: class, constructor>(const AObject: T): Integer;
    procedure Modify<T: class, constructor>(const AObject: T);
    procedure Update<T: class, constructor>(const AObject: T);
    procedure Delete<T: class, constructor>(const AObject: T);
    procedure NextPacket<T: class, constructor>(var AObjectList: TObjectList<T>);
    procedure New<T: class, constructor>(var AObject: T);
  end;

  TRepositoryManagerDataSet = class
  private
  protected
    FGOXDBConnection:TGOXDBConnection;
    FManagerDSet : TGOXManagerDataSet;
  public
    constructor Create(AGOXDBConnection:TGOXDBConnection);
    destructor Destroy; override;
    //
    procedure RemoveDataSet<T: class>;
    function AddDataSet<T: class, constructor>(const ADataSet: TDataSet; const APageSize: Integer = -1): TRepositoryManagerDataSet; overload;
    function AddDataSet<T, M: class, constructor>(const ADataSet: TDataSet): TRepositoryManagerDataSet; overload;

    function AddLookupField<T, M: class, constructor>(const AFieldName: string;
                                                      const AKeyFields: string;
                                                      const ALookupKeyFields: string;
                                                      const ALookupResultField: string;
                                                      const ADisplayLabel: string = ''): TRepositoryManagerDataSet;
    procedure Open<T: class, constructor>; overload;
    procedure Open<T: class, constructor>(const AID: Integer); overload;
    procedure Open<T: class, constructor>(const AID: String); overload;
    procedure OpenWhere<T: class, constructor>(const AWhere: string; const AOrderBy: string = '');
    procedure Close<T: class, constructor>;
    procedure RefreshRecord<T: class, constructor>;
    procedure EmptyDataSet<T: class, constructor>;
    procedure CancelUpdates<T: class, constructor>;
    procedure ApplyUpdates<T: class, constructor>(const MaxErros: Integer);
    procedure Save<T: class, constructor>(AObject: T);
    function Current<T: class, constructor>: T;
    function DataSet<T: class, constructor>: TDataSet;
    // ObjectSet
    function Find<T: class, constructor>: TObjectList<T>; overload;
    function Find<T: class, constructor>(const AID: Integer): T; overload;
    function Find<T: class, constructor>(const AID: String): T; overload;
    function FindWhere<T: class, constructor>(const AWhere: string; const AOrderBy: string = ''): TObjectList<T>;
    function AutoNextPacket<T: class, constructor>(const AValue: Boolean): TGOXManagerDataSet;
  end;






implementation


{ TRepositoryManagerObjectSet }

constructor TRepositoryManagerObjectSet.Create(AGOXDBConnection:TGOXDBConnection);
begin
  FGOXDBConnection := AGOXDBConnection;
  FManagerOSet := TGOXManagerObjectSet.Create(FGOXDBConnection);
end;

procedure TRepositoryManagerObjectSet.Delete<T>(const AObject: T);
begin
   FManagerOSet.Delete<T>(AObject);
end;

destructor TRepositoryManagerObjectSet.Destroy;
begin
  FreeAndNil(FManagerOSet);
  inherited;
end;

procedure TRepositoryManagerObjectSet.New<T>(var AObject: T);
begin
  FManagerOSet.New<T>(AObject);
end;

function TRepositoryManagerObjectSet.Find<T>(const AID: Integer): T;
begin
  Result := FManagerOSet.Find<T>(AID);
end;

function TRepositoryManagerObjectSet.Find<T>(const AID: String): T;
begin
   Result := FManagerOSet.Find<T>(AID);
end;

function TRepositoryManagerObjectSet.AddObjectSet<T>(const APageSize: Integer): TRepositoryManagerObjectSet;
begin
  Result := Self;
  FManagerOSet.AddObjectSet<T>(APageSize);
end;

function TRepositoryManagerObjectSet.Find<T>: TObjectList<T>;
begin
  Result := FManagerOSet.Find<T>;
end;

procedure TRepositoryManagerObjectSet.Update<T>(const AObject: T);
begin
  FManagerOSet.Update<T>(AObject);
end;

function TRepositoryManagerObjectSet.FindWhere<T>(const AWhere, AOrderBy: string): TObjectList<T>;
begin
  Result := FManagerOSet.FindWhere<T>(AWhere, AOrderBy);
end;

function TRepositoryManagerObjectSet.Insert<T>(const AObject: T): Integer;
begin
  Result := FManagerOSet.Insert<T>(AObject);
end;

procedure TRepositoryManagerObjectSet.Modify<T>(const AObject: T);
begin
  FManagerOSet.Modify<T>(AObject);
end;

procedure TRepositoryManagerObjectSet.NextPacket<T>(var AObjectList: TObjectList<T>);
begin
  FManagerOSet.NextPacket<T>(AObjectList);
end;


{ TRepositoryManagerDataSet }

constructor TRepositoryManagerDataSet.Create(AGOXDBConnection:TGOXDBConnection);
begin
  FGOXDBConnection := AGOXDBConnection;
  FManagerDSet := TGOXManagerDataSet.Create(FGOXDBConnection);
end;

destructor TRepositoryManagerDataSet.Destroy;
begin
  FreeAndNil(FManagerDSet);
  inherited;
end;

function TRepositoryManagerDataSet.Current<T>: T;
begin
  Result := FManagerDSet.Current<T>;
end;

function TRepositoryManagerDataSet.DataSet<T>: TDataSet;
begin
//  Result := Resolver<T>.FOrmDataSet;
end;

procedure TRepositoryManagerDataSet.EmptyDataSet<T>;
begin
  FManagerDSet.EmptyDataSet<T>;
end;

function TRepositoryManagerDataSet.Find<T>(const AID: Integer): T;
begin
  Result := FManagerDSet.Find<T>(Integer(AID));
end;

function TRepositoryManagerDataSet.Find<T>: TObjectList<T>;
begin
  Result := FManagerDSet.Find<T>;
end;

procedure TRepositoryManagerDataSet.CancelUpdates<T>;
begin
  FManagerDSet.CancelUpdates<T>;
end;

procedure TRepositoryManagerDataSet.Close<T>;
begin
  FManagerDSet.EmptyDataSet<T>;
end;

function TRepositoryManagerDataSet.AddDataSet<T, M>(const ADataSet: TDataSet): TRepositoryManagerDataSet;
begin
  Result := Self;
  //
  FManagerDSet.AddDataSet<T, M>(ADataSet);
end;

function TRepositoryManagerDataSet.AddDataSet<T>(const ADataSet: TDataSet; const APageSize: Integer): TRepositoryManagerDataSet;
begin
  Result := Self;
  //
  FManagerDSet.AddDataSet<T>(ADataSet,APageSize);
end;

function TRepositoryManagerDataSet.AddLookupField<T, M>(const AFieldName, AKeyFields: string;  const ALookupKeyFields, ALookupResultField, ADisplayLabel: string): TRepositoryManagerDataSet;
//var
//  LObject: TRepositoryDataSetAdapterBase<M>;
begin
  Result := Self;
//  LObject := Resolver<M>;
//  if LObject = nil then
//    Exit;

//  FManagerDSet.AddLookupField<T,M>(AFieldName,
//                                 AKeyFields,
//                                 LObject,
//                                 ALookupKeyFields,
//                                 ALookupResultField,
//                                 ADisplayLabel);
end;

procedure TRepositoryManagerDataSet.ApplyUpdates<T>(const MaxErros: Integer);
begin
  FManagerDSet.ApplyUpdates<T>(MaxErros);
end;


function TRepositoryManagerDataSet.AutoNextPacket<T>(const AValue: Boolean): TGOXManagerDataSet;
begin

end;

procedure TRepositoryManagerDataSet.Open<T>(const AID: String);
begin
  FManagerDSet.Open<T>(AID);
end;

procedure TRepositoryManagerDataSet.OpenWhere<T>(const AWhere,
  AOrderBy: string);
begin
  FManagerDSet.OpenWhere<T>(AWhere, AOrderBy);
end;

procedure TRepositoryManagerDataSet.Open<T>(const AID: Integer);
begin
  FManagerDSet.Open<T>(AID);
end;

procedure TRepositoryManagerDataSet.Open<T>;
begin
  FManagerDSet.Open<T>;
end;

procedure TRepositoryManagerDataSet.RefreshRecord<T>;
begin
  FManagerDSet.RefreshRecord<T>;
end;

procedure TRepositoryManagerDataSet.RemoveDataSet<T>;
begin
  FManagerDSet.RemoveDataSet<T>;
end;

procedure TRepositoryManagerDataSet.Save<T>(AObject: T);
begin
  FManagerDSet.Save<T>(AObject);
end;

function TRepositoryManagerDataSet.Find<T>(const AID: String): T;
begin
  Result := FManagerDSet.Find<T>(AID);
end;

function TRepositoryManagerDataSet.FindWhere<T>(const AWhere, AOrderBy: string): TObjectList<T>;
begin
  Result := FManagerDSet.FindWhere<T>(AWhere, AOrderBy);
end;

{ =================================================================================================================
====================================================================================================================}





end.
