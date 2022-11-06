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
   
  FROM `project_name.dataset_name.table_name`
  
  WHERE
  starttime BETWEEN '2014-01-01T00:00:00'
  AND '2015-12-31T23:59:59'
 
),

# Calculate the number of trips started from each station as A points
A_point_counts AS 
 
(

  SELECT
  start_station_id AS station_id,
  MAX(start_station_name) AS station_name,
  COUNT(*) AS A_point_countr
  
  FROM station_table
  
  GROUP BY station_id

),

# Calculate the number of trips terminated to each station as B points
B_point_counts AS

B_point_counts AS

(
  SELECT
  end_station_id AS station_id, 
  MAX(end_station_name) AS station_name,
  COUNT(*) AS B_point_countr
  
  FROM station_table
  GROUP BY station_id
  
),

# Joining A and B point counter outputs based on the station_id:
ID_based_join AS

( 

  SELECT
  COALESCE(A_point.station_name, B_point.station_name) AS station_name,
  COALESCE(A_point.station_id,B_point.station_id) AS station_id,  
  COALESCE(A_point.A_point_countr, 0) AS A_point_countr,
  COALESCE(B_point.B_point_countr, 0) AS B_point_countr
  
  FROM A_point_counts AS A_point
  
  FULL OUTER JOIN B_point_counts AS B_point 
  USING(station_id)
   
)


  # Filter and display the results (stations with highest number of trips)
  SELECT
  station_name,
  station_id,
  A_point_countr,
  B_point_countr,
  A_point_countr + B_point_countr AS total_trip_count
  
  FROM ID_based_join
  
  ORDER BY total_trip_count DESC
