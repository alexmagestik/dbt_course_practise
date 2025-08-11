{{ 
    config(
        materialized = 'table',
        on_configuration_change = "apply",
        indexes = [
            {
                "columns": ["book_ref"],
                "unique": true,
            }
        ]
    )
}}
select book_ref, book_date, total_amount
from {{ ref('stg_flight__bookings') }}