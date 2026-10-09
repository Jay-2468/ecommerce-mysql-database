SELECT 
	MONTHNAME(o.order_purchase_timestamp) AS months,
	pcnt.product_category_name_english,
	SUM(oi.price) OVER(
		PARTITION BY MONTHNAME(o.order_purchase_timestamp), product_category_name_english
	) AS monthly_revenue
FROM orders o
JOIN order_items oi 
	ON o.order_id = oi.order_id
JOIN products p
	ON oi.product_id = p.product_id
JOIN product_category_name_translation pcnt
	ON p.product_category_name = pcnt.product_category_name
WHERE o.order_purchase_timestamp IS NOT NULL AND 
	p.product_category_name IS NOT NULL AND 
    oi.price IS NOT NULL
ORDER BY 2 DESC;
    
select 
	count(o.order_purchase_timestamp),
    count(p.product_category_name),
    count(oi.price)
FROM orders o
JOIN order_items oi 
	ON o.order_id = oi.order_id
JOIN products p
	ON oi.product_id = p.product_id
where o.order_purchase_timestamp is null or 
	p.product_category_name is null or 
    oi.price is null;