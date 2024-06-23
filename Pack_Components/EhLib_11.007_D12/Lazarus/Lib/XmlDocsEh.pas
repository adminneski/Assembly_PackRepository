{*******************************************************}
{                                                       }
{                      EhLib 10.2                       }
{                                                       }
{           Classes to work w ith Xml format            }
{                                                       }
{     Copyright (c) 2021-2022 by Dmitry V. Bolshakov    }
{                                                       }
{*******************************************************}

unit XmlDocsEh;

{$I EhLib.Inc}

interface

uses
  SysUtils, Classes,
  {$IFDEF FPC}
  EhLibLCL,
  {$ELSE}
  EhLibVCL,
  {$ENDIF}
//  System.Generics.Collections,
{$IFDEF EH_LIB_17} System.UITypes, UIConsts, System.Contnrs, {$ENDIF}
  XmlReaderWriterEh,
  Types;

type
  TSimpleXmlNodeEh = class;
  TSimpleXmlDocumentEh = class;

  TSimpleXmlNodeTypeEh = (
    xntElement,
    xntText,
    xntComment,
    xntCData,
    xntAttribute
  );

{ TSimpleXMLNodeListEh }

  TSimpleXMLNodeListEh = class(TPersistent)
  private
    FOwnerNode: TSimpleXmlNodeEh;
    FNodeList: TObjectListEh;

    function GetCount: Integer;
    function GetNode(const Index: Integer): TSimpleXmlNodeEh;

  public
    constructor Create(AOwnerNode: TSimpleXmlNodeEh);
    destructor Destroy; override;

    function Add(const ANode: TSimpleXmlNodeEh): Integer;
    function FindNode(NodeName: String): TSimpleXmlNodeEh; overload;
    procedure Clear;
    function Get(Index: Integer): TSimpleXmlNodeEh;
    procedure Insert(Index: Integer; const Node: TSimpleXmlNodeEh);

    property Count: Integer read GetCount;
    property Nodes[const Index: Integer]: TSimpleXmlNodeEh read GetNode; default;
  end;

{ TSimpleXmlNodeEh }

  TSimpleXmlNodeEh = class(TPersistent)
  private
    FType: TSimpleXmlNodeTypeEh;
    FParent: TSimpleXmlNodeEh;
    FChildNodes: TSimpleXMLNodeListEh;
    FAttributeNodes: TSimpleXMLNodeListEh;
    FNodeName: String;
    FNodeValue: String;

    function GetAttributeByName(const AttrName: String): String;
//    function GetAttributeByIndex(const AttrIndex: Integer): String;
    function GetNodeName: String;
    function GetNodeType: TSimpleXmlNodeTypeEh;
    function GetNodeValue: String;
    function GetParentNode: TSimpleXmlNodeEh;
    procedure SetAttributeByName(const AttrName, Value: String);
//    procedure SetAttributeByIndex(const AttrIndex: Integer; const Value: String);
    procedure SetNodeValue(const Value: String);
    function GetChildNodes: TSimpleXMLNodeListEh;

    procedure InternalAddChild(const AChild: TSimpleXmlNodeEh);
    procedure SetParent(const AValue: TSimpleXmlNodeEh);
    function GetFirstChild: TSimpleXmlNodeEh;
    function GetAttributesCount: Integer;
    function GetAttributeNodes: TSimpleXMLNodeListEh;
    function GetChildNodesCount: Integer;

  public
    constructor Create(AType: TSimpleXmlNodeTypeEh; ANodeName: String);
    destructor Destroy; override;

    property FirstChild: TSimpleXmlNodeEh read GetFirstChild;

    property NodeName: String read GetNodeName;
    property NodeType: TSimpleXmlNodeTypeEh read GetNodeType;
    property NodeValue: String read GetNodeValue write SetNodeValue;
    property ParentNode: TSimpleXmlNodeEh read GetParentNode;

    property Attributes[const AttrName: String]: String read GetAttributeByName write SetAttributeByName;
    property AttributeNodes: TSimpleXMLNodeListEh read GetAttributeNodes;
    property AttributesCount: Integer read GetAttributesCount;

    property ChildNodes: TSimpleXMLNodeListEh read GetChildNodes;
    property ChildNodesCount: Integer read GetChildNodesCount;
  end;


  ISimpleXmlDocumentEh = interface
  ['{58EA8DB4-D353-45A3-91F5-E43115B0A6A2}']
    function GetRoot: TSimpleXmlNodeEh;
    function GetDocumentElement: TSimpleXmlNodeEh;
    function GetChildNodes: TSimpleXMLNodeListEh;
    procedure Clear;
    procedure LoadFromFile(const AFilename: String); overload;
    procedure LoadFromStream(const AStream: TStream); overload;
    procedure LoadFromArray(const ABytes: TBytes); overload;
    //procedure Load(const AReader: TXmlReader); overload;
    procedure Parse(const AXml: String);
    procedure SaveToFile(const AFilename: String; const AOptions: TXmlOutputOptions = [xmooIndent, xmooWriteDeclaration]); overload;
    procedure SaveToStream(const AStream: TStream; const AOptions: TXmlOutputOptions = [xmooIndent, xmooWriteDeclaration]); overload;
    //procedure Save(const AWriter: TXmlWriter); overload;
    function ToBytes(const AOptions: TXmlOutputOptions = [xmooIndent, xmooWriteDeclaration]): TBytes;
    function ToXml(const AOptions: TXmlOutputOptions = [xmooIndent, xmooWriteDeclaration]): String;

    property Root: TSimpleXmlNodeEh read GetRoot;
    property DocumentElement: TSimpleXmlNodeEh read GetDocumentElement;
    property ChildNodes: TSimpleXMLNodeListEh read GetChildNodes;
  end;

