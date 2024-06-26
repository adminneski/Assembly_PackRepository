 -- Cria o SEQUENCE para o campo [DRQ_ID] da table [DRQ_00]
 IF NOT EXISTS( SELECT * FROM SYS.OBJECTS WHERE TYPE = 'SO'AND OBJECT_ID = OBJECT_ID(N'SEQ_DRQ_ID'))
  CREATE SEQUENCE dbo.SEQ_DRQ_ID
  AS int 
  START WITH 1
  NO MINVALUE 
  NO MAXVALUE 
  NO CYCLE 
  CACHE 
  GO 
  

 -- Criando campo [DRQ_ID_OLD] pra receber IDs do campo [DRQ_ID] PARA GUARDAR OS IDs ANTIGOS 
 IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS 
 WHERE COLUMNS.TABLE_NAME = 'DRQ_00'
 AND COLUMNS.COLUMN_NAME = 'DRQ_ID_OLD')
 BEGIN 
 ALTER TABLE dbo.DRQ_00
 ADD DRQ_ID_OLD int NULL 
 END 
 GO 
  
 -- Guarda [DRQ_ID] de rela��o com o cabe�alho no novo [DRQ_ID_OLD] bkp 
 UPDATE DRQ_00
 SET    DRQ_ID_OLD = DRQ_ID
 WHERE  DRQ_ID_OLD IS NULL 
 GO 
  
 -- Executa o SEQ_DRQ_ID pra gerar os novos IDs do campo [DRQ_ID] 
 UPDATE DRQ_00
 SET    DRQ_ID = NEXT VALUE FOR SEQ_DRQ_ID
 GO 
  
 -- Recria �ndice Primary Key da table  [DRQ_ID] para o campo [DRQ_ID] 
 IF EXISTS ( SELECT count(table_name) 
    FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
    WHERE table_name = 'DRQ_00'
    HAVING COUNT(*) > 1 ) 
 BEGIN
 -- DESABILITA INDICE 
 ALTER INDEX ALL ON [DRQ_00]
 DISABLE 
  
 -- VERIFICA SE EXISTE O INDICE E O APAGA 
 IF  EXISTS (SELECT * 
             FROM sys.indexes AS si 
             WHERE si.name = 'DRQ_00_PK')
             ALTER TABLE dbo.DRQ_00
             DROP CONSTRAINT DRQ_00_pk 
  
 -- ALTERA A TABLE CRIANDO O INDICE 
 ALTER TABLE dbo.DRQ_00
 ADD CONSTRAINT DRQ_00_pk 
 PRIMARY KEY CLUSTERED (DRQ_ID) 
 WITH ( 
   PAD_INDEX = OFF, 
   FILLFACTOR = 90, 
   IGNORE_DUP_KEY = OFF, 
   STATISTICS_NORECOMPUTE = OFF, 
   ALLOW_ROW_LOCKS = ON, 
   ALLOW_PAGE_LOCKS = ON) 
 ON [PRIMARY] 
  
 -- REABILITA INDICES 
 ALTER INDEX ALL ON [DRQ_00] 
 REBUILD 
 END
 GO
  
