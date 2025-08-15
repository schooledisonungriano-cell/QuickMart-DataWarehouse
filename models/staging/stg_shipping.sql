{{ config(materialized='view') }}

with source as (
    select * from {{ source('quickmart_src', 'SHIPPING') }}
)

select
    shipping_id,
    method,
    carrier,
    delivery_time_days,
    shipping_cost
from source
