/*
File Name: Over time observations
Editor: Saeid Sharify
Date: 2022/10/16
*/

# Select a time interval in data and extract years and days
WITH time_intrval AS

(

  SELECT
  EXTRACT(year FROM starttime) AS year,
  EXTRACT(dayofweek FROM starttime) AS day
  
  FROM `project_name.dataset_name.table_name`
  
  WHERE
  starttime
  BETWEEN '2010-01-01T00:00:00'
  AND '2020-12-31T23:59:59'
  
),


# Set a weekly table and count daily trips
  daily_trips AS
  
(
  
  SELECT
  year,
  day,
  CASE WHEN day=1 THEN 'Sunday' 
       WHEN day=2 THEN 'Monday'
       WHEN day=3 THEN 'Tuesday'
       WHEN day=4 THEN 'Wednesday'
       WHEN day=5 THEN 'Thursday'
       WHEN day=6 THEN 'Friday'
       WHEN day=7 THEN 'Saturday'
       
       ELSE NULL END AS day_name,

  COUNT(*) AS trips_per_day
  
  FROM time_intrval
  group by year,day

),


# Set a shift register to calculate daily trips from last year
  shift_rgistr AS
(

  SELECT
  year,
  day,
  day_name,
  trips_per_day,
  LAG(trips_per_day) OVER(PARTITION BY day ORDER BY day, year ASC) AS daily_trips_last_year
  
  FROM daily_trips

),


# Set a register to calculate year-to-year daily trips (changes over a year)
  y2y_changes AS

(

  SELECT *,
  trips_per_day - daily_trips_last_year AS y2y_change
  
  FROM shift_rgistr
  
),

