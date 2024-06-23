/*
Product Analysis:

   1. How many unique product lines does the data have, List them?
   2. What is the most common payment method?
   3. What is the most selling product line?
   4.  What is the total revenue by month?
   5. What month had the largest COGS?
   6. What city had the largest revenue?
   7. What product line had the largest VAT?
   8. Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales
   9. Which branch sold more products than average product sold?
   10. What is the most common product line by gender?
   11. What is the average rating of each product line?
*/


/* 1.    How many unique product lines does the data have, List them?  */
SELECT DISTINCT product_line FROM sales;



/*  2. What is the most common payment method? */
SELECT payment_method AS COMMON_METHOD, COUNT(payment_method) AS Count
FROM sales
GROUP BY payment_method
ORDER BY COUNT(payment_method) DESC
LIMIT 1;

 
/* 3. What is the most selling product line?  */
SELECT product_line AS Most_Selling_Line, COUNT(product_line) 
FROM sales
GROUP BY product_line
order by COUNT(product_line) DESC
LIMIT 1;



/* 4.  What is the total revenue by month?   */
SELECT month_name , SUM(total) AS total_Revenue
FROM sales
GROUP BY month_name
order by total_Revenue;



/* 5.  What month had the largest COGS?  */
SELECT month_name , SUM(cogs) AS largest_COGS
FROM sales
GROUP BY month_name
order by largest_COGS DESC
LIMIT 1;


/* 6.  What city had the largest revenue? */
SELECT branch, city, SUM(total) AS Total_Revenue                               /* Branches are in different cities */ 
FROM sales
GROUP BY branch, city
order by TOTAL_Revenue
Limit 1;



/* 7. What product line had the largest VAT. (VAT: Value-Add Tax) */
SELECT product_line, ROUND(AVG(VAT_5pct),2) AS largest_avg_VAT
FROM sales
GROUP BY product_line
ORDER BY largest_avg_VAT DESC
LIMIT 1;




/*    8. Fetch each product line and add a column to those product line showing "Good", "Bad". 
Good if its greater than average sales.   (i.e., Good if more quantity sold than overall avg-quantity of product sold) */ 

SELECT product_line, ROUND(AVG(quantity),2) AS avg_sales, 
	(CASE
		WHEN AVG(quantity) > (SELECT AVG(quantity) FROM sales) THEN "Good"
        ELSE "Bad"
	END
    ) AS Sales_Status
FROM sales
GROUP BY product_line;





/* 9. Which branch sold more products than average product sold? */
SELECT branch, AVG(quantity) AS branch_qty_sold
FROM sales
GROUP BY branch
HAVING branch_qty_sold > (SELECT AVG(quantity) AS overall_avg FROM sales);



/*  10. What is the most common product line by gender? */
SELECT product_line, gender , COUNT(gender) AS count
FROM sales
group by product_line, gender
ORDER BY count DESC
LIMIT 1;


/* 11. What is the average rating of each product line.  */
SELECT product_line, ROUND(AVG(rating),2) AS avg_rating
FROM sales
GROUP BY product_line
order by avg_rating DESC;