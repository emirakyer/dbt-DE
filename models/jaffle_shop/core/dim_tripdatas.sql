with greentrip as (

    select * from {{ ref('greentripexe')}}

),

yellowtrip as (

    select * from {{ ref('yellowtripexe') }}

),

greentrip_yellowtrip as (

    select
        vendorid,

        min(total_amount) as min_total_amount,
        max(total_amount) as max_total_amount,
        count(passenger_count) as number_of_passenger

    from yellowtrip
    group by 1

),

final as (

    select *


    from greentrip

    left join greentrip_yellowtrip using (vendorid)

)

select * from final