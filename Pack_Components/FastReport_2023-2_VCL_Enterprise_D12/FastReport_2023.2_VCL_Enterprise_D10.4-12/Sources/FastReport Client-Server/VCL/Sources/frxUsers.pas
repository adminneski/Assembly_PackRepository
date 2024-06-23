
{******************************************}
{                                          }
{             FastReport VCL               }
{           Server users/groups            }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}
unit frxUsers;

{$I frx.inc}

interface

uses
  {$IFNDEF Linux}
  Windows,
  {$ENDIF}
  Messages, SysUtils, Classes, frXML, frxFileUtils,
  frxUtils,
{$IFDEF DELPHI6}
  Variants,
{$ENDIF}
  frHashUtils;

type
  TfrxUserGroupItem = class;

  TfrxUsers = class (TObject)
  private
    FXML: TfrXMLDocument;
    FUsersList: TStringList;
    FGroupsList: TStringList;
    procedure UnpackUsersTree;
    procedure PackUsersTree;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function CheckPassword(const UserName, Password: String): Boolean;
    function AllowLogin(const UserName, Password: String): Boolean;
    function AllowGroupLogin(const UserName: String): Boolean;
    function UserExists(const UserName: String): Boolean;
    function GroupExists(const GroupName: String): Boolean;
    function ChPasswd(const UserName, NewPassword: String): Boolean;
    function AddUser(const UserName: String): TfrxUserGroupItem;
    function AddGroup(const GroupName: String): TfrxUserGroupItem;
    function GetGroup(const GroupName: String): TfrxUserGroupItem;
    function GetUser(const UserName: String): TfrxUserGroupItem;
    function MemberOfGroup(const User, Group: String): Boolean;
    function GetUserIndex(const User: String): String;
    function GetGroupOfUser(const User: String): String;
    procedure LoadFromFile(const FileName: String);
    procedure AddUserToGroup(const UserName, GroupName: String);
    procedure RemoveUserFromGroup(const Username, GroupName: String);
    procedure RemoveGroupFromUser(const GroupName, Username: String);
    procedure DeleteUser(const UserName: String);
    procedure DeleteGroup(const GroupName: String);
    procedure SaveToFile(const FileName: String);

    property UserList: TStringList read FUsersList;
    property GroupList: TStringList read FGroupsList;
  end;

  TfrxUserGroupItem = class (TObject)
  private
    FActive: Boolean;
    FPassword: String;
    FName: String;
    FEmail: String;
    FFullName: String;
    FAuthType: String;
    FIsGroup: Boolean;
    FMembers: TStringList;
    FIndexFile: String;
  public
    constructor Create;
    destructor Destroy; override;

    property Name: String read FName write FName;
    property Active: Boolean read FActive write FActive;
    property FullName: String read FFullName write FFullName;
    property Email: String read FEmail write FEmail;
    property Password: String read FPassword write FPassword;
    property AuthType: String read FAuthType write FAuthType;
    property IsGroup: Boolean read FIsGroup write FIsGroup;
    property Members: TStringList read FMembers;
    property IndexFile: String read FIndexFile write FIndexFile;
  end;

var
  ServerUsers: TfrxUsers;

implementation


uses frxServerConfig;

{ TfrxUsers }

function TfrxUsers.AddGroup(const GroupName: String): TfrxUserGroupItem;
begin
  if not GroupExists(GroupName) then
  begin
    Result := TfrxUserGroupItem.Create;
    Result.Name := GroupName;
    Result.IsGroup := True;
    FGroupsList.AddObject(Result.Name, Result);
  end else
    Result := nil;
end;

function TfrxUsers.AddUser(const UserName: String): TfrxUserGroupItem;
begin
  if not UserExists(UserName) then
  begin
    Result := TfrxUserGroupItem.Create;
    Result.Name := UserName;
    Result.IsGroup := False;
    FUsersList.AddObject(Result.Name, Result);
  end else
    Result := nil;
end;

procedure TfrxUsers.AddUserToGroup(const UserName, GroupName: String);
var
  Group, User: TfrxUserGroupItem;
begin
  if (UserName <> '') and (GroupName <> '') then
  begin
    Group := GetGroup(GroupName);
    User := GetUser(UserName);
    if (Group <> nil) and (User <> nil) then
    begin
      User.Members.BeginUpdate;
      Group.Members.BeginUpdate;
      if Group.Members.IndexOf(UserName) = -1 then
        Group.Members.AddObject(UserName, User);
      if User.Members.IndexOf(GroupName) = -1 then
        User.Members.AddObject(GroupName, Group);
      Group.Members.EndUpdate;
      User.Members.EndUpdate;
    end;
  end;
end;

function TfrxUsers.AllowGroupLogin(const UserName: String): Boolean;
var
  i: Integer;
  User, Group: TfrxUserGroupItem;
begin
  Result := False;
  User := GetUser(UserName);
  for i := 0 to User.Members.Count - 1 do
  begin
    Group := TfrxUserGroupItem(User.Members.Objects[i]);
    if Group.Active then
      Result := True;
  end;
