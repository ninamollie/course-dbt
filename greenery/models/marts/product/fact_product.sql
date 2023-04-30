{{ 
    config(
        materialized='table'
) 
}}

WITH product_events AS (
   SELECT * FROM {{ ref('int_product_events') }}
), 


orders_products AS (
    SELECT * FROM {{ ref('int_orders_product') }}
)

SELECT 
product_events.product_id
, product_events.created_day
, product_events.page_view
, product_events.add_to_cart
, orders_products.total_daily_orders
FROM product_events
LEFT JOIN orders_products 
    ON product_events.product_id = orders_products.product_id 
    AND product_events.created_day = orders_products.created_day