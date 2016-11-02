{%- set major_version = salt['pillar.get']('elasticsearch:major_version', 2) %}

include:
  - elasticsearch.repo

{% from "elasticsearch/map.jinja" import elasticsearch with context %}

elasticsearch_pkg:
  pkg.installed:
    - name: {{ elasticsearch.pkg }}
    - version: {{ major_version }}.*
    - require:
      - sls: elasticsearch.repo
