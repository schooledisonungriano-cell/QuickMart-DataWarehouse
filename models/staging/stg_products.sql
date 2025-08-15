{{ config(materialized='view') }}

with source as (
    select * from {{ source('quickmart_src', 'PRODUCTS') }}
)
select
    product_id,
    product_name,
    category,
    subcategory,
    brand,
    list_price,
    cost
from source