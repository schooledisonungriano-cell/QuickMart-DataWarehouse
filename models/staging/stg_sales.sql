{{ config(materialized='view') }}

with source as (
    select * from {{ source('quickmart_src', 'SALES') }}
)
select
    sales_id,
    date_id,
    customer_id,
    product_id,
    shipping_id,
    payment_id,
    quantity,
    unit_price,
    discount
from source
