unit frxLinuxFonts;

interface

{$I frx.inc}

{$IFNDEF Windows}

{$DEFINE UseExtraLists}//use always

uses Graphics, Classes, SysUtils;

type
  TLFonts = class
  private
   {$IFDEF UseExtraLists}
    UsedFonts: TStringList;
   {$ENDIF}
  public
    constructor Create();
    destructor Destroy;
    function GetFontName(Font: TFont): String;
    function GetFontPath(Font: TFont; FontName: String): String;
  end;

function LFonts(): TLFonts;

implementation

uses EasyLazFreeType, LazFreeTypeFontCollection, FileUtil;

var
  FLFonts: TLFonts = nil;

const
  SwapFontName = 'FreeSans';

{TLFonts}

constructor TLFonts.Create();
var
  FontPathes: TStringList;

  procedure FillFontPathes(var AList: TStringList);  //TODO: Rewrite to parse  '/etc/fonts/fonts.conf'
  begin
   {$IFDEF linux}
    AList.Add('/usr/share/cups/fonts/');
    AList.Add('/usr/share/fonts/truetype/');
    AList.Add('/usr/share/fonts/msttcore/');
    AList.Add('/usr/share/fonts/ttf/ms/');
    AList.Add('/usr/local/lib/X11/fonts/');
    AList.Add(GetUserDir + '.fonts/');
   {$ENDIF}
   {$IFDEF LCLCarbon}
    AList.Add('/Library/Fonts/');
    AList.Add('/System/Library/Fonts/');
    AList.Add('/Network/Library/Fonts/');
    AList.Add('~/Library/Fonts/');
   {$ENDIF}
   {$IFDEF LCLCocoa}
    AList.Add('/Library/Fonts/');
    AList.Add('/System/Library/Fonts/');
    AList.Add('/Network/Library/Fonts/');
    AList.Add('~/Library/Fonts/');
   {$ENDIF}
  end;

  procedure InstallFonts;
  var
    i: Integer;

    procedure AddFolder(AFolder: string);
    var
      files: TStringList;
      j: integer;
    begin
      AFolder := ExpandFileName(AFolder);
      if (length(AFolder) <> 0) and (AFolder[length(AFolder)] <> PathDelim) then
        AFolder += PathDelim;
      files := TStringList.Create;
      FontCollection.BeginUpdate;
      try
        FindAllFiles(files, AFolder, '*.ttf', true);
        files.Sort;
        for j := 0 to files.Count-1 do
          try
            FontCollection.AddFile(files[j]);
          except
            FontCollection.EndUpdate;
            FontCollection.BeginUpdate;
          end;
      finally
        FontCollection.EndUpdate;
        files.Free;
      end;
    end;

  begin
    for i:=0 to FontPathes.Count-1 do
      AddFolder(FontPathes[i]);
  end;

begin
 {$IFDEF UseExtraLists}
  UsedFonts := TStringList.Create();
  UsedFonts.Sorted := True;
 {$ENDIF}

  FontPathes := TStringList.Create();
  FillFontPathes(FontPathes);

  InstallFonts();

  FontPathes.Clear;
  FontPathes.Free;
end;

destructor TLFonts.Destroy;
begin
  {$IFDEF UseExtraLists}
  UsedFonts.Clear();
  UsedFonts.Free;
  {$ENDIF}
end;

function TLFonts.GetFontName(Font: TFont): String;
var
  familyItem: TCustomFamilyCollectionItem;
  i: Integer;
begin
  {$IFDEF UseExtraLists}
  if (UsedFonts.Find(Font.Name, i)) then
  begin
    Result := TCustomFamilyCollectionItem(UsedFonts.Objects[i]).FamilyName;
    Exit;
  end;
  {$ENDIF}
  familyItem := FontCollection.Family[Font.Name];
  if familyItem = nil then
  begin
    familyItem := FontCollection.Family[SwapFontName];
    if familyItem = nil then
      raise Exception.Create('Cant swap font');
  end;
  Result := familyItem.FamilyName;
  {$IFDEF UseExtraLists}
  UsedFonts.AddObject(Font.Name, familyItem);
  if (familyItem.FamilyName <> Font.Name) and not (UsedFonts.Find(familyItem.FamilyName, i)) then
    UsedFonts.AddObject(familyItem.FamilyName, familyItem);
  {$ENDIF}
end;

function TLFonts.GetFontPath(Font: TFont; FontName: String): String;
var
  familyItem: TCustomFamilyCollectionItem;
  i: Integer;
begin
  {$IFDEF UseExtraLists}
  if (UsedFonts.Find(FontName, i)) then
    familyItem := TCustomFamilyCollectionItem(UsedFonts.Objects[i])
  else
    raise Exception.Create('A paradox has occurred. The font found was not found.');
  {$ELSE}
  familyItem := FontCollection.Family[FontName];
  {$ENDIF}
  Result := '';
  for i := 0 to familyItem.FontCount - 1 do
    if (familyItem.Font[i].Bold = Font.Bold) and (familyItem.Font[i].Italic = Font.Italic) then
      Result := familyItem.Font[i].Filename;
  if Result <> '' then Exit;
  for i := 0 to familyItem.FontCount - 1 do
    if (familyItem.Font[i].Bold = false) and (familyItem.Font[i].Italic = false) then
      Result := familyItem.Font[i].Filename;
  if Result <> '' then Exit;
  Result := familyItem.Font[0].Filename;
end;

{frxPrinters}

function LFonts(): TLFonts;
begin
  if FLFonts = nil then
    FLFonts := TLFonts.Create;
  Result := FLFonts;
end;


initialization

finalization
  if FLFonts <> nil then
    FLFonts.Free;
  FLFonts := nil;

{$ENDIF}

end.
