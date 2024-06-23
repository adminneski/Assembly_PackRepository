UPDATE LFE_00 SET LFE_INTEGRACAO = 'DEV'+CAST((SELECT DEV_ID FROM DEV_00 
WHERE 'DEV'+CAST(DEV_00.DEV_ID_OLD AS VARCHAR) = LFE_00.LFE_INTEGRACAO_OLD AND DEV_00.COM_CODIGO = LFE_00.COM_CODIGO) AS VARCHAR) 
WHERE (LFE_INTEGRACAO LIKE 'DEV%')
GO

UPDATE LFE_00 SET LFE_INTEGRACAO = 'OMF'+CAST((SELECT OMF_ID FROM OMF_00 
WHERE 'OMF'+CAST(OMF_00.OMF_ID_OLD AS VARCHAR) = LFE_00.LFE_INTEGRACAO_OLD AND OMF_00.COM_CODIGO = LFE_00.COM_CODIGO) AS VARCHAR) 
WHERE (LFE_INTEGRACAO LIKE 'OMF%')
GO

UPDATE LFE_00 SET LFE_INTEGRACAO = 'NFE'+CAST((SELECT NFE_ID FROM NFE_00 
WHERE 'NFE'+CAST(NFE_00.NFE_ID_OLD AS VARCHAR) = LFE_00.LFE_INTEGRACAO_OLD AND NFE_00.COM_CODIGO = LFE_00.COM_CODIGO) AS VARCHAR) 
WHERE (LFE_INTEGRACAO LIKE 'NFE%')
GO