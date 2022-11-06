/*
File Name: Over time observations
Editor: Saeid Sharify
Date: 2022/10/16
*/

# Select a time interval in data and extract years and days
WITH time_intrval AS

(

  SELECT
  EXTRACT(year FROM starttime) AS year,
  EXTRACT(dayofweek FROM starttime) AS day
  
  FROM`bigquery-public-data.new_york_citibike.citibike_trips`
  #FROM `project_name.dataset_name.table_name`
  
  WHERE
  starttime
  BETWEEN '2010-01-01T00:00:00'
  AND '2020-12-31T23:59:59'
  
),
