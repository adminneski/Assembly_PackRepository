unit frxExportPSDocument;

interface

{$I frx.inc}

uses
{$IFNDEF Linux}
  Windows,
{$ELSE}
  LCLType, LCLIntf, LCLProc,
{$ENDIF}
  Messages, frxExportBaseDialog, SysUtils, Classes, Graphics, frxClass, frxExportMatrix, Math, frxBarcod, frxBarcode, frxBarcode2D,
  frxBarcodeMaxiCode, frxTableObject, frxRes, frxImageConverter, frxExportPSHelper;

type
  PSDocument = class
  protected
    psData: String;
    windowWidth, windowHeight: Double;

  protected
    procedure CreateWindow(name: String; Width, Height: Double); virtual;

    procedure createText(x, y: Double; HorizontalAlignment: TfrxHAlign; VerticalAlignment: TfrxVAlign; Width, Height: Double; font: TFont; textstr: String;
                PaddingLeft, PaddingRight, PaddingTop, PaddingBottom, BorderThickness: Double; Foreground, Background: String; Angle, Indent: Double);
    function TextAlignments(x: Double; var y: Double; HorizontalAlignment: TfrxHAlign; VerticalAlignment: TfrxVAlign; Width, Height: Double; font: TFont; txt_lns: TStringList;
               PaddingLeft, PaddingRight, PaddingTop, PaddingBottom, BorderThikness: Double): AOF;

    procedure MoveTo(x, y: Double);

    //procedure AppendBezier(x, y: Double;p1, p2, p3: TPoint);
    procedure AppendLine(x2, y2: Double);
    procedure StartFig(StrokeThickness: Double);
    function PSFont(font: String): String;
    //procedure EndFig(stroke, fill: String); overload;
    procedure EndFig(stroke: String);// overload;
    function ColorToPsRgb(htmlcolor: String): String;
    function FloatToString(flt: Double): String;
    //procedure ClosePath();
  public
    procedure AddPage(); virtual;
    procedure PSWrite(s: String);
    procedure PSWriteLn(s: String);

    procedure Convert(var left, top, width, height: Double);

    procedure AddTextLine(t_x: AOF; t_y: Double; Foreground: String; font: TFont; Width, Height: Double; txt_lns: TStringList; Angle, Indent: Double);

    procedure AddRectangle(x, y, Width, Height: Double; Stroke: String; StrokeThickness: Double; Fill: String; Rounded: Boolean);
    procedure AddEllipse(x, y, Width, Height: Double; Stroke: String; StrokeThickness: Double; Fill: String);
    procedure AddTriangle(x, y, Width, Height: Double; Stroke: String; StrokeThickness: Double; Fill: String);
    procedure AddDiamond(x, y, Width, Height: Double; Stroke: String; StrokeThickness: Double; Fill: String);
    procedure AddLine(x, y, x2, y2: Double; Stroke: String; StrokeThickness: Double; dash: TfrxFrameStyle); overload;
    procedure AddLine(x, y, x2, y2: Double; Stroke: String; StrokeThickness: Double); overload;
    procedure AddBezier(x, y: Double; p0, p1, p2, p3: TPoint; Stroke: String; StrokeThickness: Double);
    procedure AddImage(data: String;left, top, width, height: Double; pwidth, pheight: Integer; Involve: Boolean = True);

    procedure AddTextObject(x, y, Width, Height: Double;
       HorizontalAlignment: TfrxHAlign; VerticalAlignment: TfrxVAlign; BorderBrush: String;
       BorderThickness, LeftLine, TopLine, RightLine, BottomLine: Double;
       LeftLineDashStile, TopLineDashStile, RightLineDashStile, BottomLineDashStile: TfrxFrameStyle;
       colorLeftLine, colorTopLine, colorRightLine, colorBottomLine: String; Shadow: Boolean;
       ShadowColor: String; ShadowWidth: Double; Background: String; Typ: TfrxFrameTypes;Text, Foreground: String;
       PaddingLeft, PaddingTop, PaddingRight, PaddingBottom: Double;
       WordWrap: Boolean; Angle: Double; Glass: Boolean; colorTop: String; font: TFont; FIndent: Double);

    constructor Create(); overload;
    constructor Create(name: String; Width, Height: Double); overload;
    procedure Save(stream: TStream); overload; virtual;
    procedure Save(fn: String); overload; virtual;
    procedure Finish(); virtual;
