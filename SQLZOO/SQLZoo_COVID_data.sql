# Modify the query to show data from Spain
SELECT name, DAY(whn),
confirmed, deaths, recovered
FROM covid
WHERE name = 'Spain'
AND MONTH(whn) = 3
ORDER BY whn;

# Modify the query to show confirmed for the day before.
SELECT name, DAY(whn), confirmed,
LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn)
FROM covid
WHERE name = 'Italy'
AND MONTH(whn) = 3
ORDER BY whn;

# Show the number of new cases for each day, for Italy, for March.
SELECT name, DAY(whn),
(LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn) - confirmed) * -1 AS new_cases
FROM covid
WHERE name = 'Italy'
AND MONTH(whn) = 3
ORDER BY whn;

# Show the number of new cases in Italy for each week - show Monday only.
SELECT name, DATENAME(week, whn) AS week,
(LAG(confirmed, 1) OVER (PARTITION BY name ORDER BY whn) - confirmed) * -1 AS new_cases
FROM covid
WHERE name = 'Italy'
AND DATENAME(weekday, whn) = 'Monday'
ORDER BY whn;

# Show the number of new cases in Italy for each week - show Monday only.
SELECT tw.name, DATENAME(week, tw.whn) AS week,
tw.confirmed AS cases_tw, (tw.confirmed - lw.confirmed) AS new_cases_tw
FROM covid tw LEFT JOIN covid lw ON 
DATEADD(week, 1, lw.whn) = tw.whn
AND tw.name=lw.name
WHERE tw.name = 'Italy'
AND DATENAME(weekday, tw.whn) = 'Monday'
ORDER BY tw.whn;

# Include the ranking for the number of deaths in the table.
SELECT name, confirmed, RANK() OVER (ORDER BY confirmed DESC) rc, deaths,
RANK() OVER (ORDER BY deaths DESC) rd
FROM covid
WHERE whn = '2020-04-20'
ORDER BY confirmed DESC;

# Show the infect rate ranking for each country. Only include countries with a population of at least 10 million.
SELECT world.name, ROUND((100000*(confirmed/population)),0) AS infection_rate,
RANK() OVER (ORDER BY (confirmed/population) DESC) AS infection_rank
FROM covid JOIN world ON covid.name=world.name
WHERE whn = '2020-04-20' AND population > 10000000
ORDER BY population DESC;