include:
  - elasticsearch.service

{% if grains.get('os_family') == 'Debian' %}
{% set sysconfig_file = '/etc/default/elasticsearch' %}
{% else %}
{% set sysconfig_file = '/etc/sysconfig/elasticsearch' %}
{% endif %}

{% set sysconfig_data = salt['pillar.get']('elasticsearch:sysconfig') %}
{% if sysconfig_data %}
{{ sysconfig_file }}:
  ini.options_present:
    - watch_in:
      - service: elasticsearch_service
    - sections:
          {%- for k,v in salt['pillar.get']('elasticsearch:sysconfig').items() %}
          {{ k }}: '{{ v }}'
          {%- endfor %}
{% endif %}
