{{ 
    config(
        materialized='table'
    )
}}

with session_events as (
    select *
    from {{ ref ('int_session_events') }}
),

purchase_orders as (
    select *
    from {{ ref ('int_purchase_orders') }}
),

final as (
    select 
        session_events.event_id,
        session_events.events_product_id,
        purchase_orders.order_items_product_id,
        purchase_orders.name,
        purchase_orders.session_id as event_session_checkout,
        purchase_orders.quantity
    from session_events
    left join purchase_orders on purchase_orders.order_items_product_id = session_events.events_product_id
)

select *
from final