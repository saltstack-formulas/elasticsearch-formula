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

{%- set java_home = salt['pillar.get']('elasticsearch:java_home', '/usr/lib/java') %}
manage Elasticsearch JAVA_HOME in environment file:
  file.replace:
    - name: {{ sysconfig_file }}
    - pattern: ^[\s#]*JAVA_HOME=.*$
    - repl: JAVA_HOME={{ java_home }}
    - prepend_if_not_found: true
    - watch_in:
      - service: elasticsearch
