{% from "elasticsearch/map.jinja" import elasticsearch_map with context %}
{% from "elasticsearch/settings.sls" import elasticsearch with context %}

include:
  - elasticsearch.pkg
  - elasticsearch.config
  - elasticsearch.sysconfig
  - elasticsearch.jvmopts
  - elasticsearch.service
  - elasticsearch.plugins
{%- if elasticsearch_map.curator is defined %}
  - elasticsearch.curator
{%- endif %}
