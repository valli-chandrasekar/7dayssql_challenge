use sqlchallenge;

-- 1.Count the total customers

select count(*) as total_customers 
from customers;

-- 2.Customers by city
-- count number of customers in each city and identify the city with highest customer count

select city, count(*) as total_customers 
from customers
group by city
order by total_customers desc
limit 10;

-- 3. Top 10 customers by order count
-- Identify the top 10 customers who placed the highest number of non-cancelled orders

select customer_id, count(order_id) as total_orders
from orders
where status <> 'cancelled'
group by customer_id
order by total_orders desc
limit 10;

-- 4. Customer spending
-- Calculate the total spending of each customer based on order item values, excluding cancelled orders

select o.customer_id, sum(oi.quantity*oi.unit_price) as total_spending
from orders o
join order_items oi 
on o.order_id=oi.order_id
where o.status <> 'cancelled'
group by o.customer_id
order by total_spending desc;

-- 5. Average spending of active customers
-- Calculate the average spending of customer among customers who have placed at least one non-cancelled order

select avg(total_spending) as avg_spending
from (select o.customer_id, sum(oi.quantity*oi.unit_price) as total_spending
from order_items oi 
join orders o 
on oi.order_id=o.order_id
where o.status <> 'cancelled'
group by o.customer_id
order by total_spending desc) as customer_spending;

-- 6. Customers with more than 5 orders
-- Find customers who have placed more than five non-cancelled orders

select customer_id, count(order_id) as total_orders
from orders
where status <> 'cancelled' 
group by customer_id
having count(order_id)>5
order by total_orders desc;

-- 7. Customer segment analysis
-- Count the number of customers in each customer segment

select segment, count(customer_id) as total_customers
from customers
group by segment
order by total_customers;

-- 8. Average orders per customer
-- Calculate the average number of non-cancelled orders per customer, including customers with zero qualifying orders

select avg(total_spending) as avg_spending
from (select c.customer_id, count(order_id) as total_spending
from customers c 
join orders o 
on c.customer_id=o.customer_id
where o.status <> 'cancelled'
group by c.customer_id
order by total_spending desc) as customer_spending;

-- 9. Top 10 customers by spending
-- Identify the top 10 customers who generated the highest item sales value from non-cancelled orders

select o.customer_id, sum(oi.quantity*oi.unit_price) as total_sales
from orders o
join order_items oi 
on o.order_id=oi.order_id 
where o.status <> 'cancelled'
group by o.customer_id 
order by total_sales desc 
limit 10;

-- 10. Customers signups by month
-- Count the number of new customer registrations per month and dispay the results chronologically

select year(order_date) as registration_year,
month(order_date) as registration_month,
count(c.customer_id) as total_customers
from customers c
join orders o
on c.customer_id=o.customer_id
group by year(order_date), month(order_date)
order by registration_year asc, registration_month asc; 