end;


implementation

uses frxUtils;

function PSDocument.FloatToString(flt: Double): String;
begin
  result := FloatToStrF(flt, ffFixed, 18, 2);
  result  := StringReplace(result, ',', '.', [rfReplaceAll, rfIgnoreCase]);
  if (result[length(result)] = '0') then
  begin
    delete(result, length(result), 1);
    if (result[length(result)] = '0') then
      delete(result, length(result)-1, 2);
  end;
end;

procedure PSDocument.CreateWindow(name: String; Width, Height: Double);
begin
 { PSWriteLn('%!PS-Adobe');
  PSWriteLn('%%Title: postscriptdoc');
  PSWriteLn('%%Creator: FastReport');
  PSWriteLn('%%BoundingBox:   0   0   595   842');
  PSWriteLn('%% Pages: (atend)');
  PSWriteLn('%% DocumentFonts:');
  PSWriteLn('%% EndComments');
  PSWriteLn('%% EndProlog');
  PSWriteLn('%% Page: 1 1');  }
  windowHeight := Height * 2.835;
  windowWidth := Width * 2.835;
  if (Round(windowWidth) = 595) and (Round(windowHeight) = 842) then
    PSWrite('a4 ');
end;

procedure PSDocument.createText(x, y: Double; HorizontalAlignment: TfrxHAlign; VerticalAlignment: TfrxVAlign; Width, Height: Double; font: TFont; textstr: String;
            PaddingLeft, PaddingRight, PaddingTop, PaddingBottom, BorderThickness: Double; Foreground, Background: String; Angle, Indent: Double);
var
  t_x: AOF;
  t_y: Double;
  txt_lns: TStringList;
  n: Integer;
begin
  t_y := y;

  txt_lns := TStringList.Create();
  txt_lns.Text := textstr;
  for n := 0 to txt_lns.Count - 1 do
  begin
    txt_lns[n] := txt_lns[n] + ' ';
  end;

  t_x := TextAlignments(x, t_y, HorizontalAlignment, VerticalAlignment, Width, Height, font, txt_lns, PaddingLeft, PaddingRight, PaddingTop, PaddingBottom, BorderThickness);

  AddTextLine(t_x, t_y, Foreground, font, Width, Height, txt_lns, Angle, Indent);
  FreeAndNil(txt_lns);
end;

procedure PSDocument.MoveTo(x, y: Double);
begin
  PSWrite(' ' + FloatToString(x) + ' ' + FloatToString(windowHeight - y) + ' moveto ');
end;

procedure PSDocument.AddTextLine(t_x: AOF; t_y: Double; Foreground: String; font: TFont; Width, Height: Double; txt_lns: TStringList; Angle, Indent: Double);
var
  fstart: Boolean;
  internal_data, gsave, coords, text_col: String;
  cur_y: Double;
  i: Integer;
begin
  fstart := true;
  internal_data := '';
  cur_y := 0;

  for i := 0 to txt_lns.Count-1 do
  begin
    text_col := ColorToPsRgb(Foreground);

    if (Angle = 0) then
    begin
      internal_data := '/' + PSFont(font.Name) + ' findfont ';
      internal_data := internal_data + FloatToString(font.Size) + ' scalefont setfont ';
      internal_data := internal_data + FloatToString(t_x[i]);
      internal_data := internal_data + ' ' + FloatToString(windowHeight - t_y - Height) + ' moveto ' + text_col + ' setrgbcolor (';
      internal_data := internal_data + txt_lns[i] + ') show ';
    end
    else
    begin
      if (Angle <= 90) then
      begin
        t_x[i] := Width / 2;
        t_y := t_y - Height / 2;
      end;

      if (fstart) then
      begin
        gsave := ' gsave ';
        fstart := false;
        coords := FloatToString(t_x[i]) + ' ' + FloatToString(windowHeight - t_y - Height) + ' translate 0 0 moveto ' + FloatToString(-Angle) + ' rotate ';
      end
      else
      begin
        gsave := '';
        coords := FloatToString(t_x[i] - t_x[0]) + ' ' + FloatToString(cur_y) + ' moveto ';
      end;
      cur_y := cur_y - font.Height * 0.75;                                      //not sure
      internal_data := gsave + '/' + font.Name + ' findfont ' + FloatToString(font.Size) + ' scalefont setfont ' +
      coords + text_col + ' setrgbcolor (' + txt_lns[i] + ') show ';
      if (i = txt_lns.Count - 1) then
        internal_data := internal_data + 'grestore ';
    end;
    PSWriteLn(internal_data + ' ');
    t_y := t_y + font.Size * Indent;
  end;
