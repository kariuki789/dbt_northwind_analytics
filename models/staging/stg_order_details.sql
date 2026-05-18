{{ config(materialized="view") }}

select
    orderid as order_id,
    productid as product_id,
    unitprice as unit_price,
    quantity,
    discount,
    unitprice * quantity * (1 - discount) as line_total,
    CASE WHEN  discount > 0 THEN true ELSE false END AS is_discounted
from {{ source("northwind", "order_details") }}
