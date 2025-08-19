{#% set relation = load_relation(ref("dim_airports")) %#}
{#% set relation = api.Relation.create(database="dwh_flight", schema="dds", identifier="dim_airports") %#}
{#% set relation = api.Relation.create(identifier="dim_airports") %#}
{% set relation = adapter.get_relation(database="dwh_flight", schema="dds", identifier="dim_airports") %}

{{ "database: " ~ relation.database }}
{{ "schema: " ~ relation.schema }}
{{ "identifier: " ~ relation.identifier }}
{{ "is_table: " ~ relation.is_table }}
{{ "is_view: " ~ relation.is_view }}
{{ "is_cte: " ~ relation.is_cte }}

{{ "BEFORE "}}
{% for column in adapter.get_columns_in_relation(relation) -%}
    {{ "column: " ~ column }}
{% endfor%}

{%- do adapter.create_schema(
    api.Relation.create(
        database="dwh_flight",
        schema="test_schema"
    )
) %}

{%- do adapter.drop_schema(
    api.Relation.create(
        database="dwh_flight",
        schema="test_schema"
    )
) %}

{%- set stage = api.Relation.create(identifier="stg_flight__airports") %}

{% for column in adapter.get_missing_columns(stage, relation) -%}
    {{ "column: " ~ column }}
{% endfor%}

{% do adapter.expand_target_column_types(stage, relation) %}

{{ "AFTER" }}
{% for column in adapter.get_columns_in_relation(relation) -%}
    {{ "column: " ~ column }}
{% endfor%}


{{ "target.profile_name: " ~ target.profile_name }}
{{ "target.name: " ~ target.name }}
{{ "target.schema: " ~ target.schema }}
{{ "target.type: " ~ target.type }}
{{ "target.threads: " ~ target.threads }}
{{ "target.dbname: " ~ target.dbname }}
{{ "target.host: " ~ target.host }}
{{ "target.user: " ~ target.user }}
{{ "target.port: " ~ target.port }}
