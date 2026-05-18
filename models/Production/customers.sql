{{config(materialized='table')}}

select * , case when region_group = 'Europe' Then TRUE ELSE FALSE END as is_europen,
case when country in ('Germany', 'USA', 'Brazil', 'France') then 'Key Market' else 'Standard' end as customer_tier
from {{ref("stg_customers")}}
