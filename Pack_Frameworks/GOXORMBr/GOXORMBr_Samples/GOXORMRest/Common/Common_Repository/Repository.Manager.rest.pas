unit Repository.Manager.rest;

interface

uses
  DB,
  Rtti,
  SysUtils,
  Variants,
  Generics.Collections,
  //GOXORMBr
  goxormbr.manager.dataset,
  goxormbr.manager.objectset,
  goxormbr.core.types;

type
  //********************************************************************************
  // Classes Repository Criada para Diminuir o Acoplamento ORM dentro da Aplicação
  //********************************************************************************

  TRepositoryManagerObjectSetRest = class
  private
  protected
    FRESTConnection: TGOXRESTConnection;
    FManagerOSetRest : TGOXManagerObjectSetRest;
  public
    constructor Create(AGOXRESTConnection:TGOXRESTConnection);
    destructor Destroy; override;
    function AddObjectSet<T: class, constructor>(const APageSize: Integer = -1): TRepositoryManagerObjectSetRest;

    // ObjectSet
    function Find<T: class, constructor>: TObjectList<T>; overload;
    function Find<T: class, constructor>(const AID: Integer): T; overload;
    function Find<T: class, constructor>(const AID: String): T; overload;
    function FindWhere<T: class, constructor>(const AWhere: string; const AOrderBy: string = ''): TObjectList<T>;
    function FindFrom<T: class, constructor>(const ASubResourceName: String): TObjectList<T>;

    function ExistSequence<T: class, constructor>: Boolean;
    // Métodos para serem usados com a propriedade OwnerNestedList := False;
    function Insert<T: class, constructor>(const AObject: T): Integer; overload;
    procedure Modify<T: class, constructor>(const AObject: T); overload;
    procedure Update<T: class, constructor>(const AObject: T); overload;
    procedure Delete<T: class, constructor>(const AObject: T); overload;
    procedure NextPacket<T: class, constructor>(var AObjectList: TObjectList<T>); overload;
    procedure New<T: class, constructor>(var AObject: T); overload;
  end;

  TRepositoryManagerDataSetRest = class
  private
  protected
    FConnection: TGOXRESTConnection;
    FManagerDSetRest : TGOXManagerDataSetREST;
  public
    constructor Create(AGOXRESTConnection:TGOXRESTConnection);
    destructor Destroy; override;

//    procedure NextPacket<T: class, constructor>;
//    function GetAutoNextPacket<T: class, constructor>: Boolean;
//    procedure SetAutoNextPacket<T: class, constructor>(const AValue: Boolean);

    function AddDataSet<T: class, constructor>(const ADataSet: TDataSet; const APageSize: Integer = -1): TRepositoryManagerDataSetRest; overload;
    function AddDataSet<T, M: class, constructor>(const ADataSet: TDataSet): TRepositoryManagerDataSetRest; overload;

    function AddLookupField<T, M: class, constructor>(const AFieldName: string;
                                                      const AKeyFields: string;
                                                      const ALookupKeyFields: string;
                                                      const ALookupResultField: string;
                                                      const ADisplayLabel: string = ''): TRepositoryManagerDataSetRest;
    procedure Open<T: class, constructor>; overload;
    procedure Open<T: class, constructor>(const AID: Integer); overload;
    procedure Open<T: class, constructor>(const AID: String); overload;
    procedure OpenWhere<T: class, constructor>(const AWhere: string; const AOrderBy: string = '');
    //
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
    function AutoNextPacket<T: class, constructor>(const AValue: Boolean): TRepositoryManagerDataSetRest;
  end;




implementation



{ =================================================================================================================
====================================================================================================================}

{ TRepositoryManagerObjectSetRest }

constructor TRepositoryManagerObjectSetRest.Create(AGOXRESTConnection:TGOXRESTConnection);
begin
  FRESTConnection := AGOXRESTConnection;
  //Criar conexao rest aqui
  FManagerOSetRest := TGOXManagerObjectSetRest.Create(FRESTConnection);
end;

procedure TRepositoryManagerObjectSetRest.Delete<T>(const AObject: T);
begin
  FManagerOSetRest.Delete<T>(AObject);
end;

destructor TRepositoryManagerObjectSetRest.Destroy;
begin
  FreeAndNil(FManagerOSetRest);
  inherited;
end;


procedure TRepositoryManagerObjectSetRest.New<T>(var AObject: T);
begin
  AObject := nil;
  FManagerOSetRest.New<T>(AObject);
end;


function TRepositoryManagerObjectSetRest.ExistSequence<T>: Boolean;
begin
  Result := FManagerOSetRest.ExistSequence<T>;
end;

function TRepositoryManagerObjectSetRest.Find<T>(const AID: Integer): T;
begin
  Result := FManagerOSetRest.Find<T>(AID);
end;

function TRepositoryManagerObjectSetRest.AddObjectSet<T>(const APageSize: Integer): TRepositoryManagerObjectSetRest;
begin
  Result := Self;
  FManagerOSetRest.AddObjectSet<T>(APageSize);
end;

function TRepositoryManagerObjectSetRest.Find<T>: TObjectList<T>;
begin
  Result := FManagerOSetRest.Find<T>;
end;


procedure TRepositoryManagerObjectSetRest.Update<T>(const AObject: T);
begin
  FManagerOSetRest.Update<T>(AObject);
end;

function TRepositoryManagerObjectSetRest.FindWhere<T>(const AWhere, AOrderBy: string): TObjectList<T>;
begin
  Result := FManagerOSetRest.FindWhere<T>(AWhere, AOrderBy);
end;

function TRepositoryManagerObjectSetRest.Insert<T>(const AObject: T): Integer;
begin
  Result := FManagerOSetRest.Insert<T>(AObject);