{ TSimpleXmlDocumentEh }

  TSimpleXmlDocumentEh = class(TInterfacedObject, ISimpleXmlDocumentEh)
  private
    FRoot: TSimpleXmlNodeEh;
  private
    function CreateNode(const AType: TSimpleXmlNodeTypeEh; ANodeName: String): TSimpleXmlNodeEh;
    function GetChildNodes: TSimpleXMLNodeListEh;
  protected
    { ISimpleXmlDocumentEh }
    function GetRoot: TSimpleXmlNodeEh;
    function GetDocumentElement: TSimpleXmlNodeEh;

    procedure Clear;

    procedure LoadFromFile(const AFilename: String); overload;
    procedure LoadFromStream(const AStream: TStream); overload;
    procedure LoadFromArray(const ABytes: TBytes); overload;

    procedure Load(const AReader: TXmlReader); overload;
    procedure Parse(const AXml: String);

    procedure SaveToFile(const AFilename: String; const AOptions: TXmlOutputOptions); overload;
    procedure SaveToStream(const AStream: TStream; const AOptions: TXmlOutputOptions); overload;
    procedure Save(const AWriter: TXmlWriter); overload;
    function ToBytes(const AOptions: TXmlOutputOptions = [xmooIndent, xmooWriteDeclaration]): TBytes;
    function ToXml(const AOptions: TXmlOutputOptions): String;
  public
    constructor Create;
    destructor Destroy; override;

    property ChildNodes: TSimpleXMLNodeListEh read GetChildNodes;
  end;

implementation

{ TSimpleXmlNodeEh }

constructor TSimpleXmlNodeEh.Create(AType: TSimpleXmlNodeTypeEh; ANodeName: String);
begin
  FType := AType;
  FNodeName := ANodeName;
end;

destructor TSimpleXmlNodeEh.Destroy;
begin
  FreeAndNil(FChildNodes);
  FreeAndNil(FAttributeNodes);
  inherited Destroy;
end;

procedure TSimpleXmlNodeEh.SetAttributeByName(const AttrName, Value: String);
var
  AttrNode: TSimpleXmlNodeEh;
begin
  AttrNode := AttributeNodes.FindNode(AttrName);
  if AttrNode = nil then
  begin
    AttrNode := TSimpleXmlNodeEh.Create(xntAttribute, AttrName);
    AttrNode.NodeValue := Value;
    AttributeNodes.Add(AttrNode);
  end else
  begin
    AttrNode.NodeValue := Value;
  end;
end;

function TSimpleXmlNodeEh.GetAttributeByName(const AttrName: String): String;
var
  AttrNode: TSimpleXmlNodeEh;
begin
  Result := '';
  if (FAttributeNodes = nil) then Exit;
  AttrNode := AttributeNodes.FindNode(AttrName);
  if AttrNode = nil then Exit;
  Result := AttrNode.NodeValue;
end;

function TSimpleXmlNodeEh.GetAttributesCount: Integer;
begin
  if (FAttributeNodes <> nil)
    then Result := FAttributeNodes.Count
    else Result := 0;
