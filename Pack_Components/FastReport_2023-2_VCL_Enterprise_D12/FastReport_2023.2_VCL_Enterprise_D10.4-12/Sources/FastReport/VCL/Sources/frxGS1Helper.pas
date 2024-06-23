unit frxGS1Helper;

interface

{$I frx.inc}

uses
  {$IFNDEF FPC}Windows, Messages, {$ENDIF}
  Types, SysUtils, Classes, Graphics, Controls, Forms, Dialogs
  {$IFDEF FPC}
  , LCLType, LazHelper, LCLIntf, LCLProc
  {$ENDIF}
  , StrUtils
{$IFDEF DELPHI16}
, System.UITypes
{$ENDIF}
  ;

function ParseGS1(code: AnsiString): AnsiString;

implementation

type
  TfrxAICodesData = packed record
   AI: AnsiString;
   AISize:Byte;
   DataMinSize:Byte;
   DataMaxSize:Byte;
   FNC1 :Boolean;
  end;

const AICodesCount = 89;
{ AI table }
{ https://www.gs1.org/docs/barcodes/GS1_General_Specifications.pdf }
const AICodesData:array[0 .. AICodesCount - 1] of TfrxAICodesData =
  (
    (AI: '00'; AISize: 2; DataMinSize: 18; DataMaxSize: 18; FNC1: False),
    (AI: '01'; AISize: 2; DataMinSize: 14; DataMaxSize: 14; FNC1: False),
    (AI: '02'; AISize: 2; DataMinSize: 14; DataMaxSize: 14; FNC1: False),
    (AI: '10'; AISize: 2; DataMinSize: 1; DataMaxSize: 20; FNC1: True),
    (AI: '11'; AISize: 2; DataMinSize: 6; DataMaxSize: 6; FNC1: False),
    (AI: '12'; AISize: 2; DataMinSize: 6; DataMaxSize: 6; FNC1: False),
    (AI: '13'; AISize: 2; DataMinSize: 6; DataMaxSize: 6; FNC1: False),
    (AI: '15'; AISize: 2; DataMinSize: 6; DataMaxSize: 6; FNC1: False),
    (AI: '16'; AISize: 2; DataMinSize: 6; DataMaxSize: 6; FNC1: False),
    (AI: '17'; AISize: 2; DataMinSize: 6; DataMaxSize: 6; FNC1: False),
    (AI: '20'; AISize: 2; DataMinSize: 2; DataMaxSize: 2; FNC1: False),
    (AI: '21'; AISize: 2; DataMinSize: 1; DataMaxSize: 20; FNC1: True),
    (AI: '22'; AISize: 2; DataMinSize: 1; DataMaxSize: 20; FNC1: True),
    (AI: '240'; AISize: 3; DataMinSize: 1; DataMaxSize: 30; FNC1: True),
    (AI: '241'; AISize: 3; DataMinSize: 1; DataMaxSize: 30; FNC1: True),
    (AI: '242'; AISize: 3; DataMinSize: 1; DataMaxSize: 6; FNC1: True),
    (AI: '243'; AISize: 3; DataMinSize: 1; DataMaxSize: 20; FNC1: True),
    (AI: '250'; AISize: 3; DataMinSize: 1; DataMaxSize: 30; FNC1: True),
    (AI: '251'; AISize: 3; DataMinSize: 1; DataMaxSize: 30; FNC1: True),
    (AI: '253'; AISize: 3; DataMinSize: 13; DataMaxSize: 30; FNC1: True),
    (AI: '254'; AISize: 3; DataMinSize: 1; DataMaxSize: 20; FNC1: True),
    (AI: '255'; AISize: 3; DataMinSize: 13; DataMaxSize: 25; FNC1: True),
    (AI: '30'; AISize: 2; DataMinSize: 1; DataMaxSize: 8; FNC1: True),
    (AI: '31XX'; AISize: 4; DataMinSize: 6; DataMaxSize: 6; FNC1: False),  // all 31xx
    (AI: '32XX'; AISize: 4; DataMinSize: 6; DataMaxSize: 6; FNC1: False),  // all 32xx
    (AI: '33XX'; AISize: 4; DataMinSize: 6; DataMaxSize: 6; FNC1: False),  // all 33xx
    (AI: '34XX'; AISize: 4; DataMinSize: 6; DataMaxSize: 6; FNC1: False),  // all 34xx
    (AI: '35XX'; AISize: 4; DataMinSize: 6; DataMaxSize: 6; FNC1: False),  // all 35xx
    (AI: '36XX'; AISize: 4; DataMinSize: 6; DataMaxSize: 6; FNC1: False),  // all 36xx
    (AI: '37'; AISize: 2; DataMinSize: 1; DataMaxSize: 8; FNC1: True),
    (AI: '390X'; AISize: 4; DataMinSize: 1; DataMaxSize: 15; FNC1: True),
    (AI: '391X'; AISize: 4; DataMinSize: 3; DataMaxSize: 18; FNC1: True),
    (AI: '392X'; AISize: 4; DataMinSize: 1; DataMaxSize: 15; FNC1: True),
    (AI: '393X'; AISize: 4; DataMinSize: 3; DataMaxSize: 18; FNC1: True),
    (AI: '394X'; AISize: 4; DataMinSize: 4; DataMaxSize: 4; FNC1: True),
    (AI: '400'; AISize: 3; DataMinSize: 1; DataMaxSize: 30; FNC1: True),
    (AI: '401'; AISize: 3; DataMinSize: 1; DataMaxSize: 30; FNC1: True),
    (AI: '402'; AISize: 3; DataMinSize: 17; DataMaxSize: 17; FNC1: True),
    (AI: '403'; AISize: 3; DataMinSize: 1; DataMaxSize: 30; FNC1: True),
    (AI: '41X'; AISize: 3; DataMinSize: 13; DataMaxSize: 13; FNC1: False),
    (AI: '420'; AISize: 3; DataMinSize: 1; DataMaxSize: 20; FNC1: True),
    (AI: '421'; AISize: 3; DataMinSize: 3; DataMaxSize: 12; FNC1: True),
    (AI: '422'; AISize: 3; DataMinSize: 3; DataMaxSize: 3; FNC1: True),
    (AI: '423'; AISize: 3; DataMinSize: 3; DataMaxSize: 15; FNC1: True),
    (AI: '424'; AISize: 3; DataMinSize: 3; DataMaxSize: 3; FNC1: True),
    (AI: '425'; AISize: 3; DataMinSize: 3; DataMaxSize: 15; FNC1: True),
    (AI: '426'; AISize: 3; DataMinSize: 3; DataMaxSize: 3; FNC1: True),
    (AI: '7001'; AISize: 4; DataMinSize: 13; DataMaxSize: 13; FNC1: True),
    (AI: '7002'; AISize: 4; DataMinSize: 1; DataMaxSize: 30; FNC1: True),
    (AI: '7003'; AISize: 4; DataMinSize: 10; DataMaxSize: 10; FNC1: True),
    (AI: '7004'; AISize: 4; DataMinSize: 1; DataMaxSize: 4; FNC1: True),
    (AI: '7005'; AISize: 4; DataMinSize: 1; DataMaxSize: 12; FNC1: True),
    (AI: '7006'; AISize: 4; DataMinSize: 6; DataMaxSize: 6; FNC1: True),
    (AI: '7007'; AISize: 4; DataMinSize: 6; DataMaxSize: 12; FNC1: True),
    (AI: '7008'; AISize: 4; DataMinSize: 1; DataMaxSize: 3; FNC1: True),
    (AI: '7009'; AISize: 4; DataMinSize: 1; DataMaxSize: 10; FNC1: True),
    (AI: '7010'; AISize: 4; DataMinSize: 1; DataMaxSize: 2; FNC1: True),
    (AI: '7020'; AISize: 4; DataMinSize: 1; DataMaxSize: 20; FNC1: True),
    (AI: '7021'; AISize: 4; DataMinSize: 1; DataMaxSize: 20; FNC1: True),
    (AI: '7022'; AISize: 4; DataMinSize: 1; DataMaxSize: 20; FNC1: True),
    (AI: '7023'; AISize: 4; DataMinSize: 1; DataMaxSize: 30; FNC1: True),
    (AI: '703X'; AISize: 4; DataMinSize: 3; DataMaxSize: 30; FNC1: True),
    (AI: '710'; AISize: 3; DataMinSize: 1; DataMaxSize: 20; FNC1: True),
    (AI: '711'; AISize: 3; DataMinSize: 1; DataMaxSize: 20; FNC1: True),
    (AI: '712'; AISize: 3; DataMinSize: 1; DataMaxSize: 20; FNC1: True),
    (AI: '713'; AISize: 3; DataMinSize: 1; DataMaxSize: 20; FNC1: True),
    (AI: '71X'; AISize: 3; DataMinSize: 1; DataMaxSize: 20; FNC1: True),
    (AI: '8001'; AISize: 4; DataMinSize: 14; DataMaxSize: 14; FNC1: True),
    (AI: '8002'; AISize: 4; DataMinSize: 1; DataMaxSize: 20; FNC1: True),
    (AI: '8003'; AISize: 4; DataMinSize: 14; DataMaxSize: 30; FNC1: True),
    (AI: '8004'; AISize: 4; DataMinSize: 1; DataMaxSize: 30; FNC1: True),
    (AI: '8005'; AISize: 4; DataMinSize: 6; DataMaxSize: 6; FNC1: True),
    (AI: '8006'; AISize: 4; DataMinSize: 18; DataMaxSize: 18; FNC1: True),
    (AI: '8007'; AISize: 4; DataMinSize: 1; DataMaxSize: 34; FNC1: True),
    (AI: '8008'; AISize: 4; DataMinSize: 8; DataMaxSize: 12; FNC1: True),
    (AI: '8010'; AISize: 4; DataMinSize: 1; DataMaxSize: 30; FNC1: True),
    (AI: '8011'; AISize: 4; DataMinSize: 1; DataMaxSize: 12; FNC1: True),
    (AI: '8012'; AISize: 4; DataMinSize: 1; DataMaxSize: 20; FNC1: True),
    (AI: '8013'; AISize: 4; DataMinSize: 1; DataMaxSize: 30; FNC1: True),
    (AI: '8017'; AISize: 4; DataMinSize: 18; DataMaxSize: 18; FNC1: True),
    (AI: '8018'; AISize: 4; DataMinSize: 18; DataMaxSize: 18; FNC1: True),
    (AI: '8019'; AISize: 4; DataMinSize: 1; DataMaxSize: 10; FNC1: True),
    (AI: '8020'; AISize: 4; DataMinSize: 1; DataMaxSize: 25; FNC1: True),
    (AI: '8110'; AISize: 4; DataMinSize: 1; DataMaxSize: 70; FNC1: True),
    (AI: '8111'; AISize: 4; DataMinSize: 4; DataMaxSize: 4; FNC1: True),
    (AI: '8112'; AISize: 4; DataMinSize: 1; DataMaxSize: 70; FNC1: True),
    (AI: '8200'; AISize: 4; DataMinSize: 1; DataMaxSize: 70; FNC1: True),
    (AI: '90'; AISize: 2; DataMinSize: 1; DataMaxSize: 30; FNC1: True),
    (AI: '9X'; AISize: 2; DataMinSize: 1; DataMaxSize: 90; FNC1: True)
  );

function ParseGS1(code: AnsiString): AnsiString;
var
  i: Integer;
  s: AnsiString;

  function FindAIIndex(const Code: AnsiString; Index: Integer): Integer;
  var
    CodeLen, MaxLen, j, i: Integer;
  begin
    Result := -1;
    if code[Index] <> '(' then Exit;
    CodeLen := Length(code) - Index;
    if CodeLen < 3 then Exit;
    for i := 0 to AICodesCount - 1 do
    begin
      Result := -1;
      MaxLen := Length(AICodesData[i].AI);
      if MaxLen > CodeLen then continue;
      for j := 1 to MaxLen do
      begin
        Result := i;
        if (AICodesData[i].AI[j] <> code[Index + j]) and (AICodesData[i].AI[j] <> 'X') then
        begin
          Result := -1;
          break;
        end;
      end;
      if Result <> -1 then break;
    end;
  end;

  { simple GS1 rules implementation }
  function GetCode(const Code: AnsiString; var Index: Integer): AnsiString;
  var
    FoundAI, MaxLen, CodeLen, TempIndex: Integer;
  begin
    Result := '';
    FoundAI := FindAIIndex(code, Index);
    { no AI was found }
    if FoundAI = -1 then Exit;
    Inc(Index, Length(AICodesData[FoundAI].AI) + 1);
    { error in syntax }
    if (code[Index] <> ')') then Exit;
    CodeLen := Length(code) - Index;
    Inc(Index);
    if not AICodesData[FoundAI].FNC1 and (CodeLen >= AICodesData[FoundAI].DataMaxSize) then
    begin
      Result := Copy(code, Index - AICodesData[FoundAI].AISize - 1, AICodesData[FoundAI].AISize) +
        {AICodesData[FoundAI].AI +} Copy(code, Index, AICodesData[FoundAI].DataMaxSize);
      Inc(Index, AICodesData[FoundAI].DataMaxSize);
    end
    else if AICodesData[FoundAI].FNC1 then
    begin
      MaxLen := CodeLen;
      TempIndex := Index;
      while TempIndex <= Length(code) do
      begin
        TempIndex := PosEx('(', String(code), TempIndex);
        if FindAIIndex(code, TempIndex) <> -1 then
        begin
          MaxLen :=  TempIndex - Index;
          break;
        end;
        Inc(TempIndex);
      end;
      if MaxLen < 0 then MaxLen := CodeLen;
      if (MaxLen >= AICodesData[FoundAI].DataMinSize) and (MaxLen <= AICodesData[FoundAI].DataMaxSize) then
      begin
        Result := Copy(code, Index - AICodesData[FoundAI].AISize - 1, AICodesData[FoundAI].AISize) +
          {AICodesData[FoundAI].AI +} Copy(code, Index, MaxLen);
        if MaxLen < CodeLen then
          Result := Result + '&1;';
        Inc(Index, MaxLen);
      end;
    end;
  end;

begin
  Result := '';
  if Length(code) < 3 then Exit;
  s := '';
  i := 1;
  Result := '&1;';
  while i < Length(code) do
  begin
    s := GetCode(code, i);
    if s <> '' then
      Result := Result + s
    else
    begin
      Result := '';
      Exit;
    end;
  end;
end;

end.
