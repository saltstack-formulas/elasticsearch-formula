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
