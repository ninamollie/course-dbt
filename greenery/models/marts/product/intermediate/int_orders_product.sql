{{ 
    config(
        materialized='table'
) 
}}

WITH events AS (
    SELECT * FROM {{ ref('stg_events') }}
)

, order_items as (
    SELECT * FROM {{ ref('stg_order_items')}}
)

SELECT 
    order_items.order_items_product_id
    , DATE(created_at) AS created_day
    , COUNT(DISTINCT order_items.order_items_order_id) as total_daily_orders
FROM events
LEFT JOIN order_items
    ON events.events_order_id = order_items.order_items_order_id
GROUP BY 1, 2