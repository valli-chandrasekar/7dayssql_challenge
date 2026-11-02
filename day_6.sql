use sqlchallenge;

-- 1. Understand order status distribution
-- How many orders belong to each order status?

select status, count(order_id) as total_orders 
from orders
group by status
order by total_orders desc;


-- 2. Analyse delivery status & performance
-- How many deliveries belong to each delivery status?

select delivery_status, count(delivery_id) as total_deliveries
from deliveries 
group by delivery_status
order by total_deliveries desc;


-- 3. Average delivery time & long deliveries
-- On average, how many days does a completed delivery take?

select avg(days) as avg_days
from (
	select datediff(delivery_date, dispatch_date) as days
    from deliveries 
    where delivery_status = 'delivered') as d;
    
 
-- 4. Top 10 longest deliveries
-- Which 10 delivered orders took the longest to arrive?

select delivery_id, datediff(delivery_date, dispatch_date) as days
from deliveries
group by delivery_id 
order by days desc
limit 10;


-- 5. Track monthly order volumes
-- How does order volume change month by month?

select month(order_date) as month, count(order_id) as order_volume
from orders 
group by month 
order by order_volume desc;


-- 6. Analyse payment status distribution
-- How are payment records distributed across statuses?

select payment_status, count(*) as total_payments
from payments
group by payment_status
order by total_payments desc;


-- 7. Identify delayed deliveries (> 5 days)
-- Which completed deliveries took longer than five days?

select delivery_id, datediff(delivery_date, dispatch_date) as days
from deliveries
where delivery_status= 'delivered' and 
 datediff(delivery_date, dispatch_date) > 5;


-- 8. Compare delivery performance by city
-- Which customer cities have the longest average delivery times?

select c.city, avg(datediff(delivery_date, dispatch_date)) as avg_days
from deliveries d
join orders o 
on d.order_id=o.order_id
join customers c 
on o.customer_id=c.customer_id
where d.delivery_status= 'delivered'
group by c.city
order by avg_days desc;







/* Insights
1. It takes around 4 days to complete a delivery approximately.
2. The longest days taken to complete a delivery is 10 days. 
3. There are nearly 222 payments have been failed. 
4. The city 'Mumbai' has the highest average delivery time
5. The city 'Surat' has the lowest average delivery time
*/