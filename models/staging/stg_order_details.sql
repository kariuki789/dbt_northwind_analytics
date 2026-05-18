{{ config(materialized="view") }}

select
    orderid as order_id,
    productid as product_id,
    unitprice as unit_price,
    quantity,
    discount,
    unitprice * quantity * (1 - discount) as line_total,
    case when discount > 0 then true else false end as is_discounted
from {{ source("northwind", "order_details") }}
