include:
{% if salt['pillar.get']('elasticsearch:add_repo', True) %}
  - elasticsearch.repo
{% endif %}
  - elasticsearch.pkg
  - elasticsearch.config
  - elasticsearch.sysconfig
  - elasticsearch.jvmopts
  - elasticsearch.service
  - elasticsearch.plugins
