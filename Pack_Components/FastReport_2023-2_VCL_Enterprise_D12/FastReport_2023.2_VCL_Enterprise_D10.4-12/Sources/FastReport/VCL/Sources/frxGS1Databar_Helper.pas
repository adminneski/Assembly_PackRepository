
(*
 * Based on Zint fork
 * https://github.com/landrix/Zint-Barcode-Generator-for-Delphi
 *
 * License: Apache License 2.0
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *)

unit frxGS1Databar_Helper;

{$IFDEF FPC}
{$mode objfpc}{$H+}
{$ENDIF}

interface

uses
  SysUtils;

const
  COLS_MAX = 102;

  NUMERIC = 110;
  ALPHA	= 97;
  ISOIEC = 105;
  INVALID_CHAR = 100;
  ANY_ENC = 120;
  ALPHA_OR_ISO = 121;

  g_sum_exp : array[0..4] of Integer = ( 0, 348, 1388, 2948, 3988 );
  t_even_exp : array[0..4] of Integer = ( 4, 20, 52, 104, 204 );
  modules_odd_exp : array[0..4] of Integer = ( 12, 10, 8, 6, 4 );
  modules_even_exp : array[0..4] of Integer = ( 5, 7, 9, 11, 13 );
  widest_odd_exp : array[0..4] of Integer = ( 7, 5, 4, 3, 1 );
  widest_even_exp : array[0..4] of Integer = ( 2, 4, 5, 6, 8 );
  checksum_weight_exp : array[0..183] of Integer = (
	1, 3, 9, 27, 81, 32, 96, 77,
	20, 60, 180, 118, 143, 7, 21, 63,
	189, 145, 13, 39, 117, 140, 209, 205,
	193, 157, 49, 147, 19, 57, 171, 91,
	62, 186, 136, 197, 169, 85, 44, 132,
	185, 133, 188, 142, 4, 12, 36, 108,
	113, 128, 173, 97, 80, 29, 87, 50,
	150, 28, 84, 41, 123, 158, 52, 156,
	46, 138, 203, 187, 139, 206, 196, 166,
	76, 17, 51, 153, 37, 111, 122, 155,
	43, 129, 176, 106, 107, 110, 119, 146,
	16, 48, 144, 10, 30, 90, 59, 177,
	109, 116, 137, 200, 178, 112, 125, 164,
	70, 210, 208, 202, 184, 130, 179, 115,
	134, 191, 151, 31, 93, 68, 204, 190,
	148, 22, 66, 198, 172, 94, 71, 2,
	6, 18, 54, 162, 64, 192, 154, 40,
	120, 149, 25, 75, 14, 42, 126, 167,
	79, 26, 78, 23, 69, 207, 199, 175,
	103, 98, 83, 38, 114, 131, 182, 124,
	161, 61, 183, 127, 170, 88, 53, 159,
	55, 165, 73, 8, 24, 72, 5, 15,
	45, 135, 194, 160, 58, 174, 100, 89
);
  finder_pattern_exp : array[0..59] of Integer = (
	1, 8, 4, 1, 1,
	1, 1, 4, 8, 1,
	3, 6, 4, 1, 1,
	1, 1, 4, 6, 3,
	3, 4, 6, 1, 1,
	1, 1, 6, 4, 3,
	3, 2, 8, 1, 1,
	1, 1, 8, 2, 3,
	2, 6, 5, 1, 1,
	1, 1, 5, 6, 2,
	2, 2, 9, 1, 1,
	1, 1, 9, 2, 2
);
  finder_sequence : array[0..109] of Integer = (
	1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	1, 4, 3, 0, 0, 0, 0, 0, 0, 0, 0,
	1, 6, 3, 8, 0, 0, 0, 0, 0, 0, 0,
	1, 10, 3, 8, 5, 0, 0, 0, 0, 0, 0,
	1, 10, 3, 8, 7, 12, 0, 0, 0, 0, 0,
	1, 10, 3, 8, 9, 12, 11, 0, 0, 0, 0,
	1, 2, 3, 4, 5, 6, 7, 8, 0, 0, 0,
	1, 2, 3, 4, 5, 6, 7, 10, 9, 0, 0,
	1, 2, 3, 4, 5, 6, 7, 10, 11, 12, 0,
	1, 2, 3, 4, 5, 8, 7, 10, 9, 12, 11
);
  weight_rows : array[0..209] of Integer = (
	0, 1, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 5, 6, 3, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 9, 10, 3, 4, 13, 14, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 17, 18, 3, 4, 13, 14, 7, 8, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 17, 18, 3, 4, 13, 14, 11, 12, 21, 22, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 17, 18, 3, 4, 13, 14, 15, 16, 21, 22, 19, 20, 0, 0, 0, 0, 0, 0, 0, 0,
	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 0, 0, 0, 0, 0, 0,
	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 17, 18, 15, 16, 0, 0, 0, 0,
	0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 17, 18, 19, 20, 21, 22, 0, 0,
	0, 1, 2, 3, 4, 5, 6, 7, 8, 13, 14, 11, 12, 17, 18, 15, 16, 21, 22, 19, 20
);

type
  TEncoded_Data = array of array of Boolean;
  TArrayOfByte = array of Byte;
  TArrayOfInteger = array of Integer;
  TArrayOfChar = array of Char;

  TBaseDatabar = class
  public
    elements : TArrayOfInteger;
    rows, width, data_chars: Integer;
    row_height : array of Integer;
    symbol : TEncoded_Data;
    sub_elements : TArrayOfInteger;
  end;

function StrToArrayOfByte(const AString : string) : TArrayOfByte;
function StrToArrayOfChar(const AString : String) : TArrayOfChar;
function ArrayOfCharToString(const AArray : TArrayOfChar) : String;
procedure ArrayCopy(var ADestination : TArrayOfChar; const ASource : TArrayOfByte; ACount : Integer = MaxInt); overload;
procedure ArrayCopy(var ADestination : TArrayOfByte; const ASource : TArrayOfChar; ACount : Integer = MaxInt); overload;

function strlen(const AString : TArrayOfChar) : Integer;
procedure strcpy(var target : TArrayOfChar; const source : TArrayOfChar); overload;
procedure strcpy(var ATarget : TArrayOfChar; const ASource : String); overload;

function Code_DBEorES(const FText: String; Stacked: Boolean; option_2: Integer = 2): TBaseDatabar;

function CalcSumArrayOfInteger(arr: TArrayOfInteger): Integer;

function ustrlen(const data : TArrayOfByte) : Integer;
procedure concat(var dest : TArrayOfChar; const source : TArrayOfChar); overload;
procedure concat(var ADest: TArrayOfChar; const ASource: String); overload;
function ctoi(source : Char) : Integer;
function itoc(source : Integer) : Char;
function module_is_set(symbol : TEncoded_Data; y_coord : Integer; x_coord : Integer) : Boolean;
procedure set_module(var symbol : TEncoded_Data; y_coord : Integer; x_coord : Integer);
procedure unset_module(var symbol : TEncoded_Data; y_coord : Integer; x_coord : Integer);

function general_rules(field : TArrayOfChar; _type: TArrayOfChar) : Integer;
procedure getRSSwidths(val, n, elements, maxWidth, noNarrow : Integer; out widths : TArrayOfInteger);
function combins(n : Integer; r : Integer) : Integer;

implementation

function StrToArrayOfByte(const AString: string): TArrayOfByte;
var
  i: Integer;
begin
  SetLength(Result, Length(AString) + 1);
  for i := 1 to Length(AString) do
    Result[i - 1]:=Ord(AString[i]);
  Result[High(Result)] := 0;
end;

function StrToArrayOfChar(const AString: String): TArrayOfChar;
var
  i : Integer;
