{{ config(materialized='table') }}

with line as (
  select * from {{ ref('int_product_profit') }}
),
agg as (
  select
    year,
    month,
    product_id,
    any_value(product_name) as product_name,
    any_value(category)     as category,
    any_value(subcategory)  as subcategory,
    any_value(brand)        as brand,
    sum(revenue)            as total_revenue,
    sum(cogs)               as total_cogs,
    sum(profit)             as total_profit
  from line
  group by year, month, product_id
)
select
  year,
  month,
  product_id,
  product_name,
  category,
  subcategory,
  brand,
  total_revenue,
  total_cogs,
  total_profit,
  case when total_revenue <> 0 then total_profit / total_revenue else null end as profit_margin
from agg
