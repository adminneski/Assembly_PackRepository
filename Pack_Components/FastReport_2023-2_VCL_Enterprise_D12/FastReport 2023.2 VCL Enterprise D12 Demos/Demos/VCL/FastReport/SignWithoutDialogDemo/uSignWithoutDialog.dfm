inherited frmSignWithoutDialog: TfrmSignWithoutDialog
  Left = 179
  Top = 103
  Caption = 'Two signatures'
  ClientHeight = 170
  ClientWidth = 424
  ExplicitWidth = 440
  ExplicitHeight = 229
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton [0]
    Left = 7
    Top = 131
    Width = 119
    Height = 30
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Export and Sign'
    TabOrder = 2
    OnClick = Button1Click
  end
  object rbOneSign: TRadioButton [1]
    Left = 6
    Top = 66
    Width = 410
    Height = 60
    Align = alCustom
    Anchors = [akLeft, akTop, akRight]
    Caption = 
      'Sign the report with one signature.'#13#10'This method allows you to s' +
      'ign reports with one signature only.'
    TabOrder = 1
    WordWrap = True
  end
  object rbTwoSign: TRadioButton [2]
    Left = 6
    Top = 6
    Width = 410
    Height = 60
    Align = alCustom
    Anchors = [akLeft, akTop, akRight]
    Caption = 
      'Sign the report with multiple signatures.'#13#10'This method allows yo' +
      'u to sign reports with one or more signatures.'
    Checked = True
    TabOrder = 0
    TabStop = True
    WordWrap = True
  end
end
