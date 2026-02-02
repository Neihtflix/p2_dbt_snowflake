/*
============================================================
Fact Table
Model: Gold Layer - Dynamic Star Schema
Logic: Metadata-driven join engine using Jinja loops
============================================================
*/

{% set configs = var('gold_fact') %}

SELECT
    {{ configs[0]['columns'] }}
FROM
    {% for config in configs %}
    {% if loop.first %}
        {{ ref(config['table']) }} AS {{ config['alias'] }}
    {% else %}
        LEFT JOIN {{ ref(config['table']) }} AS {{ config['alias'] }}
        ON {{ config['join_condition'] }}
    {% endif %}
    {% endfor %}