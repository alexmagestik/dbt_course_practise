{% macro to_money(value, scale=2) %}
    ({{ value }} / 100)::numeric(16, {{ scale }})
{% endmacro %}

{% macro concat_columns(columns, delimeter="''") %}
    {%- for column in columns -%}
        {{ column }} {% if not loop.last %}|| {{delimeter}} || {% endif -%}
    {% endfor %}
{%- endmacro %}

{% macro limit_data(date_column, days_limit=7) %}
    {% if target.name == 'dev' %}
        and {{ date_column }} >= current_date - interval '{{ days_limit }} day'
    {% endif %}
{% endmacro %}