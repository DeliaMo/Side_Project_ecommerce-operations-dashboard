USE ecommerce;

LOAD DATA INFILE '/var/lib/mysql-files/clean_sales.csv'
INTO TABLE sales
CHARACTER SET UTF8mb4
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    invoice_no, 
    stock_code, 
    description, 
    quantity, 
    invoice_date, 
    unit_price, 
    @customer_id, 
    country
)
SET customer_id = NULLIF(TRIM(@customer_id), '');
