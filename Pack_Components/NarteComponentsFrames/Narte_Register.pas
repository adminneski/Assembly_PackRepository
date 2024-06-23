unit Narte_Register;

interface





procedure Register;

implementation

uses
  Forms,
  Classes,
  TreeIntf,
  Narte_Lookup,
  Narte_DBLookup,
  Narte_DBNavigator;

type
  TFrameClass = class of TFrame;

procedure RegisterFramesAsComponents(const Page: string; const FrameClasses: array of TFrameClass);
var
  FrameClass: TFrameClass;
begin
  for FrameClass in FrameClasses do
  begin
    RegisterComponents(Page, [FrameClass]);
    RegisterSprigType(FrameClass, TComponentSprig);
  end;
end;

procedure Register;
begin
  RegisterFramesAsComponents('Narte Library - Frames', [TFrameLookup,
                                                        TFrameDBLookup,
                                                        TFrameDBNavigator]);






end;
end.
