object frxBaseMailIOTransportForm: TfrxBaseMailIOTransportForm
  Left = 325
  Top = 253
  ActiveControl = OkB
  BorderStyle = bsDialog
  Caption = 'Export to e-mail'
  ClientHeight = 284
  ClientWidth = 372
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ReqLB: TLabel
    Left = 8
    Top = 251
    Width = 193
    Height = 13
    AutoSize = False
    Caption = 'Required fields are not filled'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    Visible = False
  end
  object AddressLB: TLabel
    Left = 8
    Top = 20
    Width = 65
    Height = 13
    AutoSize = False
    Caption = 'Address'
  end
  object SubjectLB: TLabel
    Left = 8
    Top = 44
    Width = 65
    Height = 13
    AutoSize = False
    Caption = 'Subject'
  end
  object MessageLB: TLabel
    Left = 8
    Top = 68
    Width = 65
    Height = 13
    AutoSize = False
    Caption = 'Text'
  end
  object FileLB: TLabel
    Left = 8
    Top = 201
    Width = 65
    Height = 13
    AutoSize = False
    Caption = 'File'
  end
  object OkB: TButton
    Tag = 1
    Left = 207
    Top = 246
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 3
    OnClick = OkBClick
  end
  object CancelB: TButton
    Tag = 2
    Left = 288
    Top = 246
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 4
  end
  object MessageM: TMemo
    Left = 76
    Top = 64
    Width = 285
    Height = 131
    ScrollBars = ssBoth
    TabOrder = 2
  end
  object AddressE: TEdit
    Left = 76
    Top = 16
    Width = 285
    Height = 21
    Hint = 'Address or addresses delimited by comma'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
  end
  object SubjectE: TEdit
    Left = 76
    Top = 40
    Width = 285
    Height = 21
    TabOrder = 1
  end
  object FileE: TEdit
    Left = 76
    Top = 197
    Width = 285
    Height = 21
    Hint = 'FileName'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
  end
end