end;

function TSimpleXmlNodeEh.GetAttributeNodes: TSimpleXMLNodeListEh;
begin
  if (FAttributeNodes = nil) then
    FAttributeNodes := TSimpleXMLNodeListEh.Create(Self);
  Result := FAttributeNodes;
end;

function TSimpleXmlNodeEh.GetChildNodes: TSimpleXMLNodeListEh;
begin
  if (FChildNodes = nil) then
    FChildNodes := TSimpleXMLNodeListEh.Create(Self);
  Result := FChildNodes;
end;

function TSimpleXmlNodeEh.GetChildNodesCount: Integer;
begin
  if (FChildNodes <> nil)
    then Result := FChildNodes.Count
    else Result := 0;
end;

function TSimpleXmlNodeEh.GetFirstChild: TSimpleXmlNodeEh;
begin
  if (FChildNodes <> nil) and (FChildNodes.Count > 0)
    then Result := FChildNodes[0]
    else Result := nil;
end;

function TSimpleXmlNodeEh.GetNodeName: String;
begin
  Result := FNodeName;
end;

function TSimpleXmlNodeEh.GetNodeType: TSimpleXmlNodeTypeEh;
begin
  Result := FType;
end;

function TSimpleXmlNodeEh.GetNodeValue: String;
begin
  Result := FNodeValue;
end;

procedure TSimpleXmlNodeEh.SetNodeValue(const Value: String);
begin
  FNodeValue := Value;
end;

function TSimpleXmlNodeEh.GetParentNode: TSimpleXmlNodeEh;
begin
  Result := FParent;
end;

procedure TSimpleXmlNodeEh.InternalAddChild(const AChild: TSimpleXmlNodeEh);
begin
  ChildNodes.Add(AChild);
end;

procedure TSimpleXmlNodeEh.SetParent(const AValue: TSimpleXmlNodeEh);
begin
  Assert(FParent = nil);
  FParent := AValue;
end;

{ TXmlDocument }

constructor TSimpleXmlDocumentEh.Create;
begin
  inherited Create;
end;

destructor TSimpleXmlDocumentEh.Destroy;
begin
  FreeAndNil(FRoot);
  inherited Destroy;
end;

procedure TSimpleXmlDocumentEh.Clear;
begin
  FreeAndNil(FRoot);
end;

function TSimpleXmlDocumentEh.CreateNode(const AType: TSimpleXmlNodeTypeEh; ANodeName: String): TSimpleXmlNodeEh;
begin
  Result := TSimpleXmlNodeEh.Create(AType, ANodeName);
end;

function TSimpleXmlDocumentEh.GetChildNodes: TSimpleXMLNodeListEh;
begin
  Result := FRoot.ChildNodes;
end;

function TSimpleXmlDocumentEh.GetDocumentElement: TSimpleXmlNodeEh;
begin
  Result := FRoot.GetFirstChild;
end;

function TSimpleXmlDocumentEh.GetRoot: TSimpleXmlNodeEh;
begin
  Result := FRoot;
end;

procedure TSimpleXmlDocumentEh.Load(const AReader: TXmlReader);
var
  CurNode: TSimpleXmlNodeEh;
  State: TXmlReaderState;
  NewNode: TSimpleXmlNodeEh;
  AttrNode: TSimpleXmlNodeEh;
  Attr: TXmlReaderAttribute;
  ReaderValue: String;
  NodeName: String;
  AttrName: String;
  I: Integer;
