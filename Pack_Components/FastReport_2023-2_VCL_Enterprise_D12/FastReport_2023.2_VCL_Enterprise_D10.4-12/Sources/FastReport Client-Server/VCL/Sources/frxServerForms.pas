
{******************************************}
{                                          }
{             FastReport VCL               }
{            Server HTTP Forms             }
{                                          }
{         Copyright (c) 1998-2021          }
{            by Fast Reports Inc.          }
{                                          }
{******************************************}

unit frxServerForms;

{$I frx.inc}

interface

uses
  {$IFNDEF Linux}
  Windows,
  {$ELSE}
  LCLType, LCLIntf, LazHelper,
  {$ENDIF}
  Classes, SysUtils, Graphics, frxClass, frxDCtrl, frxUtils,
  frxExportMatrix, frxServerFormControls, frUnicodeUtils, frxServerTemplates;

type
  TfrxWebForm = class(Tobject)
  private
    Exp: TFileStream;
    FMatrix: TfrxIEMatrix;
    FDialog: TfrxDialogPage;
    FRepName: String;
    FSession: String;
    procedure WriteExpLn(const str: Ansistring);{$IFDEF DELPHI12} overload;
    procedure WriteExpLn(const str: String); overload;
    {$ENDIF}

    function GetHTML(Obj: TfrxDialogControl): AnsiString;
  public
    constructor Create(Dialog: TfrxDialogPage; Session: String);
    destructor Destroy; override;
    procedure Prepare;
    procedure Clear;
    procedure SaveFormToFile(FName: String);
    property ReportName: String read FRepName write FRepName;
  end;

implementation

{ TfrxWebForm }

constructor TfrxWebForm.Create(Dialog: TfrxDialogPage; Session: String);
begin
  FDialog := Dialog;
  FSession := Session;
  FMatrix := TfrxIEMatrix.Create(False, '');
  FMatrix.ShowProgress := False;
  FMatrix.Inaccuracy := 10;
  FMatrix.AreaFill := True;
  FMatrix.FramesOptimization := False;
end;

destructor TfrxWebForm.Destroy;
begin
  Clear;
  FMatrix.Free;
  inherited;
end;

procedure TfrxWebForm.Clear;
begin
  FMatrix.Clear;
end;

