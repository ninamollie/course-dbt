{{ 
    config(
        materialized='table'
) 
}}

WITH events AS (
    SELECT * FROM {{ ref('stg_events') }}
)

, order_items AS (
    SELECT * FROM {{ ref('stg_order_items') }}
)

, products AS (
    SELECT * FROM {{ ref('stg_products') }}
)

,final AS (
    SELECT 
    events.event_id,
    events.session_id,
    events.events_order_id,
    order_items.order_items_order_id,
    order_items.order_items_product_id,
    products.name,
    order_items.quantity
    FROM events
    JOIN order_items on  order_items.order_items_order_id = events.events_order_id
    JOIN products ON products.product_id = order_items.order_items_product_id
    WHERE event_type = 'checkout'
)

SELECT * FROM final