create view movie_director as
    select m.id, m.title, m.year, m.duration, m.director_id, p.name
    from movies m left join persons p on m.director_id = p.id;