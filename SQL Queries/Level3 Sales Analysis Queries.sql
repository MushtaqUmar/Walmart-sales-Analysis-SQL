/* 
Sales data analysis:

    1. Number of sales made in each time of the day per weekday.
    2. Which of the customer types brings the most revenue?
    3. Which city has the largest tax percent/ VAT (Value Added Tax)?
    4. Which customer type pays the most in VAT?
*/


/* 1. Number of sales made in each time of the day per weekday. */

SELECT time_of_day , COUNT(*) AS No_of_sales
FROM sales
WHERE day_name = "Sunday"    /* Let's find it on SUNDAY  (We can find it on any day) */
group by time_of_day;




/* 2. Which of the customer types brings the most revenue?   */
SELECT customer_type , ROUND(SUM(total) , 2) AS customer_revenue
FROM sales
GROUP BY customer_type
ORDER BY customer_revenue DESC
LIMIT 1; 


/* 3. Which city has the largest tax percent/VAT.    (-> VAT: Value Added Tax)? */
SELECT city , ROUND(AVG(VAT_5pct),2) AS VAT
FROM sales
GROUP BY city
ORDER BY VAT DESC
LIMIT 1;

/* 4. Which customer type pays the most in VAT? */
SELECT customer_type , ROUND(AVG(VAT_5pct),2) AS VAT
FROM sales
GROUP BY customer_type
ORDER BY VAT
LIMIT 1;