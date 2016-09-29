include:
  - elasticsearch.pkg
  - elasticsearch.config
  - elasticsearch.shield

elasticsearch_service:
  service.running:
    - name: elasticsearch
    - enable: True
    - watch:
      - file: elasticsearch_cfg
      - file: elasticsearch_shield_logging_cfg
      - file: elasticsearch_shield_role_mapping_cfg
      - file: elasticsearch_shield_roles_cfg
    - require:
      - sls: elasticsearch.pkg
