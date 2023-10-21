-- Statistical Questions
-- What days and times do we tend to be busiest?
-- How many pizzas are we making during peak periods?
-- What are our best and worst-selling pizzas?
-- What's our average order value?

-- I imported the data into MYSQL so that I could make SQL queries and gain insights from this pizza data.
-- Data Cleaning
-- As always, I cleaned the data before I dove deep into it.

-- Removed the Columns that I don't need to include.
ALTER TABLE pizza_sales
DROP COLUMN order_details_id, 
DROP COLUMN order_id, 
DROP COLUMN pizza_id, 
DROP COLUMN pizza_ingredients;

-- Question 1: What days and times do we tend to be the busiest?the different years that this dataset covers:
SELECT DISTINCT(EXTRACT(YEAR FROM order_date)) FROM pizza_sales 

--  What time of the day is the business selling the most pizza:

SELECT EXTRACT(HOUR FROM order_time) AS time_of_day, SUM(quantity) AS quantity_sold
FROM pizza_sales
GROUP BY EXTRACT(HOUR FROM order_time)
ORDER BY SUM(quantity) DESC;

-- To find what day of week is the busiest, I used a function called TO_CHAR to convert all the dates in the column to a day of the week.

SELECT TO_CHAR(order_date, 'Day') AS day_of_week, SUM(quantity) AS quantity_sold
FROM pizza_sales
GROUP BY TO_CHAR(order_date, 'Day')
ORDER BY SUM(quantity) DESC;

-- Question 2: How many pizzas are we making during peak periods?
SELECT EXTRACT(HOUR FROM order_time), SUM(quantity) 
FROM pizza_sales
GROUP BY EXTRACT(HOUR FROM order_time)
ORDER BY SUM(quantity) DESC;

-- Question 3: What are our best and worst-selling pizzas?
-- I'm going to find the top 3 best-selling pizzas and the bottom 3 worst-selling pizzas. It's a pretty simple query: just use a GROUP BY clause.

-- Top 3 best-selling pizzas:

SELECT pizza_name, SUM(quantity) 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(quantity) DESC
LIMIT 3;

-- Last 3 worst-selling pizzas:

SELECT pizza_name, SUM(quantity) 
FROM pizza_sales
GROUP BY pizza_name
ORDER BY SUM(quantity) ASC
LIMIT 3;

-- Question 4: What's our average order value?

SELECT pizza_size, AVG(total_price) AS average_total_price
FROM pizza_sales
GROUP BY pizza_size
ORDER BY AVG(total_price) ASC;

-- to find the average price of ALL pizzas, regardless of size:

SELECT AVG(total_price) AS average_total_price
FROM pizza_sales;



