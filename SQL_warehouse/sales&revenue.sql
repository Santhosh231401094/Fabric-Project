-- 1. Total Revenue: What is the total revenue generated across all orders?
SELECT SUM(total_amount) AS total_revenue
FROM facts;

-- 2. Top Cuisines: Which are the top 5 cuisines by total revenue?
SELECT TOP 5 r.cuisine_type,SUM(f.total_amount) AS revenue
FROM facts f
LEFT JOIN dim_restaurant r
ON f.restaurant_key=r.restaurant_key
GROUP BY r.cuisine_type
ORDER BY revenue DESC;

-- 3. Revenue by Location: Which area in Bengaluru generated the highest sales?
SELECT l.area_name,SUM(f.total_amount) AS revenue
FROM facts f
LEFT JOIN dim_location l
ON f.location_key=l.location_key
GROUP BY l.area_name
ORDER BY revenue DESC;

-- 4. Average Order Value (AOV): What is the average amount spent per order?
SELECT AVG(total_amount) AS AOV 
FROM facts;

-- 5. High-Value Orders: List the top 10 orders with the highest total_amount.
SELECT TOP 10 order_id,SUM(total_amount) AS total_amount
FROM facts
GROUP BY order_id
ORDER BY total_amount DESC;