begin
  SetLength(Result, Length(AString) + 1);
  for i := 1 to Length(AString) do
    Result[i - 1] := AString[i];
  Result[High(Result)] := Chr(0);
end;

function ArrayOfCharToString(const AArray: TArrayOfChar): String;
var
  i : Integer;
begin
  Result := '';
  for i := 0 to strlen(AArray) - 1 do
    Result := Result + AArray[i];
end;

procedure ArrayCopy(var ADestination: TArrayOfChar; const ASource: TArrayOfByte; ACount: Integer);
var
  i, j, cnt : Integer;
begin
  i := Low(ADestination);
  j := Low(ASource);
  cnt := 0;
  while (i <= High(ADestination)) and (j <= High(ASource)) and (cnt <= ACount) do
  begin
    ADestination[i] := Chr(ASource[j]);
    Inc(i);
    Inc(j);
    Inc(cnt);
  end;
end;

procedure ArrayCopy(var ADestination: TArrayOfByte; const ASource: TArrayOfChar; ACount: Integer);
var
  i, j, cnt : Integer;
begin
  i := Low(ADestination);
  j := Low(ASource);
  cnt := 0;
  while (i <= High(ADestination)) and (j <= High(ASource)) and (cnt <= ACount) do
  begin
    ADestination[i] := Ord(ASource[j]);
    Inc(i);
    Inc(j);
    Inc(cnt);
  end;
end;

function strlen(const AString: TArrayOfChar): Integer;
var
  i : Integer;
begin
  Result := High(AString) + 1;
  for i := Low(AString) to High(AString) do
    if AString[i] = #0 then
    begin
      Result := i;
      break;
    end;
end;

procedure strcpy(var target: TArrayOfChar; const source: TArrayOfChar);
var
  i, len : Integer;
begin
  len := strlen(source);
  for i := 0 to len - 1 do
    target[i] := source[i];
  target[len] := #0;
end;

procedure strcpy(var ATarget : TArrayOfChar; const ASource : String);
begin
  strcpy(ATarget, StrToArrayOfChar(ASource));
end;

function ustrlen(const data : TArrayOfByte) : Integer;
var
  i : Integer;
begin
  Result := High(data) - Low(data) + 1;
  for i := Low(data) to High(data) do
    if data[i] = 0 then
    begin
      Result := i - Low(data);
      break;
    end;
end;

procedure concat(var dest: TArrayOfChar; const source: TArrayOfChar);
var
  i, j, n : Integer;
begin
  j := strlen(dest);
  n := strlen(source);
  for i := 0 to n do
    dest[i + j] := source[i];
end;

procedure concat(var ADest: TArrayOfChar; const ASource: String);
begin
  concat(ADest, StrToArrayOfChar(ASource));
end;

function ctoi(source : Char) : Integer;
begin
	if (source >= '0') and (source <= '9') then
		result := Ord(source) - Ord('0')
  else
	  result := Ord(source) - Ord('A') + 10;
end;

function itoc(source : Integer) : Char;
begin
  if (source >= 0) and (source <= 9) then
    Result := Chr(Ord('0') + source)
  else
    Result := Chr(Ord('A') + (source - 10));
end;

function module_is_set(symbol : TEncoded_Data; y_coord : Integer; x_coord : Integer) : Boolean;
begin
  result := symbol[y_coord][x_coord];
end;

procedure set_module(var symbol : TEncoded_Data; y_coord : Integer; x_coord : Integer);
begin
  symbol[y_coord][x_coord] := True;
end;

procedure unset_module(var symbol : TEncoded_Data; y_coord : Integer; x_coord : Integer);
begin
  symbol[y_coord][x_coord] := False;
end;

function general_rules(field : TArrayOfChar; _type: TArrayOfChar) : Integer;
var
  block : array[0..1] of array[0..199] of Integer;
  block_count, i, j, k : Integer;
  current, next, last : Byte;
begin
  block_count := 0;

  block[0][block_count] := 1;
  block[1][block_count] := Ord(_type[0]);

  for i := 1 to strlen(_type) - 1 do
  begin
    current := Ord(_type[i]);
    last := Ord(_type[i - 1]);

    if (current = last) then
      block[0][block_count] := block[0][block_count] + 1
    else
    begin
      Inc(block_count);
      block[0][block_count] := 1;
      block[1][block_count] := Ord(_type[i]);
    end;
  end;

  Inc(block_count);

  for i := 0 to block_count - 1 do
  begin
    current := block[1][i];
    next := (block[1][i + 1] and $FF);

    if ((current = ISOIEC) and (i <> (block_count - 1))) then
    begin
      if ((next = ANY_ENC) and (block[0][i + 1] >= 4)) then
        block[1][i + 1] := NUMERIC;

      if ((next = ANY_ENC) and (block[0][i + 1] < 4)) then
        block[1][i + 1] := ISOIEC;

      if ((next = ALPHA_OR_ISO) and (block[0][i + 1] >= 5)) then
        block[1][i + 1] := ALPHA;

      if ((next = ALPHA_OR_ISO) and (block[0][i + 1] < 5)) then
        block[1][i + 1] := ISOIEC;

    end;

    if (current = ALPHA_OR_ISO) then
      block[1][i] := ALPHA;


    if ((current = ALPHA) and (i <> (block_count - 1))) then
    begin
      if ((next = ANY_ENC) and (block[0][i + 1] >= 6)) then
        block[1][i + 1] := NUMERIC;

      if ((next = ANY_ENC) and (block[0][i + 1] < 6)) then
      begin
        if ((i = block_count - 2) and (block[0][i + 1] >= 4)) then
          block[1][i + 1] := NUMERIC
        else
          block[1][i + 1] := ALPHA;
      end;
    end;

    if (current = ANY_ENC) then
      block[1][i] := NUMERIC;
  end;

  if (block_count > 1) then
  begin
    i := 1;
    while(i < block_count) do
    begin
      if (block[1][i - 1] = block[1][i]) then
      begin
        block[0][i - 1] := block[0][i - 1] + block[0][i];
        j := i + 1;

        while(j < block_count) do
        begin
          block[0][j - 1] := block[0][j];
          block[1][j - 1] := block[1][j];
          Inc(j);
        end;
        Dec(block_count);
        Dec(i);
      end;
      Inc(i);
    end;
  end;

  for i := 0 to block_count - 2 do
  begin
    if ((block[1][i] = NUMERIC) and ((block[0][i] and 1) <> 0)) then
    begin
      block[0][i] := block[0][i] - 1;
      block[0][i + 1] := block[0][i + 1] + 1;
    end;
  end;

  j := 0;
  for i := 0 to block_count - 1 do
  begin
    for k := 0 to  block[0][i] - 1 do
    begin
      _type[j] := Chr(block[1][i]);
      Inc(j);
    end;
  end;

  if ((block[1][block_count - 1] = NUMERIC) and ((block[0][block_count - 1] and 1) <> 0)) then
  begin
    result := 1;
  end
  else
  begin
    result := 0;
  end;
end;

{$WARNINGS OFF}
procedure getRSSwidths(val, n, elements, maxWidth, noNarrow : Integer; out widths : TArrayOfInteger);
var
  bar,
  elmWidth,
  mxwElement,
  subVal, lessVal,
  narrowMask : Integer;
