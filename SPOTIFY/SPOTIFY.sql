---ADVANCED SQL PROJECT --SPOTIFY DATASET

CREATE TABLE spotify
(
	artist	VARCHAR(255),
	track	VARCHAR(255),
	album	VARCHAR(255),
	album_type	VARCHAR(50),
	danceability FLOAT,
	energy	FLOAT,
	loudness FLOAT,	
	speechiness FLOAT,
	acousticness FLOAT,	
	instrumentalness FLOAT,	
	liveness FLOAT,
	valence FLOAT,
	tempo FLOAT,
	duration_min FLOAT,	
	title VARCHAR(255),
	channel VARCHAR(255),
	views FLOAT,	
	likes BIGINT,	
	comments BIGINT,	
    licensed BOOLEAN,
	official_video	BOOLEAN,
	Stream	BIGINT,
	Energy_liveness FLOAT,	
	most_played_on VARCHAR(50)
);


SELECT * FROM spotify;


SELECT COUNT(*) FROM spotify;


SELECT COUNT(DISTINCT artist) FROM spotify;


SELECT DISTINCT album_type FROM spotify;


SELECT duration_min FROM spotify;


SELECT MAX(duration_min) FROM spotify;


SELECT MIN(duration_min) FROM spotify;


SELECT * FROM spotify
WHERE duration_min = 0;

DELETE FROM spotify
WHERE duration_min = 0;

SELECT * FROM spotify
WHERE duration_min = 0;



SELECT DISTINCT channel FROM spotify;


SELECT DISTINCT most_played_on FROM spotify;

------------------------------------------
-- DATA ANALYSIS--EASY CATEGORY
------------------------------------------

-- Q1

SELECT * FROM spotify
WHERE stream > 1000000000;


-- Q2

SELECT 
     DISTINCT album,artist
FROM spotify
ORDER BY 1;


-- Q3

SELECT
	SUM(comments) as total_comments
FROM spotify
WHERE licensed  = 'true';


-- Q4

SELECT * FROM spotify
WHERE album_type = 'single';


-- Q5


SELECT
	artist,
	COUNT(*) as total_no_songs
FROM spotify
GROUP BY artist
ORDER BY 2 DESC;


------------------------------------------
-- DATA ANALYSIS--MEDIUM LEVEL
------------------------------------------


-- Q6

SELECT
	album,
	avg(danceability) as avg_danceability
FROM spotify
GROUP BY 1
ORDER BY 2 DESC;

	 
-- Q7

SELECT
	track,
	MAX(energy)
FROM spotify
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5


-- Q8

SELECT
	track,
	SUM(views) as total_views,
	SUM(likes) as total_likes
FROM spotify
	 WHERE 
	 official_video = 'true'
GROUP BY 1
ORDER BY 2 DESC


-- Q9


SELECT
	album,
	track,
	SUM(views)
FROM spotify
GROUP BY 1 , 2
ORDER BY 3 DESC


-- Q10


SELECT * FROM
(
SELECT
	track,
	COALESCE(SUM(CASE WHEN most_played_on = 'Youtube' THEN stream END),0) as streamed_on_youtube,
	COALESCE(SUM(CASE WHEN most_played_on = 'Spotify' THEN stream END),0) as streamed_on_spotify
FROM spotify
GROUP BY 1
) as t1
WHERE 
     streamed_on_spotify > streamed_on_youtube
	 AND
	 streamed_on_youtube <> 0


------------------------------------------
-- DATA ANALYSIS--ADVANCED PROBLEMS
------------------------------------------


-- Q11


WITH ranking_artist
AS
(
SELECT
	 artist,
	 track,
	 SUM(views) as total_views,
	 DENSE_RANK() OVER(PARTITION BY artist ORDER BY SUM(views) DESC) as rank
FROM spotify
GROUP BY 1,2
ORDER BY 1,3 DESC
)
SELECT * FROM ranking_artist
WHERE rank <= 3

-- Q12

SELECT
	track,
	artist,
	liveness
FROM spotify
WHERE liveness > (SELECT AVG(liveness) FROM spotify)

-- Q13

WITH cte
AS
(SELECT
	album,
	MAX(energy) as highest_energy,
	MIN(energy) as lowest_energy
FROM spotify
GROUP BY 1
)
SELECT
	album,
	highest_energy - lowest_energy as energy_diff
FROM cte
ORDER BY 2 DESC


-- QUERY OPTIMIZATION

EXPLAIN ANALYZE
SELECT 
	artist,
	track,
	views
FROM spotify
WHERE artist = 'Gorillaz'
	AND
	most_played_on = 'Youtube'
ORDER BY stream DESC LIMIT 25


CREATE INDEX artist_index ON spotify(artist);
	 
	 







































