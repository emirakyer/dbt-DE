{{ config(materialized="view")}}

select *
    
    from {{ source('staging', 'yellow_tripdata') }}
    limit 100
--source('staging','green_tripdata'