procedure TfrxWebForm.WriteExpLn(const str: AnsiString);
begin
  if Length(str) > 0 then
  begin
    Exp.Write(str[1], Length(str));
    Exp.Write(#13#10, 2);
  end;
end;

{$IFDEF DELPHI12}
procedure TfrxWebForm.WriteExpLn(const str: String);
begin
  WriteExpLn(UTF8Encode(str));
end;
{$ENDIF}

procedure TfrxWebForm.Prepare;
var
  i: Integer;
begin
  for i := 0 to FDialog.AllObjects.Count - 1 do
    FMatrix.AddDialogObject(FDialog.AllObjects[i]);
  FMatrix.Prepare;
end;

procedure TfrxWebForm.SaveFormToFile(FName: String);
var
  i, x, y, fx, fy, dx, dy: Integer;
  drow, dcol: Integer;
  s, sb, st: String; //ss
  obj: TfrxIEMObject;
  FTemplate: TfrxServerTemplate;

begin
  FTemplate := TfrxServerTemplate.Create;
  try
    try
      Exp := TFileStream.Create(FName, fmCreate);
      try
        FTemplate.SetTemplate('form_begin');
{$IFDEF DELPHI12}
        FTemplate.Variables.AddVariable('TITLE', FDialog.Caption);
        FTemplate.Variables.AddVariable('CAPTION', FDialog.Caption);
{$ELSE}
        FTemplate.Variables.AddVariable('TITLE', UTF8Encode(FDialog.Caption));
        FTemplate.Variables.AddVariable('CAPTION', UTF8Encode(FDialog.Caption));
{$ENDIF}
        FTemplate.Variables.AddVariable('HTML_INIT', '');
        FTemplate.Variables.AddVariable('HTML_CODE', '');
        FTemplate.Variables.AddVariable('REPORT', FRepName);
        FTemplate.Variables.AddVariable('SESSION', FSession);
        FTemplate.Variables.AddVariable('BCOLOR', HTMLRGBColor(FDialog.Color));
        FTemplate.Variables.AddVariable('COLSPAN', IntToStr(FMatrix.Width - 1));
        FTemplate.Prepare;
        st := FTemplate.TemplateStrings.Text;
        WriteExpLn(st);
        for y := 0 to FMatrix.Height - 2 do
        begin
          drow := Round(FMatrix.GetYPosById(y + 1) - FMatrix.GetYPosById(y));
          WriteExpLn('<tr height="' + IntToStr(drow) + '"' + s + '>');
          for x := 0 to FMatrix.Width - 2 do
          begin
            i := FMatrix.GetCell(x, y);
            if (i <> -1) then
            begin
              Obj := FMatrix.GetObjectById(i);
              dcol := Round(Obj.Width);
              if Obj.Counter = 0 then
              begin
                FMatrix.GetObjectPos(i, fx, fy, dx, dy);
                Obj.Counter := 1;
                if dx > 1 then
                  s := ' colspan="' + IntToStr(dx) + '"'
                else s := '';
                if dy > 1 then
                  sb := ' rowspan="' + IntToStr(dy) + '"'
                else sb := '';
                if Obj.Link = nil then
                  st := ' style="font-size:1px"'
                else
                  st := '';
                WriteExpLn('<td align="left" valign="top" width="' + IntToStr(dcol) + '"' + s + sb + st + '>');
                if Obj.Link <> nil then
                  WriteExpLn(GetHTML(TfrxDialogControl(Obj.Link)))
                else
                  WriteExpLn('&nbsp;');
                WriteExpLn('</td>');
              end
            end else
            begin
              dcol := Round(FMatrix.GetXPosById(x + 1) - FMatrix.GetXPosById(x));
              WriteExpLn('<td style="font-size:1px" width="' + IntToStr(dcol) + '">&nbsp;</td>');
            end
          end;
          WriteExpLn('</tr>');
        end;
        FTemplate.SetTemplate('form_end');
        FTemplate.Variables.AddVariable('COLSPAN', IntToStr(FMatrix.Width - 1));
        FTemplate.Prepare;
        WriteExpLn(FTemplate.TemplateStrings.Text);
      finally
        {$IFNDEF Linux}
        FlushFileBuffers(Exp.Handle);
        {$ELSE}
        FileFlush(Exp.Handle);
        {$ENDIF}
        Exp.Free;
      end;
    except
    end;
  finally
    FTemplate.Free;
  end
end;

function TfrxWebForm.GetHTML(Obj: TfrxDialogControl): AnsiString;
var
  wLabel: TfrxWebLabelControl;
  wEdit: TfrxWebTextControl;
  wButton: TfrxWebSubmitControl;
  wRadio: TfrxWebRadioControl;
  wCheckBox: TfrxWebCheckBoxControl;
  wText: TfrxWebTextAreaControl;
  wCombo: TfrxWebSelectControl;
  wDate: TfrxWebDateControl;
  wImage: TfrxWebImageControl;
begin
  Result := '';
  if Obj is TfrxLabelControl then
  begin
    wLabel := TfrxWebLabelControl.Create;
    try
      wLabel.Assign(Obj);
      Result := wLabel.HTML;
    finally
      wLabel.Free;
    end;
  end else
  if Obj is TfrxEditControl then
  begin
    wEdit := TfrxWebTextControl.Create;
    try
      wEdit.Assign(Obj);
      Result := wEdit.HTML;
    finally
      wEdit.Free;
    end;
  end else
  if Obj is TfrxDateEditControl then
  begin
    wDate := TfrxWebDateControl.Create;
    try
      wDate.Assign(Obj);
      Result := wDate.HTML;
    finally
      wDate.Free;
    end;
  end else
  if Obj is TfrxButtonControl then
  begin
    wButton := TfrxWebSubmitControl.Create;
    try
      wButton.Assign(Obj);
      Result := wButton.HTML;
    finally
      wButton.Free;
    end;
  end else
  if Obj is TfrxRadioButtonControl then
  begin
    wRadio := TfrxWebRadioControl.Create;
    try
      wRadio.Assign(Obj);
      Result := wRadio.HTML;
    finally
      wRadio.Free;
    end;
  end else
  if Obj is TfrxCheckBoxControl then
  begin
    wCheckBox := TfrxWebCheckBoxControl.Create;
    try
      wCheckBox.Assign(Obj);
      Result := wCheckBox.HTML;
    finally
      wCheckBox.Free;
    end;
  end else
  if Obj is TfrxMemoControl then
  begin
    wText := TfrxWebTextAreaControl.Create;
    try
      wText.Assign(Obj);
      Result := wText.HTML;
    finally
      wText.Free;
    end;
  end else
  if Obj is TfrxComboBoxControl then
  begin
    wCombo:=TfrxWebSelectControl.Create;
    try
      wCombo.Assign(Obj);
      Result := wCombo.HTML;
    finally
      wCombo.Free;
    end;
  end else
  if Obj is TfrxImageControl then
  begin
    wImage := TfrxWebImageControl.Create;
    try
      wImage.Session := FSession;
      wImage.Assign(Obj);
      Result := wImage.HTML;
    finally
      wImage.Free;
    end;
  end;
{$IFNDEF DELPHI12}
  Result := UTF8Encode(Result);
{$ENDIF}
end;

end.
