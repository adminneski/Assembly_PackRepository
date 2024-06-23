{******************************************}
{                                          }
{             FastReport VCL               }
{           Syntax memo control            }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxSynMemo;

interface

{$I frx.inc}

uses
  {$IFNDEF FPC}
  Windows, Messages, Imm,
  {$ELSE}
  LCLType, LMessages, LazHelper, LCLIntf, LCLProc,
  {$ENDIF}
  Types, SysUtils, Classes, Graphics, Controls, StdCtrls, ExtCtrls, Forms,
  frxCtrls, fs_iparser, frxPopupForm, fs_xml, fs_iinterpreter, Menus, frxRes, frTypes,
  frxHint;

const
  WM_FRX_SYNC_SCRIPT = WM_USER + 100;
  WM_FRX_UPDATE_CODE = WM_USER + 101;
  WM_FRX_FILL_CODE_COMPLETION = WM_USER + 102;

type
  TfrxCompletionList = class;
  TCharAttr = (caNo, caText, caComment, caKeyword, caString,
    caNumber);
  //TCharAttributes = set of TCharAttr;
  TfrxCharAttributes = record
    StyleIndex: Byte;
    IsSelBlock: Boolean;
  end;

  TfrxAttributeStyle = class(TCollectionItem)
  private
    FStyleID: Byte;
    FFontColor: TColor;
    FFontStyle: TFontStyles;
    FKeywords: TStrings;
    FAttrType: TCharAttr;
  protected
    procedure SetCollection(Value: TCollection); override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
    property StyleID: Byte read FStyleID;
  published
    property AttrType: TCharAttr read FAttrType write FAttrType;
    property FontColor: TColor read FFontColor write FFontColor;
    property FontStyle: TFontStyles read FFontStyle write FFontStyle;
    property Keywords: TStrings read FKeywords;
  end;

  TfrxAttributeStyles = class(TCollection)
  private
    { null object }
    FDefaultAttribute: TfrxAttributeStyle;
    FIndexedList: TStringList;
    function GetItem(Index: Integer): TfrxAttributeStyle;
  public
    function GetUniqueID: Byte;
    constructor Create;
    destructor Destroy; override;
    function Add: TfrxAttributeStyle;
    function GetStyleByID(ID: Byte): TfrxAttributeStyle;
    procedure AssignStyleByID(ID: Byte; aFont: TFont);
    procedure AssignStyle(aStyle: TfrxAttributeStyle; aFont: TFont);
    function FindStyleIDByKeyword(const Name: String; AttrType: TCharAttr): Byte;
    property Items[Index: Integer]: TfrxAttributeStyle read GetItem; default;
  end;

  TfrxSynDialectStyle = class(TPersistent)
  private
    FAttributeStyles: TfrxAttributeStyles;
    FKeywords: String;
    FCommentLine1: String;
    FCommentLine2: String;
    FCommentBlock1: String;
    FCommentBlock2: String;
    FStringQuotes: String;
    FHexSequence: String;
    FName: String;
    FOwner: TObject;
    procedure SetName(const Value: String);
  public
    constructor Create(AOwner: TObject);
    destructor Destroy; override;
    { TODO: we need one contract for all setings. I.e. need interface for this }
    procedure SaveTo(const Section: String; Ini: TObject);
    procedure LoadFrom(const Section: String; Ini: TObject);
    property AttributeStyles: TfrxAttributeStyles read FAttributeStyles;
    property Name: String read FName write SetName;
  published
    property Keywords: String read FKeywords write FKeywords;
    property CommentLine1: String read FCommentLine1 write FCommentLine1;
    property CommentLine2: String read FCommentLine2 write FCommentLine2;
    property CommentBlock1: String read FCommentBlock1 write FCommentBlock1;
    property CommentBlock2: String read FCommentBlock2 write FCommentBlock2;
    property StringQuotes: String read FStringQuotes write FStringQuotes;
    property HexSequence: String read FHexSequence write FHexSequence;
  end;

  TfrxSynDialectStyles = class(TObject)
  private
    FLIst: TList;
    FDefSynDialectStyle: TfrxSynDialectStyle;
    FActiveIndex: Integer;
    FActiveChanged: TNotifyEvent;
    function GetItem(Index: Integer): TfrxSynDialectStyle;
    function GetActiveDialicet: TfrxSynDialectStyle;
    function GetActiveStyles: TfrxAttributeStyles;
    procedure SetActiveIndex(const Value: Integer);
   public
    constructor Create;
    destructor Destroy; override;
    function Add: TfrxSynDialectStyle;
    procedure Clear;
    function Count: Integer;
    { TODO: we need one contract for all setings. I.e. need interface for this }
    procedure SaveTo(const Section: String; Ini: TObject);
    procedure LoadFrom(const Section: String; Ini: TObject);
    property Items[Index: Integer]: TfrxSynDialectStyle read GetItem; default;
    property ActiveDialicet: TfrxSynDialectStyle read GetActiveDialicet;
    property ActiveStyles: TfrxAttributeStyles read GetActiveStyles;
    property ActiveIndex: Integer read FActiveIndex write SetActiveIndex;
    property OnActiveChanged: TNotifyEvent read FActiveChanged write FActiveChanged;
  end;

  TfrxCodeCompletionEvent = procedure(const Name: String; List: TfrxCompletionList) of object;

  TfrxByteArr = array of Byte;

  TfrxSynAttributes = class
  private
    FArray: array of TfrxByteArr;
    FCapacity: Integer;
    FCount: Integer;
    FUpdating: Boolean;
    FDialectStyles: TfrxSynDialectStyles;
    FParser: TfsParser;
    procedure SetCapacity(NewCapacity: Integer);
    procedure SetCount(NewCount: Integer);
    function GetLine(Index: Integer): TfrxByteArr;
    procedure PutLine(Index: Integer; const Value: TfrxByteArr);
    procedure ActiveChanged(Sender: TObject);
  public
    constructor Create(Parser: TfsParser; DialectStyles: TfrxSynDialectStyles);
    procedure SetLineLen(Index: Integer; NewLen: Integer);
    procedure Delete(Index: Integer);
    function GetAllAttributes: TfrxByteArr;
    procedure SetAllAttributes(Attr: TfrxByteArr);
    procedure UpdateSyntax(EndLine: Integer; Text: TStringList);
    procedure UpdateSyntaxDialect;
    property Line[Index: Integer]: TfrxByteArr read GetLine write PutLine; default;
    property Count: Integer read FCount write SetCount;
    property Updating: Boolean read FUpdating;
  end;

  TfrxBreakPoint = class
  private
    FCondition: String;
    FSpecialCondition: String;
    FEnabled: Boolean;
    FLine: Integer;
  public
    property Condition: String read FCondition write FCondition;
    property Enabled: Boolean read FEnabled write FEnabled;
    property Line: Integer read FLine write FLine;
    property SpecialCondition: String read FSpecialCondition write FSpecialCondition;
  end;

  TfrxItemType = (itVar, itProcedure, itFunction, itProperty, itIndex, itConstant, itConstructor, itType, itEvent);
  TfrxItemTypes = set of TfrxItemType;

  TfrxCompletionListType = (cltRtti, cltScript, cltAddon);
  TfrxCompletionListTypes = set of TfrxCompletionListType;

  TfrxCompletionItem = class
  private
    FParent: TfrxCompletionItem;
    FName: String;
    FType: String;
    FParams: String;
    FItemType: TfrxItemType;
    FStartVisible: Integer;
    FEndVisible: Integer;
  public
    property Name: String read FName;
    property Typ: String read FType;
    property Params: String read FParams;
    property ItemType: TfrxItemType read FItemType;
  end;

  TfrxCompletionList = class
  private
    FConstants: TStringList;
    FVariables: TStringList;
    FFunctions: TStringList;
    FClasses: TStringList;
    FLocked: Boolean;
    function AddBaseVar(varList: TStrings; const Name, sType: String; VisibleStart: Integer = 0; VisibleEnd: Integer = -1; const ParentFunc: String = ''): TfrxCompletionItem;
    function GetItem(Index: Integer): TfrxCompletionItem;
  public
    constructor Create;
    destructor Destroy; override;
    procedure DestroyItems;
    function Count: Integer;
    function AddConstant(const Name, sType: String; VisibleStart: Integer = 0; VisibleEnd: Integer = -1; const ParentFunc: String = ''): TfrxCompletionItem;
    function AddVariable(const Name, sType: String; VisibleStart: Integer = 0; VisibleEnd: Integer = -1; const ParentFunc: String = ''): TfrxCompletionItem;
    function AddClass(const Name, sType: String; VisibleStart: Integer = 0; VisibleEnd: Integer = -1; const ParentFunc: String = ''): TfrxCompletionItem;
    function AddFunction(const Name, sType, Params: String; VisibleStart: Integer = 0; VisibleEnd: Integer = -1; const ParentFunc: String = ''): TfrxCompletionItem;
    function Find(const Name: String): TfrxCompletionItem;
    property Items[Index: Integer]: TfrxCompletionItem read GetItem; default;
    property Locked: Boolean read FLocked write FLocked;
  end;

  { TfrxCodeCompletionThread }

  TfrxCodeCompletionThread = class(TThread)
  private
    FText: TStringList;
    FScript: TfsScript;
    FOriginalScript: TfsScript;
    FILCode: TStream;
    FXML: TfsXMLDocument;
    FCompletionList: TfrxCompletionList;
    FSyntaxType: String;
    FMemoHandle: HWND;
    procedure SyncScript;
    procedure UpdateCode;
    procedure FreeScript;
    procedure FillCodeCompletion;
  public
    destructor Destroy; override;
    procedure Execute; override;
    property Script: TfsScript read FOriginalScript write FOriginalScript;
  end;

  {$IFDEF FPC}
  { TBrkStringList }

  TBrkStringList = class(TStringList)
    function AddObject(const S: string; AObject: TObject): Integer; override; overload;
  end;
  {$ENDIF}

  TfrxSyntaxMemo = class(TfrxScrollWin)
  private
    {$IFDEF NONWINFPC}
    FCaretCreated: Boolean;
    {$ENDIF}
    FActiveLine: Integer;
    FAllowLinesChange: Boolean;
    FBlockColor: TColor;
    FBlockFontColor: TColor;
    FBookmarks: array[0..9] of Integer;
    FCharHeight: Integer;
    FCharWidth: Integer;
    FCommentAttr: TFont;
    FCompletionForm: TfrxPopupForm;
    FCompletionLB: TListBox;
    FDoubleClicked: Boolean;
    FDown: Boolean;
    FToggleBreakPointDown: Boolean;
    FGutterWidth: Integer;
    FIsMonoType: Boolean;
    FKeywordAttr: TFont;
    FMaxLength: Integer;
    FMessage: String;
    FModified: Boolean;
    FMoved: Boolean;
    FNumberAttr: TFont;
    FOffset: TPoint;
    FOnChangePos: TNotifyEvent;
    FOnChangeText: TNotifyEvent;
    FOnCodeCompletion: TfrxCodeCompletionEvent;
    FParser: TfsParser;
    FPos: TPoint;
    FStringAttr: TFont;
    FSelEnd: TPoint;
    FSelStart: TPoint;
    FTabStops: Integer;
{$IFNDEF FPC}
    FCompSelStart: TPoint;
    FCompSelEnd: TPoint;
{$ENDIF}
    FShowGutter: boolean;
    //FSynStrings: TStrings;
    FSynAttributes: TfrxSynAttributes;
    FSynDialectStyles: TfrxSynDialectStyles;
    FSyntax: String;
    FTempPos, FLastHintPos: TPoint;
    FText: TStringList;
    FTextAttr: TFont;
    FUndo: TStringList;
    FWindowSize: TPoint;
    FBreakPoints: {$IFDEF FPC}TBrkStringList{$ELSE}TStringList{$ENDIF};
    FCodeCompList: TStringList;
    FStartCodeCompPos: Integer;
    FCompleationFilter: String;
    FScriptRTTIXML: TfsXMLDocument;
    FRttiCompletionList: TfrxCompletionList;
    FScriptCompletionList: TfrxCompletionList;
    FAddonCompletionList: TfrxCompletionList;
    FClassCompletionList: TfrxCompletionList;
    FCodeCompletionThread: TfrxCodeCompletionThread;
    FScript: TfsScript;
    FTimer: TTimer;
    FShowLineNumber: Boolean;
    FCodeComplitionFilter: TfrxItemTypes;
    FShowInCodeComplition: TfrxCompletionListTypes;
    FCodeCompletionWidth: Integer;
    FCodeCompletionHeight: Integer;
    FCodeCompletionMinHeight: Integer;
    FCodeCompletionMinWidth: Integer;
    FMultiByteLang: Boolean;
    FfrxHintShowEvent: TfrxHintShowEvent;
    FEnableHint: Boolean;
{$IFNDEF FPC}
    FTmpCanvas: TBitmap;
    {  need for east languages carret correction  }
    function GetCharWidth(const Str: String): Integer;
    function GetCharXPos(X: Integer): Integer;
{$ENDIF}
    function GetCharAttr(Pos: TPoint): TfrxCharAttributes;
    function GetLineBegin(Index: Integer): Integer;
    function GetPlainTextPos(Pos: TPoint): Integer;
    function GetPosPlainText(Pos: Integer): TPoint;
    function GetRunLine(Index: Integer): Boolean;
    function GetSelText: String;
    function GetText: TStrings;
    function LineAt(Index: Integer; UseTrim: Boolean = True): String;
    function GetIdentEnd(aPos: Integer): Integer;
    function IsCursorInStringBlock: Boolean;
    function LineLength(Index: Integer): Integer;
    function Pad(n: Integer): String;
    procedure AddSel;
    procedure AddUndo;
    procedure ClearSel;
    procedure ClearSyntax(ClearFrom: Integer);
    procedure CompletionFormClose(Sender: TObject; var Action: TCloseAction);
    procedure CompletionLBDblClick(Sender: TObject);
    procedure CompletionLBDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    function ItemToPrefix(Item: TfrxCompletionItem; var pref: String; c: TColor = clNone): TColor;
    procedure CompletionLBKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CompletionLBKeyPress(Sender: TObject; var Key: Char);
    procedure CorrectBookmark(Line, Delta: Integer);
    procedure CorrectBreakPoints(Line, Delta: Integer);
    procedure CreateSynArray(EndLine: Integer);
    procedure DoBackspace;
    procedure DoChange;
    procedure DoChar(Ch: Char);
    procedure DoCodeCompletion;
    procedure BuildCClist(const sName: String; aCodeCompList: TStringList; AllFunc: Boolean = False);
    procedure DoCtrlI;
    procedure DoCtrlU;
    procedure DoCtrlR;
    procedure DoCtrlL;
    procedure DoDel;
    procedure DoDown;
    procedure DoEnd(Ctrl: Boolean);
    procedure DoHome(Ctrl: Boolean);
    procedure DoLeft;
    procedure DoPgUp;
    procedure DoPgDn;
    procedure DoReturn;
    procedure DoRight;
    procedure DoUp;
    procedure EnterIndent;
    procedure LinesChange(Sender: TObject);
    procedure SetActiveLine(Line: Integer);
    procedure SetCommentAttr(Value: TFont);
    procedure SetKeywordAttr(Value: TFont);
    procedure SetNumberAttr(const Value: TFont);
    procedure SetRunLine(Index: Integer; const Value: Boolean);
    procedure SetSelText(const Value: String);
    procedure SetShowGutter(Value: Boolean);
    procedure SetStringAttr(Value: TFont);
    procedure SetSyntax(const Value: String);
    procedure SetText(Value: TStrings);
    procedure SetTextAttr(Value: TFont);
    procedure ShiftSelected(ShiftRight: Boolean);
    procedure ShowCaretPos;
    procedure TabIndent;
    procedure UnIndent;
    procedure UpdateScrollBar;
    procedure WMKillFocus(var Msg: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMSetFocus(var Msg: TWMSetFocus); message WM_SETFOCUS;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    { Inline IME realisation }
	{$IFNDEF FPC}
    procedure WMIMEStartComp(var Message: TMessage); message WM_IME_STARTCOMPOSITION;
    procedure WMIMEEndComp(var Message: TMessage); message WM_IME_ENDCOMPOSITION;
    procedure WMIMECOMPOSITION (var Message: TMessage); message WM_IME_COMPOSITION ;
	{$ENDIF}
    procedure WMFRXSyncScript(var Message: TMessage); message WM_FRX_SYNC_SCRIPT;
    procedure WMFRXUpdateCode(var Message: TMessage); message WM_FRX_UPDATE_CODE;
    procedure WMFRXFillCodeCompletion(var Message: TMessage); message WM_FRX_FILL_CODE_COMPLETION;
    procedure SetEnableHint(vEnableHint: boolean);
    procedure FakeHintShow(var Msg: TCMHintShow);
    procedure RealHintShow(var Msg: TCMHintShow);
    procedure WMFRXHintShow(var Msg: TCMHintShow); message CM_HINTSHOW;
    function OffsPoint(Point: TPoint): TPoint;
    procedure GetCurWord(Point: TPoint; var Prefix: String; var Header: String; var TextHint: String);
    function CurPosToSynPos(X, Y: Integer): TPoint;
    function GetTextSelected: Boolean;
    procedure SetGutterWidth(const Value: Integer);
    procedure SetShowInCodeComplition(const Value: TfrxCompletionListTypes);
    procedure SetCodeCompletionWidth(const Value: Integer);
    procedure SetCodeCompletionHeight(const Value: Integer);
    procedure SetCodeCompletionMinHeight(const Value: Integer);
    procedure SetCodeCompletionMinWidth(const Value: Integer);
    procedure PopCopy(Sender: TObject);
    procedure PopCut(Sender: TObject);
    procedure PopPaste(Sender: TObject);
    procedure PopDelete(Sender: TObject);
    procedure PopSelectAll(Sender: TObject);
    function GetAttributeStyles: TfrxAttributeStyles;
    procedure QuickComment;
  protected
    procedure DblClick; override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    {$IFDEF FPC}
    procedure UTF8KeyPress(var UTF8Key: TUTF8Char); override;
    {$ENDIF}
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer); override;
    procedure MouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure MouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure OnHScrollChange(Sender: TObject); override;
    procedure OnVScrollChange(Sender: TObject); override;
    procedure Resize; override;
    function GetCompletionString(Pos: TPoint): String;
    function GetFilter(aStr: String): String;
    procedure DoTimer(Sender: TObject);
    procedure DoPPIChanged(aNewPPI: Integer); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
    procedure CopyToClipboard;
    procedure CutToClipboard;
    procedure CompletionClose;
    procedure PasteFromClipboard;
    procedure SelectAll;
    procedure SetPos(x, y: Integer);
    procedure SetPosByCoords(X, Y: Integer);
    procedure ShowMessage(const s: String);
    procedure Undo;
    procedure UpdateView;
    procedure ClearBreakPoints;
    function Find(const SearchText: String; CaseSensitive: Boolean;
      var SearchFrom: Integer): Boolean;
    function GetPlainPos: Integer;
    function GetPos: TPoint;
    function IsBookmark(Line: Integer): Integer;
    procedure AddBookmark(Line, Number: Integer);
    procedure DeleteBookmark(Number: Integer);
    procedure GotoBookmark(Number: Integer);
    procedure AddNewBreakPoint;
    procedure AddBreakPoint(Number: Integer; const Condition: String; const Special: String);
    procedure ToggleBreakPoint(Number: Integer; const Condition: String);
    procedure DeleteBreakPoint(Number: Integer);
    procedure DeleteF4BreakPoints;
    function IsBreakPoint(Number: Integer): Boolean;
    function IsActiveBreakPoint(Number: Integer): Boolean;
    function GetBreakPointCondition(Number: Integer): String;
    function GetBreakPointSpecialCondition(Number: Integer): String;
    procedure FillRtti;
    procedure SaveToIni(const IniPath: String; const Section: String; const FileName: String);
    procedure LoadFromIni(const IniPath: String; const Section: String; const FileName: String);

