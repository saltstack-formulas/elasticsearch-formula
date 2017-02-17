{% from "elasticsearch/map.jinja" import elasticsearch with context %}

include:
  {%- if elasticsearch.use_upstream_repo %}
  - elasticsearch.repo
  {% endif %}
  - elasticsearch.pkg
  - elasticsearch.config
  - elasticsearch.sysconfig
  - elasticsearch.jvmopts
  - elasticsearch.service
  - elasticsearch.plugins