end;


procedure TRepositoryManagerObjectSetRest.Modify<T>(const AObject: T);
begin
  FManagerOSetRest.Modify<T>(AObject);
end;

procedure TRepositoryManagerObjectSetRest.NextPacket<T>(var AObjectList: TObjectList<T>);
begin
  FManagerOSetRest.NextPacket<T>(AObjectList);
end;

function TRepositoryManagerObjectSetRest.FindFrom<T>(const ASubResourceName: String): TObjectList<T>;
begin
  Result := FManagerOSetRest.FindFrom<T>(ASubResourceName);
end;

function TRepositoryManagerObjectSetRest.Find<T>(const AID: String): T;
begin
  Result := FManagerOSetRest.Find<T>(AID);
end;



{ TRepositoryManagerDataSetRest }

constructor TRepositoryManagerDataSetRest.Create(AGOXRESTConnection:TGOXRESTConnection);
begin
  FConnection := AGOXRESTConnection;
  FManagerDSetRest := TGOXManagerDataSetRest.Create(FConnection);
end;

destructor TRepositoryManagerDataSetRest.Destroy;
begin
  FreeAndNil(FManagerDSetRest);
  inherited;
end;

function TRepositoryManagerDataSetRest.Current<T>: T;
begin
  Result := FManagerDSetRest.Current<T>;
end;

function TRepositoryManagerDataSetRest.DataSet<T>: TDataSet;
begin
  Result := FManagerDSetRest.DataSet<T>;
end;

procedure TRepositoryManagerDataSetRest.EmptyDataSet<T>;
begin
  FManagerDSetRest.EmptyDataSet<T>;
end;

function TRepositoryManagerDataSetRest.Find<T>(const AID: Integer): T;
begin
  Result := FManagerDSetRest.Find<T>(AID);
end;

function TRepositoryManagerDataSetRest.Find<T>: TObjectList<T>;
begin
  Result := FManagerDSetRest.Find<T>;
end;

procedure TRepositoryManagerDataSetRest.CancelUpdates<T>;
begin
  FManagerDSetRest.CancelUpdates<T>;
end;

procedure TRepositoryManagerDataSetRest.Close<T>;
begin
  FManagerDSetRest.EmptyDataSet<T>;
end;


function TRepositoryManagerDataSetRest.AddDataSet<T, M>(const ADataSet: TDataSet): TRepositoryManagerDataSetRest;
begin
  Result := Self;
  //
  FManagerDSetRest.AddDataSet<T,M>(ADataSet);
end;

function TRepositoryManagerDataSetRest.AddDataSet<T>(const ADataSet: TDataSet; const APageSize: Integer): TRepositoryManagerDataSetRest;
begin
  Result := Self;
  //
  FManagerDSetRest.AddDataSet<T>(ADataSet,APageSize);
end;

function TRepositoryManagerDataSetRest.AddLookupField<T, M>(const AFieldName, AKeyFields: string;  const ALookupKeyFields, ALookupResultField, ADisplayLabel: string): TRepositoryManagerDataSetRest;
//var
//  LObject: TGOXManagerDataSetAdapterBase<M>;
begin
  Result := Self;
//  LObject := Resolver<M>;
//  if LObject = nil then
//    Exit;
//  Resolver<T>.AddLookupField(AFieldName,
//                             AKeyFields,
//                             LObject,
//                             ALookupKeyFields,
//                             ALookupResultField,
//                             ADisplayLabel);
end;

procedure TRepositoryManagerDataSetRest.ApplyUpdates<T>(const MaxErros: Integer);
begin
  FManagerDSetRest.ApplyUpdates<T>(MaxErros);
end;


function TRepositoryManagerDataSetRest.AutoNextPacket<T>(const AValue: Boolean): TRepositoryManagerDataSetRest;
begin

end;

procedure TRepositoryManagerDataSetRest.Open<T>(const AID: String);
begin
  FManagerDSetRest.Open<T>(AID);
end;

procedure TRepositoryManagerDataSetRest.OpenWhere<T>(const AWhere,
  AOrderBy: string);
begin
  FManagerDSetRest.OpenWhere<T>(AWhere, AOrderBy);
end;

procedure TRepositoryManagerDataSetRest.Open<T>(const AID: Integer);
begin
  FManagerDSetRest.Open<T>(AID);
end;

procedure TRepositoryManagerDataSetRest.Open<T>;
begin
  FManagerDSetRest.Open<T>;
end;

procedure TRepositoryManagerDataSetRest.RefreshRecord<T>;
begin
  FManagerDSetRest.RefreshRecord<T>;
end;

procedure TRepositoryManagerDataSetRest.Save<T>(AObject: T);
begin
  FManagerDSetRest.Save<T>(AObject);
end;

function TRepositoryManagerDataSetRest.Find<T>(const AID: String): T;
begin
  Result := FManagerDSetRest.Find<T>(AID);
end;

function TRepositoryManagerDataSetRest.FindWhere<T>(const AWhere, AOrderBy: string): TObjectList<T>;
var
  LObjectList: TObjectList<T>;
begin
  Result := FManagerDSetRest.FindWhere<T>(AWhere, AOrderBy);
end;

//{$IFNDEF DRIVERRESTFUL}
//procedure TRepositoryDataSetRest.NextPacket<T>;
//begin
//  Resolver<T>.NextPacket;
//end;
//
//function TRepositoryDataSetRest.GetAutoNextPacket<T>: Boolean;
//begin
//  Result := Resolver<T>.AutoNextPacket;
//end;
//
//procedure TRepositoryDataSetRest.SetAutoNextPacket<T>(const AValue: Boolean);
//begin
//  Resolver<T>.AutoNextPacket := AValue;
//end;
//{$ENDIF}



end.







