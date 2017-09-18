include:
  - elasticsearch.pkg
  - elasticsearch.config

elasticsearch_service:
  service:
    - {{ "running" if salt['pillar.get']('elasticsearch:running', True) else "dead" }}
    - name: elasticsearch
    - enable: {{ salt['pillar.get']('elasticsearch:enabled', True) }}
{%- if salt['pillar.get']('elasticsearch:config') %}
    - watch:
      - file: elasticsearch_cfg
{%- endif %}
    - require:
      - pkg: elasticsearch
