{*******************************************************}
{                                                       }
{                       EhLib 10.2                      }
{       Utilities to sort, filter data in DataSet       }
{                                                       }
{      Copyright (c) 2002-2022 by Dmitry V. Bolshakov   }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit DBUtilsEh;

interface

uses
  Variants, Messages,
  {$IFDEF FPC}
    EhLibLCL, LCLType, DBGridsEh,
    {$IFDEF FPC_CROSSP}
      LCLIntf,
    {$ELSE}
      Windows, Win32Extra,
    {$ENDIF}
  {$ELSE}
    EhLibVCL, DBGridEh, Contnrs, Windows,
  {$ENDIF}

  {$IFDEF NEXTGEN}
  {$ELSE}
     {$IFDEF EH_LIB_9} WideStrings, {$ENDIF}
  {$ENDIF}

  MemTableDataEh, MemTableEh,
  Db, SysUtils, Classes, TypInfo, ToolCtrlsEh;

type

  TDateValueToSQLStringProcEh = function(DataSet: TDataSet; Value: Variant): String;
  TNullComparisonSyntaxEh = (ncsAsIsNullEh, ncsAsEqualToNullEh);
  TLocalFilterApplyingWayEh = (lfawPropertyFilterEh, lfawEventFilterEh);

var

  STFilterOperatorsStrMapEh: array[TSTFilterOperatorEh] of String =
  ('', '=', '<>',
    '>', '<', '>=', '<=',
    '~', '!~',
    'In', '!In',
    {=}'Null', {<>}'Null',
    'AND', 'OR',
    '',
    {=}'Null', {<>}'Null');

{$IFDEF FPC}
  LFBr: String = '';
  RFBr: String = '';
{$ELSE}
  LFBr: String = '['; 
  RFBr: String = ']'; 
{$ENDIF}

const

  STFldTypeMapEh: array[TFieldType] of TSTOperandTypeEh = (
    botNon{ftUnknown}, botString{ftString}, botNumber{ftSmallint}, botNumber{ftInteger}, botNumber{ftWord},
    botBoolean{ftBoolean}, botNumber{ftFloat}, botNumber{ftCurrency}, botNumber{ftBCD}, botDateTime{ftDate}, botDateTime{ftTime}, botDateTime{ftDateTime},
    botNon{ftBytes}, botNon{ftVarBytes}, botNumber{ftAutoInc}, botNon{ftBlob}, botString{ftMemo}, botString{ftGraphic}, botString{ftFmtMemo},
    botString{ftParadoxOle}, botString{ftDBaseOle}, botString{ftTypedBinary}, botString{ftCursor}, botString{ftFixedChar}, botString{ftWideString},
    botNumber{ftLargeint}, botString{ftADT}, botString{ftArray}, botNon{ftReference}, botNon{ftDataSet}
    ,botString{ftOraBlob}, botString{ftOraClob}, botString{ftVariant}, botNon{ftInterface}, botNon{ftIDispatch}, botString{ftGuid}
    , botDateTime{ftTimeStamp}, botNumber{ftFMTBcd}
{$IFDEF FPC}
    ,botString ,botString
{$ENDIF}
{$IFDEF EH_LIB_10}
    ,botString, botString, botNon, botString
{$ENDIF}
{$IFDEF EH_LIB_12}
    ,botNumber, botNumber, botNumber, botNumber, botNon, botNon, botNon
{$ENDIF}
{$IFDEF EH_LIB_13}
    ,botNon, botNon, botNumber
{$ENDIF}
    );

  STFilterOperatorsSQLStrMapEh: array[TSTFilterOperatorEh] of String =
  ('', '=', '<>',
    '>', '<', '>=', '<=',
    'LIKE', 'NOT LIKE',
    'IN', 'NOT IN',
    'IS NULL', 'IS NOT NULL',
    'AND', 'OR',
    '',
    '= NULL', '<> NULL'
    );

procedure InitSTFilterOperatorsStrMap;

{ FilterExpression }

function ParseSTFilterExpressionEh(Exp: String; var FExpression: TSTFilterExpressionEh; DefaultOperator: TSTFilterDefaultOperatorEh): Boolean;
procedure ClearSTFilterExpression(var FExpression: TSTFilterExpressionEh);

type
  TOneExpressionFilterStringProcEh = function(O: TSTFilterOperatorEh; v: Variant;
    const FieldName: String; DataSet: TDataSet;
    DateValueToSQLStringProc: TDateValueToSQLStringProcEh;
    SupportsLike: Boolean;
    NullComparisonSyntax: TNullComparisonSyntaxEh;
    InOperIsSupported: Boolean = False): String;

{ Useful routines to form filter string for dataset }

function GetExpressionAsFilterString(AGrid: TCustomDBGridEh;
  OneExpressionProc: TOneExpressionFilterStringProcEh;
  DateValueToSQLStringProc: TDateValueToSQLStringProcEh;
  UseFieldOrigin: Boolean = False;
  SupportsLocalLike: Boolean = False;
  NullComparisonSyntax: TNullComparisonSyntaxEh = ncsAsIsNullEh;
  InOperIsSupported: Boolean = False): String;

function GetOneExpressionAsLocalFilterString(O: TSTFilterOperatorEh;
  v: Variant; const FieldName: String; DataSet: TDataSet;
  DateValueToSQLStringProc: TDateValueToSQLStringProcEh;
  SupportsLike: Boolean;
  NullComparisonSyntax: TNullComparisonSyntaxEh;
  InOperIsSupported: Boolean = False): String;

function GetOneExpressionAsSQLWhereString(O: TSTFilterOperatorEh; v: Variant;
  const FieldName: String; DataSet: TDataSet;
  DateValueToSQLStringProc: TDateValueToSQLStringProcEh; SupportsLike: Boolean;
  NullComparisonSyntax: TNullComparisonSyntaxEh;
  InOperIsSupported: Boolean = False): String;

function DateValueToDataBaseSQLString(DataBaseName: String; v: Variant): String;

procedure ApplyFilterSQLBasedDataSet(Grid: TCustomDBGridEh; DataSet: TDataSet;
  DateValueToSQLString: TDateValueToSQLStringProcEh; IsReopen: Boolean;
  const SQLPropName: String);

{ DatasetFeatures }

type

  TSimpleTextApplyFilterEh = procedure (Sender: TObject; DataSet: TDataSet;
    FieldName: String; Operation: TLSAutoFilterTypeEh; FilterText: String) of object;

  TDataSetClass = class of TDataSet;

  TDatasetFeaturesEh = class
  private
    FDataSetClass: TDataSetClass;
  public
    constructor Create; virtual;

    function BuildSortingString(AGrid: TCustomDBGridEh; DataSet: TDataSet): String; virtual;
    function CanFilterField(Field: TField): Boolean; virtual;
    function CheckFieldForSimpleTextFilter(Field: TField): Boolean; virtual;
    function CheckCurrentRecordMatchesGridSTFilter(Grid: TCustomDBGridEh; DataSet: TDataSet): Boolean; virtual;
    function CheckCurrentRecordMatchesGridSTFilterColumn(Column: TColumnEh; Grid: TCustomDBGridEh; DataSet: TDataSet): Boolean; virtual;
    function CheckCurrentRecordMatchesSimpleExpression(Column: TColumnEh; Grid: TCustomDBGridEh; DataSet: TDataSet; AnOperator: TSTFilterOperatorEh; AnOperand: Variant): Boolean; virtual;
    function CreateAndAsignMTDateField(DataStruct: TMTDataStructEh; AField: TField): TMTDataFieldEh; virtual;
    function GetDataSetLikeWildcardForSeveralCharacters: String; virtual;
    function GetLocalFilterApplyingWay: TLocalFilterApplyingWayEh; virtual;
    function LocateText(AGrid: TCustomDBGridEh; const FieldName: string; const Text: String; AOptions: TLocateTextOptionsEh; Direction: TLocateTextDirectionEh; Matching: TLocateTextMatchingEh; TreeFindRange: TLocateTextTreeFindRangeEh; TimeOut: System.LongWord = 0; CheckValueEvent: TCheckColumnValueAcceptEventEh = nil): Boolean; virtual;
    function MoveRecords(Sender: TObject; BookmarkList: TBMListEh; ToRecNo: Longint; CheckOnly: Boolean): Boolean; virtual;
    function NullComparisonSyntax(AGrid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): TNullComparisonSyntaxEh; virtual;
    function CustomFilterSingleCharWildcard: String; virtual;
    function CustomFilterMultipleCharsWildcard: String; virtual;

    procedure ApplyFilter(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); virtual;

    procedure ApplyGridLocalFilter(Grid: TCustomDBGridEh; DataSet: TDataSet; IsReopen: Boolean); virtual;
    function GetGridFilterAsFilterString(Grid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): String; virtual;
    function GetColumnExpressionAsFilterString(Column: TColumnEh; Grid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): String; virtual;
    function GetBinaryExpressionAsFilterString(FieldName: String; AnOperator: TSTFilterOperatorEh; AnOperand: Variant; Column: TColumnEh; Grid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): String; virtual;
    function GetColumnFilterFieldName(Column: TColumnEh; Grid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): String; virtual;
    function ColumnOperatorValueToFilterStrValue(AnOperator: TSTFilterOperatorEh; AnOperand: Variant; Column: TColumnEh; Grid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): String; virtual;
    function IsInOperatorSupported(Grid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): Boolean; virtual;
    function IsLikeOperatorSupported(Grid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): Boolean; virtual;
    function IsFilterUseFieldOrigin(Column: TColumnEh; Grid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): Boolean; virtual;
    function GetNullComparisionFilterString(AnOperator: TSTFilterOperatorEh; Grid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): String; virtual;
    function GetOperatorFilterStrValue(AnOperator: TSTFilterOperatorEh; Grid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): String; virtual;
    function FilterFieldNameToStrValue(FieldName: String; Column: TColumnEh; Grid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): String; virtual;

    function ExpressionValueToFilterStrValue(AnOperator: TSTFilterOperatorEh; Value: Variant; Column: TColumnEh; Grid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): String; virtual;
    function DateTimeValueToFilterStrValue(AnOperator: TSTFilterOperatorEh; Value: TDateTime; Column: TColumnEh; Grid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): String; virtual;
    function FloatValueToFilterStrValue(AnOperator: TSTFilterOperatorEh; Value: Extended; Column: TColumnEh; Grid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): String; virtual;
    function BooleanValueToFilterStrValue(AnOperator: TSTFilterOperatorEh; Value: Boolean; Column: TColumnEh; Grid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): String; virtual;
    function VarValueToFilterStrValue(AnOperator: TSTFilterOperatorEh; Value: Variant; Column: TColumnEh; Grid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): String; virtual;

    function WriteDataSetToMemTable(DataSet: TDataSet; MemTable: TCustomMemTableEh; RecordCount: Integer; Mode: TLoadMode; UseCachedUpdates: Boolean): Integer; virtual;
    function GetFilterListValuesLimit(Sender: TObject; DataSet: TDataSet): Integer; virtual;

    procedure ApplyGridServerFilter(Grid: TCustomDBGridEh; DataSet: TDataSet; IsReopen: Boolean); virtual;

    procedure ApplySimpleTextFilter(DataSet: TDataSet; const FieldNames: String; Operation: TLSAutoFilterTypeEh; const FilterText: String); virtual;
    procedure ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); virtual;
    procedure ExecuteFindDialog(Sender: TObject; const Text, FieldName: String; Modal: Boolean); virtual;
    procedure FillSTFilterListDataValues(AGrid: TCustomDBGridEh; Column: TColumnEh; Items: TStrings); virtual;
    procedure FillSTFilterListCommandValues(AGrid: TCustomDBGridEh; Column: TColumnEh; Items: TStrings); virtual;
    procedure FillFieldUniqueValues(Field: TField; Items: TStrings); virtual;
  end;

  TSQLDatasetFeaturesEh = class(TDatasetFeaturesEh)
  private
    FSortUsingFieldName: Boolean;
    FSQLPropName: String;
    FDateValueToSQLString: TDateValueToSQLStringProcEh;
    FSupportsLocalLike: Boolean;

  public
    constructor Create; override;

    procedure ApplyFilter(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); override;
    procedure ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean); override;

    procedure ApplyGridServerFilter(Grid: TCustomDBGridEh; DataSet: TDataSet; IsReopen: Boolean); override;
    function DateTimeValueToFilterStrValue(AnOperator: TSTFilterOperatorEh; Value: TDateTime; Column: TColumnEh; Grid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): String; override;
    function FloatValueToFilterStrValue(AnOperator: TSTFilterOperatorEh; Value: Extended; Column: TColumnEh; Grid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): String; override;
    function VarValueToFilterStrValue(AnOperator: TSTFilterOperatorEh; Value: Variant; Column: TColumnEh; Grid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): String; override;

    function GetSQLFilterMarker(Grid: TCustomDBGridEh; DataSet: TDataSet): String; virtual;
    function GetServerTypeName(Grid: TCustomDBGridEh; DataSet: TDataSet): String; virtual;

    property DateValueToSQLString: TDateValueToSQLStringProcEh read FDateValueToSQLString write FDateValueToSQLString;
    property SortUsingFieldName: Boolean read FSortUsingFieldName write FSortUsingFieldName;
    property SQLPropName: String read FSQLPropName  write FSQLPropName;
    property SupportsLocalLike: Boolean read FSupportsLocalLike write FSupportsLocalLike;
  end;

  TCommandTextDatasetFeaturesEh = class(TSQLDatasetFeaturesEh)
  public
    constructor Create; override;
  end;

  TDatasetFeaturesEhClass = class of TDatasetFeaturesEh;

{ Register/Unregister DatasetFeatures }

procedure RegisterDatasetFeaturesEh(DatasetFeaturesClass: TDatasetFeaturesEhClass;
  DataSetClass: TDataSetClass);
procedure UnregisterDatasetFeaturesEh(DataSetClass: TDataSetClass);
function GetDatasetFeaturesForDataSet(DataSet: TDataSet): TDatasetFeaturesEh;
function GetDatasetFeaturesForDataSetClass(DataSetClass: TClass): TDatasetFeaturesEh;


function IsSQLBasedDataSet(DataSet: TDataSet; var SQL: TStrings): Boolean;
function IsDataSetHaveSQLLikeProp(DataSet: TDataSet; const SQLPropName: String; var SQLPropValue: WideString): Boolean;

procedure ApplySortingForSQLBasedDataSet(Grid: TCustomDBGridEh; DataSet: TDataSet;
  UseFieldName: Boolean; IsReopen: Boolean; const SQLPropName: String);

function LocateDatasetTextEh(AGrid: TCustomDBGridEh;
  const FieldName, Text: String; AOptions: TLocateTextOptionsEh;
  Direction: TLocateTextDirectionEh; Matching: TLocateTextMatchingEh;
  TreeFindRange: TLocateTextTreeFindRangeEh;
  CheckValueEvent: TCheckColumnValueAcceptEventEh): Boolean;

function DefaultLocateDatasetTextEh(AGrid: TCustomDBGridEh;
  FieldName, Text: String; AOptions: TLocateTextOptionsEh;
  Direction: TLocateTextDirectionEh; Matching: TLocateTextMatchingEh;
  TimeOut: LongWord = 0;
  CheckValueProc: TCheckColumnValueAcceptEventEh = nil): Boolean;

function CharAtPos(const S: String; Pos: Integer): Char;

var
  SQLFilterMarker: String = '/*FILTER*/';

