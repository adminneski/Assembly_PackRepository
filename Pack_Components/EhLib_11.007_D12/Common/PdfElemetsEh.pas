{*******************************************************}
{                                                       }
{                       EhLib 10.2                      }
{ Base classes for the process of generating Pdf files  }
{                                                       }
{   Copyright (c) 2021-2022 by Dmitry V. Bolshakov      }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit PdfElemetsEh;

interface

{$SCOPEDENUMS ON}

uses SysUtils, Classes,
{$IFDEF FPC}
  EhLibLCL, LCLType, Generics.Collections,
{$ELSE}
  EhLibVCL, Generics.Collections,
{$ENDIF}
  Variants;

type

  TPdfAtomEh = class;
  TPdfObjectEh = class;
  TPdfStringEh = class;
  TPdfNameEh = class;
  TPdfIntegerNumberEh = class;
  TPdfDictionaryEh = class;
  TPdfArrayEh = class;

  TPdfIndirectObjectEh = class;
  TPdfIdrectDictionaryObjectEh = class;
  TPdfBaseDocumentEh = class;
  TPdfIndirectObjectListEh = class;

  TPdfDictionaryStreamEh = class;
  TPdfAsciiStreamEh = class;

  TPdfDictionaryItemsEh = TDictionary<String, TPdfObjectEh>;
  TPdfListItemsEh = TList<TPdfObjectEh>;

  TPdfFontDefEh = record
    Name: String;
    IsBold: Boolean;
    IsItalic: Boolean;
    FontKeyName: String;
  end;

{ TPdfAtomEhEh }

  TPdfAtomEh = class(TObject)
  private
  public
    constructor Create;
  end;

{ TPdfObjectEh }

  TPdfObjectEh = class(TPdfAtomEh)
  protected
    function GetHasOwner: Boolean; virtual;
  public
    procedure PrepareForExport; virtual;
    constructor Create;

    property HasOwner: Boolean read GetHasOwner;
  end;

{ TPdfStringEh }

  TPdfStringType = (Regular, Hexadecimal);

  TPdfStringEh = class(TPdfObjectEh)
  private
    FValue: AnsiString;
    FStringType: TPdfStringType;
  public
    constructor Create(AValue: String; AStringType: TPdfStringType);

    property Value: AnsiString read FValue write FValue;
    property StringType: TPdfStringType read FStringType;
  end;

{ TPdfNameEh }

  TPdfNameEh = class(TPdfObjectEh)
  private
    FValue: AnsiString;
  public
    constructor Create(AValue: String);

    property Value: AnsiString read FValue;
  end;

{ TPdfIntegerNumberEh }

  TPdfIntegerNumberEh = class(TPdfObjectEh)
  private
    FValue: Integer;
  public
    constructor Create(AValue: Integer);

    property Value: Integer read FValue;
  end;

{ TPdfRealNumberEh }

  TPdfRealNumber = class(TPdfObjectEh)
  private
    FValue: Double;
  public
    constructor Create(AValue: Double);

    property Value: Double read FValue;
  end;

{ TPdfBooleanEh }

  TPdfBoolean = class(TPdfObjectEh)
  private
    FValue: Boolean;
  public
    constructor Create(AValue: Boolean);

    property Value: Boolean read FValue;
  end;

{ TPdfDictionaryEh }

  TPdfDictionaryEh = class(TPdfObjectEh)
  private
    FItems: TPdfDictionaryItemsEh;

    {$IFDEF FPC}
    procedure ItemsItemNotification(Sender: TObject; constref Item: TPdfObjectEh; Action: TCollectionNotification);
    {$ELSE}
    procedure ItemsItemNotification(Sender: TObject; const Item: TPdfObjectEh; Action: TCollectionNotification);
    {$ENDIF}
  public
    constructor Create;
    destructor Destroy; override;

    property Items: TPdfDictionaryItemsEh read FItems;
  end;

