include:
  - elasticsearch.service

{% from "elasticsearch/settings.sls" import elasticsearch with context %}

{% if elasticsearch.major_version >= 5 %}
{%- set jvm_opts = salt['pillar.get']('elasticsearch:jvm_opts') %}
{%- if jvm_opts %}
/etc/elasticsearch/jvm.options:
  file.managed:
    - mode: 0770
    - user: elasticsearch
    - group: elasticsearch
    - contents: {{ jvm_opts | yaml }}
    - watch_in:
      - service: elasticsearch
{% endif -%}
{% endif -%}
