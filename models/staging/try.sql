{{ config(materialized="view") }}

with tripdata as 
(
  select *,
    row_number() over(partition by vendorid, tpep_pickup_datetime ORDER BY tpep_pickup_datetime) as rn
  from `dtc-de-407116`.`dbt_lrn`.`yellow_tripdata`
  where vendorid is not null 
)
select
    -- identifiers
    to_hex(md5(cast(coalesce(cast(vendorid as 
    string
), '') || '-' || coalesce(cast(tpep_pickup_datetime as 
    string
), '') as 
    string
))) as tripid,
    cast(vendorid as integer) as vendorid,
    cast(ratecodeid as integer) as ratecodeid,
    cast(pulocationid as integer) as pickup_locationid,
    cast(dolocationid as integer) as dropoff_locationid,
    
    -- timestamps
    cast(tpep_pickup_datetime as timestamp) as pickup_datetime,
    cast(tpep_dropoff_datetime as timestamp) as dropoff_datetime,
    
    -- trip info
    cast(passenger_count as integer) as passenger_count,
    cast(trip_distance as numeric) as trip_distance,
    cast(store_and_fwd_flag as boolean) as store_and_fwd_flag,
    cast(trip_type as integer) as trip_type,
    
    -- payment info
    cast(fare_amount as numeric) as fare_amount,
    cast(extra as numeric) as extra,
    cast(mta_tax as numeric) as mta_tax,
    cast(tip_amount as numeric) as tip_amount,
    cast(tolls_amount as numeric) as tolls_amount,
 --   cast(ehail_fee as numeric) as ehail_fee,
    cast(improvement_surcharge as numeric) as improvement_surcharge,
    cast(total_amount as numeric) as total_amount,
    cast(payment_type as integer) as payment_type,
    --'Payment Description' as payment_type_description,  -- Bu kısmı, doğru bir açıklamayı yazmalısınız
    cast(congestion_surcharge as numeric) as congestion_surcharge
from tripdata
where rn = 1;
