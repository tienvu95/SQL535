USE rmee_dh;

SELECT * 
FROM journey_product
WHERE sub_commodity_desc IN ('BEERALEMALT LIQUORS', 'BABY DIAPERS');


SELECT * FROM journey_transaction_data
WHERE basket_id NOT IN 
(SELECT basket_id FROM journey_transaction_data t
JOIN
(SELECT * FROM journey_product
WHERE sub_commodity_desc = 'GASOLINE-REG UNLEADED') p
ON t.product_id = p.product_id
GROUP by basket_id)
AND basket_id NOT IN 
(SELECT basket_id FROM journey_transaction_data t
JOIN
(SELECT * FROM journey_product
WHERE sub_commodity_desc IN ('BEERALEMALT LIQUORS', 'BABY DIAPERS')) p
ON t.product_id = p.product_id
GROUP by basket_id)
GROUP by basket_id; 

SELECT basket_id FROM journey_transaction_data t
JOIN
(SELECT * FROM journey_product
WHERE sub_commodity_desc = 'BABY DIAPERS') p
ON t.product_id = p.product_id;


SELECT sum(Milk*Soft_drinks)*count(*)/(sum(Milk)*sum(Soft_drinks)) AS lift
FROM 
(SELECT sum(sales_value) AS sales, basket_id, 
max(case when commodity_desc = 'FLUID MILK PRODUCTS' then 1 else 0 end) Milk, 
max(case when commodity_desc='SOFT DRINKS' then 1 else 0 end) Soft_drinks, 
max(case when sub_commodity_desc = 'GASOLINE-REG UNLEADED' then 1 else 0 end) Gas
FROM journey_transaction_data jt 
JOIN journey_product jp 
ON jt.product_id=jp.product_id
GROUP BY basket_id HAVING GAS = 0 ) a;

