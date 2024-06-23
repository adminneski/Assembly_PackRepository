unit Gobt_TabEnterBlur;

interface

uses
  Winapi.Windows,Messages, WinTypes, WinProcs, SysUtils, Classes, Graphics, Controls,
  Forms, Dialogs, stdCtrls, DB,
  ShellAPI,
  dbctrls,
  TypInfo,
  Grids,
  DBGrids,
  Vcl.ComCtrls;

const
  MAJ_VER = 1; // Major version nr.
  MIN_VER = 2; // Minor version nr.
  REL_VER = 2; // Release nr.
  BLD_VER = 4; // Build nr.

type

  TFocusWindowEx = class(TCustomControl)
  protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure CreateWnd; override;
  end;

  TBlurAllowControl = (icEdit, icMemo, icListBox, icComboBox, icDateTimePicker, icCheckBox, icRadioButton, icTagValue);

  TBlurAllowControls = set of TBlurAllowControl;

  TGlyphPosition = (gpAfterControl, gpBeforeControl);

  TOnShowFocusEvent = procedure(Sender: TObject; Control: TWinControl; var ShowFocus: boolean) of object;

  TGoTabEnterBlur = class(TComponent)
  private
    { Private declarations }
    FAbout            : string;
    FAutoSkip         : Boolean;

    FActiveEnter      : Boolean;
    FEnterClassListAllow  : TStringList;
    FEnterKeyBoardArrows   : Boolean;
    //
    FActiveBlur       : boolean;
    FBlurColor: TColor;
    FBlurSize: integer;
    FBlur: integer;
    FBlurOpacity: byte;
    FBlurRounding: byte;
    FBlurAllowControls: TBlurAllowControls;
    FBlurControlTag: integer;
    //
    FActiveFocusColor : Boolean;
    FFocusColor       : TColor;
    FFocusColorClassListNotAllow : TStringList;

    FActiveHintShow   : Boolean;
    FHintShowColor    : TColor;

    FGlyph: TBitmap;
    FGlyphPosition: TGlyphPosition;

    //
    FHasHook: boolean;
    FW: TFocusWindowEx;
    FocusControl: THandle;
    FocusHeight: integer;
    FocusWidth: integer;

    FOnMessage        : TMessageEvent;
    FOnMessageRescue  : TMessageEvent;
    FOnIdle           : TIdleEvent;
    FOnIdleRescue     : TIdleEvent;
    FOnHint           : TNotifyEvent;
    FOnHintRescue     : TNotifyEvent;
    FOnHelp           : THelpEvent;
    FOnHelpRescue     : THelpEvent;
    FOnShowFocus: TOnShowFocusEvent;

    procedure SetGlyph(const Value: TBitmap);
    procedure SetBlur(const Value: integer);
    procedure SetBlurSize(const Value: integer);
    function  GetVersion: string;
    procedure SetVersion(const Value: string);
    procedure SetBlurActive(const Value: boolean);
    procedure SetClassListAllow( AClassList: TStringList );
    procedure SetClassListNotAllow( AColorList: TStringList );

  protected
    { Protected declarations }
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DoShowHint( Control: TWinControl );
    procedure LocalOnMessage(var Msg: TMsg; var Handled: Boolean);
    procedure LocalOnIdle(Sender: TObject; var Done: Boolean);
    procedure LocalOnHint(Sender: TObject);
    function  LocalOnHelp(Command: word; Data: Longint; var CallHelp: Boolean):Boolean;

    function  CheckClassList( AClassName, AObjectName: string ): Boolean;
    function  CheckColorList( AColorClass, AObjectName: string ): Boolean;
    function  tbKeyIsDown(const Key: integer): boolean;
    //====
    function AcceptControl(wc,wcp: TWinControl): boolean; virtual;
    procedure InitHook; virtual;
    procedure Unhook; virtual;
    function GetVersionNr: Integer; virtual;

  public
    { Public declarations }
    constructor Create(AOwner:TComponent); override;
    destructor  Destroy; override;
    //
    procedure ShowHelper;
    procedure HideHelper;
    procedure MoveHelper(R: TRect);
    procedure ShowHelperOnControl(R: TRect);
    procedure UpdateHelper;


  published
    { Published declarations }

    property About  : string          read FAbout           write FAbout stored False;
    property AutoSkip: Boolean        read FAutoSkip        write FAutoSkip;

    property ActiveEnter: Boolean     read FActiveEnter     write FActiveEnter;
    property EnterClassListAllow: TStringList   read FEnterClassListAllow       write SetClassListAllow;
    property EnterKeyBoardArrows : Boolean read FEnterKeyBoardArrows  write FEnterKeyBoardArrows;


    property ActiveFocusColor : Boolean    read FActiveFocusColor     write FActiveFocusColor;
    property FocusColor : TColor      read FFocusColor      write FFocusColor;
    property FocusColorClassListNotAllow: TStringList read FFocusColorClassListNotAllow write SetClassListNotAllow;

    property ActiveHintShow : Boolean read FActiveHintShow  write FActiveHintShow;
    property HintShowColor : TColor   read FHintShowColor   write FHintShowColor;


    property ActiveBlur: boolean read FActiveBlur write SetBlurActive default true;
    property Blur: integer read FBlur write SetBlur default 3;
    property BlurColor: TColor read FBlurColor write FBlurColor default $FDD397;
    property BlurControlTag: integer read FBlurControlTag write FBlurControlTag default 0;
    property BlurAllowControls: TBlurAllowControls read FBlurAllowControls write FBlurAllowControls;
    property BlurSize: integer read FBlurSize write SetBlurSize default 4;
    property BlurOpacity: byte read FBlurOpacity write FBlurOpacity default 180;
    property BlurRounding: byte read FBlurRounding write FBlurRounding default 5;

    property Glyph: TBitmap read FGlyph write SetGlyph;
    property GlyphPosition: TGlyphPosition read FGlyphPosition write FGlyphPosition default gpAfterControl;
    property Version: string read GetVersion write SetVersion;
    //
    property OnShowFocus: TOnShowFocusEvent read FOnShowFocus write FOnShowFocus;
    property OnMessage: TMessageEvent read FOnMessage       write FOnMessage;
    property OnIdle:    TIdleEvent    read FOnIdle          write FOnIdle;
    property OnHint:    TNotifyEvent  read FOnHint          write FOnHint;
    property OnHelp:    THelpEvent    read FOnHelp          write FOnHelp;

  end;

  procedure DrawRoundRect(Bitmap: TBitmap; W, H, BMPW: Integer; BMPPos: TGlyphPosition; Thickness, Radius: Integer; Blur: Double);


implementation

const
  MaxKernelSize = 10;

{$IFNDEF DELPHI6_LVL}
  {$EXTERNALSYM AC_SRC_ALPHA}
  AC_SRC_ALPHA = $01;

  {$EXTERNALSYM AC_SRC_OVER}
  AC_SRC_OVER = $00;

  {$EXTERNALSYM ULW_ALPHA}
  ULW_ALPHA      = $00000002;

  {$EXTERNALSYM WS_EX_LAYERED}
  WS_EX_LAYERED  = $00080000;
{$ENDIF}


