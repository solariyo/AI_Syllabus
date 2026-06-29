--SECTION 0: SELECT basics

-- Exercise 1: Get population of Germany
SELECT Population FROM world
  WHERE name = 'Germany';

  --Exercise 2: Ger population of Sweden, Norway, Denmark
SELECT Name, Population FROM world
  WHERE Name IN ('Sweden', 'Norway', 'Denmark');

--Exercise 3: Just the right size
SELECT Name, Area FROM world
  WHERE area BETWEEN 200000 AND 250000;


  --SECTION 1: SELECT from WORLD 
--Exercise 1: Introduction 
SELECT Name, Continent, Population FROM world;

--Exercise 2: Large countries
SELECT Name FROM world
WHERE Population >= 200E6;

--Exercise 3: Per Capita GDP
SELECT Name, GDP/Population AS 'Per Capita GDP'  FROM world
WHERE Population >= 200E6;

--Exercise 4: South America In millions
SELECT Name, population/1000000 AS 'Population/1000000' FROM world
WHERE continent = 'South America';

--Exercise 5: France, Germany, Italy
SELECT Name, Population FROM world
WHERE name IN ('France', 'Germany', 'Italy');

--Exercise 6: 'United'
SELECT Name FROM world
WHERE name like '%United%'

--Exercise 7: Two ways to be big
SELECT Name, Population, Area AS 'Area (SqKm)' FROM world
WHERE area > 3E6 OR population >250E6;

--Exercise 8: One or the other (but not both)
SELECT Name, Population, Area FROM world
WHERE area >3E6 XOR population >250E6;

--Exercise 9: Rounding
SELECT Name, ROUND(Population/1E6 ,2) AS 'Population (Millions)', ROUND(GDP/1E9, 2) AS 'GDP (Billions)' FROM world
WHERE continent = 'South America';

--Exercise 10: Trillion dollar economies
SELECT Name, ROUND((GDP/Population), -3) AS 'Per Capita GDP 0000' FROM world
WHERE GDP >= 1E12;

--Exercise 11: Name and capital have the same length
SELECT Name, Capital FROM world
WHERE LENGTH(name) = LENGTH(capital);

--Exercise 12: Matching name and capital
SELECT Name, Capital FROM world
WHERE LEFT(name, 1) = LEFT(capital, 1) AND name <> capital;

--Exercise 13: All the vowels
SELECT Name 
    FROM world
WHERE 
      name LIKE '%A%' 
  AND name LIKE '%E%' 
  AND name LIKE '%I%'
  AND name LIKE '%O%' 
  AND name LIKE '%U%' 
  AND name NOT LIKE '% %';

  --SECTION 2: SELECT from Nobel

--Exercise 1: Winners from 1950
SELECT yr AS 'Year',Subject, Winner
  FROM nobel
 WHERE yr = 1950;

--Exercise 2: 1962 Literature
SELECT Winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'literature';

--Exercise 3: Albert Einstein
SELECT yr AS 'Year', Subject
  FROM nobel
WHERE winner = 'albert einstein';

--Exercise 4: Recent Peace Prizes
SELECT Winner
  FROM nobel
WHERE yr >= 2000 AND subject = 'peace';

--Exercise 5: Literature in the 1980's
SELECT yr AS 'Year', Subject, Winner
  FROM nobel
WHERE subject = 'literature' 
  AND yr between 1980 AND 1989;

--Exercise 6: Only Presidents
SELECT yr AS 'Year', Subject, Winner
  FROM nobel
 WHERE winner IN ('Theodore Roosevelt', 'Thomas Woodrow Wilson', 'Jimmy Carter', 'Barack Obama');

--Exercise 7: John
SELECT Winner 
  FROM nobel
WHERE Winner LIKE 'John%';

--Exercise 8: Chemistry and Physics from different years
SELECT yr AS 'Year', Subject, Winner
  FROM nobel
 WHERE (subject = 'physics' AND yr = 1980)
    OR (subject = 'chemistry' AND yr = 1984);

--Exercise 9: Exclude Chemists and Medics
SELECT yr AS 'Year', Subject, Winner
  FROM nobel
WHERE yr = 1980 
   AND subject <> 'chemistry'
   AND subject <>'medicine';