begin
  narrowMask := 0;
  SetLength(widths, 8);
  bar := 0;
  while bar < elements-1 do
  begin
    elmWidth := 1;
    narrowMask := narrowMask or (1 shl bar);
    while true do
    begin
      subVal := combins(n-elmWidth-1, elements-bar-2);
      if ((not (noNarrow <> 0)) and (not (narrowMask <> 0)) and
               (n-elmWidth-(elements-bar-1) >= elements-bar-1)) then
      begin
        Dec(subVal, combins(n-elmWidth-(elements-bar), elements-bar-2));
      end;
      if (elements-bar-1 > 1) then
      begin
        lessVal := 0;
        for mxwElement := n-elmWidth-(elements-bar-2) downto maxWidth + 1 do
        begin
          Inc(lessVal, combins(n-elmWidth-mxwElement-1, elements-bar-3));
        end;
        Dec(subVal, lessVal * (elements-1-bar));
      end
      else
      if (n-elmWidth > maxWidth) then
      begin
        Dec(subVal);
      end;
      Dec(val, subVal);
      if (val < 0) then break;
      Inc(elmWidth);
      narrowMask := narrowMask and (not (1 shl bar));
    end;
    Inc(val, subVal);
    Dec(n, elmWidth);
    widths[bar] := elmWidth;
    Inc(bar);
  end;
  widths[bar] := n;
end;
{$WARNINGS ON}

function combins(n : Integer; r : Integer) : Integer;
var
  i, j : Integer;
  maxDenom, minDenom : Integer;
  val : Integer;
begin
  if (n-r > r) then
  begin
    minDenom := r;
    maxDenom := n-r;
  end
  else
  begin
    minDenom := n-r;
    maxDenom := r;
  end;
  val := 1;
  j := 1;
  for i := n downto maxDenom + 1 do
  begin
    val := val * i;
    if (j <= minDenom) then
    begin
      val := val div j;
      Inc(j);
    end;
  end;
  while j <= minDenom do
  begin
    val := val div j;
    Inc(j);
  end;

  result := val;
end;


procedure itostr(var ai_string : TArrayOfChar; ai_value : Integer);
var
  thou, hund, ten, _unit : Integer;
  temp : TArrayOfChar;
begin
  SetLength(temp, 2);
	strcpy(ai_string, '(');
	thou := ai_value div 1000;
	hund := (ai_value - (1000 * thou)) div 100;
	ten := (ai_value - ((1000 * thou) + (100 * hund))) div 10;
	_unit := ai_value - ((1000 * thou) + (100 * hund) + (10 * ten));

  temp[1] := #0;
	if (ai_value >= 1000) then begin temp[0] := itoc(thou); concat(ai_string, temp); end;
  if (ai_value >= 100) then begin temp[0] := itoc(hund); concat(ai_string, temp); end;
  temp[0] := itoc(ten);
  concat(ai_string, temp);
  temp[0] := itoc(_unit);
  concat(ai_string, temp);
  concat(ai_string, ')');
end;


function rss_binary_string(const source : TArrayOfChar; var binary_string : TArrayOfChar) : Integer;
var
  encoding_method, i, mask, j, read_posn, latch, last_mode : Integer;
  general_field, general_field_type : TArrayOfChar;
  remainder, d1, d2, value : Integer;
  padstring : TArrayOfChar;
  weight_str, date_str, currency_str : TArrayOfChar;
  weight : Single;
  group : TArrayOfChar;
  group_val : Integer;
