include:
  - elasticsearch.service

{% if grains.get('os_family') == 'Debian' %}
{% set sysconfig_file = '/etc/default/elasticsearch' %}
{% else %}
{% set sysconfig_file = '/etc/sysconfig/elasticsearch' %}
{% endif %}

{% set sysconfig_data = salt['pillar.get']('elasticsearch:sysconfig', {}) %}

{% set heap_ratio = salt['pillar.fetch']('elasticsearch:heap_size_ratio', 0) %}
{% set heap_size = (salt['grains.get']('mem_total') * heap_ratio)|round(0)|int %}

{% if heap_size %}
{% do sysconfig_data.update({'ES_HEAP_SIZE': "{0}m".format(heap_size)}) %}
{% endif %}

{% if sysconfig_data %}
{{ sysconfig_file }}:
  file.managed:
    - source: salt://elasticsearch/files/sysconfig
    - owner: elasticsearch
    - group: elasticsearch
    - mode: 0600
    - template: jinja
    - watch_in:
      - service: elasticsearch_service
    - context:
        sysconfig: {{ sysconfig_data }}
{% endif %}
