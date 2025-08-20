{{ 
    config(
        materialized = 'view',
    )
}}
select aircraft_code, model, range
from {{ source('demo_src', 'aircrafts')}}