var
  MsgHook: HHOOK;
  FocusHelperEx: TGoTabEnterBlur;


  FHintWindow       : THintWindow;
  FFocusControl     : TWinControl;
  FActiveControl    : TWinControl;
  FFocusColorReturn : TColor;


type
  PRGBA = ^TRGBA;
  TRGBA = record
    Blue: Byte;
    Green: Byte;
    Red: Byte;
    Alpha: Byte;
  end;

  PRGB = ^TRGB;
  TRGB = record
    Blue: Byte;
    Green: Byte;
    Red: Byte;
  end;

  PRGBTriplet = ^TRGBTriplet;
  TRGBTriplet = packed record
    b: byte;
    g: byte;
    r: byte;
  end;

  TKernelSize = 1..MaxKernelSize;
  TKernel = record
    Size: TKernelSize;
    Weights: array[-MaxKernelSize..MaxKernelSize] of single;
  end;
  PKernel = ^TKernel;

  PBlendFunction = ^TBlendFunction;
 _BLENDFUNCTION = packed record
    BlendOp: BYTE;
    BlendFlags: BYTE;
    SourceConstantAlpha: BYTE;
    AlphaFormat: BYTE;
 end;
 TBlendFunction = _BLENDFUNCTION;


  PRow = ^TRow;
  TRow = array[0..10000] of TRGBTriplet;
  PPRows = ^TPRows;
  TPRows = array[0..10000] of PRow;

{ TAlphaMask }

type
  TAlphaMask = class(TBitmap)
  private
    FOpacity: Byte;
  public
    constructor Create; override;
    procedure Assign(Source: TPersistent); override;
    procedure MergeMask(Mask, Bitmap: TBitmap; Color: TColor);
    property Opacity: Byte read FOpacity write FOpacity;
  end;

(*
function UpdateLayeredWindow(Handle: THandle; hdcDest: HDC; pptDst: PPoint; _psize: PSize;
  hdcSrc: HDC; pptSrc: PPoint; crKey: COLORREF;
  pblend: PBLENDFUNCTION; dwFlags: DWORD): Boolean; stdcall; external user32 name 'UpdateLayeredWindow';
*)


function DynaLink_SetLayeredWindowAttributes(HWND: thandle; crKey: DWORD; bAlpha: byte; dwFlags: DWORD): boolean;
var
  UserDLL: THandle;
  user_SetLayeredWindowAttributes: function(HWND: thandle; crKey: DWORD; bAlpha: byte; dwFlags: DWORD): DWORD; stdcall;

begin
  result := TRUE;
  UserDLL := GetModuleHandle('USER32.DLL');
  if (UserDLL > 0) then
  begin
    @user_SetLayeredWindowAttributes := GetProcAddress(UserDLL, 'SetLayeredWindowAttributes');
    if Assigned(user_SetLayeredWindowAttributes) then
    begin
      Result := user_SetLayeredWindowAttributes(hwnd, crKey, bAlpha, dwFlags) <> 0;
    end;
  end;
end;

//------------------------------------------------------------------------------

function DynaLink_UpdateLayeredWindow(hwnd, hdcDst: thandle;
  pptDst, size: ppoint; hdcSrc: thandle;
  pptSrc: ppoint;
  crKey: dword;
  var pblend: _BLENDFUNCTION;
  dwFlags: DWORD): boolean;

var
  UserDLL: THandle;
  user_UpdateLayeredWindow: function(hwnd, hdcDst: thandle;
    pptDst, size: ppoint; hdcSrc: thandle;
    pptSrc: ppoint;
    crKey: dword;
    var pblend: _BLENDFUNCTION;
    dwFlags: DWORD): DWORD; stdcall;

begin
  Result := TRUE;
  UserDLL := GetModuleHandle('USER32.DLL');
  if (UserDLL > 0) then
  begin
    @user_UpdateLayeredWindow := GetProcAddress(UserDLL, 'UpdateLayeredWindow');
    if Assigned(user_UpdateLayeredWindow) then
    begin
      Result := user_UpdateLayeredWindow(hwnd, hdcDst, pptDst, size, hdcSrc, pptSrc, crKey, pblend, dwFlags) <> 0;
    end;
  end;
end;




procedure GlyphToMask(Glyph, Bitmap: TBitmap);
var
  x,y: integer;
  A: PRGB;
begin
  Bitmap.Width := Glyph.Width;
  Bitmap.Height := Glyph.Height;
  Bitmap.PixelFormat := pf24bit;

  Bitmap.Canvas.Brush.Color := clBlack;
  Bitmap.Canvas.Brush.Style := bsSolid;
  Bitmap.Canvas.FillRect(Rect(0,0,Bitmap.Width, Bitmap.Height));

  Glyph.TransparentMode := tmAuto;
  Glyph.Transparent := true;
  Bitmap.Canvas.Draw(0,0,Glyph);

  for y := 0 to Bitmap.Height  - 1 do
  begin
    A := Bitmap.ScanLine[y];
    for x := 0 to Bitmap.Width - 1 do
    begin
      if (A^.Red <> 0) or (A^.Blue <> 0) or (A^.Green <> 0) then
      begin
        A^.Blue := $FF;
        A^.Green := $FF;
        A^.Blue := $FF;
      end;
      inc(A);
    end;
  end;
end;



{ GetHintWindow}

function HintWindow: THintWindow;
begin
  if FHintWindow = nil then
  begin
    FHintWindow := THintWindow.Create(Application);
    FHintWindow.Visible := False;
  end;
  Result := FHintWindow;
end;

procedure UpdateAlphaWindow(Wnd: HWND; AlphaMap: TAlphaMask);
var
  Blend: _BlendFunction;
  Rect: TRect;
  P1, P2: TPoint;
  S: TSize;
  DC: HDC;
begin
  if AlphaMap.Height = 0 then
    Exit;

  SetWindowLong(Wnd, GWL_EXSTYLE, GetWindowLong(Wnd, GWL_EXSTYLE) or WS_EX_LAYERED);
  GetWindowRect(Wnd, Rect);
  P1.X := Rect.Left;
  P1.Y := Rect.Top;
  SetWindowPos(Wnd, 0, 0, 0, AlphaMap.Width, AlphaMap.Height, SWP_NOACTIVATE or SWP_NOMOVE);

  with Blend do
  begin
    BlendOp := AC_SRC_OVER;
    BlendFlags := 0;
    SourceConstantAlpha := AlphaMap.Opacity;
    AlphaFormat := AC_SRC_ALPHA;
  end;

  DC := GetDC(0);
  P2 := Point(0, 0);
  S.cx := AlphaMap.Width;
  S.cy := AlphaMap.Height;

  Dynalink_UpdateLayeredWindow(Wnd, DC, @P1, @S, AlphaMap.Canvas.Handle, @P2, 0, Blend, ULW_ALPHA);

  ReleaseDC(0, DC);
