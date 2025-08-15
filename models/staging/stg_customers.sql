{{ config(materialized='view') }}

with source as (
    select * from {{ source('quickmart_src', 'CUSTOMERS') }}
)

select
    customer_id,
    name,
    email,
    gender,
    age,
    city,
    region
from source