{ TPdfArrayEh }

  TPdfArrayEh = class(TPdfObjectEh)
  private
    FItems: TPdfListItemsEh;

    {$IFDEF FPC}
    procedure ItemsItemNotification(Sender: TObject; constref Item: TPdfObjectEh; Action: TCollectionNotification);
    {$ELSE}
    procedure ItemsItemNotification(Sender: TObject; const Item: TPdfObjectEh; Action: TCollectionNotification);
    {$ENDIF}
  public
    constructor Create;
    destructor Destroy; override;

    property Items: TPdfListItemsEh read FItems;
  end;

{ TPdfIndirectObjectEh }

  TPdfIndirectObjectEh = class(TPdfObjectEh)
  private
    FContentObject: TPdfObjectEh;

  protected
    FObjectID: Integer;
    FStreamPos: Int64;

    function GetHasOwner: Boolean; override;
  public
    constructor Create(ADocument: TPdfBaseDocumentEh; AContentObject: TPdfObjectEh);
    destructor Destroy; override;

    property ContentObject: TPdfObjectEh read FContentObject;
    property ObjectID: Integer read FObjectID;
  end;

{ TPdfDictionaryObjectEh }

  TPdfIdrectDictionaryObjectEh = class(TPdfIndirectObjectEh)
  private
    FDocument: TPdfBaseDocumentEh;
    FBoundStream: TPdfDictionaryStreamEh;
    function GetItems: TPdfDictionaryItemsEh;

  protected
    function CreateBoundStream: TPdfDictionaryStreamEh; virtual;

  public
    constructor Create(ADocument: TPdfBaseDocumentEh);
    destructor Destroy; override;

    property Items: TPdfDictionaryItemsEh read GetItems;
    property BoundStream: TPdfDictionaryStreamEh read FBoundStream;
    property Document: TPdfBaseDocumentEh read FDocument;
  end;

{ TPdfBaseDocumentEhEh }

  TPdfBaseDocumentEh = class(TObject)
  private
    FIndirectObjectList: TPdfIndirectObjectListEh;

  protected
    property IndirectObjectList: TPdfIndirectObjectListEh read FIndirectObjectList;

  public
    constructor Create;
    destructor Destroy; override;
  end;

{ TPdfIndirectObjectEh }

  TPdfIndirectObjectListEh = class(TList<TPdfIndirectObjectEh>)
  private
  protected
    FNextObjectID: Integer;

  public
    constructor Create;
    destructor Destroy; override;

//    function CreateIndirectObject(AContentObject: TPdfObject): TPdfIndirectObject;
    procedure AddObject(AnObject: TPdfIndirectObjectEh);
  end;


{ TPdfDictionaryStreamEh }

  TPdfDictionaryStreamEh = class(TObject)
  private
    FMemoryStream: TMemoryStream;
    function GetPosition: Int64;
    function GetSize: Int64;
    procedure SetPosition(const Value: Int64);
  protected
  public
    constructor Create;
    destructor Destroy; override;

    procedure Clear;
    procedure WriteToGeneralStream(Stream: TStream);
    procedure ReadFromGeneralStream(Stream: TStream);
    procedure WriteAnsiStr(AnsiStr: AnsiString);
    procedure WriteLineFeed;

    property MemoryStream: TMemoryStream read FMemoryStream;
    property Position: Int64 read GetPosition write SetPosition;
    property Size: Int64 read GetSize;
  end;

{ TPdfAsciiStreamEh }

  TPdfAsciiStreamEh = class(TPdfDictionaryStreamEh)
  public
    constructor Create;
    destructor Destroy; override;

    procedure WriteStr(Str: String);
    procedure WriteInteger(Value: Integer);
    procedure WriteLineStr(Str: String);
  end;

function CharToHexEh(Ch: Char): String;
function WordToHexEh(Ch: Word): String;

implementation

const
  LineFeed: AnsiChar = #10;

function WordToHexEh(Ch: Word): String;
var
  C1: Char;
begin
  Result := '';
  SetLength(Result, SizeOf(Ch) * 2);
  {$IFDEF FPC}
  BinToHex(@Ch, PChar(Result), SizeOf(Ch));
  {$ELSE}
  BinToHex(@Ch, PWideChar(Result), SizeOf(Ch));
  {$ENDIF}

  C1 := Result[1];
  Result[1] := Result[3];
  Result[3] := C1;

  C1 := Result[2];
  Result[2] := Result[4];
  Result[4] := C1;
end;

