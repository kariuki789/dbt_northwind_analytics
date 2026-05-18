{% snapshot employees_snapshot %}
{{ config(
    target_schema='snapshots',
    unique_key='employee_id',
    strategy='check',
    check_cols=['title', 'reports_to', 'city', 'country']
) }}

select * from {{ ref('stg_employees') }}

{% endsnapshot %}
