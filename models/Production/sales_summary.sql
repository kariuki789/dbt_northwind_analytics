{{ config(materialized="view") }}

select
    order_id,
    order_date
    company_name,
    country,
    customer_tier
    employee_full_name,
    seniority_band
    round(total_revenue, 2) as total_revenue
    total_items
from {{ ref("orders") }} as o
left join
    {{ ref("customers") }} as c
    on c.customer_id = o.customer_id
left join
    {{ ref("employees") }} as e
    on e.employeed_id = o.employee_id
left join
    {{ ref("order_details") }} as od
    on od.order_id = o.order_id
