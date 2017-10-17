{%- set major_version = salt['pillar.get']('elasticsearch:major_version', 2) %}

{% from "elasticsearch/map.jinja" import elasticsearch with context %}

elasticsearch_pkg:
  pkg.installed:
    - name: {{ elasticsearch.pkg }}
    - version: {{ major_version }}.*
    {% if salt['pillar.get']('elasticsearch:use_repo', True) == True %}
include:
  - elasticsearch.repo

{% from "elasticsearch/map.jinja" import elasticsearch_map with context %}
{% from "elasticsearch/settings.sls" import elasticsearch with context %}

elasticsearch_pkg:
  pkg.installed:
    - name: {{ elasticsearch_map.pkg }}
    {% if elasticsearch.version %}
    - version: {{ elasticsearch.version }}
    {% endif %}
    - require:
      - sls: elasticsearch.repo
    {% endif %}
