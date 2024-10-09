-- fast_recovery_area (anciennement flash_recovery_area)
show parameters recovery;
-- result:
-- db_recovery_file_dest  = chemin ou NULL
-- db_recovery_file_dest_size = 8G ou 0 (désactivée)

show parameters control;
-- control_files = C:\ORACLE\ORADATA\ORAWIN19\CONTROL01.CTL, C:\ORACLE\ORADATA\ORAWIN19\CONTROL02.CTL

show parameters spfile; -- C:\ORACLE\PRODUCT\19.3\DB_HOME1\DATABASE\SPFILEORAWIN19.OR
show parameters pfile;
-- sauvegarder le SPFILE en PFILE (sys as sysdba)
create pfile = 'C:\ORACLE\PRODUCT\19.3\DATABASE\INITORAWIN19.ORA' from spfile;

-- Changement de paramètres (en live ou base arrétée)
-- scope = BOTH, SPFILE, MEMORY
alter system set control_files='AHAHA' SCOPE = BOTH; -- ce paramètre n'est pas modifiable à chaud
alter system set control_files='C:\ORACLE\ORADATA\ORAWIN19\CONTROL01.CTL', 'C:\oracle\fast_recovery_area\ORAWIN19\CONTROL02.CTL' SCOPE = SPFILE;
-- copy spfile en pfile (avec sys as sysdba)
create pfile = 'C:\ORACLE\PRODUCT\19.3\DATABASE\INITORAWIN19_202410081151.ORA' from spfile;


-- tablespaces
CREATE TABLESPACE DATA_IDX 
    DATAFILE 
        'C:\oracle\oradata\ORAWIN19\DATA_IDX_01.DBF' 
    SIZE 2147483648 
    AUTOEXTEND ON;
    
--


CREATE TABLESPACE DATA_IDX 
    DATAFILE 
        'C:\oracle\oradata\ORAWIN19\DATA_IDX_01.DBF' 
    SIZE 2147483648 
    AUTOEXTEND ON
    NEXT 1073741824;

-- ouvrir le quota sur un nouveau tablespace
alter user movie quota unlimited on data_idx;

-- tables ou vues systèmes pour un DBA
-- Document: Database Reference
-- https://docs.oracle.com/en/database/oracle/oracle-database/19/refrn/index.html
select * from dba_tables;
select * from dba_tables where owner = 'MOVIE';

select * from dba_tables 
where owner = 'MOVIE'
    and table_name like '%MOV%';

select * from dba_tablespaces;
select * from dba_data_files;
select * from dba_temp_files;

-- C:\ORACLE\ORADATA\ORAWIN19\DATA_IDX_02.DBF

ALTER TABLESPACE DATA_IDX
    ADD DATAFILE 'C:\ORACLE\ORADATA\ORAWIN19\DATA_IDX_02.DBF'
    SIZE 1G
    AUTOEXTEND ON; -- default: maxsize unlimited

ALTER TABLESPACE DATA_IDX
    ADD DATAFILE 'C:\ORACLE\ORADATA\ORAWIN19\DATA_IDX_02.DBF'
    SIZE 1G
    AUTOEXTEND ON
    MAXSIZE UNLIMITED;  
    
ALTER TABLESPACE DATA_IDX
    ADD DATAFILE 'C:\ORACLE\ORADATA\ORAWIN19\DATA_IDX_02.DBF'
    SIZE 1G
    AUTOEXTEND ON
    MAXSIZE 1G; -- plus tard changer le max


