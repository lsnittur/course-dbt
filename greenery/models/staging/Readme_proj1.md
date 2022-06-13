How many users do we have?
query:
select count(*) from dbt_lakshmi_n.users_stg 
answer:
=130

On average, how many orders do we receive per hour?

query:
with avg_orders_cte as(
select date_trunc('hour', created_at) created_hour,
 count(order_id) no_of_orders
 from dbt_lakshmi_n.orders_stg
 group by created_hour)
 select avg(no_of_orders) as avg_orders from avg_orders_cte
 answer:
 =7.5

On average, how long does an order take from being placed to being delivered?

 query:
 with order_duration_cte as(
 select order_id,((date_part('day',delivered_at::date)-date_part('day',created_at::date))*24 
 + (date_part('hour',delivered_at::date)-date_part('hour',created_at::date))) order_duration
 from dbt_lakshmi_n.orders_stg
 where delivered_at is not null)
 select avg(order_duration) as avg_duration_hours from order_duration_cte
 =~93 hours

How many users have only made one purchase? Two purchases? Three+ purchases?

query:
 with purchase_count_cte as(
 select user_id, count(order_id) order_count
from dbt_lakshmi_n.orders_stg
 group by user_id
)
 
 select 
 count(user_id) filter( where order_count=1) as one_purchase,
 count(user_id) filter( where order_count=2) as two_purchases,
 count(user_id) filter( where order_count>=3) as more_than_three_purchases
 from purchase_count_cte

answer: 
number of users who made one purchase=25
number of users who made two purchases=28
number of users who made 3 or more purchases=71

Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

On average, how many unique sessions do we have per hour?
query:
 with sessions_per_hour_cte as(select count(distinct session_id) as session_count, 
 date_trunc('hour', created_at) created_hour
 from dbt_lakshmi_n.events_stg
 group by created_hour)
 select avg(session_count) from sessions_per_hour_cte

 answer:
 ~16 unique sessions per hour