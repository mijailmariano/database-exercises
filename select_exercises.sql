-- Create a new file called select_exercises.sql. Store your code for this exercise in that file. You should be testing your code in MySQL Workbench as you go
-- Use the albums_db database.
use albums_db;
-- Explore the structure of the albums table.
show tables;
	-- a. How many rows are in the albums table?
describe albums;
select count(*) from albums;
		-- 31 total rows in the albums table
        
	-- b. How many unique artist names are in the albums table?
select count(distinct(artist)) from albums;
		-- 23 unique artist entries
        
	-- c. What is the primary key for the albums table?
describe albums;
		-- column 'id' is the primary key for the albums table
        
	-- d. What is the oldest release date for any album in the albums table? What is the most recent release date?
    select min(release_date), max(release_date) from albums;
		-- 1967 is the oldest album release date
        -- 2011 is the most recent album release date
        
-- Write queries to find the following information:
	-- a. The name of all albums by Pink Floyd
select count(distinct(name)) from albums where artist = "Pink Floyd";
select distinct(name) from albums where artist = "Pink Floyd";
		-- two (2) albums by Pink Floyd ('The Dark Side of the Moon', 'The Wall')
        
	-- b. The year Sgt. Peppers Lonely Hearts Club Band was released
select release_date from albums where name = "Sgt. Pepper's Lonely Hearts Club Band";
		-- 1967 was the release date for Sgt. Pepper's Lonely Hearts Club Band
        
	-- c. The genre for the album Nevermind
select genre from albums where name = "Nevermind";
		-- 'Grunge, Alternative rock' is the genre for the album "Nevermind"
        
	-- d. Which albums were released in the 1990s
select distinct(name) from albums where release_date between 1990 and 1999;
-- albums released in the 1990's include: 
	-- 'Come On Over'
	-- 'Dangerous'
	-- 'Falling into You'
	-- 'Jagged Little Pill'
	-- 'Let\'s Talk About Love'
	-- 'Metallica'
	-- 'Nevermind'
	-- 'Supernatural'
	-- 'The Bodyguard'
	-- 'The Immaculate Collection'
	-- 'Titanic: Music from the Motion Picture'

	-- e. Which albums had less than 20 million certified sales
select distinct(name) from albums where sales < 20;
-- albums with less than 20 million certified sales include:
	-- 'Grease: The Original Soundtrack from the Motion Picture'
	-- 'Bad'
	-- 'Sgt. Pepper\'s Lonely Hearts Club Band'
	-- 'Dirty Dancing'
	-- 'Let\'s Talk About Love'
	-- 'Dangerous'
    -- 'The Immaculate Collection'
	-- 'Abbey Road'
	-- 'Born in the U.S.A.'
	-- 'Brothers in Arms'
	-- 'Titanic: Music from the Motion Picture'
	-- 'Nevermind'
	-- 'The Wall'

	-- f. All the albums with a genre of "Rock". Why do these query results not include albums with a genre of "Hard rock" or "Progressive rock"?
select distinct(name) from albums where genre = "Rock";
-- a. 'Rock' genre albums include:
	-- '1'
	-- 'Abbey Road'
	-- 'Born in the U.S.A.'
	-- 'Sgt. Pepper\'s Lonely Hearts Club Band'
	-- 'Supernatural'
-- b. these query results do not return 'hard rock' or 'progressive rock' because we are scripting the query to return values with an exact string.
-- b. [continued] if we wanted to return all values that contained the string 'Rock' as genre than we would code a <like> "%Rock" command instead of equals string.

-- Be sure to add, commit, and push your work.


