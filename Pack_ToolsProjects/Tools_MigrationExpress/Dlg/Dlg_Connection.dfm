object FrmConnection: TFrmConnection
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Conex'#227'o Origem / Destino'
  ClientHeight = 232
  ClientWidth = 594
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Consolas'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnKeyDown = FormKeyDown
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 594
    Height = 232
    Margins.Left = 0
    Margins.Top = 0
    Margins.Right = 0
    Margins.Bottom = 0
    Align = alClient
    BevelOuter = bvNone
    Color = 3026478
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 586
    ExplicitHeight = 231
    object Shape2: TShape
      Left = 296
      Top = 0
      Width = 2
      Height = 232
      Align = alClient
      Pen.Color = 2171169
      ExplicitWidth = 3
    end
    object Panel2: TPanel
      Left = 0
      Top = 0
      Width = 296
      Height = 232
      Margins.Left = 7
      Margins.Top = 7
      Margins.Right = 7
      Margins.Bottom = 7
      Align = alLeft
      BevelEdges = []
      BevelOuter = bvNone
      Padding.Left = 7
      Padding.Top = 7
      Padding.Right = 7
      Padding.Bottom = 7
      TabOrder = 0
      ExplicitHeight = 231
      object Label1: TLabel
        Left = 7
        Top = 7
        Width = 282
        Height = 25
        Align = alTop
        Alignment = taCenter
        Caption = 'Origem'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = 25
        Font.Name = 'Consolas'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 8
        ExplicitTop = 1
      end
      object Label3: TLabel
        Left = 7
        Top = 32
        Width = 282
        Height = 25
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'Servidor\Inst'#226'ncia:'
        Color = clBlack
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Consolas'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        ExplicitLeft = 8
        ExplicitTop = 33
        ExplicitWidth = 279
      end
      object Label6: TLabel
        Left = 7
        Top = 80
        Width = 282
        Height = 25
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'Senha:'
        Color = clBlack
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Consolas'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        ExplicitLeft = 8
        ExplicitTop = 81
        ExplicitWidth = 279
      end
      object Label15: TLabel
        Left = 7
        Top = 128
        Width = 282
        Height = 25
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'Database:'
        Color = clBlack
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Consolas'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        ExplicitLeft = 8
        ExplicitTop = 134
      end
      object edtInstanciaOrigem: TEdit
        Left = 7
        Top = 57
        Width = 282
        Height = 23
        Align = alTop
        Alignment = taCenter
        Color = 6115659
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Consolas'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        Text = '.\NESKI'
      end
      object edtSenhaOrigem: TEdit
        Left = 7
        Top = 105
        Width = 282
        Height = 23
        Align = alTop
        Alignment = taCenter
        Color = 6115659
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Consolas'
        Font.Style = []
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 1
        Text = 'Neski5500*'
      end
      object cbxDatabaseOrigem: TComboBox
        Left = 7
        Top = 153
        Width = 282
        Height = 23
        Align = alTop
        Style = csDropDownList
        Color = 6115659
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Consolas'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        ExplicitLeft = 13
        ExplicitTop = 182
      end
      object btnConectarOrigem: TGoButtonAdvanced
        Left = 7
        Top = 190
        Width = 282
        Height = 35
        Cursor = crHandPoint
        Align = alBottom
        BorderStyle = bsNone
        Caption = 'Conectar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Consolas'
        Font.Style = [fsBold]
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Picture.Data = {
          89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
          F80000000473424954080808087C0864880000000970485973000000B1000000
          B101C62D498D0000001974455874536F667477617265007777772E696E6B7363
          6170652E6F72679BEE3C1A000000FA494441544889E5D5314A034114C6F15F82
          A7B0B0B0F40C9EC003589926BDAD9EC042B0B2B213D442BC8682E24D0437A049
          9320C622BB302EBBC93393A0E007036FBE9979FF6166F70D7F4005A6785DE035
          AA13004C1BE637798DEA060059DA08CC390D7A3FD619C666C731AF8D71B20C60
          14485EB5F7B624F3EEE00293C04626386F1B5CF4151D070064DC49FD283E3168
          F097563DD125F6D60578C3269E57091826496E127F2BF187398027DF775A601B
          B789F79803E8D7000738AA79FD1C4017D749B2177C24FD2B2BA8671DF4706FF6
          778FCAB827508D23E5BAD23E76CBF801779145916A5A690787653C882E5AFB7B
          F0BF00454BFCBBFA021C43668A8B91B4200000000049454E44AE426082}
        ShowCaption = False
        TabOrder = 3
        OnClick = btnConectarOrigemClick
        Skin = tsCustom
        Appearance.BorderColor = 16024898
        Appearance.BorderColorHot = 10569485
        Appearance.BorderColorDown = clGray
        Appearance.BorderColorChecked = clBlack
        Appearance.BorderColorDisabled = 5359616
        Appearance.BorderColorFocused = clGray
        Appearance.Color = 16024898
        Appearance.ColorTo = 16024898
        Appearance.ColorChecked = 8418163
        Appearance.ColorCheckedTo = 8418163
        Appearance.ColorDisabled = 5359616
        Appearance.ColorDisabledTo = 5359616
        Appearance.ColorDown = 8418163
        Appearance.ColorDownTo = 8418163
        Appearance.ColorHot = 10569485
        Appearance.ColorHotTo = 10569485
        Appearance.ColorMirror = 16024898
        Appearance.ColorMirrorTo = 16024898
        Appearance.ColorMirrorHot = 10569485
        Appearance.ColorMirrorHotTo = 10569485
        Appearance.ColorMirrorDown = 8418163
        Appearance.ColorMirrorDownTo = 8418163
        Appearance.ColorMirrorChecked = 8418163
        Appearance.ColorMirrorCheckedTo = 8418163
        Appearance.ColorMirrorDisabled = 5359616
        Appearance.ColorMirrorDisabledTo = 5359616
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
        Appearance.GradientDisabled = ggVertical
        Appearance.GradientMirrorDisabled = ggVertical
        ExplicitLeft = 13
        ExplicitTop = 70
      end
    end
    object Panel3: TPanel
      Left = 298
      Top = 0
      Width = 296
      Height = 232
      Align = alRight
      BevelEdges = []
      BevelOuter = bvNone
      Padding.Left = 7
      Padding.Top = 7
      Padding.Right = 7
      Padding.Bottom = 7
      TabOrder = 1
      ExplicitLeft = 290
      ExplicitHeight = 231
      object Label2: TLabel
        Left = 7
        Top = 7
        Width = 282
        Height = 25
        Align = alTop
        Alignment = taCenter
        Caption = 'Destino'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = 25
        Font.Name = 'Consolas'
        Font.Style = []
        ParentFont = False
        ExplicitLeft = 11
      end
      object Label4: TLabel
        Left = 7
        Top = 32
        Width = 282
        Height = 25
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'Servidor\Inst'#226'ncia:'
        Color = clBlack
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Consolas'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        ExplicitLeft = 8
        ExplicitTop = 33
        ExplicitWidth = 283
      end
      object Label5: TLabel
        Left = 7
        Top = 80
        Width = 282
        Height = 25
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'Senha:'
        Color = clBlack
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Consolas'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        ExplicitLeft = 8
        ExplicitTop = 81
        ExplicitWidth = 283
      end
      object Label7: TLabel
        Left = 7
        Top = 128
        Width = 282
        Height = 25
        Align = alTop
        Alignment = taCenter
        AutoSize = False
        Caption = 'Database:'
        Color = clBlack
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Consolas'
        Font.Style = []
        ParentColor = False
        ParentFont = False
        ExplicitLeft = 8
        ExplicitTop = 129
        ExplicitWidth = 283
      end
      object edtInstanciaDestino: TEdit
        Left = 7
        Top = 57
        Width = 282
        Height = 23
        Align = alTop
        Alignment = taCenter
        Color = 6115659
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Consolas'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        Text = '.\SQLEXPRESS'
      end
      object edtSenhaDestino: TEdit
        Left = 7
        Top = 105
        Width = 282
        Height = 23
        Align = alTop
        Alignment = taCenter
        Color = 6115659
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Consolas'
        Font.Style = []
        ParentFont = False
        PasswordChar = '*'
        TabOrder = 1
        Text = 'Neski5500*'
      end
      object cbxDatabaseDestino: TComboBox
        Left = 7
        Top = 153
        Width = 282
        Height = 23
        Align = alTop
        Style = csDropDownList
        Color = 6115659
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Consolas'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object btnConectarDestino: TGoButtonAdvanced
        Left = 7
        Top = 190
        Width = 282
        Height = 35
        Cursor = crHandPoint
        Align = alBottom
        BorderStyle = bsNone
        Caption = 'Conectar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -16
        Font.Name = 'Consolas'
        Font.Style = [fsBold]
        NotesFont.Charset = DEFAULT_CHARSET
        NotesFont.Color = clWindowText
        NotesFont.Height = -11
        NotesFont.Name = 'Tahoma'
        NotesFont.Style = []
        ParentFont = False
        Picture.Data = {
          89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
          F80000000473424954080808087C0864880000000970485973000000B1000000
          B101C62D498D0000001974455874536F667477617265007777772E696E6B7363
          6170652E6F72679BEE3C1A000000FA494441544889E5D5314A034114C6F15F82
          A7B0B0B0F40C9EC003589926BDAD9EC042B0B2B213D442BC8682E24D0437A049
          9320C622BB302EBBC93393A0E007036FBE9979FF6166F70D7F4005A6785DE035
          AA13004C1BE637798DEA060059DA08CC390D7A3FD619C666C731AF8D71B20C60
          14485EB5F7B624F3EEE00293C04626386F1B5CF4151D070064DC49FD283E3168
          F097563DD125F6D60578C3269E57091826496E127F2BF187398027DF775A601B
          B789F79803E8D7000738AA79FD1C4017D749B2177C24FD2B2BA8671DF4706FF6
          778FCAB827508D23E5BAD23E76CBF801779145916A5A690787653C882E5AFB7B
          F0BF00454BFCBBFA021C43668A8B91B4200000000049454E44AE426082}
        ShowCaption = False
        TabOrder = 3
        OnClick = btnConectarDestinoClick
        Skin = tsCustom
        Appearance.BorderColor = 16024898
        Appearance.BorderColorHot = 10569485
        Appearance.BorderColorDown = clGray
        Appearance.BorderColorChecked = clBlack
        Appearance.BorderColorDisabled = 5359616
        Appearance.BorderColorFocused = clGray
        Appearance.Color = 16024898
        Appearance.ColorTo = 16024898
        Appearance.ColorChecked = 8418163
        Appearance.ColorCheckedTo = 8418163
        Appearance.ColorDisabled = 5359616
        Appearance.ColorDisabledTo = 5359616
        Appearance.ColorDown = 8418163
        Appearance.ColorDownTo = 8418163
        Appearance.ColorHot = 10569485
        Appearance.ColorHotTo = 10569485
        Appearance.ColorMirror = 16024898
        Appearance.ColorMirrorTo = 16024898
        Appearance.ColorMirrorHot = 10569485
        Appearance.ColorMirrorHotTo = 10569485
        Appearance.ColorMirrorDown = 8418163
        Appearance.ColorMirrorDownTo = 8418163
        Appearance.ColorMirrorChecked = 8418163
        Appearance.ColorMirrorCheckedTo = 8418163
        Appearance.ColorMirrorDisabled = 5359616
        Appearance.ColorMirrorDisabledTo = 5359616
        Appearance.GradientHot = ggVertical
        Appearance.GradientMirrorHot = ggVertical
        Appearance.GradientDown = ggVertical
        Appearance.GradientMirrorDown = ggVertical
        Appearance.GradientChecked = ggVertical
        Appearance.GradientDisabled = ggVertical
        Appearance.GradientMirrorDisabled = ggVertical
        ExplicitTop = 189
      end
    end
  end
end
