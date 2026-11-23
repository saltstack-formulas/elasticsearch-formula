{%- from "elasticsearch/map.jinja" import elasticsearch_map with context -%}
{%- from "elasticsearch/settings.sls" import elasticsearch with context -%}

{%- if elasticsearch_map.use_repo -%}
include:
  - elasticsearch.repo
{%- endif %}

elasticsearch_pkg:
  pkg.installed:
    - name: {{ elasticsearch_map.pkg }}
    {%- if elasticsearch.version %}
    - version: {{ elasticsearch.version }}
    {%- endif %}
    {%- if grains['kernel'] == 'Linux' and elasticsearch_map.hold_version %}
    - hold: True
    - update_holds: True
    {%- endif %}
    {%- if elasticsearch_map.use_repo %}
    - require:
      - sls: elasticsearch.repo
    {%- endif %}
