include:
  - elasticsearch.pkg

{%- if salt['pillar.get']('elasticsearch:config') %}

## Ensure directory permissions are set as required.
## On SUSE with 6.x, this was not always ensured as it seemed.
elasticsearch_es_path_conf_chmod:
  file.directory:
    - name: /etc/elasticsearch
    - user: root
    - group: elasticsearch
    - mode: 2770

elasticsearch_cfg:
  file.serialize:
    - name: /etc/elasticsearch/elasticsearch.yml
    - dataset_pillar: elasticsearch:config
    - formatter: yaml
    - user: root
    - require:
      - sls: elasticsearch.pkg
{%- endif %}

{% set data_dir = salt['pillar.get']('elasticsearch:config:path.data') %}
{% set log_dir = salt['pillar.get']('elasticsearch:config:path.logs') %}

{% for dir in (data_dir, log_dir) %}
{% if dir %}
{{ dir }}:
  file.directory:
    - user: elasticsearch
    - group: elasticsearch
    - mode: 0750
    - makedirs: True
    - require_in:
      - service: elasticsearch
{% endif %}
{% endfor %}
