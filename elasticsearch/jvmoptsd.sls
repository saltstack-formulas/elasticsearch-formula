include:
  - elasticsearch.service

{% from "elasticsearch/settings.sls" import elasticsearch with context %}

{% if elasticsearch.major_version >= 7 %}
{%- set jvm_opts_d_dir = '/etc/elasticsearch/jvm.options.d' %}
{%- set jvm_opts_d = salt['pillar.get']('elasticsearch:jvm_opts_d', {}) %}
{%- set all_files = salt['file.find'](jvm_opts_d_dir, type='f', name='*.options', print='name', maxdepth=1) %}

{%- for exists_file in all_files %}
{%- if exists_file | regex_replace("\.options$", "") not in jvm_opts_d.keys() %}
{{ jvm_opts_d_dir }}/{{ exists_file }}:
  file.absent:
    - watch_in:
      - service: elasticsearch
{%- endif %}
{%- endfor %}

{%- for filename, val in jvm_opts_d.items() %}
{{ jvm_opts_d_dir }}/{{ filename }}.options:
  file.managed:
    - mode: 0660
    - user: elasticsearch
    - group: elasticsearch
    - contents: {{ val | yaml }}
    - watch_in:
      - service: elasticsearch
{% endfor -%}
{% endif -%}
