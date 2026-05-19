{{ config(materialized='view') }}

select
    o.order_id,
    o.order_date,
    c.company_name,
    c.country,
    c.customer_tier,
    e.full_name,
    e.seniority_band,
    round(od.total_revenue, 2) as total_revenue,
    od.total_items
from {{ ref('fct_orders') }} as o
left join {{ ref('dim_customers') }}    as c  on c.customer_id  = o.customer_id
left join {{ ref('dim_employees') }}    as e  on e.employee_id  = o.employee_id
left join {{ ref('fct_order_details') }} as od on od.order_id    = o.order_id
