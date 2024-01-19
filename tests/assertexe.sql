with trip as (SELECT * from {{ ref('greentripexe')}})

select vendorid, count(PULocationID) as num_rides from trip
group by vendorid
having num_rides > 10
