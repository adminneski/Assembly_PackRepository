 -- "Lin2110" Criando campo [CPA_ID_OLD] pra receber IDs do campo [CPA_ID] PARA GUARDAR OS IDs ANTIGOS 
 IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS 
 WHERE COLUMNS.TABLE_NAME = 'MTL_00_01'
 AND COLUMNS.COLUMN_NAME = 'CPA_ID_OLD')
 BEGIN 
 ALTER TABLE dbo.MTL_00_01
 ADD CPA_ID_OLD int NULL 
 END; 
 GO 
  
 -- "Lin2122" Guarda [CPA_ID] de rela��o com  [CPA_ID_OLD] 
 UPDATE MTL_00_01
 SET    CPA_ID_OLD = CPA_ID
 WHERE  CPA_ID_OLD IS NULL 
 GO
 
 -- Atualiza novos ids tabela [CPA_00] campo [CPA_ID], na table filha [SCP_00_01] campo [CPA_ID] 
 UPDATE MTL_00_01 -- FILHA 
 SET MTL_00_01.CPA_ID = T2.CPA_ID -- FILHA  RECEBE DA M�E 
 FROM MTL_00_01 -- FILHA 
 INNER JOIN CPA_00 T2 ON (MTL_00_01.CPA_ID_OLD = T2.CPA_ID_OLD) 
 AND (MTL_00_01.COM_CODIGO    = T2.COM_CODIGO)  --RELACIONA FILHA COM MAE 
 GO