/*
File Name: Cleaning name irregularitie
Editor: Saeid Sharify
Date: 2022/08/16
*/

# Count and remove name repetition
# ---- ---- ---- ---- ---- ---- ---- ----
# Separate two columns and filter a time period from a table to count and compare their values
WITH A_points AS 

(
  SELECT
  start_station_name,
  start_station_id
  
  FROM `project_name.dataset_name.table_name`

  WHERE
    started_at
    BETWEEN '2021-01-01T00:00:00'
    AND '2022-12-31T23:59:59'  
),

# Calculation: the number of start station name repetition, compared and grouped by station ID.
station_name_repetition AS

(
  SELECT
  start_station_id,
  COUNT(DISTINCT start_station_name) AS name_repetition
  FROM A_points
  
  group by start_station_id
  having name_repetition >=2
),

# Joining records based on station IDs
# I used the RIGHT JOIN keyword, so the result is 0 records from the left side, if there is no match.
combined_records AS

(
  SELECT
  A_point_names.start_station_name,
  A_point_IDs.start_station_id,
  A_point_IDs.name_repetition

  FROM A_points AS A_point_names

  RIGHT JOIN station_name_repetition AS A_point_IDs
  ON A_point_names.start_station_id = A_point_IDs.start_station_id
)

# Create a new table to present the results. It will show three columns, including valus for start_station_name, start_station_id and name_repetition.
  SELECT
  DISTINCT start_station_name,
  start_station_id,
  name_repetition

  FROM combined_records
  ORDER BY start_station_id,name_repetition
