unit GOX_Calendar;
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls, Grids, Calendar, System.Generics.Collections,
  System.DateUtils;

type
   TGOXCalendar = class(TCalendar)
   private
     { private declarations }
     FDicSelectedDays  : TDictionary<String,Integer>;
     FSelectedDays: String;
     FSelectedDaysCount: Integer;
    function KeyIsDown(const Key: integer): boolean;
   protected
     { protected declarations }
      procedure Click; override;
      procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
   public
     { public declarations }
     constructor Create(AOwner: TComponent); override;
     destructor Destroy; override;
   published
     { published declarations }
     property SelectedDays: String read FSelectedDays write FSelectedDays;
     property SelectedDaysCount: Integer read FSelectedDaysCount write FSelectedDaysCount;
   end;


procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('GOXCode - Miscelanea', [TGOXCalendar]);
end;

constructor TGOXCalendar.Create(AOwner: TComponent);
begin
  inherited;
  FDicSelectedDays := TDictionary<String,Integer>.Create;
end;

destructor TGOXCalendar.Destroy;
begin
  FreeAndNil(FDicSelectedDays);
  inherited;
end;

function TGOXCalendar.KeyIsDown(const Key: integer): boolean;
begin
  Result := GetKeyState(Key) and 128 > 0;
end;

procedure TGOXCalendar.DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState);
var
  LText : String;
  LKey : String;
begin
   inherited;
   LText := CellText[ACol, ARow];
   //Guarda Dias Selecionados
   for LKey in FDicSelectedDays.Keys do
   begin
     if LText = FDicSelectedDays.Items[LKey].ToString then
     begin
       Canvas.Font.Color := clBlue;
       Canvas.Font.Style := [fsBold];
       Canvas.Brush.Color := clMoneyGreen;

       with ARect, Canvas do
         TextRect(ARect, Left + (Right - Left - TextWidth(LText)) div 2,
         Top + (Bottom - Top - TextHeight(LText)) div 2, LText);
         Canvas.Font.Color := clBlue;
     end
     else
     begin
       with ARect, Canvas do
            TextRect(ARect, Left + (Right - Left - TextWidth(LText)) div 2,
            Top + (Bottom - Top - TextHeight(LText)) div 2, LText);
     end;
   end;

end;

procedure TGOXCalendar.Click;
 var
   LDate : TDate;
   LKey : String;
begin
  inherited;
  if KeyIsDown(VK_SHIFT) then
  begin
    LDate := CalendarDate;
    if FDicSelectedDays.ContainsKey(Datetostr(LDate)) then
    Begin
      FDicSelectedDays.Remove(Datetostr(LDate))
    End
    else
    begin
      FDicSelectedDays.Add(Datetostr(LDate),DayOf(LDate));
    end;
    //Gera String de Dias
    FSelectedDays := '';
    FSelectedDaysCount := 0;
    for LKey in FDicSelectedDays.Keys do
    begin
      FSelectedDays := FSelectedDays+','+FDicSelectedDays.Items[LKey].ToString;
    end;
    FSelectedDays := Copy(FSelectedDays,2,FSelectedDays.Length);
    FSelectedDaysCount := FDicSelectedDays.Count;
  end;
end;
end.