//    property DefaultAttributeStyles: TfrxAttributeStyles read FAttributeStyles;
    property EnableHint: Boolean read FEnableHint write SetEnableHint default True;
    property AttributeStyles: TfrxAttributeStyles read GetAttributeStyles;
    property CodeCompletionThread: TfrxCodeCompletionThread read FCodeCompletionThread;
    property CodeCompletionMinWidth: Integer read FCodeCompletionMinWidth write SetCodeCompletionMinWidth default 300;
    property CodeCompletionMinHeight: Integer read FCodeCompletionMinHeight write SetCodeCompletionMinHeight default 100;
    property CodeCompletionWidth: Integer read FCodeCompletionWidth write SetCodeCompletionWidth default 300;
    property CodeCompletionHeight: Integer read FCodeCompletionHeight write SetCodeCompletionHeight default 100;
    property ActiveLine: Integer read FActiveLine write SetActiveLine;
    property BlockColor: TColor read FBlockColor write FBlockColor;
    property BlockFontColor: TColor read FBlockFontColor write FBlockFontColor;
    property BreakPoints:{$IFDEF FPC}TBrkStringList{$ELSE}TStringList{$ENDIF} read FBreakPoints;
    property Color;
    property CommentAttr: TFont read FCommentAttr write SetCommentAttr;
    property CodeComplitionFilter: TfrxItemTypes read FCodeComplitionFilter write FCodeComplitionFilter;
    property ShowInCodeComplition: TfrxCompletionListTypes read FShowInCodeComplition write SetShowInCodeComplition;
    property SynDialectStyles: TfrxSynDialectStyles read FSynDialectStyles;
    property Font;
	{$IFNDEF FPC}
    property ImeMode;
    property ImeName;
  	{$ENDIF}
    property SelStart: TPoint read FSelStart write FSelStart;
    property SelEnd: TPoint read FSelEnd write FSelEnd;
    property TabStops: Integer read FTabStops write FTabStops;
    property GutterWidth: Integer read FGutterWidth write SetGutterWidth;
    property KeywordAttr: TFont read FKeywordAttr write SetKeywordAttr;
    property Modified: Boolean read FModified write FModified;
    property MultiByteLang: Boolean read FMultiByteLang write FMultiByteLang;
    property NumberAttr: TFont read FNumberAttr write SetNumberAttr;
    property RunLine[Index: Integer]: Boolean read GetRunLine write SetRunLine;
    property SelText: String read GetSelText write SetSelText;
    property StringAttr: TFont read FStringAttr write SetStringAttr;
    property TextAttr: TFont read FTextAttr write SetTextAttr;
    property Lines: TStrings read GetText write SetText;
    property Syntax: String read FSyntax write SetSyntax;
    property Script: TfsScript read FScript write FScript;
    property ShowGutter: Boolean read FShowGutter write SetShowGutter;
    property ShowLineNumber: Boolean read FShowLineNumber write FShowLineNumber;
    property TextSelected: Boolean read GetTextSelected;
    property ScriptRTTIXML: TfsXMLDocument read FScriptRTTIXML;
    property OnChangePos: TNotifyEvent read FOnChangePos write FOnChangePos;
    property OnChangeText: TNotifyEvent read FOnChangeText write FOnChangeText;
    property OnCodeCompletion: TfrxCodeCompletionEvent read FOnCodeCompletion
      write FOnCodeCompletion;
    property OnDragDrop;
    property OnDragOver;
    property OnKeyDown;
    property PopupMenu;
  end;

  TDiffFunc = function(s1, s2: String): Integer;

implementation


uses Clipbrd, fs_itools, frxUtils, frXML, IniFiles, Registry, frDPIAwareInt,
  frxPlatformServices{$IFDEF FPC},RtlConsts{$ENDIF};

const
  SQLKeywords =
    'active,after,all,alter,and,any,as,asc,ascending,at,auto,' +
    'base_name,before,begin,between,by,cache,call,cast,check,column,commit,' +
    'committed,computed,conditional,constraint,containing,count,create,' +
    'current,cursor,database,debug,declare,default,delete,desc,descending,' +
    'distinct,do,domain,drop,else,end,entry_point,escape,exception,execute,' +
    'exists,exit,external,extract,filter,for,foreign,from,full,function,' +
    'generator,grant,group,having,if,in,inactive,index,inner,insert,into,is,' +
    'isolation,join,key,left,level,like,merge,names,no,not,null,of,on,only,' +
    'or,order,outer,parameter,password,plan,position,primary,privileges,' +
    'procedure,protected,read,retain,returns,revoke,right,rollback,schema,' +
    'select,set,shadow,shared,snapshot,some,suspend,table,then,to,' +
    'transaction,trigger,uncommitted,union,unique,update,user,using,values,' +
    'view,wait,when,where,while,with,work';
  SQLCommentLine1 = '--';
  SQLCommentBlock1 = '/*,*/';
  SQLStringQuotes = '"';
  SQLHexSequence = '0x';
  {$IFNDEF FPC}
  WordChars = ['a'..'z', 'A'..'Z', 'à'..'ÿ', 'À'..'ß', '0'..'9', '_'];
  {$ELSE}
  WordChars = ['a'..'z', 'A'..'Z', '0'..'9', '_'];
  {$ENDIF}

  {$IFDEF NONWINFPC}
  LineBreak: String = #$A;
  {$ELSE}
  LineBreak: String = #$D#$A;
  {$ENDIF}
  DefGutterWidth: Integer = 30;
  ReservedStylesCount = Byte(High(TCharAttr));

{$IFDEF DELPHI12}
function IsUnicodeChar(Chr: Char): Boolean;
begin
  Result := ((Chr >= Char($007F)) and (Chr <= Char($FFFF)));
end;
{$ENDIF}




procedure FilterCodeStringList(aFilterStr: String; aLBList: TStrings; aCodeList: TStrings; aDiffFunc: TDiffFunc);
var
  i: Integer;
  Item: TfrxCompletionItem;

  function BuildName(Item: TfrxCompletionItem): String;
  begin
    Result := Item.FName;
    if (Item.FItemType in [itProcedure, itFunction]) and (Item.FParams <> '') then
      Result := Result + '(' + Item.FParams +')'
    else if Item.FItemType = itIndex then
      Result := Result + '[' + Item.FParams +']';
    if (Item.FType <> '') and (Item.FItemType <> itType) then
      Result := Result + ':' + Item.FType;
  end;

begin
  for i := 0 to aCodeList.Count - 1 do
  begin
    Item := TfrxCompletionItem(aCodeList.Objects[i]);
    if (aFilterStr = '') or (aDiffFunc(UpperCase(aFilterStr), UpperCase(aCodeList[i])) = 1) then
      aLBList.AddObject(BuildName(Item), Item);
  end;
end;

procedure FilterCodeListBox(aFilterStr: String; aListBox: TListBox; aCodeList: TStrings; aDiffFunc: TDiffFunc);
begin
  aListBox.ItemIndex := -1;
  aListBox.Items.BeginUpdate;
  aListBox.Items.Clear;

  FilterCodeStringList(aFilterStr, aListBox.Items, aCodeList, aDiffFunc);

  if (aListBox.Count > 0) then
    aListBox.ItemIndex := 0;
  aListBox.Items.EndUpdate;
end;

function Diff(s1, s2: String): Integer;
begin
  if (s1 = s2) then
    Result := 1
  else
    Result := 0;
end;

function frxSynPos(s1, s2: String): Integer;
begin
  Result := Pos(s1, s2);
end;

{$IFDEF FPC}
{ TBrkStringList }

function TBrkStringList.AddObject(const S: string; AObject: TObject): Integer;
begin
  If Not (SortStyle=sslAuto) then
    Result:= Count
  else
    If Find (S,Result) then
      Case DUplicates of
        DupIgnore : Exit;
        DupError : Error(SDuplicateString,0)
      end;
   InsertItem (Result,S, AObject);
end;
{$ENDIF}


{ TfrxSyntaxMemo }

constructor TfrxSyntaxMemo.Create(AOwner: TComponent);
var
  i: Integer;
begin
  inherited;
{$IFDEF JPN}
  FMultiByteLang := True;
{$ENDIF}
  FSynDialectStyles := TfrxSynDialectStyles.Create;
//  FAttributeStyles := TfrxAttributeStyles.Create;
{$IFNDEF FPC}
  FTmpCanvas := TBitmap.Create;
{$ENDIF}
  {$IFDEF NONWINFPC}
  FCaretCreated := False;
  {$ENDIF}
  DoubleBuffered := True;
  TabStop := True;
  Cursor := crIBeam;
  Color := clWindow;

  FBreakPoints := {$IFDEF FPC}TBrkStringList.Create{$ELSE}TStringList.Create{$ENDIF};

  FBlockColor := clHighlight;
  FBlockFontColor := clHighlightText;

  FCommentAttr := TFont.Create;
  FCommentAttr.Color := clNavy;
  FCommentAttr.Style := [fsItalic];

  FKeywordAttr := TFont.Create;
  FKeywordAttr.Color := clWindowText;
  FKeywordAttr.Style := [fsBold];

  FNumberAttr := TFont.Create;
  FNumberAttr.Color := clGreen;
  FNumberAttr.Style := [];

  FStringAttr := TFont.Create;
  FStringAttr.Color := clNavy;
  FStringAttr.Style := [];

  FTextAttr := TFont.Create;
  FTextAttr.Color := clWindowText;
  FTextAttr.Style := [];

  Font.Size := 10;
  Font.Name := 'Courier New';

  FText := TStringList.Create;
  FParser := TfsParser.Create;
  FParser.SkipSpace := False;
  FParser.UseY := False;
  //FSynStrings := TStringList.Create;
  FSynAttributes := TfrxSynAttributes.Create(FParser, FSynDialectStyles);
  FUndo := TStringList.Create;
  FText.Add('');
  FText.OnChange := LinesChange;
  FMaxLength := 1024;
  FMoved := True;
  SetPos(1, 1);
  FTabStops := 2;
  ShowGutter := True;
  OnMouseWheelUp := MouseWheelUp;
  OnMouseWheelDown := MouseWheelDown;

  FActiveLine := -1;
  for i := 0 to 9 do
    FBookmarks[i] := -1;
  FScriptRTTIXML := TfsXMLDocument.Create;
  FRttiCompletionList := TfrxCompletionList.Create;
  FScriptCompletionList := TfrxCompletionList.Create;
  FAddonCompletionList := TfrxCompletionList.Create;
  FClassCompletionList := TfrxCompletionList.Create;
  FTimer := TTimer.Create(nil);
  FTimer.Interval := 1000;
  FTimer.OnTimer := DoTimer;
  FTimer.Enabled := False;
  FCodeCompList := TStringList.Create;
  FCodeCompletionThread := TfrxCodeCompletionThread.Create(True);
  FCodeCompletionThread.FText := FText;
  FCodeCompletionThread.FCompletionList := FScriptCompletionList;
  FShowLineNumber := True;
  FCodeComplitionFilter := [itVar, itProcedure, itFunction, itProperty, itIndex,
    itConstant, itConstructor, itType, itEvent];
  FShowInCodeComplition := [cltRtti, cltScript, cltAddon];
  FCodeCompletionHeight := 100;
  FCodeCompletionWidth := 300;
  FCodeCompletionMinHeight := 100;
  FCodeCompletionMinWidth := 300;
  PopupMenu := TPopupMenu.Create(Self);
  PopupMenu.Items.Clear;
  PopupMenu.Items.Add(NewItem(frxGet(2407), 0, False, True, PopCut      , 0, 'MenuItem1'));
  PopupMenu.Items.Add(NewItem(frxGet(2408), 0, False, True, PopCopy     , 0, 'MenuItem2'));
  PopupMenu.Items.Add(NewItem(frxGet(2409), 0, False, True, PopPaste    , 0, 'MenuItem3'));
  PopupMenu.Items.Add(NewItem(frxGet(2412), 0, False, True, PopDelete   , 0, 'MenuItem4'));
  PopupMenu.Items.Add(NewItem(frxGet(2414), 0, False, True, PopSelectAll, 0, 'MenuItem5'));
  PopupMenu.Images := frxImages.MainButtonImages;
  PopupMenu.Items[0].ImageIndex := 5;
  PopupMenu.Items[1].ImageIndex := 6;
  PopupMenu.Items[2].ImageIndex := 7;
  PopupMenu.Items[3].ImageIndex := 51;
  EnableHint := True;
end;

destructor TfrxSyntaxMemo.Destroy;
begin
{$IFNDEF FPC}
  FTmpCanvas.Free;
{$ENDIF}
  ClearBreakPoints;
  FreeAndNil(FTimer);
  {$IFDEF LCLGTK2}
  if Assigned(FCodeCompletionThread) then
  begin
    FCodeCompletionThread.Terminate;
    FCodeCompletionThread.Resume;
  end;
  {$ELSE}
  if Assigned(FCodeCompletionThread) then
    FCodeCompletionThread.Terminate;
  {$ENDIF}
  FreeAndNil(FCodeCompletionThread);
  FreeAndNil(FBreakPoints);
  FreeAndNil(FCommentAttr);
  FreeAndNil(FKeywordAttr);
  FreeAndNil(FNumberAttr);
  FreeAndNil(FStringAttr);
  FreeAndNil(FTextAttr);
  FreeAndNil(FText);
  FreeAndNil(FUndo);
  FreeAndNil(FSynAttributes);
  FreeAndNil(FSynDialectStyles);
  FreeAndNil(FParser);
  FreeAndNil(FScriptRTTIXML);
  FreeAndNil(FRttiCompletionList);
  FreeAndNil(FScriptCompletionList);
  FreeAndNil(FAddonCompletionList);
  FreeAndNil(FClassCompletionList);
  FreeAndNil(FCodeCompList);
  inherited;
end;


procedure TfrxSyntaxMemo.WMFRXFillCodeCompletion(var Message: TMessage);
begin
  if Assigned(FCodeCompletionThread) then
    FCodeCompletionThread.FillCodeCompletion;
end;

procedure TfrxSyntaxMemo.SetEnableHint(vEnableHint: boolean);
begin
  FEnableHint := vEnableHint;
  if (vEnableHint) then
    FfrxHintShowEvent := RealHintShow
  else
    FfrxHintShowEvent := FakeHintShow;
end;

procedure TfrxSyntaxMemo.FakeHintShow(var Msg: TCMHintShow);
begin
  //do nothing
end;

procedure TfrxSyntaxMemo.RealHintShow(var Msg: TCMHintShow);
var
  PropName, PropText: String;
  BufP: TPoint;
  Header, Prefix: String;
begin
  BufP := Msg.HintInfo.CursorPos;
  BufP := CurPosToSynPos(BufP.X, BufP.Y);
  GetCurWord(BufP, Prefix, Header, PropText);

  PropName := 'prop' + PropText;
  PropText := frxResources.Get(PropName);
  { TODO: Make parameters description }
  if (PropName = PropText) then
    PropText := frxResources.Get('dtNoData');

  if (Header <> '') then
  begin
    Msg.HintInfo.HintStr := PropText;
    Msg.HintInfo.HintWindowClass := TBaseHintWindow;
    Msg.HintInfo.HintData := TBaseHintData.Create(Prefix + ' ', Header + ';', True);
    Msg.HintInfo.HideTimeout := MaxInt;
  end
  else
    Msg.HintInfo.HintStr := '';
end;

procedure TfrxSyntaxMemo.WMFRXHintShow(var Msg: TCMHintShow);
begin
  inherited;
  FfrxHintShowEvent(Msg);
end;

function TfrxSyntaxMemo.OffsPoint(Point: TPoint): TPoint;
var
  i: Integer;
  s: String;

  function IsWord(c: Char): Boolean;
  begin
  {$IFDEF Delphi12}
    Result := CharInSet(c, ['a'..'z', 'A'..'Z', '0'..'9']);
  {$ELSE}
    Result := c in ['a'..'z', 'A'..'Z', '0'..'9'];
  {$ENDIF}
  end;

begin
  s := LineAt(Point.Y - 1, False);
  if Point.X > Length(s)  then
    Point.X := Length(s) + 1
  else
    if IsWord(s[Point.X]) then
      for i := Point.X to Length(s) do
      begin
        if IsWord(s[i]) then
          Point.X := Point.X + 1
        else
          break;
      end;
  Result := Point;
end;

procedure TfrxSyntaxMemo.GetCurWord(Point: TPoint; var Prefix: String;
  var Header: String; var TextHint: String);
var
  s: String;
  FCodeHintList: TStringList;
  FCompletionHintLB: TStringList;
  FHintFilter: String;
begin
  Point := OffsPoint(Point);

  FCodeHintList := TStringList.Create;
  FCompletionHintLB := TStringList.Create;
  FScriptCompletionList.Locked := True;

  try
    s := Trim(GetCompletionString(Point));
    FHintFilter := GetFilter(s);
    TextHint := FHintFilter;
    if FHintFilter = s then s := '';

    FAddonCompletionList.DestroyItems;
    if Assigned(FOnCodeCompletion) and (cltAddon in FShowInCodeComplition) then
      FOnCodeCompletion(s, FAddonCompletionList);
    BuildCClist(s, FCodeHintList, True);
    FilterCodeStringList(FHintFilter, FCompletionHintLB, FCodeHintList, @Diff);

    if FCompletionHintLB.Count > 0 then
    begin
      Header := FCompletionHintLB[0];
      ItemToPrefix(TfrxCompletionItem(FCompletionHintLB.Objects[0]), Prefix);
    end;

  finally
    FCodeHintList.Free;
    FCompletionHintLB.Free;
    FScriptCompletionList.Locked := False;
  end;
end;

function TfrxSyntaxMemo.CurPosToSynPos(X, Y: Integer): TPoint;
begin
  Result.X := (X - FGutterWidth) div FCharWidth + 1 + FOffset.X;
  Result.Y := Y div FCharHeight + 1 + FOffset.Y;
