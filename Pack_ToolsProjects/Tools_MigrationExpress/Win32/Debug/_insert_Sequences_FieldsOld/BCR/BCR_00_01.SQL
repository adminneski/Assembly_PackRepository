 -- Cria o SEQUENCE para o campo [BCR_01_ID] da table [BCR_00_01]
 IF NOT EXISTS( SELECT * FROM SYS.OBJECTS WHERE TYPE = 'SO'AND OBJECT_ID = OBJECT_ID(N'SEQ_BCR_01_ID'))
  CREATE SEQUENCE dbo.SEQ_BCR_01_ID
  AS int 
  START WITH 1
  NO MINVALUE 
  NO MAXVALUE 
  NO CYCLE 
  CACHE 
  GO 
  
  
 -- Criando campo [BCR_ID_OLD] pra receber IDs do campo [BCR_ID] PARA GUARDAR OS IDs ANTIGOS 
 IF not EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS 
 WHERE COLUMNS.TABLE_NAME = 'BCR_00_01'
 AND COLUMNS.COLUMN_NAME = 'BCR_ID_OLD')
 BEGIN 
 ALTER TABLE dbo.BCR_00_01
 ADD BCR_ID_OLD int NULL 
 END 
 GO 


 -- Criando campo [BCR_ID_OLD] pra receber IDs do campo [BCR_01_ID] PARA GUARDAR OS IDs ANTIGOS 
 IF not EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS 
 WHERE COLUMNS.TABLE_NAME = 'BCR_00_01'
 AND COLUMNS.COLUMN_NAME = 'BCR_01_ID_OLD')
 BEGIN 
 ALTER TABLE dbo.BCR_00_01
 ADD BCR_01_ID_OLD int NULL 
 END 
 GO 
  
 -- Guarda [BCR_01_ID] de rela��o com o cabe�alho no novo [BCR_01_ID_OLD] bkp 
 UPDATE BCR_00_01
 SET    BCR_01_ID_OLD = BCR_01_ID
 WHERE  BCR_01_ID_OLD IS NULL 
 GO 
  
 -- Guarda [BCR_ID] de rela��o com o cabe�alho no novo [BCR_ID_OLD] bkp 
 UPDATE BCR_00_01
 SET    BCR_ID_OLD = BCR_ID
 WHERE  BCR_ID_OLD IS NULL 
 GO 
  
 -- Executa o SEQ_BCR_01_ID pra gerar os novos IDs do campo [BCR_01_ID] 
 UPDATE BCR_00_01
 SET    BCR_01_ID = NEXT VALUE FOR SEQ_BCR_01_ID
 GO 
  
 -- Recria �ndice Primary Key da table  [BCR_01_ID] para o campo [BCR_01_ID] 
 IF EXISTS ( SELECT count(table_name) 
    FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
    WHERE table_name = 'BCR_00_01'
    HAVING COUNT(*) > 1 ) 
 BEGIN
 -- DESABILITA INDICE 
 ALTER INDEX ALL ON [BCR_00_01]
 DISABLE 
  
 -- VERIFICA SE EXISTE O INDICE E O APAGA 
 IF  EXISTS (SELECT * 
             FROM sys.indexes AS si 
             WHERE si.name = 'BCR_00_01_PK')
             ALTER TABLE dbo.BCR_00_01
             DROP CONSTRAINT BCR_00_01_pk 
  
 -- ALTERA A TABLE CRIANDO O INDICE 
 ALTER TABLE dbo.BCR_00_01
 ADD CONSTRAINT BCR_00_01_pk 
 PRIMARY KEY CLUSTERED (BCR_01_ID) 
 WITH ( 
   PAD_INDEX = OFF, 
   FILLFACTOR = 90, 
   IGNORE_DUP_KEY = OFF, 
   STATISTICS_NORECOMPUTE = OFF, 
   ALLOW_ROW_LOCKS = ON, 
   ALLOW_PAGE_LOCKS = ON) 
 ON [PRIMARY] 
  
 -- REABILITA INDICES 
 ALTER INDEX ALL ON [BCR_00_01] 
 REBUILD 
 END
 GO 
 
-- Atualiza novos ids da m�e [BCR_00] campo [BCR_ID], na table filha [BCR_00_01] campo [BCR_01_ID]
 UPDATE BCR_00_01 -- FILHA
 SET BCR_00_01.BCR_ID = T2.BCR_ID -- FILHA  RECEBE DA M�E
 FROM BCR_00_01 -- FILHA
 INNER JOIN BCR_00 T2 ON (BCR_00_01.BCR_ID_OLD = T2.BCR_ID_OLD)
 AND (BCR_00_01.COM_CODIGO    = T2.COM_CODIGO)  --RELACIONA FILHA COM MAE
 GO 
  
