-- CREATE DATABASE
CREATE DATABASE IF NOT EXISTS walmart_sales_data;
USE walmart_sales_data;


/* Create table (Bcz we have large amount of data in walmart_sales raw data, SO which we import here in this table by right click on Navigator side on table and click on 'table data import wizard'  */
CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price FLOAT NOT NULL,
    quantity INT NOT NULL,
    VAT_5pct FLOAT NOT NULL,
    total FLOAT NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment_method VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT,
    gross_income FLOAT,
    rating FLOAT
);

select * from sales;



------------------------------------------- Data Cleaning : Nothing is NULL  -------------------


-- --------------------------------------------------------------------
-- ---------------- 2- FEATURE ENGINEERING (get/ADD new cols from existing to answer various business questions) *---------------

/* column 1: ADD 'time_of_day' column from time existing column */
ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);
-- ADD Data To It by fetching from'time column'
UPDATE sales 
SET time_of_day = (
			CASE
				WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
				WHEN `time` BETWEEN "12:01:00" AND "16:00:00" THEN "AFTERNOON"
				ELSE "EVENING"
			END
		);
        
        
/*ADD  COLUMN 2:-  'day_name' From existing column "date"  */
ALTER TABLE sales ADD COLUMN day_name VARCHAR(10);

/* Add data to this column simultaneoust to each row depending on date */
UPDATE sales
SET day_name = DAYNAME(date);



/*ADD  COLUMN 3:- 'month_name' From existing column "date"  */
ALTER TABLE sales ADD COLUMN month_name VARCHAR(10);

/* Add data to this column simultaneously each row depending on date */
UPDATE sales
SET month_name = MONTHNAME(date);
SELECT * from sales;


------------------------------------ EXPLORATORY DATA ANALYSIS(EDA) :NEXT sql_tabs for queries (products, sales, customers) ----------------------



