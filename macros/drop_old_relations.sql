{% macro drop_old_relation(dryrun=True) %}


{# 1. find all models, seeds and snapshots #}

{% set nodes = [] %}

{% for node in graph.nodes.values() | selectattr("resource_type", "in", ["model", "seed", "snapshot"]) %}
    {% do nodes.append(node.name) %}
{% endfor %}

{#% do log(nodes, True) %#}


{# 2. find all tables not in nodes #}

{% set query %}
select 'DROP ' || case table_type when 'BASE TABLE' then 'TABLE ' when 'VIEW' then 'VIEW ' end || table_schema || '.' || table_name || ';' query
  from information_schema.tables
 where table_schema in ('dds','intermediate')
   and table_name not in (
    {%- for node in nodes -%}
        '{{ node }}'
        {%- if not loop.last -%}
            ,
        {%- endif %}
    {%- endfor -%}
)
--and table_name != 'fct_bookings_v1'
{% endset %}

{#% do log(query, True) %#}

{% set queries = run_query(query).columns[0].values() %}

{#% do log(queries, True) %#}


{# 3. drop / log tables #}

{% for query in queries %}
    {% if dryrun != True %}
        {% do log("Executing:  " + query, True) %}
        {% do run_query(query) %}
    {% else %}
        {% do log(query, True) %}
    {% endif %}
{% else %}
    {% do log("Nothing to drop", True) %}
{% endfor %}

{% endmacro %}