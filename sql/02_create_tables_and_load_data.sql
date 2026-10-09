SET GLOBAL local_infile = 1;
SHOW GLOBAL VARIABLES LIKE 'local_infile';

CREATE TABLE customers (
	customer_id VARCHAR(50) PRIMARY KEY, 
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(50),
    customer_state CHAR(2)
);

LOAD DATA LOCAL INFILE 'D:/Projects/Ecommerce MySQL Database/olist_customers_dataset.csv'
INTO TABLE customers
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@c_id, @customer_unique_id, @zip, @city, @state)
SET
	customer_id = TRIM(@c_id),
    customer_unique_id = NULLIF(TRIM(@customer_unique_id), ''),
    customer_zip_code_prefix = CASE
        WHEN TRIM(@zip) REGEXP '^[0-9]+$'
        THEN CAST(TRIM(@zip) AS UNSIGNED)
        ELSE NULL
    END,
    customer_city = NULLIF(TRIM(@city), ''),
    customer_state = NULLIF(TRIM(@state), '');


-- ======================================================
CREATE TABLE geolocation (
	geolocation_zip_code_prefix CHAR(5),
    geolocation_lat DECIMAL(18, 15),
    geolocation_lng DECIMAL(18,15),
    geolocation_city VARCHAR(50),
    geolocation_state CHAR(2)
);

LOAD DATA LOCAL INFILE 'D:/Projects/Ecommerce MySQL Database/olist_geolocation_dataset.csv'
INTO TABLE geolocation
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@zip_code, @lat, @lng, @city, @state)
SET
	geolocation_zip_code_prefix = NULLIF(TRIM(@zip_code), ''),
    geolocation_lat = NULLIF(TRIM(@lat), ''),
    geolocation_lng = NULLIF(TRIM(@lng), ''),
    geolocation_city = NULLIF(TRIM(@city), ''),
    geolocation_state = NULLIF(TRIM(@state), ''); 
    
    
-- ======================================================
CREATE TABLE orders (
	order_id VARCHAR(50) PRIMARY KEY,
    customer_id VARCHAR(50) NOT NULL,
    order_status VARCHAR(20),
	order_purchase_timestamp DATETIME,
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME,
    
    CONSTRAINT fk_customer_id 
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

LOAD DATA LOCAL INFILE 'D:/Projects/Ecommerce MySQL Database/olist_orders_dataset.csv'
INTO TABLE orders
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@o_id, @c_id, @status, @purchase_ts, @approved_at, @carrier_date, @customer_date, @delivery_date)
SET 
	order_id = TRIM(@o_id),
    customer_id = NULLIF(TRIM(@c_id), ''),
    order_status = NULLIF(TRIM(@status), ''),
    order_purchase_timestamp = NULLIF(TRIM(@purchase_ts), ''),
    order_approved_at = NULLIF(TRIM(@approved_at), ''),
    order_delivered_carrier_date = NULLIF(TRIM(@carrier_date), ''),
    order_delivered_customer_date = NULLIF(TRIM(@customer_date), ''),
    order_estimated_delivery_date = NULLIF(TRIM(@delivery_date), '');


-- ======================================================
CREATE TABLE product_category_name_translation (
	product_category_name VARCHAR(50) UNIQUE NOT NULL,
    product_category_name_english VARCHAR(50) NOT NULL
);

LOAD DATA LOCAL INFILE 'D:/Projects/Ecommerce MySQL Database/product_category_name_translation.csv'
INTO TABLE product_category_name_translation
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@cat_name, @cat_name_eng)
SET 
	product_category_name = TRIM(@cat_name),
    product_category_name_english = TRIM(@cat_name_eng);


-- ======================================================
CREATE TABLE products (
	product_id VARCHAR(50) PRIMARY KEY,
    product_category_name VARCHAR(50),
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);

LOAD DATA LOCAL INFILE 'D:/Projects/Ecommerce MySQL Database/olist_products_dataset.csv'
INTO TABLE products
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@p_id, @cat_name, @name_len, @desc_len, @qty, @weight, @length, @height, @width)
SET
    product_id = NULLIF(TRIM(@p_id), ''),
    
    product_category_name = NULLIF(TRIM(@cat_name), ''),
    
    product_name_length = CASE
        WHEN TRIM(@name_len) REGEXP '^[0-9]+$'
        THEN CAST(TRIM(@name_len) AS UNSIGNED)
        ELSE NULL
    END,
    
    product_description_length = CASE
        WHEN TRIM(@desc_len) REGEXP '^[0-9]+$'
        THEN CAST(TRIM(@desc_len) AS UNSIGNED)
        ELSE NULL
    END,
    
    product_photos_qty = CASE
        WHEN TRIM(@qty) REGEXP '^[0-9]+$'
        THEN CAST(TRIM(@qty) AS UNSIGNED)
        ELSE NULL
    END,
    
    product_weight_g = CASE
        WHEN TRIM(@weight) REGEXP '^[0-9]+$'
        THEN CAST(TRIM(@weight) AS UNSIGNED)
        ELSE NULL
    END,
    
    product_length_cm = CASE
        WHEN TRIM(@length) REGEXP '^[0-9]+$'
        THEN CAST(TRIM(@length) AS UNSIGNED)
        ELSE NULL
    END,
    
    product_height_cm = CASE
        WHEN TRIM(@height) REGEXP '^[0-9]+$'
        THEN CAST(TRIM(@height) AS UNSIGNED)
        ELSE NULL
    END,
    
    product_width_cm = CASE
        WHEN TRIM(@width) REGEXP '^[0-9]+$'
        THEN CAST(TRIM(@width) AS UNSIGNED)
        ELSE NULL
    END;


