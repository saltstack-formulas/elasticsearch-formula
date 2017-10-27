{% from "elasticsearch/map.jinja" import elasticsearch_map with context %}
{% from "elasticsearch/settings.sls" import elasticsearch with context %}

elasticsearch_pkg:
  pkg.installed:
    - name: {{ elasticsearch_map.pkg }}
    {% if elasticsearch.version %}
    - version: {{ elasticsearch.version }}
    {% endif %}
    {% if salt['pillar.get']('elasticsearch:use_repo', True) == True %}
    - require:
      - sls: elasticsearch.repo
    {% endif %}