type
  TRoughStringCompareProcEh = function (s1, s2: String): Integer;
  TRoughStringSearchEh = function (const SubStr, S: string;
    CaseInsensitive: Boolean; WholeWord: Boolean; Offset: Integer = 1): Integer;
  TMakeStringRoughEh = function (s: String): String;
  TStringPosProcEh = function (const SubStr, S: string; Offset: Integer): Integer;

var
  RoughStringCompareProcEh: TRoughStringCompareProcEh;
  RoughStringSearchProcEh: TRoughStringSearchEh;
  RoughStringPosProcEh: TStringPosProcEh;
  MakeStringRoughProcEh: TMakeStringRoughEh;

function DefaultRoughStringPosEh(SubStr, S: string; Offset: Integer): Integer;
function DefaultRoughStringCompareEh(s1, s2: String): Integer;
function DefaultCaseInsensitiveStringCompareEh(s1, s2: String): Integer;
function DefaultMakeStringRoughEh(s: String): String;
function DefaultRoughStringSearchEh(SubStr, S: string; CaseInsensitive: Boolean; WholeWord: Boolean; Offset: Integer = 1): Integer;
function StringIsMatchLikePattern(SourceStr: string; LikeExpr: string; IgnoreCase: Boolean; SingleCharWildcard: String; MultipleCharsWildcard: String): Boolean;

resourcestring

  SNotOperatorEh = 'Not';
  SAndOperatorEh = 'AND';
  SOrOperatorEh = 'OR';
  SLikePredicatEh = ''; 
  SInPredicatEh = 'In';
  SNullConstEh = 'Null';

implementation

uses
  DBGridEhFindDlgs,
  StrUtils,
  EhLibLangConsts;

type
  TBMListCrackEh = class(TBMListEh);

function StringIsMatchLikePattern(SourceStr: string; LikeExpr: string; IgnoreCase: Boolean;
  SingleCharWildcard: String; MultipleCharsWildcard: String): Boolean;
var
  SCWC, MCWC: Char;

  function InStr(const SourceStr: string; const LikeExpr: string): Integer;
  var
   i, j: Integer;
   Diff: Integer;
  begin
    if not UnuseOneCharLikeWildcardEh then
    begin
      i := Pos(SCWC, LikeExpr);
      if i = 0 then
      begin
        Result := Pos(LikeExpr, SourceStr);
        Exit;
      end;
    end;

    Diff := Length(SourceStr) - Length(LikeExpr);
    if Diff < 0 then
    begin
      Result := 0;
      Exit;
    end;

    for i := 0 to Diff do
    begin
      for j := 1 to Length(LikeExpr) do
      begin
        if (SourceStr[i + j] = LikeExpr[j]) or ((not UnuseOneCharLikeWildcardEh) and (LikeExpr[j] = SCWC)) then
        begin
          if j = Length(LikeExpr) then
          begin
            Result := i + 1;
            Exit;
          end;
        end
        else Break;
      end;
    end;

    Result := 0;
  end;

  function RestOfLineHaveStaticChars(Line: String; StartPos: Integer): Boolean;
  var
    i: Integer;
  begin
    Result := False;
    for i := StartPos to Length(Line) do
    begin
      if (Line[i] <> MCWC) and (Line[i] <> SCWC) then
      begin
        Result := True;
        Exit;
      end;
    end;
  end;


var
  LikeCurPos, SourceCurPos, SourceLen, LikeLen: Integer;
  i, iTemp: Integer;
  sTemp: string;
  OneCharWildcard: Boolean;
begin
  if SourceStr = LikeExpr then
  begin
    Result := True;
    Exit;
  end;

  if (Length(SingleCharWildcard) > 1) then
    raise Exception.Create('Multi-character value in a SingleCharWildcard variable is not supported.');
  if (Length(MultipleCharsWildcard) > 1) then
    raise Exception.Create('Multi-character value in a MultipleCharsWildcard variable is not supported.');

  SCWC := SingleCharWildcard[1]; //_
  MCWC := MultipleCharsWildcard[1]; //%

  repeat
    i := Pos(MCWC+MCWC, LikeExpr);
    if i > 0 then
      LikeExpr := Copy(LikeExpr, 1, i - 1) + MCWC + Copy(LikeExpr, i + 2, MaxInt);
  until i = 0;

  if not UnuseOneCharLikeWildcardEh then
  begin
    repeat
      i := Pos(SCWC+MCWC, LikeExpr);
      if i > 0 then
        LikeExpr := Copy(LikeExpr, 1, i - 1) + MCWC + Copy(LikeExpr, i + 2, MaxInt);
    until i = 0;
    repeat
      i := Pos(MCWC+SCWC, LikeExpr);
      if i > 0 then
        LikeExpr := Copy(LikeExpr, 1, i - 1) + MCWC + Copy(LikeExpr, i + 2, MaxInt);
    until i = 0;
  end;

  if LikeExpr = MCWC then
  begin
    Result := True;
    Exit;
  end;

  SourceLen := Length(SourceStr);
  LikeLen   := Length(LikeExpr);

  if (LikeLen = 0) or (SourceLen = 0) then
  begin
    Result := False;
    Exit;
  end;

  if IgnoreCase then
  begin
    SourceStr := AnsiUpperCase(SourceStr);
    LikeExpr  := AnsiUpperCase(LikeExpr);
  end;

  SourceCurPos := 1;
  LikeCurPos   := 1;
  Result := True;

  repeat
    if SourceStr[SourceCurPos] = LikeExpr[LikeCurPos] then
    begin
      Inc(LikeCurPos);
      Inc(SourceCurPos);
      Continue;
    end;

    if (not UnuseOneCharLikeWildcardEh) and (LikeExpr[LikeCurPos] = SCWC) then
    begin
      Inc(LikeCurPos);
      Inc(SourceCurPos);
      Continue;
    end;

    if LikeExpr[LikeCurPos] = MCWC then
    begin
      sTemp := Copy(LikeExpr, LikeCurPos + 1, LikeLen);
      i := Pos(MCWC, sTemp);
      if i > 0 then sTemp := Copy(sTemp, 1, i - 1);
      iTemp := Length(sTemp);

      if i = 0 then
      begin
        
        if iTemp = 0 then Exit;

        for i := 0 to iTemp - 1 do
        begin
          OneCharWildcard := not UnuseOneCharLikeWildcardEh and (sTemp[iTemp - i] = SCWC);
          if (sTemp[iTemp - i] <> SourceStr[SourceLen - i]) and
             not OneCharWildcard then
          begin
            Result := False;
            Exit;
          end;
        end;
        Exit;
      end;
      Inc(LikeCurPos, 1 + iTemp);

      i := InStr(Copy(SourceStr, SourceCurPos, MaxInt), sTemp);
      if i = 0 then
      begin
        Result := False;
        Exit;
      end;
      SourceCurPos := i + iTemp;
      Continue;
    end;

    Result := False;
    Break;
  until (SourceCurPos > SourceLen) or (LikeCurPos > LikeLen);

  if SourceCurPos <= SourceLen then
    Result := False;
  if (LikeCurPos <= LikeLen) and RestOfLineHaveStaticChars(LikeExpr, LikeCurPos) then
    Result := False;
end;

function RemoveDiacritics(s: String): String;
{$IFDEF FPC_CROSSP}
begin
  Result := s;
end;
{$ELSE}
var
  Tmp: string;
  Len: integer;
  i: Integer;
{$IFDEF EH_LIB_14}
  sb: TStringBuilder;
{$ELSE}
  sb: String;
{$ENDIF}
begin
  Len := FoldString(MAP_COMPOSITE, PChar(s), -1, nil, 0);
  SetLength(Tmp, Len);
  FoldString(MAP_COMPOSITE, PChar(s), -1, PChar(Tmp), Len);

