{{ config(
    materialized='table',
    cluster_by=['year','month','product_id'],
    tags=['intermediate']
) }}


with sales as (
  select * from {{ ref('stg_sales') }}
),
products as (
  select * from {{ ref('stg_products') }}
),
dates as (
  select * from {{ ref('stg_date') }}
),
joined as (
  select
    d.year,
    d.month,
    p.product_id,
    p.product_name,
    p.category,
    p.subcategory,
    p.brand,
    s.sales_id,
    s.quantity,
    s.unit_price,
    s.discount,                          
    p.cost,
    (s.quantity * s.unit_price * (1 - s.discount)) as revenue,
    (s.quantity * p.cost)                as cogs
  from sales s
  join products p on s.product_id = p.product_id
  join dates d    on s.date_id    = d.date_id
)

select
  *,
  (revenue - cogs) as profit,
  case when revenue <> 0 then (revenue - cogs) / revenue else null end as profit_margin
from joined
