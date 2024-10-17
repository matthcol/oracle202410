drop table play;

select count(*) from play;

select * from movies where title like 'Les Bronz%';


select id, title, year from movies2
MINUS
select id, title, year from movies;

select title, year from movies2
MINUS
select title, year from movies;