function CharToHexEh(Ch: Char): String;
begin
  Result := WordToHexEh(Word(Ch));
end;

{ TPdfAtomEh }

constructor TPdfAtomEh.Create;
begin
  inherited Create;
end;

{ TPdfStringEh }

constructor TPdfStringEh.Create(AValue: String; AStringType: TPdfStringType);
begin
  FValue := AnsiString(AValue);
  FStringType := AStringType;
end;

{ TPdfNameEh }

constructor TPdfNameEh.Create(AValue: String);
begin
  FValue := AnsiString(AValue);
end;

{ TPdfIntegerNumberEh }

constructor TPdfIntegerNumberEh.Create(AValue: Integer);
begin
  inherited Create;
  FValue := AValue;
end;

{ TPdfRealNumberEh }

constructor TPdfRealNumber.Create(AValue: Double);
begin
  inherited Create;
  FValue := AValue;
end;

{ TPdfBooleanEh }

constructor TPdfBoolean.Create(AValue: Boolean);
begin
  inherited Create;
  FValue := AValue;
end;

{ TPdfObjectEh }

constructor TPdfObjectEh.Create;
begin
  inherited Create;
end;

procedure TPdfObjectEh.PrepareForExport;
begin

end;

function TPdfObjectEh.GetHasOwner: Boolean;
begin
  Result := False;
end;

{ TPdfIndirectObjectEh }

constructor TPdfIndirectObjectEh.Create(ADocument: TPdfBaseDocumentEh; AContentObject: TPdfObjectEh);
begin
  FContentObject := AContentObject;
  ADocument.IndirectObjectList.AddObject(Self);
end;

destructor TPdfIndirectObjectEh.Destroy;
begin
  FreeAndNil(FContentObject);
  inherited Destroy;
end;

function TPdfIndirectObjectEh.GetHasOwner: Boolean;
begin
  Result := True;
end;

{ TPdfDictionaryEh }

constructor TPdfDictionaryEh.Create;
begin
  inherited Create;
  FItems := TPdfDictionaryItemsEh.Create;
  {$IFDEF FPC}
  FItems.OnValueNotify := ItemsItemNotification;
  {$ELSE}
  FItems.OnValueNotify := ItemsItemNotification;
  {$ENDIF}
end;

destructor TPdfDictionaryEh.Destroy;
begin
  FreeAndNil(FItems);
  inherited Destroy;
end;

{$IFDEF FPC}
procedure TPdfDictionaryEh.ItemsItemNotification(Sender: TObject;
  constref Item: TPdfObjectEh; Action: TCollectionNotification);
{$ELSE}
procedure TPdfDictionaryEh.ItemsItemNotification(Sender: TObject;
  const Item: TPdfObjectEh; Action: TCollectionNotification);
{$ENDIF}
begin
  //TODO: Bug in FPC?
  {$IFDEF FPC}
  {$ELSE}
  if (Action = cnRemoved) then
  begin
    if (Item.HasOwner = False) then
      Item.Free;
  end;
  {$ENDIF}
end;

{ TPdfArrayEh }

constructor TPdfArrayEh.Create;
begin
  inherited Create;

  FItems := TPdfListItemsEh.Create;
  {$IFDEF FPC}
  FItems.OnNotify := ItemsItemNotification;
  {$ELSE}
  FItems.OnNotify := ItemsItemNotification;
  {$ENDIF}
end;

{$IFDEF FPC}
procedure TPdfArrayEh.ItemsItemNotification(Sender: TObject;
  constref Item: TPdfObjectEh; Action: TCollectionNotification);
{$ELSE}
procedure TPdfArrayEh.ItemsItemNotification(Sender: TObject;
  const Item: TPdfObjectEh; Action: TCollectionNotification);
{$ENDIF}
begin
  //TODO: Bug in FPC?
  {$IFDEF FPC}
  {$ELSE}
  if (Action = cnRemoved) then
  begin
    if (Item.HasOwner = False) then
      Item.Free;
  end;
  {$ENDIF}
end;

