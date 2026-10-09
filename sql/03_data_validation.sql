-- ============================
-- Counting rows of each table 
-- ============================
SELECT 'customers' AS table_name, COUNT(1) as row_count FROM customers

UNION ALL

SELECT 'geolocation', COUNT(1) FROM geolocation

UNION ALL

SELECT 'products', COUNT(1) FROM products 

UNION ALL

SELECT 'orders', COUNT(1) FROM orders

UNION ALL

SELECT 'sellers', COUNT(1) FROM sellers

UNION ALL

SELECT 'product_category_name_translation', COUNT(1) FROM product_category_name_translation

UNION ALL

SELECT 'order_reviews', COUNT(1) FROM order_reviews

UNION ALL

SELECT 'order_items', COUNT(1) FROM order_items

UNION ALL

SELECT 'order_payments', COUNT(1) FROM order_payments;

-- ==============================
-- Primary Key uniqueness check
-- ==============================
SELECT customer_id, COUNT(1) AS cnt
FROM customers
GROUP BY customer_id
HAVING COUNT(1) > 1;

SELECT order_id, COUNT(1) AS cnt
FROM orders
GROUP BY order_id
HAVING COUNT(1) > 1;

SELECT product_id, COUNT(1) AS cnt
FROM products
GROUP BY product_id
HAVING COUNT(1) > 1;

SELECT seller_id, COUNT(1) AS cnt
FROM sellers
GROUP BY seller_id
HAVING COUNT(1) > 1;

SELECT order_id, order_item_id, COUNT(1) AS cnt
FROM order_items
GROUP BY 1, 2
HAVING COUNT(1) > 1;

SELECT product_category_name, COUNT(1) AS cnt
FROM product_category_name_translation
GROUP BY 1
HAVING COUNT(1) > 1;

SELECT order_id, payment_sequential, COUNT(1) AS cnt
FROM order_payments
GROUP BY 1, 2
HAVING COUNT(1) > 1;

SELECT review_id, COUNT(1) AS cnt
FROM order_reviews
GROUP BY 1
HAVING COUNT(1) > 1; 

-- =======================
-- Checking NULL Values
-- =======================
SELECT
    COUNT(1) AS total_customers,
    SUM(customer_id IS NULL) AS missing_customer_id,
    SUM(customer_unique_id IS NULL) AS missing_customer_unique_id,
    SUM(customer_zip_code_prefix IS NULL) AS missing_zip,
    SUM(customer_city IS NULL) AS missing_city,
    SUM(customer_state IS NULL) AS missing_state
FROM customers;

SELECT
    COUNT(1) AS total_geolocation,
    SUM(geolocation_zip_code_prefix IS NULL) AS missing_zip,
    SUM(geolocation_lat IS NULL) AS missing_latitude,
    SUM(geolocation_lng IS NULL) AS missing_longitude,
    SUM(geolocation_city IS NULL) AS missing_city,
    SUM(geolocation_state IS NULL) AS missing_state
FROM geolocation;

SELECT
    COUNT(1) AS total_products,
    SUM(product_id IS NULL) AS missing_product_id,
    SUM(product_category_name IS NULL) AS missing_category,
    SUM(product_name_length IS NULL) AS missing_name_length,
    SUM(product_description_length IS NULL) AS missing_description_length,
    SUM(product_photos_qty IS NULL) AS missing_photos_qty,
    SUM(product_weight_g IS NULL) AS missing_weight,
    SUM(product_length_cm IS NULL) AS missing_length,
    SUM(product_height_cm IS NULL) AS missing_height,
    SUM(product_width_cm IS NULL) AS missing_width
FROM products;

SELECT
    COUNT(1) AS total_categories,
    SUM(product_category_name IS NULL) AS missing_category_name,
    SUM(product_category_name_english IS NULL) AS missing_english_name
FROM product_category_name_translation;

SELECT
    order_status,
    COUNT(1) AS total_orders,
    SUM(order_id IS NULL) AS missing_order_id,
    SUM(customer_id IS NULL) AS missing_customer_id,
    SUM(order_status IS NULL) AS missing_order_status,
    SUM(order_approved_at IS NULL) AS missing_approved_at,
    SUM(order_delivered_carrier_date IS NULL) AS missing_carrier_date,
    SUM(order_delivered_customer_date IS NULL) AS missing_delivery_date,
    SUM(order_estimated_delivery_date IS NULL) AS missing_estimated_date
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;

SELECT
    COUNT(1) AS total_items,
    SUM(order_id IS NULL) AS missing_order_id,
    SUM(order_item_id IS NULL) AS missing_order_item_id,
    SUM(product_id IS NULL) AS missing_product_id,
    SUM(seller_id IS NULL) AS missing_seller_id,
    SUM(shipping_limit_date IS NULL) AS missing_shipping_limit_date,
    SUM(price IS NULL) AS missing_price,
    SUM(freight_value IS NULL) AS missing_freight_value
FROM order_items;

SELECT
    COUNT(1) AS total_payments,
    SUM(order_id IS NULL) AS missing_order_id,
    SUM(payment_sequential IS NULL) AS missing_payment_sequential,
    SUM(payment_type IS NULL) AS missing_payment_type,
    SUM(payment_installments IS NULL) AS missing_payment_installments,
    SUM(payment_value IS NULL) AS missing_payment_value
FROM order_payments;

SELECT
    COUNT(1) AS total_reviews,
    SUM(review_id IS NULL) AS missing_review_id,
    SUM(order_id IS NULL) AS missing_order_id,
    SUM(review_score IS NULL) AS missing_review_score,
    SUM(review_comment_title IS NULL) AS missing_comment_title,
    SUM(review_comment_message IS NULL) AS missing_comment_message,
    SUM(review_creation_date IS NULL) AS missing_creation_date,
    SUM(review_answer_timestamp IS NULL) AS missing_answer_timestamp
FROM order_reviews;

-- =========================================
-- Data Integrity checking
-- Checking relationships between tables
-- =========================================
-- Orders without a customer
SELECT COUNT(1) AS orphan_orders
FROM orders o 
LEFT JOIN customers c
	ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Orders without an order
SELECT COUNT(1) AS orphan_order_items
FROM order_items oi
LEFT JOIN orders o	
	ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Orders without a product
SELECT COUNT(1) AS orpahn_order_items
FROM order_items oi
LEFT JOIN products p
	ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

-- Orders withou a seller
SELECT COUNT(1) AS orpahn_order_items
FROM order_items oi
LEFT JOIN sellers s
	ON oi.seller_id = s.seller_id
WHERE s.seller_id IS NULL;

-- Payments without an order
SELECT COUNT(1) AS orphan_order_payments
FROM order_payments op 
LEFT JOIN orders o
	ON op.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Review without an order
SELECT COUNT(1) AS orpahn_order_payments
FROM order_reviews ore
LEFT JOIN orders o
	ON ore.order_id = o.order_id
WHERE o.order_id IS NULL;