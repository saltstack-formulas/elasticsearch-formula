include:
  - elasticsearch.service

{%- set major_version = salt['pillar.get']('elasticsearch:major_version', 2) %}

{%- if major_version == 5 %}
{%- set jvm_opts = salt['pillar.get']('elasticsearch:jvm_opts') %}
{%- if jvm_opts %}
/etc/elasticsearch/jvm.options:
  file.managed:
    - mode: 0770
    - owner: elasticsearch
    - group: elasticsearch
    - contents: {{ jvm_opts }}
    - watch_in:
      - service: elasticsearch
{% endif -%}
{% endif -%}
