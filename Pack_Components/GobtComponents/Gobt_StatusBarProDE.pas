{------------------------------------------------------------------------------}
{                                                                              }
{  TStatusBarPro v1.80                                                         }
{  by Kambiz R. Khojasteh                                                      }
{                                                                              }
{  kambiz@delphiarea.com                                                       }
{  http://www.delphiarea.com                                                   }
{                                                                              }
{------------------------------------------------------------------------------}


unit Gobt_StatusBarProDE;

interface

uses
  Windows, Classes, DesignIntf, DesignEditors, Gobt_StatusBarPro, TypInfo;

type
  TStatusBarProEditor = class(TDefaultEditor)
  protected
  //  procedure PanelsEditor(Prop: TPropertyEditor);
  public
    function GetVerbCount: Integer; override;
    function GetVerb(Index: Integer): string; override;
    procedure ExecuteVerb(Index: Integer); override;
    procedure EditProperty(const Prop: IProperty; var Continue: Boolean); override;

  end;


implementation

function TStatusBarProEditor.GetVerbCount: Integer;
begin
  Result:= 1;
end;

function TStatusBarProEditor.GetVerb(Index: Integer): string;
begin
  if Index = 0 then
    Result := 'Panels Editor...'
  else
    Result := inherited GetVerb(Index);
end;

procedure TStatusBarProEditor.ExecuteVerb(Index: Integer);
begin
  if Index = 0 then
    Edit
  else
    inherited ExecuteVerb(Index);
end;

procedure TStatusBarProEditor.EditProperty(const Prop: IProperty;
  var Continue: Boolean);
begin
  if Prop.GetName = 'Panels' then
  begin
    Prop.Edit;
    Continue := False;
  end;
end;

end.
