{*******************************************************}
{                                                       }
{                        EhLib 10.2                     }
{                                                       }
{           Design Time window - About EhLib            }
{                                                       }
{    Copyright (c) 2013-2022 by Dmitry V. Bolshakov     }
{                                                       }
{*******************************************************}

unit EhLibDesignAbout;

{$I EhLib.Inc}

interface

uses
  Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  {$IFDEF FPC}
    EhLibLCL, LCLType, LCLIntf,
    {$IFDEF FPC_CROSSP}
    {$ELSE}
      Windows, Win32Extra, UxTheme, ShellAPI,
    {$ENDIF}
  {$ELSE}
    XPMan, EhLibVCL, jpeg, Windows, ShellAPI,
  {$ENDIF}
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TEhLibDesignAboutForm = class(TForm)
    Image1: TImage;
    Memo1: TMemo;
    Bevel1: TBevel;
    Bevel2: TBevel;
    bbClose: TBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Bevel3: TBevel;
    lBuild: TLabel;
    Shape1: TShape;
    lSupportRef: TLabel;
    lForumRef: TLabel;
    lHomePage: TLabel;
    Shape2: TShape;
    Image2: TImage;
    lVer: TLabel;
    lEditionInfo: TLabel;
    procedure bbCloseClick(Sender: TObject);
    procedure lHomePageClick(Sender: TObject);
    procedure lForumRefClick(Sender: TObject);
    procedure lSupportRefClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTESt;
  public
    { Public declarations }
  end;

var
  EhLibDesignAboutForm: TEhLibDesignAboutForm;

procedure ShowAboutForm;

implementation

{$R *.dfm}

procedure ShowAboutForm;
begin
  EhLibDesignAboutForm := TEhLibDesignAboutForm.Create(Application);
  try
    EhLibDesignAboutForm.ShowModal;
  finally
    FreeAndNil(EhLibDesignAboutForm);
  end
end;

procedure TEhLibDesignAboutForm.bbCloseClick(Sender: TObject);
begin
  Close;
end;

type
  TControlCrack = class(TControl);

procedure TEhLibDesignAboutForm.FormCreate(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to ControlCount-1 do
  begin
    TControlCrack(Controls[i]).Font.Name := Font.Name;
  end;
  lSupportRef.Font.Style := [fsBold, fsUnderline];
  lForumRef.Font := lSupportRef.Font;
  lHomePage.Font := lSupportRef.Font;

  lVer.Caption := EhLibVerInfo;
  lBuild.Caption := EhLibBuildInfo;
  lEditionInfo.Caption := EhLibEditionInfo;
end;

procedure TEhLibDesignAboutForm.lForumRefClick(Sender: TObject);
begin
  {$IFDEF FPC}
  OpenURL('http://forum.ehlib.com');
  {$ELSE}
  ShellExecute(Application.Handle, 'Open', 'http://forum.ehlib.com', nil, nil, SW_SHOWNORMAL);
  {$ENDIF}
end;

procedure TEhLibDesignAboutForm.lHomePageClick(Sender: TObject);
begin
  {$IFDEF FPC}
  OpenURL('http://www.ehlib.com');
  {$ELSE}
  ShellExecute(Application.Handle, 'Open', 'http://www.ehlib.com', nil, nil, SW_SHOWNORMAL);
  {$ENDIF}
end;

procedure TEhLibDesignAboutForm.lSupportRefClick(Sender: TObject);
begin
  {$IFDEF FPC}
  OpenURL('mailto:support@ehlib.com');
  {$ELSE}
  ShellExecute(Application.Handle, 'open', 'mailto:support@ehlib.com', nil, nil, SW_SHOWNORMAL);
  {$ENDIF}
end;

procedure TEhLibDesignAboutForm.WMNCHitTest(var Message: TWMNCHitTest);
begin
  if FindDragTarget(Classes.Point(Message.XPos, Message.YPos), False) is TLabel then
    Message.Result := HTCLIENT
  else
    Message.Result := HTCAPTION;
end;

end.

