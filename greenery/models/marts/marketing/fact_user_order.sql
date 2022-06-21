{{
    config(
        materialized = 'table' 
    )
}}

with product_order_item_cte as (
    select 
    order_items.order_id
    , COUNT(products.product_id) as num_products
    , SUM(order_items.quantity) as num_items
    from {{ ref('order_items_stg')}} as order_items
    join {{ref('dim_products')}} as products
    using (product_id)
    group by 1
),
user_order_cte as (
    select 
      users.user_guid
    , COUNT(orders.order_guid) as num_orders
    , AVG(orders.order_total) as avg_price_total_usd
    , SUM(orders.order_total) as total_spent_usd
    , MIN(orders.created_at) as first_order_placed_utc
    , MAX(orders.created_at) as last_order_placed_utc
    from {{ ref('fact_orders')}} as orders 
    left join {{ ref('dim_users')}} as users
    using (user_guid)
    group by 1
)

select * from user_order_cte