object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'FrmMain'
  ClientHeight = 669
  ClientWidth = 1151
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object Memo_Response: TMemo
    Left = 0
    Top = 41
    Width = 1151
    Height = 628
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1151
    Height = 41
    Align = alTop
    TabOrder = 1
    ExplicitTop = -6
    object ButtonGET: TButton
      Left = 24
      Top = 10
      Width = 75
      Height = 25
      Caption = 'GET'
      TabOrder = 0
      OnClick = ButtonGETClick
    end
  end
end