begin
  Clear;
  if (AReader = nil) then
    Exit;

  FRoot := CreateNode(xntElement, '');
  CurNode := FRoot;

  while AReader.ReadNextElement(State) do
  begin
    case State of
      xrdStartElement:
        begin
          Assert(CurNode <> nil);

          //NodeName := GetPoolTextByIndex(AReader.ValueIndex);
          NodeName := AReader.CurrentElementName;
          NewNode := CreateNode(xntElement, NodeName);
          CurNode.InternalAddChild(NewNode);

          //SetNodeValueIndex(NewNode, AReader.ValueIndex);
          //NewNode.SetValueIndex(AReader.ValueIndex);
          //NewNode.NodeValue := AReader.ValueString;
          for I := 0 to AReader.AttributeCount - 1 do
          begin
            Attr := AReader.Attributes[I];
            //AttrName := GetPoolTextByIndex(Attr.NameIndex);
            AttrName := Attr.Name;
            AttrNode := CreateNode(xntElement, AttrName);
            AttrNode.NodeValue := Attr.Value;
            NewNode.AttributeNodes.Add(AttrNode);

            //NewNode.InternalAddAttribute(Attr.NameIndex, Attr.Value);
            //NewNode.Attributes[GetPoolTextByIndex(Attr.NameIndex)] := Attr.Value;
          end;

          if (not AReader.IsEmptyElement) then
            CurNode := NewNode;
        end;

      xrdEndElement:
        begin
          Assert(CurNode <> nil);

          if (CurNode = FRoot) then
            AReader.ParseError(@RS_XML_INVALID_END_ELEMENT);

          //ReaderValue := GetPoolTextByIndex(AReader.ValueIndex);
          ReaderValue := AReader.CurrentElementName;
          if (CurNode.NodeName <> ReaderValue) then
            AReader.ParseError(@RS_XML_ELEMENT_NAME_MISMATCH);

          CurNode := CurNode.ParentNode;
        end;
    else
      Assert(State in [xrdText, xrdComment, xrdCData]);

      if (CurNode = FRoot) and (State = xrdCData) then
        AReader.ParseError(@RS_XML_CDATA_NOT_ALLOWED);

      if (State = xrdText) then
      begin
        //NodeName := AReader.ValueString;
        //NewNode := CreateNode(State, NodeName);
        //NewNode.NodeValue := AReader.ValueString;
        //CurNode.InternalAddChild(NewNode);
        CurNode.NodeValue := AReader.ValueString;
      end else
      begin
        AReader.ParseError(@RS_XML_CDATA_NOT_ALLOWED);
      end;
    end;
  end;
end;

procedure TSimpleXmlDocumentEh.LoadFromFile(const AFilename: String);
var
  Reader: TXmlReader;
begin
  Reader := TXmlReader.LoadFromFile(AFilename);
  try
    Load(Reader);
  finally
    Reader.Free;
  end;
end;

procedure TSimpleXmlDocumentEh.LoadFromStream(const AStream: TStream);
var
  Reader: TXmlReader;
begin
  Reader := TXmlReader.LoadFromStream(AStream);
  try
    Load(Reader);
  finally
    Reader.Free;
  end;
end;

procedure TSimpleXmlDocumentEh.LoadFromArray(const ABytes: TBytes);
var
  Reader: TXmlReader;
begin
  Reader := TXmlReader.LoadFromArray(ABytes);
  try
    Load(Reader);
  finally
    Reader.Free;
  end;
end;

procedure TSimpleXmlDocumentEh.Parse(const AXml: String);
var
  Reader: TXmlReader;
begin
  Reader := TXmlReader.Create(AXml);
  try
    Load(Reader);
  finally
    Reader.Free;
  end;
end;

procedure TSimpleXmlDocumentEh.Save(const AWriter: TXmlWriter);
var
  Depth: Integer;
  WriteNewLine: Boolean;

  procedure WriteNode(ANode: TSimpleXmlNodeEh);
  var
    I: Integer;
    AttrNode: TSimpleXmlNodeEh;
  begin
    AWriter.WriteIndent(Depth);
    AWriter.Write('<');
    AWriter.Write(ANode.NodeName);

    for I := 0 to ANode.AttributesCount - 1 do
    begin
      AttrNode := ANode.AttributeNodes[I];
      AWriter.Write(' ');
      AWriter.Write(AttrNode.NodeName);
      AWriter.Write('="');
      AWriter.WriteEncoded(AttrNode.NodeValue, True);
      AWriter.Write('"');
    end;

    AWriter.Write('>');

    if (WriteNewLine) then
      Inc(Depth);

    for I := 0 to ANode.ChildNodesCount - 1 do
    begin
      if (WriteNewLine) then
        AWriter.WriteLineBreak;
      WriteNode(ANode.ChildNodes[i]);
    end;

    if (WriteNewLine) then
      Dec(Depth);

    if (ANode.NodeValue <> '') then
    begin
      if (ANode.ChildNodes.Count > 0) and (WriteNewLine) then
      begin
        AWriter.WriteLineBreak;
        AWriter.WriteIndent(Depth);
      end;
      AWriter.WriteEncoded(ANode.NodeValue);
    end;

    if (ANode.ChildNodes.Count > 0) and (WriteNewLine) then
    begin
      AWriter.WriteLineBreak;
      AWriter.WriteIndent(Depth);
    end;
    AWriter.Write('</');
    AWriter.Write(ANode.NodeName);
    AWriter.Write('>');
  end;

