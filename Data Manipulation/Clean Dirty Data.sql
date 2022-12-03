/*
File Name: Clean Dirty Data 
Editor: Saeid Sharify
Date: 2022/10/16
*/

-- Hands on with some queries over BigQuery or SQLite to clean dirty data


/*
SELECT *
-- 940 rows in total 
-- 33 IDs for 31 days
FROM DA
*/

/*
-- Check-list: no null row was found>
SELECT * 
FROM dailyActivity_merged
WHERE  FIELD IS NULL
*/

/*
-- remove the old char date COLUMN / bad data format
-- ALTER TABLE DA DROP ActivityDate
-- count ID number
SELECT DISTINCT Id, COUNT(DISTINCT(Id)) AS counter 
-- 33
*/

/*
-- count number of days
SELECT DISTINCT(Date), COUNT(DISTINCT(Date))
--31
*/

-- check the length of specific collumn for data validation
/*
SELECT LENGTH(Id) AS letters_in_Id
FROM DA
WHERE letters_in_Id != 10
ORDER BY letters_in_Id DESC
*/

/*
-- clean extra spaces
-- Using TRIM function to remove extra spaces
SELECT
	DISTINCT(Id)
FROM
	DA
WHERE
	TRIM(Date) BETWEEN -- remove all spaces in Date column
	"16-04-12" AND "16-05-12"
*/

/*
-- Typcasting: converting data 
-- I want the most consumed Calories shows in the first result
SELECT 
	CAST(Calories AS FLOAT64) -- INTEGER to FLOAT64
FROM DA

ORDER BY
	CAST(Calories AS FLOAT64) DESC
*/







