-- session user: moviereader
-- no resource
-- create table dummy (d number);
-- ORA-01031: privilèges insuffisants
-- 01031. 00000 -  "insufficient privileges"

select count(*) from movie.persons;
select * from movie.movie_director where year =  1984;

-- avec les synonymes
select count(*) from persons;
select * from movie_director where year =  1984;
