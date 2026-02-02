{% macro trim_whitespace(col, node) %}
    {{ col | trim | upper }}
{% endmacro %}