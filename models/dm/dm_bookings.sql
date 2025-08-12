{{ 
    config(
        materialized = 'table'
    )
}}
select book_ref, book_date, total_amount
from {{ ref('fct_bookings', v = 1) }}