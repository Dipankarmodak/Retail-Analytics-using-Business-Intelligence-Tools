-- Create the Exchange table
CREATE TABLE retail_data.Exchange (
    `Date` DATE,
    Currency VARCHAR(10),
    Exchange DECIMAL(18, 6)  -- Adjust the precision and scale based on your data requirements
);

/*
Load data from CSV file into the 'Exchange' table:
- Adjust the path 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/Exchange_Rates.csv' to match your actual CSV file location.
- Ensure that the columns in the CSV file match exactly with the columns specified in the `LOAD DATA INFILE` statement.
- Fields in CSV are terminated by comma, optionally enclosed by double quotes, and lines terminated by newline.
- Ignore the first line (header) in the CSV file.
- Convert the `Date` column from `MM/DD/YYYY` format to MySQL's `DATE` format using `STR_TO_DATE`.
*/

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 5.7/Uploads/Exchange_Rates.csv'
INTO TABLE retail_data.Exchange
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(@Date, `Currency`, `Exchange`)
SET `Date` = STR_TO_DATE(@Date, '%m/%d/%Y');