begin
  SetLength(general_field, strlen(source) + 1);
  SetLength(general_field_type, strlen(source) + 1);
  SetLength(padstring, 40);

  read_posn := 0;

  if ((strlen(source) >= 16) and ((source[0] = '0') and (source[1] = '1'))) then
  begin
    encoding_method := 1;
  end
  else
  begin
    encoding_method := 2;
  end;

  if (((strlen(source) >= 20) and (encoding_method = 1)) and ((source[2] = '9') and (source[16] = '3'))) then
  begin
    if ((strlen(source) >= 26) and (source[17] = '1')) then
    begin

      if (source[18] = '0') then
      begin
        SetLength(weight_str, 7);

        for i := 0 to 5 do
          weight_str[i] := source[20 + i];
        weight_str[6] := #0;

        if (weight_str[0] = '0') then
        begin
          encoding_method := 7;

          if ((source[19] = '3') and (strlen(source) = 26)) then
          begin
            weight := StrToFloat(ArrayOfCharToString(weight_str)) / 1000.0;

            if (weight <= 32.767) then encoding_method := 3;
          end;

          if (strlen(source) = 34) then
          begin
            if ((source[26] = '1') and (source[27] = '1')) then
              encoding_method := 7;

            if ((source[26] = '1') and (source[27] = '3')) then
              encoding_method := 9;

            if ((source[26] = '1') and (source[27] = '5')) then
              encoding_method := 11;

            if ((source[26] = '1') and (source[27] = '7')) then
              encoding_method := 13;
          end;
        end;
      end;
    end;

    if ((strlen(source) >= 26) and (source[17] = '2')) then
    begin

      if (source[18] = '0') then
      begin
        SetLength(weight_str, 7);

        for i := 0 to 5 do
          weight_str[i] := source[20 + i];
        weight_str[6] := #0;

        if (weight_str[0] = '0') then
        begin
          encoding_method := 8;

          if (((source[19] = '2') or (source[19] = '3')) and (strlen(source) = 26)) then
          begin
            if (source[19] = '3') then
            begin
              weight := StrToFloat(ArrayOfCharToString(weight_str)) / 1000.0;
              if (weight <= 22.767) then
                encoding_method := 4;
            end
            else
            begin
              weight := StrToFloat(ArrayOfCharToString(weight_str)) / 100.0;
              if (weight <= 99.99) then
                encoding_method := 4;
            end;
          end;

          if (strlen(source) = 34) then
          begin
            if ((source[26] = '1') and (source[27] = '1')) then
              encoding_method := 8;
            if ((source[26] = '1') and (source[27] = '3')) then
              encoding_method := 10;
            if ((source[26] = '1') and (source[27] = '5')) then
              encoding_method := 12;
            if ((source[26] = '1') and (source[27] = '7')) then
              encoding_method := 14;
          end;
        end;
      end;
    end;

    if (source[17] = '9') then
    begin
      if ((source[18] = '2') and ((source[19] >= '0') and (source[19] <= '3'))) then
        encoding_method := 5;
      if ((source[18] = '3') and ((source[19] >= '0') and (source[19] <= '3'))) then
        encoding_method := 6;
    end;
  end;

  case encoding_method of
    1: begin concat(binary_string, '1XX'); read_posn := 16; end;
    2: begin concat(binary_string, '00XX'); read_posn := 0; end;
    3: begin concat(binary_string, '0100'); read_posn := strlen(source); end;
    4: begin concat(binary_string, '0101'); read_posn := strlen(source); end;
    5: begin concat(binary_string, '01100XX'); read_posn := 20; end;
    6: begin concat(binary_string, '01101XX'); read_posn := 23; end;
    7: begin concat(binary_string, '0111000'); read_posn := strlen(source); end;
    8: begin concat(binary_string, '0111001'); read_posn := strlen(source); end;
    9: begin concat(binary_string, '0111010'); read_posn := strlen(source); end;
    10: begin concat(binary_string, '0111011'); read_posn := strlen(source); end;
    11: begin concat(binary_string, '0111100'); read_posn := strlen(source); end;
    12: begin concat(binary_string, '0111101'); read_posn := strlen(source); end;
    13: begin concat(binary_string, '0111110'); read_posn := strlen(source); end;
    14: begin concat(binary_string, '0111111'); read_posn := strlen(source); end;
  end;

  for i := 0 to read_posn - 1 do
  begin
    if ((source[i] < '0') or (source[i] > '9')) then
      if ((source[i] <> '(') and (source[i] <> ')')) then
        raise Exception.Create('Error in ParseGS1 01');
  end;

  if (encoding_method = 1) then
  begin
    SetLength(group, 4);

    group[0] := source[2];
    group[1] := #0;
    group_val := StrToInt(ArrayOfCharToString(group));

    mask := $08;
    for j := 0 to 3 do
    begin
      if (group_val and mask) <> 0 then
        concat(binary_string, '1')
      else
        concat(binary_string, '0');
      mask := mask shr 1;
    end;

    for i := 1 to 4 do
    begin
      group[0] := source[(i * 3)];
      group[1] := source[(i * 3) + 1];
      group[2] := source[(i * 3) + 2];
      group[3] := #0;
      group_val := StrToInt(ArrayOfCharToString(group));

      mask := $200;
      for j := 0 to 9 do
      begin
        if (group_val and mask) <> 0 then
          concat(binary_string, '1')
        else
          concat(binary_string, '0');
        mask := mask shr 1;
      end;
    end;
  end;


  if (encoding_method = 3) then
  begin
    SetLength(group, 4);
    SetLength(weight_str, 7);

    for i := 1 to 4 do
    begin
      group[0] := source[(i * 3)];
      group[1] := source[(i * 3) + 1];
      group[2] := source[(i * 3) + 2];
      group[3] := #0;
      group_val := StrToInt(ArrayOfCharToString(group));

      mask := $200;
      for j := 0 to 9 do
      begin
        if (group_val and mask) <> 0 then
          concat(binary_string, '1')
        else
          concat(binary_string, '0');
        mask := mask shr 1;
      end;
    end;

    for i := 0 to 5 do
    begin
      weight_str[i] := source[20 + i];
    end;
    weight_str[6] := #0;
    group_val := StrToInt(ArrayOfCharToString(weight_str));

    mask := $4000;
    for j := 0 to 14 do
    begin
      if (group_val and mask) <> 0 then
        concat(binary_string, '1')
      else
        concat(binary_string, '0');
      mask := mask shr 1;
    end;
  end;

  if (encoding_method = 4) then
  begin
    SetLength(group, 4);
    SetLength(weight_str, 7);

    for i := 1 to 4 do
    begin
      group[0] := source[(i * 3)];
      group[1] := source[(i * 3) + 1];
      group[2] := source[(i * 3) + 2];
      group[3] := #0;
      group_val := StrToInt(ArrayOfCharToString(group));

      mask := $200;
      for j := 0 to 9 do
      begin
        if (group_val and mask) <> 0 then
          concat(binary_string, '1')
        else
          concat(binary_string, '0');
        mask := mask shr 1;
      end;
    end;

    for i := 0 to 5 do
      weight_str[i] := source[20 + i];
    weight_str[6] := #0;
    group_val := StrToInt(ArrayOfCharToString(weight_str));

    if (source[19] = '3') then
      group_val := group_val + 10000;

    mask := $4000;
    for j := 0 to 14 do
    begin
      if (group_val and mask) <> 0 then
        concat(binary_string, '1')
      else
        concat(binary_string, '0');
      mask := mask shr 1;
    end;
  end;


  if ((encoding_method >= 7) and (encoding_method <= 14)) then
  begin
    SetLength(group, 4);
    SetLength(weight_str, 8);
    SetLength(date_str, 4);

    for i := 1 to 4 do
    begin
      group[0] := source[(i * 3)];
      group[1] := source[(i * 3) + 1];
      group[2] := source[(i * 3) + 2];
      group[3] := #0;
      group_val := StrToInt(ArrayOfCharToString(group));

      mask := $200;
      for j := 0 to 9 do
      begin
        if (group_val and mask) <> 0 then
          concat(binary_string, '1')
        else
          concat(binary_string, '0');
        mask := mask shr 1;
      end;
    end;

    weight_str[0] := source[19];

    for i := 0 to 4 do
      weight_str[i + 1] := source[21 + i];
    weight_str[6] := #0;
    group_val := StrToInt(ArrayOfCharToString(weight_str));

    mask := $80000;
    for j := 0 to 19 do
    begin
      if (group_val and mask) <> 0 then
        concat(binary_string, '1')
      else
        concat(binary_string, '0');
      mask := mask shr 1;
    end;

    if (strlen(source) = 34) then
    begin
      date_str[0] := source[28];
      date_str[1] := source[29];
      date_str[2] := #0;
      group_val := StrToInt(ArrayOfCharToString(date_str)) * 384;

      date_str[0] := source[30];
      date_str[1] := source[31];
      Inc(group_val, (StrToInt(ArrayOfCharToString(date_str)) - 1) * 32);

      date_str[0] := source[32];
      date_str[1] := source[33];
      Inc(group_val, StrToInt(ArrayOfCharToString(date_str)));
    end
    else
      group_val := 38400;

    mask := $8000;
    for j := 0 to 15 do
    begin
      if (group_val and mask) <> 0 then
        concat(binary_string, '1')
      else
        concat(binary_string, '0');
      mask := mask shr 1;
    end;

  end;

  if (encoding_method = 5) then
  begin
    SetLength(group, 4);

    for i := 1 to 4 do
    begin
      group[0] := source[(i * 3)];
      group[1] := source[(i * 3) + 1];
      group[2] := source[(i * 3) + 2];
      group[3] := #0;
      group_val := StrToInt(ArrayOfCharToString(group));

      mask := $200;
      for j := 0 to 9 do
      begin
        if (group_val and mask) <> 0 then
          concat(binary_string, '1')
        else
          concat(binary_string, '0');
        mask := mask shr 1;
      end;
    end;

    case source[19] of
      '0': concat(binary_string, '00');
      '1': concat(binary_string, '01');
      '2': concat(binary_string, '10');
      '3': concat(binary_string, '11');
    end;
  end;

  if (encoding_method = 6) then
  begin
    SetLength(group, 4);
    SetLength(currency_str, 5);

    for i := 1 to 4 do
    begin
      group[0] := source[(i * 3)];
      group[1] := source[(i * 3) + 1];
      group[2] := source[(i * 3) + 2];
      group[3] := #0;
      group_val := StrToInt(ArrayOfCharToString(group));

      mask := $200;
      for j := 0 to 9 do
      begin
        if (group_val and mask) <> 0 then
          concat(binary_string, '1')
        else
          concat(binary_string, '0');
        mask := mask shr 1;
      end;
    end;

    case source[19] of
      '0': concat(binary_string, '00');
      '1': concat(binary_string, '01');
      '2': concat(binary_string, '10');
      '3': concat(binary_string, '11');
    end;

    for i := 0 to 2 do
      currency_str[i] := source[20 + i];
    currency_str[3] := #0;
    group_val := StrToInt(ArrayOfCharToString(currency_str));

    mask := $200;
    for j := 0 to 9 do
    begin
      if (group_val and mask) <> 0 then
        concat(binary_string, '1')
      else
        concat(binary_string, '0');
      mask := mask shr 1;
    end;
  end;

  j := 0;
  for i := read_posn to strlen(source) - 1 do
  begin
    general_field[j] := source[i];
    Inc(j);
  end;
  general_field[j] := #0;

  latch := 0;
  for i := 0 to strlen(general_field) - 1 do
  begin
    if ((general_field[i] < ' ') or (general_field[i] > 'z')) then
    begin
      general_field_type[i] := Chr(INVALID_CHAR); latch := 1;
    end
    else
      general_field_type[i] := Chr(ISOIEC);

    if (general_field[i] = '#') then
    begin
      general_field_type[i] := Chr(INVALID_CHAR); latch := 1;
    end;
    if (general_field[i] = '$') then
    begin
      general_field_type[i] := Chr(INVALID_CHAR); latch := 1;
    end;
    if (general_field[i] = '@') then
    begin
      general_field_type[i] := Chr(INVALID_CHAR); latch := 1;
    end;
    if (general_field[i] = Chr(92)) then
    begin
      general_field_type[i] := Chr(INVALID_CHAR); latch := 1;
    end;
    if (general_field[i] = '^') then
    begin
      general_field_type[i] := Chr(INVALID_CHAR); latch := 1;
    end;
    if (general_field[i] = Chr(96)) then
    begin
      general_field_type[i] := Chr(INVALID_CHAR); latch := 1;
    end;

    if ((general_field[i] >= 'A') and (general_field[i] <= 'Z')) then
      general_field_type[i] := Chr(ALPHA_OR_ISO);

    if (general_field[i] = '*') then
      general_field_type[i] := Chr(ALPHA_OR_ISO);

    if (general_field[i] = ',') then
      general_field_type[i] := Chr(ALPHA_OR_ISO);

    if (general_field[i] = '-') then
      general_field_type[i] := Chr(ALPHA_OR_ISO);

    if (general_field[i] = '.') then
      general_field_type[i] := Chr(ALPHA_OR_ISO);

    if (general_field[i] = '/') then
      general_field_type[i] := Chr(ALPHA_OR_ISO);

    if ((general_field[i] >= '0') and (general_field[i] <= '9')) then
      general_field_type[i] := Chr(ANY_ENC);

    if (general_field[i] = '(') then
      general_field_type[i] := Chr(ANY_ENC);

  end;

  general_field_type[strlen(general_field)] := #0;

  if (latch = 1) then
    raise Exception.Create('Error in ParseGS1 02');

  for i := 0 to strlen(general_field) - 1 do
  begin
    if ((general_field_type[i] = Chr(ISOIEC)) and (general_field[i + 1] = '(')) then
      general_field_type[i + 1] := Chr(ISOIEC);
  end;

  for i := 0 to strlen(general_field) - 1 do
  begin
    if ((general_field_type[i] = Chr(ALPHA_OR_ISO)) and (general_field[i + 1] = '(')) then
      general_field_type[i + 1] := Chr(ALPHA_OR_ISO);
  end;

  latch := general_rules(general_field, general_field_type);

  last_mode := NUMERIC;

  if (general_field_type[0] = Chr(ALPHA)) then
  begin
    concat(binary_string, '0000');
    last_mode := ALPHA;
  end;
  if (general_field_type[0] = Chr(ISOIEC)) then
  begin
    concat(binary_string, '0000');
    concat(binary_string, '00100');
    last_mode := ISOIEC;
  end;

  i := 0;
  repeat
    case Ord(general_field_type[i]) of
      NUMERIC:
      begin
        if (last_mode <> NUMERIC) then
          concat(binary_string, '000');

        if (general_field[i] <> '(') then
          d1 := ctoi(general_field[i])
        else
          d1 := 10;

        if (general_field[i + 1] <> '(') then
          d2 := ctoi(general_field[i + 1])
        else
          d2 := 10;

        value := (11 * d1) + d2 + 8;

        mask := $40;
        for j := 0 to 6 do
        begin
          if (value and mask) <> 0 then
            concat(binary_string, '1')
          else
            concat(binary_string, '0');
          mask := mask shr 1;
        end;

        Inc(i, 2);
        last_mode := NUMERIC;
      end;

      ALPHA:
      begin
        if (i <> 0) then
        begin
          if (last_mode = NUMERIC) then
            concat(binary_string, '0000');

          if (last_mode = ISOIEC) then
            concat(binary_string, '00100');
        end;

        if ((general_field[i] >= '0') and (general_field[i] <= '9')) then
        begin
          value := Ord(general_field[i]) - 43;

          mask := $10;
          for j := 0 to 4 do
          begin
            if (value and mask) <> 0 then
              concat(binary_string, '1')
            else
             concat(binary_string, '0');
            mask := mask shr 1;
          end;
        end;

        if ((general_field[i] >= 'A') and (general_field[i] <= 'Z')) then
        begin
          value := Ord(general_field[i]) - 33;

          mask := $20;
          for j := 0 to 5 do
          begin
            if (value and mask) <> 0 then
              concat(binary_string, '1')
            else
              concat(binary_string, '0');
            mask := mask shr 1;
          end;
        end;

        last_mode := ALPHA;
        if (general_field[i] = '(') then begin concat(binary_string, '01111'); last_mode := NUMERIC; end;
        if (general_field[i] = '*') then concat(binary_string, '111010');
        if (general_field[i] = ',') then concat(binary_string, '111011');
        if (general_field[i] = '-') then concat(binary_string, '111100');
        if (general_field[i] = '.') then concat(binary_string, '111101');
        if (general_field[i] = '/') then concat(binary_string, '111110');

        Inc(i);
      end;

      ISOIEC:
      begin
        if (i <> 0) then
        begin
          if (last_mode = NUMERIC) then
          begin
            concat(binary_string, '0000');
            concat(binary_string, '00100');
          end;
          if (last_mode = ALPHA) then
            concat(binary_string, '00100');
        end;

        if ((general_field[i] >= '0') and (general_field[i] <= '9')) then
        begin
          value := Ord(general_field[i]) - 43;

          mask := $10;
          for j := 0 to 4 do
          begin
            if (value and mask) <> 0 then
              concat(binary_string, '1')
            else
              concat(binary_string, '0');
            mask := mask shr 1;
          end;
        end;

        if ((general_field[i] >= 'A') and (general_field[i] <= 'Z')) then
        begin
          value := Ord(general_field[i]) - 1;

          mask := $40;
          for j := 0 to 6 do
          begin
            if (value and mask) <> 0 then
              concat(binary_string, '1')
            else
              concat(binary_string, '0');
            mask := mask shr 1;
          end;
        end;

        if ((general_field[i] >= 'a') and (general_field[i] <= 'z')) then
        begin
          value := Ord(general_field[i]) - 7;

          mask := $40;
          for j := 0 to 6 do
          begin
            if (value and mask) <> 0 then
              concat(binary_string, '1')
            else
              concat(binary_string, '0');
            mask := mask shr 1;
          end;
        end;

        last_mode := ISOIEC;
        if (general_field[i] = '(') then begin concat(binary_string, '01111'); last_mode := NUMERIC; end;
        if (general_field[i] = '!') then concat(binary_string, '11101000');
        if (general_field[i] = Chr(34)) then concat(binary_string, '11101001');
        if (general_field[i] = Chr(37)) then concat(binary_string, '11101010');
        if (general_field[i] = '&') then concat(binary_string, '11101011');
        if (general_field[i] = Chr(39)) then concat(binary_string, '11101100');
        if (general_field[i] = '(') then concat(binary_string, '11101101');
        if (general_field[i] = ')') then concat(binary_string, '11101110');
        if (general_field[i] = '*') then concat(binary_string, '11101111');
        if (general_field[i] = '+') then concat(binary_string, '11110000');
        if (general_field[i] = ',') then concat(binary_string, '11110001');
        if (general_field[i] = '-') then concat(binary_string, '11110010');
        if (general_field[i] = '.') then concat(binary_string, '11110011');
        if (general_field[i] = '/') then concat(binary_string, '11110100');
        if (general_field[i] = ':') then concat(binary_string, '11110101');
        if (general_field[i] = ';') then concat(binary_string, '11110110');
        if (general_field[i] = '<') then concat(binary_string, '11110111');
        if (general_field[i] = '=') then concat(binary_string, '11111000');
        if (general_field[i] = '>') then concat(binary_string, '11111001');
        if (general_field[i] = '?') then concat(binary_string, '11111010');
        if (general_field[i] = '_') then concat(binary_string, '11111011');
        if (general_field[i] = ' ') then concat(binary_string, '11111100');

        Inc(i);
      end;
    end;
  until not (i + latch < strlen(general_field));

  remainder := 12 - (strlen(binary_string) mod 12);
  if (remainder = 12) then remainder := 0;
  if (strlen(binary_string) < 36) then remainder := 36 - strlen(binary_string);

  if (latch = 1) then
  begin
    if (last_mode = NUMERIC) then
    begin
      if ((remainder >= 4) and (remainder <= 6)) then
      begin
        value := ctoi(general_field[i]);
        Inc(value);

        mask := $08;
        for j := 0 to 3 do
        begin
          if (value and mask) <> 0 then
            concat(binary_string, '1')
          else
            concat(binary_string, '0');
          mask := mask shr 1;
        end;
      end
      else
      begin
        d1 := ctoi(general_field[i]);
        d2 := 10;

        value := (11 * d1) + d2 + 8;

        mask := $40;
        for j := 0 to 6 do
        begin
          if (value and mask) <> 0 then
            concat(binary_string, '1')
          else
            concat(binary_string, '0');
          mask := mask shr 1;
        end;
      end;
    end
    else
    begin
      value := Ord(general_field[i]) - 43;

      mask := $10;
      for j := 0 to 4 do
      begin
        if (value and mask) <> 0 then
            concat(binary_string, '1')
          else
            concat(binary_string, '0');
        mask := mask shr 1;
      end;
    end;

    remainder := 12 - (strlen(binary_string) mod 12);
    if (remainder = 12) then remainder := 0;
    if (strlen(binary_string) < 36) then remainder := 36 - strlen(binary_string);
  end;

  if (strlen(binary_string) > 252) then
    raise Exception.Create('Error in ParseGS1 03');

  i := remainder;
  if ((strlen(general_field) <> 0) and (last_mode = NUMERIC)) then
  begin
    strcpy(padstring, '0000');
    Dec(i, 4);
  end
  else
    strcpy(padstring, '');
  while i > 0 do
  begin
    concat(padstring, '00100');
    Dec(i, 5);
  end;

  padstring[remainder] := #0;
  concat(binary_string, padstring);

  d1 := ((strlen(binary_string) div 12) + 1) and 1;
  if (strlen(binary_string) <= 156) then d2 := 0 else d2 := 1;

  if (encoding_method = 1) then
  begin
    if d1 <> 0 then binary_string[2] := '1' else binary_string[2] := '0';
    if d2 <> 0 then binary_string[3] := '1' else binary_string[3] := '0';
  end;
  if (encoding_method = 2) then
  begin
    if d1 <> 0 then binary_string[3] := '1' else binary_string[3] := '0';
    if d2 <> 0 then binary_string[4] := '1' else binary_string[4] := '0';
  end;
  if ((encoding_method = 5) or (encoding_method = 6)) then
  begin
    if d1 <> 0 then binary_string[6] := '1' else binary_string[6] := '0';
    if d2 <> 0 then binary_string[7] := '1' else binary_string[7] := '0';
  end;
  result := 0;
