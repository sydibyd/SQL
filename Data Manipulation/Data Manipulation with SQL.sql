/* This query counts the total rows of a specific column, grouped by another value like "eyear rom another column.
   This could be usful when there is a need to count something. */

SELECT

 # Extract the year from a date_time (data type) comlum
 EXTRACT(year from A_point_moment ) AS year,
 
 # Count the number of observations (here, the number of A_point_moment or trips):
 COUNT(*) AS total_trips
 
FROM `project_name.dataset_name.table_name`



 # Group the output results by the extracted year:

GROUP BY year
ORDER BY year
