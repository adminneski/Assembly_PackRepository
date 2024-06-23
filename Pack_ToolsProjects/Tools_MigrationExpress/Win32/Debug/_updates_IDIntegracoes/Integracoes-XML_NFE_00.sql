UPDATE XML_NFE_00 SET XML_INTEGRACAO = 'LFE'+CAST((SELECT LFE_ID FROM LFE_00 
WHERE 'LFE'+CAST(LFE_00.LFE_ID_OLD AS VARCHAR) = XML_NFE_00.XML_INTEGRACAO_OLD AND LFE_00.COM_CODIGO = XML_NFE_00.COM_CODIGO) AS VARCHAR) 
WHERE (XML_INTEGRACAO LIKE 'LFE%')
GO

UPDATE XML_NFE_00 SET XML_INTEGRACAO = 'LFS'+CAST((SELECT LFS_ID FROM LFS_00 
WHERE 'LFS'+CAST(LFS_00.LFS_ID_OLD AS VARCHAR) = XML_NFE_00.XML_INTEGRACAO_OLD AND LFS_00.COM_CODIGO = XML_NFE_00.COM_CODIGO) AS VARCHAR) 
WHERE (XML_INTEGRACAO LIKE 'LFS%')
GO