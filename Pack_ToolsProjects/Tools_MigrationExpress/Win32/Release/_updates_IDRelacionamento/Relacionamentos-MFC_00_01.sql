 -- "Lin2110" Criando campo [CTR_ID_OLD] pra receber IDs do campo [CTR_ID] PARA GUARDAR OS IDs ANTIGOS 
 IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS 
 WHERE COLUMNS.TABLE_NAME = 'MFC_00_01'
 AND COLUMNS.COLUMN_NAME = 'CTR_ID_OLD')
 BEGIN 
 ALTER TABLE dbo.MFC_00_01
 ADD CTR_ID_OLD int NULL 
 END; 
 GO 
  
 -- "Lin2122" Guarda [CTR_ID] de rela��o com  [CTR_ID_OLD] 
 UPDATE MFC_00_01
 SET    CTR_ID_OLD = CTR_ID
 WHERE  CTR_ID_OLD IS NULL 
 GO

 -- Atualiza novos ids tabela [CTR_00] campo [CTR_ID], na table filha [SCP_00_01] campo [CPA_ID] 
 UPDATE MFC_00_01 -- FILHA 
 SET MFC_00_01.CTR_ID = T2.CTR_ID -- FILHA  RECEBE DA M�E 
 FROM MFC_00_01 -- FILHA 
 INNER JOIN CTR_00 T2 ON (MFC_00_01.CTR_ID_OLD = T2.CTR_ID_OLD) 
 AND (MFC_00_01.COM_CODIGO    = T2.COM_CODIGO)  --RELACIONA FILHA COM MAE 
 GO