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
    
-- Exemple: vue en modification pour ajouter film annee en cours 
-- et modification uniquement colonnes duration_mn, synopsis, poster_uri
-- accorder ses droits à 1 nouvel utilisateur movieredactor

select m.id, m.title, m.year, m.duration_mn, m.synopsis, m.poster_uri
from movies m 
where m.year = extract(year from sysdate);





