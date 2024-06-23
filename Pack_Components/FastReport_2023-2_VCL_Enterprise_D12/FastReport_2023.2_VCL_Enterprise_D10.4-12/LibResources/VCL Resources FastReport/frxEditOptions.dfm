object frxOptionsEditor: TfrxOptionsEditor
  Left = 403
  Top = 122
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Designer Options'
  ClientHeight = 666
  ClientWidth = 373
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
  object OkB: TButton
    Left = 212
    Top = 636
    Width = 75
    Height = 24
    Caption = 'OK'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object CancelB: TButton
    Left = 292
    Top = 636
    Width = 75
    Height = 24
    Cancel = True
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object RestoreDefaultsB: TButton
    Left = 8
    Top = 636
    Width = 137
    Height = 24
    Caption = 'Restore defaults'
    TabOrder = 2
    OnClick = RestoreDefaultsBClick
  end
  object Label1: TGroupBox
    Left = 4
    Top = 4
    Width = 365
    Height = 137
    Caption = 'Grid'
    TabOrder = 3
    object Label2: TLabel
      Left = 8
      Top = 16
      Width = 24
      Height = 13
      Caption = 'Type'
    end
    object Label3: TLabel
      Left = 128
      Top = 16
      Width = 19
      Height = 13
      Caption = 'Size'
    end
    object Label4: TLabel
      Left = 26
      Top = 110
      Width = 54
      Height = 13
      Caption = 'Dialog form'
    end
    object Label13: TLabel
      Left = 168
      Top = 40
      Width = 13
      Height = 13
      Caption = 'cm'
    end
    object Label14: TLabel
      Left = 168
      Top = 64
      Width = 8
      Height = 13
      Caption = 'in'
    end
    object Label15: TLabel
      Left = 168
      Top = 88
      Width = 10
      Height = 13
      Caption = 'pt'
    end
    object Label16: TLabel
      Left = 168
      Top = 112
      Width = 10
      Height = 13
      Caption = 'pt'
    end
    object CMRB: TRadioButton
      Left = 8
      Top = 36
      Width = 109
      Height = 17
      Caption = 'Centimeters'
      TabOrder = 0
    end
    object InchesRB: TRadioButton
      Left = 8
      Top = 60
      Width = 109
      Height = 17
      Caption = 'Inches'
      TabOrder = 1
    end
    object PixelsRB: TRadioButton
      Left = 8
      Top = 84
      Width = 109
      Height = 17
      Caption = 'Pixels'
      TabOrder = 2
    end
    object CME: TEdit
      Left = 128
      Top = 34
      Width = 37
      Height = 21
      AutoSize = False
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 3
    end
    object InchesE: TEdit
      Left = 128
      Top = 58
      Width = 37
      Height = 21
      AutoSize = False
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 4
    end
    object PixelsE: TEdit
      Left = 128
      Top = 82
      Width = 37
      Height = 21
      AutoSize = False
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 5
    end
    object DialogFormE: TEdit
      Left = 128
      Top = 106
      Width = 37
      Height = 21
      AutoSize = False
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 6
    end
    object ShowGridCB: TCheckBox
      Left = 196
      Top = 36
      Width = 157
      Height = 17
      Caption = 'Show grid'
      Ctl3D = True
      ParentCtl3D = False
      TabOrder = 7
    end
    object AlignGridCB: TCheckBox
      Left = 196
      Top = 56
      Width = 157
      Height = 17
      Caption = 'Align to grid'
      TabOrder = 8
    end
    object GuidesStickCB: TCheckBox
      Left = 196
      Top = 76
      Width = 165
      Height = 17
      Caption = 'Stick to guides'
      TabOrder = 9
    end
    object GuidesAsAnchorCB: TCheckBox
      Left = 196
      Top = 97
      Width = 165
      Height = 17
      Caption = 'Use guides as anchor'
      TabOrder = 10
    end
  end
  object Label6: TGroupBox
    Left = 4
    Top = 144
    Width = 365
    Height = 93
    Caption = 'Fonts'
    TabOrder = 4
    object Label7: TLabel
      Left = 8
      Top = 20
      Width = 64
      Height = 13
      Caption = 'Code window'
    end
    object Label8: TLabel
      Left = 8
      Top = 48
      Width = 59
      Height = 13
      Caption = 'Memo editor'
    end
    object Label9: TLabel
      Left = 260
      Top = 20
      Width = 19
      Height = 13
      Alignment = taRightJustify
      Caption = 'Size'
    end
    object Label10: TLabel
      Left = 260
      Top = 48
      Width = 19
      Height = 13
      Alignment = taRightJustify
      Caption = 'Size'
    end
    object CodeWindowFontCB: TComboBox
      Left = 112
      Top = 18
      Width = 121
      Height = 21
      DropDownCount = 12
      ItemHeight = 13
      TabOrder = 0
    end
    object CodeWindowSizeCB: TComboBox
      Left = 288
      Top = 18
      Width = 44
      Height = 21
      ItemHeight = 13
      TabOrder = 1
      Items.Strings = (
        '8'
        '9'
        '10'
        '11'
        '12'
        '14')
    end
    object MemoEditorFontCB: TComboBox
      Left = 112
      Top = 46
      Width = 121
      Height = 21
      DropDownCount = 12
      ItemHeight = 13
      TabOrder = 2
    end
    object MemoEditorSizeCB: TComboBox
      Left = 288
      Top = 46
      Width = 44
      Height = 21
      ItemHeight = 13
      TabOrder = 3
      Items.Strings = (
        '8'
        '9'
        '10'
        '11'
        '12'
        '14')
    end
    object ObjectFontCB: TCheckBox
      Left = 112
      Top = 68
      Width = 189
      Height = 17
      Caption = 'Use object'#39's font settings'
      TabOrder = 4
    end
  end
  object Label11: TGroupBox
    Left = 4
    Top = 240
    Width = 365
    Height = 121
    Caption = 'Colors'
    TabOrder = 5
    object WorkspacePB: TPaintBox
      Left = 168
      Top = 20
      Width = 185
      Height = 21
      OnPaint = WorkspacePBPaint
    end
    object ToolPB: TPaintBox
      Left = 168
      Top = 44
      Width = 185
      Height = 21
      OnPaint = ToolPBPaint
    end
    object IntersectionsPB: TPaintBox
      Left = 168
      Top = 68
      Width = 185
      Height = 21
      OnPaint = IntersectionsPBPaint
    end
    object WorkspaceB: TButton
      Left = 8
      Top = 20
      Width = 145
      Height = 21
      Caption = 'Workspace'
      TabOrder = 0
      OnClick = WorkspaceBClick
    end
    object ToolB: TButton
      Left = 8
      Top = 44
      Width = 145
      Height = 21
      Caption = 'Tool windows'
      TabOrder = 1
      OnClick = ToolBClick
    end
    object LCDCB: TCheckBox
      Left = 8
      Top = 96
      Width = 213
      Height = 17
      Caption = 'LCD grid color'
      TabOrder = 2
    end
    object IntersectionsB: TButton
      Left = 8
      Top = 68
      Width = 145
      Height = 21
      Caption = 'Intersections'
      TabOrder = 3
      OnClick = IntersectionsBClick
    end
  end
  object Label5: TGroupBox
    Left = 4
    Top = 456
    Width = 365
    Height = 173
    Caption = 'Other'
    TabOrder = 6
    object Label12: TLabel
      Left = 8
      Top = 124
      Width = 100
      Height = 13
      Caption = 'Gap between bands:'
    end
    object Label17: TLabel
      Left = 220
      Top = 124
      Width = 10
      Height = 13
      Caption = 'pt'
    end
    object LGuidAcc: TLabel
      Left = 8
      Top = 148
      Width = 106
      Height = 13
      Caption = 'Guides stick accuracy:'
    end
    object Label20: TLabel
      Left = 220
      Top = 148
      Width = 10
      Height = 13
      Caption = 'pt'
    end
    object EditAfterInsCB: TCheckBox
      Left = 8
      Top = 20
      Width = 293
      Height = 17
      Caption = 'Show editor after insert'
      TabOrder = 0
    end
    object FreeBandsCB: TCheckBox
      Left = 8
      Top = 60
      Width = 293
      Height = 17
      Caption = 'Free bands placement'
      TabOrder = 2
    end
    object GapE: TEdit
      Left = 180
      Top = 120
      Width = 37
      Height = 21
      TabOrder = 4
    end
    object BandsCaptionsCB: TCheckBox
      Left = 8
      Top = 40
      Width = 293
      Height = 17
      Caption = 'Show band'#39's captions'
      TabOrder = 1
    end
    object StartupCB: TCheckBox
      Left = 8
      Top = 100
      Width = 293
      Height = 17
      Caption = 'Show startup screen'
      TabOrder = 3
    end
    object EGuidAcc: TEdit
      Left = 180
      Top = 144
      Width = 37
      Height = 21
      TabOrder = 5
    end
    object EnableWorkspaceHints: TCheckBox
      Left = 8
      Top = 80
      Width = 293
      Height = 17
      Caption = 'Enable workspace hints'
      TabOrder = 6
    end
  end
  object CCGB: TGroupBox
    Left = 5
    Top = 364
    Width = 364
    Height = 85
    Caption = 'Code complition and  Syntax memo'
    TabOrder = 7
    object Label18: TLabel
      Left = 224
      Top = 16
      Width = 51
      Height = 13
      Caption = 'Tab stops:'
    end
    object ShowScriptVARCB: TCheckBox
      Left = 8
      Top = 16
      Width = 215
      Height = 17
      Caption = 'Show script variables'
      TabOrder = 0
    end
    object ShowADDVARCB: TCheckBox
      Left = 8
      Top = 32
      Width = 215
      Height = 17
      Caption = 'Show report objects'
      TabOrder = 1
    end
    object ShowRttiVARCB: TCheckBox
      Left = 8
      Top = 48
      Width = 215
      Height = 17
      Caption = 'Show Rtti variables'
      TabOrder = 2
    end
    object TBE: TEdit
      Left = 292
      Top = 13
      Width = 37
      Height = 21
      TabOrder = 3
    end
    object MultiBCB: TCheckBox
      Left = 224
      Top = 48
      Width = 129
      Height = 17
      Caption = 'MultiByte support'
      TabOrder = 4
    end
    object EnableCodeWindowHint: TCheckBox
      Left = 8
      Top = 64
      Width = 215
      Height = 17
      Caption = 'Enable code window hints'
      TabOrder = 5
    end
  end
  object ColorDialog: TColorDialog
    Options = [cdFullOpen]
    Left = 168
    Top = 296
  end
end
