include:
  - elasticsearch.repo

{% from "elasticsearch/map.jinja" import elasticsearch with context %}

elasticsearch_pkg:
  pkg.installed:
    - name: {{ elasticsearch.pkg }}
    - require:
      - sls: elasticsearch.repo
