
{******************************************}
{                                          }
{             FastReport VCL               }
{           Aggregate Functions            }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxAggregate;

interface

{$I frx.inc}

uses
  {$IFNDEF FPC}
  Windows,
  {$ENDIF}
  SysUtils, Classes, Dialogs, frxClass
{$IFDEF DELPHI6}
, Variants
{$ENDIF};


type
  TfrxAggregateFunction = (agSum, agAvg, agMin, agMax, agCount);

  TfrxAggregateItem = class(TObject)
  private
    FAggregateFunction: TfrxAggregateFunction;
    FDataRow: TfrxComponent;
    FCountInvisibleBands: Boolean;
    FDontReset: Boolean;
    FExpression: String;
    FIsPageFooter: Boolean;
    FItemsArray: Variant;      { used for vbands }
    FItemsCount: Integer;
    FItemsCountArray: Variant; { used for vbands }
    FItemsValue: Variant;
    FKeeping: Boolean;
    FLastCount: Integer;
    FLastValue: Variant;
    { used in Save/Restore }
    FSavedCount: Integer;
    FSavedValue: Variant;
    FMemoName: String;
    FOriginalName: String;
    FParentContainer: TfrxComponent;
    FReport: TfrxReport;
    FTempItemsCount: Integer;
    FTempItemsValue: Variant;
    FVColumn: Integer;         { used for vbands }
  public
    procedure Calc(AValue: Variant);
    procedure DeleteValue;
    procedure SaveValue;
    procedure RestoreValue;
    procedure Reset;
    procedure StartKeep;
    procedure EndKeep;
    function Value: Variant;
    property DataRow: TfrxComponent read FDataRow;
  end;

  TfrxAggregateList = class(TfrxCustomAggregateList)
  private
    FList: TList;
    FReport: TfrxReport;
    function GetItem(Index: Integer): TfrxAggregateItem;
    procedure FindAggregate(AComponent: TfrxComponent; const Text: String; const ExpressionDelimiters: String; DataRow: TfrxComponent; AList: TList = nil; MainParent: TfrxComponent = nil; IsAggregatedObj: Boolean = False); overload;
    procedure FindAggregate(Memo: TfrxCustomMemoView; DataRow: TfrxComponent); overload;
    procedure ParseName(const ComplexName: String; var Func: TfrxAggregateFunction;
      var Expr: String; var DataRow: TfrxComponent; var CountInvisible, DontReset: Boolean; MainParent: TfrxComponent = nil; IsAggregatedObj: Boolean = False);
    property Items[Index: Integer]: TfrxAggregateItem read GetItem; default;
  public
    constructor Create(AReport: TfrxReport);
    destructor Destroy; override;
    procedure Clear; override;
    procedure ClearValues; override;
    procedure AddItems(Page: TfrxReportPage); override;
    function AddAggregatedItem(AObject: IfrxAggregateObject; Container: TfrxComponent; AList: TList = nil): Boolean; override;
    procedure AddValue(DataRow: TfrxComponent; VColumn: Integer = 0); override;
    function AddCalculatedValue(DataRow: TfrxComponent; const Value: Variant; VColumn: Integer = 0): Boolean; override;
    procedure DeleteValue(DataRow: TfrxComponent); override;
    procedure SaveValue(DataRow: TfrxComponent); override;
    procedure RestoreValue(DataRow: TfrxComponent); override;
    procedure EndKeep; override;
    procedure Reset(ParentContainer: TfrxComponent); override;
    procedure StartKeep; override;
    function GetValue(ParentContainer: TfrxComponent; const ComplexName: String;
      VColumn: Integer = 0): Variant; overload; override;
    function GetValue(ParentContainer: TfrxComponent; VColumn: Integer;
      const Name, Expression: String; DataRow: TfrxComponent; Flags: Integer): Variant; overload; override;
  end;


implementation

uses frxVariables, frxUtils;

type
  THackComponent = class(TfrxComponent);

procedure Get3Params(const s: String; var i: Integer;
  var s1, s2, s3: String);
var
  c, d, e, oi, ci: Integer;