--Exercise 10: Early Medicine, Late Literature
SELECT yr as 'Year', Subject, Winner
  FROM nobel 
WHERE (subject = 'medicine' AND yr < 1910)
 OR (subject = 'literature' AND yr >= 2004);


 --Exercise 11: Umlaut
 SELECT * 
  FROM nobel 
WHERE Winner = 'PETER GRÜNBERG'

--Exercise 12: Apostrophe
SELECT * 
  FROM nobel 
WHERE Winner = 'EUGENE O''NEILL';

--Exercise 13: Knights of the realm
SELECT Winner, yr AS 'Year', Subject 
FROM nobel
WHERE winner LIKE 'sir%' 
  ORDER BY yr DESC, winner ASC;

  --Exercise 14: Chemistry and Physics last
  SELECT Winner, Subject 
  FROM nobel 
WHERE yr = 1984
  ORDER BY subject IN ('chemistry', 'physics'), subject, winner;
   

--SECTION 3: SELECT within SELECT
 
 --Exercise 1:Bigger than Russia
 SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')

-- Exercise 2: Richer than UK
SELECT name 
FROM world 
WHERE continent = 'Europe' 
  AND gdp/population > (
      SELECT gdp/population 
      FROM world 
      WHERE name = 'United Kingdom'
  );


--Exercise 3: Neighbours of Argentina and Australia
SELECT Name, Continent 
  FROM world 
WHERE continent IN ('south america', 'oceania') 
ORDER BY name;

--Exercise 4: Between Canada and Poland
SELECT Name, Population 
  FROM world 
WHERE population > (SELECT population 
                     FROM world WHERE  name = 'united kingdom') 
  AND population < (SELECT population FROM world WHERE name = 'germany');

  
--Exercise 5: Percentages of Germany
SELECT name, 
       CONCAT(ROUND(population * 100 / (SELECT population 
                                        FROM world 
                                        WHERE name = 'Germany')), '%') AS percentage
FROM world
WHERE continent = 'Europe';


--Exercise 6: Bigger than every country in Europe
SELECT name
FROM world
WHERE gdp > ALL(SELECT gdp
                FROM world
                WHERE continent = 'Europe'
                  AND gdp > 0);


--Exercise 7: Largest in each continent
SELECT Continent, Name, Area 
  FROM world x 
WHERE area >= ALL(SELECT area FROM world y
               WHERE y.continent = x.continent
               AND AREA >0);


--Exercise 8: First country of each continent (alphabetically)
SELECT Continent, min(Name) 
  FROM world
GROUP BY continent;

--Exercise 9: Difficult Questions That Utilize Techniques Not Covered In Prior Sections
SELECT name, continent, population
FROM world
WHERE continent IN (
  SELECT continent
  FROM world
  GROUP BY continent
  HAVING MAX(population) <= 25000000
);

--Exercise 10: Three time bigger
SELECT name, continent 
FROM world AS x 
WHERE population > ALL (
   SELECT 3 * population 
   FROM world As y
   WHERE y.continent = x.continent 
    And y.name <> x.name
);


--SECTION 4: SUM and COUNT

--Exercise 1: Total world population
SELECT SUM(population) AS 'Total Population'
FROM world;

--Exercise 2: List of continents
SELECT Distinct Continent 
  FROM world;


  --Exercise 3: GDP of Africa
  SELECT sUM(GDP) AS 'Total GDP'
  FROM world 
WHERE continent = 'africa';

--Exercise 4: Count the big countries
SELECT COUNT(name) AS 'Number of Countries'
  FROM world
WHERE area >= 1000000;

--Exercise 5: Baltic states population
SELECT SUM(population) AS 'Total Population'
 FROM world 
WHERE name IN ('EStonia', 'Latvia', 'Lithuania');

--Exercise 6: Using GROUP BY and HAVING
SELECT Continent, COUNT(name) as 'Number of Countries'
  FROM world
GROUP BY continent


--Exercise 7: Counting big countries in each continent
SELECT Continent, COUNT(name) AS 'Number of countries'
 FROM world
WHERE population >= 10000000
GROUP BY continent;


--Exercise 8: 
SELECT Continent
  FROM world
GROUP BY continent HAVING SUM(population) >= 100E6


