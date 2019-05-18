include:
  - elasticsearch.pkg
  - elasticsearch.config

elasticsearch_service:
  service.running:
    - name: elasticsearch
    - enable: True
{%- if salt['pillar.get']('elasticsearch:config') %}
    - watch:
      - file: elasticsearch_cfg
{%- endif %}
    - require:
      - pkg: elasticsearch_pkg
