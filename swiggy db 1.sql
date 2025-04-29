SELECT name, city 
from 
customers
 where city = "Delhi";

SELECT avg(rating) 
from restaurants
 where city ="Mumbai";

SELECT distinct customers.customer_id, customers.name
 from customers 
 inner join 
 orders 
 on customers.customer_id = orders.customer_id;

select
customers.customer_id,
customers.name,
count(orders.order_id) as total_orders
from
customers
left join
orders on customers.customer_id = orders.customer_id
group by customers.customer_id, customers.name;

select 
restaurants.restaurant_id,
restaurants.name,
coalesce(sum(orders.total_amount), 0) as revenue
from
restaurants
left join
orders on restaurants.restaurant_id = orders.restaurant_id
group by restaurants.restaurant_id , restaurants.name;

select 
restaurant_id, name, avg(rating) as avg_rating
from
restaurants
group by restaurant_id, name
order by avg_rating desc
limit 5;

select 
customers.customer_id, customers.name
from
customers
left join
orders on customers.customer_id = orders.customer_id
where
orders.customer_id is null;

select 
customers.customer_id, customers.name, customers.city ,
count(orders.order_id)
from
customers
left join
orders on customers.customer_id = orders.customer_id
where
customers.city = 'Mumbai'
group by customers.customer_id, customers.name,customers.city;

select * from orders
where order_date >= curdate() - interval 30 day;

select deliverypartners.partner_id,
deliverypartners.name,
count(deliveryupdates.order_id)
from
deliverypartners
join
orderdelivery on deliverypartners.partner_id = orderdelivery.partner_id
join
deliveryupdates on orderdelivery.order_delivery_id = deliveryupdates.delivery_id
where
deliveryupdates.status = 'delivered'
group by deliverypartners.partner_id,deliverypartners.name;

select 
customers.customer_id, customers.name, customers.city ,
count(orders.order_id)
from
customers
join
orders on customers.customer_id = orders.customer_id
group by customers.customer_id, customers.name, customers.city
having count(distinct orders.order_date);

select deliverypartners.partner_id,
deliverypartners.name,
count(distinct orders.customer_id) customer_count
from deliverypartners
join
orderdelivery on deliverypartners.partner_id = orderdelivery.partner_id
join
orders on orderdelivery.order_id = orders.order_id
group by deliverypartners.partner_id , deliverypartners.name
order by customer_count desc
limit 1;

select distinct
c1.name as customer1,
c2.name as customer2,
c1.city,
o1.restaurant_id,
r.name,
date(o1.order_date) as order_date1,
date(o2.order_date) as order_date2
from 
customers c1
join
orders o1 on c1.customer_id = o1.customer_id
join
customers c2 on c1.city = c2.city
join
orders o2 on c2.customer_id = o2.customer_id
join
restaurants r on r.restaurant_id =o1.restaurant_id
where
o1.restaurant_id = o2.restaurant_id
and date (o1.order_date) <> date( o2.order_date)
and c1.customer_id <>c2.customer_id
order by c1.city , o1.restaurant_id , order_date1;
