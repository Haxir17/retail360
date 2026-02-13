/* ===========================
   Section 2: Data Cleaning & Sorting
   =========================== */
   
select *
from retail_business.retail_sales_v1;
  
-- 'Categorical Profiling': 'inspecting inconsistencies, misspellings, and formatting issues'
  
SELECT DISTINCT customers_gender 
FROM retail_sales_v1;

SELECT DISTINCT customers_city 
FROM retail_sales_v1;

SELECT DISTINCT products_category
FROM retail_sales_v1;

SELECT DISTINCT products_color
FROM retail_sales_v1;

SELECT DISTINCT products_size
FROM retail_sales_v1;

SELECT DISTINCT products_season
FROM retail_sales_v1;

SELECT DISTINCT products_supplier
FROM retail_sales_v1;

-- Missing Value Audit': 'quantifying NULLs, blanks, and placeholder values'

SELECT 'customers_gender' AS column_name, 
SUM(CASE WHEN customers_gender IS NULL THEN 1 ELSE 0 END) AS null_count, 
SUM(CASE WHEN customers_gender = '' THEN 1 ELSE 0 END) AS blank_count, 
SUM(CASE WHEN customers_gender = '???' THEN 1 ELSE 0 END) AS fake_null_count 
FROM retail_sales_v1 
UNION ALL SELECT 'customers_city', 
SUM(CASE WHEN customers_city IS NULL THEN 1 ELSE 0 END), 
SUM(CASE WHEN customers_city = '' THEN 1 ELSE 0 END), 
SUM(CASE WHEN customers_city = '???' THEN 1 ELSE 0 END) 
FROM retail_sales_v1 
UNION ALL SELECT 'products_category', 
SUM(CASE WHEN products_category IS NULL THEN 1 ELSE 0 END), 
SUM(CASE WHEN products_category = '' THEN 1 ELSE 0 END), 
SUM(CASE WHEN products_category = '???' THEN 1 ELSE 0 END) 
FROM retail_sales_v1 
UNION ALL SELECT 'products_color', 
SUM(CASE WHEN products_color IS NULL THEN 1 ELSE 0 END), 
SUM(CASE WHEN products_color = '' THEN 1 ELSE 0 END), 
SUM(CASE WHEN products_color = '???' THEN 1 ELSE 0 END) 
FROM retail_sales_v1 
UNION ALL SELECT 'products_size', 
SUM(CASE WHEN products_size IS NULL THEN 1 ELSE 0 END), 
SUM(CASE WHEN products_size = '' THEN 1 ELSE 0 END), 
SUM(CASE WHEN products_size = '???' THEN 1 ELSE 0 END) 
FROM retail_sales_v1 
UNION ALL SELECT 'products_season', 
SUM(CASE WHEN products_season IS NULL THEN 1 ELSE 0 END), 
SUM(CASE WHEN products_season = '' THEN 1 ELSE 0 END), 
SUM(CASE WHEN products_season = '???' THEN 1 ELSE 0 END) 
FROM retail_sales_v1 
UNION ALL SELECT 'products_supplier', 
SUM(CASE WHEN products_supplier IS NULL THEN 1 ELSE 0 END), 
SUM(CASE WHEN products_supplier = '' THEN 1 ELSE 0 END), 
SUM(CASE WHEN products_supplier = '???' THEN 1 ELSE 0 END) 
FROM retail_sales_v1;

-- /* 'Categorical Standardisation': 'cleaning inconsistent, missing and invalid category values' */ 

UPDATE retail_sales_v1 
SET customers_gender = CASE WHEN customers_gender IN ('Male', 'male', 'MALE') THEN 'Male' 
WHEN customers_gender IN ('Female', 'female', 'FEMALE') THEN 'Female' 
WHEN customers_gender IN ('Other', 'other', 'OTHER') THEN 'Other' 
WHEN customers_gender IS NULL OR customers_gender = '???' OR customers_gender = '' THEN 'Unknown' ELSE customers_gender 
END, 
products_category = CASE WHEN products_category IN ('Tops', 'tops', 'TOPS') THEN 'Tops' 
WHEN products_category IN ('Bottoms', 'bottoms', 'BOTTOMS') THEN 'Bottoms' 
WHEN products_category IN ('Accessories', 'accessories', 'ACCESSORIES') THEN 'Accessories' 
WHEN products_category IN ('Shoes', 'shoes', 'SHOES') THEN 'Shoes' 
WHEN products_category IN ('Dresses', 'dresses', 'DRESSES') THEN 'Dresses' 
WHEN products_category IS NULL OR products_category = '???' OR products_category = '' THEN 'Unknown' ELSE products_category 
END, 
products_color = CASE WHEN products_color IN ('yellow', 'YELLOW') THEN 'Yellow' 
WHEN products_color IN ('black', 'BLACK') THEN 'Black' 
WHEN products_color IN ('red', 'RED') THEN 'Red' 
WHEN products_color IN ('blue', 'BLUE') THEN 'Blue' 
WHEN products_color IN ('green', 'GREEN') THEN 'Green' 
WHEN products_color IN ('white', 'WHITE') THEN 'White' 
WHEN products_color IS NULL OR products_color = '???' OR products_color = '' THEN 'Unknown' ELSE products_color 
END;

