inherited frmCallsMain: TfrmCallsMain
  Left = 185
  Top = 107
  Caption = 'Call demo'
  ClientHeight = 293
  ClientWidth = 395
  Position = poScreenCenter
  ExplicitWidth = 411
  ExplicitHeight = 352
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel [0]
    Left = 4
    Top = 260
    Width = 387
    Height = 29
    Anchors = [akLeft, akRight, akBottom]
    AutoSize = False
    Caption = 
      'This demo shows how to call a Delphi function from script and ho' +
      'w to call script function from Delphi'
    WordWrap = True
  end
  object Button1: TButton [1]
    Left = 4
    Top = 4
    Width = 85
    Height = 25
    Caption = 'Call DelphiFunc'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo [2]
    Left = 4
    Top = 36
    Width = 387
    Height = 218
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      'procedure ScriptFunc(Msg: String; Num: '
      'Integer);'
      'begin'
      '  ShowMessage('#39'1st param: '#39' + Msg + '
      '    '#39'  2nd param: '#39' + IntToStr(Num));'
      'end;'
      ''
      'begin'
      '  DelphiFunc('#39'Call DelphiFunc'#39', 1);'
      'end.')
    ParentFont = False
    TabOrder = 1
  end
  object Button2: TButton [3]
    Left = 96
    Top = 4
    Width = 85
    Height = 25
    Caption = 'Call ScriptFunc'
    TabOrder = 2
    OnClick = Button2Click
  end
  object fsScript1: TfsScript
    SyntaxType = 'PascalScript'
    Left = 36
    Top = 160
  end
  object fsPascal1: TfsPascal
    Left = 68
    Top = 160
  end
end
