 -- Cria o SEQUENCE para o campo [REQ_01_ID] da table [REQ_00_01]
 IF NOT EXISTS( SELECT * FROM SYS.OBJECTS WHERE TYPE = 'SO'AND OBJECT_ID = OBJECT_ID(N'SEQ_REQ_01_ID'))
  CREATE SEQUENCE dbo.SEQ_REQ_01_ID
  AS int 
  START WITH 1
  NO MINVALUE 
  NO MAXVALUE 
  NO CYCLE 
  CACHE 
  GO

 -- "1035" Criando campo [REQ_01_ID_OLD] pra receber IDs do campo [REQ_01_ID] PARA GUARDAR OS IDs ANTIGOS 
 IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS 
 WHERE COLUMNS.TABLE_NAME = 'REQ_00_01'
 AND COLUMNS.COLUMN_NAME = 'REQ_01_ID_OLD')
 BEGIN 
 ALTER TABLE dbo.REQ_00_01
 ADD REQ_01_ID_OLD int NULL 
 END; 
 GO 
  
 -- "1146" Criando campo [REQ_ID_OLD] pra receber IDs do campo [REQ_ID] PARA GUARDAR OS IDs ANTIGOS 
 IF NOT EXISTS (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS 
 WHERE COLUMNS.TABLE_NAME = 'REQ_00_01'
 AND COLUMNS.COLUMN_NAME = 'REQ_ID_OLD')
 BEGIN 
 ALTER TABLE dbo.REQ_00_01
 ADD REQ_ID_OLD int NULL 
 END; 
 GO 
  
 -- "1267" Guarda [REQ_01_ID] de rela��o com o cabe�alho no novo [REQ_01_ID_OLD] bkp 
 UPDATE REQ_00_01
 SET    REQ_01_ID_OLD = REQ_01_ID,
 REQ_ID_OLD = REQ_ID
 WHERE  REQ_01_ID_OLD IS NULL 
 GO
 
 -- Executa o SEQ_REQ_01_ID pra gerar os novos IDs do campo [REQ_01_ID] 
 UPDATE REQ_00_01
 SET    REQ_01_ID = NEXT VALUE FOR SEQ_REQ_01_ID
 GO 
  
 -- Recria �ndice Primary Key da table  [REQ_01_ID] para o campo [REQ_01_ID] 
 IF EXISTS ( SELECT count(table_name) 
    FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE 
    WHERE table_name = 'REQ_00_01'
    HAVING COUNT(*) > 1 ) 
 BEGIN
 -- DESABILITA INDICE 
 ALTER INDEX ALL ON [REQ_00_01]
 DISABLE 
  
 -- VERIFICA SE EXISTE O INDICE E O APAGA 
 IF  EXISTS (SELECT * 
             FROM sys.indexes AS si 
             WHERE si.name = 'REQ_00_01_PK')
             ALTER TABLE dbo.REQ_00_01
             DROP CONSTRAINT REQ_00_01_pk 
  
 -- ALTERA A TABLE CRIANDO O INDICE 
 ALTER TABLE dbo.REQ_00_01
 ADD CONSTRAINT REQ_00_01_pk 
 PRIMARY KEY CLUSTERED (REQ_01_ID) 
 WITH ( 
   PAD_INDEX = OFF, 
   FILLFACTOR = 90, 
   IGNORE_DUP_KEY = OFF, 
   STATISTICS_NORECOMPUTE = OFF, 
   ALLOW_ROW_LOCKS = ON, 
   ALLOW_PAGE_LOCKS = ON) 
 ON [PRIMARY] 
  
 -- REABILITA INDICES 
 ALTER INDEX ALL ON [REQ_00_01] 
 REBUILD 
 END
 GO
  
-- Atualiza novos ids da m�e [REQ_00] campo [REQ_ID], na table filha [REQ_00_01] campo [REQ_01_ID]
 UPDATE REQ_00_01 -- FILHA
 SET REQ_00_01.REQ_ID = T2.REQ_ID -- FILHA  RECEBE DA M�E
 FROM REQ_00_01 -- FILHA
 INNER JOIN REQ_00 T2 ON (REQ_00_01.REQ_ID_OLD = T2.REQ_ID_OLD)
 AND (REQ_00_01.COM_CODIGO    = T2.COM_CODIGO)  --RELACIONA FILHA COM MAE
 GO