end;

function PSDocument.TextAlignments(x: Double; var y: Double; HorizontalAlignment: TfrxHAlign; VerticalAlignment: TfrxVAlign; Width, Height: Double; font: TFont; txt_lns: TStringList;
           PaddingLeft, PaddingRight, PaddingTop, PaddingBottom, BorderThikness: Double): AOF;
var
  objBmpImage: TBitmap;
  Xold, Yold: Double;
  n, i: Integer;
  x_alignments: AOF;
begin
  objBmpImage := TBitmap.Create();
  objBmpImage.Canvas.Font := font;

  Xold := x;
  Yold := y;
  n := txt_lns.Count;
  SetLength(x_alignments, txt_lns.Count);
  for i := 0 to txt_lns.Count - 1 do
    case (HorizontalAlignment) of
      haCenter:
        x_alignments[i] := (x + Width / 2 - objBmpImage.Canvas.TextWidth(String(txt_lns[i])) / 2 * 0.75);
      haRight:
        x_alignments[i] := (x + Width - objBmpImage.Canvas.TextWidth(String(txt_lns[i])) * 0.75);
      haLeft, haBlock: x_alignments[i] := x;
    end;
  case (VerticalAlignment) of
    vaCenter:
    begin
      y := y - Height / 2 + (font.Size)/2;
      if (N > 1) then y := y - (font.Size) / 2 * N;
    end;
    vaTop:
      y := y - Height + font.Size;
    vaBottom:
      if (N > 1) then y := y - font.Size * N;
  end;
  //Paddings
  if (Yold - Height + font.Size + PaddingTop > y) then
  begin
    y := Yold - Height + font.Size + PaddingTop;
  end;
  if (Yold - PaddingBottom < y) then
  begin
    y := Yold - PaddingBottom;
  end;
  for i := 0 to  length(x_alignments) - 1 do
  begin
    if (Xold + PaddingLeft > x_alignments[i]) then
    begin
      x_alignments[i] := Xold + PaddingLeft;
    end;
    if (Xold + Width - PaddingRight < x_alignments[i]) then
    begin
      x_alignments[i] := Xold + Width - PaddingRight;
    end;
  end;
  result := x_alignments;
  FreeAndNil(objBmpImage);
end;

procedure PSDocument.AddRectangle(x, y, Width, Height: Double; Stroke: String; StrokeThickness: Double; Fill: String; Rounded: Boolean);
var
  rgb_stroke, rgb_fill, fill_str, border_col, rect_stroke, gsave, grestore, internal_data, x1, y1, x2, y2, x3, y3, x4, y4: String;
