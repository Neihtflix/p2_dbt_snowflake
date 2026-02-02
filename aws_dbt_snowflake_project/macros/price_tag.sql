{% macro price_tag(col) %}
    CASE
        WHEN cast({{ col }} AS integer) < 100 THEN 'low'
        WHEN cast({{ col }} AS integer) >= 100 AND cast({{ col }} AS integer) < 200 THEN 'medium'
        ELSE 'high'
    END
{% endmacro %}