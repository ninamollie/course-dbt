{{
  config(
    materialized='table'
  )
}}

SELECT
cast(se.created_at as date) as date,
se.product_id,
sp.name as product_name,
count(distinct case when event_type = 'page_view' then event_id else null end) as page_views,
count(distinct session_id) as sessions,
count(distinct case when event_type = 'add_to_cart' then event_id else null end) as add_to_carts,
count(distinct case when event_type = 'package_shipped' then event_id else null end) as packages_shipped,
count(distinct case when event_type = 'checkout' then event_id else null end) as checkouts
FROM {{ ref('stg_events') }} se
left join {{ ref('stg_products') }} sp on sp.product_id = se.product_id
group by 1,2,3