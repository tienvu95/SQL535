use rmee_dh;

SELECT week_no, day, COUNT(DISTINCT household_key), 
COUNT(DISTINCT basket_id), SUM(sales_value)
FROM journey_transaction_data
WHERE week_no >= 16
GROUP BY week_no, day;


