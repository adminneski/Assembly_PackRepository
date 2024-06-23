unit Core.Register;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Generics.Collections;
type
  TCoreRegisterClass = class
  public
    class var EntityList: TDictionary<String, TClass>;
    class constructor Create;
    class destructor Destroy;
    class procedure RegisterEntity(AClass :TClass);
    class procedure UnRegisterEntity(AClass: TClass);
  end;

implementation

{ TCoreRegister }

class constructor TCoreRegisterClass.Create;
begin
  EntityList  := TDictionary<String, TClass>.Create;
end;

class destructor TCoreRegisterClass.Destroy;
begin
   FreeAndNil(EntityList);
end;

class procedure TCoreRegisterClass.RegisterEntity(AClass: TClass);
begin
  if not EntityList.ContainsKey(AClass.ClassName) then
    EntityList.Add(AClass.ClassName,AClass);
end;

class procedure TCoreRegisterClass.UnRegisterEntity(AClass: TClass);
begin
  if EntityList.ContainsKey(AClass.ClassName) then
    EntityList.Remove(AClass.ClassName);
end;

end.