end;

procedure TfrxSyntaxMemo.WMFRXSyncScript(var Message: TMessage);
begin
  if Assigned(FCodeCompletionThread) then
    FCodeCompletionThread.SyncScript;
end;

procedure TfrxSyntaxMemo.WMFRXUpdateCode(var Message: TMessage);
begin
  if Assigned(FCodeCompletionThread) then
    FCodeCompletionThread.UpdateCode;
end;

{$IFNDEF FPC}
{ updating IME string and carret pos }
procedure TfrxSyntaxMemo.WMIMECOMPOSITION(var Message: TMessage);

  procedure UpdateComposition(aFlag: DWORD);
  var
    h: HIMC;
    nLen, nPos: Integer;
    StrBuf: String;
  begin
    h := Imm32GetContext(Handle);
    if h <> 0 then
    begin
      if aFlag = GCS_COMPSTR then
        nPos := Imm32GetCompositionString(h, GCS_CURSORPOS, nil, 0)
      else
        nPos := 0;
      nLen := Imm32GetCompositionString(h, aFlag, nil, 0);
      if nLen <> 0 then
      begin
        SetLength(StrBuf, nLen div 2);
        Imm32GetCompositionString(h, aFlag, @StrBuf[1], nLen);
        if (nLen div 2) > FCompSelEnd.X - FCompSelStart.X then
          FCompSelEnd.X := FCompSelStart.X + (nLen div 2) - 1;
        FSelStart.Y := FCompSelStart.Y;
        FSelStart.X := FCompSelStart.X;
        FSelEnd.Y := FCompSelEnd.Y;
        FSelEnd.X := FCompSelEnd.X;
        SelText := StrBuf;
        FPos.X := FCompSelStart.X + nPos + (nLen div 2);
        SetPos(FPos.X, FPos.Y);
        FCompSelEnd.X := FCompSelStart.X + (nLen div 2);
        Invalidate;
      end;
      Imm32ReleaseContext(Handle, h);
    end;
  end;

begin
  if (Message.LParam = $1E00) and (Message.WParam <> 12288) and (Message.WParam <> 32) then
    ResetImeComposition(CPS_CANCEL)
  else
  if (Message.LParam and GCS_RESULTSTR) = GCS_RESULTSTR  then
  begin
    UpdateComposition(GCS_RESULTSTR);
    FCompSelStart := FCompSelEnd;
  end
  else
  begin
    UpdateComposition(GCS_COMPSTR);
    Inherited;
  end;
end;

procedure TfrxSyntaxMemo.WMIMEEndComp(var Message: TMessage);
begin
  FInImeComposition := False;
end;

procedure TfrxSyntaxMemo.WMIMEStartComp(var Message: TMessage);
begin
  FCompSelStart.Y := FPos.Y;
  FCompSelStart.X := FPos.X;
  FCompSelEnd.Y := FPos.Y;
  FCompSelEnd.X := FPos.X;
  FInImeComposition := True;
end;
{$ENDIF}

procedure TfrxSyntaxMemo.WMKillFocus(var Msg: TWMKillFocus);
begin
  inherited;
  if Assigned(FCompletionForm) then Exit;
  {$IFDEF NONWINFPC}
  if not FCaretCreated then
    exit
  else
    FCaretCreated := False;
  {$ENDIF}
  HideCaret(Handle);
  DestroyCaret{$IFDEF FPC}(Handle){$ENDIF};
end;

procedure TfrxSyntaxMemo.WMSetFocus(var Msg: TWMSetFocus);
begin
  inherited;
  {$IFDEF NONWINFPC}
  if not HandleAllocated then
    exit
  else
    FCaretCreated := True;
  {$ENDIF}
  CreateCaret(Handle, 0, 2, FCharHeight);
  ShowCaretPos;
end;

procedure TfrxSyntaxMemo.ShowCaretPos;
{$IFNDEF FPC}
var
  cWidth: Integer;
  LineLen: Integer;
{$ENDIF}
begin
  if FPos.X > FOffset.X then
  begin
{$IFNDEF FPC}
  if FMultiByteLang then
  begin
    cWidth  := GetCharWidth(Copy(LineAt(FPos.Y - 1), FOffset.X, FPos.X - 1  - FOffset.X));
    LineLen := LineLength(FPos.Y - 1);
    if LineLen < FPos.X then
      cWidth := cWidth + FCharWidth * (FPos.X - 1 - LineLen);
  end
  else
    cWidth := FCharWidth * (FPos.X - 1 - FOffset.X);

    SetCaretPos(cWidth + FGutterWidth,
      FCharHeight * (FPos.Y - 1 - FOffset.Y));
{$ELSE}
    SetCaretPos(FCharWidth * (FPos.X - 1 - FOffset.X) + FGutterWidth,
      FCharHeight * (FPos.Y - 1 - FOffset.Y));
{$ENDIF}
    {$IFDEF NONWINFPC}
    if FCaretCreated then
      Update;
    {$ELSE}
    ShowCaret(Handle);
    {$ENDIF}
  end
  else
    SetCaretPos(-100, -100);
  if Assigned(FOnChangePos) then
    FOnChangePos(Self);
end;

procedure TfrxSyntaxMemo.CMFontChanged(var Message: TMessage);
var
  b: TBitmap;
begin
  FCommentAttr.PixelsPerInch := Font.PixelsPerInch;
  FCommentAttr.Size := Font.Size;
  FCommentAttr.Name := Font.Name;
  FKeywordAttr.PixelsPerInch := Font.PixelsPerInch;
  FKeywordAttr.Size := Font.Size;
  FKeywordAttr.Name := Font.Name;
  FNumberAttr.PixelsPerInch := Font.PixelsPerInch;
  FNumberAttr.Size := Font.Size;
  FNumberAttr.Name := Font.Name;
  FStringAttr.PixelsPerInch := Font.PixelsPerInch;
  FStringAttr.Size := Font.Size;
  FStringAttr.Name := Font.Name;
  FTextAttr.PixelsPerInch := Font.PixelsPerInch;
  FTextAttr.Size := Font.Size;
  FTextAttr.Name := Font.Name;

  b := TBitmap.Create;
  with b.Canvas do
  begin
    Font.PixelsPerInch := Self.Font.PixelsPerInch;
    Font.Assign(Self.Font);
    Font.Style := [fsBold];
    FCharHeight := TextHeight('Wg') + 1;
    FCharWidth := TextWidth('W');
    FIsMonoType := Pos('COURIER NEW', AnsiUppercase(Self.Font.Name)) <> 0;
  end;
  b.Free;
end;

procedure TfrxSyntaxMemo.Resize;
begin
  inherited;
  if FCharWidth = 0 then Exit;
  FWindowSize := Point((ClientWidth - FGutterWidth) div FCharWidth,
    ClientHeight div FCharHeight);
  {$IFDEF FPC}
  if (ClientHeight > 0) and (ClientWidth > 0) then
  begin
    HorzPage := FWindowSize.X;
    VertPage := FWindowSize.Y;
    UpdateScrollBar;
  end;
  {$ELSE}
  HorzPage := FWindowSize.X;
  VertPage := FWindowSize.Y;
  UpdateScrollBar;
  {$ENDIF}
end;

procedure TfrxSyntaxMemo.UpdateScrollBar;
begin
  VertRange := FText.Count;
  HorzRange := FMaxLength;
  LargeChange := FWindowSize.Y;
  VertPosition := FOffset.Y;
  HorzPosition := FOffset.X;
end;

function TfrxSyntaxMemo.GetText: TStrings;
//var
//  i: Integer;
begin
//  FAllowLinesChange := False;
//  for i := 0 to FText.Count - 1 do
//    FText[i] := LineAt(i);
  Result := FText;
  FAllowLinesChange := True;
end;

function TfrxSyntaxMemo.GetPlainPos: Integer;
begin
  Result := GetPlainTextPos(FPos);
end;

function TfrxSyntaxMemo.GetPos: TPoint;
begin
  Result := FPos;
end;

procedure TfrxSyntaxMemo.SetText(Value: TStrings);
begin
  FAllowLinesChange := True;
  FText.Assign(Value);
  DoChange;
end;

procedure TfrxSyntaxMemo.SetSyntax(const Value: String);
var
  sl: TStringList;

  procedure GetGrammar;
  var
    Grammar: TfrXMLDocument;
    ss: TStringStream;
    ParserRoot, xi: TfrXMLItem;
    i: Integer;
    Name, PropText: String;
  begin
    Grammar := TfrXMLDocument.Create;
    ss := TStringStream.Create(fsGetLanguage(Value){$IFDEF DELPHI12}, TEncoding.UTF8{$ENDIF});
    Grammar.LoadFromStream(ss);
    ss.Free;

    ParserRoot := Grammar.Root.FindItem('parser');
    xi := ParserRoot.FindItem('keywords');
    for i := 0 to xi.Count - 1 do
      FParser.Keywords.Add(xi[i].Name);

    for i := 0 to ParserRoot.Count - 1 do
    begin
      Name := LowerCase(ParserRoot[i].Name);
      PropText := ParserRoot[i].Prop['text'];
      if Name = 'identchars' then
        FParser.ConstructCharset(PropText)
      else if Name = 'commentline1' then
        FParser.CommentLine1 := PropText
      else if Name = 'commentline2' then
        FParser.CommentLine2 := PropText
      else if Name = 'commentblock1' then
        FParser.CommentBlock1 := PropText
      else if Name = 'commentblock2' then
        FParser.CommentBlock2 := PropText
      else if Name = 'stringquotes' then
        FParser.StringQuotes := PropText
      else if Name = 'hexsequence' then
        FParser.HexSequence := PropText
    end;

    Grammar.Free;
  end;

begin
  FSyntax := Value;
  FParser.Keywords.Clear;
  sl := TStringList.Create;
  if AnsiCompareText(Value, 'SQL') = 0 then
    FSynAttributes.UpdateSyntaxDialect
  else
  begin
    fsGetLanguageList(sl);
    if sl.IndexOf(Value) <> -1 then
      GetGrammar;
  end;

  ClearSyntax(1);
  sl.Free;
end;

procedure TfrxSyntaxMemo.SetCodeCompletionHeight(const Value: Integer);
begin
  FCodeCompletionHeight := Value;
  CompletionClose;
end;

procedure TfrxSyntaxMemo.SetCodeCompletionMinHeight(const Value: Integer);
begin
  FCodeCompletionMinHeight := Value;
  CompletionClose;
end;

procedure TfrxSyntaxMemo.SetCodeCompletionMinWidth(const Value: Integer);
begin
  FCodeCompletionMinWidth := Value;
  CompletionClose;
end;

procedure TfrxSyntaxMemo.PopCopy(Sender: TObject);
begin
  Self.CopyToClipboard;
end;

procedure TfrxSyntaxMemo.PopCut(Sender: TObject);
begin
  Self.CutToClipboard;
end;

procedure TfrxSyntaxMemo.PopPaste(Sender: TObject);
begin
  Self.PasteFromClipboard;
end;

procedure TfrxSyntaxMemo.PopDelete(Sender: TObject);
var
  buf: Word;
begin
  buf := vk_Delete;
  Self.KeyDown(buf, []);
end;

procedure TfrxSyntaxMemo.PopSelectAll(Sender: TObject);
begin
  Self.SelectAll;
end;

procedure TfrxSyntaxMemo.SetCodeCompletionWidth(const Value: Integer);
begin
  FCodeCompletionWidth := Value;
  CompletionClose;
end;

procedure TfrxSyntaxMemo.SetCommentAttr(Value: TFont);
begin
  FCommentAttr.Assign(Value);
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

procedure TfrxSyntaxMemo.SetGutterWidth(const Value: Integer);
begin
  if FGutterWidth <> Value  then
  begin
    FGutterWidth := Value;
    Invalidate;
  end;
end;

procedure TfrxSyntaxMemo.SetKeywordAttr(Value: TFont);
begin
  FKeywordAttr.Assign(Value);
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

procedure TfrxSyntaxMemo.SetNumberAttr(const Value: TFont);
begin
  FNumberAttr.Assign(Value);
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

procedure TfrxSyntaxMemo.SetStringAttr(Value: TFont);
begin
  FStringAttr.Assign(Value);
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

procedure TfrxSyntaxMemo.SetTextAttr(Value: TFont);
begin
  FTextAttr.Assign(Value);
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

procedure TfrxSyntaxMemo.SetActiveLine(Line: Integer);
begin
  FActiveLine := Line;
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

procedure TfrxSyntaxMemo.DoChange;
begin
  FModified := True;
  FTimer.Enabled := (FCompletionForm = nil) and
    (cltScript in FShowInCodeComplition) and Assigned(FScript);
  if Assigned(FOnChangeText) then
    FOnChangeText(Self);
end;

procedure TfrxSyntaxMemo.LinesChange(Sender: TObject);
begin
  if FAllowLinesChange then
  begin
    FAllowLinesChange := False;
    if FText.Count = 0 then
      FText.Add('');
    ClearSyntax(1);
    FMoved := True;
    FUndo.Clear;
    FPos := Point(1, 1);
    FOffset := Point(0, 0);
    ClearSel;
    ShowCaretPos;
    UpdateScrollBar;
  end;
end;

procedure TfrxSyntaxMemo.ShowMessage(const s: String);
begin
  FMessage := s;
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

procedure TfrxSyntaxMemo.CopyToClipboard;
begin
  if FSelStart.X <> 0 then
    Clipboard.AsText := SelText;
end;

procedure TfrxSyntaxMemo.CutToClipboard;
begin
  if FSelStart.X <> 0 then
  begin
    Clipboard.AsText := SelText;
    SelText := '';
  end;
  CorrectBookmark(FSelStart.Y, FSelStart.Y - FSelEnd.Y);
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

procedure TfrxSyntaxMemo.PasteFromClipboard;
begin
  SelText := Clipboard.AsText;
end;

procedure TfrxSyntaxMemo.SelectAll;
begin
  SetPos(0, 0);
  FSelStart := FPos;
  SetPos(LineLength(FText.Count - 1) + 1, FText.Count);
  FSelEnd := FPos;
{$IFDEF FPC}
      frxUpdateControl(Self, True);
{$ELSE}
      Repaint;
{$ENDIF}
end;

function TfrxSyntaxMemo.LineAt(Index: Integer; UseTrim: Boolean = True): String;
begin
  if Index < FText.Count then
  begin
    if UseTrim then
      Result := TrimRight(FText[Index])
    else
      Result := FText[Index];
  end
  else
    Result := '';
end;

function TfrxSyntaxMemo.LineLength(Index: Integer): Integer;
begin
  Result := frxLength(LineAt(Index));
end;

function TfrxSyntaxMemo.Pad(n: Integer): String;
begin
  Result := '';
  SetLength(Result, n);
{$IFDEF DELPHI12}
  Result := StringOfChar(Char(' '), n);
{$ELSE}
  FillChar(Result[1], n, ' ');
{$ENDIF}
end;

procedure TfrxSyntaxMemo.AddUndo;
begin
  if not FMoved then exit;
  FUndo.Add(Format('%5d%5d', [FPos.X, FPos.Y]) + FText.Text);
  if FUndo.Count > 32 then
    FUndo.Delete(0);
  FMoved := False;
end;

procedure GenerateClassList(Prog: TfsScript; cl: TClass; aList: TfrxCompletionList);
var
  i, j, k: Integer;
  v: TfsCustomVariable;
  c: TfsClassVariable;
  clItem: TfsCustomHelper;
  Params: String;
  Item: TfrxCompletionItem;
begin
  aList.DestroyItems;
  for i := 0 to Prog.Count - 1 do
  begin
    v := Prog.Items[i];
    if v is TfsClassVariable then
    begin
      c := TfsClassVariable(v);
      if cl.InheritsFrom(c.ClassRef) then
      begin
        for j := 0 to c.MembersCount - 1 do
        begin
          clItem := c.Members[j];
          if clItem is TfsPropertyHelper then
          begin
            Item := aList.AddVariable(clItem.Name, clItem.GetFullTypeName);
            Item.FItemType := itProperty;
          end
          else if clItem is TfsMethodHelper then
          begin
            Params := '';

            for k := 0 to clItem.Count - 1 do
            begin
              if k > 0 then
                Params := Params + ';';
              Params := Params + clItem.Params[k].Name + ': ' + clItem.Params[k].TypeName;
            end;
            Item := aList.AddFunction(clItem.Name, clItem.GetFullTypeName, Params);
            if TfsMethodHelper(clItem).IndexMethod then
              Item.FItemType := itIndex;
          end
          else
          begin
            Item := aList.AddVariable(clItem.Name, clItem.GetFullTypeName);
            Item.FItemType := itEvent;
          end;
        end;
      end;
    end;
  end;
end;

procedure TfrxSyntaxMemo.BuildCClist(const sName: String; aCodeCompList: TStringList; AllFunc: Boolean = False);
var
  members: TStringList;
  i: Integer;
  Item: TfrxCompletionItem;
  clName: String;
  clVar: TfsClassVariable;
  clMethod: TfsCustomHelper;

  procedure FillMembers(const Text: String; Comma: Char = ';');
  var
    i, ipos: Integer;
    Len: Integer;
  begin
    members.Clear;
    ipos := -1;
    Len := Length(Text);
    for i := Len downto 1 do
    begin
      if (Text[i] = Comma) then
      begin
        if ipos <> -1 then
          members.Insert(0, Copy(Text, i + 1, (iPos - 1 - i)));
        ipos := i;
      end
      else if (i = 1) then
      begin
        members.Insert(0, Copy(Text, i, (iPos - i)));
      end;

    end;
  end;
begin
  members := TStringList.Create;
  members.Duplicates := dupAccept;
  FillMembers(sName, '.');
  FClassCompletionList.DestroyItems;
  if members.Count = 0 then
  begin
    for i := 0 to FAddonCompletionList.Count - 1 do
      aCodeCompList.AddObject(FAddonCompletionList[i].FName, FAddonCompletionList[i]);
    for i := 0 to FScriptCompletionList.Count - 1 do
      if AllFunc or (FPos.Y >= FScriptCompletionList[i].FStartVisible) and ((FPos.Y <= FScriptCompletionList[i].FEndVisible) or (FScriptCompletionList[i].FEndVisible = -1)) then
        aCodeCompList.AddObject(FScriptCompletionList[i].FName, FScriptCompletionList[i]);
    for i := 0 to FRttiCompletionList.Count - 1 do
      aCodeCompList.AddObject(FRttiCompletionList[i].FName, FRttiCompletionList[i]);
  end;

  if Members.Count > 0 then
  begin
    Item := FAddonCompletionList.Find(Members[0]);
    if Item = nil then
      Item := FScriptCompletionList.Find(Members[0]);
    if Item = nil then
      Item := FRttiCompletionList.Find(Members[0]);

    if (Item <> nil) and (Item.FStartVisible < FPos.Y) and ((Item.FEndVisible > FPos.Y) or (Item.FEndVisible < 0)) then
    begin
      clName := Item.FType;
      i := 1;
      while (clName <> '') and (i < Members.Count) do
      begin
        clVar := FScript.FindClass(clName);
        clName := '';
        if clVar <> nil then
        begin
          clMethod := clVar.Find(Members[i]);
          if clMethod <> nil then
            clName := clMethod.TypeName;
          Inc(i);
        end;
      end;

      if clName <> '' then
      begin
        clVar := FScript.FindClass(clName);
        if clVar <> nil then
          GenerateClassList(FScript, FScript.FindClass(clName).ClassRef,
            FClassCompletionList);
      end;
    end;
  end;
  for i := 0 to FClassCompletionList.Count - 1 do
    aCodeCompList.AddObject(FClassCompletionList[i].FName,
      FClassCompletionList[i]);
  FreeAndNil(Members);
