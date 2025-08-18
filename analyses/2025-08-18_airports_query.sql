SELECT  
    scheduled_departure::date as scheduled_departure,
    COUNT(*) as cancelled_fligth_cnt
FROM
    {{ ref('stg_flight__flights') }}
WHERE 
    departure_airport = 'MJZ'
    AND status = 'Cancelled'
GROUP BY
    scheduled_departure::date