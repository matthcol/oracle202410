select 
    current_scn, 
    scn_to_timestamp(current_scn),
    log_mode 
from v$database;
-- current: 3 397 679 , backup: 3 290 385
select 1+3 from dual;

-- 9/10 16H05
select 
    timestamp_to_scn('09/10/2024 16:05')
from dual;

alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD';
alter session set NLS_TIMESTAMP_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
alter session set NLS_TIMESTAMP_TZ_FORMAT = 'YYYY-MM-DD HH24:MI:SS TZR';

select 
    timestamp_to_scn('2024-10-09 16:05')
from dual;

select current_scn, scn_to_timestamp(current_scn) from v$database;
    
select current_timestamp from dual;
-- 2024-10-10 09:55:42 EUROPE/PARIS, tz equivalent CEST => CET

select * from v$log;
-- #1: 3266813	to	3395400
-- #2: 3395400	to	18446744073709551615
-- #3: 3146719	to	3266813
select * from v$archived_log;  -- 1 pièces : 3266813	=>	3395400

alter system switch LOGFILE; -- peut etre differe
select * from v$log;
ALTER SYSTEM ARCHIVE LOG CURRENT; -- archivage maintenant



-- apres avoir ajouté les bronzés
alter system switch LOGFILE; -- ttes les 10mn avec rman ou sqlplus

-- Commandes RMAN
SHOW ALL; -- liste de tous les paramètres
-- CONTROLFILE AUTOBACKUP ON;
-- RETENTION POLICY TO REDUNDANCY 1;
show RETENTION POLICY; -- voir 1 variable
-- changer 1 paramétrage (exemple)
CONFIGURE RETENTION POLICY TO REDUNDANCY 1;

-- TODO: commandes rman

-- apres avoir ajouté les sous doues
alter system switch LOGFILE; -- ttes les 10mn avec rman ou sqlplus



alter session set NLS_DATE_FORMAT = 'YYYY-MM-DD';
alter session set NLS_TIMESTAMP_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
alter session set NLS_TIMESTAMP_TZ_FORMAT = 'YYYY-MM-DD HH24:MI:SS TZR';

select 
    timestamp_to_scn('2024-10-10 12:15')
from dual;


