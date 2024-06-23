{*******************************************************}
{                                                       }
{                        EhLib 10.2                     }
{                                                       }
{                  TCompoManEh component                }
{                                                       }
{    Copyright (c) 2014-2022 by Dmitry V. Bolshakov     }
{                                                       }
{*******************************************************}

{$I EhLib.Inc}

unit CompoMansEh;

interface

uses
  Windows, SysUtils, Classes, Graphics, Dialogs, Variants, Db;

type

{ TCompoManEh }

  TCompoManEh = class(TComponent)
  private
  protected
    FVisibleComponentListPos: TStringList;
    procedure DefineProperties(Filer: TFiler); override;
    procedure ReadCompoPoses(Reader: TReader);
    procedure WriteCompoPoses(Writer: TWriter);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

implementation

{ TCompoManEh }

constructor TCompoManEh.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FVisibleComponentListPos := TStringList.Create;
end;

destructor TCompoManEh.Destroy;
begin
  if Owner <> nil then Owner.RemoveComponent(Self);
  FreeAndNil(FVisibleComponentListPos);
  inherited Destroy;
end;

procedure TCompoManEh.ReadCompoPoses(Reader: TReader);
begin
  FVisibleComponentListPos.Clear;
  Reader.ReadListBegin;
  while not Reader.EndOfList do
    FVisibleComponentListPos.Add(Reader.ReadString);
  Reader.ReadListEnd;
end;

procedure TCompoManEh.WriteCompoPoses(Writer: TWriter);
var
  I: Integer;
begin
  Writer.WriteListBegin;
  for I := 0 to FVisibleComponentListPos.Count - 1 do
    Writer.WriteString(FVisibleComponentListPos[I]);
  Writer.WriteListEnd;
end;

procedure TCompoManEh.DefineProperties(Filer: TFiler);
begin
  inherited DefineProperties(Filer);
  Filer.DefineProperty('VisibleComponentListPos', ReadCompoPoses, WriteCompoPoses, True);
end;

end.
