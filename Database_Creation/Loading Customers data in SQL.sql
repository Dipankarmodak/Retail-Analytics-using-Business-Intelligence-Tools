-- Create the Customers table
CREATE TABLE retail_data.Customers (
    CustomerKey INT PRIMARY KEY,
    Gender VARCHAR(10),
    `Name` VARCHAR(100),
    City VARCHAR(50),
    `State Code` VARCHAR(100),
    State VARCHAR(50),
    `Zip Code` VARCHAR(20),
    Country VARCHAR(50),
    Continent VARCHAR(50),
    Birthday DATE
);

/*
Load data from CSV file into the 'Customers' table:
- Adjust the path 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/Customers.csv' to match your actual CSV file location.
- Ensure that the columns in the CSV file match exactly with the columns specified in the `LOAD DATA INFILE` statement.
- Fields in CSV are terminated by comma, optionally enclosed by double quotes, and lines terminated by newline.
- Ignore the first line (header) in the CSV file.
- Convert the `Birthday` column from `MM/DD/YYYY` format to MySQL's `DATE` format using `STR_TO_DATE`.
*/

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/Customers.csv'
INTO TABLE retail_data.customers
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`CustomerKey`, `Gender`, `Name`, `City`, `State Code`, `State`, `Zip Code`, `Country`, `Continent`, @Birthday)
SET `Birthday` = STR_TO_DATE(@Birthday, '%m/%d/%Y');
