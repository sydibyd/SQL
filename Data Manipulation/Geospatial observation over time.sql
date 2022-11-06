/*
File Name: Geospatial observation over time
Editor: Saeid Sharify
Date: 2022/10/16
*/

# ---- ---- ---- ---- ---- ---- ---- ----
# Select a time interval in data and extract years, days and geo points of trips
WITH trip_source AS

(

  SELECT 
  EXTRACT(year FROM starttime) AS year,
  EXTRACT(dayofweek FROM starttime) AS day,

  ST_GEOGPOINT(start_station_latitude, start_station_longitude) AS geo_A_point,
  ST_GEOGPOINT(end_station_latitude, end_station_longitude) AS geo_B_point

  FROM`bigquery-public-data.new_york_citibike.citibike_trips`
  #FROM `project_name.dataset_name.table_name`

  WHERE
  starttime
  BETWEEN '2010-01-01T00:00:00'
  AND '2020-12-31T23:59:59'
  
),
