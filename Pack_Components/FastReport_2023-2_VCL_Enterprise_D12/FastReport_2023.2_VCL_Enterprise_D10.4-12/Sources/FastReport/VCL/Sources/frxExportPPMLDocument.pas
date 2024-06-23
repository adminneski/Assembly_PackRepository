unit frxExportPPMLDocument;

interface

{$I frx.inc}

uses
{$IFNDEF Linux}
  Windows,
{$ELSE}
  LCLType, LCLIntf, LCLProc,
{$ENDIF}
  Messages, frxExportBaseDialog, SysUtils, Classes, Graphics, frxClass, frxExportMatrix, Math, frxBarcod, frxBarcode, frxBarcode2D,
  frxBarcodeMaxiCode, frxTableObject, frxRes, frxImageConverter, frxExportPSDocument, frxExportPSHelper, frXML;

type PPMLDocument = class(PSDocument)
  protected
    doc: TfrXMLDocument;
    root, internalData, mark, document: TfrXMLItem;
    procedure CreateWindow(name: String; Width, Height: Double); override;
  public
    procedure AddPage(); override;
    procedure Save(stream: TStream); overload; override;
    procedure Save(fn: String); overload; override;
    procedure Finish(); override;
    Destructor Destroy; override;
end;


implementation

uses frxUtils;

procedure PPMLDocument.CreateWindow(name: String; Width, Height: Double);
var
  PAGE_DESIGN, JOB: TfrXMLItem;
begin
  Inherited;
  doc := TfrXMLDocument.Create();
  doc.AutoIndent := True;

  root := doc.Root;
  root.Name := 'PPML';
  root.Prop['xmlns'] := 'urn://www.podi.org/ppml/ppml3';
  root.Prop['xmlns:xsi'] := 'http://www.w3.org/2001/XMLSchema-instance';
  root.Prop['xsi:schemaLocation'] := 'urn://www.podi.org/ppml/ppml3 http://www.podi.org/ppml/ppml300.xsd';
  root.Prop['Version'] := '3.0';

  PAGE_DESIGN := root.Add('PAGE_DESIGN');
  PAGE_DESIGN.Prop['TrimBox'] := '0 0 ' + FloatToString(windowWidth) + ' ' + FloatToString(windowHeight);

  JOB := root.Add('JOB');

  document := JOB.Add('DOCUMENT');
end;

procedure PPMLDocument.AddPage();
var
  PAGE, OBJ, SOURCE: TfrXMLItem;
begin
  PAGE := document.Add('PAGE');

  mark := PAGE.Add('MARK');
  mark.Prop['Position'] := '0 0';

  OBJ := mark.Add('OBJECT');
  OBJ.Prop['Position'] := '0 0';

  SOURCE := OBJ.Add('SOURCE');
  SOURCE.Prop['Format'] := 'application/postscript';
  SOURCE.Prop['Dimensions'] := FloatToString(windowWidth) + ' ' + FloatToString(windowHeight);

  internalData := SOURCE.Add('INTERNAL_DATA');
end;

procedure PPMLDocument.Save(stream: TStream);
begin
  doc.SaveToStream(stream);
end;

procedure PPMLDocument.Save(fn: String);
begin
  doc.SaveToFile(fn);
end;

procedure PPMLDocument.Finish();
begin
  internalData.Value := psData;
  psData := '';
end;

Destructor PPMLDocument.Destroy;
begin
  FreeAndNil(doc);
end;

end.

