-- user movieredactor
select * from current_movies;
insert into current_movies -- remplacer movies par le nom de la vue
    (title, year) values ('Joker: Folie à deux', 2024);
insert into current_movies (title, year, duration_mn) 
    values ('Beetlejuice Beetlejuice', 2024, 105);
    
select * from current_movies;

update current_movies -- ou nom de la vue
set duration_mn = 138
where id = 8079269;

-- on veut interdire les suivantes:
update current_movies -- ou nom de la vue
set year = 2032
where id = 8079269;

update current_movies -- ou nom de la vue
set title = 'bad movie'
where id = 8079269;

delete current_movies -- ou nom de la vue
where id = 8079269;

-- pas d'acces a la table sous-jacente
select * from movie.movies;

-- super bonus
insert into current_movies (title, year) 
    values ('Beetlejuice', 1988);
