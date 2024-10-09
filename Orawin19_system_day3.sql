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

-- accorder le droit de creer une vue au user movie
-- NB: ce droit n'est pas inclus dans resource
grant create view to movie;
revoke create view from movie;
revoke resource from movie;
-- autre méthode: créer un role amélioré
create role resourcefull;
grant resource to resourcefull;
grant create view to resourcefull;
grant resourcefull to movie;

-- accorder des droits de lecture sur des tables ou vues du schema movie
-- à 1 autre utilisateur (moviereader)
-- NB: on pourrait passer par 1 role intermédiaire
grant select on movie.play to moviereader; -- lecture table
grant select on movie.persons to moviereader; -- lecture table
grant select on movie.movie_director to moviereader; -- lecture vue
-- fluidifier l'accès aux tables/vues pour les utilisateurs tiers
-- avec des synonymes (privé=1 utilisateur ou publique=tous les utilisateurs)
create synonym moviereader.play for movie.play;
create synonym moviereader.play for movie.persons;
create synonym moviereader.play for movie.movie_director;

-- utilisateur pour accès sur vue en écriture
create user movieredactor identified by PppsuNTQDTmi3ASqdEZQ;
grant connect to movieredactor;
create synonym movieredactor.current_movies for movie.current_movies;
-- NB: la vue et les droits sur la vue ont été fixés dans la session du user movie

-- chercher une requete recemment executée (DML)
select * from v$sql where lower(sql_text) like '%current_movies%';



