{{ 
    config(
        materialized = 'incremental',
        incremental_strategy = "append",
        unique_key = ['book_ref'],
        tags = ['bookings'],
        merge_update_columns = ['total_amount'],
        incremental_predicates = ["DBT_INTERNAL_DEST.book_date > '2017-01-01'"] 
    )
}}
select book_ref, book_date, {{ to_money('total_amount', scale=2) }} as total_amount
from {{ source('demo_src', 'bookings')}}
{# incremental load #}
{% if is_incremental() -%}
WHERE
    book_date > (SELECT max(book_date) FROM {{ this }})  --'7 day'::interval
    {#{- limit_data('book_date', 2000) }#}
{% endif %}