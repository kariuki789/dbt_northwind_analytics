{{ config(materialized='view') }}

with source_data as (
    select
        orderID as order_id,
        customerID as customer_id,
        employeeID as employee_id,
        orderDate as order_date,
        requiredDate as required_date,
        shippedDate as shipped_date,
        shipVia as shipper_id,
        freight,
        shipName as ship_name,
        shipAddress as ship_address,
        shipCity as ship_city,
        shipRegion as ship_region,
        shipPostalCode as ship_postal_code,
        shipCountry as ship_country
    from {{ source('northwind', 'orders') }}
),

cleaned as (
    select
        order_id,
        customer_id,
        employee_id,
        date(order_date) as order_date,
        date(required_date) as required_date,
        date(shipped_date) as shipped_date,
        shipper_id,
        freight,
        ship_name,
        ship_address,
        ship_city,
        ship_region,
        ship_postal_code,
        ship_country,
        
        -- Calculated fields
        case 
            when shipped_date is not null then date_diff(date(shipped_date), date(order_date), day)
            else null 
        end as days_to_ship,
        
        case 
            when shipped_date <= required_date then 'On Time'
            when shipped_date > required_date then 'Late'
            when shipped_date is null and current_date() > required_date then 'Overdue'
            else 'Pending'
        end as shipping_status,
        
        -- Add some useful date parts for analysis
        extract(year from order_date) as order_year,
        extract(month from order_date) as order_month,
        extract(quarter from order_date) as order_quarter,
        format_date('%A', order_date) as order_day_of_week
        
    from source_data
)

select * from cleaned