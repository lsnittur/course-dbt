{% macro event_type_grouping(column_value) %}
    sum(case when event_type = '{{ column_value }}'  then 1 else 0 end) as {{ column_value }}
{% endmacro %}