{{
  config(
    MATERIALIZED = 'table'
  )
}}

with products as (

    select
    product_id as product_id,
    name as  product_name,
    price as product_price,
    inventory asproduct_inventory
    from {{ ref('products_stg') }}

)

select * from products