end;

function gs1_verify(source : TArrayOfByte; const src_len : Integer; var reduced : TArrayOfChar) : Integer;
var
  i, j, last_ai, ai_latch : Integer;
  ai_string : TArrayOfChar;
  bracket_level, max_bracket_level, ai_length, max_ai_length, min_ai_length : Integer;
  ai_value, ai_location, data_location, data_length : array[0..99] of Integer;
  ai_count : Integer;
  error_latch : Integer;
begin
  SetLength(ai_string, 6);
	for i := 0 to src_len - 1 do
  begin
		if Ord(source[i]) >= 128 then
      raise Exception.Create('Extended ASCII characters are not supported by GS1');
		if Ord(source[i]) < 32 then
      raise Exception.Create('Control characters are not supported by GS1');
	end;

	if source[0] <> Ord('(') then
    raise Exception.Create('Data does not start with an AI');

	bracket_level := 0;
	max_bracket_level := 0;
	ai_length := 0;
	max_ai_length := 0;
	min_ai_length := 5;
	j := 0;
	ai_latch := 0;
	for i := 0 to src_len - 1 do
  begin
		Inc(ai_length, j);
		if (((j = 1) and (source[i] <> Ord(')'))) and ((source[i] < Ord('0')) or (source[i] > Ord('9')))) then ai_latch := 1;
		if (source[i] = Ord('(')) then begin Inc(bracket_level); j := 1; end;
		if (source[i] = Ord(')')) then
    begin
			Dec(bracket_level);
			if (ai_length < min_ai_length) then min_ai_length := ai_length;
			j := 0;
			ai_length := 0;
		end;
		if (bracket_level > max_bracket_level) then max_bracket_level := bracket_level;
		if (ai_length > max_ai_length) then max_ai_length := ai_length;
	end;
	Dec(min_ai_length);

	if (bracket_level <> 0) then
    raise Exception.Create('Malformed AI in input data (brackets don\''t match)');
	if (max_bracket_level > 1) then
    raise Exception.Create('Found nested brackets in input data');
	if(max_ai_length > 4) then
    raise Exception.Create('Invalid AI in input data (AI too long)');
	if(min_ai_length <= 1) then
    raise Exception.Create('Invalid AI in input data (AI too short)');
	if(ai_latch = 1) then
    raise Exception.Create('Invalid AI in input data (non-numeric characters in AI)');

	ai_count := 0;
	for i := 1 to src_len - 1 do
  begin
		if (source[i - 1] = Ord('(')) then
    begin
			ai_location[ai_count] := i;
			j := 0;
			repeat
				ai_string[j] := Chr(source[i + j]);
        Inc(j)
			until not (ai_string[j - 1] <> ')');
      ai_string[j - 1] := #0;
			ai_value[ai_count] := StrToInt(ArrayOfCharToString(ai_string));
			Inc(ai_count);
		end;
	end;

	for i := 0 to ai_count - 1 do
  begin
		data_location[i] := ai_location[i] + 3;
		if (ai_value[i] >= 100) then Inc(data_location[i]);
		if (ai_value[i] >= 1000) then Inc(data_location[i]);
		data_length[i] := 0;
		repeat
			Inc(data_length[i]);
		until not ((source[data_location[i] + data_length[i] - 1] <> Ord('(')) and (source[data_location[i] + data_length[i] - 1] <> 0));
		Dec(data_length[i]);
	end;

	for i := 0 to ai_count - 1 do
		if(data_length[i] = 0) then
      raise Exception.Create('Empty data field in input data');

	error_latch := 0;
  strcpy(ai_string, '');
	for i := 0 to ai_count - 1 do
  begin
		case ai_value[i] of
			0: if(data_length[i] <> 18) then error_latch := 1;
			1,
			2,
			3: if(data_length[i] <> 14) then error_latch := 1;
			4: if(data_length[i] <> 16) then error_latch := 1;
			11,
			12,
			13,
			14,
			15,
			16,
			17,
			18,
			19: if(data_length[i] <> 6) then error_latch := 1;
			20: if(data_length[i] <> 2) then error_latch := 1;
			23,
			24,
			25,
			39,
			40,
			41,
			42,
			70,
			80,
			81: error_latch := 2;
		end;
		if (
			 ((ai_value[i] >= 100) and (ai_value[i] <= 179))
			 or ((ai_value[i] >= 1000) and (ai_value[i] <= 1799))
			 or ((ai_value[i] >= 200) and (ai_value[i] <= 229))
			 or ((ai_value[i] >= 2000) and (ai_value[i] <= 2299))
			 or ((ai_value[i] >= 300) and (ai_value[i] <= 309))
			 or ((ai_value[i] >= 3000) and (ai_value[i] <= 3099))
			 or ((ai_value[i] >= 31) and (ai_value[i] <= 36))
			 or ((ai_value[i] >= 310) and (ai_value[i] <= 369))
		) then
			error_latch := 2;
		if((ai_value[i] >= 3100) and (ai_value[i] <= 3699)) then
    begin
			if (data_length[i] <> 6) then
				error_latch := 1;
		end;
		if (
			 ((ai_value[i] >= 370) and (ai_value[i] <= 379))
			 or ((ai_value[i] >= 3700) and (ai_value[i] <= 3799))
		) then
			error_latch := 2;
		if ((ai_value[i] >= 410) and (ai_value[i] <= 415)) then
    begin
			if(data_length[i] <> 13) then
				error_latch := 1;
		end;
		if (
			 ((ai_value[i] >= 4100) and (ai_value[i] <= 4199))
			 or ((ai_value[i] >= 700) and (ai_value[i] <= 703))
			 or ((ai_value[i] >= 800) and (ai_value[i] <= 810))
			 or ((ai_value[i] >= 900) and (ai_value[i] <= 999))
			 or ((ai_value[i] >= 9000) and (ai_value[i] <= 9999))
		) then
			error_latch := 2;
		if((error_latch < 4) and (error_latch > 0)) then
    begin
			itostr(ai_string, ai_value[i]);
			Inc(error_latch, 4);
		end;
	end;

	if(error_latch = 5) then
    raise Exception.Create('Invalid data _length for AI');
	if(error_latch = 6) then
    raise Exception.Create('Invalid AI value');

  j := 0;
	ai_latch := 1;
	for i := 0 to src_len - 1 do
  begin
		if ((source[i] <> Ord('(')) and (source[i] <> Ord(')'))) then
    begin
			reduced[j] := Chr(source[i]);
      Inc(j);
    end;
    if (source[i] = Ord('(')) then
    begin
			if(ai_latch = 0) then
      begin
				reduced[j] := '(';
        Inc(j);
      end;
			ai_string[0] := Chr(source[i + 1]);
			ai_string[1] := Chr(source[i + 2]);
      ai_string[2] := #0;
			last_ai := StrToInt(ArrayOfCharToString(ai_string));
			ai_latch := 0;
			if(
				((last_ai >= 0) and (last_ai <= 4))
				or ((last_ai >= 11) and (last_ai <= 20))
				or (last_ai = 23)
				or ((last_ai >= 31) and (last_ai <= 36))
				or (last_ai = 41)
			) then
				ai_latch := 1;
		end;
	end;
    reduced[j] := #0;
	result := 0;
