declare
    -- franchise varchar2(300) := 'Les Bronzés ';
    -- franchise varchar2(300) := 'Les Sous Doués ';
    -- franchise varchar2(300) := 'Les Gendarmes ';
    -- franchise varchar2(300) := 'Fast and Furious ';
    -- franchise varchar2(300) := 'Star Wars ';
    -- franchise varchar2(300) := 'Rambo ';
    -- franchise varchar2(300) := 'James Bond ';
    nb number := 100;
begin
    for i in 1 .. nb loop
        insert into movies (title, year) values (franchise || i, 1980);
    end loop;
    commit;
end;
/

select * from movies where title like 'Les Bronzés%';
select * from movies where title like 'Les Sous Doués%';
select * from movies where title like 'Les Gendarmes%';


select * from play;
select count(*) from play;

delete from play
where role like '%007%';  -- NB: executer en selectionnant sans le where => tout supprimer
commit;

delete from movies where title like 'Les Bronzés%'; -- 100 deleted
delete from movies where title like  'Les Gendarmes%'; -- 100 deleted
commit;

select 'play' as table_name, count(*) as nb from play
UNION
select 'movies' as table_name, count(*) as nb from movies;