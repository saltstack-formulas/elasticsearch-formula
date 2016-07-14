{% from "elasticsearch/map.jinja" import elasticsearch with context %}

elasticsearch:
  pkg.installed:
    - name: {{ elasticsearch.lookup.pkg }}

  service.running:
    - name: elasticsearch
    - enable: True
    - require:
      - pkg: elasticsearch

  pkgrepo.managed:
    - humanname: Elasticsearch 2.x
    - name: deb http://packages.elastic.co/elasticsearch/2.x/debian stable main
    - dist: stable
    - file: /etc/apt/sources.list.d/elasticsearch.list
    - keyid: D88E42B4
    - keyserver: keyserver.ubuntu.com
    - require_in:
      - pkg: elasticsearch
