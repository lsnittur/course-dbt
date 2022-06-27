select
p.product_id
,p.name
,count(p.product_id) as nb_times_viewed
,sum(case when e.event_type='add_to_cart' then 1
    else 0
    end) as nb_added_to_cart
from {{ ref('products_stg')}} p
left join {{ref('events_stg')}} e on e.product_id=p.product_id
group by 1,2
