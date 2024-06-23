object frxSignatureEditorForm: TfrxSignatureEditorForm
  Tag = 6720
  Left = 309
  Top = 237
  BorderStyle = bsDialog
  Caption = 'Signature Editor'
  ClientHeight = 483
  ClientWidth = 809
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    809
    483)
  PixelsPerInch = 96
  TextHeight = 13
  object SignatureGroupBox: TGroupBox
    Tag = 6721
    Left = 272
    Top = 8
    Width = 530
    Height = 436
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Signature'
    TabOrder = 0
    object SamplePaintBox: TPaintBox
      Left = 2
      Top = 15
      Width = 526
      Height = 419
      Align = alClient
      OnPaint = SamplePaintBoxPaint
    end
  end
  object OkButton: TButton
    Tag = 1
    Left = 647
    Top = 450
    Width = 74
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 1
  end
  object CancelButton: TButton
    Tag = 2
    Left = 727
    Top = 450
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
  object OptionsPageControl: TPageControl
    Left = 8
    Top = 8
    Width = 249
    Height = 468
    ActivePage = GeneralTabSheet
    TabOrder = 3
    object GeneralTabSheet: TTabSheet
      Tag = 6740
      Caption = 'General'
      DesignSize = (
        241
        440)
      object KeepAspectCheckBox: TCheckBox
        Tag = 6741
        Left = 12
        Top = 12
        Width = 204
        Height = 17
        Caption = 'Keep Aspect Ratio'
        TabOrder = 0
        OnClick = KeepAspectCheckBoxClick
      end
      object FillButton: TButton
        Tag = 6743
        Left = 12
        Top = 68
        Width = 80
        Height = 20
        Caption = 'Fill...'
        TabOrder = 1
        OnClick = FillButtonClick
      end
      object FrameButton: TButton
        Tag = 6744
        Left = 12
        Top = 94
        Width = 80
        Height = 21
        Caption = 'Frame...'
        TabOrder = 2
        OnClick = FrameButtonClick
      end
      object CustomizableCheckBox: TCheckBox
        Tag = 6742
        Left = 12
        Top = 40
        Width = 204
        Height = 17
        Caption = 'Customizable'
        TabOrder = 3
        OnClick = CustomizableCheckBoxClick
      end
      object ImportPictureButton: TButton
        Tag = 6726
        Left = -99
        Top = 120
        Width = 80
        Height = 20
        Anchors = [akTop, akRight]
        Caption = 'Import...'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = ImportPictureButtonClick
      end
    end
    object CustomizableTabSheet: TTabSheet
      Tag = 6745
      Caption = 'Customizable'
      ImageIndex = 1
      object ConfigureGraphicGroupBox: TGroupBox
        Tag = 6722
        Left = 12
        Top = 2
        Width = 221
        Height = 119
        Caption = 'Configure Graphic'
        TabOrder = 0
        object gtImportedRadioButton: TRadioButton
          Tag = 6724
          Left = 8
          Top = 47
          Width = 180
          Height = 17
          Caption = 'Imported graphic'
          TabOrder = 0
          OnClick = ConfigureGraphicRadioButtonClick
        end
        object gtNameRadioButton: TRadioButton
          Tag = 6725
          Left = 8
          Top = 70
          Width = 180
          Height = 17
          Caption = 'Name'
          TabOrder = 1
          OnClick = ConfigureGraphicRadioButtonClick
        end
        object ImpotrGraphicButton: TButton
          Left = 188
          Top = 45
          Width = 20
          Height = 20
          Caption = '...'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = ImpotrGraphicButtonClick
        end
        object gtNoRadioButton: TRadioButton
          Tag = 6723
          Left = 8
          Top = 24
          Width = 180
          Height = 17
          Caption = 'No graphic'
          TabOrder = 3
          OnClick = ConfigureGraphicRadioButtonClick
        end
      end
      object ConfigureTextGroupBox: TGroupBox
        Tag = 6735
        Left = 12
        Top = 127
        Width = 221
        Height = 218
        Caption = 'Configure Text'
        TabOrder = 1
        object ImportLogoButton: TButton
          Left = 188
          Top = 92
          Width = 20
          Height = 20
          Caption = '...'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = ImportLogoButtonClick
        end
        object NameCheckBox: TCheckBox
          Tag = 6727
          Left = 8
          Top = 24
          Width = 180
          Height = 17
          Caption = 'Name'
          Checked = True
          State = cbChecked
          TabOrder = 1
          OnClick = CheckBoxClick
        end
        object LocationCheckBox: TCheckBox
          Tag = 6728
          Left = 8
          Top = 47
          Width = 180
          Height = 17
          Caption = 'Location'
          Checked = True
          State = cbChecked
          TabOrder = 2
          OnClick = CheckBoxClick
        end
        object DistinguishedNameCheckBox: TCheckBox
          Tag = 6729
          Left = 8
          Top = 70
          Width = 180
          Height = 17
          Caption = 'Distinguished Name'
          Checked = True
          State = cbChecked
          TabOrder = 3
          OnClick = CheckBoxClick
        end
        object LogoCheckBox: TCheckBox
          Tag = 6730
          Left = 8
          Top = 93
          Width = 180
          Height = 17
          Caption = 'Logo'
          Checked = True
          State = cbChecked
          TabOrder = 4
          OnClick = CheckBoxClick
        end
        object DateCheckBox: TCheckBox
          Tag = 6731
          Left = 8
          Top = 116
          Width = 180
          Height = 17
          Caption = 'Date'
          Checked = True
          State = cbChecked
          TabOrder = 5
          OnClick = CheckBoxClick
        end
        object ReasonCheckBox: TCheckBox
          Tag = 6732
          Left = 8
          Top = 139
          Width = 180
          Height = 17
          Caption = 'Reason'
          Checked = True
          State = cbChecked
          TabOrder = 6
          OnClick = CheckBoxClick
        end
        object ProgramVersionCheckBox: TCheckBox
          Tag = 6733
          Left = 8
          Top = 162
          Width = 180
          Height = 17
          Caption = 'Program Version'
          Checked = True
          State = cbChecked
          TabOrder = 7
          OnClick = CheckBoxClick
        end
        object LabelsCheckBox: TCheckBox
          Tag = 6734
          Left = 8
          Top = 185
          Width = 180
          Height = 17
          Caption = 'Labels'
          Checked = True
          State = cbChecked
          TabOrder = 8
          OnClick = CheckBoxClick
        end
      end
      object TextPropertyGroupBox: TGroupBox
        Tag = 6736
        Left = 12
        Top = 351
        Width = 221
        Height = 82
        Caption = 'Text Property'
        TabOrder = 2
        object RTLCheckBox: TCheckBox
          Tag = 6737
          Left = 8
          Top = 24
          Width = 128
          Height = 17
          Caption = 'Right to Left'
          Checked = True
          State = cbChecked
          TabOrder = 0
          OnClick = CheckBoxClick
        end
        object FontButton: TButton
          Tag = 6397
          Left = 8
          Top = 47
          Width = 200
          Height = 20
          Caption = 'Font...'
          TabOrder = 1
          OnClick = FontButtonClick
        end
      end
    end
  end
  object FontDialog: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Left = 172
    Top = 65524
  end
end
