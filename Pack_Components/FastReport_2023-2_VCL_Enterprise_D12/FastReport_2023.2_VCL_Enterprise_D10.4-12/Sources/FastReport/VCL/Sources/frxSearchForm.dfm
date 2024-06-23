object frxSearchForm: TfrxSearchForm
  Left = 555
  Top = 173
  BorderStyle = bsNone
  Caption = 'frxSearchForm'
  ClientHeight = 416
  ClientWidth = 183
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlSearch: TPanel
    Left = 0
    Top = 0
    Width = 183
    Height = 185
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      183
      185)
    object lblFind: TLabel
      Left = 8
      Top = 8
      Width = 56
      Height = 13
      Caption = 'Text to Find'
    end
    object edtFind: TEdit
      Left = 8
      Top = 21
      Width = 173
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      BevelInner = bvNone
      BevelOuter = bvNone
      TabOrder = 0
      OnKeyDown = edtFindKeyDown
    end
    object btnFind: TButton
      Left = 70
      Top = 154
      Width = 103
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Find'
      TabOrder = 2
    end
    object gbSearch: TGroupBox
      Left = 8
      Top = 48
      Width = 165
      Height = 87
      Anchors = [akLeft, akRight]
      Caption = 'Search options'
      TabOrder = 1
      object chkBeg: TCheckBox
        Left = 8
        Top = 16
        Width = 152
        Height = 17
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Search from beginning'
        TabOrder = 0
      end
      object chkCase: TCheckBox
        Left = 8
        Top = 37
        Width = 152
        Height = 17
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Case sensitive'
        TabOrder = 1
      end
      object chkFindAll: TCheckBox
        Left = 8
        Top = 58
        Width = 152
        Height = 17
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Find All'
        TabOrder = 2
        OnClick = chkFindAllClick
      end
    end
  end
end
