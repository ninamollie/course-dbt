## Part 1. Models
#### What is our user repeat rate?

79.84%

```
WITH purchases_count as (
SELECT
    user_id as customer,
    count (distinct order_id) as count_purchases
FROM DEV_DB.DBT_NINAVANBOXTELMOLLIECOM.stg_orders 
GROUP BY 1)

, customer_count as (
SELECT
    count_purchases,
    count (distinct customer) as count_customers
FROM purchases_count
GROUP BY 1)

SELECT
    sum (case when count_purchases > 1 THEN count_customers ELSE 0 END)/sum (count_customers) AS customer_repeat_rate
FROM customer_count

0.798387

```

#### What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

Indicators from current data might be:
- current repeat rate
- usage of promo codes
- delivery time
- website visits
- type of product and its lifetime
- demographics

If data would be available:
- customer satisfaction
- returns
- campaigns

#### Explain the product mart models you added. Why did you organize the models in the way you did?

I added the models thinking about what a business question would be. 

#### What assumptions are you making about each model? (i.e. why are you adding each test?)

I added non_null and unique tests to ensure data quality

#### Did you find any “bad” data as you added and ran tests on your models? How did you go about either cleaning the data in the dbt model or adjusting your assumptions/tests?

Yes 4 errors

##### Which products had their inventory change from week 1 to week 2? 

Pothos
Philodendron
Monstera
String of pearls
