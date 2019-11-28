USE rmee_dh;

SELECT week, brand, avg(dollar_sales/units)
FROM carbo_transactions t
JOIN carbo_product_lookup p
ON t.upc = p.upc
WHERE commodity = "syrups" AND brand IN ('Aunt Jemima', 'Hungry Jack', 'Karo', 'Log Cabin', 'Mrs Butterworth') AND geography = 2
GROUP BY week, brand
ORDER BY brand, week;

SELECT week, avg(dollar_sales/units)
FROM carbo_transactions t
JOIN carbo_product_lookup p
ON t.upc = p.upc
WHERE commodity = "syrups" AND brand IN ('Private Label', 'Private Label Premium', 'Private Label Value') AND geography = 2
GROUP BY week;

SELECT week,avg(dollar_sales/units)
FROM carbo_transactions t
JOIN carbo_product_lookup p
ON t.upc = p.upc
WHERE commodity = "syrups" AND brand != 'Karo' AND geography = 2
GROUP BY week;

SELECT week, SUM(dollar_sales)
FROM carbo_transactions t
JOIN carbo_product_lookup p
ON t.upc = p.upc
WHERE commodity = "syrups" AND brand NOT IN ('Aunt Jemima', 'Hungry Jack', 'Karo', 'Log Cabin', 'Mrs Butterworth','Private Label', 'Private Label Premium', 'Private Label Value') AND geography = 1
GROUP BY week;

SELECT week, SUM(dollar_sales)
FROM carbo_transactions t
JOIN carbo_product_lookup p
ON t.upc = p.upc
WHERE commodity = "syrups" AND brand IN ('Aunt Jemima', 'Hungry Jack', 'Log Cabin', 'Mrs Butterworth','Private Label', 'Private Label Premium', 'Private Label Value') AND geography = 1
GROUP BY week;

SELECT week, avg(dollar_sales/units)
FROM carbo_transactions
WHERE upc = 6172005110 AND geography = 2
GROUP BY week;

SELECT week, count(*)
FROM carbo_transactions
WHERE upc = 6172005110 AND geography = 2 AND units > 1
GROUP BY week
order by week;


SELECT week, (dollar_sales/units), SUM(units)
FROM carbo_transactions t
JOIN carbo_product_lookup p
ON t.upc = p.upc
WHERE commodity = "syrups" AND geography = 2
GROUP BY week;