begin
  if ((StrokeThickness = 0) and (Fill = 'none')) then
    Exit;
  fill_str := '';
  border_col := '';
  rect_stroke := '';
  gsave := 'gsave ';
  grestore := 'grestore ';

  if (StrokeThickness = 0) then
  begin
    gsave := '';
    grestore := '';
  end
  else
  begin
    rgb_stroke := ColorToPsRgb(Stroke);
    border_col := rgb_stroke + ' setrgbcolor ';
  end;
  if (Fill <> 'none') then
  begin
    rgb_fill := ColorToPsRgb(Fill);
    fill_str := gsave + rgb_fill + ' setrgbcolor fill ' + grestore;
  end;

  rect_stroke := FloatToString(StrokeThickness) + ' setlinewidth ';
  if (Rounded) then
  begin
    x1 := FloatToString(x);
    y1 := FloatToString(windowHeight - y - Height);
    x2 := FloatToString(x);
    y2 := FloatToString(windowHeight - y);
    x3 := FloatToString(x + Width);
    y3 := FloatToString(windowHeight - y); ;
    x4 := FloatToString(x + Width);
    y4 := FloatToString(windowHeight - y - Height);
    internal_data := FloatToString(StrokeThickness) + ' setlinewidth ' + FloatToString(x + Width/2) + ' ' +
    FloatToString(windowHeight - y - Height) + ' moveto ' +
    x1 + ' ' + y1 + ' ' + x2 + ' ' + y2 + ' 5 arct ' +
    x2 + ' ' + y2 + ' ' + x3 + ' ' + y3 + ' 5 arct ' +
    x3 + ' ' + y3 + ' ' + x4 + ' ' + y4 + ' 5 arct ' +
    x4 + ' ' + y4 + ' ' + x1 + ' ' + y1 + ' 5 arct closepath ' + fill_str + border_col + 'stroke';
  end
  else
  begin
    internal_data := FloatToString(StrokeThickness) + ' setlinewidth ' + FloatToString(x) + ' ' +
    FloatToString(windowHeight - y - Height) + ' newpath moveto ' + FloatToString(x) + ' ' + FloatToString(windowHeight - y) +
    ' lineto  ' + FloatToString(x + Width) + ' ' + FloatToString(windowHeight - y) +
    ' lineto  ' + FloatToString(x + Width) + ' ' + FloatToString(windowHeight - y - Height) +
    ' lineto  closepath ' + fill_str + border_col + 'stroke';
  end;
  PSWrite(internal_data + ' ');
end;

procedure PSDocument.AddEllipse(x, y, Width, Height: Double; Stroke: String; StrokeThickness: Double; Fill: String);
var
  rgb_stroke, rgb_fill, fill_str, border_col, ell_stroke, gsave, grestore, internal_data: String;
begin
  if ((StrokeThickness = 0) and (Fill = 'none')) then
    Exit;
  fill_str := '';
  border_col := '';
  ell_stroke := '';
  gsave := 'gsave ';
  grestore := 'grestore ';

  if (StrokeThickness = 0) then
  begin
    gsave := '';
    grestore := '';
  end
  else
  begin
    rgb_stroke := ColorToPsRgb(Stroke);
    border_col := rgb_stroke + ' setrgbcolor ';
  end;
  if (Fill <> 'none') then
  begin
    rgb_fill := ColorToPsRgb(Fill);
    fill_str := gsave + rgb_fill + ' setrgbcolor fill ' + grestore;
  end;
  ell_stroke := FloatToString(StrokeThickness) + ' setlinewidth ';
  internal_data := '';


  internal_data := FloatToString(StrokeThickness) + ' setlinewidth ' +
  FloatToString(x + Width/2) + ' ' + FloatToString(windowHeight - y - Height / 2) +
  ' ' + FloatToString(Width/2) + ' 0 360 arc closepath '
  + fill_str + border_col + 'stroke';

  PSWrite(internal_data + ' ');
end;

procedure PSDocument.AddTriangle(x, y, Width, Height: Double; Stroke: String; StrokeThickness: Double; Fill: String);
var
  x2, y2, x3, y3: Double;
  rgb_stroke, rgb_fill, fill_str, border_col, tri_stroke, gsave, grestore, internal_data: String;
