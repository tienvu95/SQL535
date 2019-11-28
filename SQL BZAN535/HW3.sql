use rmee_dh;

SELECT *
FROM journey_product
WHERE commodity_desc = "SOFT DRINKS"
AND sub_commodity_desc LIKE "S%";


USE rmee_sqlbook;
SELECT state, zc.zipcode, longitude, latitude, numords, hh,
(CASE WHEN hh = 0 THEN 0.0 ELSE numords*1000/hh END) as penetration
FROM zipcensus zc JOIN
(SELECT zipcode, COUNT(*) as numords
FROM orders
GROUP BY zipcode) o
ON zc.zipcode = o.zipcode
WHERE latitude BETWEEN 20 and 50 AND longitude BETWEEN -135 AND -65;

SELECT * FROM orders LIMIT 100;
SELECT * FROM zipcensus LIMIT 100;