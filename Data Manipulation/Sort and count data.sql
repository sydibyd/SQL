/*
File Name: Sort and count data
Editor: Saeid Sharify
Date: 2022/10/16
*/

# ---- ---- ---- ---- ---- ---- ---- ----
# Extract start and end station names and IDs and put them in station_table:
WITH station_table AS

(

  SELECT
  start_station_name,
  end_station_name,
  start_station_id,
  end_station_id
   
  FROM`bigquery-public-data.new_york_citibike.citibike_trips`

  WHERE
  starttime BETWEEN '2014-01-01T00:00:00'
  AND '2015-12-31T23:59:59'
 
),