begin
  if ((StrokeThickness = 0) and (Fill = 'none')) then
    Exit;
  x2 := Width + x;
  y2 := y;
  x3 := x + Width/2;
  y3 := y;

  fill_str := '';
  border_col := '';
  tri_stroke := '';
  gsave := 'gsave ';
  grestore := 'grestore ';

  if (StrokeThickness = 0) then
  begin
    gsave := '';
    grestore := '';
  end
  else
  begin
      rgb_stroke := ColorToPsRgb(Stroke);
      border_col := rgb_stroke + ' setrgbcolor ';
  end;
  if (Fill <> 'none') then
  begin
      rgb_fill := ColorToPsRgb(Fill);
      fill_str := gsave + rgb_fill + ' setrgbcolor fill ' + grestore;
  end;
  tri_stroke := FloatToString(StrokeThickness) + ' setlinewidth ';

  internal_data := FloatToString(StrokeThickness) + ' setlinewidth ' + FloatToString(x) + ' ' +
  FloatToString(windowHeight - y - Height) + ' newpath moveto ' + FloatToString(x2) + ' ' + FloatToString(windowHeight - Height - y2) +
  ' lineto  ' + FloatToString(x3) + ' ' + FloatToString(windowHeight - y3) +
  ' lineto  closepath ' + fill_str + border_col + 'stroke';

  PSWrite(internal_data + ' ');
end;

procedure PSDocument.AddDiamond(x, y, Width, Height: Double; Stroke: String; StrokeThickness: Double; Fill: String);
var
  x1, y1, x2, y2, x3, y3, x4, y4: Double;
  rgb_stroke, rgb_fill, fill_str, border_col, tri_stroke, gsave, grestore, internal_data: String;
begin
  x1 := Width / 2 + x;
  y1 := y;
  x2 := Width + x;
  y2 := Height / 2 + y;
  x3 := Width / 2 + x;
  y3 := y;
  x4 := x;
  y4 := Height / 2 + y;

  fill_str := '';
  border_col := '';
  tri_stroke := '';
  gsave := 'gsave ';
  grestore := 'grestore ';

  if (StrokeThickness = 0) then
  begin
    gsave := '';
    grestore := '';
  end
  else
  begin
      rgb_stroke := ColorToPsRgb(Stroke);
      border_col := rgb_stroke + ' setrgbcolor ';
  end;
  if (Fill <> 'none') then
  begin
      rgb_fill := ColorToPsRgb(Fill);
      fill_str := gsave + rgb_fill + ' setrgbcolor fill ' + grestore;
  end;
  tri_stroke := FloatToString(StrokeThickness) + ' setlinewidth ';

  internal_data := FloatToString(StrokeThickness) + ' setlinewidth ' + FloatToString(x1) + ' ' +
  FloatToString(windowHeight - y1 - Height) + ' newpath moveto ' + FloatToString(x2) + ' ' + FloatToString(windowHeight - y2) +
  ' lineto  ' + FloatToString(x3) + ' ' + FloatToString(windowHeight - y3) +
  ' lineto  ' + FloatToString(x4) + ' ' + FloatToString(windowHeight - y4) +
  ' lineto  closepath ' + fill_str + border_col + 'stroke';

  PSWrite(internal_data + ' ');
end;

procedure PSDocument.AddLine(x, y, x2, y2: Double; Stroke: String; StrokeThickness: Double; dash: TfrxFrameStyle);
var
  line_col, line_stroke, rgb, StrokeDashArray, internal_data: String;
begin
  line_col := '';
  line_stroke := '';
  rgb := ColorToPsRgb(Stroke);

  StrokeDashArray := '';
  case (dash) of
    fsDash: StrokeDashArray := ' [5] 0 setdash ';
    fsDot: StrokeDashArray := '[2 2] 0 setdash';
    fsDashDot: StrokeDashArray := '[2 2 5 2] 0 setdash';
    fsDashDotDot: StrokeDashArray := '[2 2 2 2 5 2] 0 setdash';
    fsDouble:
    begin
      StrokeDashArray := '';
      AddLine(x+10, y+10, x2+10, y2+10, Stroke, StrokeThickness);
    end;
  end;

  line_col := rgb + ' setrgbcolor ';
  line_stroke := FloatToString(StrokeThickness) + ' setlinewidth ' + StrokeDashArray + ' ';
  internal_data := line_stroke + FloatToString(x) + ' ' +
  FloatToString(windowHeight - y) + ' newpath moveto ' + FloatToString(x2) + ' ' + FloatToString(windowHeight - y2) +
  ' lineto  ' + line_col + 'stroke [ ] 0 setdash';
  PSWrite(internal_data + ' ');
