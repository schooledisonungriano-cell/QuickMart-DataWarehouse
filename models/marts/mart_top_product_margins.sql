{{ config(materialized='view') }}

with m as (
  select * from {{ ref('mart_product_profit_margin') }}
),
ranked as (
  select
    m.*,
    row_number() over (
      partition by year, month
      order by profit_margin desc nulls last, total_revenue desc
    ) as rank_by_margin
  from m
  where total_revenue > 0
)
select *
from ranked
where rank_by_margin <= 5
