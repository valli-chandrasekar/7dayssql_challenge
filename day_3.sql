use sqlchallenge;

-- 1. Total sales revenue
-- Calculate the total value of all orders

select sum(oi.quantity*oi.unit_price) as total_value
from orders o
join order_items oi
on o.order_id=oi.order_id
where o.status <> 'cancelled';

-- 2.Revenue by product category
-- Identify which product categories generate the most sales

select p.category, sum(oi.quantity*oi.unit_price) as revenue
from orders o
join order_items oi
on o.order_id=oi.order_id
join products p
on oi.product_id=p.product_id
where o.status <> 'cancelled'
group by p.category
order by revenue asc;

-- 3. Top 10 Products by Revenue
-- Find the 10 products generating the highest revenue

select p.product_id, sum(oi.quantity*oi.unit_price) as revenue
from orders o
join order_items oi
on o.order_id=oi.order_id
join products p
on oi.product_id=p.product_id
where status <> 'cancelled'
group by p.product_id
order by revenue desc
limit 10;

-- 4. Monthly revenue trend
-- 	Calculate revenue month by month

select month(order_date) as month, sum(oi.quantity*oi.unit_price) as revenue
from orders o
join order_items oi
on o.order_id=oi.order_id
where o.status <> 'cancelled'
group by month
order by month asc;

-- 5.Revenue by sales channel
-- Identify which sales channel generate the highest revenue

select o.channel, sum(oi.quantity*oi.unit_price) as revenue
from orders o
join order_items oi
on o.order_id=oi.order_id
where o.status <> 'cancelled'
group by o.channel
order by revenue desc;

-- 6. Total quantity sold by product category
-- Calcualte the total quantity of products sold in each category

select p.category, sum(oi.quantity) as total_quantity
from orders o
join order_items oi
on o.order_id=oi.order_id
join products p
on oi.product_id=p.product_id
where status <> 'cancelled'
group by p.category
order by total_quantity desc;

-- 7. Payment method analysis
-- Count how many payments were made using each payment method

select payment_method, count(*) as total_payments
from payments
group by payment_method
order by total_payments desc;

-- 8.Payment status analysis
-- Count payments by their status

select o.status, count(p.payment_id) as total_payments
from orders o
join payments p
on o.order_id=p.order_id
group by o.status
order by total_payments desc;

-- 9. Average payment amount
-- Calculate the average recorded payment amount

select avg(amount) as avg_amount
from payments;

-- 10. Payment amount by payment method
-- Calculate the total recorded payment amount for each payment method

select payment_method, sum(amount) as total_amount
from payments
group by payment_method
order by total_amount desc;