end;

procedure PSDocument.AddLine(x, y, x2, y2: Double; Stroke: String; StrokeThickness: Double);
begin
  StartFig(StrokeThickness);
  MoveTo(x, y);
  AppendLine(x2, y2);
  EndFig(Stroke);
end;

procedure PSDocument.AddPage;
begin
///
end;

procedure PSDocument.AddBezier(x, y: Double; p0, p1, p2, p3: TPoint; Stroke: String; StrokeThickness: Double);
var
  line_col, line_stroke, rgb, internal_data: String;
begin
  line_col := '';
  line_stroke := '';
  rgb := ColorToPsRgb(Stroke);
  line_col := rgb + ' setrgbcolor ';
  line_stroke := FloatToString(StrokeThickness) + ' setlinewidth ';
  internal_data := line_stroke + FloatToString(x + p0.X) + ' ' +
  FloatToString(windowHeight - y - p0.Y) + ' newpath moveto ' +
  FloatToString(x + p1.X) + ' ' + FloatToString(windowHeight - y - p1.Y) + ' ' +
  FloatToString(x + p2.X) + ' ' + FloatToString(windowHeight - y - p2.Y) + ' ' +
  FloatToString(x + p3.X) + ' ' + FloatToString(windowHeight - y - p3.Y) + ' ' +
  ' curveto ' + line_col + 'stroke';
  PSWrite(internal_data + ' ');
end;

{procedure PSDocument.AppendBezier(x, y: Double;p1, p2, p3: TPoint);              //not used
var
  internal_data: String;
begin
   internal_data :=
   FloatToString(x + p1.X * 0.75) + ' ' + FloatToString(windowHeight - y - p1.Y * 0.75) + ' ' +
   FloatToString(x + p2.X * 0.75) + ' ' + FloatToString(windowHeight - y - p2.Y * 0.75) + ' ' +
   FloatToString(x + p3.X * 0.75) + ' ' + FloatToString(windowHeight - y - p3.Y * 0.75) + ' ' +
   ' curveto ';
   PSWrite(internal_data);
end;}

procedure PSDocument.AppendLine(x2, y2: Double);
var
  internal_data: String;
begin
  internal_data := FloatToString(x2) + ' ' + FloatToString(windowHeight - y2) + ' lineto ';
  PSWrite(internal_data);
end;

procedure PSDocument.StartFig(StrokeThickness: Double);
var
  line_stroke: String;
begin
  line_stroke := ' ';
  line_stroke := FloatToString(StrokeThickness) + ' setlinewidth ';
  PSWrite(line_stroke + ' ');
end;

function PSDocument.PSFont(font: String): String;
begin
  result := StringReplace(font, ' ', '-', [rfReplaceAll, rfIgnoreCase]);
end;

