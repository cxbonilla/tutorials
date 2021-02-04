# List the films where the yr is 1962 [Show id, title]
SELECT id, title
FROM movie
WHERE yr = '1962';

# Give year of 'Citizen Kane'.
SELECT yr
FROM movie
WHERE title = 'Citizen Kane';

# List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year.
SELECT id, title, yr
FROM movie
WHERE title LIKE 'Star Trek%'
ORDER BY yr;

# What id number does the actor 'Glenn Close' have?
SELECT id
FROM actor
WHERE name = 'Glenn Close';

# What is the id of the film 'Casablanca'
SELECT id
FROM movie
WHERE title = 'Casablanca';

# Obtain the cast list for 'Casablanca'.
# Use movieid=11768, (or whatever value you got from the previous question)
SELECT name
FROM actor
JOIN casting ON (actor.id = casting.actorid)
JOIN movie ON (movie.id = casting.movieid)
WHERE movie.title = 'Casablanca';

# Obtain the cast list for the film 'Alien'
SELECT name
FROM movie
JOIN casting ON (movie.id = casting.movieid)
JOIN actor ON (actor.id = casting.actorid)
WHERE movie.title = 'Alien';

# List the films in which 'Harrison Ford' has appeared
SELECT title
FROM movie
JOIN casting ON (movie.id = casting.movieid)
JOIN actor ON (actor.id = casting.actorid)
WHERE actor.name = 'Harrison Ford';

# List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]
SELECT title
FROM movie
JOIN casting ON (movie.id = casting.movieid)
JOIN actor ON (actor.id = casting.actorid)
WHERE actor.name = 'Harrison Ford'
AND casting.ord <> 1;

# List the films together with the leading star for all 1962 films.
SELECT title, name
FROM movie
JOIN casting ON (movie.id = casting.movieid)
JOIN actor ON (actor.id = casting.actorid)
WHERE ord = 1
AND yr = 1962;

# Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies.
SELECT yr, COUNT(movie.id)
FROM movie
JOIN casting ON (movie.id = casting.movieid)
JOIN actor ON (actor.id = casting.actorid)
WHERE name = 'Rock Hudson'
GROUP BY yr
HAVING COUNT(movie.id) > 2;

# List the film title and the leading actor for all of the films 'Julie Andrews' played in.
SELECT title, name
FROM movie
JOIN casting ON (movie.id = casting.movieid)
JOIN actor ON (actor.id = casting.actorid)
WHERE title IN
(SELECT title
FROM movie
JOIN casting ON (movie.id = casting.movieid)
JOIN actor ON (actor.id = casting.actorid)
WHERE name = 'Julie Andrews')
AND ord = 1;












