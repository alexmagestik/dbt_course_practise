{{
    config(
        severity = 'warn',
        error_if = '>829069',
        warn_if = '>829070'
    )
}}
SELECT
    b.book_ref
FROM
    {{ ref('stg_flight__bookings') }} b
    JOIN {{ ref('stg_flight__tickets') }} t
        ON b.book_ref = t.book_ref
WHERE
    length(b.book_ref) > 5

