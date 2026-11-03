use sqlchallenge;

 -- Q1. Total Orders and Order Status Distribution

SELECT COUNT(*) AS total_orders
FROM orders;

SELECT status, COUNT(*) AS total
FROM orders
GROUP BY status;


-- Q2. Total Sales Value from Non-Cancelled Orders

SELECT SUM(oi.quantity * oi.unit_price) AS total_sales
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
WHERE o.status <> 'cancelled';


-- Q3. Months with the Highest and Lowest Order Volumes

SELECT
    DATE_FORMAT(order_date, '%Y-%m') AS order_month,
    COUNT(*) AS total_orders
FROM orders
GROUP BY DATE_FORMAT(order_date, '%Y-%m')
ORDER BY total_orders DESC;

-- Q4. Sales Value by Sales Channel

SELECT
    o.channel,
    SUM(oi.quantity * oi.unit_price) AS sales_value
FROM orders o
JOIN order_items oi
ON o.order_id = oi.order_id
WHERE o.status <> 'cancelled'
GROUP BY o.channel;

-- Q5. Sales Value by Product Category


SELECT
    p.category,
    SUM(oi.quantity * oi.unit_price) AS sales_value
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
JOIN orders o
ON oi.order_id = o.order_id
WHERE o.status <> 'cancelled'
GROUP BY p.category;

-- Q6. Top 10 Products by Sales Value

SELECT
    p.product_id,
    p.product_name,
    SUM(oi.quantity * oi.unit_price) AS sales_value
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
JOIN orders o
ON oi.order_id = o.order_id
WHERE o.status <> 'cancelled'
GROUP BY p.product_id, p.product_name
ORDER BY sales_value DESC
LIMIT 10;

-- Q7. Products with No Sales from Non-Cancelled Orders


SELECT
    p.product_id,
    p.product_name
FROM products p
LEFT JOIN order_items oi
ON p.product_id = oi.product_id
LEFT JOIN orders o
ON oi.order_id = o.order_id
AND o.status <> 'cancelled'
WHERE o.order_id IS NULL;

-- Q8. Estimated Product Profit by Category


SELECT
    p.category,
    SUM((oi.unit_price - p.cost) * oi.quantity) AS estimated_profit
FROM products p
JOIN order_items oi
ON p.product_id = oi.product_id
JOIN orders o
ON oi.order_id = o.order_id
WHERE o.status <> 'cancelled'
GROUP BY p.category
ORDER BY estimated_profit DESC;

-- Q9. Top 10 Customers by Non-Cancelled Order Count

SELECT
    c.customer_id,
    c.full_name,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.status <> 'cancelled'
GROUP BY c.customer_id, c.full_name
ORDER BY total_orders DESC
LIMIT 10;

-- Q10. Top 10 Customers by Calculated Spending

SELECT
    c.customer_id,
    c.full_name,
    SUM(oi.quantity * oi.unit_price) AS total_spending
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
JOIN order_items oi
ON o.order_id = oi.order_id
WHERE o.status <> 'cancelled'
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spending DESC
LIMIT 10;

-- Q11. Cities with the Largest Customer Easc

SELECT
    city,
    COUNT(customer_id) AS total_customers
FROM customers
GROUP BY city
ORDER BY total_customers DESC;


-- Q12. Average Customer Spending by Segment

SELECT
    c.segment,
    AVG(customer_spending) AS avg_spending
FROM customers c
JOIN (
    SELECT
        o.customer_id,
        SUM(oi.quantity * oi.unit_price) AS customer_spending
    FROM orders o
    JOIN order_items oi
    ON o.order_id = oi.order_id
    WHERE o.status <> 'cancelled'
    GROUP BY o.customer_id
) s
ON c.customer_id = s.customer_id
GROUP BY c.segment;

-- Q13. Payment Status Distribution

SELECT
    payment_status,
    COUNT(*) AS total_payments
FROM payments
GROUP BY payment_status;

-- Q14. Average Delivery Time

SELECT
    AVG(DATEDIFF(delivery_date, dispatch_date)) AS avg_delivery_days
FROM deliveries
WHERE delivery_status = 'delivered';

-- Q15. Orders Taking More Than Five Days to Deliver

SELECT
    order_id,
    DATEDIFF(delivery_date, dispatch_date) AS delivery_days
FROM deliveries
WHERE delivery_status = 'delivered'
AND DATEDIFF(delivery_date, dispatch_date) > 5;

