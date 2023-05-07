{{
  config(
    materialized='table'
  )
}}

SELECT 
    order_id AS order_items_order_id,
    product_id AS order_items_product_id,
    quantity
FROM {{ source('postgres', 'order_items') }}