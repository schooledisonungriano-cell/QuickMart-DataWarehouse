{{ config(
    materialized='table',
    cluster_by=['year','month','product_id'],
    tags=['marts']
) }}

with monthly_profit as (
    select
        year,
        month,
        product_id,
        product_name,
        category,
        subcategory,
        brand,
        sum(revenue) as total_revenue,
        sum(cogs) as total_cogs,
        sum(profit) as total_profit,
        avg(profit_margin) as avg_profit_margin
    from {{ ref('int_product_profit') }}
    group by year, month, product_id, product_name, category, subcategory, brand
)

select * from monthly_profit