end;


procedure MakeGaussianKernel(var K: TKernel; radius: double; MaxData, DataGranularity: double);
var
  j: integer; temp, delta: double;
  KernelSize: TKernelSize;

begin
  for j := Low(K.Weights) to High(K.Weights) do
  begin
    temp := j/radius;
    K.Weights[j] := exp(- temp*temp/2);
  end;

  temp := 0;

  for j := Low(K.Weights) to High(K.Weights) do
    temp := temp + K.Weights[j];

  for j := Low(K.Weights) to High(K.Weights) do
    K.Weights[j] := K.Weights[j] / temp;

  KernelSize := MaxKernelSize;
  delta := DataGranularity / (2*MaxData);
  temp := 0;

  while (temp < delta) and (KernelSize > 1) do
  begin
    temp := temp + 2 * K.Weights[KernelSize];
    dec(KernelSize);
  end;

  K.Size := KernelSize;

  temp := 0;

  for j := -K.Size to K.Size do
    temp := temp + K.Weights[j];

  for j := -K.Size to K.Size do
    K.Weights[j] := K.Weights[j] / temp;
end;


function TrimInt(Lower, Upper, theInteger: integer): integer;
begin
  if (theInteger <= Upper) and (theInteger >= Lower) then
    Result := theInteger
  else
    if theInteger > Upper then
      Result := Upper
    else
      Result := Lower;
end;

function TrimReal(Lower, Upper: integer; x: double): integer;
begin
  if (x < upper) and (x >= lower) then
    Result := trunc(x)
  else
    if x > Upper then
      Result := Upper
    else
      Result := Lower;
end;

procedure BlurRow(var theRow: array of TRGBTriplet; K: PKernel; P: PRow);
var
  j, n: integer; tr, tg, tb: double; //tempRed, etc
  w: double;

begin
  for j:= 0 to High(theRow) do
  begin
    tb := 0;
    tg := 0;
    tr := 0;

    for n := -K.Size to K.Size do
    begin
      w := K.Weights[n];

      with theRow[TrimInt(0, High(theRow), j - n)] do
      begin
        tb := tb + w * b;
        tg := tg + w * g;
        tr := tr + w * r;
      end;
    end;

    with P[j] do
    begin
      b := TrimReal(0, 255, tb);
      g := TrimReal(0, 255, tg);
      r := TrimReal(0, 255, tr);
    end;
  end;

  Move(P[0], theRow[0], (High(theRow) + 1) * Sizeof(TRGBTriplet));
end;

procedure GBlur(theBitmap: TBitmap; radius: double);
var
  i,
  Row, Col: integer;
  theRows: PPRows;
  K: TKernel;
  ACol: PRow; P:PRow;

begin
  if (theBitmap.HandleType <> bmDIB) or (theBitmap.PixelFormat <> pf24Bit) then
    raise exception.Create('Blur only works for 24-bit bitmaps');

  MakeGaussianKernel(K, radius, 255, 1);

  GetMem(theRows, theBitmap.Height * SizeOf(PRow));
  GetMem(ACol, theBitmap.Height * SizeOf(TRGBTriplet));

  for Row := 0 to theBitmap.Height - 1 do
    theRows[Row] := theBitmap.Scanline[Row];

  P := AllocMem(theBitmap.Width*SizeOf(TRGBTriplet));
  for Row := 0 to theBitmap.Height - 1 do
  begin
    //Optimization: rows between 20 and Height - 20 are the same...
    if (Row > 20) and (Row < theBitmap.Height - 20) then
      //...so copy a previous row
      for i := 0 to theBitmap.Width do
        theRows[Row][i] := theRows[15][i]
    else
      BlurRow(Slice(theRows[Row]^, theBitmap.Width), @K, P);
  end;

  ReAllocMem(P, theBitmap.Height*SizeOf(TRGBTriplet));

  for Col := 0 to theBitmap.Width - 1 do
  begin
    //Optimization: rows between 20 and With - 20 are the same...
    if (Col > 20) and (Col < theBitmap.Width - 20) then
    begin
      //...so copy a previous col
      for Row := 0 to theBitmap.Height - 1 do
        theRows[Row][Col]:= theRows[Row][15];
      Continue;
    end;

    for Row := 0 to theBitmap.Height - 1 do
      ACol[Row] := theRows[Row][Col];

    BlurRow(Slice(ACol^, theBitmap.Height), @K, P);

    for Row := 0 to theBitmap.Height - 1 do
     theRows[Row][Col]:= ACol[Row];
  end;

  FreeMem(theRows);
  FreeMem(ACol);
  ReAllocMem(P, 0);
end;

procedure DrawRoundRect(Bitmap: TBitmap; W, H, BMPW: Integer; BMPPOS: TGlyphPosition; Thickness, Radius: Integer; Blur: Double);
var
  DC: HDC;
  P: HPEN;
  B: HBRUSH;
  I: Integer;
begin
  Bitmap.PixelFormat := pf24bit;

  Bitmap.Width := W;
  Bitmap.Height := H;

  DC := Bitmap.Canvas.Handle;

  // outer black rectangle
  FillRect(DC, Rect(0, 0, Bitmap.Width, Bitmap.Height), GetStockObject(BLACK_BRUSH));

  if Thickness > 0 then
  begin
    P := SelectObject(DC, CreatePen(PS_SOLID, Thickness, $FFFFFF));
    B := SelectObject(DC, GetStockObject(BLACK_BRUSH));
  end
  else
  begin
    P := SelectObject(DC, GetStockObject(WHITE_PEN));
    B := SelectObject(DC, GetStockObject(WHITE_BRUSH));
  end;

  I := 2;
  if BMPPOS = gpAfterControl then
    RoundRect(DC, I + Thickness shr 1, I + Thickness shr 1, W - BMPW - I - Thickness shr 1, H - I - Thickness shr 1, Radius, Radius)
  else
    RoundRect(DC, I + BMPW + Thickness shr 1, I + Thickness shr 1, W - I - Thickness shr 1, H - I - Thickness shr 1, Radius, Radius);

  if Thickness > 0 then
  begin
    SelectObject(DC, B);
    DeleteObject(SelectObject(DC, P));
  end
  else
  begin
    SelectObject(DC, B);
    SelectObject(DC, P);
  end;

  if (Blur > 0) then
    GBlur(Bitmap, Blur);
end;

//------------------------------------------------------------------------------

procedure WindowBlend(hwnd,hdc: THandle;Colorkey: TColor;Alpha:byte; r:trect);
var
  dw: dword;
  blnd: _BLENDFUNCTION;
  dskdc: THandle;
  size,src: TPoint;
  //si : TSize;
