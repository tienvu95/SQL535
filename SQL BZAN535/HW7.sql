USE rmee_dh;

SELECT household, count(distinct basket) as trips, sum(dollar_sales) as sales, sum(units) as units 
FROM carbo_transactions 
WHERE geography = 1 
GROUP BY household 
HAVING trips > 23; 

SELECT upc, week, sum(units)
FROM carbo_transactions 
WHERE upc in (3620000350, 3620000439) and geography = 1
GROUP by upc, week; 

SELECT * 
FROM carbo_product_lookup 
WHERE upc in (3620000350, 3620000439);