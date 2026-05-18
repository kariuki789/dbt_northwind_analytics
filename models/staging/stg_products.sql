{{ config(materialized="view") }}
select
    productid as product_id,
    productname as product_name,
    supplierid as supplier_id,
    categoryid as category_id,
    quantityperunit as quantity_per_unit,
    unitprice as unit_price,
    unitsinstock as units_in_stock,
    unitsonorder as units_on_order,
    reorderlevel as reorder_level,
    cast(discontinued as bool) as is_discontinued,
    case
        when unitsinstock <= reorderlevel
        then true
        else false end as needs_reorder
        from{{ source("northwind", "products") }}
