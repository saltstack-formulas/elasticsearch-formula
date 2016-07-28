include:
  - elasticsearch.pkg
  - elasticsearch.config

elasticsearch_service:
  service.running:
    - name: elasticsearch
    - enable: True
    - watch:
      - file: elasticsearch_cfg
    - require:
      - sls: elasticsearch.pkg
