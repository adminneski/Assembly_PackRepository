object FrameLookup: TFrameLookup
  Left = 0
  Top = 0
  Width = 413
  Height = 26
  Color = clWindow
  ParentBackground = False
  ParentColor = False
  TabOrder = 0
  OnEnter = FrameEnter
  object Panel: TPanel
    Left = 0
    Top = 0
    Width = 413
    Height = 26
    Align = alClient
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWindow
    ParentBackground = False
    TabOrder = 0
    object GoButtonAdvanced: TGoButtonAdvanced
      Left = 81
      Top = 0
      Width = 45
      Height = 22
      Align = alLeft
      BorderStyle = bsNone
      Caption = 'F3'
      Font.Charset = ANSI_CHARSET
      Font.Color = 5263440
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      DisabledPicture.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        61000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
        00097048597300000B1300000B1301009A9C180000013D49444154384F95D24F
        2B44510086F119257C04454A59604B8A6CE5DF6636123B915096BE86C9424936
        42CA0760AB46AC6C647957948DB5EC789EE39EDBBDD365CC5BBFA6739BF39E73
        CFB9D524492A697AB083158CF8803CE31C87F8F4417362C100AE318CBB541553
        988445737841211D706527F762066B78C31E2C70621FFC4F170AB1C06DBBF212
        86708B41C4DC6019A3D8F6413EBEC223BF1F7065278FE315CDB94727C6C2288D
        3BF0C07CE7795CA16CB269201E6E160B8C0756C76E18B5110B3C610FAB55A6E1
        7F0BB1C07BF6AA667DF04B163081B330CAC5023F129B2F5156E2E40B3CE114BE
        6E96F821F5C37BF6AA1EE08119B7EDCA4E5E84E7F48E4D7C212B30DDD8C22AF2
        9FB2DB76E513D4608E114AF2057FC56D1F61238C7E124AE235B68ADB754527C5
        5856FF6F81292B596FA7C0C49203F0F957F6BF016F994B372C4F712E00000000
        49454E44AE426082}
      NotesFont.Charset = DEFAULT_CHARSET
      NotesFont.Color = clWindowText
      NotesFont.Height = -11
      NotesFont.Name = 'Tahoma'
      NotesFont.Style = []
      ParentFont = False
      Picture.Data = {
        89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
        610000000473424954080808087C086488000000097048597300000B1300000B
        1301009A9C18000000F949444154388DADD1314A43411485E12F41F0A54C6FB4
        4BE116C43210CC4E6CD49025D8A88DB1740B82AB8828185304750582A5B150EC
        9EC5BBA249DE44031EB80CDC39E79F3B337CAB861E46F888BA4317995FB48147
        E418E008C7B88ADE3D1AA9702DC22F68A189FD1FFB6D4C02B25A06E8C5292DEC
        E21967339E76780ECA00A318BB19E1B5C4A4D718CE36ABD854DC750717784A00
        06E19DD24AAC159C26820B55C503B6FEE0DD0EEF9CBA8A076A2F0877C2B357B6
        9929BE68928074F08A31EA8AEBCEA911905CF1DA275137D11B631D97384F4132
        C53F0FF11E751B63D7239C47252129552294FB67487F194019E46D59C017A41F
        E1C34F7A8044FCEF4A21F70000000049454E44AE426082}
      Rounded = False
      TabOrder = 0
      Skin = tsOffice2016White
      Appearance.BorderColor = 13948116
      Appearance.BorderColorHot = 15917525
      Appearance.BorderColorCheckedHot = 14925219
      Appearance.BorderColorDown = 14925219
      Appearance.BorderColorChecked = 15914434
      Appearance.BorderColorDisabled = 13948116
      Appearance.BorderColorFocused = clGray
      Appearance.ColorTo = clNone
      Appearance.ColorChecked = 15914434
      Appearance.ColorCheckedTo = clNone
      Appearance.ColorDisabled = clWhite
      Appearance.ColorDisabledTo = clNone
      Appearance.ColorDown = 14925219
      Appearance.ColorDownTo = clNone
      Appearance.ColorHot = 15917525
      Appearance.ColorHotTo = clNone
      Appearance.ColorMirror = clWhite
      Appearance.ColorMirrorTo = clNone
      Appearance.ColorMirrorHot = 15917525
      Appearance.ColorMirrorHotTo = clNone
      Appearance.ColorMirrorDown = 14925219
      Appearance.ColorMirrorDownTo = clNone
      Appearance.ColorMirrorChecked = 15914434
      Appearance.ColorMirrorCheckedTo = clNone
      Appearance.ColorMirrorDisabled = clWhite
      Appearance.ColorMirrorDisabledTo = clNone
      Appearance.GradientHot = ggVertical
      Appearance.GradientMirrorHot = ggVertical
      Appearance.GradientDown = ggVertical
      Appearance.GradientMirrorDown = ggVertical
      Appearance.GradientChecked = ggVertical
      Appearance.GradientDisabled = ggVertical
      Appearance.GradientMirrorDisabled = ggVertical
      Appearance.TextColorChecked = 5263440
      Appearance.TextColorDown = 5263440
      Appearance.TextColorHot = 5263440
    end
    object Panel_DBLookupText: TPanel
      Left = 126
      Top = 0
      Width = 283
      Height = 22
      Align = alClient
      Alignment = taLeftJustify
      BevelOuter = bvNone
      Color = clSilver
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Padding.Left = 5
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      object DBLookupText: TDBText
        Left = 5
        Top = 0
        Width = 278
        Height = 22
        Align = alClient
        AutoSize = True
        Color = clSilver
        DataSource = DataSource_Lookup
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = False
        ExplicitWidth = 115
        ExplicitHeight = 19
      end
    end
    object FEditLookup: TEdit
      Left = 0
      Top = 0
      Width = 81
      Height = 22
      Align = alLeft
      BorderStyle = bsNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = []
      NumbersOnly = True
      ParentFont = False
      TabOrder = 2
      Text = 'FEditLookup'
      OnExit = FEditLookupExit
      OnKeyDown = FEditLookupKeyDown
    end
  end
  object DataSource_Lookup: TDataSource
    AutoEdit = False
    OnDataChange = DataSource_LookupDataChange
    Left = 382
    Top = 65535
  end
end