var
  I: Integer;
begin
  Assert(AWriter <> nil);
  if (FRoot = nil) then Exit;

  Depth := 0;
  WriteNewLine := True;

  for I := 0 to FRoot.ChildNodesCount - 1 do
  begin
    if (WriteNewLine) then
      AWriter.WriteLineBreak;
    WriteNode(FRoot.ChildNodes[i]);
  end;
end;

procedure TSimpleXmlDocumentEh.SaveToFile(const AFilename: String; const AOptions: TXmlOutputOptions);
var
  Bytes: TBytes;
  Stream: TFileStream;
begin
  Bytes := ToBytes(AOptions);
  if (Bytes = nil) then
    Exit;

  Stream := TFileStream.Create(AFilename, fmCreate or fmShareDenyWrite);
  try
    Stream.WriteBuffer(Bytes, Length(Bytes));
  finally
    Stream.Free;
  end;
end;

procedure TSimpleXmlDocumentEh.SaveToStream(const AStream: TStream; const AOptions: TXmlOutputOptions);
var
  Bytes: TBytes;
begin
  if (AStream = nil) then
    Exit;

  Bytes := ToBytes(AOptions);
  if (Bytes <> nil) then
    AStream.WriteBuffer(Bytes, Length(Bytes));
end;

function TSimpleXmlDocumentEh.ToBytes(const AOptions: TXmlOutputOptions): TBytes;
var
  Writer: TXmlWriter;
begin
  if (FRoot = nil) then
  begin
    Result := nil;
    Exit;
  end;

  Writer := TXmlWriter.Create(AOptions);
  try
    Save(Writer);
    Result := Writer.ToBytes;
  finally
    Writer.Free;
  end;
end;

function TSimpleXmlDocumentEh.ToXml(const AOptions: TXmlOutputOptions): String;
var
  Writer: TXmlWriter;
begin
  if (FRoot = nil) then
  begin
    Result := '';
    Exit;
  end;

  Writer := TXmlWriter.Create(AOptions);
  try
    Save(Writer);
    Result := Writer.ToXml;
  finally
    Writer.Free;
  end;
end;

{ TXMLNodeList }

constructor TSimpleXMLNodeListEh.Create(AOwnerNode: TSimpleXmlNodeEh);
begin
  inherited Create;
  FOwnerNode := AOwnerNode;
  FNodeList := TObjectListEh.Create;
end;

destructor TSimpleXMLNodeListEh.Destroy;
begin
  Clear;
  FreeAndNil(FNodeList);
  inherited Destroy;
end;

function TSimpleXMLNodeListEh.Add(const ANode: TSimpleXmlNodeEh): Integer;
begin
  //Assert(FNode <> nil);
  Assert(FOwnerNode.NodeType = xntElement);
  Assert(ANode <> nil);

  ANode.SetParent(FOwnerNode);
  FNodeList.Add(ANode);
  Result := FNodeList.Count - 1;
end;

procedure TSimpleXMLNodeListEh.Clear;
var
  I: Integer;
begin
  for I := 0  to FNodeList.Count - 1  do
    FNodeList[I].Free;
  FNodeList.Clear;
end;

function TSimpleXMLNodeListEh.FindNode(NodeName: String): TSimpleXmlNodeEh;
var
  I: Integer;
begin
  Result := nil;
  for I := 0  to FNodeList.Count - 1  do
  begin
    if TSimpleXmlNodeEh(FNodeList[I]).NodeName = NodeName then
    begin
      Result := TSimpleXmlNodeEh(FNodeList[I]);
      Exit;
    end;
  end;
end;

function TSimpleXMLNodeListEh.Get(Index: Integer): TSimpleXmlNodeEh;
begin
  Result := TSimpleXmlNodeEh(FNodeList[Index]);
end;

function TSimpleXMLNodeListEh.GetCount: Integer;
begin
  Result := FNodeList.Count;
end;

function TSimpleXMLNodeListEh.GetNode(const Index: Integer): TSimpleXmlNodeEh;
begin
  Result := TSimpleXmlNodeEh(FNodeList[Index]);
end;

procedure TSimpleXMLNodeListEh.Insert(Index: Integer; const Node: TSimpleXmlNodeEh);
begin
  FNodeList.Insert(Index, Node);
end;

end.
