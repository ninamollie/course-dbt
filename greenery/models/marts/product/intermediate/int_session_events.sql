{{ 
    config(
        materialized='table'
    )
}}

{%- set event_types = dbt_utils.get_column_values(
    table = ref('stg_events'),
    column = 'event_type'
    )
%}

select
    event_id,
    session_id,
    events_order_id,
    events_product_id
    {%- for event_type in event_types %}
        , sum(case when event_type = '{{ event_type }}' then 1 else 0 end) as {{ event_type }} 
    {%- endfor %}
from {{ ref ('stg_events') }}
group by 1,2,3,4