include:
  - elasticsearch.service

{% if grains.get('os_family') == 'Debian' %}
{% set sysconfig_file = '/etc/default/elasticsearch' %}
{% else %}
{% set sysconfig_file = '/etc/sysconfig/elasticsearch' %}
{% endif %}

{{ sysconfig_file }}:
  file.managed:
    - source: salt://elasticsearch/files/sysconfig
    - user: elasticsearch
    - group: elasticsearch
    - mode: 0600
    - template: jinja
    - watch_in:
      - service: elasticsearch_service
    - context:
        sysconfig: {{ salt['pillar.get']('elasticsearch:sysconfig', '{}') }}
