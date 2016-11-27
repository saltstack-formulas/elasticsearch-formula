include:
  - elasticsearch.pkg

{%- set plugins_pillar = salt['pillar.get']('elasticsearch:plugins', {}) %}
{% for name, repo in plugins_pillar.items() %}
elasticsearch-{{ name }}:
  cmd.run:
    - name: /usr/share/elasticsearch/bin/plugin install {{ repo }}
    - require:
      - sls: elasticsearch.pkg
    - unless: test -x /usr/share/elasticsearch/plugins/{{ name }}
{% endfor %}