end;

procedure TfrxSyntaxMemo.Undo;
var
  s: String;
begin
  FMoved := True;
  if FUndo.Count = 0 then exit;
  s := FUndo[FUndo.Count - 1];
  FPos.X := StrToInt(Copy(s, 1, 5));
  FPos.Y := StrToInt(Copy(s, 6, 5));
  FAllowLinesChange := False;
  FText.Text := Copy(s, 11, Length(s) - 10);
  FAllowLinesChange := True;
  FUndo.Delete(FUndo.Count - 1);
  SetPos(FPos.X, FPos.Y);
  ClearSyntax(1);
  DoChange;
end;

function TfrxSyntaxMemo.GetPlainTextPos(Pos: TPoint): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 0 to Pos.Y - 2 do
    Result := Result + frxLength(FText[i]) + {$IFDEF FPC}Length(LineBreak){$ELSE}2{$ENDIF};
  Result := Result + Pos.X;
end;

function TfrxSyntaxMemo.GetPosPlainText(Pos: Integer): TPoint;
var
  i: Integer;
  s: String;
begin
  Result := Point(0, 1);
  s := FText.Text;
  i := 1;
  while i <= Pos do
    if frxGetSymbol(s, i) = LineBreak[1] then
    begin
      Inc(i, length(LineBreak));
      if i <= Pos then
      begin
        Inc(Result.Y);
        Result.X := 0;
      end
      else
        Inc(Result.X);
    end
    else
    begin
      Inc(i);
      Inc(Result.X);
    end;
end;

function TfrxSyntaxMemo.GetLineBegin(Index: Integer): Integer;
var
  s: String;
begin
  s := FText[Index];
  Result := 1;
  if Trim(s) <> '' then
    for Result := 1 to Length(s) do
      if s[Result] <> ' ' then
        break;
end;

procedure TfrxSyntaxMemo.TabIndent;
begin
  SelText := Pad(FTabStops - ((FPos.X - 1) mod FTabStops));
end;

procedure TfrxSyntaxMemo.EnterIndent;
var
  res: Integer;
begin
  if Trim(FText[FPos.Y - 1]) = '' then
    res := FPos.X else
    res := GetLineBegin(FPos.Y - 1);

  if FPos.X = 1 then
    CorrectBookmark(FPos.Y - 1, 1) else
    CorrectBookmark(FPos.Y, 1);

  FPos := Point(1, FPos.Y + 1);
  SelText := Pad(res - 1);
end;

procedure TfrxSyntaxMemo.UnIndent;
var
  i, res: Integer;
begin
  i := FPos.Y - 2;
  res := FPos.X - 1;
  CorrectBookmark(FPos.Y, -1);
  while i >= 0 do
  begin
    res := GetLineBegin(i);
    if (res < FPos.X) and (Trim(FText[i]) <> '') then
      break else
      Dec(i);
  end;
  FSelStart := FPos;
  FSelEnd := FPos;
  Dec(FSelEnd.X, FPos.X - res);
  SelText := '';
end;

procedure TfrxSyntaxMemo.ShiftSelected(ShiftRight: Boolean);
var
  i, ib, ie: Integer;
  s: String;
  Shift: Integer;
begin
  AddUndo;
  if FSelStart.X + FSelStart.Y * FMaxLength < FSelEnd.X + FSelEnd.Y * FMaxLength then
  begin
    ib := FSelStart.Y - 1;
    ie := FSelEnd.Y - 1;
  end
  else
  begin
    ib := FSelEnd.Y - 1;
    ie := FSelStart.Y - 1;
  end;
  if FSelEnd.X = 1 then
    Dec(ie);

  Shift := 2;
  if not ShiftRight then
    for i := ib to ie do
    begin
      s := FText[i];
      if (Trim(s) <> '') and (GetLineBegin(i) - 1 < Shift) then
        Shift := GetLineBegin(i) - 1;
    end;

  for i := ib to ie do
  begin
    s := FText[i];
    if ShiftRight then
      s := Pad(Shift) + s
    else if Trim(s) <> '' then
      frxDelete(s, 1, Shift);
    FText[i] := s;
  end;

  ClearSyntax(FSelStart.Y);
  DoChange;
end;

function TfrxSyntaxMemo.GetSelText: String;
var
  p1, p2: TPoint;
  i: Integer;
begin
  if FSelStart.X = 0 then
  begin
    Result := '';
    Exit;
  end;

  if FSelStart.X + FSelStart.Y * FMaxLength < FSelEnd.X + FSelEnd.Y * FMaxLength then
  begin
    p1 := FSelStart;
    p2 := FSelEnd;
    Dec(p2.X);
  end
  else
  begin
    p1 := FSelEnd;
    p2 := FSelStart;
    Dec(p2.X);
  end;

  if LineLength(p1.Y - 1) < p1.X then
  begin
    Inc(p1.Y);
    p1.X := 1;
  end;
  if LineLength(p2.Y - 1) < p2.X then
    p2.X := LineLength(p2.Y - 1);

  i := GetPlainTextPos(p1);
  Result := frxCopy(FText.Text, i, GetPlainTextPos(p2) - i + 1);
end;

procedure TfrxSyntaxMemo.SetSelText(const Value: String);
var
  p1, p2, p3: TPoint;
  i, k: Integer;
  s: String;
begin
  AddUndo;
  if FSelStart.X = 0 then
  begin
    p1 := FPos;
    p2 := p1;
    Dec(p2.X);
  end
  else if FSelStart.X + FSelStart.Y * FMaxLength < FSelEnd.X + FSelEnd.Y * FMaxLength then
  begin
    p1 := FSelStart;
    p2 := FSelEnd;
    Dec(p2.X);
  end
  else
  begin
    p1 := FSelEnd;
    p2 := FSelStart;
    Dec(p2.X);
  end;
  FAllowLinesChange := False;
  if LineLength(p1.Y - 1) < p1.X then
    FText[p1.Y - 1] := FText[p1.Y - 1] + Pad(p1.X - LineLength(p1.Y - 1) + 1);
  if LineLength(p2.Y - 1) < p2.X then
    p2.X := LineLength(p2.Y - 1);

  i := GetPlainTextPos(p1);
  s := FText.Text;
  k := GetPlainTextPos(p2) - i + 1;
  if K > 0 then
     frxDelete(s, i, k);
  frxInsert(Value, s, i);

  FText.Text := s;
  p3 := GetPosPlainText(i + frxLength(Value));
  FAllowLinesChange := True;
  CorrectBookmark(FPos.Y, p3.y - FPos.Y);

  SetPos(p3.X, p3.Y);
  FSelStart.X := 0;
  DoChange;
  i := p3.Y;
  if p2.Y < i then
    i := p2.Y;
  if p1.Y < i then
    i := p1.Y;
  ClearSyntax(i);
end;

procedure TfrxSyntaxMemo.ClearSel;
begin
  if FSelStart.X <> 0 then
  begin
    FSelStart := Point(0, 0);
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
  end;
end;

procedure TfrxSyntaxMemo.AddSel;
begin
  if FSelStart.X = 0 then
    FSelStart := FTempPos;
  FSelEnd := FPos;
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

procedure TfrxSyntaxMemo.SetPos(x, y: Integer);
begin
  if FMessage <> '' then
  begin
    FMessage := '';
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
  end;

  if x > FMaxLength then x := FMaxLength;
  if x < 1 then x := 1;
  if y > FText.Count then y := FText.Count;
  if y < 1 then y := 1;

  FPos := Point(x, y);
  if (FWindowSize.X = 0) or (FWindowSize.Y = 0) then exit;

  if FOffset.Y >= FText.Count then
    FOffset.Y := FText.Count - 1;

  if FPos.X > FOffset.X + FWindowSize.X then
  begin
    Inc(FOffset.X, FPos.X - (FOffset.X + FWindowSize.X));
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
  end
  else if FPos.X <= FOffset.X then
  begin
    Dec(FOffset.X, FOffset.X - FPos.X + 1);
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
  end
  else if FPos.Y > FOffset.Y + FWindowSize.Y then
  begin
    Inc(FOffset.Y, FPos.Y - (FOffset.Y + FWindowSize.Y));
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
  end
  else if FPos.Y <= FOffset.Y then
  begin
    Dec(FOffset.Y, FOffset.Y - FPos.Y + 1);
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
  end;

  ShowCaretPos;
  UpdateScrollBar;

end;

procedure TfrxSyntaxMemo.SetPosByCoords(X, Y: Integer);
begin
{$IFNDEF FPC}
  if FMultiByteLang then
    X := GetCharXPos(X - FGutterWidth)+ 1 + FOffset.X
  else
{$ENDIF}
    X := (X - FGutterWidth) div FCharWidth + 1 + FOffset.X;
  Y := Y div FCharHeight + 1 + FOffset.Y;
  FTempPos := FPos;
  SetPos(X, Y);
end;

procedure TfrxSyntaxMemo.OnHScrollChange(Sender: TObject);
begin
  FOffset.X := HorzPosition;
  if FOffset.X > 1024 then
    FOffset.X := 1024;
  ShowCaretPos;
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

procedure TfrxSyntaxMemo.OnVScrollChange(Sender: TObject);
begin
  FOffset.Y := VertPosition;
  if FOffset.Y > FText.Count then
    FOffset.Y := FText.Count;
  ShowCaretPos;
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

procedure TfrxSyntaxMemo.DblClick;
var
  s: String;
begin
  FDoubleClicked := True;
  DoCtrlL;
  FSelStart := FPos;
  s := LineAt(FPos.Y - 1);
  if s <> '' then
{$IFDEF DELPHI12}
    while CharInSet(s[FPos.X], WordChars)
      or IsUnicodeChar(s[FPos.X]) do
{$ELSE}
  {$IFDEF FPC}
    while (Length(frxGetSymbol(s, FPos.X)) >= 1) and ((frxGetSymbol(s, FPos.X)[1] in WordChars) or
          (frxGetSymbol(s, FPos.X) >= 'À') and (frxGetSymbol(s, FPos.X) <= 'ÿ')) do

  {$ELSE}
    while s[FPos.X] in WordChars do
  {$ENDIF}
{$ENDIF}
      Inc(FPos.X);
  FSelEnd := FPos;
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

procedure TfrxSyntaxMemo.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
var
  selected: Boolean;
begin
  if FDoubleClicked then
  begin
    FDoubleClicked := False;
    Exit;
  end
  else if (Button = mbRight) then
  begin
    selected := (FSelStart.X <> 0) and ((FSelStart.X <> FSelEnd.X) or (FSelStart.Y <> FSelEnd.Y));
    PopupMenu.Items[0].Enabled := selected;
    PopupMenu.Items[1].Enabled := selected;
    PopupMenu.Items[2].Enabled := Clipboard.HasFormat(CF_TEXT);
    PopupMenu.Items[3].Enabled := selected;
    Exit;
  end;

  FMoved := True;
  if not Focused then
    SetFocus;
  FDown := True;
  if X < FGutterWidth then
    FToggleBreakPointDown := True;
{$IFNDEF FPC}
  if FMultiByteLang then
    X := GetCharXPos(X - FGutterWidth)+ 1 + FOffset.X
  else
{$ENDIF}
    X := (X - FGutterWidth) div FCharWidth + 1 + FOffset.X;
  Y := Y div FCharHeight + 1 + FOffset.Y;
  FTempPos := FPos;
  SetPos(X, Y);
  if ssShift in Shift then
    AddSel
  else
    ClearSel;
end;

procedure TfrxSyntaxMemo.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  CurHintPos: TPoint;
begin
  if FDown then
  begin
    FTempPos := FPos;
    FPos := CurPosToSynPos(X, Y);
    if (FPos.X <> FTempPos.X) or (FPos.Y <> FTempPos.Y) then
    begin
      SetPos(FPos.X, FPos.Y);
      AddSel;
    end;
  end;

  if X < FGutterWidth then
    Cursor := crArrow
  else
    Cursor := crIBeam;

  CurHintPos := CurPosToSynPos(X, Y);
  if (CurHintPos.X < 1) or (CurHintPos.Y < 1) then
  begin
    Application.CancelHint;
    FLastHintPos := Point(-1, -1);
    Exit;
  end;

  CurHintPos := OffsPoint(CurHintPos);
  if ((CurHintPos.X <> FLastHintPos.X) or (CurHintPos.Y <> FLastHintPos.Y)) then
  begin
    Application.CancelHint;
    FLastHintPos := CurHintPos;
  end;
end;

procedure TfrxSyntaxMemo.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  FDown := False;
  if (X < FGutterWidth) and (FToggleBreakPointDown) then
    ToggleBreakPoint(FPos.Y, '');
  FToggleBreakPointDown := False;
end;

procedure TfrxSyntaxMemo.KeyDown(var Key: Word; Shift: TShiftState);
var
  MyKey: Boolean;
  TempPos: Tpoint;
begin
  inherited;
  FAllowLinesChange := False;

  FTempPos := FPos;
  MyKey := True;
  case Key of
    vk_Left:
      if ssCtrl in Shift then
        DoCtrlL else
        DoLeft;

    vk_Right:
      if ssCtrl in Shift then
        DoCtrlR else
        DoRight;

    vk_Up:
      DoUp;

    vk_Down:
      DoDown;

    vk_Home:
      DoHome(ssCtrl in Shift);

    vk_End:
      DoEnd(ssCtrl in Shift);

    vk_Prior:
      DoPgUp;

    vk_Next:
      DoPgDn;

    vk_Return:
      if Shift = [] then
        DoReturn;

    vk_Delete:
    begin
      if ssCtrl in Shift then // Ctrl+Del delete word before cursor
      begin
        TempPos := FPos;
        Inc(FPos.X);
        DblClick;
        FDoubleClicked := False;
        if FSelEnd.X <= TempPos.X then
        begin
          FSelStart := TempPos;
          FSelEnd := TempPos;
          dec(FSelStart.X);
        end;
      end;
      if ssShift in Shift then
        CutToClipboard else
        DoDel;
    end;

    vk_Back:
    begin
      if ssCtrl in Shift then // Ctrl+BackSpace delete word after cursor
      begin
        DblClick;
        FDoubleClicked := False;
      end;
      DoBackspace;
    end;

    vk_Insert:
      if ssCtrl in Shift then
        CopyToClipboard
      else if ssShift in Shift then
        PasteFromClipboard;

    vk_Tab:
      TabIndent;

    vk_Divide, $BF: // $BF - VK_OEM_2, missing in D7
      if (Shift = [ssCtrl]) then
        QuickComment;

  else
    MyKey := False;
  end;

  if Shift = [ssCtrl] then
  begin
    MyKey := True;
    if Key = 65 then // Ctrl+A Select all
    begin
      SelectAll;
    end
    else if Key = 89 then // Ctrl+Y Delete line
    begin
      if FText.Count > FPos.Y then
      begin
        FMoved := True;
        AddUndo;
        FText.Delete(FPos.Y - 1);
        CorrectBookmark(FPos.Y, -1);
        DoChange;
      end
      else if FText.Count = FPos.Y then
      begin
        FMoved := True;
        AddUndo;
        FText[FPos.Y - 1] := '';
        FPos.X := 1;
        SetPos(FPos.X, FPos.Y);
        DoChange;
      end;
      ClearSyntax(FPos.Y);
    end
    else if Key in [48..57] then
      GotoBookmark(Key - 48)
    else if Key = 32 then // Ctrl+Space code completion
    begin
      if Assigned(FOnCodeCompletion) then
        DoCodeCompletion;
      MyKey := True;
    end
    else if Key = Ord('C') then
    begin
      CopyToClipboard;
      MyKey := True;
    end
    else if Key = Ord('V') then
    begin
      PasteFromClipboard;
      MyKey := True;
    end
    else if Key = Ord('X') then
    begin
      CutToClipboard;
      MyKey := True;
    end
    else if Key = Ord('I') then
    begin
      DoCtrlI;
      MyKey := True;
    end
    else if Key = Ord('U') then
    begin
      DoCtrlU;
      MyKey := True;
    end
    else if Key = Ord('Z') then
    begin
      Undo;
      MyKey := True;
    end;
  end;

  if Shift = [ssCtrl, ssShift] then
  begin
    MyKey := True;
    if Key in [48..57] then
      if IsBookmark(FPos.Y - 1) < 0 then
        AddBookmark(FPos.Y - 1, Key - 48)
      else if IsBookmark(FPos.Y - 1) = (Key - 48) then
        DeleteBookmark(Key - 48);
  end;

  if Key in [vk_Left, vk_Right, vk_Up, vk_Down, vk_Home, vk_End, vk_Prior, vk_Next] then
  begin
    FMoved := True;
    if ssShift in Shift then
      AddSel else
      ClearSel;
  end
  else if Key in [vk_Return, vk_Delete, vk_Back, vk_Insert, vk_Tab] then
    FMoved := True;

  if MyKey then
    Key := 0;
end;

procedure TfrxSyntaxMemo.KeyPress(var Key: Char);
var
  MyKey, ControlKeyDown: Boolean;
begin
  inherited;

  ControlKeyDown := (((GetKeyState(VK_LCONTROL) and not $7FFF) <> 0) or
    ((GetKeyState(VK_RCONTROL) and not $7FFF) <> 0)) and
    (GetKeyState(VK_RMENU) >= 0);
  MyKey := True;

