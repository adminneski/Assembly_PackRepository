
{******************************************}
{                                          }
{             FastReport VCL               }
{              FR Variables                }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxVariables;

interface

{$I frx.inc}

uses
  SysUtils,
  {$IFNDEF FPC}
  Windows, Messages,
  {$ENDIF}
  Forms, Classes, Controls, Graphics, Dialogs, Variants,
  frXML, frCoreClasses;

type
  /// <summary>
  ///   The TfrxVariable class represents a variable.
  /// </summary>
  TfrxVariable = class(TfrCollectionItem)
  private
    FName: String;
    FValue: Variant;
  protected
    function GetInheritedName: String; override;
  public
    constructor Create(ACollection: TCollection); override;
    procedure Assign(Source: TPersistent); override;
    function IsUniqueNameStored: Boolean; override;
  published
    /// <summary>
    ///   Name of a variable. must be unique.
    /// </summary>
    property Name: String read FName write FName;
    /// <summary>
    ///   Value of a variable.
    /// </summary>
    property Value: Variant read FValue write FValue;
  end;

  /// <summary>
  ///   The TfrxVariables class represents a list of variables. It contains all
  ///   methods necessary for working with the list. TfrxReport.Variables
  ///   property contains a link to the instance of this class.
  /// </summary>
  TfrxVariables = class(TfrCollection)
  private
    function GetItems(Index: Integer): TfrxVariable;
    function GetVariable(Index: String): Variant;
    procedure SetVariable(Index: String; const Value: Variant);
  public
    constructor Create;
    /// <summary>
    ///   Adds a variable to the end of the list.
    /// </summary>
    function Add: TfrxVariable;
    /// <summary>
    ///   Adds a variable to the given position of the list.
    /// </summary>
    function Insert(Index: Integer): TfrxVariable;
    /// <summary>
    ///   Returns the index of a variable with the given name.
    /// </summary>
    function IndexOf(const Name: String): Integer;
    /// <summary>
    ///   Adds a variable to the specified category.
    /// </summary>
    procedure AddVariable(const ACategory, AName: String; const AValue: Variant);
    /// <summary>
    ///   Deletes a category and all its variables.
    /// </summary>
    procedure DeleteCategory(const Name: String);
    /// <summary>
    ///   Deletes a variable.
    /// </summary>
    procedure DeleteVariable(const Name: String);
    /// <summary>
    ///   Returns the list of categories.
    /// </summary>
    procedure GetCategoriesList(List: TStrings; ClearList: Boolean = True);
    /// <summary>
    ///   Returns the list of variables in the specified category.
    /// </summary>
    procedure GetVariablesList(const Category: String; List: TStrings);
    /// <summary>
    ///   Loads the list of variables from file.
    /// </summary>
    procedure LoadFromFile(const FileName: String);
    /// <summary>
    ///   Loads the list of variables from stream.
    /// </summary>
    procedure LoadFromStream(Stream: TStream);
    /// <summary>
    ///   Loads the list of variables from XML node.
    /// </summary>
    procedure LoadFromXMLItem(Item: TfrXMLItem; OldXMLFormat: Boolean = True);
    /// <summary>
    ///   Saves the list of variables to file.
    /// </summary>
    procedure SaveToFile(const FileName: String);
    /// <summary>
    ///   Saves the list of variables to stream.
    /// </summary>
    procedure SaveToStream(Stream: TStream);
    /// <summary>
    ///   Saves the list of variables to XML node.
    /// </summary>
    procedure SaveToXMLItem(Item: TfrXMLItem);
    /// <summary>
    ///   The list of variables.
    /// </summary>
    property Items[Index: Integer]: TfrxVariable read GetItems;
    /// <summary>
    ///   Values of variables.
    /// </summary>
    property Variables[Index: String]: Variant read GetVariable
      write SetVariable; default;
  end;

  TfrxArray = class(TCollection)
  private
    function GetItems(Index: Integer): TfrxVariable;
    function GetVariable(Index: Variant): Variant;
    procedure SetVariable(Index: Variant; const Value: Variant);
  public
    constructor Create;
    function IndexOf(const Name: Variant): Integer;
    property Items[Index: Integer]: TfrxVariable read GetItems;
    property Variables[Index: Variant]: Variant read GetVariable
      write SetVariable; default;
  end;


