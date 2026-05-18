{{ config(materialized="table") }}

select
    *,
    CASE WHEN region_group = 'Europe' THEN true  ELSE false END AS is_european,
    case
        WHEN country IN ('Germany', 'USA', 'Brazil', 'France')
        THEN 'Key Market'
        ELSE 'Standard'
    END AS customer_tier
from {{ ref("stg_customers") }}
