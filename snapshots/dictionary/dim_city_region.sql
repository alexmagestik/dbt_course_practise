{% snapshot dim_city_region %}

{{
    config(
        target_database="dwh_flight",
        target_schema="dds",
        unique_key="city",
        strategy="timestamp",
        updated_at="updated",
        dbt_valid_to_current="'2100-01-01'"
    )
}}

select city, region, updated
from {{ ref('city_region') }}

{% endsnapshot %}
