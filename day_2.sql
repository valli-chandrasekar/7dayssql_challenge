use sqlchallenge;

-- 1.Total number of orders
select count(*) as total_orders 
from orders;

-- 2.Order status counts

select status, count(*) as total_order_for_status
from orders group by status;

-- 3. 10 Most recent orders

select order_id, order_date 
from orders
order by order_date desc
limit 10;

-- 4. 10 Highest value orders

select o.order_id, p.amount
from orders o
join payments p
ON o.order_id=p.order_id
order by p.amount desc 
limit 10;

-- 5. Daily order volume

select order_date, count(order_id) as total_orders
from orders
group by order_date
order by order_date asc;
 
-- 6. Group orders by month and identify peak and low-volume months

select month(order_date) as month, count(*) as total_orders
from orders
group by month(order_date)
order by month(order_date) asc;

-- 7. Average order amount across all orders

select round(avg(order_amount),2)
from
(select order_id, sum(quantity*unit_price) as order_amount
from order_items
group by order_id) as orders_total;

-- 8. Top 10 customers by order count

select customer_id, count(order_id) as total_orders
from orders
group by customer_id
order by total_orders desc
limit 10;











