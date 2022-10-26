/*
File Name: Calculating growth or changes
Editor: Saeid Sharify
Date: 2022/10/16
*/

/* 1. txt */
# ---- ---- ---- ---- ---- ---- ---- ----
# Extract month and year to cut and frame a time sample from data
WITH time_sample AS

(
  SELECT
  EXTRACT(year FROM starttime) AS year_date,
  EXTRACT(month FROM starttime) AS month_date,
  COUNT(*) AS numb_trips
   
  FROM `project_name.dataset_name.table_name`

  # Cut a time sample
  WHERE
  starttime
  BETWEEN '2010-01-01T00:00:00'
  AND '2020-12-31T23:59:59'
  
  # Eliminate null cells based on the checksum value
  AND checksum IS NOT NULL

  GROUP BY year_date,month_date
),

  # Using LAG() function to calculate previous records partitioned by month date 
  previous_record AS

(
  SELECT
  year_date,
  month_date,
  numb_trips,
  
  LAG(numb_trips)
  OVER(PARTITION BY year_date ORDER BY year_date, month_date ASC) AS trips_from_previous_month
  FROM time_sample

),

