CREATE TABLE Products (
    ProductKey INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Brand VARCHAR(50),
    Color VARCHAR(50),
    UnitCostUSD DECIMAL(18, 2),
    UnitPriceUSD DECIMAL(18, 2),
    SubcategoryKey INT,
    Subcategory VARCHAR(50),
    CategoryKey INT,
    Category TEXT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/Products.csv'
INTO TABLE retail_data.Products
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(ProductKey, ProductName, Brand, Color, @UnitCostUSD, @UnitPriceUSD, SubcategoryKey, Subcategory, CategoryKey, Category)
SET UnitCostUSD = TRIM(REPLACE(REPLACE(@UnitCostUSD, '$', ''), ',', '')),
    UnitPriceUSD = TRIM(REPLACE(REPLACE(@UnitPriceUSD, '$', ''), ',', ''));