end;

function TfrxUsers.AllowLogin(const UserName, Password: String): Boolean;
var
  User: TfrxUserGroupItem;
begin
  Result := False;
  User := GetUser(UserName);
  if User <> nil then
    Result := User.Active and CheckPassword(UserName, Password) and AllowGroupLogin(UserName);
end;

function TfrxUsers.CheckPassword(const UserName,
  Password: String): Boolean;
var
  User: TfrxUserGroupItem;
begin
  Result := False;
  User := GetUser(UserName);
  if User <> nil then
    Result := String(frMD5String(AnsiString(Password))) = User.Password;
end;

function TfrxUsers.ChPasswd(const UserName,
  NewPassword: String): Boolean;
var
  User: TfrxUserGroupItem;
begin
  Result := False;
  User := GetUser(UserName);
  if User <> nil then
  begin
    User.Password := String(frMD5String(AnsiString(NewPassword)));
    Result := True;
  end;
end;

procedure TfrxUsers.Clear;
var
  i: Integer;
begin
  for i := 0 to FUsersList.Count - 1 do
    TfrxUserGroupItem(FUsersList.Objects[i]).Free;
  FUsersList.Clear;
  for i := 0 to FGroupsList.Count - 1 do
    TfrxUserGroupItem(FGroupsList.Objects[i]).Free;
  FGroupsList.Clear;
end;

constructor TfrxUsers.Create;
begin
  FXML := TfrXMLDocument.Create;
  FXML.AutoIndent := True;
  FUsersList := TStringList.Create;
  FGroupsList := TStringList.Create;
  FUsersList.Sorted := True;
  FGroupsList.Sorted := True;
end;

procedure TfrxUsers.DeleteGroup(const GroupName: String);
var
  Group: TfrxUserGroupItem;
  i: Integer;
begin
  Group := GetGroup(GroupName);
  if Group <> nil then
  begin
    for i := 0 to Group.Members.Count - 1 do
      RemoveGroupFromUser(GroupName, Group.Members[i]);
    Group.Free;
    i := FGroupsList.IndexOf(GroupName);
    FGroupsList.Delete(i);
  end;
end;

procedure TfrxUsers.DeleteUser(const UserName: String);
var
  User: TfrxUserGroupItem;
  i: Integer;
begin
  User := GetUser(UserName);
  if User <> nil then
  begin
    for i := 0 to User.Members.Count - 1 do
      RemoveUserFromGroup(UserName, User.Members[i]);
    User.Free;
    i := FUsersList.IndexOf(UserName);
    FUsersList.Delete(i);
  end;
end;

destructor TfrxUsers.Destroy;
begin
  Clear;
  FXML.Free;
  FUsersList.Clear;
  FUsersList.Free;
  FGroupsList.Clear;
  FGroupsList.Free;
  inherited;
end;

function TfrxUsers.GetGroup(const GroupName: String): TfrxUserGroupItem;
var
  i: Integer;
begin
  i := FGroupsList.IndexOf(GroupName);
  if i <> -1 then
    Result := TfrxUserGroupItem(FGroupsList.Objects[i])
  else
    Result := nil;
end;

function TfrxUsers.GetUser(const UserName: String): TfrxUserGroupItem;
var
  i: Integer;
begin
  i := FUsersList.IndexOf(UserName);
  if i <> -1 then
    Result := TfrxUserGroupItem(FUsersList.Objects[i])
  else
    Result := nil;
end;

function TfrxUsers.GetUserIndex(const User: String): String;
var
  U: TfrxUserGroupItem;
begin
  U := GetUser(User);
  Result := '';
  if (U <> nil) and (U.Members.Count > 0) then
    Result := TfrxUserGroupItem(U.Members.Objects[0]).IndexFile;
  if Result = '' then
    Result := ServerConfig.GetValue('server.http.indexfile');
end;

function TfrxUsers.GetGroupOfUser(const User: String): String;
var
  U: TfrxUserGroupItem;
begin
  U := GetUser(User);
  Result := '';
  if (U <> nil) and (U.Members.Count > 0) then
    Result := TfrxUserGroupItem(U.Members.Objects[0]).Name;
end;

function TfrxUsers.GroupExists(const GroupName: String): Boolean;
begin
  Result := FGroupsList.IndexOf(GroupName) <> -1;
end;

procedure TfrxUsers.LoadFromFile(const FileName: String);
var
  f: TFileStream;
begin
  if FileExists(FileName) then
  begin
    f := TFileStream.Create(FileName, fmOpenRead + fmShareDenyWrite);
    try
      Clear;
      try
        FXML.LoadFromStream(f, False);
      finally
        UnpackUsersTree;
      end;
    finally
      f.Free;
    end;
  end;
end;

function TfrxUsers.MemberOfGroup(const User, Group: String): Boolean;
begin
  Result := GetUser(User).Members.IndexOf(Group) <> -1;
end;

procedure TfrxUsers.PackUsersTree;
var
  x: TfrXMLItem;
  i, j: Integer;
  User: TfrxUserGroupItem;
