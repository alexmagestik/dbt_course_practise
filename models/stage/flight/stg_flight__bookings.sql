{{ 
    config(
        materialized = 'incremental',
        incremental_strategy  "merge",
        tags = ['bookings'],
        merge_update_columns = ['total_amount'],
        merge_exclude_columns = ['book_date'],
        incremental_predicates = ["DBT_INTERNAL_DEST.book_date > current_timestamp - '7 day'::interval"] 
    )
}}
select book_ref, book_date, total_amount
from {{ source('demo_src', 'bookings')}}
{% if is_incremental() %}
WHERE
    book_ref > (SELECT max(book_ref) FROM {{ source('demo_src', 'bookings')}}) - '7 day'::interval
{% endif %}