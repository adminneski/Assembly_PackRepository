object DtmMigrationExpress: TDtmMigrationExpress
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 529
  Width = 928
  object MSSQLDriverLink: TFDPhysMSSQLDriverLink
    Left = 97
    Top = 74
  end
  object FIL_00: TFDQuery
    AfterOpen = FIL_00AfterOpen
    FetchOptions.AssignedValues = [evRowsetSize]
    SQL.Strings = (
      'SELECT FIL_CODIGO'
      '       ,COM_CODIGO'
      '       ,FIL_CNPJ'
      '       ,FIL_RAZAO'
      '       ,FIL_FANTASIA_OU_APELIDO'
      '       ,FIL_IE'
      '       ,UFS_SIGLA'
      '       ,FIL_DESATIVADO'
      '       ,FIL_SELECIONADO'
      'FROM FIL_00')
    Left = 336
    Top = 16
    object FIL_00FIL_CODIGO: TStringField
      DisplayWidth = 15
      FieldName = 'FIL_CODIGO'
      Origin = 'FIL_CODIGO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 3
    end
    object FIL_00COM_CODIGO: TIntegerField
      DisplayWidth = 17
      FieldName = 'COM_CODIGO'
      Origin = 'COM_CODIGO'
    end
    object FIL_00FIL_CNPJ: TStringField
      DisplayWidth = 11
      FieldName = 'FIL_CNPJ'
      Origin = 'FIL_CNPJ'
      Required = True
      Size = 14
    end
    object FIL_00FIL_RAZAO: TStringField
      DisplayWidth = 13
      FieldName = 'FIL_RAZAO'
      Origin = 'FIL_RAZAO'
      Required = True
      Size = 50
    end
    object FIL_00FIL_FANTASIA_OU_APELIDO: TStringField
      DisplayWidth = 35
      FieldName = 'FIL_FANTASIA_OU_APELIDO'
      Origin = 'FIL_FANTASIA_OU_APELIDO'
      Size = 50
    end
    object FIL_00FIL_IE: TStringField
      DisplayWidth = 7
      FieldName = 'FIL_IE'
      Origin = 'FIL_IE'
      Required = True
      Size = 16
    end
    object FIL_00UFS_SIGLA: TStringField
      DisplayWidth = 13
      FieldName = 'UFS_SIGLA'
      Origin = 'UFS_SIGLA'
      Required = True
      Size = 2
    end
    object FIL_00FIL_DESATIVADO: TStringField
      DisplayWidth = 21
      FieldName = 'FIL_DESATIVADO'
      Origin = 'FIL_DESATIVADO'
      Required = True
      Size = 1
    end
    object FIL_00FIL_SELECIONADO: TStringField
      DisplayWidth = 22
      FieldName = 'FIL_SELECIONADO'
      Origin = 'FIL_SELECIONADO'
      Size = 1
    end
  end
  object dtsFIL_00: TDataSource
    DataSet = FIL_00
    Left = 408
    Top = 16
  end
  object TABLES: TFDQuery
    Left = 336
    Top = 88
  end
  object SQLCorrige: TFDQuery
    Left = 337
    Top = 160
  end
  object SQL_EXE: TFDQuery
    Left = 785
    Top = 400
  end
  object FDQueryDestino: TFDQuery
    FetchOptions.AssignedValues = [evMode, evRowsetSize]
    FetchOptions.Mode = fmAll
    FetchOptions.RowsetSize = -1
    Left = 185
    Top = 160
  end
  object FDQueryOrigem: TFDQuery
    FetchOptions.AssignedValues = [evMode, evRowsetSize]
    FetchOptions.Mode = fmAll
    FetchOptions.RowsetSize = -1
    Left = 41
    Top = 160
  end
end
