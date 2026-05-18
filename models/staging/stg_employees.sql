{{config(materialized='view')}}
select
   employeeID AS employee_id,
    LastName AS last_name,
    FirstName AS first_name,
    concat(FirstName, ' ', LastName) AS full_name,
    title,
    titleOfCourtesy AS title_of_courtesy,
    birthDate AS birth_date,
    hireDate AS hire_date,
    address,
    city,
    region,
    postalCode AS postal_code,
    country,
    homePhone AS home_phone,
    reportsTo AS reports_to
    from {{source('northwind','employees')}}