begin
  dw := GetWindowLong(hwnd, GWL_EXSTYLE);
  SetWindowLong(hwnd, GWL_EXSTYLE,dw or WS_EX_LAYERED);

  Dynalink_SetLayeredWindowAttributes(hwnd,DWORD(colorkey),Alpha,2);

  blnd.BlendOp := AC_SRC_OVER;
  blnd.BlendFlags := 0;
  blnd.SourceConstantAlpha := 0;
  blnd.AlphaFormat := 0;

  dskdc := getdc(0);
  size := point(r.right-r.left,r.bottom-r.top);
  src := point(r.left,r.top);
  Dynalink_UpdateLayeredWindow(hwnd, dskdc, nil, @size, hdc, @src, dword(colorkey), blnd, ULW_ALPHA);
  ReleaseDC(hwnd,dskdc);
end;

//------------------------------------------------------------------------------

function IsProcessWindow(Wnd: HWND): Boolean;
var
  Process: THandle;
begin
  Result := IsWindow(Wnd);
  if Result then
  begin
    GetWindowThreadProcessId(Wnd, @Process);
    Result := (Process = GetCurrentProcessID);
  end;
end;

//------------------------------------------------------------------------------


function MsgHookProc(Code: Integer; CurrentProcess: Cardinal; HookStruct: PCWPStruct): integer; stdcall;
var
  r: TRect;
  wc: TWinControl;
  wcp: TWinControl;
  frm: TWinControl;
  AllowShowFocus: boolean;
  i: integer;
  ph: THandle;
  pr,ir: TRect;
  winclass: array[0..255] of char;

begin
  case HookStruct.Message of
  WM_SETFOCUS:
     if IsProcessWindow(HookStruct.hwnd) then
     begin
       if Assigned(FocusHelperex) then
       begin
         wc := FindControl(HookStruct.hwnd);
         wcp := FindControl(GetParent(HookStruct.hwnd));

         AllowShowFocus := FocusHelperEx.AcceptControl(wc,wcp);

         if FocusHelperEx.ActiveBlur then
         begin
           if Assigned(FocusHelperEx.OnShowFocus) then
           begin
             FocusHelperEx.OnShowFocus(FocusHelperEx, wc, AllowShowFocus);
           end;
         end
         else
           AllowShowFocus := false;

         if (wc is TCustomForm) then
           AllowShowFocus := false;

         GetClassName(hookStruct.hwnd, winclass, sizeof(winclass));

         // Do not display focus indicator on dropdown of TDateTimePicker
         if StrComp(winclass,'SysMonthCal32') = 0 then
         begin
           AllowShowFocus := false;
         end;

         if AllowShowFocus then
         begin
           FocusHelperEx.FocusControl := HookStruct.hwnd;
           GetWindowRect(HookStruct.hwnd, r);

           if (wc is TCustomComboBox) or (wcp is TCustomComboBox) then
           begin
             if (wcp is TCustomComboBox) then
             begin
               GetWindowrect(wcp.Handle, r);
             end;
           end;

           ph := HookStruct.hwnd;
           repeat
             ph := GetParent(ph);

             if (ph <> 0) then
             begin
               GetWindowrect(ph, pr);
               if (pr.Right - pr.Left > 0) and (pr.Bottom - pr.Top > 0) then
               begin
                 IntersectRect(ir, pr, r);
                 r := ir;
               end;
             end;

             frm := Controls.FindControl(ph);
             if Assigned(frm) and (frm is TForm) then
               ph := 0;

           until (ph = 0);

           FocusHelperEx.FocusHeight := r.Bottom - r.Top;
           FocusHelperEx.FocusWidth := r.Right - r.Left;

           FocusHelperEx.ShowHelperOnControl(r);
         end;
       end;
     end;

  WM_CLOSE:
     begin
       FocusHelperEx.FocusControl := 0;
       FocusHelperEx.HideHelper;
     end;

  WM_WINDOWPOSCHANGING, WM_WINDOWPOSCHANGED:
     begin
       if IsChild(HookStruct.hwnd, FocusHelperEx.FocusControl) then
       begin
         GetWindowRect(FocusHelperEx.FocusControl, r);

         wc := FindControl(FocusHelperEx.FocusControl);
         wcp := FindControl(GetParent(FocusHelperEx.FocusControl));


         if Assigned(wcp) then
         begin
           if not wcp.Visible then
           begin
             FocusHelperEx.FocusControl := 0;
             FocusHelperEx.HideHelper;
           end;
         end;

         if (wc is TCustomComboBox) or (wcp is TCustomComboBox) then
         begin
           if (wcp is TCustomComboBox) then
           begin
             GetWindowrect(wcp.Handle, r);
           end;
         end;

         ph := FocusHelperEx.FocusControl;
         repeat
            ph := GetParent(ph);
            if (ph <> 0) then
            begin
              GetWindowrect(ph, pr);

              if (pr.Right - pr.Left > 0) and (pr.Bottom - pr.Top > 0) then
              begin
                IntersectRect(ir, pr, r);
                r := ir;
              end;
            end;
         until ph = 0;

         if (r.Bottom - r.Top = FocusHelperEx.FocusHeight) and
            (r.Right - r.Left = FocusHelperEx.FocusWidth) then
           FocusHelperEx.MoveHelper(r)
         else
         begin
           FocusHelperEx.FocusHeight := r.Bottom - r.Top;
           FocusHelperEx.FocusWidth := r.Right - r.Left;
           FocusHelperEx.ShowHelperOnControl(r);
         end;
       end;
     end;
  WM_KILLFOCUS:
     begin
       if FocusHelperEx.FocusControl <> 0 then
       begin
         FocusHelperEx.FocusControl := 0;
         FocusHelperEx.HideHelper;
       end;

       if IsProcessWindow(HookStruct.hwnd) then
       begin
         InvalidateRect(hookstruct.hwnd, nil, true);
       end;
     end;
  WM_SIZE:
     begin
     end;
  WM_ACTIVATE:
     begin

       wc := FindControl(HookStruct.hwnd);
       if Assigned(wc) then
       begin
         if (wc is TCustomForm) then
         begin
           if (hookstruct.wParam = WA_ACTIVE) or (hookstruct.wParam = WA_CLICKACTIVE) then
           begin
             for i := 0 to wc.ComponentCount - 1 do
             begin
               if (wc.Components[i] is TGoTabEnterBlur) then
               begin
                 FocusHelperEx := (wc.Components[i] as TGoTabEnterBlur);
               end;
             end;
           end
           else
           begin
             if FocusHelperEx.FocusControl <> 0 then
             begin
               FocusHelperEx.FocusControl := 0;
               FocusHelperEx.HideHelper;
             end;
           end;
         end;
       end;
     end;
  end;

  Result := CallNextHookEx(MsgHook, Code, CurrentProcess, Integer(HookStruct))
end;

//------------------------------------------------------------------------------


{ Create }

constructor TGoTabEnterBlur.Create(AOwner:TComponent);
var
  Instances, I: integer;
