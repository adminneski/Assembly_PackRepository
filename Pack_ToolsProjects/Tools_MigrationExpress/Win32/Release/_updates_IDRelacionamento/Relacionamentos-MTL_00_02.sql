 -- "Lin2110" Criando campo [TLN_ID_OLD] pra receber IDs do campo [TLN_ID] PARA GUARDAR OS IDs ANTIGOS 
 IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS 
 WHERE COLUMNS.TABLE_NAME = 'MTL_00_02'
 AND COLUMNS.COLUMN_NAME = 'TLN_ID_OLD')
 BEGIN 
 ALTER TABLE dbo.MTL_00_02
 ADD TLN_ID_OLD int NULL 
 END; 
 GO 
  
 -- "Lin2122" Guarda [TLN_ID] de rela��o com  [TLN_ID_OLD] 
 UPDATE MTL_00_02
 SET    TLN_ID_OLD = TLN_ID
 WHERE  TLN_ID_OLD IS NULL 
 GO

 -- Atualiza novos ids tabela [TLN_00] campo [TLN_ID], na table filha [SCP_00_01] campo [CPA_ID] 
 UPDATE MTL_00_02 -- FILHA 
 SET MTL_00_02.TLN_ID = T2.TLN_ID -- FILHA  RECEBE DA M�E 
 FROM MTL_00_02 -- FILHA 
 INNER JOIN TLN_00 T2 ON (MTL_00_02.TLN_ID_OLD = T2.TLN_ID_OLD) 
 AND (MTL_00_02.COM_CODIGO    = T2.COM_CODIGO)  --RELACIONA FILHA COM MAE 
 GO
