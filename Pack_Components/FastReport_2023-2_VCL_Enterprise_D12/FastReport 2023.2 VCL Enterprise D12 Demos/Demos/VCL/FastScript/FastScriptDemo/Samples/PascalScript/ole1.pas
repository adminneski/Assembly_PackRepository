var
  MSWord: Variant;
begin
  MsWord := CreateOleObject('Word.Basic');
  MsWord.AppShow;
  MSWord.FileNew;
  MSWord.Insert('Test!');
  MSWord.LineUp(1, 1);
end.
