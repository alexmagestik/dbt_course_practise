{% snapshot dim_airports %}

{{
    config(
        target_schema = "dds",
        unique_key = "airport_code",
        strategy = "check",
        check_cols = ["airport_name", "city", "coordinates", "timezone"],
        dbt_valid_to_current = "'2100-01-01'",
        snapshot_meta_column_names = {
            "dbt_valid_from": "valid_from",
            "dbt_valid_to": "valid_to",
            "dbt_scd_id": "dbt_scd_id",
            "dbt_updated_at": "dbt_updated_at",
            "dbt_is_deleted": "is_deleted"
        },
        hard_deletes = "new_record",
    )
}}

select airport_code, airport_name, city, coordinates, timezone
from {{ ref('stg_flight__airports') }}

{% endsnapshot %}