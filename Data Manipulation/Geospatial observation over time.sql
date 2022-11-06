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

# Set a weekly table and calculates miles traveled per day of week
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


