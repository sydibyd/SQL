/*
Edited: 2022/07/26
Saeid SHARIFY
From:
Capstone project | Google Data Analytics professionnal certificate  

The goal: to identify what percentage of the company's total orders are been fulfilled by each warehouse. 
Topic: Writing complex Query, using Subqueries, JOIN, and CASE statments.  

Two datasets are manipulated in this example:
  1. Warehouse-Orders---Orders.csv
  
        Table ID: capstone-project-356415.JOINs.orders 
        Table size: 390.59 KB 
        Number of rows: 9,999
        5 Columns: order_id, customer_id,	warehouse_id,	order_date,	shipper_date
  
  2. Warehouse-Orders---Warehouse.csv
        Table ID: capstone-project-356415.JOINs.warehouse 
        Table size: 550 B 
        Number of rows: 10
        5 Columns: warehouse_id,	warehouse_alias,	maximum_capacity,	employee_total,	state
*/



# SELECT
# Select 3 columns and add them into the output table:
# 1. warehouse_id 2. warehouse_name 3. num_of_orders (for each warehouse)
# Add state and warehouse_alias strings together create warehouse_name
# Count number of orders

SELECT
  Warehouse.warehouse_id,
  CONCAT(Warehouse.state, ': ',Warehouse.warehouse_alias) AS warehouse_name,
  COUNT(Orders.order_id) AS num_of_orders,


# SUBQUERY
# To calculate and add a new column into the output table:
# 4. total_order (of all warehouses)

  (SELECT
    COUNT(*)
   FROM `capstone-project-356415.JOINs.orders` AS Orders
  )  AS total_orders,
  
  # CASE Statements
  # To compare, filter and add a new column into the output table:
  # 5. fulfillment_state (identifying fulfillment of each warehouse)

  CASE
    WHEN COUNT(Orders.order_id)/(SELECT COUNT(*) FROM `capstone-project-356415.JOINs.orders` AS Orders) <= 0.20
    THEN "fulfilled 0-20% of Others"
    WHEN COUNT(Orders.order_id)/(SELECT COUNT(*) FROM `capstone-project-356415.JOINs.orders` AS Orders) > 0.20
    AND  COUNT(Orders.order_id)/(SELECT COUNT(*) FROM `capstone-project-356415.JOINs.orders` AS Orders) <= 0.60
    THEN "fulfilled 21-60% of Others"
      ELSE "fulfilled more than 60% of Orders"
  END AS fulfillment_state

# JOIN
# LEFT JOINT to aggregate all information from the Warehouse date, even if the data isn't in the Orders table.

FROM `capstone-project-356415.JOINs.warehouse` AS Warehouse
LEFT JOIN `capstone-project-356415.JOINs.orders` AS Orders
  ON Orders.warehouse_id = Warehouse.warehouse_id

# GROUP BY
# To group the output data by the warehouse_id and warehouse_name.

GROUP BY
  Warehouse.warehouse_id,
  warehouse_name

# Having
# To take into account only the activated warehouses having at least 1 order or more.
HAVING
  COUNT(Orders.order_id) >=1

ORDER BY
  num_of_orders DESC

#end
