UPDATE GNRE_00 SET GNRE_INTEGRACAO = 'FAT'+CAST((SELECT FAT_ID FROM FAT_00 
WHERE 'FAT'+CAST(FAT_00.FAT_ID_OLD AS VARCHAR) = GNRE_00.GNRE_INTEGRACAO_OLD AND FAT_00.COM_CODIGO = GNRE_00.COM_CODIGO) AS VARCHAR) 
WHERE (GNRE_INTEGRACAO LIKE 'FAT%')
GO