include:
  - elasticsearch.pkg
  - elasticsearch.config
  - elasticsearch.sysconfig
  - elasticsearch.jvmopts
  - elasticsearch.service
  - elasticsearch.plugins
  {% if salt['pillar.get']('elasticsearch:use_repo', True) == True %}
  - elasticsearch.repo
  {% endif %}
