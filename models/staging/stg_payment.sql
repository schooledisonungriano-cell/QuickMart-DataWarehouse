{{ config(materialized='view') }}

with source as (
    select * from {{ source('quickmart_src', 'PAYMENT') }}
)

select
    payment_id,
    method,
    status
from source
