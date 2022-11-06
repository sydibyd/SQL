/*
File Name: Geospatial observation over time
Editor: Saeid Sharify
Date: 2022/10/16
*/

# ---- ---- ---- ---- ---- ---- ---- ----
# Select a time interval in data and extract years, days and geo points of trips
WITH all_trips AS

(

  SELECT 
  EXTRACT(year FROM starttime) AS year,
  EXTRACT(dayofweek FROM starttime) AS day,

  ST_GEOGPOINT(start_station_latitude, start_station_longitude) AS geo_A_point,
  ST_GEOGPOINT(end_station_latitude, end_station_longitude) AS geo_B_point

  FROM `project_name.dataset_name.table_name`

  WHERE
  starttime
  BETWEEN '2010-01-01T00:00:00'
  AND '2020-12-31T23:59:59'
  
),


# Set a register to calculate cycled miles over time (daily for each year)
  cycled_distance AS

(

  SELECT
  year,
  day,

  # Converting meters to miles:
  ST_DISTANCE(geo_A_point, geo_B_point) * .000621 AS cycled_miles 
  
  FROM all_trips
  
),

# Set a weekly table and calculates miles traveled per days of week
  daily_meters AS
  
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

  SUM(cycled_miles) AS daily_miles

  FROM cycled_distance
 
  group by year,day
 
),

# Set a shift register to calculate daily miles from last year (for days of week)
shift_rgistr  AS

(

  SELECT
  year,
  day,
  day_name,
  daily_miles,
  
  LAG(daily_miles) OVER(PARTITION BY day ORDER BY day, year ASC) AS daily_miles_last_year
 
  FROM daily_meters
  
),


# Set a register to calculate year-to-year daily miles (changes over a year)
  y2y_changes AS

(

  SELECT *,
  daily_miles - daily_miles_last_year AS y2y_change
  
  FROM shift_rgistr
  
),

# Set a register to calculate the percentage of changes
  percentage_changes  AS
  
(

  SELECT *,
  
  ROUND((y2y_change / daily_miles) *100) AS percentage_change
  
  FROM y2y_changes
  
)


  # Filter and display the results
  SELECT *
  
  FROM percentage_changes 
  
  where year = 2020
  order by day