implementation

uses
  frxXMLSerializer;

{ TfrxVariable }

constructor TfrxVariable.Create(ACollection: TCollection);
begin
  inherited;
{$IFDEF FPC}
  FValue := 'default';
{$ELSE}
  FValue := Null;
{$ENDIF}
end;

function TfrxVariable.GetInheritedName: String;
begin
  if Name <> '' then
    Result := Name
  else
    Result := inherited GetInheritedName;
end;

function TfrxVariable.IsUniqueNameStored: Boolean;
begin
  Result := False;
end;


procedure TfrxVariable.Assign(Source: TPersistent);
begin
  if Source is TfrxVariable then
  begin
    FName := TfrxVariable(Source).Name;
    FValue := TfrxVariable(Source).Value;
    FIsInherited := TfrxVariable(Source).IsInherited;
  end;
end;


{ TfrxVariables }

constructor TfrxVariables.Create;
begin
  inherited Create(TfrxVariable);
end;

function TfrxVariables.Add: TfrxVariable;
begin
  Result := TfrxVariable(inherited Add);
end;

function TfrxVariables.Insert(Index: Integer): TfrxVariable;
begin
  Result := TfrxVariable(inherited Insert(Index));
end;

function TfrxVariables.GetItems(Index: Integer): TfrxVariable;
begin
  Result := TfrxVariable(inherited Items[Index]);
end;

function TfrxVariables.IndexOf(const Name: String): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Count - 1 do
    if AnsiCompareText(Name, Items[i].Name) = 0 then
    begin
      Result := i;
      break;
    end;
end;

function TfrxVariables.GetVariable(Index: String): Variant;
var
  i: Integer;
begin
  i := IndexOf(Index);
  if i <> -1 then
    Result := Items[i].Value else
    Result := Null;
end;

procedure TfrxVariables.SetVariable(Index: String; const Value: Variant);
var
  i: Integer;
  v: TfrxVariable;
begin
  i := IndexOf(Index);
  if i <> -1 then
    Items[i].Value := Value
  else
  begin
    v := Add;
    v.Name := Index;
    v.Value := Value;
  end;
end;

procedure TfrxVariables.GetCategoriesList(List: TStrings; ClearList: Boolean = True);
var
  i: Integer;
  s: String;
begin
  if ClearList then
    List.Clear;

  for i := 0 to Count - 1 do
  begin
    s := Items[i].Name;
    if (s <> '') and (s[1] = ' ') then
      List.Add(Copy(s, 2, 255));
  end;
end;

procedure TfrxVariables.GetVariablesList(const Category: String; List: TStrings);
var
  i, j: Integer;
  s: String;
begin
  List.Clear;
  for i := 0 to Count - 1 do
    if (Category = '') or (AnsiCompareText(Items[i].Name, ' ' + Category) = 0) then
    begin
      if Category <> '' then
        j := i + 1 else
        j := i;
      while j < Count do
      begin
        s := Items[j].Name;
        Inc(j);
        if (s <> '') and (s[1] <> ' ') then
          List.Add(s) else
          break
      end;
      break;
    end;
end;

procedure TfrxVariables.DeleteCategory(const Name: String);
var
  i: Integer;
begin
  i := 0;
  while i < Count do
  begin
    if AnsiCompareText(Items[i].Name, ' ' + Name) = 0 then
    begin
      Items[i].Free;
      while (i < Count) and (Items[i].Name[1] <> ' ') do
        Items[i].Free;
      break;
    end;
    Inc(i);
  end;
end;

procedure TfrxVariables.DeleteVariable(const Name: String);
var
  i: Integer;
begin
  i := IndexOf(Name);
  if i <> -1 then
    Items[i].Free;
end;

procedure TfrxVariables.AddVariable(const ACategory, AName: String;
  const AValue: Variant);
