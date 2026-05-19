{{ config(materialized='incremental', unique_key='order_id') }}

select
    order_id,
    customer_id,
    employee_id,
    order_date,
    required_date,
    shipped_date,
    shipper_id,
    freight,
    ship_name,
    ship_address,
    ship_city,
    ship_region,
    ship_postal_code,
    ship_country
from {{ ref('stg_orders') }}

{% if is_incremental() %}
    where order_date > (select max(order_date) from {{ this }})
{% endif %}
