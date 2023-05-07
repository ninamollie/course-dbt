## Part 1. Create new models to answer the first two questions 
#### What is our overall conversion rate?

10,16

```
with session_counts as (
    select
        count(distinct event_session_checkout) as sessions_with_purchase,
        count(distinct event_id) as total_sessions
    from DEV_DB.dbt_ninavanboxtelmolliecom.fact_conversion_rate
)

select
    round((sessions_with_purchase / total_sessions) * 100, 2) as overall_conversion_rate
from session_counts

```

| **Product Name** | **Overall Conversion Rate** |
|------------------| ----------------------------|
|String of pearls |	35.78|
|Cactus |	34.48|
|ZZ Plant |	34|
|Arrow Head |	33.98|
|Monstera |	33.33|
|Bamboo |	32.43|
|Devil's Ivy |	31.88|
|Rubber Plant |	31.82|
|Calathea Makoyana |	31.76|
|Money Tree |	31.71|
|Aloe Vera |	31.68|
|Philodendron |	31.58|
|Spider Plant |	31.46|
|Fiddle Leaf Fig |	31.46|
|Jade Plant |	31.43|
|Majesty Palm |	30.84|
|Pilea Peperomioides |	30.43|
|Orchid |	30.36|
|Dragon Tree |	30.21|
|Bird of Paradise |	29.03|
|Ficus |	28.16|
|Pink Anthurium |	27.93|
|Ponytail Palm |	27.72|
|Birds Nest Fern |	27.5|
|Snake Plant |	27.1|
|Boston Fern |	26.8|
|Peace Lily |	26.47|
|Alocasia Polly |	25.93|
|Angel Wings Begonia |	25.53|
|Pothos |	23.86|


## Part 6. dbt Snapshots
#### Which products had their inventory change from week 2 to week 3? 

Philodendron
String of pearls
Pothos
Monstera
ZZ Plant
Bamboo

```

with latest_update as (
    select max(dbt_valid_from) as max_date
    from DEV_DB.dbt_ninavanboxtelmolliecom.products_snapshot
    )
select distinct name
from DEV_DB.dbt_ninavanboxtelmolliecom.products_snapshot
join latest_update on latest_update.max_date = products_snapshot.dbt_valid_from
where dbt_valid_to is null
and dbt_valid_from = max_date;

```