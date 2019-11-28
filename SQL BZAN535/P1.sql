USE rmee_dh;

SELECT household_key, basket_id, day, COUNT(*) AS Number_items, 
COUNT(DISTINCT product_id) AS No_uniq_items,
SUM(quantity) AS total_quantity, SUM(sales_value) AS total_$sales,
store_id, SUM(coupon_match_disc) AS Matching_discount, 
SUM(coupon_disc) AS manufacturer_discount, SUM(retail_disc) AS retailer_discount,
trans_time, week_no
FROM journey_transaction_data 
GROUP BY basket_id
ORDER BY household_key, week_no, day, trans_time;

SELECT household_key, basket_id, day, COUNT(*) AS Number_items, 
COUNT(DISTINCT product_id) AS No_uniq_items,
SUM(quantity) AS total_quantity, SUM(sales_value) AS total_$sales,
store_id, SUM(coupon_match_disc) AS Matching_discount, 
SUM(coupon_disc) AS manufacturer_discount, SUM(retail_disc) AS retailer_discount,
trans_time, week_no
FROM journey_transaction_data
WHERE retail_disc = 0 AND coupon_disc = 0 AND coupon_match_disc = 0
GROUP BY basket_id
ORDER BY household_key, week_no, day, trans_time;

SELECT household_key, COUNT(distinct product_id)
FROM journey_transaction_data
GROUP BY household_key;



SELECT household_key, COUNT(distinct product_id)
FROM journey_transaction_data 
GROUP BY household_key;

SELECT household_key, COUNT(distinct basket_id)
FROM journey_transaction_data 
GROUP BY household_key;

SELECT * FROM journey_product WHERE sub_commodity_desc = 'GASOLINE-REG UNLEADED';

SELECT * FROM journey_product WHERE manufacturer = 69;

SELECT * FROM journey_transaction_data 
WHERE product_id IN ('202291','259120','397896','418530','420647','480014','511273','545926','707683','731106','1153346','1211227','1388206','1404121','1426702','2690723','2848087','5668957','5668996','5703832','5712216','5714802','5716076','5747233','5747420','5845857','5850988','6410462','6410464','6430664','6533765','6533889','6534166','6534178','6544236');


SELECT j.household_key, basket_id, day, COUNT(*) AS Number_items, 
COUNT(DISTINCT j.product_id) AS No_uniq_items,
SUM(quantity) AS total_quantity, SUM(sales_value) AS total_$sales,
store_id, SUM(coupon_match_disc) AS Matching_discount, 
SUM(coupon_disc) AS manufacturer_discount, SUM(retail_disc) AS retailer_discount,
trans_time, week_no
FROM journey_transaction_data j JOIN 
(SELECT product_id FROM journey_product
WHERE department = "SEAFOOD") p
ON j.product_id = p.product_id
GROUP BY j.basket_id
ORDER BY household_key, week_no, day, trans_time;

SELECT * FROM journey_product
WHERE department = 'DELI'
ORDER BY 1 DESC; 