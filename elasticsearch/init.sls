include:
  - elasticsearch.repo

{% from "elasticsearch/map.jinja" import elasticsearch with context %}

elasticsearch:
  pkg.installed:
    - name: {{ elasticsearch.lookup.pkg }}
    - require:
      - sls: elasticsearch.repo

  service.running:
    - name: elasticsearch
    - enable: True
    - require:
      - pkg: elasticsearch
