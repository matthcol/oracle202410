select * from movies where year = 2024; -- 1 id: 8079270

select * from movies where year = 2024;


-- session 1
update movies 
set duration_mn = 120
where id = 8079270;

-- .....
commit;
-- ou rollback

-- session 2
update movies 
set duration_mn = 300
where id = 8079270;