begin
  inherited Create(AOwner);
  FAutoSkip       := true;
  FActiveFocusColor   := False;
  FEnterKeyBoardArrows := true;
  FActiveEnter   := true;
  FFocusColor     := $00FEF7EB;
  FHintShowColor      := Application.HintColor;
  //
  FEnterClassListAllow  := TStringList.create;
  //
  FEnterClassListAllow.Add('TCustomEdit');
  FEnterClassListAllow.Add('TCustomMemo');
  FEnterClassListAllow.Add('TCustomListBox');
  FEnterClassListAllow.Add('TCustomCombo');
  FEnterClassListAllow.Add('TDateTimePicker');
  FEnterClassListAllow.Add('TCustomCheckBox');
  FEnterClassListAllow.Add('TRadioButton');
  //
  FFocusColorClassListNotAllow      := TStringList.create;
  FFocusColorClassListNotAllow.Add('TComboBox');
  FFocusColorClassListNotAllow.Add('TListBox');
  FFocusColorClassListNotAllow.Add('TMemo');
  FFocusColorClassListNotAllow.Add('TDBComboBox');
  FFocusColorClassListNotAllow.Add('TDBListBox');
  FFocusColorClassListNotAllow.Add('TDBMemo');

  // global variable
  FHasHook := false;

  //if not (Owner is TForm) then
  //raise Exception.Create('Control parent must be a form!');

  Instances := 0;

  for I := 0 to Owner.ComponentCount - 1 do
    if (Owner.Components[I] is TGoTabEnterBlur) then
      Inc(Instances);

  if (Instances > 1) then
    raise Exception.Create('The form already contains a TGobt_TabEnter component');

  FActiveBlur := true;
  FBlurSize := 4;
  FBlur := 3;
  FBlurColor :=  $FDD397;
  FBlurRounding := 5;
  FBlurOpacity := 230;
  FBlurRounding := 5;
  FGlyph := TBitmap.Create;
  FGlyphPosition := gpAfterControl;
  FW := TFocusWindowEx.Create(self);
  FBlurAllowControls := [icEdit,icMemo,icListBox,icComboBox,icDateTimePicker];


  if not (csDesigning in ComponentState) and (MsgHook = 0) then
  begin
    // assign the focus helper
    FocusHelperEx := self;
    // do the hooking here ....
    InitHook;
    FHasHook := true;
  end;


  if not( csDesigning in ComponentState ) then
  begin
    FOnMessageRescue      := Application.OnMessage;
    Application.OnMessage := LocalOnMessage;
    FOnIdleRescue         := Application.OnIdle;
    Application.OnIdle    := LocalOnIdle;
    FOnHintRescue         := Application.OnHint;
    Application.OnHint    := LocalOnHint;
    FOnHelpRescue         := Application.OnHelp;
  //  Application.OnHelp    := LocalOnHelp;    JEICKSON
  end;




end;

{ Destroy }
destructor TGoTabEnterBlur.Destroy;
begin
  FEnterClassListAllow.free;
  FFocusColorClassListNotAllow.Free;

  if Assigned( FOnMessageRescue ) then
    Application.OnMessage := FOnMessageRescue;

  if Assigned( FOnIdleRescue ) then
    Application.OnIdle := FOnIdleRescue;

  if Assigned( FOnHintRescue ) then
    Application.OnHint := FOnHintRescue;

  if Assigned( FOnHelpRescue ) then
    Application.OnHelp := FOnHelpRescue;


  FGlyph.Free;
  FW.Free;

  if not (csDesigning in ComponentState) and FHasHook then
  begin
    Unhook;
    FocusHelperEx := nil;
    FHasHook := false;
  end;


  inherited Destroy;
end;

procedure TGoTabEnterBlur.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation = opRemove) and (AComponent = FFocusControl) then
    FFocusControl := nil;
  inherited Notification(AComponent, Operation);
end;

procedure TGoTabEnterBlur.SetBlurActive(const Value: boolean);
begin
  FActiveBlur := Value;

  if not (csDesigning in ComponentState) then
  begin
    if not FActiveBlur then
    begin
      if (Owner is TCustomForm) then
        SendMessage((Owner as TCustomForm).Handle, WM_KILLFOCUS, 0,0);
    end
    else
    begin
      if (Owner is TCustomForm) then
      begin
        SendMessage(Winapi.Windows.GetFocus(), WM_SETFOCUS, 0 , 0);
      end;
    end;
  end;
end;

procedure TGoTabEnterBlur.SetBlur(const Value: integer);
begin
  if (Value >= 0) and (Value < 10) then
    FBlur := Value;
end;

procedure TGoTabEnterBlur.SetClassListAllow( AClassList: TStringList );
begin
  FEnterClassListAllow.Assign(AClassList);
end;

procedure TGoTabEnterBlur.SetClassListNotAllow( AColorList: TStringList );
begin
  FFocusColorClassListNotAllow.Assign(AColorList);
end;


procedure TGoTabEnterBlur.SetGlyph(const Value: TBitmap);
begin
  FGlyph.Assign(Value);
end;

procedure TGoTabEnterBlur.SetBlurSize(const Value: integer);
begin
  if (Value >= 0) and (Value < 15) then
    FBlurSize := Value;
end;

procedure TGoTabEnterBlur.SetVersion(const Value: string);
begin
  // readonly
end;

procedure TGoTabEnterBlur.ShowHelper;
begin
  if Assigned(FocusHelperEx) then
    ShowWindow(FocusHelperEx.FW.Handle, SW_SHOWNOACTIVATE);
end;

procedure TGoTabEnterBlur.ShowHelperOnControl(R: TRect);
var
  A,B,C: THandle;
  AlphaMask: TAlphaMask;
  Bitmap: TBitmap;
  MaskBitmap: TBitmap;
  GlyphBitmap: TBitmap;
  W,H: integer;
  BMPW: integer;
  BMPO: integer;
