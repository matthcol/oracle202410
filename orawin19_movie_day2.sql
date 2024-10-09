-- user movie (ou user system en prefixant les noms d'objets)
-- Au préalable: accorder le quota sur le tablespace (user DBA comme system)
ALTER INDEX PK_MOVIES REBUILD 
TABLESPACE DATA_IDX;

ALTER INDEX PK_PERSONS REBUILD 
TABLESPACE DATA_IDX;

ALTER INDEX PK_PLAY REBUILD 
TABLESPACE DATA_IDX;

ALTER INDEX UNIQ_MOVIES REBUILD 
TABLESPACE DATA_IDX;

ALTER INDEX PK_HAVE_GENRE REBUILD 
TABLESPACE DATA_IDX;

-- tables ou vues systèmes (point de vue user movie)
select * from user_tables; -- mes tables
select * from user_views; -- mes vues
select * from user_indexes; -- mes indexes

select * from all_tables;

select * from dba_tables; --error: movie is not DBA

select * from user_tab_columns where column_name like '%MOV%';







