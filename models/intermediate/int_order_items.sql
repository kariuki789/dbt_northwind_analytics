{{ config(materialized='ephemeral') }}

-- Enriches each order line item with product name and category.
-- Used by fct_order_details and any mart that needs line-level product context.
select
    od.order_id,
    od.product_id,
    od.unit_price,
    od.quantity,
    od.discount,
    od.line_total,
    od.is_discounted,
    p.product_name,
    p.units_in_stock,
    p.needs_reorder,
    p.category_id,
    c.category_name
from {{ ref('stg_order_details') }} as od
left join {{ ref('stg_products') }}   as p on p.product_id  = od.product_id
left join {{ ref('stg_categories') }} as c on c.category_id = p.category_id