-- ======================================================
CREATE TABLE sellers (
    seller_id VARCHAR(50) PRIMARY KEY,
    seller_zip_code_prefix CHAR(5),
    seller_city VARCHAR(60),
    seller_state CHAR(2)
);

LOAD DATA LOCAL INFILE 'D:/Projects/Ecommerce MySQL Database/olist_sellers_dataset.csv'
INTO TABLE sellers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@s_id, @zip_code, @city, @state)
SET 
	seller_id = TRIM(@s_id),
    seller_zip_code_prefix = NULLIF(TRIM(@zip_code), ''),
    seller_city = NULLIF(TRIM(@city), ''),
    seller_state = NULLIF(TRIM(@state), '');
    

-- ======================================================
CREATE TABLE order_items (
	order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date DATETIME,
    price DECIMAL(10, 2),
    freight_value DECIMAL(10, 2),
	
	PRIMARY KEY (order_id, order_item_id),
    CONSTRAINT fk_product_id FOREIGN KEY (product_id) REFERENCES products(product_id),
    CONSTRAINT fk_seller_id FOREIGN KEY (seller_id) REFERENCES sellers(seller_id)
);

LOAD DATA LOCAL INFILE 'D:/Projects/Ecommerce MySQL Database/olist_order_items_dataset.csv'
INTO TABLE order_items
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS 
(@o_id, @o_item_id, @p_id, @s_id, @limit_date, @price, @freight_value)
SET 
	order_id = TRIM(@o_id),
    order_item_id = TRIM(@o_item_id), 
    product_id = NULLIF(TRIM(@p_id), ''), 
    seller_id = NULLIF(TRIM(@s_id), ''), 
    shipping_limit_date = NULLIF(TRIM(@limit_date), ''), 
    price = NULLIF(TRIM(@price), ''), 
    freight_value = NULLIF(TRIM(@freight_value), '');


-- ======================================================
CREATE TABLE order_payments (
	order_id VARCHAR(50),
    payment_sequential INT,
    payment_type VARCHAR(50),
    payment_installments INT,
    payment_value DECIMAL(10, 2),
    
    PRIMARY KEY (order_id, payment_sequential),
    CONSTRAINT fk_order_id FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

LOAD DATA LOCAL INFILE 'D:/Projects/Ecommerce MySQL Database/olist_order_payments_dataset.csv'
INTO TABLE order_payments
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@o_id, @pay_seq, @pay_type, @pay_install, @pay_value)
SET
	 order_id = TRIM(@o_id),
     payment_sequential = TRIM(@pay_seq),
     payment_type = NULLIF(TRIM(@pay_type), ''),
     payment_installments = NULLIF(TRIM(@pay_install), ''),
     payment_value = NULLIF(TRIM(@pay_value) , '');
     
     
-- ======================================================
CREATE TABLE order_reviews (
	review_id VARCHAR(50) PRIMARY KEY,
    order_id VARCHAR(50),
    review_score INT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date DATETIME,
    review_answer_timestamp DATETIME,
    
    CONSTRAINT fk_order_id_order_reviews FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

LOAD DATA LOCAL INFILE 'D:/Projects/Ecommerce MySQL Database/olist_order_reviews_dataset.csv'
INTO TABLE order_reviews
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@r_id, @o_id, @r_score, @comment_title, @comment_message, @r_creation_date, @r_answer_timestamp)
SET 
	review_id = TRIM(@r_id),
    order_id = NULLIF(TRIM(@o_id), ''),
    review_score = NULLIF(TRIM(@r_score), ''),
    review_comment_title = NULLIF(TRIM(@comment_title), ''),
    review_comment_message = NULLIF(TRIM(@comment_message), ''),
    review_creation_date = NULLIF(TRIM(@r_creation_date), ''),
    review_answer_timestamp = NULLIF(TRIM(@r_answer_timestamp), '');
