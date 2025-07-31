{{ config(materialized='view') }}

with source_data as (
    select
       string_field_0 as customer_id,
        string_field_1 as company_name,
        string_field_2 as contact_name,
        string_field_3 as contact_title,
        string_field_4 as address,
        string_field_5 as city,
        string_field_6 as region,
        string_field_7 as postal_code,
        string_field_8 as country,
        string_field_9 as phone,
        string_field_10 as fax
    from {{ source('northwind', 'customers') }}
)
,

cleaned as (
    select
        customer_id,
        company_name,
        contact_name,
        contact_title,
        address,
        city,
        case 
            when region is null or trim(region) = '' then 'Not Specified'
            else region 
        end as region,
        postal_code,
        country,
        phone,
        fax,
        
        -- Add useful fields for analysis
        case 
            when country in ('USA', 'Canada', 'Mexico') then 'North America'
            when country in ('Germany', 'France', 'UK', 'Italy', 'Spain', 'Austria', 'Belgium', 'Denmark', 'Finland', 'Ireland', 'Norway', 'Poland', 'Portugal', 'Sweden', 'Switzerland') then 'Europe'
            when country in ('Brazil', 'Argentina', 'Venezuela') then 'South America'
            else 'Other'
        end as region_group,
        
        -- Customer name standardization
        coalesce(company_name, 'Unknown Company') as company_name_clean,
        coalesce(contact_name, 'Unknown Contact') as contact_name_clean
        
    from source_data
)

select * from cleaned