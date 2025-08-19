{{ 
    config(
        materialized = 'table',
        post_hook = '
            {% set backup_relation = api.Relation.create(
                database = this.database,
                schema = this.schema,
                identifier = this.identifier ~ "_backup",
                type = "table"
            )%}
            {% do adapter.drop_relation(backup_relation) %}
            {#% do adapter.rename_relation(this, backup_relation) %#}
        '
    )
}}
select airport_code::varchar(4) as airport_code, airport_name, city, coordinates, timezone as {{ adapter.quote('timezone') }}, 'test' as test_column
from {{ source('demo_src', 'airports')}}