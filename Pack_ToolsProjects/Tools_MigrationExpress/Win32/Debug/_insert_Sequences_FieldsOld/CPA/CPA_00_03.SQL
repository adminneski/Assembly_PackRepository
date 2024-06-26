 -- Cria o SEQUENCE para o campo [CPA_03_ID] da table [CPA_00_03]
 IF NOT EXISTS( SELECT * FROM SYS.OBJECTS WHERE TYPE = 'SO'AND OBJECT_ID = OBJECT_ID(N'SEQ_CPA_03_ID'))
  CREATE SEQUENCE dbo.SEQ_CPA_03_ID
  AS int 
  START WITH 1
  NO MINVALUE 
  NO MAXVALUE 
  NO CYCLE 
  CACHE 
  GO 
  
  
 -- Criando campo [CPA_03_ID_OLD] pra receber IDs do campo [CPA_03_ID] PARA GUARDAR OS IDs ANTIGOS 
 IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS 
 WHERE COLUMNS.TABLE_NAME = 'CPA_00_03'
 AND COLUMNS.COLUMN_NAME = 'CPA_03_ID_OLD')
 BEGIN 
 ALTER TABLE dbo.CPA_00_03
 ADD CPA_03_ID_OLD int NULL 
 END 
 GO 
  
 -- Criando campo [CPA_ID_OLD] pra receber IDs do campo [CPA_ID] PARA GUARDAR OS IDs ANTIGOS 
 IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS 
 WHERE COLUMNS.TABLE_NAME = 'CPA_00_03'
 AND COLUMNS.COLUMN_NAME = 'CPA_ID_OLD')
 BEGIN 
 ALTER TABLE dbo.CPA_00_03
 ADD CPA_ID_OLD int NULL 
 END 
 GO 
  
 -- Guarda [CPA_03_ID] de rela��o com o cabe�alho no novo [CPA_03_ID_OLD] bkp 
 UPDATE CPA_00_03
 SET    CPA_03_ID_OLD = CPA_03_ID
 WHERE  CPA_03_ID_OLD IS NULL 
 GO 
  
 -- Guarda [CPA_ID] de rela��o com o cabe�alho no novo [CPA_ID_OLD] bkp 
 UPDATE CPA_00_03
 SET    CPA_ID_OLD = CPA_ID
 WHERE  CPA_ID_OLD IS NULL 
 GO 
  
 -- Executa o SEQ_CPA_03_ID pra gerar os novos IDs do campo [CPA_03_ID] 
 UPDATE CPA_00_03
 SET    CPA_03_ID = NEXT VALUE FOR SEQ_CPA_03_ID
 GO 
  
 -- Recria �ndice Primary Key da table  [CPA_03_ID] para o campo [CPA_03_ID] 
 IF EXISTS ( SELECT count(table_name) 
    FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
    WHERE table_name = 'CPA_00_03'
    HAVING COUNT(*) > 1 ) 
 BEGIN
 -- DESABILITA INDICE 
 ALTER INDEX ALL ON [CPA_00_03]
 DISABLE 
  
 -- VERIFICA SE EXISTE O INDICE E O APAGA 
 IF  EXISTS (SELECT * 
             FROM sys.indexes AS si 
             WHERE si.name = 'CPA_00_03_PK')
             ALTER TABLE dbo.CPA_00_03
             DROP CONSTRAINT CPA_00_03_pk 
  
 -- ALTERA A TABLE CRIANDO O INDICE 
 ALTER TABLE dbo.CPA_00_03
 ADD CONSTRAINT CPA_00_03_pk 
 PRIMARY KEY CLUSTERED (CPA_03_ID) 
 WITH ( 
   PAD_INDEX = OFF, 
   FILLFACTOR = 90, 
   IGNORE_DUP_KEY = OFF, 
   STATISTICS_NORECOMPUTE = OFF, 
   ALLOW_ROW_LOCKS = ON, 
   ALLOW_PAGE_LOCKS = ON) 
 ON [PRIMARY] 
  
 -- REABILITA INDICES 
 ALTER INDEX ALL ON [CPA_00_03] 
 REBUILD 
 END
 GO
  
-- Atualiza novos ids da m�e [CPA_00] campo [CPA_ID], na table filha [CPA_00_03] campo [CPA_03_ID]
 UPDATE CPA_00_03 -- FILHA
 SET CPA_00_03.CPA_ID = T2.CPA_ID -- FILHA  RECEBE DA M�E
 FROM CPA_00_03 -- FILHA
 INNER JOIN CPA_00 T2 ON (CPA_00_03.CPA_ID_OLD = T2.CPA_ID_OLD)
 AND (CPA_00_03.COM_CODIGO    = T2.COM_CODIGO)  --RELACIONA FILHA COM MAE
 GO 
  
