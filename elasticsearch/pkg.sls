{% if salt['pillar.get']('elasticsearch:add_repo', True) %}
include:
  - elasticsearch.repo
{% endif %}

{% from "elasticsearch/map.jinja" import elasticsearch_map with context %}
{% from "elasticsearch/settings.sls" import elasticsearch with context %}

elasticsearch_pkg:
  pkg.installed:
    - name: {{ elasticsearch_map.pkg }}
    {% if elasticsearch.version %}
    - version: {{ elasticsearch.version }}
    {% endif %}
{% if salt['pillar.get']('elasticsearch:add_repo', True) %}
    - require:
      - sls: elasticsearch.repo
{% endif %}
