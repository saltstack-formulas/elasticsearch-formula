include:
  - elasticsearch.pkg

elasticsearch_shield_logging_cfg: 
  file.managed: 
    - name: /etc/elasticsearch/shield/logging.yml 
    - source: salt://elasticsearch/files/shield/logging.yml 
    - template: jinja 
    - user: root 
    - require: 
      - sls: elasticsearch.pkg 

elasticsearch_shield_role_mapping_cfg:
  file.managed:
    - name: /etc/elasticsearch/shield/role_mapping.yml
    - source: salt://elasticsearch/files/shield/role_mapping.yml
    - template: jinja
    - user: root 
    - require:
      - sls: elasticsearch.pkg

elasticsearch_shield_roles_cfg:
  file.managed:
    - name: /etc/elasticsearch/shield/roles.yml
    - source: salt://elasticsearch/files/shield/roles.yml
    - template: jinja
    - user: root 
    - require:
      - sls: elasticsearch.pkg
