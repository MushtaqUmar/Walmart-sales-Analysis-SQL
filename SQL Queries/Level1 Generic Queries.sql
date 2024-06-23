/*
  ## Generic Question:\
1. How many unique cities does the data have?
2. In which city is each branch?
*/


/* 1. How many unique cities does the data have? */
SELECT count(distinct city) AS unique_cities from sales;



/* 2. In which city is each branch (Where the branch of walmart is) */
SELECT DISTINCT city, branch from sales
ORDER BY branch;   								 /* ARrange data according to city name in Ascending order */



