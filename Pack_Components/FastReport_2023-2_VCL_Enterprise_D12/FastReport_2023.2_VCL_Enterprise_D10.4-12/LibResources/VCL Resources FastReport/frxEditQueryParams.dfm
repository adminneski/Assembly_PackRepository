object frxParamsEditorForm: TfrxParamsEditorForm
  Left = 186
  Top = 107
  ActiveControl = ParamsLV
  BorderStyle = bsDialog
  Caption = 'Parameters editor'
  ClientHeight = 381
  ClientWidth = 392
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnCreate = FormCreate
  OnHide = FormHide
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ParamsLV: TListView
    Left = 4
    Top = 4
    Width = 384
    Height = 337
    Columns = <
      item
        Caption = 'Name'
        MaxWidth = 100
        MinWidth = 100
        Width = 100
      end
      item
        Caption = 'Data type'
        MaxWidth = 80
        MinWidth = 80
        Width = 80
      end
      item
        Caption = 'Value'
        MaxWidth = 200
        MinWidth = 200
        Width = 200
      end>
    ColumnClick = False
    ReadOnly = True
    ParentShowHint = False
    ShowHint = False
    TabOrder = 0
    ViewStyle = vsReport
    OnMouseUp = ParamsLVMouseUp
    OnSelectItem = ParamsLVSelectItem
  end
  object TypeCB: TComboBox
    Left = 104
    Top = 23
    Width = 84
    Height = 19
    Style = csOwnerDrawFixed
    ItemHeight = 13
    TabOrder = 1
  end
  object ValueE: TEdit
    Left = 184
    Top = 23
    Width = 184
    Height = 21
    TabOrder = 2
  end
  object OkB: TButton
    Left = 232
    Top = 348
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 3
    OnClick = OkBClick
  end
  object CancelB: TButton
    Left = 312
    Top = 348
    Width = 75
    Height = 25
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
  object ButtonPanel: TPanel
    Left = 368
    Top = 24
    Width = 17
    Height = 17
    BevelOuter = bvNone
    TabOrder = 5
    object ExpressionB: TSpeedButton
      Left = 0
      Top = 0
      Width = 17
      Height = 17
      Glyph.Data = {
        D6000000424DD60000000000000076000000280000000C0000000C0000000100
        0400000000006000000000000000000000001000000010000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00707777777777
        0000770777777777000077087007007700007780778007770000778087700077
        0000777087007807000077780777777700007700000777770000777708777777
        0000777700780777000077777000777700007777777777770000}
      OnClick = ValueEButtonClick
    end
  end
end
