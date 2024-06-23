object Form1: TForm1
  Left = 723
  Top = 334
  BorderStyle = bsDialog
  Caption = 'Form1'
  ClientHeight = 570
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  DesignSize = (
    447
    570)
  TextHeight = 12
  object SignByCryptoAPIButton: TButton
    Left = 6
    Top = 473
    Width = 212
    Height = 27
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'SignByCryptoAPI'
    TabOrder = 3
    OnClick = SignByCryptoAPIButtonClick
    ExplicitTop = 544
  end
  object GroupBox1: TGroupBox
    Left = 7
    Top = 7
    Width = 430
    Height = 123
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Files'
    TabOrder = 0
    object MessageLabel: TLabel
      Left = 98
      Top = 23
      Width = 41
      Height = 12
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Unit1.pas'
    end
    object SignatureLabel: TLabel
      Left = 98
      Top = 57
      Width = 3
      Height = 12
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
    end
    object PFXLabel: TLabel
      Left = 98
      Top = 92
      Width = 3
      Height = 12
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
    end
    object MessageButton: TButton
      Left = 13
      Top = 19
      Width = 60
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Message'
      TabOrder = 0
      OnClick = MessageButtonClick
    end
    object SignatureButton: TButton
      Left = 13
      Top = 54
      Width = 60
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Signature'
      TabOrder = 1
      OnClick = SignatureButtonClick
    end
    object PFXButton: TButton
      Left = 13
      Top = 90
      Width = 60
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'PFX / P12'
      TabOrder = 2
      OnClick = PFXButtonClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 7
    Top = 134
    Width = 212
    Height = 275
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Certificate'
    TabOrder = 1
    object Label1: TLabel
      Left = 13
      Top = 56
      Width = 38
      Height = 12
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Subject:'
    end
    object Label2: TLabel
      Left = 13
      Top = 83
      Width = 31
      Height = 12
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Issuer:'
    end
    object Label3: TLabel
      Left = 13
      Top = 110
      Width = 47
      Height = 12
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Password:'
    end
    object Label4: TLabel
      Left = 13
      Top = 137
      Width = 52
      Height = 12
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Date format'
    end
    object Label5: TLabel
      Left = 13
      Top = 164
      Width = 52
      Height = 12
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Not before:'
    end
    object Label6: TLabel
      Left = 13
      Top = 195
      Width = 43
      Height = 12
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Not after:'
    end
    object SubjectEdit: TEdit
      Left = 90
      Top = 53
      Width = 96
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      TabOrder = 1
    end
    object IssuerEdit: TEdit
      Left = 90
      Top = 80
      Width = 96
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      TabOrder = 2
    end
    object PasswordEdit: TEdit
      Left = 90
      Top = 107
      Width = 96
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      TabOrder = 3
    end
    object DateFormatEdit: TEdit
      Left = 90
      Top = 134
      Width = 96
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      TabOrder = 4
      Text = 'dd.mm.yy'
    end
    object NotBeforeEdit: TEdit
      Left = 90
      Top = 162
      Width = 96
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      TabOrder = 5
    end
    object NotAfterEdit: TEdit
      Left = 90
      Top = 188
      Width = 96
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      TabOrder = 6
    end
    object IgnoreCaseCheckBox: TCheckBox
      Left = 13
      Top = 22
      Width = 129
      Height = 15
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Ignore Case'
      TabOrder = 0
    end
  end
  object GroupBox3: TGroupBox
    Left = 223
    Top = 136
    Width = 212
    Height = 273
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Signature'
    TabOrder = 2
    object DetachedCheckBox: TCheckBox
      Left = 13
      Top = 22
      Width = 77
      Height = 15
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Detached'
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object ChainCheckBox: TCheckBox
      Left = 13
      Top = 51
      Width = 77
      Height = 15
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Chain'
      TabOrder = 1
    end
    object OnlyGOSTCheckBox: TCheckBox
      Left = 13
      Top = 79
      Width = 77
      Height = 15
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Only GOST'
      TabOrder = 2
    end
    object DebugLogCheckBox: TCheckBox
      Left = 13
      Top = 108
      Width = 77
      Height = 15
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Debug log'
      Checked = True
      State = cbChecked
      TabOrder = 3
    end
    object PFXCheckBox: TCheckBox
      Left = 13
      Top = 137
      Width = 84
      Height = 15
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Use pfx / p12'
      TabOrder = 4
    end
    object BESRadioButton: TRadioButton
      Left = 13
      Top = 172
      Width = 84
      Height = 15
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'CAdES-BES'
      Checked = True
      TabOrder = 5
      TabStop = True
      OnClick = BESRadioButtonClick
    end
    object TRadioButton: TRadioButton
      Left = 13
      Top = 194
      Width = 173
      Height = 15
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'CAdES-T'
      TabOrder = 6
      OnClick = BESRadioButtonClick
    end
    object XLongTime1RadioButton: TRadioButton
      Left = 13
      Top = 216
      Width = 173
      Height = 15
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'CAdES-X Long Type 1'
      TabOrder = 7
      OnClick = BESRadioButtonClick
    end
  end
  object DebugLogMemo: TMemo
    Left = 223
    Top = 473
    Width = 213
    Height = 91
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akRight, akBottom]
    Lines.Strings = (
      'DebugLogMemo')
    TabOrder = 4
    ExplicitTop = 544
  end
  object TimeStampGroupBox: TGroupBox
    Left = 7
    Top = 413
    Width = 430
    Height = 53
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Timestamp'
    TabOrder = 5
    object Label8: TLabel
      Left = 98
      Top = 57
      Width = 3
      Height = 12
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
    end
    object Label9: TLabel
      Left = 98
      Top = 92
      Width = 3
      Height = 12
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
    end
    object Label7: TLabel
      Left = 13
      Top = 19
      Width = 54
      Height = 12
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'TSA server:'
    end
    object TSAServerEdit: TEdit
      Left = 90
      Top = 17
      Width = 320
      Height = 20
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      TabOrder = 0
      Visible = False
    end
  end
  object SignByCryptoAPIAndCryptoProSDKButton: TButton
    Left = 6
    Top = 537
    Width = 212
    Height = 27
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'SignByCryptoAPIStampByCryptoProSDK'
    TabOrder = 6
    OnClick = SignByCryptoAPIButtonClick
    ExplicitTop = 608
  end
  object SignByCryptoProSDKButton: TButton
    Left = 6
    Top = 505
    Width = 212
    Height = 27
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akLeft, akRight, akBottom]
    Caption = 'SignByCryptoProSDK'
    TabOrder = 7
    OnClick = SignByCryptoAPIButtonClick
    ExplicitTop = 576
  end
  object OpenDialog1: TOpenDialog
    Left = 496
    Top = 24
  end
  object SaveDialog1: TSaveDialog
    Left = 496
    Top = 72
  end
end
