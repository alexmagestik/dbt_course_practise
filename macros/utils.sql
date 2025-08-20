{% macro to_money(value, scale=2) %}
    {% if scale < 0 %}
        {% do exceptions.raise_compiler_error("Invalid scale: " ~ scale) %}
    {% elif scale == 0 %}
        {% do exceptions.warn("Possibly incorrect scale: " ~ scale) %}
    {% endif %}
    ({{ value }} / 100)::numeric(16, {{ scale }})
{% endmacro %}


{% macro concat_columns(columns, delimeter="''") %}
    {%- for column in columns -%}
        {{ column }} {% if not loop.last %} || {{delimeter}} || {% endif -%}
    {% endfor %}
{%- endmacro %}


{% macro limit_data(date_column, days_limit=7) %}
    {% if target.name == 'dev' %}
        {# and {{ date_column }} >= current_date - interval '{{ days_limit }} day' #}
        and {{ date_column }} >= {{ dbt.dateadd(datepart="day", interval=-days_limit, from_date_or_timestamp="current_date") }}
    {% endif %}
{% endmacro %}