var
  i, idx: Integer;
begin
  i := 0;
  while i < Count do
  begin
    if AnsiCompareText(Items[i].Name, ' ' + ACategory) = 0 then
    begin
      Inc(i);
      while (i < Count) and (Items[i].Name[1] <> ' ') do
        Inc(i);
      idx := IndexOf(AName);
      if  idx <> - 1 then
        Items[idx].Value := AValue
      else
        if i = Count then
          with Add do
          begin
            Name := AName;
            Value := AValue;
          end
        else
          with Insert(i) do
          begin
            Name := AName;
            Value := AValue;
          end;
      break;
    end;
    Inc(i);
  end;
end;

procedure TfrxVariables.LoadFromFile(const FileName: String);
var
  f: TFileStream;
begin
  f := TFileStream.Create(FileName, fmOpenRead);
  try
    LoadFromStream(f);
  finally
    f.Free;
  end;
end;

procedure TfrxVariables.LoadFromStream(Stream: TStream);
var
  x: TfrXMLDocument;
begin
  Clear;
  x := TfrXMLDocument.Create;
  try
    x.LoadFromStream(Stream);
    if CompareText(x.Root.Name, 'variables') = 0 then
      LoadFromXMLItem(x.Root, x.OldVersion);
  finally
    x.Free;
  end;
end;

procedure TfrxVariables.LoadFromXMLItem(Item: TfrXMLItem; OldXMLFormat: Boolean);
var
  xs: TfrxXMLSerializer;
  i: Integer;
begin
  Clear;
  xs := TfrxXMLSerializer.Create(nil);
  xs.OldFormat := OldXMLFormat;
  try
    for i := 0 to Item.Count - 1 do
      if CompareText(Item[i].Name, 'item') = 0 then
        xs.XMLToObj(Item[i].Text, Add);
  finally
    xs.Free;
  end;
end;

procedure TfrxVariables.SaveToFile(const FileName: String);
var
  f: TFileStream;
begin
  f := TFileStream.Create(FileName, fmCreate);
  try
    SaveToStream(f);
  finally
    f.Free;
  end;
end;

procedure TfrxVariables.SaveToStream(Stream: TStream);
var
  x: TfrXMLDocument;
begin
  x := TfrXMLDocument.Create;
  x.AutoIndent := True;
  try
    x.Root.Name := 'variables';
    SaveToXMLItem(x.Root);
    x.SaveToStream(Stream);
  finally
    x.Free;
  end;
end;

procedure TfrxVariables.SaveToXMLItem(Item: TfrXMLItem);
var
  xi: TfrXMLItem;
  xs: TfrxXMLSerializer;
  i: Integer;
begin
  xs := TfrxXMLSerializer.Create(nil);
  try
    for i := 0 to Count - 1 do
    begin
      xi := Item.Add;
      xi.Name := 'item';
      xi.Text := xs.ObjToXML(Items[i]);
    end;
  finally
    xs.Free;
  end;
end;


{ TfrxArray }

constructor TfrxArray.Create;
begin
  inherited Create(TfrxVariable);
end;

function TfrxArray.GetItems(Index: Integer): TfrxVariable;
begin
  Result := TfrxVariable(inherited Items[Index]);
end;

function TfrxArray.IndexOf(const Name: Variant): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Count - 1 do
    if AnsiCompareText(VarToStr(Name), Items[i].Name) = 0 then
    begin
      Result := i;
      break;
    end;
end;

function TfrxArray.GetVariable(Index: Variant): Variant;
var
  i: Integer;
begin
  i := IndexOf(Index);
  if i <> -1 then
    Result := Items[i].Value else
    Result := Null;
end;

procedure TfrxArray.SetVariable(Index: Variant; const Value: Variant);
var
  i: Integer;
  v: TfrxVariable;
begin
  i := IndexOf(Index);
  if i <> -1 then
    Items[i].Value := Value
  else
  begin
    v := TfrxVariable(inherited Add);
    v.Name := Index;
    v.Value := Value;
  end;
end;

end.
