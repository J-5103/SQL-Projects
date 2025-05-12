--netflix project
DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
	show_id VARCHAR(6),
	type VARCHAR(10),
	title	VARCHAR(150),
	director VARCHAR(208),	
	casts	VARCHAR(1000),
	country	VARCHAR(150),
	date_added	VARCHAR(50),
	release_year INT,
	rating	VARCHAR(10),
	duration VARCHAR(15),	
	listed_in	VARCHAR(100),
	description VARCHAR(250)

)


SELECT * FROM netflix


SELECT
    COUNT(*) as total_content
FROM netflix	



SELECT
    DISTINCT type
FROM netflix	



--15 business problems

--	Q1


SELECT
	type,
	COUNT(*) as total_content
FROM netflix
GROUP BY type



--	Q2

SELECT
	type,
	rating
FROM
(
	SELECT
		type,
		rating,
		COUNT(*),
		RANK() OVER(PARTITION BY type ORDER BY COUNT(*) DESC) as ranking
	FROM netflix
	GROUP BY 1,2
) as t1
WHERE
    ranking = 1


-- Q3


SELECT * FROM netflix
WHERE
    type='Movie'
	AND
	release_year = 2020


-- Q4


SELECT
	UNNEST(STRING_TO_ARRAY(country,',')) as new_country,
	COUNT(show_id) as total_content
FROM netflix
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5


-- Q5


SELECT * FROM netflix
WHERE
	type = 'Movie'
	AND
    duration=(SELECT MAX(duration) FROM netflix)



-- Q6


SELECT
	*
FROM netflix
WHERE
	TO_DATE(date_added,'Month DD,YYYY') >= CURRENT_DATE - INTERVAL '5 years'



-- Q7


SELECT * FROM netflix 
WHERE director ILIKE '%Rajiv Chilaka%'


-- Q8



SELECT
	*
FROM netflix
WHERE 
	type='TV Show'
	AND
	SPLIT_PART(duration,' ',1)::numeric > 5


-- Q9


SELECT
	UNNEST(STRING_TO_ARRAY(listed_in,',')) as genre,
	COUNT(show_id) as total_content
FROM netflix
GROUP BY 1


-- Q10


SELECT
	EXTRACT(YEAR FROM TO_DATE(date_added,'Month DD,YYYY')) as year,
	COUNT(*) as yearly_content,
	ROUND(
	COUNT(*) ::numeric/(SELECT COUNT(*) FROM netflix WHERE country = 'India')::numeric * 100
	,2)as avg_content
FROM netflix
WHERE country = 'India'
GROUP BY 1



-- Q11


SELECT * FROM netflix
WHERE
     listed_in ILIKE '%documentaries%'


-- Q12


SELECT * FROM netflix
WHERE
     director IS NULL



-- Q13


SELECT * FROM netflix
WHERE 
    casts ILIKE '%Salman Khan%'
	AND
	release_year > EXTRACT(YEAR FROM CURRENT_DATE) - 10


-- Q14


SELECT 
	UNNEST(STRING_TO_ARRAY(casts,',')) as actors,
	COUNT(*) as total_content
FROM netflix
WHERE 
     country ILIKE '%india'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10



-- Q15


WITH new_table
AS
(
SELECT
*,
	CASE
	WHEN
		description ILIKE '%kill%' OR
		description ILIKE '%violence%' THEN 'Bad_Content'
		ELSE 'Good Content'
	END category
FROM netflix
)
SELECT
	category,
	COUNT(*) as total_content
FROM new_table
GROUP BY 1
	
	 
	 
	
		
	





	










