{%- set major_version = salt['pillar.get']('elasticsearch:major_version', 2) %}

{% from "elasticsearch/map.jinja" import elasticsearch with context %}

elasticsearch_pkg:
  pkg.installed:
    - name: {{ elasticsearch.pkg }}
    - version: {{ major_version }}.*
    {% if salt['pillar.get']('elasticsearch:use_repo') == 'True', True %}
    - require:
      - sls: elasticsearch.repo
    {% endif %}
