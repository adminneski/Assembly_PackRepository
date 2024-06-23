 -- "1146" Criando campo [FAT_ID_OLD] pra receber IDs do campo [FAT_ID] PARA GUARDAR OS IDs ANTIGOS 
 IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS 
 WHERE COLUMNS.TABLE_NAME = 'RFC_00_02'
 AND COLUMNS.COLUMN_NAME = 'FAT_ID_OLD')
 BEGIN 
 ALTER TABLE dbo.RFC_00_02
 ADD FAT_ID_OLD int NULL 
 END; 
 GO 
  
 -- "Lin2122" Guarda [FAT_ID] de rela��o com  [FAT_ID_OLD] 
 UPDATE RFC_00_02
 SET    FAT_ID_OLD = FAT_ID
 WHERE  FAT_ID_OLD IS NULL 
 GO 

   -- Atualiza novos ids da m�e [FAT_00] campo [FAT_ID], na table filha [RFC_00_02] campo [FAT_ID]
 UPDATE RFC_00_02 -- FILHA
 SET RFC_00_02.FAT_ID = T2.FAT_ID -- FILHA  RECEBE DA M�E
 FROM RFC_00_02 -- FILHA
 INNER JOIN FAT_00 T2 ON (RFC_00_02.FAT_ID_OLD = T2.FAT_ID_OLD)
 AND (RFC_00_02.COM_CODIGO    = T2.COM_CODIGO)  --RELACIONA FILHA COM MAE
 GO

 -- "1035" Criando campo [FAT_01_ID_OLD] pra receber IDs do campo [FAT_01_ID] PARA GUARDAR OS IDs ANTIGOS 
 IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS 
 WHERE COLUMNS.TABLE_NAME = 'RFC_00_02'
 AND COLUMNS.COLUMN_NAME = 'FAT_01_ID_OLD')
 BEGIN 
 ALTER TABLE dbo.RFC_00_02
 ADD FAT_01_ID_OLD int NULL 
 END; 
 GO 
  
 -- "Lin2122" Guarda [FAT_ID] de rela��o com  [FAT_01_ID_OLD] 
 UPDATE RFC_00_02
 SET    FAT_01_ID_OLD = FAT_01_ID
 WHERE  FAT_01_ID_OLD IS NULL 
 GO 
 
  -- Atualiza novos ids da m�e [FAT_00] campo [FAT_ID], na table filha [RFC_00_02] campo [FAT_ID]
 UPDATE RFC_00_02 -- FILHA
 SET RFC_00_02.FAT_01_ID = T2.FAT_01_ID -- FILHA  RECEBE DA M�E
 FROM RFC_00_02 -- FILHA
 INNER JOIN FAT_00_01 T2 ON (RFC_00_02.FAT_01_ID_OLD = T2.FAT_01_ID_OLD)
 AND (RFC_00_02.COM_CODIGO    = T2.COM_CODIGO)  --RELACIONA FILHA COM MAE
 GO