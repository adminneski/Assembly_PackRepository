object frmFinalizado: TfrmFinalizado
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'frmFinalizado'
  ClientHeight = 380
  ClientWidth = 568
  Color = clNone
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 15
  object pnlConteudo: TPanel
    AlignWithMargins = True
    Left = 16
    Top = 15
    Width = 537
    Height = 345
    Margins.Left = 10
    Margins.Top = 10
    Margins.Right = 10
    Margins.Bottom = 10
    Color = 3026478
    ParentBackground = False
    TabOrder = 0
    object lblTitulo: TLabel
      Left = 32
      Top = 16
      Width = 465
      Height = 32
      Caption = 'Migra'#231#227'o Realizada com Sucesso!'
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clYellow
      Font.Height = -27
      Font.Name = 'Consolas'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object lblAtencao: TLabel
      Left = 183
      Top = 80
      Width = 126
      Height = 38
      Caption = 'Aten'#231#227'o'
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -33
      Font.Name = 'Consolas'
      Font.Style = [fsBold, fsUnderline]
      ParentColor = False
      ParentFont = False
    end
    object lblConteudo: TLabel
      Left = 16
      Top = 128
      Width = 39
      Height = 28
      Caption = '...'
      Color = clBlack
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clYellow
      Font.Height = -24
      Font.Name = 'Consolas'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
    object btnOK: TButton
      Left = 184
      Top = 288
      Width = 137
      Height = 41
      Cursor = crHandPoint
      Caption = 'OK'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Consolas'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btnOKClick
    end
  end
end
