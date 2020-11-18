include:
  - elasticsearch.pkg

{% from "elasticsearch/settings.sls" import elasticsearch with context %}
{%- set plugins_pillar = salt['pillar.get']('elasticsearch:plugins', {}) %}

{% if elasticsearch.major_version >= 5 %}
  {%- set plugin_bin = 'elasticsearch-plugin' %}
{% else %}
  {%- set plugin_bin = 'plugin' %}
{% endif %}

{% set es_version = salt['pkg.info_installed']('elasticsearch').get('elasticsearch', {}).get('version') %}
{% for name, repo in plugins_pillar.items() %}
{%   set es_plugin_file = salt['file.find']('/usr/share/elasticsearch/plugins/' + name, type='f', iname=name + '-*.jar')[0] %}

{%   if es_version not in es_plugin_file %}
elasticsearch-plugin-remove-{{ name }}:
  cmd.run:
    - name: /usr/share/elasticsearch/bin/{{ plugin_bin }} remove {{ repo }}
    - require:
      - sls: elasticsearch.pkg
{%   endif %}

elasticsearch-plugin-install-{{ name }}:
  cmd.run:
    - name: /usr/share/elasticsearch/bin/{{ plugin_bin }} install -b {{ repo }}
    - require:
      - sls: elasticsearch.pkg
    - unless: test -x /usr/share/elasticsearch/plugins/{{ name }}
{% endfor %}
