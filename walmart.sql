select * from walmart;
-- 
select count (*) from walmart;

SELECT payment_method, 
		COUNT (*)
		FROM walmart
		GROUP BY payment_method


SELECT COUNT(DISTINCT branch)
FROM walmart;

SELECT MAX (quantity) FROM walmart;
SELECT MIN (quantity) FROM walmart;
-- 
-- 1. Analyze Payment Methods and Sales
-- ● Question: What are the different payment methods, and how many transactions and
--  items were sold with each method?
-- ● Purpose: This helps understand customer preferences for payment methods, aiding in
--  payment optimization strategies


SELECT 
    payment_method,  
    COUNT(*) AS no_payments,  
    SUM(quantity) AS total_items_sold  
FROM walmart 
GROUP BY payment_method  
ORDER BY no_payments DESC;


 -- 2. Identify the Highest-Rated Category in Each Branch
 -- ● Question: Which category received the highest average rating in each branch?
 -- ● Purpose: This allows Walmart to recognize and promote popular categories in specific
 -- branches, enhancing customer satisfaction and branch-specific marketing.

SELECT branch, category, avg_rating
FROM (
    SELECT 
        branch,
        category,
        AVG(rating) AS avg_rating,
        RANK() OVER(PARTITION BY branch ORDER BY AVG(rating) DESC) AS rank
    FROM walmart
    GROUP BY branch, category
) AS ranked
WHERE rank = 1;

 -- 3. Determine the Busiest Day for Each Branch
 -- ● Question: What is the busiest day of the week for each branch based on transaction
 -- volume?
 -- ● Purpose: This insight helps in optimizing staffing and inventory management to
 -- accommodate peak days.

SELECT *
FROM 

(	SELECT 
		branch,
		TO_CHAR(TO_DATE(date, 'dd/mm/yy'),'Day') as day_name,
		count(*) as no_transactions,
		rank() OVER( partition by branch ORDER BY COUNT (*) desc) as rank
	From walmart
	GROUP BY 1,2
)
WHERE RANK = 1

--  4. Calculate Total Quantity Sold by Payment Method
 -- ● Question: How many items were sold through each payment method?
 -- ● Purpose: This helps Walmart track sales volume by payment type, providing insights
 -- into customer purchasing habits
 
SELECT 
    payment_method,
    SUM(quantity) AS no_qty_sold
FROM walmart
GROUP BY payment_method;

 -- 5. Analyze Category Ratings by City
 -- ● Question: What are the average, minimum, and maximum ratings for each category in
 -- each city?
 -- ● Purpose: This data can guide city-level promotions, allowing Walmart to address
 -- regional preferences and improve customer experiences.

SELECT 
    city,
    category,
    MIN(rating) AS min_rating,
    MAX(rating) AS max_rating,
    AVG(rating) AS avg_rating
FROM walmart
GROUP BY city, category;

 -- 6. Calculate Total Profit by Category
 -- ● Question: What is the total profit for each category, ranked from highest to lowest?
 -- ● Purpose: Identifying high-profit categories helps focus efforts on expanding these
 -- products or managing pricing strategies effectively

SELECT 
    category,
    SUM(unit_price * quantity * profit_margin) AS total_profit
FROM walmart
GROUP BY category
ORDER BY total_profit DESC;

--  7. Determine the Most Common Payment Method per Branch
-- ● Question: What is the most frequently used payment method in each branch?
--  ● Purpose: This information aids in understanding branch-specific payment preferences,
--  potentially allowing branches to streamline their payment processing systems.

WITH cte AS (
    SELECT 
        branch,
        payment_method,
        COUNT(*) AS total_trans,
        RANK() OVER(PARTITION BY branch ORDER BY COUNT(*) DESC) AS rank
    FROM walmart
    GROUP BY branch, payment_method
)
SELECT branch, payment_method AS preferred_payment_method
FROM cte
WHERE rank = 1;

 -- 8. Analyze Sales Shifts Throughout the Day
 -- ● Question: How many transactions occur in each shift (Morning, Afternoon, Evening)
 -- across branches?
 -- ● Purpose: This insight helps in managing staff shifts and stock replenishment schedules,
 -- especially during high-sales periods.


SELECT *,

	time::time 
FROM walmart;
-- changed time (text) to time (time)
SELECT
    branch,
    CASE 
        WHEN HOUR(TIME(time)) < 12 THEN 'Morning'
        WHEN HOUR(TIME(time)) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS num_invoices
FROM walmart
GROUP BY branch, shift
ORDER BY branch, num_invoices DESC;


-- Q9: Identify the 5 branches with the highest revenue decrease ratio from last year to current year (e.g., 2022 to 2023)
WITH revenue_2022 AS (
    SELECT 
        branch,
        SUM(total) AS revenue
    FROM walmart
    WHERE YEAR(STR_TO_DATE(date, '%d/%m/%Y')) = 2022
    GROUP BY branch
),
revenue_2023 AS (
    SELECT 
        branch,
        SUM(total) AS revenue
    FROM walmart
    WHERE YEAR(STR_TO_DATE(date, '%d/%m/%Y')) = 2023
    GROUP BY branch
)
SELECT 
    r2022.branch,
    r2022.revenue AS last_year_revenue,
    r2023.revenue AS current_year_revenue,
    ROUND(((r2022.revenue - r2023.revenue) / r2022.revenue) * 100, 2) AS revenue_decrease_ratio
FROM revenue_2022 AS r2022
JOIN revenue_2023 AS r2023 ON r2022.branch = r2023.branch
WHERE r2022.revenue > r2023.revenue
ORDER BY revenue_decrease_ratio DESC
LIMIT 5;