-- 'Numeric Field Profiling': 'evaluating min, max, and average values for each numeric column to detect outliers and irregular ranges'

SELECT 'quantity' AS metric,
       MIN(quantity) AS min_value,
       MAX(quantity) AS max_value,
       AVG(quantity) AS avg_value
FROM retail_sales_v1

UNION ALL
SELECT 'discount',
       MIN(discount),
       MAX(discount),
       AVG(discount)
FROM retail_sales_v1

UNION ALL
SELECT 'returned',
       MIN(returned),
       MAX(returned),
       AVG(returned)
FROM retail_sales_v1

UNION ALL
SELECT 'customers_age',
       MIN(customers_age),
       MAX(customers_age),
       AVG(customers_age)
FROM retail_sales_v1

UNION ALL
SELECT 'cost_price',
       MIN(cost_price),
       MAX(cost_price),
       AVG(cost_price)
FROM retail_sales_v1

UNION ALL
SELECT 'list_price',
       MIN(list_price),
       MAX(list_price),
       AVG(list_price)
FROM retail_sales_v1;

-- 'Duplicate Audit': 'flagging repeated records to protect data accuracy'

SELECT transaction_id, COUNT(*) AS duplicate_count 
FROM retail_sales_v1 
GROUP BY transaction_id 
HAVING COUNT(*) > 1;

SELECT customer_id, product_id, date, COUNT(*) AS duplicate_count 
FROM retail_sales_v1 
GROUP BY customer_id, product_id, date 
HAVING COUNT(*) > 1;

SELECT transaction_id, customer_id, customers_gender, customers_age, customers_city, customers_email, product_id, 
       products_category, products_color, products_size, products_season, products_supplier, quantity, discount, returned, 
       cost_price, list_price, date, COUNT(*) AS duplicate_count 
FROM retail_sales_v1 
GROUP BY transaction_id, customer_id, customers_gender, customers_age, customers_city, customers_email, product_id, 
         products_category, products_color, products_size, products_season, products_supplier, quantity, discount, returned, 
         cost_price, list_price, date 
HAVING COUNT(*) > 1;

/* Business Logic Audit */

-- 1. Negative or zero prices
SELECT 'Invalid Price' AS issue_type, t.*
FROM retail_sales_v1 t
WHERE t.cost_price <= 0 OR t.list_price <= 0

UNION ALL

-- 2. cost_price greater than list_price
SELECT 'Cost > List Price', t.*
FROM retail_sales_v1 t
WHERE t.cost_price > t.list_price

UNION ALL

-- 3. Invalid discounts (less than 0 or greater than 100)
SELECT 'Invalid Discount', t.*
FROM retail_sales_v1 t
WHERE t.discount < 0 OR t.discount > 100

UNION ALL

-- 4. Invalid quantities (zero or negative)
SELECT 'Invalid Quantity', t.*
FROM retail_sales_v1 t
WHERE t.quantity <= 0

UNION ALL

-- 5. Returned items with zero or negative quantity
SELECT 'Returned Item With Invalid Quantity', t.*
FROM retail_sales_v1 t
WHERE t.returned = 1 AND t.quantity <= 0

UNION ALL

-- 6. Negative revenue (calculated check)
SELECT 'Negative Revenue', t.*
FROM retail_sales_v1 t
WHERE (t.list_price - t.discount) * t.quantity < 0;

-- 'Price Logic Correction': 'dropped rows violating basic pricing logic'

DELETE FROM retail_sales_v1
WHERE cost_price > list_price;
