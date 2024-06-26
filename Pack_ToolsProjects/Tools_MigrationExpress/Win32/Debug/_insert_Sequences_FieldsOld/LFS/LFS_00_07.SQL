 -- Cria o SEQUENCE para o campo [LFS_07_ID] da table [LFS_00_07]
 IF NOT EXISTS( SELECT * FROM SYS.OBJECTS WHERE TYPE = 'SO'AND OBJECT_ID = OBJECT_ID(N'SEQ_LFS_07_ID'))
  CREATE SEQUENCE dbo.SEQ_LFS_07_ID
  AS int 
  START WITH 1
  NO MINVALUE 
  NO MAXVALUE 
  NO CYCLE 
  CACHE 
  GO 
  
  
 -- Criando campo [LFS_07_ID_OLD] pra receber IDs do campo [LFS_07_ID] PARA GUARDAR OS IDs ANTIGOS 
 IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS 
 WHERE COLUMNS.TABLE_NAME = 'LFS_00_07'
 AND COLUMNS.COLUMN_NAME = 'LFS_07_ID_OLD')
 BEGIN 
 ALTER TABLE dbo.LFS_00_07
 ADD LFS_07_ID_OLD int NULL 
 END 
 GO 
  
 -- Criando campo [LFS_ID_OLD] pra receber IDs do campo [LFS_ID] PARA GUARDAR OS IDs ANTIGOS 
 IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS 
 WHERE COLUMNS.TABLE_NAME = 'LFS_00_07'
 AND COLUMNS.COLUMN_NAME = 'LFS_ID_OLD')
 BEGIN 
 ALTER TABLE dbo.LFS_00_07
 ADD LFS_ID_OLD int NULL 
 END 
 GO 
  
 -- Guarda [LFS_07_ID] de rela��o com o cabe�alho no novo [LFS_07_ID_OLD] bkp 
 UPDATE LFS_00_07
 SET    LFS_07_ID_OLD = LFS_07_ID
 WHERE  LFS_07_ID_OLD IS NULL 
 GO 
  
 -- Guarda [LFS_ID] de rela��o com o cabe�alho no novo [LFS_ID_OLD] bkp 
 UPDATE LFS_00_07
 SET    LFS_ID_OLD = LFS_ID
 WHERE  LFS_ID_OLD IS NULL 
 GO 
  
 -- Executa o SEQ_LFS_07_ID pra gerar os novos IDs do campo [LFS_07_ID] 
 UPDATE LFS_00_07
 SET    LFS_07_ID = NEXT VALUE FOR SEQ_LFS_07_ID
 GO 
  
 -- Recria �ndice Primary Key da table  [LFS_07_ID] para o campo [LFS_07_ID] 
 IF EXISTS ( SELECT count(table_name) 
    FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
    WHERE table_name = 'LFS_00_07'
    HAVING COUNT(*) > 1 ) 
 BEGIN
 -- DESABILITA INDICE 
 ALTER INDEX ALL ON [LFS_00_07]
 DISABLE 
  
 -- VERIFICA SE EXISTE O INDICE E O APAGA 
 IF  EXISTS (SELECT * 
             FROM sys.indexes AS si 
             WHERE si.name = 'LFS_00_07_PK')
             ALTER TABLE dbo.LFS_00_07
             DROP CONSTRAINT LFS_00_07_pk 
  
 -- ALTERA A TABLE CRIANDO O INDICE 
 ALTER TABLE dbo.LFS_00_07
 ADD CONSTRAINT LFS_00_07_pk 
 PRIMARY KEY CLUSTERED (LFS_07_ID) 
 WITH ( 
   PAD_INDEX = OFF, 
   FILLFACTOR = 90, 
   IGNORE_DUP_KEY = OFF, 
   STATISTICS_NORECOMPUTE = OFF, 
   ALLOW_ROW_LOCKS = ON, 
   ALLOW_PAGE_LOCKS = ON) 
 ON [PRIMARY] 
  
 -- REABILITA INDICES 
 ALTER INDEX ALL ON [LFS_00_07] 
 REBUILD 
 END
 GO
  
-- Atualiza novos ids da m�e [LFS_00] campo [LFS_ID], na table filha [LFS_00_07] campo [LFS_07_ID]
 UPDATE LFS_00_07 -- FILHA
 SET LFS_00_07.LFS_ID = T2.LFS_ID -- FILHA  RECEBE DA M�E
 FROM LFS_00_07 -- FILHA
 INNER JOIN LFS_00 T2 ON (LFS_00_07.LFS_ID_OLD = T2.LFS_ID_OLD)
 AND (LFS_00_07.COM_CODIGO    = T2.COM_CODIGO)  --RELACIONA FILHA COM MAE
 GO 
  
