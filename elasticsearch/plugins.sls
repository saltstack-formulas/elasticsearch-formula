include:
  - elasticsearch.pkg

{% for name, repo in salt['pillar.get']('elasticsearch:plugins', {}).items() %}
elasticsearch-{{ name }}:
  cmd.run:
    - name: /usr/share/elasticsearch/bin/plugin install {{ repo }}
    - require:
      - sls: elasticsearch.pkg
    - unless: test -x /usr/share/elasticsearch/plugins/{{ name }}
{% endfor %}
