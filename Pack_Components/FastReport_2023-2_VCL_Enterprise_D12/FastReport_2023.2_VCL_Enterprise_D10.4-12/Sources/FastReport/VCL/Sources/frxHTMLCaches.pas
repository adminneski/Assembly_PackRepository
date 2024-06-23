{
Version   12
Copyright (c) 1995-2008 by L. David Baldwin,
Copyright (c) 2008-2010 by HtmlViewer Team
Copyright (c) 2011-2012 by Bernd Gabriel

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Note that the source modules HTMLGIF1.PAS and DITHERUNIT.PAS
are covered by separate copyright notices located in those modules.
}

{$I frxHTMLCons.inc}

unit frxHTMLCaches;

interface

uses
  SysUtils, Classes,
  frxHTMLGlobals;

type

  //BG, 30.04.2011:
  ThtCachable = class(TObject);

//------------------------------------------------------------------------------
// ThtCache is the cache, that holds the above cacheable items.
//------------------------------------------------------------------------------

  ThtCache = class(ThtStringList)
  private
    function GetObject(Index: Integer): ThtCachable; reintroduce;
  protected
    function GetCachable(I: Integer): ThtCachable; {$ifdef UseInline} inline; {$endif}
    property Objects[Index: Integer]: ThtCachable read GetObject;
  public
    constructor Create;
    destructor Destroy; override;
    function AddObject(const S: ThtString; AObject: ThtCachable): Integer; reintroduce;
    procedure Clear; override;
    procedure ClearUnused; virtual;
    function IsFound(const S: ThtString; out Index: Integer): Boolean;
  end;

  ThtCSSCache = class(ThtCache)
  public
    function GetStream(i: Integer): TStream;
    function AddStream(const S: ThtString; AStream: TStream): Integer;

    procedure WriteToStream(Stream: TStream);
    procedure ReadFromStream(Stream: TStream);
  end;

implementation

uses
  frxHelpers;

type
  ThtCSSObject = class(ThtCachable)
  private
    FCSSStream: TStream;
  public
    constructor Create(Stream: TStream = nil);
    destructor Destroy; override;

    procedure LoadFromStream(Stream: TStream);
    procedure SaveToStream(Stream: TStream);

    property CSSStream: TStream read FCSSStream;
  end;

{ ThtCache }

//------------------------------------------------------------------------------
function ThtCache.AddObject(const S: ThtString; AObject: ThtCachable): Integer;
begin
  Result := inherited AddObject(S, AObject);
end;

//------------------------------------------------------------------------------
procedure ThtCache.Clear;
var
  i: Integer;
begin
  for i := 0 to Count - 1 do
    Objects[i].Free;
  inherited Clear;
end;

procedure ThtCache.ClearUnused;
begin
  Clear;
end;

//------------------------------------------------------------------------------
constructor ThtCache.Create;
begin
  inherited Create;
  Sorted := True;
end;

//------------------------------------------------------------------------------
destructor ThtCache.Destroy;
begin
  Clear;
  inherited Destroy;
end;

//------------------------------------------------------------------------------
function ThtCache.GetCachable(I: Integer): ThtCachable;
begin
  Result := Objects[I];
end;

//-- BG ---------------------------------------------------------- 06.03.2011 --
function ThtCache.GetObject(Index: Integer): ThtCachable;
begin
  Result := ThtCachable(inherited GetObject(Index));
end;

function ThtCache.IsFound(const S: ThtString; out Index: Integer): Boolean;
begin
  Index := IndexOf(S);
  Result := Index <> -1;
end;

{ ThtCSSObject }

constructor ThtCSSObject.Create(Stream: TStream = nil);
begin
  FCSSStream := TMemoryStream.Create;
  if Stream <> nil then
    FCSSStream.CopyFrom(Stream, 0);
end;

destructor ThtCSSObject.Destroy;
begin
  FCSSStream.Free;
  inherited;
end;

procedure ThtCSSObject.LoadFromStream(Stream: TStream);
var
  Size: Int64;
begin
  Stream.ReadBuffer(Size, SizeOf(Size));
  FCSSStream.Position := 0;
  FCSSStream.CopyFrom(Stream, Size);
end;

procedure ThtCSSObject.SaveToStream(Stream: TStream);
var
  Size: Int64;
begin
  Size := FCSSStream.Size;
  Stream.WriteBuffer(Size, SizeOf(Size));
  FCSSStream.Position := 0;
  Stream.CopyFrom(FCSSStream, Size);
end;

{ ThtCSSCache }

function ThtCSSCache.AddStream(const S: ThtString; AStream: TStream): Integer;
begin
  Result := AddObject(S, ThtCSSObject.Create(AStream));
end;

function ThtCSSCache.GetStream(i: Integer): TStream;
begin
  Result := ThtCSSObject(Objects[i]).FCSSStream;
end;

procedure ThtCSSCache.ReadFromStream(Stream: TStream);
var
  C, i: Integer;
  WS: WideString;
  CSSObject: ThtCSSObject;
begin
  Clear;
  Stream.ReadBuffer(C, SizeOf(C));

  for i := 0 to C - 1 do
  begin
    WS := ReadWideStringFromStream(Stream);

    CSSObject := ThtCSSObject.Create;
    CSSObject.LoadFromStream(Stream);

    AddObject(WS, CSSObject);
  end;
end;

procedure ThtCSSCache.WriteToStream(Stream: TStream);
var
  C, i: Integer;
  WS: WideString;
begin
  C := Count;
  Stream.WriteBuffer(C, SizeOf(C));

  for i := 0 to Count - 1 do
  begin
    WS := Strings[i];
    WriteWideStringToStream(Stream, WS);
    ThtCSSObject(Objects[i]).SaveToStream(Stream);
  end;
end;

end.
