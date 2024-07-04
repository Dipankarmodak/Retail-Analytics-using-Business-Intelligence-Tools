-- Create a cleaned version of the customers table
CREATE TABLE customers_clean AS
SELECT 
    CustomerKey AS customer_key,
    Gender AS gender,
    SUBSTRING_INDEX(`Name`, ' ', 1) AS first_name,
    City AS city,
    `State Code` AS state_code,
    Country AS country,
    Continent AS continent,
    YEAR(Birthday) AS birth_year,
    MONTH(Birthday) AS birth_month
FROM customers_copy;

-- Create a cleaned version of the products table
CREATE TABLE products_clean AS
SELECT 
    ProductKey AS product_key,
    `Product Name` AS product_name,
    Brand AS brand,
    Color AS color,
    CAST(REPLACE(REPLACE(`Unit Cost USD`, '$', ''), ',', '') AS DECIMAL(18,2)) AS cost_usd,
    CAST(REPLACE(REPLACE(`Unit Price USD`, '$', ''), ',', '') AS DECIMAL(18,2)) AS cost_price,
    Subcategory AS subcategory,
    Category AS category
FROM products;

-- Create a cleaned version of the sales table with transformed dates and calculated delivery time
CREATE TABLE sales_clean AS
SELECT 
    s.order_number,
    s.line_item,
    DATEDIFF(s.delivery_date, s.order_date) AS day_order_to_delivery,
    s.customer_key,
    s.store_key,
    s.product_key,
    s.quantity,
    s.currency_code
FROM (
    SELECT 
        `Order Number` AS order_number,
        `Line Item` AS line_item,
        STR_TO_DATE(NULLIF(`Order Date`, ''), '%m/%d/%Y') AS order_date,
        STR_TO_DATE(NULLIF(`Delivery Date`, ''), '%m/%d/%Y') AS delivery_date,
        CustomerKey AS customer_key,
        StoreKey AS store_key,
        ProductKey AS product_key,
        Quantity AS quantity,
        `Currency Code` AS currency_code
    FROM sales
) AS s;

-- Create a cleaned version of the stores table
CREATE TABLE stores_clean AS
SELECT 
    StoreKey AS store_key,
    Country AS country,
    State AS state,
    `Square Meters` AS area,
    YEAR(`Open Date`) AS year_opened,
    MONTH(`Open Date`) AS month_opened
FROM stores;

-- Create a table for exchange rates
CREATE TABLE exchange_rates AS
SELECT 
    Date AS date,
    Currency AS currency,
    CAST(Exchange AS DECIMAL(18,2)) AS exchange_rate
FROM exchange;
