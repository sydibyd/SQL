/* 1. Cleaning - Name Irregularities. */
# ---- ---- ---- ---- ---- ---- ---- ----

# Separate two columns and cut a time period from a table to count and compare their values

WITH A_points AS 

(
  SELECT
  start_station_name,
  start_station_id
  
  FROM `capstone-project-356415.00.202201`

  WHERE
    started_at
    BETWEEN '2021-01-01T00:00:00'
    AND '2022-12-31T23:59:59'  
),