{procedure PSDocument.EndFig(stroke, fill: String);
var
  rgb_stroke, l, rgb_fill: String;
begin
  rgb_stroke := ColorToPsRgb(stroke);
  l := '';
  rgb_fill := ColorToPsRgb(stroke);
  l := l + (*' gsave ' +*) rgb_fill + ' setrgbcolor fill '(*grestore '*);
  PSWrite(l + rgb_stroke +' ');
end;}

procedure PSDocument.EndFig(stroke: String);
var
  rgb_stroke: String;
begin
  rgb_stroke := ColorToPsRgb(stroke);
  PSWrite(' gsave ' + rgb_stroke + '  setrgbcolor stroke grestore ');
end;

function PSDocument.ColorToPsRgb(htmlcolor: String): String;
var
  tmpRGB : TColorRef;
begin
  Delete(htmlcolor, 1, 1);
  tmpRGB := ColorToRGB(HexToTColor(htmlcolor)) ;
  result := FloatToString(GetRValue(tmpRGB) / 255) + ' ' + FloatToString(GetGValue(tmpRGB) / 255) + ' ' + FloatToString(GetBValue(tmpRGB) / 255);
end;

{procedure PSDocument.ClosePath();
begin
  PSWrite(' closepath ');
end;}

procedure PSDocument.Convert(var left, top, width, height: Double);
begin
  left := MmToPt(DpToMm(left));
  top := MmToPt(DpToMm(top));
  width := DpToPt(width);
  height := DpToPt(height);
end;

procedure PSDocument.PSWrite(s: String);
begin
  psData := psData + s;
end;

procedure PSDocument.PSWriteLn(s: String);
begin
  PSWrite(s + sLineBreak);
end;

procedure PSDocument.AddImage(data: String;left, top, width, height: Double; pwidth, pheight: Integer; Involve: Boolean = True);
begin
  Convert(left, top, width, height);
  PSWrite(' gsave '+ FloatToString(left) + ' '+FloatToString(windowHeight - height - top));  //set lower left of image at (360, 72)
  PSWrite(' translate ' + FloatToString(Round(width)) + ' ' + FloatToString(Round(height))); //size of rendered image is 175 points by 47 points
  PSWrite(' scale ' + IntToStr(pwidth) + ' ' + IntToStr(pheight)); //number of columns per row and number of rows
  PSWrite(' 8 '); //bits per color channel (1, 2, 4, or 8)
  PSWrite('['+ IntToStr(pwidth) + ' 0 0 -' + IntToStr(pheight) + ' 0 ' + IntToStr(pheight) + '] ');     //transform array... maps unit square to pixel
  if (Involve) then
    PSWrite(data + ' /ASCIIHexDecode filter 0 dict /DCTDecode filter ')
  else
    PSWrite('(' + data + ') (r) file /DCTDecode filter ');
  PSWrite('false '); //pull channels from separate sources
  PSWrite('3 ');     // 3 color channels (RGB)
  PSWrite('colorimage ');
  PSWrite('grestore ');
end;

procedure PSDocument.AddTextObject(x, y, Width, Height: Double;
   HorizontalAlignment: TfrxHAlign; VerticalAlignment: TfrxVAlign; BorderBrush: String;
   BorderThickness, LeftLine, TopLine, RightLine, BottomLine: Double;
   LeftLineDashStile, TopLineDashStile, RightLineDashStile, BottomLineDashStile: TfrxFrameStyle;
   colorLeftLine, colorTopLine, colorRightLine, colorBottomLine: String; Shadow: Boolean;
   ShadowColor: String; ShadowWidth: Double; Background: String; Typ: TfrxFrameTypes;Text, Foreground: String;
   PaddingLeft, PaddingTop, PaddingRight, PaddingBottom: Double;
   WordWrap: Boolean; Angle: Double; Glass: Boolean; colorTop: String; font: TFont; FIndent: Double);
var
  All, Left, Right, Top, Bottom: Boolean;
begin
  Convert(x, y, Width, Height);
  Right := ftRight in Typ;
  Left := ftLeft in Typ;
  Top := ftTop in Typ;
  Bottom := ftBottom in Typ;
  All := (Left and Right and Top and Bottom);

  if (All and ((LeftLine = TopLine) and (TopLine = RightLine) and (RightLine = BottomLine)) and
    ((LeftLineDashStile = TopLineDashStile) and (TopLineDashStile = RightLineDashStile) and
    (RightLineDashStile = BottomLineDashStile) and (BottomLineDashStile = fsSolid)) and
    ((colorLeftLine = colorTopLine) and (colorTopLine = colorRightLine) and (colorRightLine = colorBottomLine)
    (*&& colorBottomLine == Background*))) then
  begin
    AddRectangle(x, y, Width, Height, BorderBrush, BorderThickness, Background, false);
  end
  else
  begin
    if (Background <> 'none') then
      AddRectangle(x, y, Width, Height, BorderBrush, 0, Background, false);
    if (Left or All) then
      case (LeftLineDashStile) of
        fsSolid: AddLine(x, y, x, y + Height, colorLeftLine, LeftLine);
        fsDouble:
        begin
          AddLine(x, y, x, y + Height, colorLeftLine, LeftLine);
          AddLine(x - BorderThickness * 2, y - BorderThickness * 2, x - BorderThickness * 2, y + Height + BorderThickness * 2, colorLeftLine, LeftLine);
        end;
        else
          AddLine(x, y, x, y + Height, colorLeftLine, LeftLine, LeftLineDashStile);
      end;
    if (Right or All) then
      case (LeftLineDashStile) of
        fsSolid: AddLine(x + Width, y, x + Width, y + Height, colorRightLine, RightLine);
        fsDouble:
        begin
          AddLine(x + Width, y, x + Width, y + Height, colorRightLine, RightLine);
          AddLine(x + Width + BorderThickness * 2, y - BorderThickness * 2, x + Width + BorderThickness * 2, y + Height + BorderThickness * 2, colorRightLine, RightLine);
        end;
        else
          AddLine(x + Width, y, x + Width, y + Height, colorRightLine, RightLine, LeftLineDashStile);
      end;
    if (Top or All) then
      case (LeftLineDashStile) of
        fsSolid: AddLine(x, y, x + Width, y, colorTopLine, TopLine);
        fsDouble:
        begin
          AddLine(x, y, x + Width, y, colorTopLine, TopLine);
          AddLine(x - BorderThickness * 2, y - BorderThickness * 2, x + Width + BorderThickness * 2, y - BorderThickness * 2, colorTopLine, TopLine);
        end;
        else
          AddLine(x, y, x + Width, y, colorTopLine, TopLine, LeftLineDashStile);
      end;
    if (Bottom or All) then
      case (LeftLineDashStile) of
        fsSolid: AddLine(x, y + Height, x + Width, y + Height, colorBottomLine, BottomLine);
        fsDouble:
        begin
          AddLine(x, y + Height, x + Width, y + Height, colorBottomLine, BottomLine);
          AddLine(x - BorderThickness * 2, y + Height + BorderThickness * 2, x + Width + BorderThickness * 2, y + Height + BorderThickness * 2, colorBottomLine, BottomLine);
        end;
        else
          AddLine(x, y + Height, x + Width, y + Height, colorBottomLine, BottomLine, LeftLineDashStile);
      end;
  end;
  //Glass--------------------
  if (Glass) then
  begin
    AddRectangle(x, y, Width, Height / 2, BorderBrush, 0, colorTop, false);
    AddRectangle(x, y + Height / 2, Width, Height / 2, BorderBrush, 0, Background, false);
  end;
  //Shadow-------------------
  if (Shadow) then
  begin
    AddLine(x + ShadowWidth, y + Height + ShadowWidth / 2, x + Width + ShadowWidth, y + Height + ShadowWidth / 2, ShadowColor, ShadowWidth);
    AddLine(x + Width + ShadowWidth / 2, y + ShadowWidth, x + Width + ShadowWidth / 2, y + Height + ShadowWidth, ShadowColor, ShadowWidth);
  end;

  if (Text <> '') then
    createText(x, y, HorizontalAlignment, VerticalAlignment, Width, Height, font, Text, PaddingLeft, PaddingRight, PaddingTop, PaddingBottom, BorderThickness, Foreground, Background, Angle, FIndent);
end;

constructor PSDocument.Create();
begin

end;

constructor PSDocument.Create(name: String; Width, Height: Double);
begin
  CreateWindow(name, Width, Height);
end;

procedure PSDocument.Save(stream: TStream);
{$IFDEF DELPHI14}
var AnsStr: AnsiString;
{$ENDIF}
begin
{$IFDEF DELPHI14}
 {$WARNINGS OFF}
  AnsStr := psData;
 {$WARNINGS ON}
  stream.Write(Pointer(AnsStr)^, length(AnsStr));
{$ELSE}
  stream.Write(Pointer(psData)^, length(psData));
{$ENDIF}
end;

procedure PSDocument.Save(fn: String);
var
  f:TextFile;
begin
  AssignFile(f, fn);
  ReWrite(f);
  Write(f, psData);
  CloseFile(f);
end;

procedure PSDocument.Finish();
begin
  PSWriteLn('showpage');
  {PSWriteLn('%%Trailer');
  PSWriteLn('%% Pages: 1');
  PSWrite('%% EOF');}
end;

end.

