{{ config(materialized='incremental', unique_key='order_id') }}

select
    order_id,
    count(*)                              as total_items,
    sum(quantity)                         as total_quantity,
    sum(line_total)                       as total_revenue,
    max(cast(is_discounted as int64)) = 1 as has_discounts
from {{ ref('int_order_items') }}

{% if is_incremental() %}
    where order_id > (select max(order_id) from {{ this }})
{% endif %}

group by 1
