select * from dba_directories;

create directory IMPORT_DIR AS '/tmp/import';
grant read on directory import_dir TO movie;
select * from dba_directories;

-- pour ecrire dump ou log
grant write on directory import_dir TO movie;