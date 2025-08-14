{{ 
    config(
        materialized = 'table',
        indexes = [
            {
                "columns": ["city"],
                "unique": true,
            }
        ]
    )
}}
select city, region
from {{ ref('city_region') }}