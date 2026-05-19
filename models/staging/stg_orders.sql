{{ config(materialized='view') }}

select
    orderID as order_id,
    customerID as customer_id,
    employeeID as employee_id,
    orderDate     as order_date,
    requiredDate  as required_date,
    shippedDate   as shipped_date,
    shipVia as shipper_id,
    freight,
    shipName as ship_name,
    shipAddress as ship_address,
    shipCity as ship_city,
    shipRegion as ship_region,
    shipPostalCode as ship_postal_code,
    shipCountry as ship_country
from {{ source('northwind', 'orders') }}