-- Create the 'sales' table with appropriate column definitions
CREATE TABLE retail_data.sales (
    `Order Number` INT,                 -- Order number as integer
    `Line Item` INT,                    -- Line item number as integer
    `Order Date` TEXT,                  -- Order date stored as text (DATE column has NULL VALUES)
    `Delivery Date` TEXT,               -- Delivery date stored as text (DATE column has NULL VALUES)
    `CustomerKey` INT,                  -- Customer key as integer
    `StoreKey` INT,                     -- Store key as integer
    `ProductKey` INT,                   -- Product key as integer
    `Quantity` INT,                     -- Quantity ordered as integer
    `Currency Code` VARCHAR(10)         -- Currency code as variable-length string
);

-- Load data from CSV file into the 'sales' table
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/Sales.csv'
INTO TABLE retail_data.sales
FIELDS TERMINATED BY ','              -- Fields in CSV are terminated by comma
OPTIONALLY ENCLOSED BY '"'           -- Fields optionally enclosed by double quotes
LINES TERMINATED BY '\n'             -- Lines terminated by newline
IGNORE 1 LINES                       -- Ignore the first line (header) in the CSV file
(`Order Number`, `Line Item`, `Order Date`, `Delivery Date`, `CustomerKey`, `StoreKey`, `ProductKey`, `Quantity`, `Currency Code`)
SET `Order Date` = IF(`Order Date` = 'NULL', NULL, `Order Date`),  -- Handle 'NULL' string and convert to NULL if true
    `Delivery Date` = IF(`Delivery Date` = 'NULL', NULL, `Delivery Date`);  -- Handle 'NULL' string and convert to NULL if true
