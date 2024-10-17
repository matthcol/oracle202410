select * from dba_directories;

select * from dba_datapump_jobs;

select current_scn from v$database;

-- sessions
select * from v$session where username is not null;
select * from v$session where username = 'MOVIE';
select * from v$session where username like 'MOVIE%';
select * from v$session where username IN ('MOVIE', 'MOVIEREADER', 'MOVIEREDACTOR');

select 
    sid, serial#,
    program, username, osuser, program, module, status 
from v$session 
where username IN ('MOVIE', 'MOVIEREADER', 'MOVIEREDACTOR');


-- kill session
alter system kill session '370,58689';
alter system kill session '370,48282';


select PARSING_SCHEMA_NAME, SQL_TEXT, SQL_FULLTEXT from v$sql;
desc v$sql;

select PARSING_SCHEMA_NAME, SQL_TEXT, SQL_FULLTEXT 
from v$sql
where lower(sql_text) like '%from movie%';

select * from v$lock where sid in (
    select sid
    from v$session 
    where username IN ('MOVIE', 'MOVIEREADER', 'MOVIEREDACTOR')
);

-- flashback
show parameters undo