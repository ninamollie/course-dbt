How many users do we have?
130

SELECT COUNT(DISTINCT USER_ID)
FROM DEV_DB.DBT_NINAVANBOXTELMOLLIECOM.stg_users

On average, how many orders do we receive per hour?
7.520833

WITH orders_per_hour as(
SELECT 
    date_trunc('hour', created_at) as hour,
    count(distinct order_id) as count_orders
FROM DEV_DB.DBT_NINAVANBOXTELMOLLIECOM.stg_orders 
GROUP BY 1)

SELECT avg(count_orders) as avg_orders_per_hour
FROM orders_per_hour

On average, how long does an order take from being placed to being delivered?

3.891803 days

SELECT avg(datediff(day, created_at, delivered_at))
FROM DEV_DB.DBT_NINAVANBOXTELMOLLIECOM.stg_orders

How many users have only made one purchase? Two purchases? Three+ purchases?

1	25
2	28
3	34

WITH orders_per_user as (SELECT 
    user_id,
    count(order_id) as count_orders
FROM DEV_DB.DBT_NINAVANBOXTELMOLLIECOM.stg_orders
group by 1)

SELECT 
    count_orders,
    count(user_id)
FROM orders_per_user
group by 1 order by 1

On average, how many unique sessions do we have per hour?

16.327586

WITH sessions_per_hour as(
SELECT 
    date_trunc('hour', created_at) as hour,
    count(distinct session_id) as count_sessions
FROM DEV_DB.DBT_NINAVANBOXTELMOLLIECOM.stg_events 
GROUP BY 1)

SELECT avg(count_sessions) as avg_sessions_per_hour
FROM sessions_per_hour