object frxFileSignatureErrorDialog: TfrxFileSignatureErrorDialog
  Tag = 210
  Left = 597
  Top = 335
  BorderStyle = bsDialog
  Caption = 'File Signature Error'
  ClientHeight = 122
  ClientWidth = 441
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    441
    122)
  TextHeight = 13
  object lblDescription: TLabel
    Left = 12
    Top = 16
    Width = 95
    Height = 13
    Caption = '<error description>'
  end
  object btnOk: TButton
    Tag = 1
    Left = 181
    Top = 89
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object btnCancel: TButton
    Tag = 2
    Left = 358
    Top = 89
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object cbSaveLog: TCheckBox
    Tag = 211
    Left = 8
    Top = 53
    Width = 397
    Height = 17
    Caption = 'Save log'
    TabOrder = 2
  end
  object btnIgnore: TButton
    Tag = 212
    Left = 8
    Top = 89
    Width = 167
    Height = 25
    Hint = '10102'
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Ignore Certificate'
    ModalResult = 5
    TabOrder = 3
  end
end