begin
  FXML.Clear;
  FXML.Root.Name := 'server';
  x := FXML.Root.Add;
  x.Name := 'groups';
  x.Prop['desc'] := 'Groups list';
  for i := 0 to FGroupsList.Count - 1 do
    with x.Add do
    begin
      Name := 'group';
      User := TfrxUserGroupItem(FGroupsList.Objects[i]);
      Prop['name'] := User.Name;
      Prop['index'] := User.IndexFile;
      if User.Active then
        Prop['active'] := 'yes'
      else
        Prop['active'] := 'no';
      Prop['fullname'] := User.FullName;
    end;
  x := FXML.Root.Add;
  x.Name := 'users';
  x.Prop['desc'] := 'Users list';
  for i := 0 to FUsersList.Count - 1 do
    with x.Add do
    begin
      Name := 'user';
      User := TfrxUserGroupItem(FUsersList.Objects[i]);
      Prop['name'] := User.Name;
      if User.Active then
        Prop['active'] := 'yes'
      else
        Prop['active'] := 'no';
      Prop['fullname'] := User.FullName;
      Prop['email'] := User.Email;
      Prop['password'] := User.Password;
    end;
  x := FXML.Root.Add;
  x.Name := 'membership';
  x.Prop['desc'] := 'Membership relations';
  for i := 0 to FGroupsList.Count - 1 do
  begin
    User := TfrxUserGroupItem(FGroupsList.Objects[i]);
    if User.Members.Count > 0 then
    begin
      with x.Add do
      begin
        Name := 'group';
        Prop['name'] := User.Name;
        for j := 0 to User.Members.Count - 1 do
        with Add do
        begin
          Name := 'user';
          Prop['name'] := User.Members[j];
        end;
      end;
    end;
  end;
end;

procedure TfrxUsers.RemoveGroupFromUser(const GroupName, Username: String);
var
  User: TfrxUserGroupItem;
  i: Integer;
begin
  User := GetUser(Username);
  if User <> nil then
  begin
    i := User.Members.IndexOf(GroupName);
    if i <> -1 then
      User.Members.Delete(i);
  end;
end;

procedure TfrxUsers.RemoveUserFromGroup(const Username, GroupName: String);
var
  Group: TfrxUserGroupItem;
  i: Integer;
begin
  Group := GetGroup(GroupName);
  if Group <> nil then
  begin
    i := Group.Members.IndexOf(UserName);
    if i <> -1 then
      Group.Members.Delete(i);
  end;
end;

procedure TfrxUsers.SaveToFile(const FileName: String);
begin
  PackUsersTree;
  FXML.SaveToFile(FileName);
end;

procedure TfrxUsers.UnpackUsersTree;
var
  x: TfrXMLItem;
  Item: TfrxUserGroupItem;
  i, j: Integer;
begin
  Clear;
  x := FXML.Root.FindItem('groups');
  for i := 0 to x.Count - 1 do
  begin
    Item := AddGroup(x.Items[i].Prop['name']);
    if Item <> nil then
    begin
      Item.FullName := x.Items[i].Prop['fullname'];
      Item.Active := (x.Items[i].Prop['active'] = 'yes') or (x.Items[i].Prop['active'] = '');
      Item.AuthType := x.Items[i].Prop['auth'];
      Item.IndexFile := x.Items[i].Prop['index'];
    end;
  end;
  x := FXML.Root.FindItem('users');
  for i := 0 to x.Count - 1 do
  begin
    Item := AddUser(x.Items[i].Prop['name']);
    if Item <> nil then
    begin
      Item.FullName := x.Items[i].Prop['fullname'];
      Item.Active := (x.Items[i].Prop['active'] = 'yes') or (x.Items[i].Prop['active'] = '');
      Item.AuthType := x.Items[i].Prop['auth'];
      if x.Items[i].Prop['auth'] <> '' then
        Item.Password := x.Items[i].Prop['auth'];
      Item.Email := x.Items[i].Prop['email'];
      if x.Items[i].Prop['password'] <> '' then
        Item.Password := x.Items[i].Prop['password'];
    end;
  end;
  x := FXML.Root.FindItem('membership');
  for i := 0 to x.Count - 1 do
    for j := 0 to x.Items[i].Count - 1 do
      AddUserToGroup(x.Items[i].Items[j].Prop['name'], x.Items[i].Prop['name']);
end;

function TfrxUsers.UserExists(const UserName: String): Boolean;
begin
  Result := FUsersList.IndexOf(UserName) <> -1;
end;

{ TfrxUserGroupItem }

constructor TfrxUserGroupItem.Create;
begin
  FActive := True;
  FAuthType := 'internal';
  FIsGroup := False;
  FMembers := TStringList.Create;
  FMembers.Sorted := True;
  FPassword := String(frMD5String(''));
end;

destructor TfrxUserGroupItem.Destroy;
begin
  FMembers.Free;
  inherited;
end;

initialization
  ServerUsers := TfrxUsers.Create;

finalization
  ServerUsers.Free;

end.
