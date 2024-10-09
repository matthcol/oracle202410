-- system peut changer tous les mots de passe sauf sys
alter user system identified by iRFAbcYKPMtPS2fLD7TL;
-- uniquement par sys: 
alter user sys identified by AdMPdY51JmCYfZkM9QSJ;

-- list of all users
select * from dba_users;
select * from dba_users order by username;
select * from dba_users order by account_status desc, username;
-- Users admins interactifs: sys, system
-- Users métiers: movie
create user moviereader identified by xUTcWpUTnyHk6tr8QjHc;
-- NB: cet utilisateur a un tablespace et un tablespace temporaire 
-- par défaut (repris dans les propriétés de la base: DEFAULT_PERMANENT_TABLESPACE, DEFAULT_TEMP_TABLESPACE)
-- Rappel: tablespace = Data (table, index), temporary tablespace (requêtes)
create user superviser 
    identified by jD3QV5Be0kuxLEW2ckY6
    default TABLESPACE system
    TEMPORARY TABLESPACE temp;

select * from dba_users order by account_status desc, username;

-- accorder le droit de se connecter: role connect
-- Definition: 1 role = collection de privileges ou autres roles
grant connect to moviereader;
grant connect to superviser;

select * from v$session;
select * from v$session where username is not null;
select * from v$session where username = 'SUPERVISER';

-- objectif: date d'expiration de mot de passe
--      * user movie : unlimited
--      * user sys : 31/12/2025
select * from dba_users where username in ('MOVIEREADER', 'SUPERVISER');

select * from dba_profiles order by profile; -- SQLDeveloper: DBA -> Sécurité -> Profils
alter profile default limit PASSWORD_LIFE_TIME UNLIMITED;
alter profile default limit PASSWORD_LIFE_TIME 365;
select * from dba_profiles order by profile;
select * from dba_users where username in ('MOVIEREADER', 'SUPERVISER', 'MOVIE', 'SYS', 'SYSTEM');

create profile appli LIMIT 
    PASSWORD_LIFE_TIME UNLIMITED;
select * from dba_profiles order by profile;
alter user movie PROFILE appli;
select * from dba_users where username in ('MOVIEREADER', 'SUPERVISER', 'MOVIE', 'SYS', 'SYSTEM');

-- NB: pour certains utilisateurs (sys), le mot de passe est stocké dans
-- Ex: C:\oracle\product\19.3\db_home1\database\PWDorawin19.ora


alter user moviereader account lock;
select * from dba_users where username = 'MOVIEREADER';
alter user moviereader account unlock;


-- privileges, roles (suite)
grant create view to movie;


