/*
Customer Data Analysis:

   1. How many unique customer types does the data have, list them along with count of each..
   2. How many unique payment methods does the data have?
   3. What is the most common customer type?
   4. Which customer type buys the most?
   5.  What is the gender of most of the customers?
   6. What is the gender distribution per branch?
   7. Which time of the day do customers give most ratings?
   8. What rating customers give at each time of day ? 
   9. Which time of the day do customers give most ratings per branch?
   10.  Which day of the week has the best avg ratings?
   11. Which day of the week has the best average ratings per branch?
*/


/* 1. How many unique customer types does the data have, list them along with count of each. */
SELECT customer_type AS unique_customers, COUNT(*)
FROM sales
GROUP BY customer_type;   


/*  2. How many unique payment methods does the data have. */
SELECT COUNT(DISTINCT payment_method) AS total_payment_menthods
FROM sales;



/* 3. What is the most common customer type?  */
SELECT customer_type, COUNT(customer_type) AS count
FROM sales
GROUP BY customer_type
ORDER BY count DESC
LIMIT 1;

/* 4. Which customer type buys the most?  */
SELECT customer_type, SUM(quantity) AS quantity_buy
FROM sales
GROUP BY customer_type
ORDER BY quantity_buy DESC
LIMIT 1;



/* 5. What is the gender of most of the customers?  */
SELECT gender, COUNT(gender) AS most_cmn_gender
FROM sales
GROUP BY gender
ORDER BY most_cmn_gender DESC
LIMIT 1;



/*  6. What is the gender distribution per branch?   */
SELECT branch , gender, COUNT(gender) AS gender_distr
FROM sales
GROUP BY branch,gender
ORDER BY branch, gender;            /* In alphabatically Ascending Order */




/* 7.  Which time of the day do customers give most ratings? */
SELECT time_of_day , COUNT(rating) AS count_ratings
FROM sales
GROUP BY time_of_day
ORDER BY count_ratings DESC
LIMIT 1;


/*  8. What rating customers give at each time of day ?  */
SELECT time_of_day , ROUND(AVG(rating),2) AS Avg_rating
FROM sales
GROUP BY time_of_day
ORDER BY Avg_rating DESC;

/* 9. Which time of the day do customers give most ratings per branch? */

SELECT branch, time_of_day, rating_count                                   		 /* STEP 3: Get branch with time_of_day along with rating_count gaving rank =1 FROM step2(subquery)  i.e., highest rating time */
FROM
	(SELECT branch, time_of_day, rating_count,                                   /* Step 2: Subquery gives ranking which repeats as category changes */
	RANK() OVER(partition By branch ORDER BY rating_count DESC) AS ranking       /* Rank based on : ORDER BY rating_count in DESCENDING order ( i.e., highest count is given rank 1 in each partition ) */
	FROM                    
		(SELECT branch , time_of_day, COUNT(rating) AS rating_count              /* step 1: This subquery gives branch + time_of_day with count(rating) */
		FROM sales
		GROUP BY branch, time_of_day) AS table1) AS rank_table2  				
WHERE ranking = 1 ;     													     /* Only need Most rating time_of_day per branch given by customers */




/* 10. Which day of the week has the best avg ratings? */
SELECT day_name , ROUND(AVG(rating),2) AS best_avg_rating 
FROM sales
GROUP BY day_name
ORDER BY best_avg_rating DESC
LIMIT 1;


/*  11. Which day of the week has the best average ratings per branch?   (SIMILAR TO ques 9 ) */

SELECT branch, day_name , avg_rating AS best_avg_rating
FROM
(SELECT branch, day_name , avg_rating,												  /* Step2 : Subquery to rank data data of step 1 so that we fetch per branches reqd data */
RANK() OVER(PARTITION BY branch ORDER BY avg_rating DESC) AS ranking
FROM
(SELECT branch, day_name , ROUND(AVG(rating),2) AS avg_rating                         /* Step 1: Subquery to get main data  */
FROM sales
GROUP BY branch , day_name) AS table1) rank_table2
WHERE ranking = 1;                                    								  /* feth branch with such day when avg_rating is high given by customers */