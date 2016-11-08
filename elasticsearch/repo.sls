elasticsearch_repo:
  pkgrepo.managed:
    - humanname: Elasticsearch 2.
    {% if grains.get('os_family') == 'Debian' %}
    - name: deb http://packages.elastic.co/elasticsearch/2.x/debian stable main
    - dist: stable
    - file: /etc/apt/sources.list.d/elasticsearch.list
    {% if  salt['pillar.get']('elasticsearch:config:hkp_port_blocked', False) %}
    - keyid: D88E42B4
    - keyserver: keyserver.ubuntu.com
    {% else %}
    - key_url: http://packages.elastic.co/GPG-KEY-elasticsearch
    {% endif %}
    - clean_file: true
    {% elif grains['os_family'] == 'RedHat' %}
    - name: elasticsearch
    - baseurl: http://packages.elastic.co/elasticsearch/2.x/centos
    - enabled: 1
    - gpgcheck: 1
    - gpgkey: http://packages.elastic.co/GPG-KEY-elasticsearch
    {% endif %}