destructor TPdfArrayEh.Destroy;
begin
//  while FItems.Count > 0 do
//  begin
//    if (FItems[FItems.Count - 1].HasOwner = False) then
//    begin
//      FItems[FItems.Count - 1].Free;
//      FItems[FItems.Count - 1] := nil;
//    end;
//    FItems.Delete(FItems.Count - 1);
//  end;
  FreeAndNil(FItems);
  inherited Destroy;
end;

{ TPdfDictionaryObjectEh }

constructor TPdfIdrectDictionaryObjectEh.Create(ADocument: TPdfBaseDocumentEh);
begin
  inherited Create(ADocument, TPdfDictionaryEh.Create);
  FDocument := ADocument;

  FBoundStream := CreateBoundStream;
end;

destructor TPdfIdrectDictionaryObjectEh.Destroy;
begin
  FreeAndNil(FBoundStream);
  inherited Destroy;
end;

function TPdfIdrectDictionaryObjectEh.GetItems: TPdfDictionaryItemsEh;
begin
  Result := TPdfDictionaryEh(ContentObject).Items;
end;

function TPdfIdrectDictionaryObjectEh.CreateBoundStream: TPdfDictionaryStreamEh;
begin
  Result := nil;
end;

{ TPdfIndirectObjectListEh }

constructor TPdfIndirectObjectListEh.Create;
begin
  inherited Create;
  FNextObjectID := 1;
end;

procedure TPdfIndirectObjectListEh.AddObject(AnObject: TPdfIndirectObjectEh);
begin
  AnObject.FObjectID := FNextObjectID;
  Add(AnObject);

  FNextObjectID := FNextObjectID + 1;
end;

destructor TPdfIndirectObjectListEh.Destroy;
begin
  inherited Destroy;
end;

{ TPdfBaseDocumentEh }

constructor TPdfBaseDocumentEh.Create;
begin
  inherited Create;

  FIndirectObjectList := TPdfIndirectObjectListEh.Create;
end;

destructor TPdfBaseDocumentEh.Destroy;
begin
  FreeAndNil(FIndirectObjectList);
  inherited Destroy;
end;

{ TPdfDictionaryStreamEh }

constructor TPdfDictionaryStreamEh.Create;
begin
  inherited Create;
  FMemoryStream := TMemoryStream.Create;
end;

destructor TPdfDictionaryStreamEh.Destroy;
begin
  FreeAndNil(FMemoryStream);
  inherited Destroy;
end;

procedure TPdfDictionaryStreamEh.WriteAnsiStr(AnsiStr: AnsiString);
begin
  if (Length(AnsiStr) = 0) then Exit;
  MemoryStream.Write(AnsiStr[1], Length(AnsiStr));
end;

procedure TPdfDictionaryStreamEh.WriteLineFeed;
begin
  WriteAnsiStr(LineFeed);
end;

procedure TPdfDictionaryStreamEh.WriteToGeneralStream(Stream: TStream);
begin
  Stream.CopyFrom(FMemoryStream, 0);
end;

procedure TPdfDictionaryStreamEh.ReadFromGeneralStream(Stream: TStream);
begin
  Clear;
  FMemoryStream.CopyFrom(Stream, 0);
end;

procedure TPdfDictionaryStreamEh.Clear;
begin
  FMemoryStream.Clear;
end;

function TPdfDictionaryStreamEh.GetPosition: Int64;
begin
  Result := FMemoryStream.Position;
end;

procedure TPdfDictionaryStreamEh.SetPosition(const Value: Int64);
begin
  FMemoryStream.Position := Value;
end;

function TPdfDictionaryStreamEh.GetSize: Int64;
begin
  Result := FMemoryStream.Size;
end;

{ TPdfAsciiStreamEh }

constructor TPdfAsciiStreamEh.Create;
begin
  inherited Create;
end;

destructor TPdfAsciiStreamEh.Destroy;
begin
  inherited Destroy;
end;

procedure TPdfAsciiStreamEh.WriteStr(Str: String);
begin
  WriteAnsiStr(AnsiString(Str));
end;

procedure TPdfAsciiStreamEh.WriteInteger(Value: Integer);
begin
  WriteStr(IntToStr(Value));
end;

procedure TPdfAsciiStreamEh.WriteLineStr(Str: String);
begin
  WriteStr(Str);
  WriteLineFeed;
end;

end.