{$IFDEF EH_LIB_14}
  sb := TStringBuilder.Create('');
{$ELSE}
  sb := '';
{$ENDIF}
  for i := 1 to Length(Tmp) do
    if IsCharAlphaNumeric(Tmp[i]) or
       CharInSetEh(Tmp[i], [' ', '!','>','<','#',';',':','-','+']) or
       CharInSetEh(Tmp[i], ['-','=', '~','"','''','\','/','?','.']) or
       CharInSetEh(Tmp[i], [',',']','[','{','}','&','^','%','$','@'])
    then    
{$IFDEF EH_LIB_14}
      sb.Append(Tmp[i]);

  Result := sb.ToString;
  sb.Free;
{$ELSE}
      sb := sb + Tmp[i];
  Result := sb;
{$ENDIF}
end;
{$ENDIF} 

function DefaultMakeStringRoughEh(s: String): String;
begin
  Result := RemoveDiacritics(s);
end;

function DefaultRoughStringPosEh(SubStr, S: string; Offset: Integer): Integer;
begin
  if @MakeStringRoughProcEh <> nil then
    SubStr := MakeStringRoughProcEh(SubStr);
  if @MakeStringRoughProcEh <> nil then
    S := MakeStringRoughProcEh(S);
  Result := PosEx(SubStr, S, Offset);
end;

function DefaultRoughStringSearchEh(SubStr, S: string; CaseInsensitive: Boolean;
  WholeWord: Boolean; Offset: Integer = 1): Integer;
begin
  if @MakeStringRoughProcEh <> nil then
    SubStr := MakeStringRoughProcEh(SubStr);
  if @MakeStringRoughProcEh <> nil then
    S := MakeStringRoughProcEh(S);
  Result := StringSearch(SubStr, S, CaseInsensitive, WholeWord, Offset);
end;

function DefaultRoughStringCompareEh(s1, s2: String): Integer;
begin
  if @MakeStringRoughProcEh <> nil then
    s1 := MakeStringRoughProcEh(s1);
  if @MakeStringRoughProcEh <> nil then
    s2 := MakeStringRoughProcEh(s2);
  Result := DefaultCaseInsensitiveStringCompareEh(s1, s2);
end;

function DefaultCaseInsensitiveStringCompareEh(s1, s2: String): Integer;
begin
  Result := AnsiCompareText(s1, s2);
end;

procedure SetDataSetSQLLikeProp(DataSet: TDataSet; const SQLPropName: String; const SQLPropValue: WideString);
var
  FPropInfo: PPropInfo;
begin
  FPropInfo := GetPropInfo(DataSet.ClassInfo, SQLPropName);
  if FPropInfo = nil then Exit;
  if PropType_getKind(PropInfo_getPropType(FPropInfo)) = tkString then
    SetStrProp(DataSet, FPropInfo, String(SQLPropValue))
{$IFDEF EH_LIB_12}
  else if PropType_getKind(PropInfo_getPropType(FPropInfo)) = tkUString then
    SetStrProp(DataSet, FPropInfo, SQLPropValue)
{$ENDIF}

{$IFDEF NEXTGEN}
{$ELSE}
  else if PropType_getKind(PropInfo_getPropType(FPropInfo)) = tkWString then
    SetWideStrProp(DataSet, FPropInfo, SQLPropValue)
{$ENDIF}

  else if PropType_getKind(PropInfo_getPropType(FPropInfo)) = tkClass then
    if TObject(GetOrdProp(DataSet, FPropInfo)) is TStrings then
      (TObject(GetOrdProp(DataSet, FPropInfo)) as TStrings).Text := String(SQLPropValue)
{$IFDEF CIL}
{$ELSE}
{$IFDEF NEXTGEN}
{$ELSE}
  {$IFDEF EH_LIB_9}
    else if TObject(GetOrdProp(DataSet, FPropInfo)) is TWideStrings then
      (TObject(GetOrdProp(DataSet, FPropInfo)) as TWideStrings).Text := SQLPropValue
  {$ENDIF}
{$ENDIF}
{$ENDIF}
    ;
end;

procedure ClearSTFilterExpression(var FExpression: TSTFilterExpressionEh);
begin
  FExpression.Operator1 := foNon;
  FExpression.Operand1 := Null;
  FExpression.Relation := foNon;
  FExpression.Operator2 := foNon;
  FExpression.Operand2 := Null;
end;

procedure InitSTFilterOperatorsStrMap;
var
  NotOperator: String;
begin
  if SNotOperatorEh <> ''
    then NotOperator := SNotOperatorEh + ' '
    else NotOperator := 'Not ';
  if SLikePredicatEh <> '' then
  begin
    STFilterOperatorsStrMapEh[foLike] := SLikePredicatEh;
    STFilterOperatorsStrMapEh[foNotLike] := NotOperator + SLikePredicatEh;
  end;
  if SInPredicatEh <> '' then
  begin
    STFilterOperatorsStrMapEh[foIn] := SInPredicatEh;
    STFilterOperatorsStrMapEh[foNotIn] := NotOperator + SInPredicatEh;
  end;
  if SNullConstEh <> '' then
  begin
    STFilterOperatorsStrMapEh[foNull] := SNullConstEh;
    STFilterOperatorsStrMapEh[foNotNull] := SNullConstEh;
  end;
  if SAndOperatorEh <> '' then
    STFilterOperatorsStrMapEh[foAND] := SAndOperatorEh;
  if SOrOperatorEh <> '' then
    STFilterOperatorsStrMapEh[foOR] := SOrOperatorEh;
end;

{$IFDEF FPC}
function NextCharIndex(const S: string; Index: Integer): Integer;
begin
  Result := Index + 1;
  assert((Index > 0) and (Index <= Length(S)));
  if SysLocale.FarEast and (S[Index] in LeadBytes) then
    Result := Index + StrCharLength(PChar(S) + Index - 1);
end;
{$ENDIF}

{ ParseSTFilterExpression }

type
  TOperator = (
    opNon, opEqual, opNotEqual,
    opGreaterThan, opLessThan, opGreaterOrEqual, opLessOrEqual,
    opLike,
    opIn,
    opAND, opOR,
    opValue,
    opNot, opComma, opOpenBracket, opCloseBracket, opQuote, opNullConst);

const
  OperatorAdvFilterOperatorMap: array[TOperator] of TSTFilterOperatorEh = (
    foNon, foEqual, foNotEqual,
    foGreaterThan, foLessThan, foGreaterOrEqual, foLessOrEqual,
    foLike,
    foIn,
    foAND, foOR,
    foValue,
    foNon, foNon, foNon, foNon, foNon, foNull);


function GetLexeme(const S: String; var Pos: Integer;
  var Operator: TSTFilterOperatorEh;
  PreferCommaForList: Boolean;
  AutoDetectOperator: Boolean): Variant; forward;

function GetOperatorByWord(TheWord: String): TOperator;
begin
  Result := opNon;
  TheWord := AnsiUpperCase(TheWord);
  if (TheWord = 'NOT') or
     ((SNotOperatorEh <> '') and (TheWord = AnsiUpperCase(SNotOperatorEh))) then
    Result := opNot
  else if (TheWord = 'AND') or
          ((SAndOperatorEh <> '') and (TheWord = AnsiUpperCase(SAndOperatorEh))) then
    Result := opAND
  else if (TheWord = 'OR') or
          ((SOrOperatorEh <> '') and (TheWord = AnsiUpperCase(SOrOperatorEh))) then
    Result := opOR
  else if (TheWord = 'LIKE') or
          ((SLikePredicatEh <> '') and (TheWord = AnsiUpperCase(SLikePredicatEh))) then
    Result := opLIKE
  else if (TheWord = 'IN') or
          ((SInPredicatEh <> '') and (TheWord = AnsiUpperCase(SInPredicatEh))) then
    Result := opIN
  else if (TheWord = 'NULL') or
          ((SNullConstEh <> '') and (TheWord = AnsiUpperCase(SNullConstEh))) then
    Result := opNullConst;
end;

procedure ConvertVarStrValues(var v: Variant; ot: TSTOperandTypeEh);
var
  i: Integer;

  function StrToDateTimeEh(const s: String): Variant;
  begin
    if  SameText(s, 'NOW')
      then Result := s
      else Result := StrToDateTime(s);
  end;

begin
  if ot = botNumber then
  begin
    if not VarIsNull(v) then
      if VarIsArray(v) then
        for i := VarArrayLowBound(v, 1) to VarArrayHighBound(v, 1) do
          if VarIsNull(v[i]) then
            v[i] := v[i]
          else if SameText(VarToStr(v[i]), 'Null') then
            v[i] := Null
          else
            v[i] := StrToFloat(v[i])
      else
        v := StrToFloat(v);
  end
  else if ot = botDateTime then
  begin
    if not VarIsNull(v) then
      if VarIsArray(v) then
        for i := VarArrayLowBound(v, 1) to VarArrayHighBound(v, 1) do
          if VarIsNull(v[i]) then
            v[i] := v[i]
          else if SameText(v[i], 'Null') then
            v[i] := Null
          else
            v[i] := StrToDateTimeEh(v[i])
      else
        v := StrToDateTimeEh(v);
  end
  else if ot = botBoolean then
  begin
    if not VarIsNull(v) then
    begin
      if VarIsArray(v) then
      begin
        for i := VarArrayLowBound(v, 1) to VarArrayHighBound(v, 1) do
          if VarIsNull(v[i]) then
            v[i] := v[i]
          else if SameText(v[i], 'Null') then
            v[i] := Null
          else
            v[i] := StrToBool(v[i])
      end
      else
        v := StrToBool(v);
    end;
  end;
end;

function SkipBlanks(const s: String; Pos: Integer): Integer;
var
  i: Integer;
begin
  Result := Pos;
  for i := Pos to Length(s) do
    if s[i] <> ' ' then
    begin
      Result := i;
      Break;
    end
end;

procedure SetOperatorPos(var Pos: Integer; Increment: Integer; var Op: TOperator; NewOp: TOperator);
begin
  Inc(Pos, Increment);
  Op := NewOp;
end;

function CharAtPos(const S: String; Pos: Integer): Char;
begin
  if (Length(S) < Pos) or (Pos <= 0) then
    Result := #0
  else
    Result := S[Pos];
end;

function ReadValue(const S: String; var Pos: Integer; PreferCommaForList: Boolean): Variant;

  function CheckForOperand(const S: String; Pos: Integer): Boolean;
  var
    Operator: TSTFilterOperatorEh;
  begin
    GetLexeme(S, Pos, Operator, PreferCommaForList, False);
    if Operator in [foEqual..foOR] then
      Result := True
    else
      Result := False;
  end;

var
  i: Integer;
  InSpecSign: Boolean;
  sVal: String;
begin
  Result := Unassigned;
  if Pos > Length(S) then
    Exit;
  if S[Pos] = '''' then
  begin
    InSpecSign := False;
    for i := Pos + 1 to Length(S) do
    begin
      if (S[i] = '''') and not InSpecSign then
      begin
        Result := VarToStr(Result) + Copy(S, Pos + 1, i - Pos - 1);
        if CharAtPos(S,i+1) = '''' then
        begin
          Pos := i;
          InSpecSign := True
        end else
        begin
          Pos := i + 1;
          Exit;
        end;
      end else
        InSpecSign := False;
    end;

    raise Exception.Create(EhLibLanguageConsts.QuoteIsAbsentEh + S);
  end
  else
  begin
    for i := Pos to Length(S) do
    begin
      if ( CharInSetEh(S[i], [' ']) and CheckForOperand(S, SkipBlanks(S, i))) or
        ( CharInSetEh(S[i], [')', '(']) ) or
        (PreferCommaForList and (S[i] = ',')) then
      begin
        sVal := Copy(S, Pos, i - Pos);
        if UpperCase(sVal) = 'NULL'
          then Result := Null
          else Result := sVal;
        Pos := i;
        Exit;
      end;
    end;
    Result := Copy(S, Pos, MAXINT);
    Pos := Length(S) + 1;
  end;
end;

function ReadValues(const S: String; var Pos: Integer; PreferCommaForList: Boolean): Variant;
var
  i: Integer;
  vArr: Variant;
begin
  i := 0;
  vArr := VarArrayCreate([0, 0], varVariant);
  while True do
  begin
    vArr[i] := ReadValue(S, Pos, PreferCommaForList);
    if VarIsClear(vArr[i]) then
      Break;
    if PreferCommaForList and (CharAtPos(S, Pos) = ',') then
      Inc(Pos)
    else
      Break;
    Inc(i);
    VarArrayRedimEh(vArr, i);
  end;
  if i = 0 then
    Result := vArr[0]
  else
    Result := vArr;
end;

function GetLexeme(const S: String; var Pos: Integer; var Operator: TSTFilterOperatorEh;
  PreferCommaForList: Boolean; AutoDetectOperator: Boolean): Variant;
var
  Oper: TOperator;
  Operator1: TSTFilterOperatorEh;
  TheWord: String;

  function ReadWord(const S: String; Pos: Integer): String;
  var
    c: Char;
    NextPos: Integer;
  begin
    Result := '';
    while True do
    begin
      c := CharAtPos(S, Pos);
      if (c < #32) or CharInSetEh(c, [' ','(',')','>','<','=','!','~','&','|','.',',','''','"','+','-']) then
        Exit;
      NextPos := NextCharIndex(S,Pos);
      Result := Result + Copy(S,Pos,NextPos-Pos);
      Pos := NextPos;
    end;
  end;

begin
  if not (Operator in [foIn, foNotIn]) then
    Operator := foNon;
  Oper := opNon;
  Result := '';
  if Length(S) < Pos then
    Exit;
  if (S[Pos] = '''') or (Operator in [foIn, foNotIn]) then
  begin
    Result := ReadValues(S, Pos, PreferCommaForList);
    if VarIsArray(Result)
      then Operator := foIn
      else Operator := foValue;
  end
  else
  begin
    case S[Pos] of

      '!':
        if CharAtPos(S, Pos + 1) = '=' then
          SetOperatorPos(Pos, 2, Oper, opNotEqual)
        else
          SetOperatorPos(Pos, 1, Oper, opNot);
      '=':
        SetOperatorPos(Pos, 1, Oper, opEqual);
      '(':
        SetOperatorPos(Pos, 1, Oper, opOpenBracket);

      '>':
        if CharAtPos(S, Pos + 1) = '=' then
          SetOperatorPos(Pos, 2, Oper, opGreaterOrEqual)
        else
          SetOperatorPos(Pos, 1, Oper, opGreaterThan);
      '<':
        if CharAtPos(S, Pos + 1) = '=' then
          SetOperatorPos(Pos, 2, Oper, opLessOrEqual)
        else if CharAtPos(S, Pos + 1) = '>' then
          SetOperatorPos(Pos, 2, Oper, opNotEqual)
        else
          SetOperatorPos(Pos, 1, Oper, opLessThan);
      '~':
        SetOperatorPos(Pos, 1, Oper, opLike);
      '&':
        SetOperatorPos(Pos, 1, Oper, opAnd); 
      '|':
        SetOperatorPos(Pos, 1, Oper, opOr); 
    else
      TheWord := ReadWord(S,Pos);
      Oper := GetOperatorByWord(TheWord);
      if Oper <> opNon then
        Inc(Pos, Length(TheWord));
    end;

    if (Oper = opNon) and AutoDetectOperator then
    begin
      Result := ReadValues(S, Pos, PreferCommaForList);
      if VarIsNull(Result) then
        Operator := foNon
      else if VarIsArray(Result) then
        Operator := foIn
      else
        Operator := foValue;
      Exit;
    end;

    Pos := SkipBlanks(S, Pos);

    if Oper = opNot then
    begin
      GetLexeme(S, Pos, Operator1, PreferCommaForList, True);
      case Operator1 of
        foLike: Operator := foNotLike;
        foIn: Operator := foNotIn;
        foNull: Operator := foNotNull;
      end
    end
    else if Oper = opIn then
    begin
      if CharAtPos(S, Pos) = '(' then
        Inc(Pos)
      else
        raise Exception.Create(EhLibLanguageConsts.LeftBracketExpectedEh + S);
      Operator := foIn;
    end
    else
      Operator := OperatorAdvFilterOperatorMap[Oper];
  end;
end;

function ParseSTFilterExpression(Exp: String; var FExpression: TSTFilterExpressionEh): Boolean;

var
  PreferCommaForList: Boolean;

  procedure ResetPreferCommaForList;
  begin
    if (FExpression.ExpressionType = botNumber) and (FormatSettings.DecimalSeparator = ',') then
      PreferCommaForList := False
    else
      PreferCommaForList := True;
  end;

var
  v: Variant;
  op, op1: TSTFilterOperatorEh;
  p: Integer;
begin
  Result := False;

  ResetPreferCommaForList;

  FExpression.Operator1 := foNon;
  FExpression.Operand1 := Null;
  FExpression.Relation := foNon;
  FExpression.Operator2 := foNon;
  FExpression.Operand2 := Null;

  Exp := Trim(Exp);
  if Exp = '' then
    Exit;
  p := SkipBlanks(Exp, 1);
  v := GetLexeme(Exp, p, op, PreferCommaForList, True);
  if op = foValue then
  begin
    if VarIsArray(v) then
      FExpression.Operator1 := foIn
    else if FExpression.ExpressionType = botString then
      FExpression.Operator1 := foLike
    else
      FExpression.Operator1 := foEqual;
    FExpression.Operand1 := v;
  end
  else if (op = foNon) and (Length(Exp) <> 0) then
    raise Exception.Create(EhLibLanguageConsts.ErrorInExpressionEh + Exp)
  else
  begin
    if op in [foIn, foNotIn] then
      PreferCommaForList := True;
    p := SkipBlanks(Exp, p);
    v := GetLexeme(Exp, p, op1, PreferCommaForList, True);
    FExpression.Operator1 := op;
    if op1 = foNull then
      if op = foEqual then
        FExpression.Operator1 := foNull
      else if op = foNotEqual then
        FExpression.Operator1 := foNotNull
      else
        raise Exception.Create(EhLibLanguageConsts.UnexpectedExpressionBeforeNullEh + Exp)
    else if op1 <> foValue then
      raise Exception.Create(EhLibLanguageConsts.UnexpectedExpressionAfterOperatorEh + Exp);
    FExpression.Operand1 := v;
    if op in [foIn, foNotIn] then
    begin
      p := SkipBlanks(Exp, p);
      if CharAtPos(Exp, p) = ')' then
        Inc(p)
      else
        raise Exception.Create(EhLibLanguageConsts.RightBracketExpectedEh + Exp);
      ResetPreferCommaForList;
    end;
  end;

  while True do
  begin
    p := SkipBlanks(Exp, p);
    v := GetLexeme(Exp, p, op, PreferCommaForList, True);
    if op = foNon then
      if p <> Length(Exp) + 1 then
        raise Exception.Create(EhLibLanguageConsts.IncorrectExpressionEh + Exp)
      else
        Break;
    if not (op in [foAND, foOR]) then
      raise Exception.Create(EhLibLanguageConsts.UnexpectedANDorOREh + Exp);
    FExpression.Relation := op;

    p := SkipBlanks(Exp, p);
    v := GetLexeme(Exp, p, op, PreferCommaForList, True);
    if op = foNon then
      if p <> Length(Exp) + 1 then
        raise Exception.Create(EhLibLanguageConsts.IncorrectExpressionEh + Exp)
      else
        Break;
    if op = foValue then
    begin
      if VarIsArray(v) then
        FExpression.Operator2 := foIn
      else if FExpression.ExpressionType = botString then
        FExpression.Operator2 := foLike
      else
        FExpression.Operator2 := foEqual;
      FExpression.Operand2 := v;
    end
    else if (op = foNon) and (Length(Exp) <> 0) then
      raise Exception.Create(EhLibLanguageConsts.ErrorInExpressionEh + Exp)
    else
    begin
      if op in [foIn, foNotIn] then
        PreferCommaForList := True;
      p := SkipBlanks(Exp, p);
      v := GetLexeme(Exp, p, op1, PreferCommaForList, True);
      FExpression.Operator2 := op;
      if op1 = foNull then
        if op = foEqual then
          FExpression.Operator2 := foNull
        else if op = foNotEqual then
          FExpression.Operator2 := foNotNull
        else
          raise Exception.Create(EhLibLanguageConsts.UnexpectedExpressionBeforeNullEh + Exp)
      else if op1 <> foValue then
        raise Exception.Create(EhLibLanguageConsts.UnexpectedExpressionAfterOperatorEh + Exp);
      FExpression.Operand2 := v;
      ResetPreferCommaForList;
    end;
    Result := True;
    Break;
  end;

  if FExpression.Operator1 in [foEqual..foNotIn] then
    ConvertVarStrValues(FExpression.Operand1, FExpression.ExpressionType)
  else
    FExpression.Operand1 := Null;

  if FExpression.Operator2 in [foEqual..foNotIn] then
    ConvertVarStrValues(FExpression.Operand2, FExpression.ExpressionType)
  else
    FExpression.Operand2 := Null;
end;

function ParseSTFilterExpressionEh(Exp: String;
  var FExpression: TSTFilterExpressionEh;
  DefaultOperator: TSTFilterDefaultOperatorEh): Boolean;
var
  PreferCommaForList: Boolean;

  procedure ResetPreferCommaForList;
  begin
    PreferCommaForList := False
  end;

  procedure MakeSimpleLike;
  begin
    FExpression.Operator1 := foLike;
    FExpression.Operand1 := Exp;
    FExpression.Relation := foNon;
    FExpression.Operator2 := foNon;
    FExpression.Operand2 := Null;
  end;

const
  OperatorForDefaultOperators: array[TSTFilterDefaultOperatorEh] of
    TSTFilterOperatorEh = (
      foNon, foEqual, foNotEqual,
      foGreaterThan, foLessThan, foGreaterOrEqual, foLessOrEqual,
      foLike, foNotLike,
      foIn, foNotIn,
      foLike, foNotLike,
      foLike, foNotLike,
      foLike, foNotLike);
var
  v: Variant;
  op, op1: TSTFilterOperatorEh;
  p: Integer;
  NoClosedComma: Boolean;
begin
  Result := False;

  ResetPreferCommaForList;

  FExpression.Operator1 := foNon;
  FExpression.Operand1 := Null;
  FExpression.Relation := foNon;
  FExpression.Operator2 := foNon;
  FExpression.Operand2 := Null;

  Exp := Trim(Exp);
  if Exp = '' then
    Exit;
  p := SkipBlanks(Exp, 1);
  v := GetLexeme(Exp, p, op, PreferCommaForList, True);
  if op = foValue then
  begin
    if DefaultOperator <> fdoAuto then
    begin
      FExpression.Operator1 := OperatorForDefaultOperators[DefaultOperator];
      if DefaultOperator in [fdoBeginsWith, fdoContains, fdoDoesntContain] then
      begin
        v := VarToStr(v);
        if CharAtPos(v, 1) <> '%' then
          v := v + '%';
      end;
      if DefaultOperator in [fdoEndsWith, fdoDoesntEndWith, fdoContains, fdoDoesntContain] then
      begin
        v := VarToStr(v);
        if CharAtPos(v, 1) <> '%' then
          v := '%' + v;
      end;
    end else if VarIsArray(v) then
      FExpression.Operator1 := foIn
    else if FExpression.ExpressionType = botString then
      FExpression.Operator1 := foLike
    else
      FExpression.Operator1 := foEqual;
    FExpression.Operand1 := v;
  end
  else if (op = foNon) and (Length(Exp) <> 0) then
    raise Exception.Create(EhLibLanguageConsts.ErrorInExpressionEh + Exp)
  else
  begin
    if op in [foIn, foNotIn] then
      PreferCommaForList := True;
    p := SkipBlanks(Exp, p);
    FExpression.Operator1 := op;
    NoClosedComma := False;
    op1 := op;
    if VarEquals(v, '') then
    begin
      v := GetLexeme(Exp, p, op1, PreferCommaForList, True);
      if op1 = foNull then
      begin
        if (op in [foIn, foNotIn]) then
          v := Null
        else if op = foEqual then
          FExpression.Operator1 := foNull
        else if op = foNotEqual then
          FExpression.Operator1 := foNotNull
        else
        begin
          MakeSimpleLike;
          Exit;
        end;
      end else if not (op1 in [foValue, foIn]) then
          raise Exception.Create(EhLibLanguageConsts.UnexpectedExpressionAfterOperatorEh + Exp);
    end else
      NoClosedComma := True;
    FExpression.Operand1 := v;
    if op in [foIn, foNotIn] then
    begin
      p := SkipBlanks(Exp, p);
      if CharAtPos(Exp, p) = ')' then
        Inc(p)
      else if not NoClosedComma then
      begin
        MakeSimpleLike;
        Exit;
      end;
      ResetPreferCommaForList;
    end;
  end;

  while True do
  begin
    p := SkipBlanks(Exp, p);
    op := foNon;
    v := GetLexeme(Exp, p, op, PreferCommaForList, True);
    if op = foNon then
      if p <> Length(Exp) + 1 then
      begin
        MakeSimpleLike;
        Exit;
      end else
        Break;
    if not (op in [foAND, foOR]) then
      raise Exception.Create(EhLibLanguageConsts.UnexpectedANDorOREh + Exp);
    FExpression.Relation := op;

    p := SkipBlanks(Exp, p);
    v := GetLexeme(Exp, p, op, PreferCommaForList, True);
    if op = foNon then
      if p <> Length(Exp) + 1 then
        raise Exception.Create(EhLibLanguageConsts.IncorrectExpressionEh + Exp)
      else
        Break;
    if op = foValue then
    begin
      if VarIsArray(v) then
        FExpression.Operator2 := foIn
      else if FExpression.ExpressionType = botString then
        FExpression.Operator2 := foLike
      else
        FExpression.Operator2 := foEqual;
      FExpression.Operand2 := v;
    end
    else if (op = foNon) and (Length(Exp) <> 0) then
      raise Exception.Create(EhLibLanguageConsts.ErrorInExpressionEh + Exp)
    else
    begin
      if op in [foIn, foNotIn] then
        PreferCommaForList := True;
      p := SkipBlanks(Exp, p);
      v := GetLexeme(Exp, p, op1, PreferCommaForList, True);
      FExpression.Operator2 := op;
      if op1 = foNull then
        if op = foEqual then
          FExpression.Operator2 := foNull
        else if op = foNotEqual then
          FExpression.Operator2 := foNotNull
        else
          raise Exception.Create(EhLibLanguageConsts.UnexpectedExpressionBeforeNullEh + Exp)
      else if (op1 <> foValue) and (op1 <> foIn) then
        raise Exception.Create(EhLibLanguageConsts.UnexpectedExpressionAfterOperatorEh + Exp);
      FExpression.Operand2 := v;
      ResetPreferCommaForList;
    end;
    Result := True;
    Break;
  end;

  if (FExpression.Relation in [foAND, foOR]) and (FExpression.Operator2 = foNon) then
    raise Exception.Create(EhLibLanguageConsts.ErrorInExpressionEh + Exp);

  if FExpression.Operator1 in [foEqual..foNotIn] then
    ConvertVarStrValues(FExpression.Operand1, FExpression.ExpressionType)
  else
    FExpression.Operand1 := Null;

  if FExpression.Operator2 in [foEqual..foNotIn] then
    ConvertVarStrValues(FExpression.Operand2, FExpression.ExpressionType)
  else
    FExpression.Operand2 := Null;
end;

function GetExpressionAsFilterString(AGrid: TCustomDBGridEh;
  OneExpressionProc: TOneExpressionFilterStringProcEh;
  DateValueToSQLStringProc: TDateValueToSQLStringProcEh;
  UseFieldOrigin: Boolean = False;
  SupportsLocalLike: Boolean = False;
  NullComparisonSyntax: TNullComparisonSyntaxEh = ncsAsIsNullEh;
  InOperIsSupported: Boolean = False): String;

  function GetExpressionAsString(Column: TColumnEh): String;
  var
    FieldName: String;
    ADataField: TField;
    stf: TSTColumnFilterEh;
  begin
    if Column.LookupParams.LookupActive
      then ADataField := Column.LookupParams.KeyFields[0]
      else ADataField := Column.Field;

    if ADataField = nil then
      FieldName := ''
    else if UseFieldOrigin and (ADataField.Origin <> '') and (Column.STFilter.DataField = '') then
      FieldName := Column.Field.Origin
    else
      FieldName := Column.STFilter.GetFilterFieldName;
    Result := '';
    stf := Column.STFilter;
    if (stf.Expression.ExpressionType = botNon) or (ADataField = nil) or
       (stf.Expression.Operator1 = foNon) then
      Exit;
    begin
      Result := OneExpressionProc(stf.Expression.Operator1, stf.Expression.Operand1, FieldName,
        AGrid.DataSource.DataSet, DateValueToSQLStringProc, SupportsLocalLike,
        NullComparisonSyntax, InOperIsSupported);
      if stf.Expression.Relation <> foNon then
      begin
        Result := Result + ' ' + STFilterOperatorsSQLStrMapEh[stf.Expression.Relation];
        Result := Result + OneExpressionProc(stf.Expression.Operator2, stf.Expression.Operand2,
          FieldName, AGrid.DataSource.DataSet, DateValueToSQLStringProc, SupportsLocalLike, NullComparisonSyntax);
      end
    end;
    if stf.Expression.Relation = foOR then
      Result := '(' + Result + ')';
  end;
var
  i: Integer;
  s: String;
begin
  Result := '';
  if (AGrid.DataSource <> nil) and (AGrid.DataSource.DataSet <> nil)
  then
  begin
    for i := 0 to AGrid.Columns.Count - 1 do
    begin
      s := GetExpressionAsString(TColumnEh(AGrid.Columns[i]));
      if s <> '' then
        Result := Result + s + ' AND ';
    end;
    Delete(Result, Length(Result) - 3, 4);
  end;
end;

function GetOneExpressionAsLocalFilterString(O: TSTFilterOperatorEh; v: Variant;
  const FieldName: String; DataSet: TDataSet;
  DateValueToSQLStringProc: TDateValueToSQLStringProcEh;
  SupportsLike: Boolean;
  NullComparisonSyntax: TNullComparisonSyntaxEh;
  InOperIsSupported: Boolean = False): String;

  function VarValueAsFilterStr(v: Variant): String;
  begin
    if VarType(v) = varDouble then
      Result := FloatToStr(v)
    else if VarType(v) = varDate then
      if @DateValueToSQLStringProc <> nil then
        Result := DateValueToSQLStringProc(Dataset, v)
      else
        Result := '''' + DateTimeToStr(v) + ''''
    else
    begin
      Result := VarToStr(v);
      Result := StringReplace(Result, '''', '''''',[rfReplaceAll]);
      Result := '''' + Result + '''';
    end;
  end;

  function ComposeExpressionForFieldList(FieldNames: String;
    O: TSTFilterOperatorEh; var VarValues: Variant): String;
  var
    Pos, i: Integer;
    FieldName: String;
  begin
    Result := '( ';
    Pos := 1;
    i := 0;
    while Pos <= Length(FieldNames) do
    begin
      if i > 0 then
        Result := Result + ' AND ';
      FieldName := ExtractFieldName(FieldNames, Pos);
      Result := Result +  ' ' + LFBr + FieldName + RFBr + ' ' + STFilterOperatorsSQLStrMapEh[O];
      if not (O in [foNull, foNotNull, foEqualToNull, foNotEqualToNull]) then
        Result := Result + ' ' + VarValueAsFilterStr(VarValues[i]);
      Inc(i);
    end;
    Result := Result + ' )';
  end;

var
  i: Integer;
  vin: Variant;
  AddIsNull: Boolean;
begin
  Result := '';
  if (O = foNull) and (NullComparisonSyntax = ncsAsEqualToNullEh) then
    O := foEqualToNull;
  if (O = foNotNull) and (NullComparisonSyntax = ncsAsEqualToNullEh) then
    O := foNotEqualToNull;

  if O in [foIn, foNotIn] then
  begin
    AddIsNull := False;
    Result := Result + ' (';
    if InOperIsSupported and VarIsArray(v) then
    begin
      if O = foIn then
        Result := Result +  LFBr + FieldName + RFBr + ' In('
      else
        Result := Result +  LFBr + FieldName + RFBr + ' Not In(';
    end else
    begin
      if O = foNotIn then
        Result := ' NOT' + Result;
    end;
    if VarIsArray(v) then
    begin
      for i := VarArrayLowBound(v, 1) to VarArrayHighBound(v, 1) do
      begin
        if Pos(';', FieldName) <> 0 then
        begin
          vin := v[i];
          Result := Result + ComposeExpressionForFieldList(FieldName, foEqual, vin)  + ' OR '
        end else if InOperIsSupported then
        begin
          if VarIsNull(v[i]) then
            AddIsNull := True
          else
            Result := Result + VarValueAsFilterStr(v[i]) + ' ,  ';
        end else if VarIsNull(v[i]) then
          Result := Result + LFBr + FieldName + RFBr +' Is Null OR '
        else
          Result := Result + LFBr + FieldName + RFBr +' = ' + VarValueAsFilterStr(v[i]) + ' OR ';
      end;
    end else
    begin
      if Pos(';', FieldName) <> 0 then
        Result := ComposeExpressionForFieldList(FieldName, foEqual, v)  + ' OR '
      else
        Result := Result + LFBr + FieldName + RFBr +' = ' + VarValueAsFilterStr(v) + ' OR ';
    end;
    Delete(Result, Length(Result) - 3, 4);
    if InOperIsSupported and VarIsArray(v) then
      Result := Result + ') ';
    if AddIsNull then
      Result := Result + ' OR ' + LFBr + FieldName + RFBr +' Is Null ';

    Result := Result + ')';
  end
  else if O in [foLike, foNotLike] then
  begin
    Result := Result +  ' ' + LFBr + FieldName;
    if SupportsLike then
      if O = foLike
        then Result := Result + RFBr + ' Like '
        else Result := ' Not (' + Result + RFBr + ' Like '
    else
      if O = foLike
        then Result := Result + RFBr + ' = '
        else Result := Result + RFBr + ' <> ';
    Result := Result + VarValueAsFilterStr(v);
    if SupportsLike and (O = foNotLike) then
      Result := Result + ')';
  end else
  begin
    if Pos(';', FieldName) <> 0 then
      Result := ComposeExpressionForFieldList(FieldName, O, v)
    else
    begin
      Result := Result +  ' ' + LFBr + FieldName + RFBr + ' ' + STFilterOperatorsSQLStrMapEh[O];
      if not (O in [foNull, foNotNull, foEqualToNull, foNotEqualToNull]) then
        Result := Result + ' ' + VarValueAsFilterStr(v);
    end;
  end;
end;

function GetOneExpressionAsSQLWhereString(O: TSTFilterOperatorEh; v: Variant;
  const FieldName: String; DataSet: TDataSet;
  DateValueToSQLStringProc: TDateValueToSQLStringProcEh;
  SupportsLike: Boolean;
  NullComparisonSyntax: TNullComparisonSyntaxEh;
  InOperIsSupported: Boolean = False): String;

  function VarValueAsFilterStr(v: Variant): String;
  var
{$IFDEF CIL}
    OldDecimalSeparator: String;
{$ELSE}
    OldDecimalSeparator: Char;
{$ENDIF}
   VType: TVarType;
  begin
    VType := VarType(v);
    if VarIsNumericType(v) then
    begin
      OldDecimalSeparator := FormatSettings.DecimalSeparator;
      FormatSettings.DecimalSeparator := '.';
      try
        Result := FloatToStr(v);
      finally
        FormatSettings.DecimalSeparator := OldDecimalSeparator;
      end;
    end
    else if VType = varDate then
      if @DateValueToSQLStringProc <> nil then
        Result := DateValueToSQLStringProc(DataSet, v)
      else
        Result := '''' + VarToStr(v) + ''''
    else
    begin
      Result := VarToStr(v);
      Result := StringReplace(Result, '''', '''''',[rfReplaceAll]);
      Result := '''' + Result + '''';
    end;
  end;

var
  i: Integer;
  theNOT: String;
begin
  Result := '';
  if (O = foNull) and (NullComparisonSyntax = ncsAsEqualToNullEh) then
    O := foEqualToNull;
  if (O = foNotNull) and (NullComparisonSyntax = ncsAsEqualToNullEh) then
    O := foNotEqualToNull;

  if O in [foIn, foNotIn] then
  begin
    if O = foNotIn then
      theNOT := ' NOT'
    else
      theNOT := '';
    Result := Result + FieldName + theNOT + ' IN (';
    if VarIsArray(v) then
      for i := VarArrayLowBound(v, 1) to VarArrayHighBound(v, 1) do
        Result := Result + VarValueAsFilterStr(v[i]) + ','
    else
      Result := Result + VarValueAsFilterStr(v) + ',';
    Delete(Result, Length(Result), 1);
    Result := Result + ')';
  end else
  begin
    Result := Result + ' ' + FieldName + ' ' + STFilterOperatorsSQLStrMapEh[O];
    if not (O in [foNull, foNotNull, foEqualToNull, foNotEqualToNull]) then
      Result := Result + ' ' + VarValueAsFilterStr(v);
  end;
end;

function DateValueToDataBaseSQLString(DataBaseName: String; v: Variant): String;
var
{$IFDEF CIL}
  OldDateSeparator: String;
{$ELSE}
  OldDateSeparator: Char;
{$ENDIF}
begin
  DataBaseName := UpperCase(DataBaseName);
  if DataBaseName = 'STANDARD' then
    Result := '''' + VarToStr(v) + ''''
  else if DataBaseName = 'ORACLE' then
    Result := 'TO_DATE(''' + FormatDateTime(FormatSettings.ShortDateFormat, v) + ''',''' + FormatSettings.ShortDateFormat + ''')'
  else if DataBaseName = 'INTRBASE' then
    Result := '''' + VarToStr(v) + ''''
  else if DataBaseName = 'INFORMIX' then
    Result := '''' + VarToStr(v) + ''''
  else if DataBaseName = 'MSACCESS' then
  begin
    OldDateSeparator := FormatSettings.DateSeparator;
    try
      FormatSettings.DateSeparator := '/';
      Result := '#' + FormatDateTime('MM/DD/YYYY', v) + '#';
    finally
      FormatSettings.DateSeparator := OldDateSeparator;
    end;
  end
  else if DataBaseName = 'MSSQL' then
    Result := QuotedStr(FormatDateTime('yyyymmdd hh:nn:ss', v))
  else if DataBaseName = 'SYBASE' then
    Result := '''' + VarToStr(v) + ''''
  else if DataBaseName = 'DB2' then
    Result := '''' + VarToStr(v) + ''''
  else
    Result := '''' + VarToStr(v) + '''';
end;

procedure ApplyFilterSQLBasedDataSet(Grid: TCustomDBGridEh; DataSet: TDataSet;
  DateValueToSQLString: TDateValueToSQLStringProcEh; IsReopen: Boolean;
  const SQLPropName: String);
var
  i, OrderLine: Integer;
  s: String;
  SQL: TStrings;
  SQLPropValue: WideString;
begin
  SQLPropValue := '';
  if not IsDataSetHaveSQLLikeProp(DataSet, SQLPropName, SQLPropValue) then
    raise Exception.Create(DataSet.ClassName + ' is not SQL based dataset');

  SQL := TStringList.Create;
  try
    SQL.Text := String(SQLPropValue);

    OrderLine := -1;
    for i := 0 to SQL.Count - 1 do
      if UpperCase(Copy(SQL[i], 1, Length(SQLFilterMarker))) = UpperCase(SQLFilterMarker) then
      begin
        OrderLine := i;
        Break;
      end;
    s := GetExpressionAsFilterString(Grid, GetOneExpressionAsSQLWhereString, DateValueToSQLString, True);
    if s = '' then
      s := '1=1';
    if OrderLine = -1 then
      Exit;
    DataSet.DisableControls;
    try
      if DataSet.Active then
        DataSet.Close;
      SQL.Strings[OrderLine] := SQLFilterMarker + ' (' + s + ')';
      SetDataSetSQLLikeProp(DataSet, SQLPropName, WideString(SQL.Text));
      if IsReopen then
        DataSet.Open;
    finally
      DataSet.EnableControls;
    end;

  finally
    SQL.Free;
  end;
end;

{ Sorting }

function IsSQLBasedDataSet(DataSet: TDataSet; var SQL: TStrings): Boolean;
var
  FPropInfo: PPropInfo;
begin
  Result := False;
  SQL := nil;
  FPropInfo := GetPropInfo(DataSet.ClassInfo, 'SQL');
  if FPropInfo = nil then Exit;
  if PropType_getKind(PropInfo_getPropType(FPropInfo)) = tkClass then
  try
    SQL := (TObject(GetOrdProp(DataSet, FPropInfo)) as TStrings);
  except 
  end;

  if SQL <> nil then
    Result := True;
end;

function IsDataSetHaveSQLLikeProp(DataSet: TDataSet; const SQLPropName: String; var SQLPropValue: WideString): Boolean;
var
  FPropInfo: PPropInfo;
begin
  Result := False;
  SQLPropValue := '';
  FPropInfo := GetPropInfo(DataSet.ClassInfo, SQLPropName);
  if FPropInfo = nil then Exit;
  if PropType_getKind(PropInfo_getPropType(FPropInfo)) = tkString then
    SQLPropValue := WideString(GetStrProp(DataSet, FPropInfo))
{$IFDEF EH_LIB_12}
  else if PropType_getKind(PropInfo_getPropType(FPropInfo)) = tkUString then
    SQLPropValue := GetStrProp(DataSet, FPropInfo)
{$ENDIF}

{$IFDEF NEXTGEN}
{$ELSE}
  else if PropType_getKind(PropInfo_getPropType(FPropInfo)) = tkWString then
    SQLPropValue := GetWideStrProp(DataSet, FPropInfo)
{$ENDIF}

  else if PropType_getKind(PropInfo_getPropType(FPropInfo)) = tkClass then
    try
      if TObject(GetOrdProp(DataSet, FPropInfo)) is TStrings then
        SQLPropValue := WideString((TObject(GetOrdProp(DataSet, FPropInfo)) as TStrings).Text)
{$IFDEF CIL}
{$ELSE}
  {$IFDEF NEXTGEN}
  {$ELSE}
    {$IFDEF EH_LIB_9}
      else if TObject(GetOrdProp(DataSet, FPropInfo)) is TWideStrings then
        SQLPropValue := (TObject(GetOrdProp(DataSet, FPropInfo)) as TWideStrings).Text
    {$ENDIF}
  {$ENDIF}
{$ENDIF}
      else
        Exit;
    except 
    end
  else Exit;
  Result := True;
end;

procedure ApplySortingForSQLBasedDataSet(Grid: TCustomDBGridEh; DataSet: TDataSet;
   UseFieldName: Boolean; IsReopen: Boolean; const SQLPropName: String);

  function GetDataFieldName(LookUpFieldName : String) : String;
  var
    FieldList: TFieldListEh;
    i: Integer;
  begin
    Result := DataSet.FieldByName(LookUpFieldName).KeyFields;
    if UseFieldName then
      Result := StringReplace(Result, ';', ', ', [])
    else
    begin
      FieldList := TFieldListEh.Create;
      try
        DataSet.GetFieldList(FieldList, Result);
        Result := '';
        for i := 0 to FieldList.Count-1 do
        begin
          if i > 0 then
            Result := Result + ', ';
          Result := Result + IntToStr(TField(FieldList[i]).FieldNo);
        end;
      finally
        FreeAndNil(FieldList);
      end;
    end;
  end;

var
  i, OrderLine: Integer;
  s: String;
  SQL: TStrings;
  SQLPropValue: WideString;
  SortOrder: TSortOrderEh;
  Field: TField;
  Fields: String;
begin
  SQLPropValue := '';
  if not IsDataSetHaveSQLLikeProp(DataSet, SQLPropName, SQLPropValue) then
    raise Exception.Create(DataSet.ClassName + ' is not SQL based dataset');

  SQL := TStringList.Create;
  try
    SQL.Text := String(SQLPropValue);

    s := '';
    for i := 0 to Grid.SortMarkedColumns.Count - 1 do
    begin
      Field := Grid.SortMarkedColumns[i].Field;
      if (Field <> nil) and (Field.FieldKind = fkLookup) then
        Fields := GetDataFieldName(Field.FieldName)
      else if UseFieldName then
        Fields := Grid.SortMarkedColumns[i].FieldName
      else if Field <> nil then
        Fields := IntToStr(Grid.SortMarkedColumns[i].Field.FieldNo);

      SortOrder := Grid.Center.GetSortOrderForSortMarker(Grid,
        Grid.SortMarkedColumns[i], Grid.SortMarkedColumns[i].Title.SortMarker);
      if SortOrder = soDescEh
        then s := s + StringReplace(Fields, ',', ' DESC,', []) + ' DESC, '
        else s := s + Fields + ', ';
    end;

    if s <> '' then
      s := 'ORDER BY ' + Copy(s, 1, Length(s) - 2);

    OrderLine := -1;
    for i := 0 to SQL.Count - 1 do
      if UpperCase(Copy(SQL[i], 1, Length('ORDER BY'))) = 'ORDER BY' then
      begin
        OrderLine := i;
        Break;
      end;

    if OrderLine = -1 then
    begin
      if (SQL.Count = 0) or (SQL[SQL.Count-1] <> '') then
        SQL.Add('');
      OrderLine := SQL.Count-1;
    end;

    SQL.Strings[OrderLine] := s;

    DataSet.DisableControls;
    try
      if DataSet.Active then
        DataSet.Close;
      SetDataSetSQLLikeProp(DataSet, SQLPropName, WideString(SQL.Text));
      if IsReopen then
        DataSet.Open;
    finally
      DataSet.EnableControls;
    end;

  finally
    SQL.Free;
  end;
end;

function LocateDatasetTextEh(AGrid: TCustomDBGridEh;
  const FieldName, Text: String; AOptions: TLocateTextOptionsEh;
  Direction: TLocateTextDirectionEh; Matching: TLocateTextMatchingEh;
  TreeFindRange: TLocateTextTreeFindRangeEh;
  CheckValueEvent: TCheckColumnValueAcceptEventEh): Boolean;
var
  DatasetFeatures: TDatasetFeaturesEh;
begin
  if (AGrid.DataSource <> nil) and (AGrid.DataSource.DataSet <> nil) then
  begin
    DatasetFeatures := GetDatasetFeaturesForDataSet(AGrid.DataSource.DataSet);
    if DatasetFeatures <> nil then
      Result := DatasetFeatures.LocateText(AGrid, FieldName, Text, AOptions, Direction, Matching, TreeFindRange)
    else
      Result := DefaultLocateDatasetTextEh(AGrid, FieldName, Text, AOptions, Direction, Matching);
  end else
    Result := DefaultLocateDatasetTextEh(AGrid, FieldName, Text, AOptions, Direction, Matching);
end;

function DefaultLocateDatasetTextEh(AGrid: TCustomDBGridEh;
  FieldName, Text: String; AOptions: TLocateTextOptionsEh;
  Direction: TLocateTextDirectionEh; Matching: TLocateTextMatchingEh;
  TimeOut: LongWord = 0; CheckValueProc: TCheckColumnValueAcceptEventEh = nil): Boolean;
var
  FCurInListColIndex: Integer;
  FCurRow: Integer;
  FCheckEof: Boolean;
  FCheckBof: Boolean;
  FFindFromStart: Boolean;
  FFindColList: TColumnsEhList;
  ticks: Int64;
  RecChanged: Boolean;

  function CheckEofBof: Boolean;
  begin
    if (ltoInsideSelectionEh in AOptions) and
        (AGrid.Selection.SelectionType in [gstRecordBookmarks, gstRectangle]) then
      if AGrid.Selection.SelectionType = gstRecordBookmarks then
      begin
        if (Direction = ltdUpEh)
          then Result := FCheckBof
          else Result := FCheckEof;
      end else
      begin
        if (Direction = ltdUpEh)
          then Result := FCheckBof
          else Result := FCheckEof;
      end
    else
      if (Direction = ltdUpEh)
        then Result := AGrid.DataSource.DataSet.Bof
        else Result := AGrid.DataSource.DataSet.Eof;
  end;

  function CheckNextCol: Boolean;
  begin
    Result := FCurInListColIndex < FFindColList.Count-1;
    if Result then
      Inc(FCurInListColIndex);
  end;

  function CheckPrevCol: Boolean;
  begin
    Result := FCurInListColIndex > 0;
    if Result then
      Dec(FCurInListColIndex);
  end;

  procedure ResetCol(ToFirstCol: Boolean);
  begin
    if ToFirstCol then
      if ltoInsideSelectionEh in AOptions then
        case AGrid.Selection.SelectionType of
          gstRecordBookmarks: FCurInListColIndex := 0;
          gstRectangle: FCurInListColIndex := 0;
          gstColumns: FCurInListColIndex := 0; 
          gstAll: FCurInListColIndex := 0;
          gstNon: FCurInListColIndex := 0;
        end
      else
        FCurInListColIndex := 0
    else
      if ltoInsideSelectionEh in AOptions then
        case AGrid.Selection.SelectionType of
          gstRecordBookmarks: FCurInListColIndex := FFindColList.Count-1;
          gstRectangle: FCurInListColIndex := FFindColList.Count-1;
          gstColumns: FCurInListColIndex := FFindColList.Count-1;
          gstAll: FCurInListColIndex := FFindColList.Count-1;
          gstNon: FCurInListColIndex := FFindColList.Count-1;
        end
      else
        FCurInListColIndex := FFindColList.Count-1
  end;

  procedure NextRec;
  begin
    if (ltoInsideSelectionEh in AOptions) and
      (AGrid.Selection.SelectionType in [gstRecordBookmarks, gstRectangle]) then
      if AGrid.Selection.SelectionType = gstRecordBookmarks then
      begin
        if FCurRow < AGrid.Selection.Rows.Count-1 then
        begin
          Inc(FCurRow);
          AGrid.DataSource.DataSet.Bookmark := AGrid.Selection.Rows[FCurRow];
          FCheckEof := False;
        end else
          FCheckEof := True
      end else
      begin
        if DataSetCompareBookmarks(AGrid.DataSource.DataSet,
            AGrid.DataSource.DataSet.Bookmark, AGrid.Selection.Rect.BottomRow) <> 0 then
        begin
          AGrid.DataSource.DataSet.Next;
          FCheckEof := False;
          if AGrid.DataSource.DataSet.Eof then
            FCheckEof := True;
        end else
          FCheckEof := True;
      end
    else
      AGrid.DataSource.DataSet.Next;
    RecChanged := True;
  end;

  procedure PriorRec;
  begin
    if (ltoInsideSelectionEh in AOptions) and
      (AGrid.Selection.SelectionType in [gstRecordBookmarks, gstRectangle]) then
      if AGrid.Selection.SelectionType = gstRecordBookmarks then
      begin
        if FCurRow > 0 then
        begin
          Dec(FCurRow);
          AGrid.DataSource.DataSet.Bookmark := AGrid.Selection.Rows[FCurRow];
          FCheckBof := False;
        end else
          FCheckBof := True;
      end else
      begin
        if DataSetCompareBookmarks(AGrid.DataSource.DataSet,
            AGrid.DataSource.DataSet.Bookmark, AGrid.Selection.Rect.TopRow) <> 0 then
        begin
          AGrid.DataSource.DataSet.Prior;
          FCheckBof := False;
        end else
          FCheckBof := True;
      end
    else
      AGrid.DataSource.DataSet.Prior;
  end;

  procedure ToNextRec;
  begin
    if ltoAllFieldsEh in AOptions then
      if (Direction = ltdUpEh) then
      begin
        if CheckPrevCol then
          
        else
        begin
          PriorRec;
          ResetCol(False);
        end;
      end else
      begin
        if CheckNextCol then
          
        else
        begin
          NextRec;
          ResetCol(True);
        end;
      end
    else if (Direction = ltdUpEh) then
      PriorRec
    else
      NextRec;
  end;

  procedure ResetRec(ToFirstRec: Boolean);
  begin
    if ToFirstRec then
      if (ltoInsideSelectionEh in AOptions) and
        (AGrid.Selection.SelectionType in [gstRecordBookmarks, gstRectangle]) then
        case AGrid.Selection.SelectionType of
          gstRecordBookmarks: AGrid.DataSource.DataSet.Bookmark := AGrid.Selection.Rows[0];
          gstRectangle: AGrid.DataSource.DataSet.Bookmark := AGrid.Selection.Rect.TopRow;
        end
      else
        AGrid.DataSource.DataSet.First
    else
      if (ltoInsideSelectionEh in AOptions) and
        (AGrid.Selection.SelectionType in [gstRecordBookmarks, gstRectangle]) then
        case AGrid.Selection.SelectionType of
          gstRecordBookmarks: AGrid.DataSource.DataSet.Bookmark := AGrid.Selection.Rows[AGrid.Selection.Rows.Count-1];
          gstRectangle: AGrid.DataSource.DataSet.Bookmark := AGrid.Selection.Rect.BottomRow;
        end
      else
        AGrid.DataSource.DataSet.Last;
    FCurInListColIndex := 0;
  end;

  function ColText(Col: TColumnEh): String;
  begin
    if ltoMatchFormatEh in AOptions then
      Result := Col.DisplayText
    else
      Result := Col.EditText;
  end;

  function AnsiContainsText(const AText, ASubText: string): Boolean;
  begin
    Result := AnsiPos(AnsiUppercase(ASubText), AnsiUppercase(AText)) > 0;
  end;

  function AnsiContainsStr(const AText, ASubText: string): Boolean;
  begin
    Result := AnsiPos(ASubText, AText) > 0;
  end;

  function IsEscapePressed: Boolean;
  var
    Msg: TMsg;
  begin
    Result := False;
    if PeekMessage(Msg, AGrid.Handle, WM_KEYDOWN, WM_KEYDOWN, PM_NOREMOVE) then
    begin
      if Msg.wParam = VK_ESCAPE then
      begin
        PeekMessage(Msg, AGrid.Handle, WM_KEYDOWN, WM_KEYDOWN, PM_REMOVE);
        Result := True;
      end;
    end;
  end;

  function IsAnyKeyPress: Boolean;
  var
    Msg: TMsg;
  begin
    Result := False;
    if PeekMessage(Msg, GetFocus{AGrid.Handle}, WM_KEYDOWN, WM_KEYDOWN, PM_NOREMOVE) then
      Result := True;
  end;

  procedure ResetAll;
  begin
    if Direction in [ltdAllEh, ltdDownEh] then
    begin
      ResetRec(True);
      ResetCol(True);
    end else
    begin
      ResetRec(False);
      ResetCol(False);
    end;
    FFindFromStart := True;
    FCheckEof := False;
    FCheckBof := False;
  end;

  procedure SetFoundIndex(Index: Integer);
  begin
    if AGrid.SearchPanel.Active
      then AGrid.SearchPanel.FoundColumnIndex := Index
      else AGrid.SelectedIndex := Index;
  end;

  function GetFoundIndex: Integer;
  begin
    if AGrid.SearchPanel.Active
      then Result := AGrid.SearchPanel.FoundColumnIndex
      else Result := AGrid.SelectedIndex;
    if Result < 0 then
      Result := 0;
  end;

  procedure FillFindColList;
  var
    i: Integer;
  begin
    if FieldName <> '' then
      FFindColList.Add(AGrid.FieldColumns[FieldName])
    else if (ltoInsideSelectionEh in AOptions) and
      (AGrid.Selection.SelectionType in [gstRectangle, gstColumns]) then
    begin
      if AGrid.Selection.SelectionType = gstColumns then
      begin
        for i := 0 to AGrid.Selection.Columns.Count-1 do
          if AGrid.Center.CanColumnValueReadAsText(AGrid, AGrid.Selection.Columns[i]) then
            FFindColList.Add(AGrid.Selection.Columns[i])
      end else
      begin
        for i := AGrid.Selection.Rect.LeftCol to AGrid.Selection.Rect.RightCol do
          if AGrid.Columns[i].Visible and
            AGrid.Center.CanColumnValueReadAsText(AGrid, AGrid.Columns[i]) then
            FFindColList.Add(AGrid.Columns[i])
      end;
    end else if ltoAllFieldsEh in AOptions then
    begin
      for i := 0 to AGrid.VisibleColumns.Count-1 do
        if AGrid.Center.CanColumnValueReadAsText(AGrid, AGrid.VisibleColumns[i]) then
          FFindColList.Add(AGrid.VisibleColumns[i])
    end else
      FFindColList.Add(AGrid.Columns[AGrid.SelectedIndex])
  end;

var
  DataText: String;
  PC: PChar;

begin
  Result := False;
  FCheckEof := False;
  FCheckBof := False;
  FFindFromStart := False;
  ticks := GetTickCountEh;
  RecChanged := False;

  FFindColList := TColumnsEhList.Create;
  FillFindColList;
  try

  if Assigned(AGrid) and
     Assigned(AGrid.DataSource) and
     Assigned(AGrid.DataSource.DataSet) and
     AGrid.DataSource.DataSet.Active and
     not AGrid.DataSource.DataSet.IsEmpty
  then
  begin
    FCurInListColIndex := FFindColList.IndexOf(AGrid.Columns[GetFoundIndex]);
    if FCurInListColIndex < 0 then
      FCurInListColIndex := 0;

    if  (ltoInsideSelectionEh in AOptions) and
        (AGrid.Selection.SelectionType = gstRecordBookmarks) then
    begin
      FCurRow := AGrid.Selection.Rows.IndexOf(AGrid.DataSource.DataSet.Bookmark);
      if FCurRow < 0 then
      begin
        FCurRow := 0;
        AGrid.DataSource.DataSet.Bookmark := AGrid.Selection.Rows[0];
      end;
    end;

    if not AGrid.SearchPanel.Active and (dgRowSelect in AGrid.Options) and (FieldName = '') then
    begin
      FCurInListColIndex := 0;
    end;

    if (AGrid.VisibleColumns.Count = 0) then Exit;

    AGrid.DataSource.DataSet.DisableControls;
    try
      AGrid.SaveBookmark;
      if (Direction = ltdAllEh) then
        ResetRec(True)
      else
        ToNextRec;

      while True do
      begin
        if CheckEofBof then
          if FFindFromStart
            then Break
            else ResetAll;

        if @CheckValueProc <> nil then
        begin
          Result := False;
          CheckValueProc(FFindColList[FCurInListColIndex], Result, Text);
          if Result then
          begin
            SetFoundIndex(FFindColList[FCurInListColIndex].Index);
            Break;
          end;
        end else
        begin

          DataText := ColText(FFindColList[FCurInListColIndex]);

          if (ltoWholeWordsEh in AOptions) and
             (Matching = ltmAnyPartEh) then
          begin
            if ltoCaseInsensitiveEh in AOptions then
            begin
              DataText := AnsiUpperCase(Text);
              Text := AnsiUpperCase(Text);
            end;
            PC := SearchBuf(PChar(DataText), Length(DataText), 0, 0, Text, [soDown, soWholeWord]);
            if PC <> nil then
            begin
              Result := True;
              SetFoundIndex(FFindColList[FCurInListColIndex].Index);
              Break;
            end;
          end else
          if not (ltoCaseInsensitiveEh in AOptions) then
          begin
            if ( (Matching = ltmAnyPartEh) and (AnsiContainsStr(DataText, Text) ))
              or ((Matching = ltmWholeEh) and (DataText = Text))
              or ((Matching = ltmFromBegingEh) and
                   (Copy(DataText, 1, Length(Text)) = Text) )
            then
            begin
              Result := True;
              SetFoundIndex(FFindColList[FCurInListColIndex].Index);
              Break;
            end
          end else 
          if ( (Matching = ltmAnyPartEh) and (AnsiContainsText(DataText, Text) ))
           or ((Matching = ltmWholeEh) and (AnsiUpperCase(DataText) = AnsiUpperCase(Text)))
           or ((Matching = ltmFromBegingEh) and
            (AnsiUpperCase(Copy(DataText, 1, Length(Text))) = AnsiUpperCase(Text)) ) then
          begin
            Result := True;
            SetFoundIndex(FFindColList[FCurInListColIndex].Index);
            Break;
          end;

        end;

        if RecChanged then
        begin
          if (ltoStopOnEscapeEh in AOptions) and IsEscapePressed then
            Break;

          if (ltoStopKeyMessageEh in AOptions) and IsAnyKeyPress then
            Break;

          if (TimeOut > 0) and ((GetTickCountEh - ticks) > TimeOut) then
            Break;

          RecChanged := False;
        end;

        ToNextRec;
      end;
      if not Result then
      begin
        try
          AGrid.RestoreBookmark;
        except
          on EDatabaseError do
            ;
        end;
      end;
    finally
      AGrid.DataSource.DataSet.EnableControls;
    end;
  end;

  finally
    FreeAndNil(FFindColList);
  end;
end;

{ Dataset Features }

var
  DatasetFeaturesList: TStringList;

procedure RegisterDatasetFeaturesEh(DatasetFeaturesClass: TDatasetFeaturesEhClass;
  DataSetClass: TDataSetClass);
var
  DatasetFeatures: TDatasetFeaturesEh;
  OldDatasetFeatures: TDatasetFeaturesEh;
  ClassIndex: Integer;
begin
  DatasetFeatures := DatasetFeaturesClass.Create;
  DatasetFeatures.FDataSetClass := DataSetClass;
  if DatasetFeatures.FDataSetClass = nil then
    Exit;
  ClassIndex := DatasetFeaturesList.IndexOf(DatasetFeatures.FDataSetClass.ClassName);
  if ClassIndex >= 0 then
  begin
    OldDatasetFeatures := TDatasetFeaturesEh(DatasetFeaturesList.Objects[ClassIndex]);
    DatasetFeaturesList.Objects[ClassIndex] := DatasetFeatures;
    OldDatasetFeatures.Free;
  end else
  begin
    DatasetFeaturesList.AddObject(DatasetFeatures.FDataSetClass.ClassName, DatasetFeatures);
  end;
end;

procedure UnregisterDatasetFeaturesEh(DataSetClass: TDataSetClass);
var
  idx: Integer;
begin
  idx := DatasetFeaturesList.IndexOf(DataSetClass.ClassName);
  if idx >= 0 then
  begin
    FreeObjectEh(DatasetFeaturesList.Objects[idx]);
    DatasetFeaturesList.Delete(idx);
  end;
end;

function GetDatasetFeaturesForDataSetClass(DataSetClass: TClass): TDatasetFeaturesEh;

  function GetDatasetFeaturesDeep(DataSetClass: TClass; DataSetClassName: String): Integer;
  begin
    Result := 0;
    while True do
    begin
      if UpperCase(DataSetClass.ClassName) = UpperCase(DataSetClassName) then
        Exit;
      Inc(Result);
      DataSetClass := DataSetClass.ClassParent;
      if DataSetClass = nil then
      begin
        Result := MAXINT;
        Exit;
      end;
    end;
  end;

var
  Deep, MeenDeep, i: Integer;
  ClassName: String;
begin
  Result := nil;
  MeenDeep := MAXINT;
  for i := 0 to DatasetFeaturesList.Count - 1 do
  begin
    if DataSetClass.InheritsFrom(TDatasetFeaturesEh(DatasetFeaturesList.Objects[i]).FDataSetClass) then
    begin
      ClassName := TDatasetFeaturesEh(DatasetFeaturesList.Objects[i]).FDataSetClass.ClassName;
      Deep := GetDatasetFeaturesDeep(DataSetClass, ClassName);
      if Deep < MeenDeep then
      begin
        MeenDeep := Deep;
        Result := TDatasetFeaturesEh(DatasetFeaturesList.Objects[i]);
      end;
    end;
  end;
end;

function GetDatasetFeaturesForDataSet(DataSet: TDataSet): TDatasetFeaturesEh;
begin
  Result := GetDatasetFeaturesForDataSetClass(DataSet.ClassType);
end;

procedure DisposeDatasetFeaturesList;
begin
  while DatasetFeaturesList.Count > 0 do
  begin
    FreeObjectEh(DatasetFeaturesList.Objects[0]);
    DatasetFeaturesList.Delete(0);
  end;
  FreeAndNil(DatasetFeaturesList);
end;

{ TDatasetFeaturesEh }

constructor TDatasetFeaturesEh.Create;
begin
  inherited Create;
end;

procedure TDatasetFeaturesEh.ApplyFilter(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean);
var
  Grid: TCustomDBGridEh;
begin
  Grid := Sender as TCustomDBGridEh;
  if (Grid <> nil) then
    ApplyGridLocalFilter(Grid, DataSet, IsReopen);
end;

procedure TDatasetFeaturesEh.ApplyGridLocalFilter(Grid: TCustomDBGridEh;
  DataSet: TDataSet; IsReopen: Boolean);
var
  FilterWay: TLocalFilterApplyingWayEh;
begin
  FilterWay := GetLocalFilterApplyingWay;
  if (FilterWay = lfawPropertyFilterEh) then
  begin
    Grid.DataSource.DataSet.Filter := GetGridFilterAsFilterString(Grid, DataSet, True);
    Grid.DataSource.DataSet.Filtered := True;
  end else
  begin
    Grid.ApplyFilterViaDataSetFilterEvent;
  end;
end;

function TDatasetFeaturesEh.GetGridFilterAsFilterString(
  Grid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): String;
var
  i: Integer;
  s: String;
begin
  Result := '';
  if (Grid.DataSource <> nil) and (Grid.DataSource.DataSet <> nil)
  then
  begin
    for i := 0 to Grid.Columns.Count - 1 do
    begin
      s := GetColumnExpressionAsFilterString(Grid.Columns[i], Grid, DataSet, IsLocalFilter);
      if s <> '' then
        Result := Result + s + ' AND ';
    end;
    Delete(Result, Length(Result) - 3, 4);
  end;
end;

function TDatasetFeaturesEh.GetColumnExpressionAsFilterString(
  Column: TColumnEh; Grid: TCustomDBGridEh; DataSet: TDataSet;
  IsLocalFilter: Boolean): String;
var
  FieldName: String;
  ADataField: TField;
  stf: TSTColumnFilterEh;
begin
  if Column.LookupParams.LookupActive
    then ADataField := Column.LookupParams.KeyFields[0]
    else ADataField := Column.Field;

  FieldName := GetColumnFilterFieldName(Column, Grid, DataSet, IsLocalFilter);

  Result := '';
  stf := Column.STFilter;
  if (stf.Expression.ExpressionType = botNon) or
     (ADataField = nil) or
     (stf.Expression.Operator1 = foNon) then
    Exit;
  begin
    Result := GetBinaryExpressionAsFilterString(FieldName,
      stf.Expression.Operator1, stf.Expression.Operand1, Column, Grid, DataSet, IsLocalFilter);
    if stf.Expression.Relation <> foNon then
    begin
      Result := Result + ' ' + STFilterOperatorsSQLStrMapEh[stf.Expression.Relation];
      Result := Result + GetBinaryExpressionAsFilterString(FieldName,
        stf.Expression.Operator2, stf.Expression.Operand2, Column, Grid, DataSet, IsLocalFilter);
    end
  end;
  if stf.Expression.Relation = foOR then
    Result := '(' + Result + ')';
end;

function TDatasetFeaturesEh.GetBinaryExpressionAsFilterString(
  FieldName: String; AnOperator: TSTFilterOperatorEh; AnOperand: Variant;
  Column: TColumnEh; Grid: TCustomDBGridEh; DataSet: TDataSet;
  IsLocalFilter: Boolean): String;

  function ComposeExpressionForFieldList(FieldNames: String;
    O: TSTFilterOperatorEh; var VarValues: Variant): String;
  var
    Pos, i: Integer;
    FieldName: String;
    FilterStrValue: String;
  begin
    Result := '( ';
    Pos := 1;
    i := 0;
    while Pos <= Length(FieldNames) do
    begin
      if i > 0 then
        Result := Result + ' AND ';
      FieldName := ExtractFieldName(FieldNames, Pos);
      Result := Result +  ' ' + LFBr + FieldName + RFBr + ' ' + STFilterOperatorsSQLStrMapEh[O];
      FilterStrValue := ExpressionValueToFilterStrValue(
                          O, VarValues[i], Column, Grid, DataSet, IsLocalFilter);
      Result := Result + ' ' + FilterStrValue;
      Inc(i);
    end;
    Result := Result + ' )';
  end;

var
  i: Integer;
  vin: Variant;
  AddIsNull: Boolean;
  InOperIsSupported: Boolean;
  SupportsLike: Boolean;
  FilterStrValue: String;
  FieldNameOperator: String;
begin
  Result := '';

  InOperIsSupported := IsInOperatorSupported(Grid, DataSet, IsLocalFilter);
  SupportsLike := IsLikeOperatorSupported(Grid, DataSet, IsLocalFilter);

  FieldNameOperator := FilterFieldNameToStrValue(FieldName, Column, Grid, DataSet, IsLocalFilter);

  if AnOperator in [foIn, foNotIn] then
  begin
    AddIsNull := False;
    Result := Result + ' (';

    if InOperIsSupported and VarIsArray(AnOperand) then
    begin
      if AnOperator = foIn then
        Result := Result +  FieldNameOperator + ' In('
      else
        Result := Result +  FieldNameOperator + ' Not In(';
    end else
    begin
      if AnOperator = foNotIn then
        Result := ' NOT' + Result;
    end;

    if VarIsArray(AnOperand) then
    begin
      for i := VarArrayLowBound(AnOperand, 1) to VarArrayHighBound(AnOperand, 1) do
      begin
        FilterStrValue := ExpressionValueToFilterStrValue(AnOperator,
          AnOperand[i], Column, Grid, DataSet, IsLocalFilter);
        if Pos(';', FieldName) <> 0 then
        begin
          vin := AnOperand[i];
          Result := Result + ComposeExpressionForFieldList(FieldName, foEqual, vin)  + ' OR '
        end else if InOperIsSupported then
        begin
          if VarIsNull(AnOperand[i]) then
            AddIsNull := True
          else
            Result := Result + FilterStrValue + ' ,  ';
        end else if VarIsNull(AnOperand[i]) then
        begin
          Result := Result + FieldNameOperator + ' ' +
            GetNullComparisionFilterString(foNull, Grid, DataSet, IsLocalFilter) + ' OR ';
        end else
        begin
          Result := Result + FieldNameOperator + ' = ' + FilterStrValue + ' OR ';
        end;
      end;
    end else
    begin
      FilterStrValue := ExpressionValueToFilterStrValue(AnOperator, AnOperand,
        Column, Grid, DataSet, IsLocalFilter);
      if Pos(';', FieldName) <> 0 then
        Result := ComposeExpressionForFieldList(FieldName, foEqual, AnOperand)  + ' OR '
      else
        Result := Result + FieldNameOperator + ' = ' + FilterStrValue + ' OR ';
    end;

    Delete(Result, Length(Result) - 3, 4);
    if InOperIsSupported and VarIsArray(AnOperand) then
      Result := Result + ') ';
    if AddIsNull then
      Result := Result + ' OR ' + FieldNameOperator + ' ' +
        GetNullComparisionFilterString(foNull, Grid, DataSet, IsLocalFilter);

    Result := Result + ')';
  end
  else if AnOperator in [foLike, foNotLike] then
  begin
    if SupportsLike then
    begin
      if AnOperator = foLike
        then Result := ' ' + FieldNameOperator + ' Like '
        else Result := ' Not (' + FieldNameOperator + ' Like '
    end else
    begin
      if AnOperator = foLike
        then Result := ' ' + FieldNameOperator + ' ' +
          GetOperatorFilterStrValue(foEqual, Grid, DataSet, IsLocalFilter) + ' '
        else Result := ' ' + FieldNameOperator + ' ' +
          GetOperatorFilterStrValue(foNotEqual, Grid, DataSet, IsLocalFilter) + ' ';
    end;
    FilterStrValue := ExpressionValueToFilterStrValue(AnOperator, AnOperand,
      Column, Grid, DataSet, IsLocalFilter);
    Result := Result + FilterStrValue;
    if SupportsLike and (AnOperator = foNotLike) then
      Result := Result + ')';
  end else
  begin
    if Pos(';', FieldName) <> 0 then
      Result := ComposeExpressionForFieldList(FieldName, AnOperator, AnOperand)
    else
    begin
      Result := Result +
        ' ' + FieldNameOperator + ' ' +
        ColumnOperatorValueToFilterStrValue(AnOperator, AnOperand, Column, Grid, DataSet, IsLocalFilter);
    end;
  end;
end;

function TDatasetFeaturesEh.ColumnOperatorValueToFilterStrValue(
  AnOperator: TSTFilterOperatorEh; AnOperand: Variant;
  Column: TColumnEh; Grid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): String;
var
  SupportsLike: Boolean;
  FilterStrValue: String;
begin
  Result := '';
  SupportsLike := IsLikeOperatorSupported(Grid, DataSet, IsLocalFilter);

  if AnOperator in [foIn, foNotIn] then
    raise Exception.Create('Operator "In" should be implemented in the GetBinaryExpressionAsLocalFilterString method');

  if VarIsArray(AnOperand) then
    raise Exception.Create('Operand should not be an Array');

  if AnOperator in [foLike, foNotLike] then
  begin
    if SupportsLike then
      if AnOperator = foLike
        then Result := GetOperatorFilterStrValue(foLike, Grid, DataSet, IsLocalFilter) + ' '
        else Result := GetOperatorFilterStrValue(foNotLike, Grid, DataSet, IsLocalFilter) + ' '
    else
      if AnOperator = foLike
        then Result := GetOperatorFilterStrValue(foEqual, Grid, DataSet, IsLocalFilter) + ' '
        else Result := GetOperatorFilterStrValue(foNotEqual, Grid, DataSet, IsLocalFilter) + ' ';
    FilterStrValue := ExpressionValueToFilterStrValue(AnOperator, AnOperand,
      Column, Grid, DataSet, IsLocalFilter);
    Result := Result + FilterStrValue;
  end else
  begin
    Result := GetOperatorFilterStrValue(AnOperator, Grid, DataSet, IsLocalFilter);
    if not (AnOperator in [foNull, foNotNull, foEqualToNull, foNotEqualToNull]) then
    begin
      FilterStrValue := ExpressionValueToFilterStrValue(AnOperator, AnOperand,
        Column, Grid, DataSet, IsLocalFilter);
      Result := Result + ' ' + FilterStrValue;
    end;
  end;
end;

function TDatasetFeaturesEh.GetColumnFilterFieldName(
  Column: TColumnEh; Grid: TCustomDBGridEh; DataSet: TDataSet;
  IsLocalFilter: Boolean): String;
var
  ADataField: TField;
  UseFieldOrigin: Boolean;
begin
  if Column.LookupParams.LookupActive
    then ADataField := Column.LookupParams.KeyFields[0]
    else ADataField := Column.Field;

  UseFieldOrigin := IsFilterUseFieldOrigin(Column, Grid, DataSet, IsLocalFilter);
  if ADataField = nil then
    Result := ''
  else if UseFieldOrigin and (ADataField.Origin <> '') and (Column.STFilter.DataField = '') then
    Result := Column.Field.Origin
  else
    Result := Column.STFilter.GetFilterFieldName;
end;

function TDatasetFeaturesEh.FilterFieldNameToStrValue(
  FieldName: String; Column: TColumnEh; Grid: TCustomDBGridEh;
  DataSet: TDataSet; IsLocalFilter: Boolean): String;
begin
  if (IsLocalFilter) then
    Result := LFBr + FieldName + RFBr
  else
    Result := FieldName;
end;

function TDatasetFeaturesEh.ExpressionValueToFilterStrValue(
  AnOperator: TSTFilterOperatorEh; Value: Variant;
  Column: TColumnEh; Grid: TCustomDBGridEh; DataSet: TDataSet;
  IsLocalFilter: Boolean): String;
var
  VType: TVarType;
  DateTimeValue: TDateTime;
  FloatValue: Extended;
  BooleanValue: Boolean;
begin
  VType := VarType(Value);
  if VarIsNumericType(Value) then
  begin
    FloatValue := Value;
    Result := FloatValueToFilterStrValue(AnOperator, FloatValue, Column, Grid, DataSet, IsLocalFilter);
  end
  else if VType = varDate then
  begin
    DateTimeValue := VarToDateTime(Value);
    Result := DateTimeValueToFilterStrValue(AnOperator, DateTimeValue, Column, Grid, DataSet, IsLocalFilter);
  end
  else if VType = varBoolean then
  begin
    BooleanValue := Value;
    Result := BooleanValueToFilterStrValue(AnOperator, BooleanValue, Column, Grid, DataSet, IsLocalFilter);
  end
  else
  begin
    Result := VarValueToFilterStrValue(AnOperator, Value, Column, Grid, DataSet, IsLocalFilter);
  end;
end;

function TDatasetFeaturesEh.DateTimeValueToFilterStrValue(
  AnOperator: TSTFilterOperatorEh; Value: TDateTime; Column: TColumnEh;
  Grid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): String;
begin
  Result := DateTimeToStr(Value)
end;

function TDatasetFeaturesEh.FloatValueToFilterStrValue(
  AnOperator: TSTFilterOperatorEh; Value: Extended; Column: TColumnEh;
  Grid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): String;
begin
  Result := FloatToStr(Value)
end;

function TDatasetFeaturesEh.BooleanValueToFilterStrValue(
  AnOperator: TSTFilterOperatorEh; Value: Boolean; Column: TColumnEh;
  Grid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): String;
begin
  if (Value = True) then
    Result := 'True'
  else
    Result := 'False';
end;

function TDatasetFeaturesEh.VarValueToFilterStrValue(
  AnOperator: TSTFilterOperatorEh; Value: Variant; Column: TColumnEh;
  Grid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): String;
begin
  Result := VarToStr(Value);
  Result := StringReplace(Result, '''', '''''',[rfReplaceAll]);
  Result := '''' + Result + '''';
end;

function TDatasetFeaturesEh.GetNullComparisionFilterString(
  AnOperator: TSTFilterOperatorEh; Grid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): String;
var
  ncSnx: TNullComparisonSyntaxEh;
begin
  ncSnx := NullComparisonSyntax(Grid, DataSet, IsLocalFilter);
  if (ncSnx = ncsAsIsNullEh) then
  begin
    if AnOperator in [foNull, foEqualToNull] then
      Result := 'Is Null'
    else
      Result := 'Is Not Null';
  end else
  begin
    if AnOperator in [foNull, foEqualToNull] then
      Result := '= Null'
    else
      Result := '<> Null';
  end;
end;

function TDatasetFeaturesEh.GetOperatorFilterStrValue(
  AnOperator: TSTFilterOperatorEh; Grid: TCustomDBGridEh;
  DataSet: TDataSet; IsLocalFilter: Boolean): String;
begin
  if AnOperator in [foNull, foNotNull, foEqualToNull, foNotEqualToNull] then
    Result := GetNullComparisionFilterString(AnOperator, Grid, DataSet, IsLocalFilter)
  else
    Result := STFilterOperatorsSQLStrMapEh[AnOperator];
end;

function TDatasetFeaturesEh.IsInOperatorSupported(
  Grid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): Boolean;
begin
  Result := True;
end;

function TDatasetFeaturesEh.IsLikeOperatorSupported(
  Grid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): Boolean;
begin
  Result := True;
end;

function TDatasetFeaturesEh.IsFilterUseFieldOrigin(
  Column: TColumnEh; Grid: TCustomDBGridEh; DataSet: TDataSet;
  IsLocalFilter: Boolean): Boolean;
begin
  Result := False;
end;

procedure TDatasetFeaturesEh.ApplyGridServerFilter(Grid: TCustomDBGridEh;
  DataSet: TDataSet; IsReopen: Boolean);
begin

end;

procedure TDatasetFeaturesEh.ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean);
begin
end;

function TDatasetFeaturesEh.CreateAndAsignMTDateField(DataStruct: TMTDataStructEh; AField: TField): TMTDataFieldEh;
begin
  Result := DataStruct.BuildAndCopyDataFieldForField(AField);
end;

function TDatasetFeaturesEh.LocateText(AGrid: TCustomDBGridEh;
  const FieldName, Text: String; AOptions: TLocateTextOptionsEh;
  Direction: TLocateTextDirectionEh; Matching: TLocateTextMatchingEh;
  TreeFindRange: TLocateTextTreeFindRangeEh; TimeOut: System.LongWord = 0;
  CheckValueEvent: TCheckColumnValueAcceptEventEh = nil): Boolean;
begin
  Result := DefaultLocateDatasetTextEh(AGrid, FieldName, Text, AOptions,
    Direction, Matching, TimeOut, CheckValueEvent);
end;

function TDatasetFeaturesEh.MoveRecords(Sender: TObject; BookmarkList: TBMListEh;
  ToRecNo: Integer; CheckOnly: Boolean): Boolean;
var
  va: array of Variant;
  vs: array of Boolean;
  i, j: Integer;
  IsAppend: Boolean;
  DataSet: TDataSet;
  LocBookmarkList: TBMListEh;
begin
  Result := False;
  LocBookmarkList := nil;
  if (Sender is TDBGridEh)
    then DataSet := TDBGridEh(Sender).DataSource.DataSet
    else Exit;
  Result := DataSet.CanModify;
  if CheckOnly or not Result then Exit;
  DataSet.DisableControls;
  try
    LocBookmarkList := TBMListEh.Create;
    for I := 0 to BookmarkList.Count - 1 do
      TBMListCrackEh(LocBookmarkList).InsertItem(0, BookmarkList[i]);

    if ToRecNo >= DataSet.RecordCount
      then IsAppend := True
      else IsAppend := False;
    SetLength(va, BookmarkList.Count);
    SetLength(vs, BookmarkList.Count);
    for i := 0 to LocBookmarkList.Count-1 do
    begin
      DataSet.Bookmark := LocBookmarkList[i];
      va[i] := VarArrayCreate([0, DataSet.Fields.Count], varVariant);
      for j := 0 to DataSet.Fields.Count-1 do
        va[i][j] := DataSet.Fields[j].Value;
      if (i > 0) and (ToRecNo > DataSet.RecNo) then
        Dec(ToRecNo);
      vs[i] := TDBGridEh(Sender).SelectedRows.CurrentRowSelected;
      TDBGridEh(Sender).SelectedRows.CurrentRowSelected := False;
    end;
    for i := 0 to LocBookmarkList.Count-1 do
    begin
      DataSet.Bookmark := LocBookmarkList[i];
      DataSet.Delete;
    end;
    for i := Length(va)-1 downto 0 do
    begin
      if IsAppend then
        DataSet.Append
      else
      begin
        if i < Length(va)-1
          then DataSet.Next
          else DataSet.RecNo := ToRecNo;
        DataSet.Insert;
      end;
      for j := 0 to DataSet.Fields.Count-1 do
        if DataSet.Fields[j].CanModify then
          DataSet.Fields[j].Value := va[i][j];
      DataSet.Post;
      TDBGridEh(Sender).SelectedRows.CurrentRowSelected := vs[i];
    end;
  finally
    LocBookmarkList.Free;
    DataSet.EnableControls;
  end;
end;

procedure TDatasetFeaturesEh.ExecuteFindDialog(Sender: TObject;
  const Text, FieldName: String; Modal: Boolean);
begin
  if (Sender is TDBGridEh) then
    ExecuteDBGridEhFindDialogProc(TDBGridEh(Sender), Text, '', nil, Modal);
end;

procedure TDatasetFeaturesEh.FillSTFilterListDataValues(AGrid: TCustomDBGridEh; Column: TColumnEh; Items: TStrings);
begin
  if Assigned(AGrid.Center) then
     AGrid.Center.StandardFillSTFilterListDataValues(AGrid, Column, Items);
end;

procedure TDatasetFeaturesEh.FillSTFilterListCommandValues(
  AGrid: TCustomDBGridEh; Column: TColumnEh; Items: TStrings);
begin
  if Assigned(AGrid.Center) then
     AGrid.Center.StandardFillSTFilterListCommandValues(AGrid, Column, Items, True, True);
end;

procedure TDatasetFeaturesEh.FillFieldUniqueValues(Field: TField; Items: TStrings);
begin
  raise Exception.Create('A List of Field Values feature is not supported for ' + sLineBreak +
  ' DataSet class: ' + FDataSetClass.ClassName);
end;

procedure TDatasetFeaturesEh.ApplySimpleTextFilter(DataSet: TDataSet;
  const FieldNames: String; Operation: TLSAutoFilterTypeEh;
  const FilterText: String);
var
  swc1, swc2: String;
  FieldList: TFieldListEh;
  i: Integer;
  FilterStr: String;
begin
  swc2 := GetDataSetLikeWildcardForSeveralCharacters;
  FieldList := TFieldListEh.Create;
  try
  if (FieldNames = '') or (FieldNames = '*') then
  begin
    for i := 0 to DataSet.FieldCount-1 do
      if CanFilterField(DataSet.Fields[i]) then
        FieldList.Add(DataSet.Fields[i])
  end else
    DataSet.GetFieldList(FieldList, FieldNames);

  if Operation = lsftContainsEh
    then swc1 := swc2
    else swc1 := '';
  if DataSet <> nil then
    if FilterText <> '' then
    begin
      FilterStr := '';
      for i := 0 to FieldList.Count-1 do
      begin
        if CheckFieldForSimpleTextFilter(TField(FieldList[i])) then
        begin
          FilterStr := FilterStr + LFBr + TField(FieldList[i]).FieldName + RFBr + ' like ''' + swc1 +
            StringReplace(FilterText, '''', '''''', [rfReplaceAll])
            + swc2 + '''';
          FilterStr := FilterStr + ' OR ';
        end;
      end;
      FilterStr := Copy(FilterStr, 1, Length(FilterStr)-4);
      DataSet.Filter := FilterStr;
      DataSet.Filtered := True;
    end else
      DataSet.Filter := '';
  finally
    FreeAndNil(FieldList);
  end;
end;


/// <summary> Default MultipleChar Wildcard character for 'like' operator in
/// DataSet.Fitler property
/// </summary>
function TDatasetFeaturesEh.GetDataSetLikeWildcardForSeveralCharacters: String;
begin
  Result := '*';
end;

/// <summary> SingleChar Wildcard character for ApplyFilter mehtod
/// when GetLocalFilterApplyingWay = lfawEventFilterEh.
/// Method is used when filtering is done via an DataSet.OnFilterRecord event.
/// </summary>
function TDatasetFeaturesEh.CustomFilterSingleCharWildcard: String;
begin
  Result := '_';
end;

/// <summary> MultipleChar Wildcard character for ApplyFilter mehtod
/// when GetLocalFilterApplyingWay = lfawEventFilterEh.
/// Method is used when filtering is done via an DataSet.OnFilterRecord event.
/// </summary>
function TDatasetFeaturesEh.CustomFilterMultipleCharsWildcard: String;
begin
  Result := '%';
end;

function TDatasetFeaturesEh.CheckFieldForSimpleTextFilter(
  Field: TField): Boolean;
begin
  Result := Field.DataType in [ftString, ftMemo, ftFmtMemo,
    ftFixedChar, ftWideString, ftOraClob, ftGuid{$IFDEF EH_LIB_10}
    , ftFixedWideChar, ftWideMemo, ftOraInterval{$ENDIF}];
end;

function TDatasetFeaturesEh.CanFilterField(Field: TField): Boolean;
begin
  Result := Field.FieldKind in [fkData, fkInternalCalc];
end;

function TDatasetFeaturesEh.BuildSortingString(AGrid: TCustomDBGridEh; DataSet: TDataSet): String;
var
  s: String;
  i: Integer;
  SortOrder: TSortOrderEh;
  Field: TField;
  Fields: String;

  function GetDataFieldName(LookUpFieldName : String) : String;
  var
    FieldList: TFieldListEh;
    i: Integer;
  begin
    Result := DataSet.FieldByName(LookUpFieldName).KeyFields;
    begin
      FieldList := TFieldListEh.Create;
      try
        DataSet.GetFieldList(FieldList, Result);
        Result := '';
        for i := 0 to FieldList.Count-1 do
        begin
          if i > 0 then
            Result := Result + ', ';
          Result := '[' + TField(FieldList[i]).FieldName + ']';
        end;
      finally
        FreeAndNil(FieldList);
      end;
    end;
  end;

  begin
  s := '';
  for i := 0 to AGrid.SortMarkedColumns.Count - 1 do
  begin

    Field := AGrid.SortMarkedColumns[i].Field;
    if (Field <> nil) and (Field.FieldKind = fkLookup) then
      Fields := GetDataFieldName(Field.FieldName)
    else
      Fields := '[' + AGrid.SortMarkedColumns[i].FieldName + ']';

    s := s + Fields;

    SortOrder := AGrid.Center.GetSortOrderForSortMarker(AGrid,
      AGrid.SortMarkedColumns[i], AGrid.SortMarkedColumns[i].Title.SortMarker);
    if SortOrder = soDescEh
      then s := s + ' DESC, '
      else s := s + ', ';
  end;
  Result := Copy(s, 1, Length(s) - 2);
end;

function TDatasetFeaturesEh.NullComparisonSyntax(AGrid: TCustomDBGridEh;
  DataSet: TDataSet; IsLocalFilter: Boolean): TNullComparisonSyntaxEh;
begin
  Result := ncsAsIsNullEh;
end;

function TDatasetFeaturesEh.WriteDataSetToMemTable(DataSet: TDataSet;
  MemTable: TCustomMemTableEh; RecordCount: Integer;
  Mode: TLoadMode; UseCachedUpdates: Boolean): Integer;
begin
  Result := MemTable.DefaultLoadFromDataSet(DataSet, RecordCount, Mode, UseCachedUpdates);
end;

function TDatasetFeaturesEh.GetLocalFilterApplyingWay: TLocalFilterApplyingWayEh;
begin
  Result := lfawPropertyFilterEh;
end;

function TDatasetFeaturesEh.CheckCurrentRecordMatchesGridSTFilter(
  Grid: TCustomDBGridEh; DataSet: TDataSet): Boolean;
var
  i: Integer;
begin
  Result := True;
  for i := 0 to Grid.Columns.Count-1 do
  begin
    Result := Result and CheckCurrentRecordMatchesGridSTFilterColumn(Grid.Columns[i], Grid, DataSet);
  end;
end;

function TDatasetFeaturesEh.CheckCurrentRecordMatchesGridSTFilterColumn(Column: TColumnEh;
  Grid: TCustomDBGridEh; DataSet: TDataSet): Boolean;
var
  FilterExpt: TSTFilterExpressionEh;
  Expression2: Boolean;
begin
  FilterExpt := Column.STFilter.Expression;
  if (FilterExpt.ExpressionType = botNon) then
  begin
    Result := True;
  end else
  begin
    Result := CheckCurrentRecordMatchesSimpleExpression(Column, Grid, DataSet, FilterExpt.Operator1, FilterExpt.Operand1);
    if (FilterExpt.Relation <> foNon) then
    begin
      Expression2 := CheckCurrentRecordMatchesSimpleExpression(Column, Grid, DataSet, FilterExpt.Operator2, FilterExpt.Operand2);

      if (FilterExpt.Relation = foAND) then
        Result := Result and Expression2
      else
        Result := Result or Expression2;
    end;
  end;
end;

function TDatasetFeaturesEh.CheckCurrentRecordMatchesSimpleExpression(Column: TColumnEh;
  Grid: TCustomDBGridEh; DataSet: TDataSet; AnOperator: TSTFilterOperatorEh; AnOperand: Variant): Boolean;
var
  colValue: Variant;
  VarCompRel: TVariantRelationship;
  i: Integer;
  SingleWildcard: String;
  MultipleWildcard: String;
begin
  Result := False;
  if (Column.LookupParams.LookupActive) then
    colValue := Column.LookupParams.GetKeyValue
  else
    colValue := Column.Field.Value;

  if (AnOperator in [foNull, foEqualToNull]) then
  begin
    AnOperator := foEqual;
    AnOperand := Null;
  end else if (AnOperator in [foNotNull, foNotEqualToNull]) then
  begin
    AnOperator := foNotEqual;
    AnOperand := Null;
  end;

  if (AnOperator = foNon) then
  begin
    Result := True;
  end else if (AnOperator in [foEqual, foNotEqual]) then
  begin
    Result := VarEquals(colValue, AnOperand);
    if (AnOperator = foNotEqual) then
      Result := not Result;
  end else if (AnOperator in [foGreaterThan, foLessThan, foGreaterOrEqual, foLessOrEqual]) then
  begin
    VarCompRel := VarCompareValue(colValue, AnOperand);
    if (VarCompRel = vrEqual) and (AnOperator in [foGreaterOrEqual, foLessOrEqual]) then
      Result := True
    else if (VarCompRel = vrLessThan) and (AnOperator in [foLessThan, foLessOrEqual]) then
      Result := True
    else if (VarCompRel = vrGreaterThan) and (AnOperator in [foGreaterThan, foGreaterOrEqual]) then
      Result := True
    else
      Result := False;
  end else if (AnOperator in [foLike, foNotLike]) then
  begin
    SingleWildcard := CustomFilterSingleCharWildcard;
    MultipleWildcard := CustomFilterMultipleCharsWildcard;
    Result := StringIsMatchLikePattern(VarToStrDef(colValue, ''), VarToStrDef(AnOperand, ''), True, SingleWildcard, MultipleWildcard);
    if AnOperator = foNotLike then
      Result := not Result ;
  end else if (AnOperator in [foIn, foNotIn]) then
  begin
    if (VarIsArray(AnOperand)) then
    begin
      for i := VarArrayLowBound(AnOperand, 1) to VarArrayHighBound(AnOperand, 1) do
      begin
        if (VarEquals(colValue, AnOperand[i])) then
        begin
          Result := True;
          Break;
        end;
      end;
    end
    else
    begin
      if (VarEquals(colValue, AnOperand)) then
      begin
        Result := True;
      end;
    end;

    if AnOperator = foNotIn then
      Result := not Result ;
  end;
end;

/// <summary> Limit of selected values in the TDBGridEh SubTitle
/// DropDown Filter Window
/// </summary>
function TDatasetFeaturesEh.GetFilterListValuesLimit(Sender: TObject;
  DataSet: TDataSet): Integer;
begin
  Result := -1;
end;

{ TSQLDatasetFeaturesEh }

constructor TSQLDatasetFeaturesEh.Create;
begin
  inherited Create;
  SQLPropName := 'SQL';
end;

function TSQLDatasetFeaturesEh.DateTimeValueToFilterStrValue(
  AnOperator: TSTFilterOperatorEh; Value: TDateTime; Column: TColumnEh;
  Grid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): String;
var
  ServerTypeName: String;
begin
  if (IsLocalFilter) then
    Result := '''' + DateTimeToStr(Value) + ''''
  else
  begin
    ServerTypeName := GetServerTypeName(Grid, DataSet);
    Result := DateValueToDataBaseSQLString(ServerTypeName, Value);
  end;
end;

function TSQLDatasetFeaturesEh.FloatValueToFilterStrValue(
  AnOperator: TSTFilterOperatorEh; Value: Extended; Column: TColumnEh;
  Grid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): String;
var
{$IFDEF CIL}
  OldDecimalSeparator: String;
{$ELSE}
  OldDecimalSeparator: Char;
{$ENDIF}
begin
  if (IsLocalFilter) then
    Result := FloatToStr(Value)
  else
  begin
    OldDecimalSeparator := FormatSettings.DecimalSeparator;
    FormatSettings.DecimalSeparator := '.';
    try
      Result := FloatToStr(Value);
    finally
      FormatSettings.DecimalSeparator := OldDecimalSeparator;
    end;
  end;
end;

function TSQLDatasetFeaturesEh.VarValueToFilterStrValue(
  AnOperator: TSTFilterOperatorEh; Value: Variant; Column: TColumnEh;
  Grid: TCustomDBGridEh; DataSet: TDataSet; IsLocalFilter: Boolean): String;
begin
  Result := VarToStr(Value);
  Result := StringReplace(Result, '''', '''''',[rfReplaceAll]);
  Result := '''' + Result + '''';
end;

procedure TSQLDatasetFeaturesEh.ApplyFilter(Sender: TObject;
  DataSet: TDataSet; IsReopen: Boolean);
begin
  if TDBGridEh(Sender).STFilter.Local then
    ApplyGridLocalFilter(TDBGridEh(Sender), DataSet, IsReopen)
  else
    ApplyGridServerFilter(TDBGridEh(Sender), DataSet, IsReopen);
end;

procedure TSQLDatasetFeaturesEh.ApplyGridServerFilter(Grid: TCustomDBGridEh;
  DataSet: TDataSet; IsReopen: Boolean);
var
  i, OrderLine: Integer;
  s: String;
  SQL: TStrings;
  SQLPropValue: WideString;
  {$IFDEF FPC}
  ASQLFilterMarker: String;
  {$ELSE}
  ASQLFilterMarker: WideString;
  {$ENDIF}
begin
  SQLPropValue := '';
  if not IsDataSetHaveSQLLikeProp(DataSet, SQLPropName, SQLPropValue) then
    raise Exception.Create(DataSet.ClassName + ' is not SQL based dataset');

  ASQLFilterMarker := GetSQLFilterMarker(Grid, DataSet);
  SQL := TStringList.Create;
  try
    SQL.Text := String(SQLPropValue);

    OrderLine := -1;
    for i := 0 to SQL.Count - 1 do
      if UpperCase(Copy(SQL[i], 1, Length(ASQLFilterMarker))) = UpperCase(ASQLFilterMarker) then
      begin
        OrderLine := i;
        Break;
      end;
    s := GetGridFilterAsFilterString(Grid, DataSet, False);
    if s = '' then
      s := '1=1';
    if OrderLine = -1 then
      Exit;
    DataSet.DisableControls;
    try
      if DataSet.Active then
        DataSet.Close;
      SQL.Strings[OrderLine] := ASQLFilterMarker + ' (' + s + ')';
      SetDataSetSQLLikeProp(DataSet, SQLPropName, WideString(SQL.Text));
      if IsReopen then
        DataSet.Open;
    finally
      DataSet.EnableControls;
    end;

  finally
    SQL.Free;
  end;
end;

function TSQLDatasetFeaturesEh.GetSQLFilterMarker(Grid: TCustomDBGridEh;
  DataSet: TDataSet): String;
begin
  Result := DBUtilsEh.SQLFilterMarker;
end;

function TSQLDatasetFeaturesEh.GetServerTypeName(Grid: TCustomDBGridEh;
  DataSet: TDataSet): String;
begin
  Result := '';
end;

procedure TSQLDatasetFeaturesEh.ApplySorting(Sender: TObject; DataSet: TDataSet; IsReopen: Boolean);
begin
  if Sender is TCustomDBGridEh then
    if TCustomDBGridEh(Sender).SortLocal then
      raise Exception.Create(Format ('TSQLDatasetFeaturesEh can not sort data ' +
        'in dataset "%s" in local mode', [DataSet.Name]))
    else
      ApplySortingForSQLBasedDataSet(TCustomDBGridEh(Sender), DataSet,
        SortUsingFieldName, IsReopen, SQLPropName);
end;

{ TCommandTextDatasetFeaturesEh }

constructor TCommandTextDatasetFeaturesEh.Create;
begin
  inherited Create;
  SQLPropName := 'CommandText';
end;

procedure InitUnit;
begin
  DatasetFeaturesList := TStringList.Create;
  DatasetFeaturesList.Duplicates := dupError;

  RoughStringCompareProcEh := @DefaultRoughStringCompareEh;
  RoughStringSearchProcEh := @DefaultRoughStringSearchEh;
  RoughStringPosProcEh := @DefaultRoughStringPosEh;
  MakeStringRoughProcEh := nil;
end;

procedure FinalUnit;
begin
  DisposeDatasetFeaturesList;
end;

initialization
  InitUnit;
finalization
  FinalUnit;
end.
