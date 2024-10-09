create view movie_director as
    select m.id, m.title, m.year, m.duration, m.director_id, p.name
    from movies m left join persons p on m.director_id = p.id;
    
    
select * from movie_director where year = 1982;

alter table movies add ca number(12) NULL;
alter table movies rename column duration to duration_mn;

drop view movie_director;
create view movie_director as
    select m.id, m.title, m.year, m.duration_mn as duration, m.director_id, p.name
    from movies m left join persons p on m.director_id = p.id;
    
-- Exercice: vue en modification pour ajouter film annee en cours 
-- et modification uniquement colonnes duration_mn, synopsis, poster_uri
-- accorder ses droits à 1 nouvel utilisateur movieredactor

-- Query:
select m.id, m.title, m.year, m.duration_mn, m.synopsis, m.poster_uri
from movies m 
where m.year = extract(year from sysdate);

-- Tests
insert into movies -- remplacer movies par le nom de la vue
    (title, year) values ('Joker: Folie à deux', 2024);
insert into movies (title, year, duration) 
    values ('Beetlejuice Beetlejuice', 2024, 105);

update movies -- ou nom de la vue
set duration = 138
where id = xxxxx;

-- on veut interdire les suivantes:
update movies -- ou nom de la vue
set year = 2032
where id = xxxxx;

update movies -- ou nom de la vue
set title = 'bad movie'
where id = xxxxx;

delete movies -- ou nom de la vue
where id = xxxx;





