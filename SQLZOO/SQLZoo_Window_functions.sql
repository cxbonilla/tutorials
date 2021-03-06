# Show the lastName, party and votes for the constituency 'S14000024' in 2017.
SELECT lastName, party, votes
FROM ge
WHERE constituency = 'S14000024' AND yr = 2017
ORDER BY votes DESC;

# Show the party and RANK for constituency S14000024 in 2017. List the output by party
SELECT party, votes,
RANK() OVER (ORDER BY votes DESC) as posn
FROM ge
WHERE constituency = 'S14000024' AND yr = 2017
ORDER BY party ASC;

# Use PARTITION to show the ranking of each party in S14000021 in each year. Include yr, party, votes and ranking (the party with the most votes is 1).
SELECT yr,party, votes,
RANK() OVER (PARTITION BY yr ORDER BY votes DESC) as posn
FROM ge
WHERE constituency = 'S14000021'
ORDER BY party,yr;

# Use PARTITION BY constituency to show the ranking of each party in Edinburgh in 2017. Order your results so the winners are shown first, then ordered by constituency.
SELECT constituency,party, votes,
RANK() OVER (PARTITION BY constituency ORDER BY votes DESC) as posn
FROM ge
WHERE constituency BETWEEN 'S14000021' AND 'S14000026'
AND yr  = 2017
ORDER BY posn ASC, constituency;

# Use PARTITION BY constituency to show the ranking of each party in Edinburgh in 2017. Order your results so the winners are shown first, then ordered by constituency.
SELECT constituency,party, votes,
RANK() OVER (PARTITION BY constituency ORDER BY votes DESC) as posn
FROM ge
WHERE constituency BETWEEN 'S14000021' AND 'S14000026'
AND yr  = 2017
ORDER BY posn ASC, constituency;

# Show the parties that won for each Edinburgh constituency in 2017.
SELECT  constituency, party
FROM 
(
SELECT constituency,party, votes, 
rank() OVER (PARTITION BY constituency order by votes desc) as posn
FROM ge
WHERE constituency BETWEEN 'S14000021' AND 'S14000026'
AND yr  = 2017
) TAB WHERE posn = 1;

# Show how many seats for each party in Scotland in 2017.
SELECT party, COUNT(votes)
FROM 
(
SELECT constituency,party, votes, 
rank() OVER (PARTITION BY constituency order by votes desc) as posn
FROM ge
WHERE constituency LIKE 'S%'
AND yr  = 2017
) TAB WHERE posn = 1
GROUP BY party;