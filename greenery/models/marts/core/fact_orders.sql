{{
    config(
        MATERIALIZED = 'table'
  )
}}

with orders as (

    SELECT
  order_id as order_guid ,
  user_id as user_guid,
  promo_id as promo_guid,
  address_id address_guid,
  created_at ,
  order_cost ,
  shipping_cost ,
  order_total ,
  tracking_id as tracking_guid ,
  shipping_service, 
  estimated_delivery_at, 
  delivered_at ,
  status as order_status
    FROM {{ ref('orders_stg') }}

)

SELECT * FROM orders