end;

function Code_DBE_Encode(const source : TArrayOfByte; src_len : Integer) : TBaseDatabar;
var
  i, j, k, checksum, row, check_char, c_group, c_odd, c_even, pattern_width : Integer;
  vs, group, v_odd, v_even, check_widths : TArrayOfInteger;
  reduced, binary_string : TArrayOfChar;
  substring : array[0..20] of array[0..13] of Char;
  widths : TArrayOfInteger;
  char_widths : array[0..20] of array[0..7] of Integer;
begin
  result := TBaseDatabar.Create();
  try
    with (result) do
    begin
      SetLength(vs, 21);
      SetLength(group, 21);
      SetLength(v_odd, 21);
      SetLength(v_even, 21);
      SetLength(check_widths, 8);
      SetLength(elements, 235);
      SetLength(sub_elements, 235);
      SetLength(reduced, src_len + 1);
      SetLength(binary_string, 7 * (src_len + 1));

      i := gs1_verify(source, src_len, reduced);
      if (i <> 0) then
        raise Exception.Create('Error in ParseGS1 04');

      strcpy(binary_string, '');

        concat(binary_string, '0');

      i := rss_binary_string(reduced, binary_string);
      if (i <> 0) then
        raise Exception.Create('Error in ParseGS1 09');

      data_chars := strlen(binary_string) div 12;

      for i := 0 to data_chars - 1 do
      begin
        for j := 0 to 11 do
          substring[i][j] := binary_string[(i * 12) + j];
        substring[i][12] := #0;
      end;

      for i := 0 to data_chars - 1 do
      begin
        vs[i] := 0;
        if (substring[i][0] = '1') then Inc(vs[i], 2048);
        if (substring[i][1] = '1') then Inc(vs[i], 1024);
        if (substring[i][2] = '1') then Inc(vs[i], 512);
        if (substring[i][3] = '1') then Inc(vs[i], 256);
        if (substring[i][4] = '1') then Inc(vs[i], 128);
        if (substring[i][5] = '1') then Inc(vs[i], 64);
        if (substring[i][6] = '1') then Inc(vs[i], 32);
        if (substring[i][7] = '1') then Inc(vs[i], 16);
        if (substring[i][8] = '1') then Inc(vs[i], 8);
        if (substring[i][9] = '1') then Inc(vs[i], 4);
        if (substring[i][10] = '1') then Inc(vs[i], 2);
        if (substring[i][11] = '1') then Inc(vs[i], 1);
      end;

      for i := 0 to data_chars - 1 do
      begin
        if (vs[i] <= 347) then group[i] := 1;
        if ((vs[i] >= 348) and (vs[i] <= 1387)) then group[i] := 2;
        if ((vs[i] >= 1388) and (vs[i] <= 2947)) then group[i] := 3;
        if ((vs[i] >= 2948) and (vs[i] <= 3987)) then group[i] := 4;
        if (vs[i] >= 3988) then group[i] := 5;
        v_odd[i] := (vs[i] - g_sum_exp[group[i] - 1]) div t_even_exp[group[i] - 1];
        v_even[i] := (vs[i] - g_sum_exp[group[i] - 1]) mod t_even_exp[group[i] - 1];

        getRSSwidths(v_odd[i], modules_odd_exp[group[i] - 1], 4, widest_odd_exp[group[i] - 1], 0, widths);
        char_widths[i][0] := widths[0];
        char_widths[i][2] := widths[1];
        char_widths[i][4] := widths[2];
        char_widths[i][6] := widths[3];
        getRSSwidths(v_even[i], modules_even_exp[group[i] - 1], 4, widest_even_exp[group[i] - 1], 1, widths);
        char_widths[i][1] := widths[0];
        char_widths[i][3] := widths[1];
        char_widths[i][5] := widths[2];
        char_widths[i][7] := widths[3];
      end;

      checksum := 0;
      for i := 0 to data_chars - 1 do
      begin
        row := weight_rows[(((data_chars - 2) div 2) * 21) + i];
        for j := 0 to 7 do
          Inc(checksum, (char_widths[i][j] * checksum_weight_exp[(row * 8) + j]));
      end;

      check_char := (211 * ((data_chars + 1) - 4)) + (checksum mod 211);

      case check_char of
        0..347     : c_group := 1;
        348..1387  : c_group := 2;
        1388..2947 : c_group := 3;
        2948..3987 : c_group := 4;
        3988..4191 : c_group := 5;
        else raise Exception.Create('Error in ParseGS1 505');
      end;

      c_odd := (check_char - g_sum_exp[c_group - 1]) div t_even_exp[c_group - 1];
      c_even := (check_char - g_sum_exp[c_group - 1]) mod t_even_exp[c_group - 1];

      getRSSwidths(c_odd, modules_odd_exp[c_group - 1], 4, widest_odd_exp[c_group - 1], 0, widths);
      check_widths[0] := widths[0];
      check_widths[2] := widths[1];
      check_widths[4] := widths[2];
      check_widths[6] := widths[3];
      getRSSwidths(c_even, modules_even_exp[c_group - 1], 4, widest_even_exp[c_group - 1], 1, widths);
      check_widths[1] := widths[0];
      check_widths[3] := widths[1];
      check_widths[5] := widths[2];
      check_widths[7] := widths[3];

      pattern_width := ((((data_chars + 1) div 2) + ((data_chars + 1) and 1)) * 5) + ((data_chars + 1) * 8) + 4;
      for i := 0 to pattern_width - 1 do
        elements[i] := 0;

      elements[0] := 1;
      elements[1] := 1;
      elements[pattern_width - 2] := 1;
      elements[pattern_width - 1] := 1;

      for i := 0 to (((data_chars + 1) div 2) + ((data_chars + 1) and 1)) - 1 do
      begin
        k := ((((((data_chars + 1) - 2) div 2) + ((data_chars + 1) and 1)) - 1) * 11) + i;
        for j := 0 to 4  do
          elements[(21 * i) + j + 10] := finder_pattern_exp[((finder_sequence[k] - 1) * 5) + j];
      end;

      for i := 0 to 7 do
        elements[i + 2] := check_widths[i];

      i := 1;
      while i < data_chars do
      begin
        for j := 0 to 7 do
          elements[(((i - 1) div 2) * 21) + 23 + j] := char_widths[i][j];
        Inc(i, 2);
      end;

      i := 0;
      while i < data_chars do
      begin
        for j := 0 to 7 do
          elements[((i div 2) * 21) + 15 + j] := char_widths[i][7 - j];
        Inc(i, 2);
      end;
    end;
  except
    on e : Exception do
    begin
      FreeAndNil(result);
      Raise Exception.Create(e.Message);
    end;
  end;
