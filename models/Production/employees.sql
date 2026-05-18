{{ config(materialized="table") }}

select
    *,
    date_diff(current_date(), cast(hire_date as date), year) as years_tenure,
    rank() over (order by hire_date asc) as tenure_rank,

    case
        when date_diff(current_date(), cast(hire_date as date), year) < 3 then 'Junior'
        when date_diff(current_date(), cast(hire_date as date), year) < 8 then 'Mid'
        when date_diff(current_date(), cast(hire_date as date), year) < 15 then 'Senior'
        else 'Veteran' end as seniority_band
from {{ ref("stg_employees") }}
