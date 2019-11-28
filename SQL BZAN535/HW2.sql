use rmee_dh;

##household_key, groupid, total sales, number of baskets (i.e., the number of
#shopping trips), the date of their first and last shopping trips (using the
#functions MIN and MAX), the average dollar sales per trip, and the average
#number of different items per trip.

SELECT *
FROM journey_transaction_data 
GROUP BY household_key
HAVING MIN(day) = MAX(day);

SELECT t.*, 
CASE WHEN dem.household_key then 1 ELSE 0 END AS groupid
FROM journey_hh_demographic dem
RIGHT JOIN
(SELECT household_key, SUM(sales_value) AS total$, COUNT(DISTINCT basket_id) AS Ntrips, 
MIN(day) AS first_Trip, MAX(day) AS last_Trip,
SUM(sales_value)/ COUNT(DISTINCT basket_id) AS average_sale,
COUNT( DISTINCT product_id)/COUNT(DISTINCT basket_id) AS item_per_trip,
(MAX(day)-MIN(day))/(COUNT(DISTINCT basket_id) -1) AS avrg_time_btw_trip
FROM journey_transaction_data
GROUP BY household_key
HAVING COUNT(DISTINCT basket_id) > 50) AS t
ON t.household_key = dem.household_key;

SELECT count(distinct basket_id), count(distinct f.household_key), count(distinct product_id), sum(sales_value)
FROM journey_hh_demographic t 
RIGHT JOIN
journey_transaction_data f
ON t.household_key = f.household_key
WHERE t.household_key is NULL
group by f.household_key;