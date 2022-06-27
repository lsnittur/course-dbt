
select 
session_id,
user_id,
date_trunc('day',created_at) as created_at_day,
{{ event_type_grouping('page_view') }},
{{ event_type_grouping('add_to_cart') }},
{{ event_type_grouping('checkout') }},
{{ event_type_grouping('package_shipped') }},
min(created_at) as session_start,
max(created_at) as session_end,
max(created_at) - min(created_at) as session_length
from {{ ref('events_stg') }} events
group by 1,2,3