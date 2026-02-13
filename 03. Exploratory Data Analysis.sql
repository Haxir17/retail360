/* ====================================
   Section 3: Exploratory Data Analysis
   ==================================== */
   
select *
from retail_business.retail_sales_v1;

-- Gender Distribution by Total Orders

SELECT 
	customers_gender, 
    COUNT(*) AS total_orders 
FROM retail_sales_v1 
GROUP BY customers_gender 
ORDER BY total_orders DESC;

-- Age Group vs Quantity Purchased

SELECT CASE 
WHEN customers_age BETWEEN 10 AND 19 THEN '10s' 
WHEN customers_age BETWEEN 20 AND 29 THEN '20s' 
WHEN customers_age BETWEEN 30 AND 39 THEN '30s' 
WHEN customers_age BETWEEN 40 AND 49 THEN '40s' 
WHEN customers_age BETWEEN 50 AND 59 THEN '50s' 
ELSE '60+' END AS age_group, AVG(quantity) AS avg_quantity 
FROM retail_sales_v1 
GROUP BY age_group 
ORDER BY age_group;

-- Gender Distribution by Return Rate

SELECT 
	customers_gender, 
    Round(AVG(returned) * 100, 1) AS return_rate_percentage 
FROM retail_sales_v1 
GROUP BY customers_gender;

-- Age Group vs Discount Received

SELECT CASE 
WHEN customers_age BETWEEN 10 AND 19 THEN '10s' 
WHEN customers_age BETWEEN 20 AND 29 THEN '20s' 
WHEN customers_age BETWEEN 30 AND 39 THEN '30s' 
WHEN customers_age BETWEEN 40 AND 49 THEN '40s' 
WHEN customers_age BETWEEN 50 AND 59 THEN '50s' 
ELSE '60+' END AS age_group, round(AVG(discount), 3) AS avg_discount_received
FROM retail_sales_v1 
GROUP BY age_group 
ORDER BY age_group;

--  “age groups and genders purchasing patterns differences across product categories.”

SELECT CASE 
WHEN customers_age BETWEEN 10 AND 19 THEN '10s' 
WHEN customers_age BETWEEN 20 AND 29 THEN '20s' 
WHEN customers_age BETWEEN 30 AND 39 THEN '30s' 
WHEN customers_age BETWEEN 40 AND 49 THEN '40s' 
WHEN customers_age BETWEEN 50 AND 59 THEN '50s' 
ELSE '60+' END AS age_group, customers_gender, products_category, COUNT(*) AS total_orders
FROM retail_sales_v1 
GROUP BY age_group, customers_gender, products_category
ORDER BY total_orders desc; 

--  “seasonal demand by gender based on average quantities purchased.”

SELECT 
    customers_gender,
    products_season,
    round(AVG(quantity),2) AS avg_quantity
FROM retail_sales_v1
GROUP BY customers_gender, products_season
ORDER BY customers_gender, avg_quantity DESC;

--  “age groups and genders purchasing patterns differences across product colors.”

SELECT CASE 
WHEN customers_age BETWEEN 10 AND 19 THEN '10s' 
WHEN customers_age BETWEEN 20 AND 29 THEN '20s' 
WHEN customers_age BETWEEN 30 AND 39 THEN '30s' 
WHEN customers_age BETWEEN 40 AND 49 THEN '40s' 
WHEN customers_age BETWEEN 50 AND 59 THEN '50s' 
ELSE '60+' END AS age_group, customers_gender, products_color, COUNT(*) AS total_orders
FROM retail_sales_v1 
GROUP BY age_group, customers_gender, products_color
ORDER BY total_orders desc; 

-- Product Categorical Distribution

SELECT 
    products_category,
    COUNT(*) AS total_orders
FROM retail_sales_v1
GROUP BY products_category
ORDER BY total_orders DESC;

-- Product Seasonal Distribution

SELECT 
    products_season,
    COUNT(*) AS total_orders
FROM retail_sales_v1
GROUP BY products_season
ORDER BY total_orders DESC;

-- Product Sizal Distribution

SELECT 
    products_size,
    COUNT(*) AS total_orders
FROM retail_sales_v1
GROUP BY products_size
ORDER BY total_orders DESC;

-- Product Supplier based Distribution

SELECT 
    products_supplier,
    COUNT(*) AS total_orders
FROM retail_sales_v1
GROUP BY products_supplier
ORDER BY total_orders DESC;

-- Total Quantity Sold by Categories

SELECT 
    products_category,
    SUM(quantity) AS total_quantity
FROM retail_sales_v1
GROUP BY products_category
ORDER BY total_quantity DESC;

-- Total Revenue in $ by Seasons

SELECT 
    products_season,
    Round(SUM((list_price - discount) * quantity), 0) AS total_revenue
FROM retail_sales_v1
GROUP BY products_season
ORDER BY total_revenue DESC;

-- Return Rate by Product Categories

SELECT 
    products_category,
    Round(AVG(returned), 2) * 100 AS return_rate_percentage
FROM retail_sales_v1
GROUP BY products_category
ORDER BY return_rate_percentage DESC;

-- Avg Discount Received by Product Category

SELECT 
    products_category,
    Round(AVG(discount), 3) AS avg_discount
FROM retail_sales_v1
GROUP BY products_category
ORDER BY avg_discount DESC;

-- Avg Value Gap by Supplier

SELECT 
    products_supplier,
    round(AVG(list_price - cost_price), 1) AS avg_margin_gap
FROM retail_sales_v1
GROUP BY products_supplier
ORDER BY avg_margin_gap DESC;

-- “peak revenue generating categories by seasons”

SELECT 
    products_category,
    products_season,
    Round(SUM((list_price - discount) * quantity), 0) AS total_revenue
FROM retail_sales_v1
GROUP BY products_category, products_season
ORDER BY total_revenue DESC;

-- “peak revenue generating categories by cities”

SELECT 
    products_category,
    customers_city,
    Round(SUM((list_price - discount) * quantity), 0) AS total_revenue
FROM retail_sales_v1
GROUP BY products_category, customers_city
ORDER BY total_revenue DESC;

-- Return Rate Percentage by Quantity Ordered

SELECT 
    quantity,
    round(AVG(returned) * 100, 1) AS return_rate_percentage
FROM retail_sales_v1
GROUP BY quantity
ORDER BY quantity;


-- Total Revenue by Years

SELECT 
    YEAR(date) AS sales_year,
    round(SUM((list_price - discount) * quantity), 0) AS total_revenue
FROM retail_sales_v1
GROUP BY YEAR(date)
ORDER BY sales_year;

-- Total Profit by Years

SELECT 
    YEAR(date) AS sales_year,
    Round(SUM(((list_price - discount) - cost_price) * quantity), 0) AS total_profit
FROM retail_sales_v1
GROUP BY YEAR(date)
ORDER BY sales_year;

-- Total Profit by City and Year

SELECT 
    YEAR(date) AS sales_year,
    customers_city,
    Round(SUM(((list_price - discount) - cost_price) * quantity), 0) AS total_profit
FROM retail_sales_v1
GROUP BY YEAR(date), customers_city
ORDER BY sales_year, total_profit DESC;