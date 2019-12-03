USE rmee_dh;

#commodity sale % private vs national
SELECT sales1 AS Private_sale, sales2 AS National_sale, a.commodity_desc
FROM
(SELECT SUM(sales_value) AS sales1, commodity_desc, sub_commodity_desc, brand
FROM journey_transaction_data t 
JOIN journey_product p
ON t.product_id = p.product_id
WHERE brand = "Private"
GROUP BY commodity_desc) a
JOIN
(SELECT SUM(sales_value) AS sales2, commodity_desc, sub_commodity_desc, brand
FROM journey_transaction_data t 
JOIN journey_product p
ON t.product_id = p.product_id
WHERE brand = "National"
GROUP BY commodity_desc) b
ON a.commodity_desc = b.commodity_desc 
GROUP BY a.commodity_desc
ORDER BY 3 DESC;



#subcommodity sale % private vs national
SELECT (sales1+sales2) AS total, a.sub_commodity_desc, (SUM(sales1))/(SUM(sales1)+SUM(sales2))
FROM
(SELECT SUM(sales_value) AS sales1, commodity_desc, sub_commodity_desc, brand
FROM journey_transaction_data t 
JOIN journey_product p
ON t.product_id = p.product_id
WHERE brand = "Private"
GROUP BY sub_commodity_desc) a
LEFT JOIN
(SELECT SUM(sales_value) AS sales2, commodity_desc, sub_commodity_desc, brand
FROM journey_transaction_data t 
JOIN journey_product p
ON t.product_id = p.product_id
WHERE brand = "National"
GROUP BY sub_commodity_desc) b
ON a.sub_commodity_desc = b.sub_commodity_desc 
GROUP BY a.sub_commodity_desc
ORDER BY 3 DESC;

SELECT SUM(sales_value) AS sales1, commodity_desc, sub_commodity_desc, brand
FROM journey_transaction_data t 
JOIN journey_product p
ON t.product_id = p.product_id
WHERE brand = "Private"
GROUP BY sub_commodity_desc;

SELECT SUM(sales_value) AS sales2, commodity_desc, sub_commodity_desc, brand
FROM journey_transaction_data t 
JOIN journey_product p
ON t.product_id = p.product_id
WHERE brand = "National"
GROUP BY sub_commodity_desc;




#Loyalty card private
SELECT SUM(sales_value) AS total_sales, 
AVG((coupon_match_disc + coupon_disc + retail_disc)/(sales_value - retail_disc + coupon_match_disc))*(-1) AS discount_percentage, 
sub_commodity_desc, brand
FROM journey_transaction_data t
JOIN journey_product p
ON t.product_id = p.product_id
WHERE brand = "Private" and retail_disc != 0
GROUP BY sub_commodity_desc
ORDER BY 2 DESC;

#Loyalty card National
SELECT SUM(sales_value) AS total_sales, 
AVG((coupon_match_disc + coupon_disc + retail_disc)/(sales_value - retail_disc + coupon_match_disc))*(-1) AS discount_percentage, 
sub_commodity_desc, brand
FROM journey_transaction_data t
JOIN journey_product p
ON t.product_id = p.product_id
WHERE brand = "National" and retail_disc != 0
GROUP BY sub_commodity_desc
ORDER BY 2 DESC;


#Without loyalty card Private
SELECT SUM(sales_value) AS total_sales, 
AVG((coupon_match_disc + coupon_disc + retail_disc)/(sales_value - coupon_match_disc)*(-1)) AS discount_percentage, 
sub_commodity_desc, brand
FROM journey_transaction_data t
JOIN journey_product p
ON t.product_id = p.product_id
WHERE brand = "Private" and retail_disc = 0
GROUP BY sub_commodity_desc
ORDER BY 2 DESC;


#Without loyalty card National
SELECT SUM(sales_value) AS total_sales, 
AVG((coupon_match_disc + coupon_disc + retail_disc)/(sales_value - coupon_match_disc)*(-1)) AS discount_percentage, 
sub_commodity_desc, brand
FROM journey_transaction_data t
JOIN journey_product p
ON t.product_id = p.product_id
WHERE brand = "National" and retail_disc = 0
GROUP BY sub_commodity_desc
ORDER BY 2 DESC;

#Question 4 lift for basket worth more than $50
SELECT COUNT(distinct basket_id), sub_commodity_desc 
FROM journey_transaction_data t
JOIN journey_product p 
ON t.product_id = p.product_id
GROUP BY sub_commodity_desc ;


#question 3
SELECT COUNT(distinct c.basket_id), sub_commodity_desc 
FROM journey_transaction_data t 
RIGHT JOIN
(SELECT a.basket_id
FROM 
(SELECT basket_id, SUM(sales_value) AS total_sales
FROM journey_transaction_data t
GROUP BY basket_id) a
WHERE a.total_sales > 50) c
ON t.basket_id = c.basket_id
JOIN journey_product p 
ON t.product_id = p.product_id
GROUP BY sub_commodity_desc; 
 
SELECT COUNT(*) FROM
(SELECT basket_id, SUM(sales_value) AS total_sales
FROM journey_transaction_data t
GROUP BY basket_id) a
WHERE a.total_sales > 50;

SELECT * FROM journey_transaction_data
WHERE coupon_match_disc != 0 AND coupon_disc !=0 AND retail_disc != 0;


SELECT COUNT(distinct t.product_id), sub_commodity_desc FROM journey_transaction_data t
JOIN journey_product p ON t.product_id = p.	product_id
WHERE brand = "private"
GROUP BY sub_commodity_desc;


SELECT SUM(sales_value), SUM(coupon_match_disc + coupon_disc + retail_disc) AS discount, commodity_desc, sub_commodity_desc, brand
FROM journey_transaction_data t 
JOIN journey_product p
ON t.product_id = p.product_id
WHERE sub_commodity_desc = "MEAT SUPPLIES" AND brand = "National"
GROUP BY commodity_desc;


SELECT SUM(sales_value) FROM journey_transaction_data t
JOIN journey_product p
ON t.product_id = p.product_id
WHERE commodity_desc = "DELI SUPPLIES" AND brand = "Private";