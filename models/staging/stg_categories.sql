{{ config(materialized='view') }}

select
    categoryID   as category_id,
    categoryName as category_name,
    description
from {{ source('northwind', 'categories') }}
