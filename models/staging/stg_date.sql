{{ config(materialized='view') }}

select
    date_id,
    month,
    year
from {{ source('quickmart_src', 'DATE') }}