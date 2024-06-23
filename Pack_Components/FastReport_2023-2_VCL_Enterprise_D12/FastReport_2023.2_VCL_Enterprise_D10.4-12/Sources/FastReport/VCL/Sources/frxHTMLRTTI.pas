
{******************************************}
{                                          }
{             FastReport v5.0              }
{                HTML RTTI                 }
{                                          }
{            Copyright (c) 2016            }
{             by Oleg Adibekov             }
{             Fast Reports Inc.            }
{                                          }
{******************************************}

unit frxHTMLRTTI;

{$I frx.inc}

interface

implementation

uses
  fs_iinterpreter, frxHTML, frxClassRTTI, Graphics, Classes, Types;

type
  TFunctions = class(TfsRTTIModule)
  private
    function GetProp(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
    procedure SetProp(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
  public
    constructor Create(AScript: TfsScript); override;
  end;

{ TFunctions }

constructor TFunctions.Create(AScript: TfsScript);
begin
  inherited Create(AScript);

  with AScript do
  begin
    with AddClass(TfrxHtmlView, 'TfrxStretcheable') do
    begin
      AddProperty('DefBackground', 'Integer', GetProp, SetProp);
      AddProperty('DefFontColor', 'Integer', GetProp, SetProp);
      AddProperty('DefFontName', 'String', GetProp, SetProp);
      AddProperty('DefFontSize', 'Integer', GetProp, SetProp);
      AddProperty('DefHotSpotColor', 'Integer', GetProp, SetProp);
      AddProperty('DefPreFontName', 'String', GetProp, SetProp);
      AddProperty('MarginHeight', 'Integer', GetProp, SetProp);
      AddProperty('MarginWidth', 'Integer', GetProp, SetProp);
    end;
  end;
end;

function TFunctions.GetProp(Instance: TObject; ClassType: TClass; const PropName: String): Variant;
begin
  Result := 0;

  if ClassType = TfrxHTMLView then
    if      PropName = 'DEFBACKGROUND' then
      Result := Integer(TfrxHTMLView(Instance).DefBackground)
    else if PropName = 'DEFFONTCOLOR' then
      Result := Integer(TfrxHTMLView(Instance).DefFontColor)
    else if PropName = 'DEFFONTNAME' then
      Result := TfrxHTMLView(Instance).DefFontName
    else if PropName = 'DEFFONTSIZE' then
      Result := TfrxHTMLView(Instance).DefFontSize
    else if PropName = 'DEFHOTSPOTCOLOR' then
      Result := Integer(TfrxHTMLView(Instance).DefHotSpotColor)
    else if PropName = 'DEFRPEFONTNAME' then
      Result := TfrxHTMLView(Instance).DefPreFontName
    else if PropName = 'MARGINHEIGHT' then
      Result := TfrxHTMLView(Instance).MarginHeight
    else if PropName = 'MARGINwIDTH' then
      Result := TfrxHTMLView(Instance).MarginWidth
end;

procedure TFunctions.SetProp(Instance: TObject; ClassType: TClass; const PropName: String; Value: Variant);
begin
  if ClassType = TfrxHTMLView then
    if      PropName = 'DEFBACKGROUND' then
      TfrxHTMLView(Instance).DefBackground := TColor(Value)
    else if PropName = 'DEFFONTCOLOR' then
      TfrxHTMLView(Instance).DefFontColor := TColor(Value)
    else if PropName = 'DEFFONTNAME' then
      TfrxHTMLView(Instance).DefFontName := Value
    else if PropName = 'DEFFONTSIZE' then
      TfrxHTMLView(Instance).DefFontSize := Value
    else if PropName = 'DEFHOTSPOTCOLOR' then
      TfrxHTMLView(Instance).DefHotSpotColor := TColor(Value)
    else if PropName = 'DEFRPEFONTNAME' then
      TfrxHTMLView(Instance).DefPreFontName := Value
    else if PropName = 'MARGINHEIGHT' then
      TfrxHTMLView(Instance).MarginHeight := Value
    else if PropName = 'MARGINwIDTH' then
      TfrxHTMLView(Instance).MarginWidth := Value
end;

initialization
  fsRTTIModules.Add(TFunctions);

finalization
  if fsRTTIModules <> nil then
    fsRTTIModules.Remove(TFunctions);

end.
