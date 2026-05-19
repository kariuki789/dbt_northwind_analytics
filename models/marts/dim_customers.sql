{{ config(materialized='table') }}

select
    customer_id,
    company_name,
    contact_name,
    contact_title,
    address,
    city,
    region,
    postal_code,
    country,
    phone,
    fax,
    case
        when country in ('USA', 'Canada', 'Mexico') then 'North America'
        when country in (
            'Germany', 'France', 'UK', 'Italy', 'Spain', 'Austria',
            'Belgium', 'Denmark', 'Finland', 'Ireland', 'Norway', 'Poland',
            'Portugal', 'Sweden', 'Switzerland'
        ) then 'Europe'
        when country in ('Brazil', 'Argentina', 'Venezuela') then 'South America'
        else 'Other'
    end as region_group,
    case
        when country in (
            'Germany', 'France', 'UK', 'Italy', 'Spain', 'Austria',
            'Belgium', 'Denmark', 'Finland', 'Ireland', 'Norway', 'Poland',
            'Portugal', 'Sweden', 'Switzerland'
        ) then true else false
    end as is_european,
    case
        when country in ('Germany', 'USA', 'Brazil', 'France') then 'Key Market'
        else 'Standard'
    end as customer_tier,
    coalesce(company_name, 'Unknown Company') as company_name_clean,
    coalesce(contact_name, 'Unknown Contact') as contact_name_clean
from {{ ref('stg_customers') }}
