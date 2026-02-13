/* ===========================
   Section 1: Staging & Structural Foundation
   =========================== */

select *
from retail_business.retail_sales;

-- 'Renaming Columns': 'standardising column names to ensure consistent and SQL-friendly structure'

ALTER TABLE retail_sales 
CHANGE `ï»¿transaction_id` transaction_id TEXT,
CHANGE `customers.age` customer_age INT, 
CHANGE `customers.gender` customer_gender TEXT, 
CHANGE `customers.city` customer_city TEXT, 
CHANGE `customers.email` customer_email TEXT, 
CHANGE `products.category` product_category TEXT, 
CHANGE `products.color` product_color TEXT, 
CHANGE `products.size` product_size TEXT, 
CHANGE `products.season` product_season TEXT, 
CHANGE `products.supplier` product_supplier TEXT, 
CHANGE `products.cost_price` cost_price DOUBLE, 
CHANGE `products.list_price` list_price DOUBLE;

-- 'Creating Clean Table': 'defining the refined table schema for improved clarity and downstream use'

create table retail_sales_v1
(transaction_id VARCHAR(50), 
date varchar(50),
quantity INT, 
discount DOUBLE, 
returned INT, 
customers_age INT, 
customers_gender VARCHAR(20), 
customers_city VARCHAR(100), 
customers_email VARCHAR(255), 
products_category VARCHAR(100), 
products_color VARCHAR(50), 
products_size VARCHAR(50), 
products_season VARCHAR(50), 
products_supplier VARCHAR(100), 
cost_price DOUBLE, 
list_price DOUBLE,
product_id VARCHAR(50), 
store_id VARCHAR(50), 
customer_id VARCHAR(50));

-- 'Inserting Clean Data': 'migrating data into the updated schema with aligned and validated fields'

INSERT INTO retail_sales_v1 
SELECT 
rs.transaction_id, 
rs.date, 
rs.quantity, 
rs.discount, 
rs.returned, 
rs.customer_age, 
rs.customer_gender, 
rs.customer_city, 
rs.customer_email, 
rs.product_category, 
rs.product_color, 
rs.product_size, 
rs.product_season, 
rs.product_supplier, 
rs.cost_price, 
rs.list_price,
rs.product_id, 
rs.store_id, 
rs.customer_id
from retail_sales as rs;

UPDATE retail_sales_v1 
SET date = STR_TO_DATE(date, '%d/%m/%Y') 
WHERE date IS NOT NULL;

-- 'Timestamp Column': 'introducing a load timestamp to track when each record enters the staging table'

ALTER TABLE retail_sales_v1 
ADD COLUMN load_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
