PART 1

1) What is our overall conversion rate?
QUERY-
SELECT 
SUM(checkout)/COUNT(distinct session_id) as conversion_rate
FROM
dbt_lakshmi_n.fact_session_events

ANSWER=0.62456747404844290657

2)What is our conversion rate by product?
QUERY-
select
product_id,
name,
sum(nb_added_to_cart)/sum(nb_times_viewed) as conversion_rate
from dbt.dbt_lakshmi_n.fact_product_events
group by 1,2
order by 3 desc

ANSWER-
csv file in path- greenery/analyses/project_3_part_1_question_2_results.csv