begin
  s1 := ''; s2 := ''; s3 := '';
  c := 1; d := 1; e := 1; oi := i + 1; ci := 1;
  repeat
    Inc(i);
    if s[i] = '''' then
      if (d = 1) and (e = 1) then Inc(d) else d := 1;
    if (d = 1) and (s[i] = '"') then
      if e = 1 then Inc(e) else e := 1;
    if (d = 1) and (e = 1) then
    begin
      if s[i] = '(' then
        Inc(c) else
      if s[i] = ')' then Dec(c);
      if (s[i] = ',') and (c = 1) then
      begin
        if ci = 1 then
          s1 := Copy(s, oi, i - oi) else
          s2 := Copy(s, oi, i - oi);
        oi := i + 1; Inc(ci);
      end;
    end;
  until (c = 0) or (i >= Length(s));
  case ci of
    1: s1 := Copy(s, oi, i - oi);
    2: s2 := Copy(s, oi, i - oi);
    3: s3 := Copy(s, oi, i - oi);
  end;
  Inc(i);
end;


{ TfrxAggregateItem }

procedure TfrxAggregateItem.Calc(AValue: Variant);
var
  i: Integer;
begin
  if Assigned(FDataRow) and not FDataRow.Visible and not FCountInvisibleBands then Exit;

  FReport.CurObject := FMemoName;
  if FAggregateFunction <> agCount then
  begin
    if AValue = Null then
      AValue := FReport.Calc(FExpression);
  end
  else
    AValue := Null;

  if VarType(AValue) = varBoolean then
    if AValue = True then
      AValue := 1;

  { process vbands }
  if FVColumn > 0 then
  begin
    if VarIsNull(FItemsArray) then
    begin
      FItemsArray := VarArrayCreate([0, 1000], varVariant);
      FItemsCountArray := VarArrayCreate([0, 1000], varVariant);
      for i := 0 to 1000 do
      begin
        FItemsArray[i] := Null;
        FItemsCountArray[i] := 0;
      end;
    end;

    if (FAggregateFunction <> agAvg) or (AValue <> Null) then
      FItemsCountArray[FVColumn] := FItemsCountArray[FVColumn] + 1;
    if FItemsArray[FVColumn] = Null then
      FItemsArray[FVColumn] := AValue
    else if AValue <> Null then
      case FAggregateFunction of
        agSum, agAvg:
          FItemsArray[FVColumn] := FItemsArray[FVColumn] + AValue;
        agMin:
          if AValue < FItemsArray[FVColumn] then
            FItemsArray[FVColumn] := AValue;
        agMax:
          if AValue > FItemsArray[FVColumn] then
            FItemsArray[FVColumn] := AValue;
      end;
  end
  else if FKeeping then
  begin
    if (FAggregateFunction <> agAvg) or (AValue <> Null) then
      Inc(FTempItemsCount);
    if FTempItemsValue = Null then
      FTempItemsValue := AValue
    else if AValue <> Null then
      case FAggregateFunction of
        agSum, agAvg:
          FTempItemsValue := FTempItemsValue + AValue;
        agMin:
          if AValue < FTempItemsValue then
            FTempItemsValue := AValue;
        agMax:
          if AValue > FTempItemsValue then
            FTempItemsValue := AValue;
      end;
  end
  else
  begin
    FLastCount := FItemsCount;
    FLastValue := FItemsValue;
    if (FAggregateFunction <> agAvg) or (AValue <> Null) then
      Inc(FItemsCount);
    if FItemsValue = Null then
      FItemsValue := AValue
    else if AValue <> Null then
      case FAggregateFunction of
        agSum, agAvg:
          FItemsValue := FItemsValue + AValue;
        agMin:
          if AValue < FItemsValue then
            FItemsValue := AValue;
        agMax:
          if AValue > FItemsValue then
            FItemsValue := AValue;
      end;
  end;
end;

procedure TfrxAggregateItem.DeleteValue;
begin
  FItemsCount := FLastCount;
  FItemsValue := FLastValue;
end;

procedure TfrxAggregateItem.Reset;
begin
  if FDontReset and (FItemsCount <> 0) then Exit;

  FItemsCount := 0;
  FItemsValue := Null;
  FItemsArray := Null;
  FItemsCountArray := Null;
end;

procedure TfrxAggregateItem.RestoreValue;
begin
  FItemsCount := FSavedCount;
  FItemsValue := FSavedValue;
end;

procedure TfrxAggregateItem.SaveValue;
begin
  FSavedCount := FItemsCount;
  FSavedValue := FItemsValue;
end;

procedure TfrxAggregateItem.StartKeep;
begin
  if not FIsPageFooter or FKeeping then Exit;
  FKeeping := True;

  FTempItemsCount := 0;
  FTempItemsValue := Null;
end;

procedure TfrxAggregateItem.EndKeep;
begin
  if not FIsPageFooter or not FKeeping then Exit;
  FKeeping := False;

  FItemsCount := FItemsCount + FTempItemsCount;
  if FItemsValue = Null then
    FItemsValue  := FTempItemsValue
  else if FTempItemsValue <> Null then
    case FAggregateFunction of
      agMin:
        if FTempItemsValue < FItemsValue then
          FItemsValue := FTempItemsValue;
      agMax:
        if FTempItemsValue > FItemsValue then
          FItemsValue := FTempItemsValue;
      else
        FItemsValue := FItemsValue + FTempItemsValue;
    end;
end;

function TfrxAggregateItem.Value: Variant;
begin
  Result := Null;
  if not VarIsNull(FItemsArray) then
  begin
    case FAggregateFunction of
      agSum, agMin, agMax:
        Result := FItemsArray[FVColumn];
      agAvg:
        Result := FItemsArray[FVColumn] / FItemsCountArray[FVColumn];
      agCount:
        Result := FItemsCountArray[FVColumn];
    end
  end
  else
    case FAggregateFunction of
      agSum, agMin, agMax:
        Result := FItemsValue;
      agAvg:
        Result := FItemsValue / FItemsCount;
      agCount:
        Result := FItemsCount;
    end;

  if VarIsNull(Result) then
    Result := 0;
end;


{ TfrxAggregateList }

constructor TfrxAggregateList.Create(AReport: TfrxReport);
begin
  FList := TList.Create;
  FReport := AReport;
end;

destructor TfrxAggregateList.Destroy;
begin
  Clear;
  FList.Free;
  inherited;
end;

procedure TfrxAggregateList.Clear;
begin
  while FList.Count > 0 do
  begin
    TObject(FList[0]).Free;
    FList.Delete(0);
  end;
end;

function TfrxAggregateList.GetItem(Index: Integer): TfrxAggregateItem;
begin
  Result := TfrxAggregateItem(FList[Index]);
end;

procedure TfrxAggregateList.ParseName(const ComplexName: String;
  var Func: TfrxAggregateFunction; var Expr: String; var DataRow: TfrxComponent;
  var CountInvisible, DontReset: Boolean; MainParent: TfrxComponent; IsAggregatedObj: Boolean);
var
  i: Integer;
  Name, Param1, Param2, Param3: String;
begin
{$IFDEF FPC}
  Param1 := '';
  Param2 := '';
  Param3 := '';
{$ENDIF}
  if MainParent = nil then
    MainParent := FReport;
  i := Pos('(', ComplexName);
  Name := UpperCase(Trim(Copy(ComplexName, 1, i - 1)));
  Get3Params(ComplexName, i, Param1, Param2, Param3);
  Param1 := Trim(Param1);
  Param2 := Trim(Param2);
  Param3 := Trim(Param3);

  if Name = 'SUM' then
    Func := agSum
  else if Name = 'MIN' then
    Func := agMin
  else if Name = 'MAX' then
    Func := agMax
  else if Name = 'AVG' then
    Func := agAvg
  else //if Name = 'COUNT' then
    Func := agCount;

  if (Name <> 'COUNT') and not (IsAggregatedObj and (Param2 = '') and (Param3 = '')) then
  begin
    Expr := Param1;
    if Param2 <> '' then
      DataRow := MainParent.FindObject(Param2) else
      DataRow := nil;
    if Param3 <> '' then
      i := StrToInt(Param3) else
      i := 0;
  end
  else
  begin
    Expr := '';
    DataRow := MainParent.FindObject(Param1);
    if Param2 <> '' then
      i := StrToInt(Param2) else
      i := 0;
  end;

  CountInvisible := (i and 1) <> 0;
  DontReset := (i and 2) <> 0;
end;

procedure TfrxAggregateList.FindAggregate(Memo: TfrxCustomMemoView;
  DataRow: TfrxComponent);
begin
  if Memo.AllowExpressions then
    FindAggregate(Memo, Memo.Text, Memo.ExpressionDelimiters, DataRow);
end;

function TfrxAggregateList.AddAggregatedItem(AObject: IfrxAggregateObject;
  Container: TfrxComponent; AList: TList): Boolean;
var
  i: Integer;
begin
  i := FList.Count;
  FindAggregate(AObject.GetInstance, AObject.GetExpression, AObject.GetExpressionDelimiters, Container, AList, AObject.GetDataRowContainer, True);
  Result := i <> FList.Count;
end;

function TfrxAggregateList.AddCalculatedValue(DataRow: TfrxComponent;
  const Value: Variant; VColumn: Integer): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 0 to FList.Count - 1 do
    if Items[i].FDataRow = DataRow then
    begin
      Result := True;
      Items[i].FVColumn := VColumn;
      Items[i].Calc(Value);
    end;
end;

procedure TfrxAggregateList.AddItems(Page: TfrxReportPage);

  procedure EnumObjects(ParentBand: TfrxBand; DataBand: TfrxDataBand);
  var
    i: Integer;
    c: TfrxComponent;
    AllObjects: TList;
  begin
    if ParentBand = nil then Exit;
    AllObjects := ParentBand.AllObjects;
    for i := 0 to AllObjects.Count - 1 do
    begin
      c := TfrxComponent(AllObjects[i]);
      if c is TfrxCustomMemoView then
        FindAggregate(TfrxCustomMemoView(c), DataBand);
    end;

    if ParentBand.Child <> nil then
      EnumObjects(ParentBand.Child, DataBand);
  end;

  procedure EnumGroups(GroupHeader: TfrxGroupHeader; DataBand: TfrxDataBand);
  var
    i: Integer;
    g: TfrxGroupHeader;
  begin
    if GroupHeader = nil then Exit;

    for i := 0 to GroupHeader.FSubBands.Count - 1 do
    begin
      g := TfrxGroupHeader(GroupHeader.FSubBands[i]);
      EnumObjects(g.FFooter, DataBand);
    end;
  end;

  procedure EnumDataBands(List: TList);
  var
    i: Integer;
    d: TfrxDataBand;
  begin
    for i := 0 to List.Count - 1 do
    begin
      d := TfrxDataBand(List[i]);
      EnumObjects(d.FFooter, d);
      EnumGroups(TfrxGroupHeader(d.FGroup), d);
      EnumDataBands(d.FSubBands);
      if d.Vertical then
        EnumObjects(d, d);
    end;
  end;

begin
  EnumDataBands(Page.FSubBands);
  EnumDataBands(Page.FVSubBands);
  if Page.FSubBands.Count > 0 then
  begin
    EnumObjects(Page.FindBand(TfrxPageFooter), TfrxDataBand(Page.FSubBands[0]));
    EnumObjects(Page.FindBand(TfrxColumnFooter), TfrxDataBand(Page.FSubBands[0]));
    EnumObjects(Page.FindBand(TfrxReportSummary), TfrxDataBand(Page.FSubBands[0]));
  end;
end;

procedure TfrxAggregateList.AddValue(DataRow: TfrxComponent; VColumn: Integer = 0);
var
  i: Integer;
begin
  for i := 0 to FList.Count - 1 do
    if Items[i].FDataRow = DataRow then
    begin
      Items[i].FVColumn := VColumn;
      Items[i].Calc(Null);
    end;
end;

procedure TfrxAggregateList.DeleteValue(DataRow: TfrxComponent);
var
  i: Integer;
begin
  for i := 0 to FList.Count - 1 do
    if Items[i].FDataRow = DataRow then
      Items[i].DeleteValue;
end;

function TfrxAggregateList.GetValue(ParentContainer: TfrxComponent;
  const ComplexName: String; VColumn: Integer = 0): Variant;
var
  i: Integer;
begin
  Result := Null;

  for i := 0 to FList.Count - 1 do
    if (Items[i].FParentContainer = ParentContainer) and
       (AnsiCompareText(Items[i].FOriginalName, Trim(ComplexName)) = 0) then
    begin
      Items[i].FVColumn := VColumn;
      Result := Items[i].Value;
      break;
    end;
end;

function TfrxAggregateList.GetValue(ParentContainer: TfrxComponent; VColumn: Integer;
  const Name, Expression: String; DataRow: TfrxComponent; Flags: Integer): Variant;
var
  i: Integer;
  fn: TfrxAggregateFunction;
  AggObject: IfrxAggregateObject;
begin
  { TODO: move aggregates to interfaces }
  { remove depency from FCurBand }
  if Supports(DataRow, IfrxAggregateObject, AggObject) then
    ParentContainer := AggObject.GetParentContainer;
  Result := Null;
  if Name = 'SUM' then
    fn := agSum
  else if Name = 'AVG' then
    fn := agAvg
  else if Name = 'MIN' then
    fn := agMin
  else if Name = 'MAX' then
    fn := agMax
  else
    fn := agCount;

  for i := 0 to FList.Count - 1 do
    if ((Items[i].FParentContainer = ParentContainer){ or (Items[i].FParentContainer = nil)}) and
      (Items[i].FAggregateFunction = fn) and
      (AnsiCompareText(Items[i].FExpression, Trim(Expression)) = 0) and
      ((DataRow = nil) or (Items[i].FDataRow = DataRow)) and
      (Items[i].FCountInvisibleBands = ((Flags and 1) <> 0)) and
      (Items[i].FDontReset = ((Flags and 2) <> 0)) then
    begin
      Items[i].FVColumn := VColumn;
      Result := Items[i].Value;
      break;
    end;
end;

procedure TfrxAggregateList.Reset(ParentContainer: TfrxComponent);
var
  i: Integer;
begin
  for i := 0 to FList.Count - 1 do
    if Items[i].FParentContainer = ParentContainer then
      Items[i].Reset;
end;

procedure TfrxAggregateList.RestoreValue(DataRow: TfrxComponent);
var
  i: Integer;
begin
  for i := 0 to FList.Count - 1 do
    if Items[i].FDataRow = DataRow then
      Items[i].RestoreValue;
end;

procedure TfrxAggregateList.SaveValue(DataRow: TfrxComponent);
var
  i: Integer;
begin
  for i := 0 to FList.Count - 1 do
    if Items[i].FDataRow = DataRow then
      Items[i].SaveValue;
end;

procedure TfrxAggregateList.StartKeep;
var
  i: Integer;
begin
  for i := 0 to FList.Count - 1 do
    Items[i].StartKeep;
end;

procedure TfrxAggregateList.EndKeep;
var
  i: Integer;
begin
  for i := 0 to FList.Count - 1 do
    Items[i].EndKeep;
end;

procedure TfrxAggregateList.FindAggregate(AComponent: TfrxComponent;
  const Text: String; const ExpressionDelimiters: String; DataRow: TfrxComponent; AList: TList; MainParent: TfrxComponent; IsAggregatedObj: Boolean);
const
  Spaces = [#1..#32, '!', '#', '$', '%', '^', '&', '|', '+', '-', '*', '/',
            '=', '.', ',', '[', ']', '0'..'9'];
  IdentSpaces = Spaces - ['0'..'9'] + ['('];
var
  i, j: Integer;
  //s,
  s1, dc1, dc2: String;
  Report: TfrxReport;

  procedure FindIn(const s: String); forward;

  procedure SkipString(const s: String; var i: Integer);
  var
    ch: Char;
  begin
    ch := s[i];
    Inc(i);
    while (i <= Length(s)) and (s[i] <> ch) do
      Inc(i);
    Inc(i);
  end;

  function Check(s: String): Boolean;
  var
    i: Integer;
    ds: TfrxDataSet;
    s1: String;
    VarVal: Variant;
  begin
    Result := False;
    if s = '' then Exit;
{$IFDEF FPC}
    ds := nil;
    s1 := '';
{$ENDIF}
    { searching in the variables }
    i := Report.Variables.IndexOf(s);
    if i <> -1 then
    begin
      VarVal := Report.Variables.Items[i].Value;
      if VarIsNull(VarVal) then
        s := ''
      else
        s := VarVal;
      FindIn(s);
      Result := True;
      Exit;
    end;

    { maybe it's a dataset/field? }
    Report.GetDataSetAndField(s, ds, s1);
    if (ds <> nil) and (s1 <> '') then
      Result := True;
  end;

  function GetParentAggContainer(c: TfrxComponent): TfrxComponent;
  var
    AggObj: IfrxAggregateObject;
  begin
    if Supports(c, IfrxAggregateObject, AggObj) then
    begin
      Result := AggObj.GetParentContainer;
      Exit;
    end;
    Result := c.Parent;
    while Assigned(Result) and not (Result is TfrxBand) do
      Result := Result.Parent;
  end;

  procedure AddAggregate(const ComplexName: String);
  var
    Item: TfrxAggregateItem;
  begin
    Item := TfrxAggregateItem.Create;
    AList.Add(Item);

    ParseName(ComplexName, Item.FAggregateFunction, Item.FExpression,
      Item.FDataRow, Item.FCountInvisibleBands, Item.FDontReset, MainParent, IsAggregatedObj);
    if Item.FDataRow = nil then
      Item.FDataRow := DataRow;

    Item.FReport := FReport;

    Item.FParentContainer := GetParentAggContainer(AComponent);
    // change to an interface
    if (Item.FParentContainer is TfrxBand) and TfrxBand(Item.FParentContainer).Vertical and (THackComponent(AComponent).FOriginalBand <> nil) and
      (TfrxBand(THackComponent(AComponent).FOriginalBand).BandNumber in [1, 3, 5, 13]) then
      Item.FParentContainer := TfrxBand(THackComponent(AComponent).FOriginalBand);
    Item.FIsPageFooter := Item.FParentContainer is TfrxPageFooter;
    Item.FOriginalName := Trim(ComplexName);
    Item.FMemoName := AComponent.Name;
    Item.Reset;
  end;

  procedure FindIn(const s: String);
  var
    i, j: Integer;
    s1, s2, s3, s4: String;
  begin
    if Check(s) then
      Exit;

    { this is an expression }
    i := 1;
    while i <= Length(s) do
    begin
      { skip non-significant chars }
{$IFDEF DELPHI12}
      while (i <= Length(s)) and (CharInSet(s[i], Spaces)) do
{$ELSE}
      while (i <= Length(s)) and (s[i] in Spaces) do
{$ENDIF}
        Inc(i);

      case s[i] of
        '<':
          begin
          {$IFDEF DELPHI12}
            FindIn(frxGetBrackedVariableW(s, '<', '>', i, j));
          {$ELSE}
            FindIn(frxGetBrackedVariable(s, '<', '>', i, j));
          {$ENDIF}
            i := j;
          end;

        '''', '"':
          SkipString(s, i);

        '(':
          begin
          {$IFDEF DELPHI12}
            FindIn(frxGetBrackedVariableW(s, '(', ')', i, j));
          {$ELSE}
            FindIn(frxGetBrackedVariable(s, '(', ')', i, j));
          {$ENDIF}
            if i = j then
              Inc(i) else
              i := j;
          end;
        else
        begin
          j := i;
          {$IFDEF DELPHI12}
          while (i <= Length(s)) and not (CharInSet(s[i], IdentSpaces)) do
          {$ELSE}
          while (i <= Length(s)) and not (s[i] in IdentSpaces) do
          {$ENDIF}
            Inc(i);
          s1 := UpperCase(Copy(s, j, i - j));

          if (s1 = 'SUM') or (s1 = 'MIN') or (s1 = 'MAX') or
             (s1 = 'AVG') or (s1 = 'COUNT') then
          begin
            if (i < Length(s)) and (s[i] = '(') then
            begin
              Get3Params(s, i, s2, s3, s4);
              AddAggregate(Copy(s, j, i - j));
            end;
          end
          else
            Check(s1);
        end;
      end;
    end;
  end;

begin
  if not Assigned(AList) then
    AList := FList;
  Report := AComponent.Report;
//  if Memo.AllowExpressions then
  begin
    //s := Memo.Text;
    i := 1;
    dc1 := ExpressionDelimiters;
    dc2 := Copy(dc1, Pos(',', dc1) + 1, 255);
    dc1 := Copy(dc1, 1, Pos(',', dc1) - 1);

    repeat
      while (i < Length(Text)) and (Copy(Text, i, Length(dc1)) <> dc1) do Inc(i);
{$IFDEF DELPHI12}
      s1 := frxGetBrackedVariableW(Text, dc1, dc2, i, j);
{$ELSE}
      s1 := frxGetBrackedVariable(Text, dc1, dc2, i, j);
{$ENDIF}
      if i <> j then
      begin
        FindIn(s1);
        i := j;
        j := 0;
      end;
    until i = j;
  end;
end;

procedure TfrxAggregateList.ClearValues;
var
  i: Integer;
  SaveReset: Boolean;
begin
  for i := 0 to FList.Count - 1 do
  begin
    SaveReset := Items[i].FDontReset;
    Items[i].FDontReset := False;
    Items[i].Reset;
    Items[i].FDontReset := SaveReset;
  end;
end;

end.
