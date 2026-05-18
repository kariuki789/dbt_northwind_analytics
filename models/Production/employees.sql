{{ config(materialized="table") }}

select
    *,
    date_diff(current_date(), cast(hire_date as date), year) as years_tenure,
    rank() over (order by hire_date asc) as tenure_rank

from {{ ref("stg_employees") }}