begin
  W := r.Right - r.Left + (FocusHelperEx.BlurSize * 2) + 1;
  H := r.Bottom - r.Top + (FocusHelperEx.BlurSize * 2) + 1;

  BMPW := 0;
  BMPO := 0;

  if Assigned(FocusHelperEx.Glyph) and not FocusHelperEx.Glyph.Empty then
  begin
    BMPW := 2 * 2 + FocusHelperEx.Glyph.Width;
    W := W + BMPW;

    if FocusHelperEx.Glyph.Width < H then
      BMPO := (H - FocusHelperEx.Glyph.Width) div 2;
  end;

  FocusHelperEx.FW.Visible := false;
  FocusHelperEx.FW.Width := W;
  FocusHelperEx.FW.Height := H;

  AlphaMask := TAlphaMask.Create;
  try
    MaskBitmap := TBitmap.Create;
    MaskBitmap.PixelFormat := pf24bit;
    MaskBitmap.Width := W;
    MaskBitmap.Height := H;

    Bitmap := TBitmap.Create;
    Bitmap.PixelFormat := pf24bit;
    Bitmap.Width := W;
    Bitmap.Height := H;

    try
      MaskBitmap.Canvas.Brush.Color := clBlack;
      MaskBitmap.Canvas.Brush.Style := bsSolid;
      MaskBitmap.Canvas.Pen.Color := clBlack;
      MaskBitmap.Canvas.Pen.Style := psSolid;
      MaskBitmap.Canvas.Rectangle(0,0,W,H);

      DrawRoundRect(MaskBitmap, W, H, BMPW, FocusHelperEx.GlyphPosition, FocusHelperEx.BlurSize, FocusHelperEx.BlurRounding, FocusHelperEx.Blur);

      if Assigned(FocusHelperEx.Glyph) and not FocusHelperEx.Glyph.Empty then
      begin
        GlyphBitmap := TBitmap.Create;
        try
          GlyphToMask(FocusHelperEx.Glyph, GlyphBitmap);
          if FocusHelperEx.GlyphPosition = gpAfterControl then
            MaskBitmap.Canvas.Draw(W - BMPW + 2, BMPO, GlyphBitmap)
          else
            MaskBitmap.Canvas.Draw(2, BMPO, GlyphBitmap);
        finally
          GlyphBitmap.Free;
        end;
      end;

      Bitmap.Canvas.Pen.Color := FocusHelperEx.BlurColor;
      Bitmap.Canvas.Pen.Width := 1;
      Bitmap.Canvas.Brush.Color := FocusHelperEx.BlurColor;
      Bitmap.Canvas.Brush.Style := bsSolid;
      Bitmap.Canvas.Rectangle(0,0,bitmap.width,bitmap.height);

      if Assigned(FocusHelperEx.Glyph) and not FocusHelperEx.Glyph.Empty then
      begin
        FocusHelperEx.Glyph.TransparentMode := tmAuto;
        FocusHelperEx.Glyph.Transparent := true;
        if FocusHelperEx.GlyphPosition = gpAfterControl then
          Bitmap.Canvas.Draw(W - BMPW + 2, BMPO, FocusHelperEx.Glyph)
        else
          Bitmap.Canvas.Draw(2, BMPO, FocusHelperEx.Glyph)
      end;

      AlphaMask.MergeMask(MaskBitmap, Bitmap, clYellow);
    finally
      Bitmap.Free;
      MaskBitmap.Free;
    end;

    AlphaMask.Opacity := FocusHelperEx.BlurOpacity;
    UpdateAlphaWindow(FocusHelperEx.FW.Handle, AlphaMask);
  finally
    AlphaMask.Free;
  end;

  if not ( (GlyphPosition = gpBeforeControl) and Assigned(Glyph) and not Glyph.Empty) then
  begin
    BMPW := 0;
  end;

  A := CreateRectRgn(0, 0, W, H);
  B := CreateRectRgn(0, 0, R.Right - R.Left, R.Bottom - R.Top);

  OffsetRgn(B, FocusHelperEx.BlurSize + BMPW, FocusHelperEx.BlurSize);
  C := CreateRectRgn(0, 0, 1, 1);
  CombineRgn(C, A, B, RGN_XOR);
  SetWindowRgn(FocusHelperEx.FW.Handle, C, False);
  DeleteObject(A);
  DeleteObject(B);

  MoveWindow(FocusHelperEx.FW.Handle, r.Left - FocusHelperEx.BlurSize - BMPW, r.Top - FocusHelperEx.BlurSize, W, H, true);
  ShowWindow(FocusHelperEx.FW.Handle, SW_SHOWNOACTIVATE);
end;


procedure TGoTabEnterBlur.LocalOnMessage(var Msg: TMsg; var Handled: Boolean);
var
  pMaxLengthPropInfo,
  pColorPropInfo,
  pOnKeyDownPropInfo: PPropInfo;
  intMaxLength,
  intSelStart: integer;
begin
 //intMaxLength := 0;
   intSelStart := 0;
  //-------------------------------------------------------------------------
  // Controle de Focus Color do Componente
  //-------------------------------------------------------------------------
  try
    if (FActiveFocusColor) then
    begin
      if ( FActiveControl <> Screen.ActiveControl ) then
      begin
        // if the control was out then turn off the hint window
        if ( FHintWindow <> nil ) then
        begin
          FHintWindow.ReleaseHandle;
          FHintWindow := nil;
        end;
        // Changed = ActiveControl
        if FActiveControl <> Screen.ActiveControl then
        begin
          FActiveControl := Screen.ActiveControl;
          DoShowHint(FActiveControl);
        end;
        // if focus control <> nil then the control was changed
        if (FFocusControl <> nil) then
        begin
           //JEICKSON
           // Antes de setar de volta a cor, verifico se o component nao esta sendo destruido
           if not( csDestroying in FFocusControl.ComponentState ) then
           begin
             if Length(FFocusControl.Name) > 0  then
             begin
               pColorPropInfo := GetPropInfo( FFocusControl.ClassInfo, 'Color' );
               if ( pColorPropInfo <> nil ) then
                 SetOrdProp( FFocusControl, 'Color', FFocusColorReturn );
             end;
           end;
           FFocusControl := nil;
        end;
        // Debugando...
//        TForm(GetParentForm(Screen.ActiveControl)).Caption := Screen.ActiveControl.ClassName;
        //
        // The new control is geting
        if Screen.ActiveControl = nil then exit;
        if (CheckClassList(Screen.ActiveControl.ClassName, Screen.ActiveControl.Name)) and
           (Screen.ActiveControl.Tag < 9999) and
           (not CheckColorList(Screen.ActiveControl.ClassName, Screen.ActiveControl.Name)) then
        begin
          FFocusControl := Screen.ActiveControl;
        end
        else
          FFocusControl := nil;

        // Set the Focus Color to new control
        if (FFocusControl <> nil) then
        begin
          pColorPropInfo := GetPropInfo( FFocusControl.ClassInfo, 'Color' );
          if ( pColorPropInfo <> nil ) then
          begin
            FFocusColorReturn := GetOrdProp( FFocusControl, pColorPropInfo );
            SetOrdProp( FFocusControl, 'Color', FFocusColor );
          end;
        end;

        // Changed = ActiveControl
