UPDATE ORS_00 SET ORS_INTEGRACAO = 'ORS'+CAST((SELECT ORS_ID FROM ORS_00 T
WHERE 'ORS'+CAST(T.ORS_ID_OLD AS VARCHAR) = ORS_00.ORS_INTEGRACAO_OLD AND T.COM_CODIGO = ORS_00.COM_CODIGO) AS VARCHAR) 
WHERE (ORS_INTEGRACAO LIKE 'ORS%')
GO