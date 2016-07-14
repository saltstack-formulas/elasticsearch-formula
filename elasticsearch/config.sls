{% from "elasticsearch/map.jinja" import elasticsearch with context %}

include:
  - elasticsearch

elasticsearch_cfg:
  file.managed:
    - name: /etc/elasticsearch/elasticsearch.yml
    - source: salt://elasticsearch/files/elasticsearch.yml
    - template: jinja
    - user: root
    - watch_in:
      - service: elasticsearch
    - require:
      - pkg: elasticsearch
