/*
File Name: Data Manipulation with SQL in BigQuery
Editor: Saeid Sharify
Date: 2022/10/16
*/

/* 1. This query counts the total rows of a specific column, grouped by another value like "eyear rom another column.
   This could be usful when there is a need to count something. */
# ---- ---- ---- ---- ---- ---- ---- ----

SELECT

 # Extract the year from a date_time (data type) comlum
 EXTRACT(year from A_point_moment ) AS year,
 
 # Count the number of observations (here, the number of A_point_moment or trips):
 COUNT(*) AS total_trips
 
FROM `project_name.dataset_name.table_name`

 # Group the output results by the extracted year:

GROUP BY year
ORDER BY year

/* 2. This query counts the total number of observations (trips) grouped by months and years */
# ---- ---- ---- ---- ---- ---- ---- ----

SELECT

 # Extract years and months from a date_time (data type) comlum
 EXTRACT(year FROM A_point_moment) AS trip_year,
 EXTRACT(month FROM A_point_moment) AS trip_month,
 
 # Count the number of observations (here, the number of A_point_moment or trips): 
 COUNT(*) AS total_trips

FROM `project_name.dataset_name.table_name`

 # Group the output results by the extracted years and months:

GROUP BY trip_year,trip_month
ORDER BY trip_year,trip_month

/* 3. This query counts the number of months and days during which we had trips, for each year. */
# ---- ---- ---- ---- ---- ---- ---- ----

SELECT
 EXTRACT(year FROM A_point_moment) AS year,
 COUNT(DISTINCT EXTRACT(month FROM A_point_moment)) AS month,
 COUNT(DISTINCT EXTRACT(dayofyear FROM A_point_moment)) AS day

FROM `project_name.dataset_name.table_name`

GROUP BY year
ORDER BY year





