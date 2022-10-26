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


  # Calculate the gap

(
  SELECT *,
  numb_trips - trips_from_previous_month as gap
  FROM previous_record
  
),


  # Select a new table and its columns and calculate the percentage of gaps / changes
  pcent_gap AS 

(
  SELECT
  year_date,
  month_date,    
  numb_trips,
  numb_trips_prv_month,
  gap,
  ROUND((gap / numb_trips) * 100) AS pcent_gap,

  # Naming the months with CASE Statement
  CASE  WHEN month_date = 1 THEN 'January'
        WHEN month_date = 2 THEN 'February'
        WHEN month_date = 3 THEN 'March'
        WHEN month_date = 4 THEN 'April'
        WHEN month_date = 5 THEN 'May'
        WHEN month_date = 6 THEN 'June'
        WHEN month_date = 7 THEN 'July'
        WHEN month_date = 8 THEN 'August'
        WHEN month_date = 9 THEN 'September'
        WHEN month_date = 10 THEN 'October'
        WHEN month_date = 11 THEN 'November'
        WHEN month_date = 12 THEN 'December'
        
        ELSE NULL END AS month_date_name
  
  FROM month_gap
  
)


