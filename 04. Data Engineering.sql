/* =================================
   Section 4: Data Transformations
   ================================= */

CREATE TABLE retail_sales_engineered AS
SELECT
    date,
    quantity,
    returned,
    discount,

    -- Customer Dimensions
    customers_age,
    customers_gender,
    customers_city,
    
    CASE 
		WHEN customers_age BETWEEN 10 AND 19 THEN '10s' 
        WHEN customers_age BETWEEN 20 AND 29 THEN '20s' 
        WHEN customers_age BETWEEN 30 AND 39 THEN '30s' 
        WHEN customers_age BETWEEN 40 AND 49 THEN '40s' 
        WHEN customers_age BETWEEN 50 AND 59 THEN '50s' 
        ELSE '60+' 
	END AS age_group,

    -- Product Dimensions
    products_category,
    products_season,
    products_supplier,

    -- Pricing Fields
    cost_price,
    list_price,
    round((list_price - cost_price), 0) AS markup, 
    round((list_price / cost_price), 0) AS price_ratio,

    -- Engineered Metrics
    round((list_price - discount), 0) * quantity AS revenue,
    round((list_price - discount - cost_price), 0) * quantity AS profit,

    CASE 
        WHEN (list_price - discount) * quantity = 0 THEN 0
        ELSE round(((list_price - discount - cost_price) * quantity) 
             / ((list_price - discount) * quantity) * 100, 0)
    END AS margin_percentage

FROM retail_sales_v1;