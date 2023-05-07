{{
  config(
    materialized='table'
  )
}}

SELECT 
    event_id,
    session_id,
    user_id,
    event_type,
    page_url,
    created_at,
    order_id AS events_order_id,
    product_id AS events_product_id
FROM {{ source('postgres', 'events') }}