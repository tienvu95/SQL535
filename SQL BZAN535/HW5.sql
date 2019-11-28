use rmee_dh;



SELECT SUM(dollar_sales) AS total_sales, t.store AS Store, t.week AS Week
FROM carbo_transactions t
JOIN
(SELECT * FROM carbo_store_lookup 
WHERE zipcode = "30606") AS s
ON t.store = s.store
GROUP BY t.store,Week
ORDER BY 2;

SELECT SUM(dollar_sales) AS total_sales, t.store AS Store, t.week AS Week
FROM carbo_transactions t
JOIN
(SELECT * FROM carbo_store_lookup 
WHERE zipcode = "40502") AS s
ON t.store = s.store
GROUP BY t.store,Week
ORDER BY 2;

SELECT SUM(dollar_sales) AS total_sales, store AS Store, week 
FROM carbo_transactions 
WHERE store = "229" OR store ="321"
GROUP BY store,Week
ORDER BY 2;


SELECT SUM(dollar_sales) AS total_sales, store AS Store, week 
FROM carbo_transactions 
WHERE store = "330" OR store ="331"
GROUP BY store,Week
ORDER BY 2;