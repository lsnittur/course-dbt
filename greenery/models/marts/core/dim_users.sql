{{
  config(
    MATERIALIZED = 'table'
  )
}}

with users as (

    select
  user_id as user_guid,
  first_name ,
  last_name ,
  email ,
  phone_number ,
  created_at ,
  updated_at ,
  address_id as address_guid
    from {{ ref('users_stg') }}

)

select * from users