{$IFDEF DELPHI12}
  if ((Key = #32) and not ControlKeyDown) or (CharInSet(Key, [#33..#255]) and not((Key = #127) and ControlKeyDown))
    or IsUnicodeChar(Key) and not((Key = #127) and ControlKeyDown) then
{$ELSE}
  if ((Key = #32) and not ControlKeyDown) or (Key in [#33..#255]) and not((Key = #127) and ControlKeyDown) then
{$ENDIF}
  begin
    DoChar(Key);
    FMoved := False;
  end
  else
    MyKey := False;

  if MyKey then
    Key := #0;
end;

{$IFDEF FPC}
procedure TfrxSyntaxMemo.UTF8KeyPress(var UTF8Key: TUTF8Char);
begin
  {$note TODO: fix handling of UTF8 keys}
  inherited UTF8KeyPress(UTF8Key);
  SelText := String(UTF8Key);
  UTF8Key := '';
end;
{$ENDIF}

procedure TfrxSyntaxMemo.DoCodeCompletion;
var
  p: TPoint;
  s: String;
begin
  if IsCursorInStringBlock then Exit;
  FCompletionForm := TfrxPopupForm.Create(Self);
  FCompletionForm.Color := clSkyBlue;
  FCompletionForm.Resizable := True;
  FCompletionForm.OnClose := CompletionFormClose;
  FCompletionForm.Constraints.MinWidth := FCodeCompletionMinWidth;
  FCompletionForm.Constraints.MinHeight := FCodeCompletionMinHeight;
  FCodeCompList.Clear;
  FCompletionLB := TListBox.Create(FCompletionForm);
  FScriptCompletionList.Locked := True;
  with FCompletionLB do
  begin
    Parent := FCompletionForm;
{$IFNDEF FPC}
    Ctl3D := False;
{$ENDIF}
    Color := Self.Color;
{$IFDEF FPC}
    ItemHeight := 16;
    Align := alClient;
{$ELSE}
    Align := alNone;
    ItemHeight := ItemHeight + 2;
{$ENDIF}
    Style := lbOwnerDrawFixed;
    Sorted := False;
    OnDblClick := CompletionLBDblClick;
    OnKeyDown := CompletionLBKeyDown;
    OnKeyPress := CompletionLBKeyPress;
    OnDrawItem := CompletionLBDrawItem;
    s := Trim(GetCompletionString(FPos));
    FCompleationFilter := GetFilter(s);
    FStartCodeCompPos := FPos.X - Length(FCompleationFilter);
    if FCompleationFilter = s then s := '';
    FAddonCompletionList.DestroyItems;
    if Assigned(FOnCodeCompletion) and (cltAddon in FShowInCodeComplition) then
      FOnCodeCompletion(s, FAddonCompletionList);
    BuildCClist(s, FCodeCompList);
    FilterCodeListBox(FCompleationFilter, FCompletionLB, FCodeCompList, @frxSynPos);
    p := Self.ClientToScreen(
      Point(FCharWidth * (FPos.X - 1 - FOffset.X) + FGutterWidth,
            FCharHeight * (FPos.Y - FOffset.Y)));
    FCompletionForm.SetBounds(p.X, p.Y, CodeCompletionWidth, CodeCompletionHeight);
{$IFNDEF FPC}
    SetBounds(2, 2, CodeCompletionWidth - 4, CodeCompletionHeight - 4);
    Anchors := [akLeft, akTop, akRight, akBottom];
{$ENDIF}
    if FCompletionLB.Count > 0 then
      FCompletionForm.Show
    else
      CompletionClose;
  end;
end;

procedure TfrxSyntaxMemo.CompletionClose;
var
  lForm: TCustomForm;
begin
  { prevent access to FCompletionForm when form destroying }
  lForm := FCompletionForm;
  if (FCompletionForm = nil) or (csDestroying in FCompletionForm.ComponentState) then Exit;
  FCompletionForm := nil;
  FScriptCompletionList.Locked := False;
  lForm.Close;
end;

procedure TfrxSyntaxMemo.CompletionFormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FCodeCompletionWidth := TForm(Sender).Width;
  FCodeCompletionHeight := TForm(Sender).Height;
end;

procedure TfrxSyntaxMemo.CompletionLBDblClick(Sender: TObject);
var
  s, s1: String;
  i: Integer;
  stepBack: Boolean;
  Item: TfrxCompletionItem;
begin
  if FCompletionLB.ItemIndex <> -1 then
  begin
    FSelStart.X := FPos.X - frxLength(FCompleationFilter);
    FSelStart.Y := FPos.Y;
    FSelEnd.X := GetIdentEnd(FStartCodeCompPos);
    FSelEnd.Y := FPos.Y;
    s := FCompletionLB.Items[FCompletionLB.ItemIndex];
    Item := TfrxCompletionItem(FCompletionLB.Items.Objects[FCompletionLB.ItemIndex]);
    i := 2;
{$IFDEF DELPHI12}
    while (i <= Length(s)) and ((CharInSet(s[i], WordChars) or IsUnicodeChar(s[i]))) do
{$ELSE}
    while (i <= frxLength(s)) and
      (frxGetSymbol(s, i) {$IFDEF FPC}[1]{$ENDIF} in WordChars)
       {$IFDEF FPC} or (Length(frxGetSymbol(s, i)) > 1){$ENDIF}do
{$ENDIF}
      Inc(i);
    s1 := frxCopy(s, 1, i - 1);
    stepBack := (i <= frxLength(s)) and (frxGetSymbol(s, i) = '(');
    if stepBack then
      s1 := s1 + '()';
    SelText := s1;
    s1 := '';
    if stepBack then
    begin
      DoLeft;
      if Item.FParams <> '' then
        s1 := 'Parameters: (' + Item.FParams + ')  ';
    end;
    if Item.FType <> '' then
        s1 := s1 + 'Type: ' + Item.FType;
    if s1 <> '' then
      ShowMessage(s1)
  end;
  CompletionClose;
  FCompleationFilter := '';
end;

procedure TfrxSyntaxMemo.CompletionLBKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  oldKey: Char;
begin
  oldKey := Char(Key);
  if Key = VK_ESCAPE then
    CompletionClose
  else if (Key = VK_RETURN) or (key = 190) then
    CompletionLBDblClick(nil)
  else if not((Integer(Key) >= 0) and (Integer(Key) <= 48))
          or (((Integer(Key) = VK_BACK) or (Integer(Key) = VK_LEFT)) and (FPos.X > FStartCodeCompPos))
          or ((Integer(Key) = VK_RIGHT) and (FPos.X  < GetIdentEnd(FStartCodeCompPos))) then
    KeyDown(Key, Shift);
  { update code compleation }
  if (Integer(oldKey) = VK_LEFT) or (Integer(oldKey) = VK_RIGHT) then
    CompletionLBKeyPress(Sender, oldKey);
end;

procedure TfrxSyntaxMemo.CompletionLBKeyPress(Sender: TObject; var Key: Char);
var
  bLeftRightKey: Boolean;
begin
  bLeftRightKey := (Key = Char(VK_LEFT)) or (Key = Char(VK_RIGHT));
  if (Key >= #0) and (Key <= #48) and not((Key = Char(VK_BACK)) or bLeftRightKey) then Exit;
  if not bLeftRightKey then
    KeyPress(Key);
  FCompleationFilter := Trim(GetFilter(GetCompletionString(FPos)));
  FilterCodeListBox(FCompleationFilter, FCompletionLB, FCodeCompList, @frxSynPos);
end;

procedure TfrxSyntaxMemo.CompletionLBDrawItem(Control: TWinControl; Index: Integer;
  ARect: TRect; State: TOwnerDrawState);
var
  i, w: Integer;
  s: String;
  Item: TfrxCompletionItem;
begin
  with FCompletionLB.Canvas do
  begin
    FillRect(ARect);
    if Index <> -1 then
    begin
      Item := TfrxCompletionItem(FCompletionLB.Items.Objects[Index]);
      s := '';
      Font.Color := FCommentAttr.Color;
      if Pos('Constructor', FCompletionLB.Items[Index]) <> 0 then
        s := 'constructor'
      else
        Font.Color := ItemToPrefix(Item, s, Font.Color);
      if odSelected in State then
        Font.Color := FBlockFontColor;
      if Item.ItemType in [itVar] then
        Font.Style := [fsBold]
      else
        Font.Style := [];
      TextOut(ARect.Left + 2, ARect.Top + 2, s);
      w := TextWidth('constructor ');
      Font.Color := FKeywordAttr.Color;

      if odSelected in State then
        Font.Color := FBlockFontColor;
      Font.Style := [fsBold];
      s := FCompletionLB.Items[Index];
      i := 1;
{$IFDEF DELPHI12}
      while (i <= Length(s)) and ((CharInSet(s[i], WordChars))
       or IsUnicodeChar(s[i])) do
{$ELSE}
      while (i <= frxLength(s)) and
        (frxGetSymbol(s, i){$IFDEF FPC}[1]{$ENDIF} in WordChars)
        {$IFDEF FPC} or (Length(frxGetSymbol(s, i)) > 1){$ENDIF}do
{$ENDIF}
        Inc(i);
      s := frxCopy(s, 1, i - 1);
      TextOut(ARect.Left + w + 6, ARect.Top + 2, s);
      w := w + TextWidth(s);
      Font.Style := [];
      s := Copy(FCompletionLB.Items[Index], i, 255);
      if Pos(': Constructor', s) <> 0 then
        s := Copy(s, 1, Pos(': Constructor', s) - 1);
      TextOut(ARect.Left + w + 6, ARect.Top + 2, s);
    end;
  end;
end;

function TfrxSyntaxMemo.ItemToPrefix(Item: TfrxCompletionItem; var pref: String; c: TColor = clNone): TColor;
begin
  Result := c;
  case Item.FItemType of
    itVar: begin pref := 'var'; Result := FStringAttr.Color; end;
    itProperty, itIndex: begin pref := 'property'; Result := FStringAttr.Color; end;
    itProcedure: pref := 'procedure';
    itFunction: pref := 'function';
    itConstant: pref := 'constant';
    itConstructor: pref:= 'constructor';
    itType: begin pref := 'type'; Result := FTextAttr.Color; end;
    itEvent: begin pref := 'event'; Result := FCommentAttr.Color; end;
  end;
end;

procedure TfrxSyntaxMemo.DoLeft;
begin
  Dec(FPos.X);
  if FPos.X < 1 then
    FPos.X := 1;
  SetPos(FPos.X, FPos.Y);
end;

procedure TfrxSyntaxMemo.DoRight;
begin
  Inc(FPos.X);
  if FPos.X > FMaxLength then
    FPos.X := FMaxLength;
  SetPos(FPos.X, FPos.Y);
end;

procedure TfrxSyntaxMemo.DoTimer(Sender: TObject);
begin
  FTimer.Enabled := False;
  if csDestroying in ComponentState then Exit;
  FCodeCompletionThread.FMemoHandle := Handle;
  FCodeCompletionThread.Script := FScript;
  FCodeCompletionThread.FSyntaxType := Syntax;
  if FCodeCompletionThread.Suspended then
    FCodeCompletionThread.Resume;
end;

procedure TfrxSyntaxMemo.DoUp;
begin
  Dec(FPos.Y);
  if FPos.Y < 1 then
    FPos.Y := 1;
  SetPos(FPos.X, FPos.Y);
end;

procedure TfrxSyntaxMemo.DoDown;
begin
  Inc(FPos.Y);
  if FPos.Y > FText.Count then
    FPos.Y := FText.Count;
  SetPos(FPos.X, FPos.Y);
end;

procedure TfrxSyntaxMemo.DoHome(Ctrl: Boolean);
begin
  if Ctrl then
    SetPos(1, 1) else
    SetPos(1, FPos.Y);
end;

procedure TfrxSyntaxMemo.DoEnd(Ctrl: Boolean);
begin
  if Ctrl then
    SetPos(LineLength(FText.Count - 1) + 1, FText.Count) else
    SetPos(LineLength(FPos.Y - 1) + 1, FPos.Y);
end;

procedure TfrxSyntaxMemo.DoPgUp;
begin
  if FOffset.Y > FWindowSize.Y then
  begin
    Dec(FOffset.Y, FWindowSize.Y - 1);
    Dec(FPos.Y, FWindowSize.Y - 1);
  end
  else
  begin
    if FOffset.Y > 0 then
    begin
      Dec(FPos.Y, FOffset.Y);
      FOffset.Y := 0;
    end
    else
      FPos.Y := 1;
  end;
  SetPos(FPos.X, FPos.Y);
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

procedure TfrxSyntaxMemo.DoPPIChanged(aNewPPI: Integer);
begin
  inherited;
  FGutterWidth := MulDiv(FGutterWidth, aNewPPI, FfrCurrentPPI);
  Font.PixelsPerInch := aNewPPI;
  FCommentAttr.PixelsPerInch := aNewPPI;
  FKeywordAttr.PixelsPerInch := aNewPPI;
  FNumberAttr.PixelsPerInch := aNewPPI;
  FStringAttr.PixelsPerInch := aNewPPI;
  FTextAttr.PixelsPerInch := aNewPPI;
end;

procedure TfrxSyntaxMemo.DoPgDn;
begin
  if FOffset.Y + FWindowSize.Y < FText.Count then
  begin
    Inc(FOffset.Y, FWindowSize.Y - 1);
    Inc(FPos.Y, FWindowSize.Y - 1);
  end
  else
  begin
    FOffset.Y := FText.Count;
    FPos.Y := FText.Count;
  end;
  SetPos(FPos.X, FPos.Y);
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

procedure TfrxSyntaxMemo.DoReturn;
var
  s: String;
begin
  s := LineAt(FPos.Y - 1);
  FText[FPos.Y - 1] := frxCopy(s, 1, FPos.X - 1);
  FText.Insert(FPos.Y, frxCopy(s, FPos.X, FMaxLength));
  EnterIndent;
end;

procedure TfrxSyntaxMemo.DoDel;
var
  s: String;
begin
  FMessage := '';
  if FSelStart.X <> 0 then
    SelText := ''
  else
  begin
    s := FText[FPos.Y - 1];
    AddUndo;
    if FPos.X <= LineLength(FPos.Y - 1) then
    begin
      frxDelete(s, FPos.X, 1);
      FText[FPos.Y - 1] := s;
    end
    else if FPos.Y < FText.Count then
    begin
      s := s + Pad(FPos.X - frxLength(s) - 1) + LineAt(FPos.Y);
      FText[FPos.Y - 1] := s;
      FText.Delete(FPos.Y);
      CorrectBookmark(FPos.Y, -1);
    end;
    UpdateScrollBar;
    ClearSyntax(FPos.Y);
    DoChange;
  end;
end;

procedure TfrxSyntaxMemo.DoBackspace;
var
  s: String;
begin
  FMessage := '';
  if FSelStart.X <> 0 then
    SelText := ''
  else
  begin
    s := FText[FPos.Y - 1];
    if FPos.X > 1 then
    begin
      if (GetLineBegin(FPos.Y - 1) = FPos.X) or (Trim(s) = '') then
        UnIndent
      else
      begin
        AddUndo;
        if Trim(s) <> '' then
        begin
          frxDelete(s, FPos.X - 1, 1);
          FText[FPos.Y - 1] := s;
          DoLeft;
        end
        else
          DoHome(False);
        ClearSyntax(FPos.Y);
        DoChange;
      end;
    end
    else if FPos.Y > 1 then
    begin
      AddUndo;
      CorrectBookmark(FPos.Y, -1);
      s := LineAt(FPos.Y - 2);
      FText[FPos.Y - 2] := s + FText[FPos.Y - 1];
      FText.Delete(FPos.Y - 1);
      SetPos(Length(s) + 1, FPos.Y - 1);
      ClearSyntax(FPos.Y);
      DoChange;
    end;
  end;
end;

procedure TfrxSyntaxMemo.DoCtrlI;
begin
  if FSelStart.X <> 0 then
    ShiftSelected(True);
end;

procedure TfrxSyntaxMemo.DoCtrlU;
begin
  if FSelStart.X <> 0 then
    ShiftSelected(False);
end;

procedure TfrxSyntaxMemo.DoCtrlL;
var
  i: Integer;
  s: String;
begin
  s := FText.Text;
  i := frxLength(LineAt(FPos.Y - 1));
  if FPos.X > i then
    FPos.X := i;

  i := GetPlainTextPos(FPos);

  Dec(i);
{$IFDEF DELPHI12}
  while (i > 0) and not ((CharInSet(s[i], WordChars))
    or IsUnicodeChar(s[i])) do
{$ELSE}
  while (i > 0) and not (frxGetSymbol(s, i){$IFDEF FPC}[1]{$ENDIF} in WordChars)
  {$IFDEF FPC}or (Length(frxGetSymbol(s, i)) > 1){$ENDIF}do
{$ENDIF}
    if frxGetSymbol(s, i) = LineBreak[1] then
      break else
      Dec(i);
{$IFDEF DELPHI12}
  while (i > 0) and ((CharInSet(s[i], WordChars))
    or IsUnicodeChar(s[i])) do
{$ELSE}
  while (i > 0) and (frxGetSymbol(s, i){$IFDEF FPC}[1]{$ENDIF}  in WordChars)
  {$IFDEF FPC}or (Length(frxGetSymbol(s, i)) > 1){$ENDIF}do
{$ENDIF}
    Dec(i);
  Inc(i);

  FPos := GetPosPlainText(i);
  SetPos(FPos.X, FPos.Y);
end;

procedure TfrxSyntaxMemo.DoCtrlR;
var
  i: Integer;
  s: String;
begin
  s := FText.Text;
  i := Length(LineAt(FPos.Y - 1));
  if FPos.X > i then
  begin
    DoDown;
    DoHome(False);
    FPos.X := 1;
    Exit;
  end;

  i := GetPlainTextPos(FPos);

{$IFDEF DELPHI12}
  while (i < Length(s)) and ((CharInSet(s[i], WordChars))
     or IsUnicodeChar(s[i])) do
{$ELSE}
  while (i < frxLength(s)) and (frxGetSymbol(s, i){$IFDEF FPC}[1]{$ENDIF}  in WordChars)
  {$IFDEF FPC}or (Length(frxGetSymbol(s, i)) > 1){$ENDIF}do
{$ENDIF}
    Inc(i);
{$IFDEF DELPHI12}
  while (i < Length(s)) and not ((CharInSet(s[i], WordChars))
    or IsUnicodeChar(s[i])) do
{$ELSE}
  while (i < frxLength(s)) and not (frxGetSymbol(s, i){$IFDEF FPC}[1]{$ENDIF}  in WordChars)
  {$IFDEF FPC}or (Length(frxGetSymbol(s, 1)) > 1){$ENDIF}do
{$ENDIF}
    if frxGetSymbol(s, i) = LineBreak[1] then
    begin
      while (i > 1) and (frxGetSymbol(s, i - 1) = ' ') do
        Dec(i);
      break;
    end
    else
      Inc(i);

  FPos := GetPosPlainText(i);
  SetPos(FPos.X, FPos.Y);
end;

procedure TfrxSyntaxMemo.DoChar(Ch: Char);
begin
  SelText := Ch;
end;

function TfrxSyntaxMemo.GetCharAttr(Pos: TPoint): TfrxCharAttributes;

  function IsBlock: Boolean;
  var
    p1, p2, p3: Integer;
  begin
    Result := False;
    if FSelStart.X = 0 then Exit;

    p1 := FSelStart.X + FSelStart.Y * FMaxLength;
    p2 := FSelEnd.X + FSelEnd.Y * FMaxLength;
    if p1 > p2 then
    begin
      p3 := p1;
      p1 := p2;
      p2 := p3;
    end;
    p3 := Pos.X + Pos.Y * FMaxLength;
    Result := (p3 >= p1) and (p3 < p2);
  end;

  function CharAttr: Byte;
  var
    s: TfrxByteArr;
  begin
    SetLength(s, 0);
    if Pos.Y - 1 < FSynAttributes.Count then
    begin
      s := FSynAttributes[Pos.Y - 1];
      if Pos.X <= Length(s) then
        Result := s[Pos.X - 1] else
        Result := Ord(caText);
    end
    else
      Result := Ord(caText);
  end;

begin
  Result.StyleIndex := CharAttr;
  Result.IsSelBlock := IsBlock;
end;

function TfrxSyntaxMemo.GetCompletionString(Pos: TPoint): String;
  var
    i: Integer;
    s: String;
    fl1, fl2: Boolean;
    fl3, fl4: Integer;
  begin
    Result := '';
    s := LineAt(Pos.Y - 1, False);
    s := frxCopy(s, 1, Pos.X - 1);

    fl1 := False;
    fl2 := False;
    fl3 := 0;
    fl4 := 0;

    i := frxLength(s);
    while i >= 1 do
    begin
      if (frxGetSymbol(s, i) = ' ') then break
      else if (frxGetSymbol(s, i) = '''') and not fl2 then
        fl1 := not fl1
      else if (frxGetSymbol(s, i) = '"') and not fl1 then
        fl2 := not fl2
      else if not fl1 and not fl2 and
        (frxGetSymbol(s, i) = ')') then
        Inc(fl3)
      else if not fl1 and not fl2 and
        ((frxGetSymbol(s, i) = '(') or (frxGetSymbol(s, i) = ' ')) and (fl3 > 0) then
        Dec(fl3)
      else if not fl1 and not fl2 and
        (frxGetSymbol(s, i) = ']') then
        Inc(fl4)
      else if not fl1 and not fl2 and
        (frxGetSymbol(s, i) = '[') and (fl4 > 0) then
        Dec(fl4)
      else if not fl1 and not fl2 and (fl3 = 0) and (fl4 = 0) then
{$IFDEF DELPHI12}
        if CharInSet(s[i], ['A'..'Z', 'a'..'z', '0'..'9', '_', '.', ' '])
        or IsUnicodeChar(s[i]) then
{$ELSE}
        if frxGetSymbol(s, i){$IFDEF FPC}[1]{$ENDIF}
          in ['A'..'Z', 'a'..'z', '0'..'9', '_', '.', ' '] then
{$ENDIF}
          Result := s[i] + Result
        else
          break;
      Dec(i);
    end;
  end;

function TfrxSyntaxMemo.GetFilter(aStr: String): String;
var
  i: Integer;
begin
  Result := aStr;
  for i := Length(aStr) downto 1 do
    if aStr[i] = '.' then
    begin
      Result := Copy(aStr, i + 1, Length(aStr) - i);
      break;
    end;
end;

{$IFNDEF FPC}
function TfrxSyntaxMemo.GetCharWidth(const Str: String): Integer;
begin
  with FTmpCanvas.Canvas do
  begin
    Font.Assign(Self.Font);
    Result := TextWidth(Str);
  end;
end;

function TfrxSyntaxMemo.GetCharXPos(X: Integer): Integer;
var
  s, s2: String;
  i: Integer;
begin
  s := LineAt(FPos.Y - 1);
  s2 := '';
  Result := 0;
  for i := FOffset.X + 1 to Length(s) do
  begin
    s2 := s2 + s[i];
    if GetCharWidth(s2) >= x then
    begin
      Result := i;
      Exit;
    end;
  end;
end;
{$ENDIF}

procedure TfrxSyntaxMemo.Paint;
var
  i, j, j1: Integer;
  a, a1: TfrxCharAttributes;
  s: String;

  procedure SetAttr(a: TfrxCharAttributes; ALine: Integer);
  var
    Attr: TCharAttr;
    style: TfrxAttributeStyle;
  begin
    style := nil;
    with Canvas do
    begin
      Brush.Color := Color;
      if a.StyleIndex <= ReservedStylesCount then
        Attr := TCharAttr(a.StyleIndex)
      else
      begin
        style := AttributeStyles.GetStyleByID(a.StyleIndex);
        Attr := style.AttrType;
      end;

      case Attr of
        caNo: ;
        caText: Font.Assign(FTextAttr);
        caComment: Font.Assign(FCommentAttr);
        caKeyword: Font.Assign(FKeywordAttr);
        caString: Font.Assign(FStringAttr);
        caNumber: Font.Assign(FNumberAttr);
      end;
      if Assigned(style) then
        AttributeStyles.AssignStyle(style, Font);

      if a.IsSelBlock or (ALine = FActiveLine - 1) then
      begin
        Brush.Color := FBlockColor;
        Font.Color := FBlockFontColor;
      end;

      Font.Charset := Self.Font.Charset;
    end;
  end;

  procedure MyTextOut(x, y: Integer; const s: String);
  var
    i: Integer;
  begin
    if FIsMonoType then
    begin
      Canvas.FillRect(Rect(x, y, x + frxLength(s) * FCharWidth, y + FCharHeight));
      Canvas.TextOut(x, y, s)
    end
    else
    with Canvas do
    begin
      FillRect(Rect(x, y, x + frxLength(s) * FCharWidth, y + FCharHeight));
      if FMultiByteLang then
        Canvas.TextOut(x, y, s)
      else
      begin
        for i := 1 to frxLength(s) do
          TextOut(x + (i - 1) * FCharWidth, y, frxGetSymbol(s, i));
        MoveTo(x + frxLength(s) * FCharWidth, y);
      end;
    end;
  end;

  procedure DrawLineMarks(ALine, Y: Integer);
  var
    s: String;
    tw, defGW, h: Integer;
  begin
    if not FShowGutter then Exit;
    Canvas.Brush.Color := clSkyBlue;
    Canvas.Pen.Color := clSkyBlue;
    h := MulDiv(4, FfrCurrentPPI, 96);
    Canvas.Ellipse(6, Y + 8, 6 + h, Y + 8 + h);
    if ((ALine + 1) mod 5 = 0) and FShowLineNumber then
    begin
      Canvas.Brush.Color := clBtnFace;
      Canvas.Font.Name := 'Tahoma';
      Canvas.Font.Color := clSkyBlue;
      Canvas.Font.Style := [];
      Canvas.Font.Size := 8;
      Canvas.Font.Height := MulDiv(Canvas.Font.Height, FfrCurrentPPI, Canvas.Font.PixelsPerInch);
      s := IntToStr(ALine + 1);
      Canvas.TextOut(4, Y + 2, s);
      tw := Canvas.TextWidth(s) + 10;
      defGW := MulDiv(DefGutterWidth, FfrCurrentPPI, 96);
      if FGutterWidth < tw then
        FGutterWidth := Canvas.TextWidth(s) + 10
      else if tw <= defGW then
        FGutterWidth := defGW;
    end;
    if IsBookmark(ALine) >= 0 then
      with Canvas do
      begin
        Font.Name := 'Tahoma';
        Font.Color := clWhite;
        Font.Style := [fsBold];
        Font.Size := 7;
        Canvas.Font.Height := MulDiv(Canvas.Font.Height, FfrCurrentPPI, Canvas.Font.PixelsPerInch);
        tw := MulDiv(10, FfrCurrentPPI, 96);
        h := MulDiv(11, FfrCurrentPPI, 96);
        Brush.Color := clBlack;
        FillRect(Rect(13, Y + 3, 13 + tw, Y + 3 + h));
        Brush.Color := clGreen;
        FillRect(Rect(12, Y + 4, 12 + tw, Y + 4 + h));
        TextOut(14, Y + 4, IntToStr(IsBookmark(ALine)));
      end;
    if RunLine[ALine + 1] then
      with Canvas do
      begin
        Brush.Color := clBlue;
        Pen.Color := clBlack;
        h := MulDiv(4, FfrCurrentPPI, 96);
        Ellipse(4, Y + 7, 4 + h, Y + 7 + h);
        Pixels[5, Y + 7] := clAqua;
        Pixels[4, Y + 8] := clAqua;
      end;
    if IsBreakPoint(ALine + 1) then
      with Canvas do
      begin
        if IsActiveBreakPoint(ALine + 1) then
        begin
          Brush.Color := clRed;
          Pen.Color := clRed;
        end
        else
        begin
          Brush.Color := clGray;
          Pen.Color := clBlack;
        end;
        h := MulDiv(11, FfrCurrentPPI, 96);
        Ellipse(2, Y + 4, 2 + h, Y + 4 + h);
      end;
  end;

begin
  inherited;
  Canvas.Font.PixelsPerInch := Font.PixelsPerInch;
  with Canvas do
  begin
    Brush.Color := clBtnFace;
    FillRect(Rect(0, 0, FGutterWidth - 2, Height));
    Pen.Color := clBtnHighlight;
    MoveTo(FGutterWidth - 4, 0);
    LineTo(FGutterWidth - 4, Height + 1);

    if FSynAttributes.Updating then Exit;
    CreateSynArray(FOffset.Y + FWindowSize.Y - 1);

    for i := FOffset.Y to FOffset.Y + FWindowSize.Y - 1 do
    begin
      if i >= FText.Count then break;

      s := FText[i];
      PenPos := Point(FGutterWidth, (i - FOffset.Y) * FCharHeight);
      j1 := FOffset.X + 1;
      a := GetCharAttr(Point(j1, i + 1));

      for j := j1 to FOffset.X + FWindowSize.X do
      begin
        if j > Length(s) then break;

        a1 := GetCharAttr(Point(j, i + 1));
        if (a1.IsSelBlock <> a.IsSelBlock) or (a.StyleIndex <> a1.StyleIndex) then
        begin
          SetAttr(a, i);
          MyTextOut(PenPos.X, PenPos.Y, Copy(FText[i], j1, j - j1));
          a := a1;
          j1 := j;
        end;
      end;

      SetAttr(a, i);
      MyTextOut(PenPos.X, PenPos.Y, Copy(s, j1, FMaxLength));
      if (GetCharAttr(Point(1, i + 1)).IsSelBlock) or (i = FActiveLine - 1) then
        MyTextOut(PenPos.X, PenPos.Y, Pad(FWindowSize.X - Length(s) - FOffset.X + 3));

      DrawLineMarks(i, PenPos.Y);
    end;

    if FMessage <> '' then
    begin
      Font.Name := 'Tahoma';
      Font.Color := clWhite;
      Font.Style := [fsBold];
      Font.Size := 8;
      Brush.Color := clMaroon;
      FillRect(Rect(0, ClientHeight - TextHeight('|') - 6, ClientWidth, ClientHeight));
      TextOut(6, ClientHeight - TextHeight('|') - 5, FMessage);
    end;
    {$IFDEF NONWINFPC}
    if Visible and HandleAllocated and FCaretCreated then
    begin
      SetCaretPos(FCharWidth * (FPos.X - 1 - FOffset.X) + FGutterWidth,
      FCharHeight * (FPos.Y - 1 - FOffset.Y));
      {$IFDEF LCLGTK2}
      ShowCaret(Self.Handle);
      {$ENDIF}
    end;
    {$ENDIF}
  end;
end;

procedure TfrxSyntaxMemo.ClearSyntax(ClearFrom: Integer);
begin
  Dec(ClearFrom);
  if ClearFrom < 1 then
    ClearFrom := 1;
  //FUpdatingSyntax := True;
  while FSynAttributes.Count > ClearFrom - 1 do
    FSynAttributes.Delete(FSynAttributes.Count - 1);
  //FUpdatingSyntax := False;
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

procedure TfrxSyntaxMemo.CreateSynArray(EndLine: Integer);
begin
  if EndLine >= FText.Count then
    EndLine := FText.Count - 1;
  if EndLine <= FSynAttributes.Count - 1 then Exit;
  FAllowLinesChange := False;
  FParser.Text := FText.Text;
  try
    FSynAttributes.UpdateSyntax(EndLine, FText);
  finally
    FAllowLinesChange := True;
  end;
end;

procedure TfrxSyntaxMemo.UpdateView;
begin
  Invalidate;
end;

procedure TfrxSyntaxMemo.MouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  VertPosition := VertPosition - SmallChange;
end;

procedure TfrxSyntaxMemo.MouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  VertPosition := VertPosition + SmallChange;
end;

procedure TfrxSyntaxMemo.SetShowGutter(Value: Boolean);
begin
  FShowGutter := Value;
  if Value then
    FGutterWidth := MulDiv(DefGutterWidth, FfrCurrentPPI, 96) else
    FGutterWidth := 0;
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

procedure TfrxSyntaxMemo.SetShowInCodeComplition(
  const Value: TfrxCompletionListTypes);
begin
  FShowInCodeComplition := Value;
  if cltRtti in Value then
    FillRtti
  else
    FRttiCompletionList.DestroyItems;
end;

function TfrxSyntaxMemo.IsBookmark(Line: Integer): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to 9 do
    if FBookmarks[i] = Line then
    begin
      Result := i;
      break;
    end;
end;

procedure TfrxSyntaxMemo.AddBookmark(Line, Number: Integer);
begin
  if Number < Length(FBookmarks) then
  begin
    FBookmarks[Number] := Line;
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
  end;
end;

procedure TfrxSyntaxMemo.DeleteBookmark(Number: Integer);
begin
  if Number < Length(FBookmarks) then
  begin
    FBookmarks[Number] := -1;
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
  end;
end;

procedure TfrxSyntaxMemo.CorrectBookmark(Line, Delta: Integer);
var
  i: Integer;
begin
  if Delta = 0 then exit;
  CorrectBreakPoints(Line, Delta);
  for i := 0 to Length(FBookmarks) - 1 do
    if FBookmarks[i] >= Line then
      Inc(FBookmarks[i], Delta);
end;

procedure TfrxSyntaxMemo.GotoBookmark(Number : Integer);
begin
  if Number < Length(FBookmarks) then
    if FBookmarks[Number] >= 0 then
      SetPos(0, FBookmarks[Number] + 1);
end;

function TfrxSyntaxMemo.GetRunLine(Index: Integer): Boolean;
begin
  if (Index < 1) or (Index > FText.Count) then
    Result := False else
    Result := FText.Objects[Index - 1] = Pointer(1);
end;

procedure TfrxSyntaxMemo.SetRunLine(Index: Integer; const Value: Boolean);
begin
  if (Index < 1) or (Index > FText.Count) then Exit;
  if Value then
    FText.Objects[Index - 1] := Pointer(1) else
    FText.Objects[Index - 1] := Pointer(0);
end;

procedure TfrxSyntaxMemo.FillRtti;
var
  i, j: Integer;
  Params: String;
  v: TfsCustomVariable;
begin
 if not(cltRtti in FShowInCodeComplition) or (FRttiCompletionList.Count > 0) then Exit;
 for i := 0 to FScript.Count - 1 do
  begin
    v := FScript.Items[i];
    if v is TfsVariable then
    begin
      if v.Typ = fvtEnum then continue;
      if v.IsReadOnly then
          FRttiCompletionList.AddConstant(v.Name, v.TypeName) else
          FRttiCompletionList.AddVariable(v.Name, v.TypeName);
    end
    else if v is TfsClassVariable then
    begin
      FRttiCompletionList.AddClass(v.Name, v.TypeName);
    end
    else if v is TfsMethodHelper then
    begin
    Params := '';

      for j:= 0 to v.Count - 1 do
      begin
        if j > 0 then
          Params := Params + ';';
        Params := Params + v.Params[j].Name + ': ' + v.Params
          [j].TypeName;
      end;
      FRttiCompletionList.AddFunction(TfsMethodHelper(v).Name, TfsMethodHelper(v).TypeName, Params);
    end;
  end;
end;

function TfrxSyntaxMemo.Find(const SearchText: String;
  CaseSensitive: Boolean; var SearchFrom: Integer): Boolean;
var
  i: Integer;
  s: String;
begin
  i := 0;
  Result := False;
  if FText.Count > 1 then
  begin
    s := FText.Text;
    if SearchFrom = 0 then
      SearchFrom := 1;
    s := frxCopy(s, SearchFrom, frxLength(s) - SearchFrom + 1);
    if CaseSensitive then
    begin
      i := frxPos(SearchText, s);
      if i <> 0 then
        Result := True;
    end
    else
    begin
      i := frxPos(frxUpperCase(SearchText), frxUpperCase(s));
      if i <> 0 then
        Result := True;
    end;
  end;

  if Result then
  begin
    Inc(SearchFrom, i);
    FSelStart := GetPosPlainText(SearchFrom - 1);
    FSelEnd := Point(FSelStart.X + frxLength(SearchText), FSelStart.Y);
    Inc(SearchFrom, frxLength(SearchText));
    SetPos(FSelStart.X, FSelStart.Y);
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
  end;
end;

procedure TfrxSyntaxMemo.AddBreakPoint(Number: Integer; const Condition: String; const Special: String);
var
  bp: TfrxBreakPoint;
begin
  if (Number = -1) or (Number >= Lines.Count) or IsBreakPoint(Number) or (LineAt(Number - 1) = '') then Exit;
  bp := TfrxBreakPoint.Create;
  bp.FLine := Number;
  bp.Condition := Condition;
  bp.SpecialCondition := Special;
  bp.FEnabled := True;
  FBreakPoints.AddObject(IntToStr(Number), bp);
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

procedure TfrxSyntaxMemo.ToggleBreakPoint(Number: Integer; const Condition: String);
begin
  if IsBreakPoint(Number) then
    DeleteBreakPoint(Number)
  else
    AddBreakPoint(Number, Condition, '');
end;

procedure TfrxSyntaxMemo.DeleteBreakPoint(Number: Integer);
var
  i: Integer;
begin
  i := FBreakPoints.IndexOf(IntToStr(Number));
  if i <> -1 then
  begin
    TObject(FBreakPoints.Objects[i]).Free;
    FBreakPoints.Delete(i);
  end;
{$IFDEF FPC}
      frxUpdateControl(Self);
{$ELSE}
      Repaint;
{$ENDIF}
end;

function TfrxSyntaxMemo.IsBreakPoint(Number: Integer): Boolean;
begin
  Result := FBreakPoints.IndexOf(IntToStr(Number)) <> -1;
end;

function TfrxSyntaxMemo.IsCursorInStringBlock: Boolean;
var
  s: String;
  i, sPos: Integer;
begin
  Result := False;
  s := LineAt(FPos.Y - 1);
  if Length(s) >= FPos.X then
  begin
    sPos := 1;
    for i := FPos.X downto 1 do
      if (s[i] = FParser.StringQuotes[1]) or (s[i] = FParser.StringQuotes[2]) then
      begin
        sPos := i;
        break;
      end;
    FParser.Text := s;
    FParser.Position := sPos;
    Result := (FParser.GetString <> '');
  end;
end;

function TfrxSyntaxMemo.GetAttributeStyles: TfrxAttributeStyles;
begin
  Result := FSynDialectStyles.ActiveStyles;
end;

procedure TfrxSyntaxMemo.QuickComment;
var
  singleLine, selected: Boolean;
  i, y, x, x1, y1: Integer;
  commenting: Boolean;
  s: String;
  CL1: String;
  CL1L, buf: Integer;

  procedure swap;
  var
    bp: TPoint;
  begin
    bp := Self.SelStart;
    Self.SelStart := Self.SelEnd;
    Self.SelEnd := bp;
  end;

begin
  //check Dialect
  CL1 := FParser.CommentLine1;
  CL1L := Length(CL1);
  if CL1L < 1 then
    Exit;

  //Add undo
  FMoved := True;
  AddUndo;

  //swap if need
  if (Self.SelStart.Y > Self.SelEnd.Y) then
    swap
  else
    if (Self.SelStart.Y = Self.SelEnd.Y) then
      if Self.SelStart.X > Self.SelEnd.X then
        swap;

  //initialization
  if (((Self.SelStart.X = 0) and (Self.SelStart.Y = 0))
    or ((Self.SelEnd.X = 0) and (Self.SelEnd.Y = 0))) then
  begin
    singleLine := True;
    selected := False;
  end
  else
  begin
    singleLine := Self.SelStart.Y = Self.SelEnd.Y;
    selected := not singleLine or (Self.SelStart.X <> Self.SelEnd.X);
  end;
  commenting := singleLine;
  if (selected) then
  begin
    x := Self.SelStart.X;
    y := Self.SelStart.Y;
    x1 := Self.SelEnd.X;
    y1 := Self.SelEnd.Y;
  end
  else
  begin
    x := Self.GetPos.X;
    y := Self.GetPos.Y;
    x1 := x;
    y1 := y;
  end;

  //analyze "comment or uncomment"
  if singleLine then
  begin
    s := Self.FText[y - 1];
    for i := 1 to Length(s) do
    begin
      if s[i] = CL1[1] then
      begin
        commenting := (Pos(CL1, S) <> i);
        break;
      end
      else
      if (s[i] <> ' ') then
      begin
        commenting := True;
        break;
      end;
    end;
  end
  else
  begin
    for i := y to y1 do
    begin
      s := Self.FText[i - 1];
      if (Length(s) < CL1L) then
      begin
        commenting := True;
        break;
      end
      else
        if (Pos(CL1, S) <> 1) then
        begin
          commenting := True;
          break;
        end;
    end;
  end;

  //change text
  for i := y to y1 do
  begin
    s := Self.FText[i - 1];
    if commenting then
      s := CL1 + s
    else
    begin
      if singleLine then
        buf := Pos(CL1, S)
      else
        buf := 1;
      Delete(s, buf, CL1L);
    end;
    Self.FText[i - 1] := s;
  end;

  //change car
  if ((singleLine) and (not selected)) then
      Self.SetPos(x, y + 1)
  else
  begin
    if singleLine then
      x := 1;
    Self.SelStart := Point(x, y);
    Self.SelEnd := Point(x1, y1);
    Self.SetPos(x1, y1);
  end;

  //Repaint
  DoChange;
  ClearSyntax(y);
end;

function TfrxSyntaxMemo.GetBreakPointCondition(Number: Integer): String;
var
  i: Integer;
begin
  Result := '';
  i := FBreakPoints.IndexOf(IntToStr(Number));
  if i <> -1 then
    Result := TfrxBreakPoint(FBreakPoints.Objects[i]).Condition;
end;

procedure TfrxSyntaxMemo.DeleteF4BreakPoints;
var
  i: Integer;
begin
  i := 0;
  while i < FBreakPoints.Count do
    if TfrxBreakPoint(FBreakPoints.Objects[i]).FSpecialCondition = 'F4' then
    begin
      TObject(FBreakPoints.Objects[i]).Free;
      FBreakPoints.Delete(i);
    end
    else
      Inc(i);
end;

procedure TfrxSyntaxMemo.CorrectBreakPoints(Line, Delta: Integer);
var
  i, bPos: Integer;
begin
// FBreakPoints[FBreakPoints.IndexOfObject(TObject(Number))]
  for i := 0 to FBreakPoints.Count - 1 do
  begin
    bPos := TfrxBreakPoint(FBreakPoints.Objects[i]).FLine;
    if bPos >= Line then
    begin
      Inc(bPos, Delta);
      TfrxBreakPoint(FBreakPoints.Objects[i]).FLine := bPos;
      FBreakPoints[i] := IntToStr(bPos);
    end;
  end;
end;

function TfrxSyntaxMemo.GetTextSelected: Boolean;
begin
//
  Result := True;// FSelStart

end;

function TfrxSyntaxMemo.GetBreakPointSpecialCondition(
  Number: Integer): String;
var
  i: Integer;
begin
  Result := '';
  i := FBreakPoints.IndexOf(IntToStr(Number));
  if i <> -1 then
    Result := TfrxBreakPoint(FBreakPoints.Objects[i]).FSpecialCondition;
end;

function TfrxSyntaxMemo.GetIdentEnd(aPos: Integer): Integer;
var
  s: String;
begin
  Result := aPos;
  s := LineAt(FPos.Y - 1);
  if Length(s) >= aPos then
  begin
    FParser.Text := s;
    FParser.Position := aPos;//GetPlainTextPos(Point(aPos, FPos.Y));
    Result := Result + Length(FParser.GetIdent);
  end;
end;

procedure TfrxSyntaxMemo.ClearBreakPoints;
var
  i: Integer;
begin
  for i := 0 to FBreakPoints.Count - 1 do
    TObject(FBreakPoints.Objects[i]).Free;
  FBreakPoints.Clear;
end;

function TfrxSyntaxMemo.IsActiveBreakPoint(Number: Integer): Boolean;
var
  i: Integer;
begin
  Result := False;
  i := FBreakPoints.IndexOf(IntToStr(Number));
  if i <> -1 then
    Result := TfrxBreakPoint(FBreakPoints.Objects[i]).FEnabled;
end;

procedure TfrxSyntaxMemo.AddNewBreakPoint;
begin
  AddBreakPoint(FPos.Y, '', '');
end;

procedure TfrxSyntaxMemo.LoadFromIni(const IniPath: String; const Section: String; const FileName: String);
  var
    i, nCount: Integer;
    BPIni: TCustomIniFile;
    sName: String;
begin
  ClearBreakPoints;
  {$IFNDEF FPC}
  if Pos('\Software\', IniPath) = 1 then
  begin
    BPIni := TRegistryIniFile.Create(IniPath);
  //  TRegistryIniFile(BPIni).RegIniFile.OpenKey(Section, False);
  end
  else
  {$ENDIF}
  BPIni := TIniFile.Create(IniPath);
  FSynDialectStyles.LoadFrom(Section + '\SQLDialects', BPIni);
  sName := Section + '\BreakPoints\' + FileName;
  nCount := BPIni.ReadInteger(sName, 'Count', 0);
  try
    for i := 0 to nCount - 1 do
    begin
      sName :=  Section + '\BreakPoints\' + FileName + '\BP' + IntToStr(i);
      AddBreakPoint(BPIni.ReadInteger(sName, 'Line', -1), BPIni.ReadString(sName, 'Condition', ''), '');
      if BreakPoints.Count > 0 then
        TfrxBreakPoint(BreakPoints.Objects[BreakPoints.Count -1]).Enabled := BPIni.ReadBool(sName, 'Enabled', False);
    end;
  finally
    BPIni.Free;
  end;
end;

procedure TfrxSyntaxMemo.SaveToIni(const IniPath: String; const Section: String; const FileName: String);
var
  BPStr, sName: String;
  BP: TfrxBreakPoint;
  i: Integer;
  BPIni: TCustomIniFile;
begin
{$IFNDEF FPC}
  if Pos('\Software\', IniPath) = 1 then
    BPIni := TRegistryIniFile.Create(IniPath)
  else
{$ENDIF}
  BPIni := TIniFile.Create(IniPath);
  try
    sName := Section + '\BreakPoints\' + FileName;
    FSynDialectStyles.SaveTo(Section + '\SQLDialects', BPIni);
    BPIni.EraseSection(sName);
    BPIni.WriteInteger(sName, 'Count', BreakPoints.Count);
    for i := 0 to BreakPoints.Count - 1 do
    begin
      BP := TfrxBreakPoint(BreakPoints.Objects[i]);
      BPStr := sName + '\BP' + IntToStr(i);
      BPIni.WriteString(BPStr, 'Condition', BP.Condition);
      BPIni.WriteBool(BPStr, 'Enabled', BP.Enabled);
      BPIni.WriteInteger(BPStr, 'Line', BP.Line);
    end;
  finally
    BPIni.Free;
  end;
end;

{ TfrxCompletionList }

function TfrxCompletionList.AddBaseVar(varList: TStrings; const Name, sType: String; VisibleStart,
  VisibleEnd: Integer; const ParentFunc: String): TfrxCompletionItem;
var
  Index: Integer;
begin
  Index := varList.IndexOf(Name);
  if Index <> -1 then
  begin
    Result := TfrxCompletionItem(varList.Objects[Index]);
    Exit;
  end;
  Result := TfrxCompletionItem.Create;
  Result.FType := sType;
  Result.FStartVisible := VisibleStart;
  Result.FEndVisible := VisibleEnd;
  Result.FName := Name;
  if ParentFunc <> '' then
  begin
    Index := FFunctions.IndexOf(ParentFunc);
    if Index <> -1 then
      Result.FParent := TfrxCompletionItem(FFunctions.Objects[Index]);
  end;
  varList.AddObject(Name, Result);
end;

function TfrxCompletionList.AddClass(const Name, sType: String; VisibleStart,
  VisibleEnd: Integer; const ParentFunc: String): TfrxCompletionItem;
begin
  Result := AddBaseVar(FClasses, Name, sType, VisibleStart, VisibleEnd ,ParentFunc);
  Result.FItemType := itType;
end;

function TfrxCompletionList.AddConstant(const Name, sType: String; VisibleStart,
  VisibleEnd: Integer; const ParentFunc: String): TfrxCompletionItem;
begin
  Result := AddBaseVar(FConstants, Name, sType, VisibleStart, VisibleEnd ,ParentFunc);
  Result.FItemType := itConstant;
end;

function TfrxCompletionList.AddFunction(const Name, sType, Params: String;
  VisibleStart, VisibleEnd: Integer; const ParentFunc: String): TfrxCompletionItem;
var
  Item: TfrxCompletionItem;
begin
  Item := AddBaseVar(FFunctions, Name, sType, VisibleStart, VisibleEnd ,ParentFunc);
  Item.FParams := Params;
  if sType = '' then
    Item.FItemType := itProcedure
  else if SameText(Name, 'create') then
    Item.FItemType := itConstructor
  else
    Item.FItemType := itFunction;
  Result := Item;
end;

function TfrxCompletionList.AddVariable(const Name, sType: String; VisibleStart,
  VisibleEnd: Integer; const ParentFunc: String): TfrxCompletionItem;
begin
  Result := AddBaseVar(FVariables, Name, sType, VisibleStart, VisibleEnd ,ParentFunc);
  if CompareText(Name, sType) = 0 then
    Result.FItemType := itType
  else
    Result.FItemType := itVar;
end;

function TfrxCompletionList.Count: Integer;
begin
  Result := FConstants.Count + FVariables.Count + FFunctions.Count + FClasses.Count;
end;

constructor TfrxCompletionList.Create;
begin
  FConstants := TStringList.Create;
  FConstants.Sorted := True;
  FVariables := TStringList.Create;
  FVariables.Sorted := True;
  FFunctions := TStringList.Create;
  FFunctions.Sorted := True;
  FClasses := TStringList.Create;
  FClasses.Sorted := True;
end;

destructor TfrxCompletionList.Destroy;
begin
  DestroyItems;
  FreeAndNil(FConstants);
  FreeAndNil(FVariables);
  FreeAndNil(FFunctions);
  FreeAndNil(FClasses);
end;

procedure TfrxCompletionList.DestroyItems;

  procedure FreeList(sl: TStrings);
  var
    i: Integer;
  begin
    for i := 0 to sl.Count - 1 do
      TfrxCompletionItem(sl.Objects[i]).Free;
    sl.Clear;
  end;

begin
  if FLocked then Exit;
  FreeList(FConstants);
  FreeList(FVariables);
  FreeList(FFunctions);
  FreeList(FClasses);
end;

function TfrxCompletionList.Find(const Name: String): TfrxCompletionItem;
var
  Index: Integer;
begin
  Result := nil;
  if FConstants.Find(Name, Index) then
    Result := TfrxCompletionItem(FConstants.Objects[Index])
  else if FVariables.Find(Name, Index) then
    Result := TfrxCompletionItem(FVariables.Objects[Index])
  else if FFunctions.Find(Name, Index) then
    Result := TfrxCompletionItem(FFunctions.Objects[Index])
  else if FClasses.Find(Name, Index) then
    Result := TfrxCompletionItem(FClasses.Objects[Index]);
end;

function TfrxCompletionList.GetItem(Index: Integer): TfrxCompletionItem;
begin
  Result := nil;
  if Index < 0 then Exit;
  if FConstants.Count > Index then
  begin
    Result := TfrxCompletionItem(FConstants.Objects[Index]);
    Exit;
  end;
  Dec(Index, FConstants.Count);
  if FVariables.Count > Index then
  begin
    Result := TfrxCompletionItem(FVariables.Objects[Index]);
    Exit;
  end;
  Dec(Index, FVariables.Count);
  if FFunctions.Count > Index then
  begin
    Result := TfrxCompletionItem(FFunctions.Objects[Index]);
    Exit;
  end;
  Dec(Index, FFunctions.Count);
  if FClasses.Count > Index then
    Result := TfrxCompletionItem(FClasses.Objects[Index]);
end;

{ TfrxCodeCompletionThread }

destructor TfrxCodeCompletionThread.Destroy;
begin
  FText := nil;
  inherited;
  FreeScript;
end;

procedure TfrxCodeCompletionThread.Execute;
begin
  while not Terminated do
  begin
// synch via messages is not tested on Lazarus
{$IFDEF FPC}
    Synchronize(SyncScript);
{$ELSE}
    SendMessage(FMemoHandle, WM_FRX_SYNC_SCRIPT, 0, 0);
{$ENDIF}
    if Assigned(FScript) and not Terminated  then
    begin
      FILCode := TMemoryStream.Create;
{$IFDEF FPC}
      Synchronize(UpdateCode);
{$ELSE}
      SendMessage(FMemoHandle, WM_FRX_UPDATE_CODE, 0, 0);
{$ENDIF}
      try
      if FScript.GetILCode(FILCode) and not Terminated then
      begin
        FXML := TfsXMLDocument.Create;
        FILCode.Position := 0;
        FXML.LoadFromStream(FILCode);
{$IFDEF FPC}
        Synchronize(FillCodeCompletion);
{$ELSE}
        SendMessage(FMemoHandle, WM_FRX_FILL_CODE_COMPLETION, 0, 0);
{$ENDIF}
        FreeAndNil(FXML);
      end;
      except

      end;
      FreeAndNil(FILCode);
    end;
    // just in case
    if not Terminated then
      Suspend;
  end;
end;

procedure TfrxCodeCompletionThread.FillCodeCompletion;

var
  Prog: TfsXMLItem;

  function GetLine(const s: String): Integer;
  var
    Index: Integer;
    ss: String;
  begin
    Result := 0;
    Index := Pos(':', s);
    if Index > 1 then
    begin
      ss := Copy(s, 1, Index - 1);
      if ss <> '' then
        Result := StrToInt(ss);
    end;
  end;

  function DoAddV(sItem: TfsXMLItem; pStart, pEnd: Integer): String;
  var
    i: Integer;
    Name, sType: String;
    lTypFixup: TList;
  begin
    Result := '';
    if (CompareText(sItem.Name, 'var') = 0) then
    begin
      lTypFixup := TList.Create;
      try
        for i := 0 to sItem.Count - 1 do
          if (CompareText(sItem.Items[i].Name, 'ident') = 0) then
          begin
            Name := sItem.Items[i].Prop['text'];
            if Result <> '' then
              Result := Result + ' ,';
            Result := Result + Name;
            lTypFixup.Add(FCompletionList.AddVariable(Name, sType, pStart, pEnd));
          end
          else if (CompareText(sItem.Items[i].Name, 'type') = 0) then
            sType := sItem.Items[i].Prop['text'];
          Result := Result + ': ' + sType;
          for i := 0 to lTypFixup.Count - 1 do
            TfrxCompletionItem(lTypFixup[i]).FType := sType;
      finally
        lTypFixup.Free;
      end;
    end;
  end;

  function GetLastPos(sItem: TfsXMLItem): String;
  var
    s: String;
  begin
    Result := sItem.Prop['pos'];
    if (CompareText(sItem.Name, 'compoundstmt') = 0) and (sItem.Count > 0) then
      s := GetLastPos(sItem.Items[sItem.Count - 1]);
    if s <> '' then
      Result := s;
  end;

  procedure DoAddVar(sItem: TfsXMLItem; pStart, pEnd: Integer);
  var
    i, nStart: Integer;
    s, s1, sTyp: String;
    bNextIsVar: Boolean;
    TypItem: TfsXMLItem;
  begin
    nStart := 0;
    sTyp := '';
    if (CompareText(sItem.Name, 'procedure') = 0) or (CompareText(sItem.Name, 'function') = 0) then
    begin
      s := sItem.Prop['pos'];
      pStart := GetLine(s);
      s1 := sItem.Items[0].Prop['text'];
      if (CompareText(sItem.Items[1].Name, 'parameters') = 0) then
      begin
        s := GetLastPos(sItem.Items[sItem.Count - 1]);
        pEnd := GetLine(s) + 1;
        s := '';
        bNextIsVar := False;
        for i := 0 to sItem.Items[1].Count - 1 do
        begin
          if bNextIsVar then
            s := s + ' var '
          else if i > 0 then
            s := s + ';';
          bNextIsVar := (CompareText(sItem.Items[1].Items[i].Name, 'varparams') = 0);
          if bNextIsVar then continue;

          s := s + DoAddV(sItem.Items[1].Items[i], pStart, pEnd);
        end;
        nStart := 2;
      end;
      TypItem := sItem.FindItem('type');
      if Assigned(TypItem) then
        sTyp := TypItem.Prop['text'];
      if s <> '' then
        FCompletionList.AddFunction(s1, sTyp, s, pStart);
    end
    else if (CompareText(sItem.Name, 'var') = 0) then
      DoAddV(sItem, pStart, pEnd);
    for i := nStart to sItem.Count - 1 do
        DoAddVar(sItem.Items[i], pStart, pEnd);
  end;
begin
  if not Assigned(FXML) or FCompletionList.Locked then Exit;
  Prog := FXML.Root.FindItem('program');
  FCompletionList.DestroyItems;
  if Assigned(Prog) then
    DoAddVar(FXML.Root, 0, -1);
end;

procedure TfrxCodeCompletionThread.FreeScript;
var
  pScript, lScript: TfsScript;
begin
  if not Assigned(FScript) then Exit;
  pScript := FScript.Parent;
  while pScript <> nil do
  begin
    lScript := pScript;
    pScript := pScript.Parent;
    FreeAndNil(lScript);
  end;
  FreeAndNil(FScript);
end;

procedure TfrxCodeCompletionThread.SyncScript;
var
  pScript, lScript: TfsScript;
begin
  if Assigned(FScript) or not Assigned(FOriginalScript) then Exit;
  FScript := TfsScript.Create(nil);
  FScript.SyntaxType := FSyntaxType;
  pScript := FOriginalScript.Parent;
  { do not process GlobalUnit }
  if Assigned(pScript) and (fsIsGlobalUnitExist) and (pScript = fsGlobalUnit) then
    pScript := nil;
  lScript := FScript;
  lScript.AddRTTI;
  while pScript <> nil do
  begin
    pScript := pScript.Parent;
    if Assigned(pScript) and (fsIsGlobalUnitExist) and (pScript = fsGlobalUnit) then
      break;
    lScript.Parent := TfsScript.Create(nil);
    lScript := lScript.Parent;
    lScript.Lines.Assign(pScript.Lines);
    lScript.SyntaxType := FSyntaxType;
    lScript.AddRTTI;
  end;
end;

procedure TfrxCodeCompletionThread.UpdateCode;
begin
  if Assigned(FScript) and Assigned(FText) then
    FScript.Lines.Assign(FText);
  if Assigned(FScript) and Assigned(FOriginalScript) then
    FScript.SyntaxType := FSyntaxType;
end;

{ TfrxSynAttributes }

procedure TfrxSynAttributes.ActiveChanged(Sender: TObject);
begin
  UpdateSyntaxDialect;
end;

constructor TfrxSynAttributes.Create(Parser: TfsParser; DialectStyles: TfrxSynDialectStyles);
begin
  FParser := Parser;
  FDialectStyles := DialectStyles;
  FDialectStyles.OnActiveChanged := ActiveChanged;
end;

procedure TfrxSynAttributes.Delete(Index: Integer);
begin
  FUpdating := True;
  if (Index < 0) or (Index >= FCount) then raise Exception.Create('Error Message');

  Finalize(FArray[Index]);
  Dec(FCount);
  if Index < FCount then
  begin
    System.Move(FArray[Index + 1], FArray[Index],
      (FCount - Index) * SizeOf(TfrxByteArr));
  end;
  FUpdating := False;
end;

function TfrxSynAttributes.GetAllAttributes: TfrxByteArr;
var
  Len, i: Integer;
begin
  Len := 0;
  for i := 0 to FCount - 1 do
    Inc(Len, Length(FArray[i]) + Length(sLineBreak));
  SetLength(Result, Len);
  Len := 0;
  for i := 0 to FCount - 1 do
  begin
    Move(FArray[i][0], Result[Len], Length(FArray[i]));
    Inc(Len, Length(FArray[i]) + Length(sLineBreak));
    Result[Len - 1] := 0;
    Result[Len - 2] := 0;
  end;
end;

function TfrxSynAttributes.GetLine(Index: Integer): TfrxByteArr;
begin
  Result := FArray[Index];
end;

procedure TfrxSynAttributes.PutLine(Index: Integer; const Value: TfrxByteArr);
begin
  FArray[Index] := Value;
end;

procedure TfrxSynAttributes.SetAllAttributes(Attr: TfrxByteArr);
var
  i, Index, Len, sLen: Integer;
begin
  Len := Length(Attr);
  Index := 0;
  for i := 0 to FCount - 1 do
  begin
    if Len - Length(FArray[i]) > 0 then
      sLen := Length(FArray[i])
    else
      sLen := Len;
    Move(Attr[Index], FArray[i][0], sLen);
    Inc(Index, sLen + Length(sLineBreak));
    Dec(Len, sLen + Length(sLineBreak));
  end;
end;

procedure TfrxSynAttributes.SetCapacity(NewCapacity: Integer);
begin
  if NewCapacity < FCount then
    raise Exception.CreateFmt('Invalid Capacity %d', [NewCapacity]);
  if NewCapacity <> FCapacity then
  begin
    SetLength(FArray, NewCapacity);
    FCapacity := NewCapacity;
  end;
end;

procedure TfrxSynAttributes.SetCount(NewCount: Integer);
begin
  if NewCount < 0 then
    raise Exception.CreateFmt('Invalid count %d', [NewCount]);
  if NewCount <> FCount then
  begin
    if NewCount > FCapacity then
      SetCapacity(NewCount);
    FCount := NewCount;
  end;;

end;

procedure TfrxSynAttributes.SetLineLen(Index, NewLen: Integer);
begin
  SetLength(FArray[Index], NewLen);
  FillChar(FArray[Index][0], NewLen, 255);
end;

procedure TfrxSynAttributes.UpdateSyntax(EndLine: Integer; Text: TStringList);
var
  i, j, n, Max: Integer;
  FSyn: TfrxByteArr;
  s: String;
  attr: Byte;
begin
  FUpdating := True;
  n := Count;
  Count := EndLine + 1;
  for i := n to EndLine do
    SetLineLen(i, Length(Text[i]));
  FSyn := GetAllAttributes;
  Max := Length(FSyn);

  for i := Length(FSyn) - 1 downto 0 do
    if Integer(FSyn[i]) = Ord(caText) then
    begin
      j := i;
      while (j > 1) and (Integer(FSyn[j]) = Ord(caText)) do
        Dec(j);
      FParser.Position := j + 1;
      break;
    end;

  while FParser.Position < Max do
  begin
    n := FParser.Position;
    FParser.SkipSpaces;
    for i := n to FParser.Position - 1 do
      if i <= Max then
        if FSyn[i - 1] > 31 then
          FSyn[i - 1] := Ord(caComment);

    attr := Ord(caText);
    n := FParser.Position;
    s := FParser.GetWord;
    if s <> '' then
    begin
      if FParser.IsKeyword(s) then
        attr := FDialectStyles.ActiveStyles.FindStyleIDByKeyword(s, caKeyword)
      else
        attr := FDialectStyles.ActiveStyles.FindStyleIDByKeyword(s, caText);
    end
    else
    begin
      s := FParser.GetNumber;
      if s <> '' then
        attr := Ord(caNumber)
      else
      begin
        s := FParser.GetString;
        if s <> '' then
          attr := Ord(caString) else
          FParser.Position := FParser.Position + 1
      end
    end;

    for i := n to FParser.Position - 1 do
      if i <= Max then
        if FSyn[i - 1] > 31 then
          FSyn[i - 1] := Ord(attr);
  end;

  SetAllAttributes(FSyn);
  FUpdating := False;
end;

procedure TfrxSynAttributes.UpdateSyntaxDialect;
var
  sl: TStringList;
  Dialect: TfrxSynDialectStyle;
begin
  sl := TStringList.Create;
  Dialect := FDialectStyles.ActiveDialicet;
  if Dialect.Keywords <> '' then
    sl.CommaText := Dialect.Keywords
  else
    sl.CommaText := SQLKeywords;
  FParser.Keywords.Assign(sl);
  sl.Free;
  if Dialect.CommentLine1 <> '' then
    FParser.CommentLine1 := Dialect.CommentLine1
  else
    FParser.CommentLine1 := SQLCommentLine1;
  FParser.CommentLine2 := Dialect.CommentLine2;
  if Dialect.CommentBlock1 <> '' then
    FParser.CommentBlock1 := Dialect.CommentBlock1
  else
    FParser.CommentBlock1 := SQLCommentBlock1;
  FParser.CommentBlock2 := Dialect.CommentBlock2;

  if Dialect.StringQuotes <> '' then
    FParser.StringQuotes := Dialect.StringQuotes
  else
    FParser.StringQuotes := SQLStringQuotes;

  if Dialect.HexSequence <> '' then
    FParser.HexSequence := Dialect.HexSequence
  else
    FParser.HexSequence := SQLHexSequence;
  while Count > 0 do
    Delete(Count - 1);
end;

{ TfrxAttributeStyles }

function TfrxAttributeStyles.Add: TfrxAttributeStyle;
begin
  Result := inherited Add as TfrxAttributeStyle;
end;

procedure TfrxAttributeStyles.AssignStyle(aStyle: TfrxAttributeStyle;
  aFont: TFont);
begin
  aFont.Color := aStyle.FontColor;
  aFont.Style := aStyle.FontStyle;
end;

procedure TfrxAttributeStyles.AssignStyleByID(ID: Byte; aFont: TFont);
var
  style: TfrxAttributeStyle;
begin
  style := GetStyleByID(ID);
  AssignStyle(style, aFont);
end;

constructor TfrxAttributeStyles.Create;
begin
  inherited Create(TfrxAttributeStyle);
  FDefaultAttribute := TfrxAttributeStyle.Create(nil);
  FIndexedList := TStringList.Create;
  FIndexedList.Sorted := True;
end;

destructor TfrxAttributeStyles.Destroy;
begin
  inherited;
  FreeAndNil(FDefaultAttribute);
  FreeAndNil(FIndexedList);
end;

function TfrxAttributeStyles.FindStyleIDByKeyword(const Name: String; AttrType: TCharAttr): Byte;
var
  i, Index: Integer;
begin
  Result := ord(AttrType);
  for i := 0 to Count - 1 do
    if Items[i].AttrType =  AttrType then
    begin
      Index := Items[i].FKeywords.IndexOf(Name);
      if Index > -1 then
      begin
        Result := Items[i].StyleID;
        break;
      end;
    end;
end;

function TfrxAttributeStyles.GetItem(Index: Integer): TfrxAttributeStyle;
begin
  Result := TfrxAttributeStyle(inherited GetItem(Index));
end;

function TfrxAttributeStyles.GetStyleByID(ID: Byte): TfrxAttributeStyle;
var
  i: Integer;
begin
  Result := FDefaultAttribute;
  i := FIndexedList.IndexOf(IntToStr(ID));
  if i > -1 then
    Result := TfrxAttributeStyle(FIndexedList.Objects[i]);
end;

function TfrxAttributeStyles.GetUniqueID: Byte;
var
  i: Integer;
begin
  Result := Byte(High(TCharAttr)) + 1;
  for i := 0 to Count - 1 do
  begin
    if Result = Items[i].StyleID then
      Inc(Result);
  end;
  if Result >= 200 then
    raise Exception.Create('Collection is full.');
end;

{ TfrxAttributeStyle }

constructor TfrxAttributeStyle.Create(Collection: TCollection);
begin
  inherited Create(Collection);
  FKeywords := TStringList.Create;
  TStringList(FKeywords).Sorted := True;
end;

destructor TfrxAttributeStyle.Destroy;
begin
  FreeAndNil(FKeywords);
  inherited;
end;

procedure TfrxAttributeStyle.SetCollection(Value: TCollection);
var
  ACol: TfrxAttributeStyles;
  i: Integer;
begin
  ACol := Value as TfrxAttributeStyles;
  if Assigned(ACol) then
  begin
    FStyleID := ACol.GetUniqueID;
    if Assigned(ACol.FIndexedList) then
      ACol.FIndexedList.AddObject(IntToStr(StyleID), Self);
  end
  else
  begin
    ACol := Collection as TfrxAttributeStyles;
    if Assigned(ACol) and Assigned(ACol.FIndexedList) then
    begin
      i := ACol.FIndexedList.IndexOf(IntToStr(StyleID));
      if i > -1 then
        ACol.FIndexedList.Delete(i);
    end; 
  end;
  inherited;
end;

{ TfrxSynDialectStyle }

constructor TfrxSynDialectStyle.Create(AOwner: TObject);
begin
  FAttributeStyles := TfrxAttributeStyles.Create;
  FKeywords := SQLKeywords;
  FCommentLine1 := SQLCommentLine1;
  FCommentLine2 := '';
  FCommentBlock1 := SQLCommentBlock1;
  FCommentBlock2 := '';
  FStringQuotes := SQLStringQuotes;
  FHexSequence := SQLHexSequence;
  FOwner := AOwner;
end;

destructor TfrxSynDialectStyle.Destroy;
begin
  FreeAndNil(FAttributeStyles);
  if Assigned(FOwner) and (FOwner is TfrxSynDialectStyles) then
    TfrxSynDialectStyles(FOwner).FLIst.Remove(Self);
  inherited;
end;

procedure TfrxSynDialectStyle.LoadFrom(const Section: String; Ini: TObject);
var
  IniFile: TCustomIniFile absolute Ini;
  i, nCount: Integer;
  Style: TfrxAttributeStyle;
  sName: String;
begin
  FKeywords := IniFile.ReadString(Section, 'Keywords', SQLKeywords);
  CommentLine1 := IniFile.ReadString(Section, 'CommentLine1', SQLCommentLine1);
  CommentLine2 := IniFile.ReadString(Section, 'CommentLine2', '');
  CommentBlock1 := IniFile.ReadString(Section, 'CommentBlock1', SQLCommentBlock1);
  CommentBlock2 := IniFile.ReadString(Section, 'CommentBlock2', '');
  StringQuotes := IniFile.ReadString(Section, 'StringQuotes', SQLStringQuotes);
  HexSequence := IniFile.ReadString(Section, 'HexSequence', SQLHexSequence);
  Name := IniFile.ReadString(Section, 'Name', '');
  nCount := IniFile.ReadInteger(Section + '\AttributeStyles', 'Count', 0);
  for i := 0 to nCount - 1 do
  begin
    sName := Section + '\AttributeStyles\Style.' + IntToStr(i);
    Style := AttributeStyles.Add;
    Style.AttrType := TCharAttr(IniFile.ReadInteger(sName, 'AttrType', 0));
    Style.Keywords.CommaText := IniFile.ReadString(sName, 'Keywords', '');
    Style.FontColor := IniFile.ReadInteger(sName, 'FontColor', 0);
    Style.FontStyle := TFontStyles({$IFNDEF FPC}Byte{$ENDIF}(IniFile.ReadInteger(sName, 'FontStyle', 0)));
  end;
end;

procedure TfrxSynDialectStyle.SaveTo(const Section: String; Ini: TObject);
var
  IniFile: TCustomIniFile absolute Ini;
  i: Integer;
  sName, sStr: String;
  Style: TfrxAttributeStyle;
begin
  if (Keywords <> '') and (Keywords <> SQLKeywords) then
    IniFile.WriteString(Section, 'Keywords', Keywords);
  if (CommentLine1 <> '') and (CommentLine1 <> SQLCommentLine1) then
    IniFile.WriteString(Section, 'CommentLine1', CommentLine1);
  if CommentLine2 <> '' then
    IniFile.WriteString(Section, 'CommentLine2', CommentLine2);
  if (CommentBlock1 <> '') and (CommentBlock1 <> SQLCommentBlock1) then
    IniFile.WriteString(Section, 'CommentBlock1', CommentBlock1);
  if CommentBlock2 <> '' then
    IniFile.WriteString(Section, 'CommentBlock2', CommentBlock2);
  if (StringQuotes <> '') and (StringQuotes <> SQLStringQuotes) then
    IniFile.WriteString(Section, 'StringQuotes', StringQuotes);
  if (HexSequence <> '') and (HexSequence <> SQLHexSequence) then
    IniFile.WriteString(Section, 'HexSequence', HexSequence);
  IniFile.WriteString(Section, 'Name', Name);
  sName := Section + '\AttributeStyles';
  IniFile.EraseSection(sName);
  IniFile.WriteInteger(sName, 'Count', AttributeStyles.Count);
  for i := 0 to AttributeStyles.Count - 1 do
  begin
    Style := AttributeStyles.Items[i];
    sStr := sName + '\Style.' + IntToStr(i);
    IniFile.WriteInteger(sStr, 'AttrType', Integer(Style.AttrType));
    IniFile.WriteString(sStr, 'Keywords', Style.Keywords.CommaText);
    IniFile.WriteInteger(sStr, 'FontColor', Style.FontColor);
    IniFile.WriteInteger(sStr, 'FontStyle', {$IFNDEF FPC}Byte{$ELSE}Integer{$ENDIF}(Style.FontStyle));
  end;
end;

procedure TfrxSynDialectStyle.SetName(const Value: String);
begin
  FName := Value;
end;

{ TfrxSynDialectStyles }

function TfrxSynDialectStyles.Add: TfrxSynDialectStyle;
begin
  Result := TfrxSynDialectStyle.Create(Self);
  FLIst.Add(Result);
end;

procedure TfrxSynDialectStyles.Clear;
var
  i: Integer;
begin
  for i := FLIst.Count - 1 downto 0 do
    TObject(FLIst[i]).Free;
  FLIst.Clear;
end;

function TfrxSynDialectStyles.Count: Integer;
begin
  Result := FLIst.Count;
end;

constructor TfrxSynDialectStyles.Create;
begin
  FLIst := TList.Create;
  FDefSynDialectStyle := TfrxSynDialectStyle.Create(nil);
  FActiveIndex := -1;
end;

destructor TfrxSynDialectStyles.Destroy;
begin
  Clear;
  FreeAndNil(FLIst);
  FreeAndNil(FDefSynDialectStyle);
  inherited;
end;

function TfrxSynDialectStyles.GetActiveDialicet: TfrxSynDialectStyle;
begin
  if FActiveIndex > -1 then
    Result := Items[FActiveIndex]
  else
    Result := FDefSynDialectStyle;
end;

function TfrxSynDialectStyles.GetActiveStyles: TfrxAttributeStyles;
begin
  if FActiveIndex > -1 then
    Result := Items[FActiveIndex].AttributeStyles
  else
    Result := FDefSynDialectStyle.AttributeStyles;
end;

function TfrxSynDialectStyles.GetItem(Index: Integer): TfrxSynDialectStyle;
begin
  Result := TfrxSynDialectStyle(FLIst[Index]);
end;

procedure TfrxSynDialectStyles.LoadFrom(const Section: String; Ini: TObject);
var
  IniFile: TCustomIniFile absolute Ini;
  i, nCount: Integer;
begin
  Clear;
  nCount := IniFile.ReadInteger(Section, 'Count', 0);
  for i := 0 to nCount - 1 do
    Add.LoadFrom(Section + '\SQL.' + IntToStr(i), Ini);
end;

procedure TfrxSynDialectStyles.SaveTo(const Section: String; Ini: TObject);
var
  IniFile: TCustomIniFile absolute Ini;
  i: Integer;
  sName: String;
  Style: TfrxSynDialectStyle;
begin
  IniFile.WriteInteger(Section, 'Count', FLIst.Count);
  for i := 0 to FLIst.Count - 1 do
  begin
    Style := TfrxSynDialectStyle(FLIst[i]);
    sName := Section + '\SQL.' + IntToStr(i);
    IniFile.EraseSection(sName);
    Style.SaveTo(sName, Ini);
  end;
end;

procedure TfrxSynDialectStyles.SetActiveIndex(const Value: Integer);
begin
  FActiveIndex := Value;
  if Assigned(FActiveChanged) then
    FActiveChanged(Self);
end;

end.