//        if FActiveControl <> Screen.ActiveControl then
//        begin
//          FActiveControl := Screen.ActiveControl;
//          DoShowHint(FActiveControl);
//        end;
      end;
    end;
  except
     FFocusControl  := nil;
     FActiveControl := nil;
  end;
  //-------------------------------------------------------------------------
  // Controle de Focus Color do Componente
  //-------------------------------------------------------------------------
  if FActiveEnter then
  if Screen <> nil then
  if Screen.ActiveControl <> nil then
  if (Msg.message = WM_KEYDOWN) and
     (CheckClassList(Screen.ActiveControl.ClassName, Screen.ActiveControl.Name)) and
     (Screen.ActiveControl.Tag < 9999) then
  begin
    case Msg.wParam of
      VK_RETURN:  if ( Screen.ActiveControl is TCustomGrid ) then
                  begin
                    if ( Screen.ActiveControl is TDBGrid ) then Msg.wParam := VK_TAB
                    else
                    Msg.wParam := VK_Right;
                  end
                  else
                  if (Screen.ActiveControl is TCustomMemo) then
                  begin
                     if TDBMemo(Screen.ActiveControl).DataSource.DataSet.State in [dsBrowse] then
                        Msg.wParam := VK_TAB;
                     end
                     else
                     begin
                       pOnKeyDownPropInfo := GetPropInfo( Screen.ActiveControl.ClassInfo, 'OnKeyDown' );

                       if ( Screen.ActiveControl is TCustomComboBox ) then
                       begin
                         if not ( Screen.ActiveControl as TCustomComboBox ).DroppedDown then Msg.wParam := VK_TAB;
                       end
                       else
                       begin
                         if ( pOnKeyDownPropInfo <> nil ) then
                         if ( GetOrdProp( Screen.ActiveControl, pOnKeyDownPropInfo ) = 0 ) then
                         Msg.wParam := VK_TAB;

                         // Rotina colocada por Jeickson - Pq nao estava funcionando o enter nos relatorios
                         if ( pOnKeyDownPropInfo <> nil ) then
                         if ( GetOrdProp( Screen.ActiveControl, pOnKeyDownPropInfo ) <> 0 ) then
                         Msg.wParam := VK_TAB;
                       end;
                  end;


      VK_DOWN  :  if (FEnterKeyBoardArrows) and not( Screen.ActiveControl is TCustomGrid ) and not
                     (tbKeyIsDown(VK_CONTROL)) then
                  begin
                     if (Screen.ActiveControl is TCustomCombo) then
                     begin
                        // Só executa o TAB se o combo estiver fechado.
                        if (not TCustomComboBox(Screen.ActiveControl).DroppedDown) then
                           Msg.wParam := VK_TAB
                     end
                     else if (Screen.ActiveControl is TCustomEdit) then
                     begin
                       Msg.wParam := VK_TAB;
                     end
                     else
                       Msg.wParam := VK_TAB;
                  end;
      VK_UP    :  if (FEnterKeyBoardArrows) and not( Screen.ActiveControl is TCustomGrid ) and not
                     (tbKeyIsDown(VK_CONTROL)) then
                  begin
                     if (Screen.ActiveControl is TCustomCombo) then
                     begin
                        // Só executa o SHIFT+TAB se o combo estiver fechado.
                        if (not TCustomComboBox(Screen.ActiveControl).DroppedDown) then
                        begin
                           Msg.wParam := VK_CLEAR;
                           keybd_event(VK_SHIFT,0,0,0);
                           keybd_event(VK_TAB,0,0,0);
                           Keybd_event(VK_SHIFT,0,Keyeventf_keyup,0);
                        end;
                     end
                     else if (Screen.ActiveControl is TCustomEdit) then
                     begin
                        Msg.wParam := VK_CLEAR;
                        keybd_event(VK_SHIFT,0,0,0);
                        keybd_event(VK_TAB,0,0,0);
                        Keybd_event(VK_SHIFT,0,Keyeventf_keyup,0);
                     end
                     else
                     begin
                        Msg.wParam := VK_CLEAR;
                        keybd_event(VK_SHIFT,0,0,0);
                        keybd_event(VK_TAB,0,0,0);
                        Keybd_event(VK_SHIFT,0,Keyeventf_keyup,0);
                     end;
                  end;
      VK_BACK  :  ;


    else
      // Mais um codigo em quarentena
      // if ( Screen.ActiveControl is TCustomEdit ) and
       if  (CheckClassList(Screen.ActiveControl.ClassName, Screen.ActiveControl.Name)) and
           ( FAutoSkip ) then
       begin
         { Verifica a propriedade MaxLength }
         pMaxLengthPropInfo := GetPropInfo( Screen.ActiveControl.ClassInfo, 'MaxLength' );

         { Verifica a propriedade SelStart }
         { furada, GetPropInfo só trabalha com Published }
         { pSelStartPropInfo := GetPropInfo( Screen.ActiveControl.ClassInfo, 'SelStart' ); }

         if ( pMaxLengthPropInfo <> nil ) then
         begin

           { Pega os valores das propriedades }
           intMaxLength := GetOrdProp( Screen.ActiveControl, pMaxLengthPropInfo );

           // Ainda preciso deixar esse codigo mais bonito :(((
           if ( Screen.ActiveControl is TCustomComboBox ) then
             intSelStart  := ( Screen.ActiveControl as TCustomCombobox ).SelStart;

           if ( Screen.ActiveControl is TCustomEdit ) then
             intSelStart  := ( Screen.ActiveControl as TCustomEdit).SelStart;
           // =============================================

           if ( intMaxLength <> 0 ) and
              ( intMaxLength = ( intSelStart + 1 ) ) then
             keybd_event(13,0,0,0);
         end;
       end;
    end;
  end;
  if Assigned( FOnMessageRescue ) then FOnMessageRescue( Msg, Handled );
  if Assigned( FOnMessage ) then FOnMessage( Msg, Handled );
end;

procedure TGoTabEnterBlur.MoveHelper(R: TRect);
var
  BMPW: integer;
begin
  BMPW := 0;

  if (GlyphPosition = gpBeforeControl) and Assigned(Glyph) and not Glyph.Empty then
  begin
    BMPW := Glyph.Width + 2 * 2;
  end;

  MoveWindow(FocusHelperEx.FW.Handle,
    r.Left - FocusHelperEx.BlurSize - BMPW,
    r.Top - FocusHelperEx.BlurSize,
    r.Right - r.Left + 2 * FocusHelperEx.BlurSize,
    r.Bottom - r.Top + 2 * FocusHelperEx.BlurSize, true);
end;

procedure TGoTabEnterBlur.LocalOnIdle(Sender: TObject; var Done: Boolean);
begin
  if not (csDestroying in Application.ComponentState) then
  begin
     if Assigned( FOnIdleRescue ) then FOnIdleRescue( Sender, Done );
     if Assigned( FOnIdle ) then FOnIdle( Sender, Done );
  end;
end;

procedure TGoTabEnterBlur.LocalOnHint(Sender: TObject);
begin
  if not (csDestroying in Application.ComponentState) then
  begin
     if Assigned( FOnHintRescue ) then FOnHintRescue( Sender );
     if Assigned( FOnHint ) then FOnHint( Sender );
  end;
end;

function  TGoTabEnterBlur.LocalOnHelp(Command: word; Data: Longint; var CallHelp: Boolean):Boolean;
begin
  result := true;
  if not (csDestroying in Application.ComponentState) then
  begin
    if Assigned( FOnHelpRescue ) then result:= FOnHelpRescue( Command, Data, CallHelp );
    if Assigned( FOnHelp ) then result:= FOnHelp( Command, Data, CallHelp );
  end;
end;

