{% set current_date = run_started_at | string | truncate(10, True, "")   %}
{% set current_year = run_started_at | string | truncate(4, True, "") | int  %}

SELECT 
    COUNT(*)
FROM
    {{ ref('fct_flights') }}
WHERE 
    scheduled_departure BETWEEN '{{ current_date | replace(current_year, current_year - 10) }}' and '{{ current_date }}'