end;

function Code_DBES_Encode(const source: TArrayOfByte; src_len: Integer; option_1: Integer = -1; option_2: Integer = 2) : TBaseDatabar;
var
  i, j, k, l, elements_in_sub, special_case_row, codeblocks, reader,
  stack_rows, current_row, current_block, writer, left_to_right : Integer;
  latch : Char;
begin
  result := Code_DBE_Encode(source, src_len);

  with (result) do
  begin
    codeblocks := (data_chars + 1) div 2;
    if (data_chars +1) mod 2 <> 0 then
      Inc(codeblocks);

    rows := 0;
    width:= 0;

    stack_rows := codeblocks div option_2;
    if (codeblocks mod option_2 <> 0) then
      Inc(stack_rows);

    if (option_2 mod 2) <> 0 then
     Inc(codeblocks);

    SetLength(symbol, stack_rows + (stack_rows - 1) * 3, COLS_MAX * option_2);
    SetLength(row_height, stack_rows + (stack_rows - 1) * 3);

    current_block := 0;
    for current_row := 1 to stack_rows do
    begin
      for i := 0 to 234 do
        sub_elements[i] := 0;
      special_case_row := 0;

      sub_elements[0] := 1;
      sub_elements[1] := 1;
      elements_in_sub := 2;

      reader := 0;
      repeat
        if ((((option_2 and 1) <> 0) or ((current_row and 1) <> 0)) or
          ((current_row = stack_rows) and (codeblocks <> (current_row * option_2)) and
          ((((current_row * option_2) - codeblocks) and 1) <> 0))) then
        begin
          left_to_right := 1;
          i := 2 + (current_block * 21);
          for j := 0 to 20 do
          begin
            sub_elements[j + (reader * 21) + 2] := elements[i + j];
            Inc(elements_in_sub);
          end;
        end
        else
        begin
          left_to_right := 0;
          if ((current_row * option_2) < codeblocks) then
          begin
            i := 2 + (((current_row * option_2) - reader - 1) * 21);
            for j := 0 to 20 do
            begin
              sub_elements[(20 - j) + (reader * 21) + 2] := elements[i + j];
              Inc(elements_in_sub);
            end;
          end
          else
          begin
            k := ((current_row * option_2) - codeblocks);
            l := (current_row * option_2) - reader - 1;
            i := 2 + ((l - k) * 21);
            for j := 0 to 20 do
            begin
              sub_elements[(20 - j) + (reader * 21) + 2] := elements[i + j];
              Inc(elements_in_sub);
            end;
          end;
        end;
        Inc(reader);
        Inc(current_block);
      until not ((reader < option_2) and (current_block < codeblocks));

      sub_elements[elements_in_sub] := 1;
      sub_elements[elements_in_sub + 1] := 1;
      Inc(elements_in_sub, 2);

      if (current_row and 1) <> 0 then
        latch := '0'
      else
        latch := '1';
      // redmine #3306
      if ((current_row = stack_rows) and (codeblocks <> (current_row * option_2)) and
        ((Abs(((current_row - 1) * option_2) - codeblocks) and 1) <> 0) ) then
      begin
        special_case_row := 1;
        sub_elements[0] := 2;
        latch := '0';
      end;

      writer := 0;
      for i := 0 to elements_in_sub - 1 do
      begin
        for j := 0 to sub_elements[i] - 1 do
        begin
          if (latch = '1') then set_module(symbol, rows, writer) else unset_module(symbol, rows, writer);
          Inc(writer);
        end;
        if (latch = '1') then
          latch := '0'
        else
          latch := '1';
      end;
      if (width < writer) then width := writer;

      if (current_row <> 1) then
      begin
        j := 5;
        while j < (49 * option_2) do
        begin
          set_module(symbol, rows - 2, j);
          Inc(j, 2);
        end;
        row_height[rows - 2] := 1;
        for j := 4 to (writer - 4) - 1 do
        begin
          if module_is_set(symbol, rows, j) then
            unset_module(symbol, rows - 1, j)
          else
            set_module(symbol, rows - 1, j);
        end;
        row_height[rows - 1] := 1;
        for j := 0 to reader - 1 do
        begin
          if (special_case_row <> 0) then
            k := (49 * j) + 19
          else
            k := (49 * j) + 18;
          if (left_to_right <> 0) then
          begin
            for i := 0 to 14 do
            begin
              if ((not module_is_set(symbol, rows, i + k - 1)) and (not module_is_set(symbol, rows, i + k)) and
              module_is_set(symbol, rows - 1, i + k - 1)) then
                unset_module(symbol, rows - 1, i + k);
            end;
          end
          else
          begin
            for i := 14 downto 0 do
            begin
              if ((not module_is_set(symbol, rows, i + k + 1)) and (not module_is_set(symbol, rows, i + k)) and
              module_is_set(symbol, rows - 1, i + k + 1)) then
                unset_module(symbol, rows - 1, i + k);
            end;
          end;
        end;
      end;

      if (current_row <> stack_rows) then
      begin
        for j := 4 to (writer - 4) - 1 do
        begin
          if module_is_set(symbol, rows, j) then
            unset_module(symbol, rows + 1, j)
          else
            set_module(symbol, rows + 1, j);
        end;
        row_height[rows + 1] := 1;
        for j := 0 to reader - 1 do
        begin
          k := (49 * j) + 18;
          if (left_to_right <> 0) then
          begin
            for i := 0 to 14 do
            begin
              if (not (module_is_set(symbol, rows, i + k - 1)) and (not module_is_set(symbol, rows, i + k)) and
              module_is_set(symbol, rows + 1, i + k - 1)) then
                unset_module(symbol, rows + 1, i + k);
            end;
          end
          else
          begin
            for i := 14 downto 0 do
            begin
              if ((not module_is_set(symbol, rows, i + k + 1)) and
              (not module_is_set(symbol, rows, i + k)) and
              module_is_set(symbol, rows + 1, i + k + 1)) then
                unset_module(symbol, rows + 1, i + k);
            end;
          end;
        end;
      end;

      rows := rows + 4;
    end;
    rows := rows - 3;
  end;
end;

function CalcSumArrayOfInteger(arr: TArrayOfInteger): Integer;
var
  i: Integer;
begin
  result := 0;
  i := 0;
  while(arr[i] > 0) do
  begin
    inc(result, arr[i]);
    inc(i);
  end;
end;

function Code_DBEorES(const FText: String; Stacked: Boolean; option_2: Integer = 2): TBaseDatabar;
var
  b : TArrayOfByte;
begin
  b := StrToArrayOfByte(string(UTF8Encode(FText)));
  if Stacked then
    result := Code_DBES_Encode(b, ustrlen(b), -1, option_2)
  else
    result := Code_DBE_Encode(b, ustrlen(b));
end;

end.

