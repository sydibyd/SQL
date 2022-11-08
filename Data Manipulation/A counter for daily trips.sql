/*
File Name: A counter for daily trips 
Editor: Saeid Sharify
Date: 2022/10/16
*/

# ---- ---- ---- ---- ---- ---- ---- ----
# Select a time interval in data and extract years, days of month
WITH all_trips AS

(

  SELECT
  EXTRACT(year FROM starttime) AS year,
  SUBSTR(STRING(EXTRACT(DATE FROM starttime)), 6,5) AS day_of_month,
  tripduration,
  bikeid,
  
  EXTRACT(DATE FROM starttime) AS date_of_trips
  
  FROM `project_name.dataset_name.table_name`

  WHERE
  starttime
  BETWEEN '2010-01-01T00:00:00'
  AND '2020-12-31T23:59:59'
    
),

  -- Set a register to calculate and save daily trips for all bikes
  counter AS

(
  
  SELECT
  year,
  day_of_month,

  COUNT(bikeid) AS numbr_of_trips
  
  FROM all_trips
  
  GROUP BY year,day_of_month
  
),

