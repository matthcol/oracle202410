-- session SQL avec user system ou sys
select * from v$database; -- colonne log_mode=ARCHIVELOG ou NOARCHIVELOG
select log_mode from v$database; 
-- réponse = NOARCHIVELOG

-- en session SQL privilégiée: / as sysdba ou sys as sysdba
select log_mode from v$database;
shutdown immediate
startup mount
alter database archivelog; -- ok car fast_recovery_area activée
select log_mode from v$database;
shutdown immediate
startup
select log_mode from v$database;

-- 1er backup avec outil RMAN
rman target /
backup database;

