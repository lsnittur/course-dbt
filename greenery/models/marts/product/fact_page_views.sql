{{
    config(
        materialized = 'table' 
    )
}}

with page_views_cte as (
    SELECT
    page_url
    ,COUNT( distinct session_id) as page_views
    ,MIN(created_at) as page_viewed_at
    FROM {{ref('events_stg')}}
    WHERE event_type = 'page_view'
    GROUP BY page_url
)

SELECT * from page_views_cte