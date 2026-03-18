-- 11. Order Mode: What is the percentage split between "Online" vs "Offline" orders?
SELECT online_order,COUNT(*) AS Percentage_split
FROM facts
GROUP BY online_order
--WHERE online_order!='NA';

-- 12. Booking Influence: Do customers who "Book a Table" spend more on average than those who don't?

SELECT 
CASE 
    WHEN 
        (SELECT AVG(total_amount) FROM facts WHERE book_table='Yes') >
        (SELECT AVG(total_amount) FROM facts WHERE book_table='No')
    THEN 'Customers who book tables spend more'
    ELSE 'Customers who do not book tables spend more'
END AS result;

-- 13. Peak Order Hours: During which hour of the day do most orders occur?
SELECT DATEPART(HOUR,d.order_time) AS Hourofday,COUNT(f.order_id) AS total_orders
FROM facts f
LEFT JOIN dim_date d
ON f.date_key=d.date_key
GROUP BY DATEPART(HOUR,d.order_time)
ORDER BY total_orders DESC;

-- 14. Popular Locations: Which 5 locations have the highest volume of orders?
SELECT TOP 5 l.area_name,COUNT(f.order_id) AS orders
FROM facts f
LEFT JOIN dim_location l
ON f.location_key=l.location_key
GROUP BY l.area_name
ORDER BY COUNT(f.order_id) DESC;

-- 15. Quantity Trends: What is the average ordered_qty per order for different cuisine types?
SELECT r.cuisine_type,AVG(f.ordered_qty) AS avg_qty
FROM facts f
LEFT JOIN dim_restaurant r
ON f.restaurant_key=r.restaurant_key
GROUP BY r.cuisine_type
ORDER BY avg_qty;

