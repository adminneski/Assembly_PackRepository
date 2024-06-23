 -- "Lin2110" Criando campo [FAT_ID_OLD] pra receber IDs do campo [FAT_ID] PARA GUARDAR OS IDs ANTIGOS 
 IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS 
 WHERE COLUMNS.TABLE_NAME = 'LIB_00'
 AND COLUMNS.COLUMN_NAME = 'FAT_ID_OLD')
 BEGIN 
 ALTER TABLE dbo.LIB_00
 ADD FAT_ID_OLD int NULL 
 END; 
 GO 
  
 -- "Lin2122" Guarda [FAT_ID] de rela��o com  [FAT_ID_OLD] 
 UPDATE LIB_00
 SET    FAT_ID_OLD = FAT_ID
 WHERE  FAT_ID_OLD IS NULL 
 GO

 -- Atualiza novos ids tabela [FAT_00] campo [FAT_ID], na table filha [SCP_00_01] campo [CPA_ID] 
 UPDATE LIB_00 -- FILHA 
 SET LIB_00.FAT_ID = T2.FAT_ID -- FILHA  RECEBE DA M�E 
 FROM LIB_00 -- FILHA 
 INNER JOIN FAT_00 T2 ON (LIB_00.FAT_ID_OLD = T2.FAT_ID_OLD) 
 AND (LIB_00.COM_CODIGO    = T2.COM_CODIGO)  --RELACIONA FILHA COM MAE 
 GO