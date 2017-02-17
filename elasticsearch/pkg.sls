{% from "elasticsearch/map.jinja" import elasticsearch with context %}

{%- set major_version = salt['pillar.get']('elasticsearch:major_version', 2) %}
{%- if elasticsearch.use_upstream_repo %}
include:
  - elasticsearch.repo
{% endif %}

elasticsearch_pkg:
  pkg.installed:
    - name: {{ elasticsearch.pkg }}
    - version: {{ major_version }}.*
{%- if elasticsearch.use_upstream_repo %}
    - require:
      - sls: elasticsearch.repo
{% endif %}
