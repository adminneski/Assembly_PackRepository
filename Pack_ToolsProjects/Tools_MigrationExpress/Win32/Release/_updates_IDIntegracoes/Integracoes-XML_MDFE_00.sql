UPDATE XML_MDFE_00 SET XML_INTEGRACAO = 'MFC'+CAST((SELECT MFC_ID FROM MFC_00 
WHERE 'MFC'+CAST(MFC_00.MFC_ID_OLD AS VARCHAR) = XML_MDFE_00.XML_INTEGRACAO_OLD AND MFC_00.COM_CODIGO = XML_MDFE_00.COM_CODIGO) AS VARCHAR) 
WHERE (XML_INTEGRACAO LIKE 'MFC%')
GO