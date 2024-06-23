object frxReportDataForm: TfrxReportDataForm
  Left = 185
  Top = 107
  BorderIcons = []
  Caption = 'Select Report Datasets'
  ClientHeight = 272
  ClientWidth = 288
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnHide = FormHide
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DSPanel: TPanel
    Left = 0
    Top = 0
    Width = 288
    Height = 231
    Align = alClient
    BorderWidth = 2
    TabOrder = 0
    object DatasetsLB: TCheckListBox
      Left = 3
      Top = 3
      Width = 282
      Height = 225
      OnClickCheck = DatasetsLBClickCheck
      Align = alClient
      Columns = 1
      Style = lbOwnerDrawFixed
      TabOrder = 0
    end
  end
  object FooterPanel: TPanel
    Left = 0
    Top = 231
    Width = 288
    Height = 41
    Align = alBottom
    TabOrder = 1
    DesignSize = (
      288
      41)
    object SelAllCB: TCheckBox
      Left = 4
      Top = 13
      Width = 114
      Height = 17
      AllowGrayed = True
      Anchors = [akLeft, akBottom]
      Caption = 'SelAllCB'
      TabOrder = 0
      OnClick = SelAllCBClick
    end
    object OKB: TButton
      Left = 128
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'OK'
      ModalResult = 1
      TabOrder = 1
    end
    object CancelB: TButton
      Left = 208
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Cancel = True
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 2
    end
  end
end
