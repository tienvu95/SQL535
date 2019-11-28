USE rmee_dh;

#query 1
SELECT count(distinct upc) AS number_of_upc , count(distinct brand) AS number_of_brand,commodity
FROM carbo_product_lookup
GROUP BY commodity;

#query 2
SELECT pasta.brand, number_of_pasta , number_of_sauce 

FROM 

( SELECT brand,commodity, count(upc) as number_of_pasta 
FROM carbo_product_lookup
WHERE commodity IN ("pasta")
GROUP BY brand) AS pasta

 INNER JOIN 
 
 (SELECT brand,commodity, count(upc) as number_of_sauce 
FROM carbo_product_lookup
WHERE commodity IN ("pasta sauce")
GROUP BY brand) AS sauce

ON pasta.brand = sauce.brand;

#query 3
SELECT t.upc, SUM(dollar_sales) AS total_$sales, SUM(units) AS total_units
FROM carbo_transactions t
JOIN carbo_product_lookup p
on t.upc = p.upc
WHERE commodity = "pasta"
GROUP BY upc
ORDER BY total_$sales DESC
LIMIT 25;

SELECT SUM(dollar_sales) AS total_$sales, SUM(units) AS total_units
FROM carbo_transactions t
JOIN carbo_product_lookup p
on t.upc = p.upc
WHERE commodity = "pasta";

#query 4

SELECT brand, SUM(dollar_sales) AS total_$sales, SUM(units) AS total_units, SUM(dollar_sales)/SUM(units) AS average_price
FROM carbo_transactions t
JOIN carbo_product_lookup p
on t.upc = p.upc
WHERE commodity = "pasta"
GROUP BY brand
ORDER BY total_$sales DESC
LIMIT 26;

#query 5

SELECT m.*
FROM 
(SELECT brand, SUM(dollar_sales) AS total_$sales, SUM(units) AS total_unitsales, SUM(dollar_sales)/SUM(units) AS average_price
FROM carbo_transactions t
JOIN carbo_product_lookup p
on t.upc = p.upc
WHERE commodity = "pasta"
GROUP BY brand) AS m
WHERE brand IN 
(SELECT pasta.brand FROM
( SELECT brand
FROM carbo_product_lookup
WHERE commodity IN ("pasta")
GROUP BY brand) AS pasta
 LEFT JOIN 
 (SELECT brand
FROM carbo_product_lookup
WHERE commodity IN ("pasta sauce")
GROUP BY brand) AS sauce
ON pasta.brand = sauce.brand
WHERE sauce.brand is NULL)
GROUP BY brand
ORDER BY total_$sales DESC;

SELECT brand, SUM(dollar_sales) AS total_$sales, SUM(units) AS total_units, SUM(dollar_sales)/SUM(units) AS average_price
FROM carbo_transactions t
JOIN carbo_product_lookup p
on t.upc = p.upc
WHERE commodity = "pasta sauce"
GROUP BY brand
ORDER BY total_$sales DESC
LIMIT 26;


SELECT m.*
FROM 
(SELECT brand, SUM(dollar_sales) AS total_$sales, SUM(units) AS total_unitsales, SUM(dollar_sales)/SUM(units) AS average_price
FROM carbo_transactions t
JOIN carbo_product_lookup p
on t.upc = p.upc
WHERE commodity = "pasta sauce"
GROUP BY brand) AS m
WHERE brand IN 
(SELECT pasta.brand FROM
( SELECT brand
FROM carbo_product_lookup
WHERE commodity IN ("pasta")
GROUP BY brand) AS pasta
 INNER JOIN 
 (SELECT brand
FROM carbo_product_lookup
WHERE commodity IN ("pasta sauce")
GROUP BY brand) AS sauce
ON pasta.brand = sauce.brand)
GROUP BY brand
ORDER BY total_$sales DESC;



#query 6
SELECT t.upc, total_stores,total_$sales, product_description, brand
FROM 
(SELECT upc,sum(dollar_sales) as total_$sales, COUNT(DISTINCT store) as total_stores
FROM carbo_transactions 
WHERE dollar_sales > 0
GROUP BY upc) AS t
JOIN carbo_product_lookup p
ON t.upc = p.upc
WHERE commodity = "pasta"
HAVING total_stores < 100
ORDER BY total_$sales DESC
LIMIT 1;

#query 6 checking
SELECT upc, sum(dollar_sales), COUNT(DISTINCT store) as total_stores
FROM carbo_transactions 
WHERE dollar_sales > 0
GROUP BY upc
ORDER BY 2 DESC;

#query 7

SELECT t.upc, COUNT(DISTINCT store) AS total_stores, sum(dollar_sales) as total_$sales,sum(dollar_sales)/COUNT(DISTINCT store) AS average_revenue
FROM carbo_transactions t
JOIN carbo_product_lookup p
ON t.upc = p.upc
WHERE commodity = "pasta"
AND brand = "San Giorgio"
GROUP BY t.upc
ORDER BY total_$sales DESC
LIMIT 6;

SELECT brand, COUNT(DISTINCT t.store), COUNT(DISTINCT zipcode), COUNT(DISTINCT p.upc),
SUM(dollar_sales) AS total_$sales, SUM(units) AS total_unitsales, 
SUM(dollar_sales)/SUM(units) AS average_price, SUM(dollar_sales)/COUNT(DISTINCT t.store) AS average_revenue
FROM carbo_transactions t
JOIN carbo_product_lookup p
on t.upc = p.upc
JOIN carbo_store_lookup s
on t.store = s.store
WHERE commodity = "pasta"
GROUP BY brand
ORDER BY average_revenue DESC
LIMIT 10;


SELECT t.upc, total_stores,total_$sales, product_description, brand,total_$sales/total_stores,total_$sales/total_unit
FROM 
(SELECT upc,sum(dollar_sales) as total_$sales, COUNT(DISTINCT store) as total_stores, SUM(units) AS total_unit
FROM carbo_transactions 
WHERE dollar_sales > 0
GROUP BY upc) AS t
JOIN carbo_product_lookup p
ON t.upc = p.upc
WHERE commodity = "pasta"
HAVING total_stores > 90 AND total_stores < 200
ORDER BY 6 DESC
LIMIT 25;

SELECT t.upc, total_stores,total_$sales, brand,total_$sales/total_stores,total_$sales/total_unit
FROM 
(SELECT upc,sum(dollar_sales) as total_$sales, COUNT(DISTINCT store) as total_stores, SUM(units) AS total_unit
FROM carbo_transactions 
WHERE dollar_sales > 0
GROUP BY upc) AS t
JOIN carbo_product_lookup p
ON t.upc = p.upc
WHERE commodity = "pasta"
HAVING total_stores < 150 AND total_stores >50
ORDER BY 5 DESC
LIMIT 25;

SELECT t.upc, total_stores,total_$sales, brand,total_$sales/total_stores,total_$sales/total_unit
FROM 
(SELECT upc,sum(dollar_sales) as total_$sales, COUNT(DISTINCT store) as total_stores, SUM(units) AS total_unit
FROM carbo_transactions 
WHERE dollar_sales > 0
GROUP BY upc) AS t
JOIN carbo_product_lookup p
ON t.upc = p.upc
WHERE commodity = "pasta"
ORDER BY 5 DESC
LIMIT 25;