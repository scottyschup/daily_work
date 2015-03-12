-- cross joins + where
-- explain
select
  actors.name, yr, movies.title
from
  actors, movies, (
    select
      director_id, count(*) as num_movies
    from
      movies
    where
      yr between 1990 and 1999
    group by
      director_id
  ) as movie_counts

where
  actors.id = movies.director_id and
  movie_counts.director_id = movies.director_id and
  movie_counts.num_movies > 1
order by
  actors.name, yr
;

-- inner joins
-- explain
select
  actors.name, yr, movies.title
from
  actors
join
  movies on actors.id = movies.director_id
join
  (
    select
      director_id, count(*) as num_movies
    from
      movies
    where
      yr between 1990 and 1999
    group by
      director_id
  ) as movie_counts on movie_counts.director_id = movies.director_id
where
  movie_counts.num_movies > 1
order by
  actors.name, yr
;