function TGoTabEnterBlur.AcceptControl(wc, wcp: TWinControl): boolean;
begin
  Result := False;

  if (BlurAllowControls <> []) then
  begin
    if (icEdit in BlurAllowControls) and (wc is TCustomEdit) and not (wc is TCustomMemo) then
      Result := true;
    if (icMemo in BlurAllowControls) and (wc is TCustomMemo) then
      Result := true;
    if (icListBox in BlurAllowControls) and (wc is TCustomListBox) then
      Result := true;
    if (icComboBox in BlurAllowControls) and ((wcp is TCustomComboBox) or (wc is TCustomComboBox)) then
      Result := true;
    if (icDateTimePicker in BlurAllowControls) and (wc is TDateTimePicker) then
      Result := true;
    if (icCheckBox in BlurAllowControls) and (wc is TCheckBox) then
      Result := true;
    if (icRadioButton in BlurAllowControls) and (wc is TRadioButton) then
      Result := true;

    if (wc is TWinControl) then
      if (icTagValue in BlurAllowControls) and ((wc as TWinControl).Tag = BlurControlTag) then
        Result := true;

  end;
end;

function TGoTabEnterBlur.CheckClassList( AClassName, AObjectName: string ): Boolean;
var
  intX : integer;
begin
  Result := false;
  for intX := 0 to FEnterClassListAllow.Count-1 do
  begin
     Result := AnsiCompareText( UpperCase(AClassName), UpperCase(FEnterClassListAllow.Strings[intX]) ) = 0;
     //if not result then result := AnsiCompareText( UpperCase(AObjectName), UpperCase(FClassList.Strings[intX]) ) = 0;
     if result then break;
  end;
end;

function TGoTabEnterBlur.CheckColorList( AColorClass, AObjectName: string ): Boolean;
var
  intX: Integer;
begin
   Result := False;
   for intX := 0 to FFocusColorClassListNotAllow.Count -1 do
   begin
      Result := AnsiCompareText( AColorClass, FFocusColorClassListNotAllow.Strings[intX] ) = 0;
      //if not result then result := AnsiCompareText( UpperCase(AObjectName), UpperCase(FColorList.Strings[intX]) ) = 0;
      if Result then break;
   end;
end;

procedure TGoTabEnterBlur.DoShowHint( Control : TWinControl );
var
  lPoint : TPoint;
  lHintRect: TRect;
  lHintWindow: THintWindow;

begin
  if Control = nil then exit;
  if (Control.Hint = '') or
     not( ActiveHintShow ) then Exit;

  lHintWindow := HintWindow;
  lHintWindow.Color := FHintShowColor;

  { display hint below bottom left corner of speed button }
  lPoint.X := 0;
  lPoint.Y := Control.Height;

  { convert to scree corrdinates }
  lPoint := Control.ClientToScreen(lPoint);

  { set hint window size & position }
  lHintRect.Left   := lPoint.X;
  lHintRect.Top    := lPoint.Y ;
  lHintRect.Right  := lHintRect.Left +  lHintWindow.Canvas.TextWidth(Control.Hint)  + 6;
  lHintRect.Bottom := lHintRect.Top  +  lHintWindow.Canvas.TextHeight(Control.Hint) + 2;

  lHintWindow.Visible := True;
  lHintWindow.ActivateHint(lHintRect, Control.Hint);
end;


function TGoTabEnterBlur.GetVersion: string;
var
  vn: Integer;
begin
  vn := GetVersionNr;
  Result := IntToStr(Hi(Hiword(vn)))+'.'+IntToStr(Lo(Hiword(vn)))+'.'+IntToStr(Hi(Loword(vn)))+'.'+IntToStr(Lo(Loword(vn)));
end;

function TGoTabEnterBlur.GetVersionNr: Integer;
begin
  Result := MakeLong(MakeWord(BLD_VER,REL_VER),MakeWord(MIN_VER,MAJ_VER));
end;

procedure TGoTabEnterBlur.HideHelper;
begin
  if Assigned(FocusHelperEx) then
    ShowWindow(FocusHelperEx.FW.Handle, SW_HIDE);
end;

procedure TGoTabEnterBlur.InitHook;
begin
  MsgHook := SetWindowsHookEx(WH_CALLWNDPROC, @MsgHookProc, 0, GetCurrentThreadID);
end;

function TGoTabEnterBlur.tbKeyIsDown(const Key: integer): boolean;
begin
  Result := GetKeyState(Key) and 128 > 0;
end;

procedure TGoTabEnterBlur.Unhook;
begin
  if MsgHook <> 0 then
     UnhookWindowsHookEx(MsgHook);
  MsgHook := 0;
end;

procedure TGoTabEnterBlur.UpdateHelper;
begin
  SendMessage(Winapi.Windows.GetFocus(), WM_SETFOCUS, 0, 0);
end;

{******************************************************************************
 *
 ** I N I T I A L I Z A T I O N   /   F I N A L I Z A T I O N
 *
{******************************************************************************}

{ TFocusWindowEx }

constructor TFocusWindowEx.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 0;
  Height := 0;
  Color := clRed;
end;

procedure TFocusWindowEx.CreateParams(var Params: TCreateParams);
begin
  inherited;
  Params.Style := WS_POPUP or WS_DISABLED;
  Params.ExStyle := WS_EX_TOPMOST or WS_EX_TOOLWINDOW; /// or WS_EX_TRANSPARENT;
end;

procedure TFocusWindowEx.CreateWnd;
begin
  inherited;
end;

procedure TFocusWindowEx.Paint;
begin
  inherited;
end;

{ TAlphaMask }

procedure TAlphaMask.Assign(Source: TPersistent);
var
  AlphaMap: TAlphaMask absolute Source;
  I: Integer;
begin
  if Source is TAlphaMask then
  begin
    Opacity := AlphaMap.Opacity;
    for I := 0 to Height - 1 do
      Move(AlphaMap.ScanLine[I]^, ScanLine[I]^, Width * SizeOf(TRGBA));
  end
  else
    inherited Assign(Source);
  PixelFormat := pf32bit;
end;

constructor TAlphaMask.Create;
begin
  inherited Create;
  PixelFormat := pf32bit;
  FOpacity := $FF;
end;

procedure TAlphaMask.MergeMask(Mask, Bitmap: TBitmap; Color: TColor);
var
  Fill: TRGBA;
  Swap: Byte;
  A: PRGBA;
  B: PRGB;
  C: PRGB;
  X, Y: Integer;
begin
  if Bitmap.PixelFormat <> pf24Bit then
    Exit;

  Width := Bitmap.Width;
  Height := Bitmap.Height;

  Fill := TRGBA(ColorToRGB(Color));
  Swap := Fill.Blue;
  Fill.Blue := Fill.Red;
  Fill.Red := Swap;

  for Y := 0 to Height - 1 do
  begin
    A := ScanLine[Y];
    B := Bitmap.Scanline[Y];
    C := Mask.ScanLine[Y];

    for X := 0 to Width - 1 do
    begin
      A.Alpha := C.Red;
      A.Red := Round(B.Red * (C.Red / $FF));
      A.Green := Round(B.Green * (C.Red / $FF));
      A.Blue := Round(B.Blue * (C.Red / $FF));

      Inc(A);
      Inc(B);
      Inc(C);
    end;
  end;
end;

initialization
  FHintWindow := nil;

finalization
  FHintWindow := nil;

end.





