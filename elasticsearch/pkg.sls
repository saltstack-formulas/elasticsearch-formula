{% from "elasticsearch/map.jinja" import elasticsearch with context %}

{%- if elasticsearch.use_upstream_repo %}
include:
  - elasticsearch.repo
{% endif %}

elasticsearch_pkg:
  pkg.installed:
    - name: {{ elasticsearch.lookup.pkg }}
    {%- if elasticsearch.use_upstream_repo %}
    - require:
      - sls: elasticsearch.repo
    {% endif %}
