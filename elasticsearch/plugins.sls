include:
  - elasticsearch.pkg

{%- from "elasticsearch/map.jinja" import elasticsearch with context -%}
{%- if elasticsearch['plugins'] is defined %}

{% for name, repo in elasticsearch.plugins.iteritems() %}
elasticsearch-{{ name }}:
  cmd.run:
    - name: /usr/share/elasticsearch/bin/plugin install {{ repo }}
    - require:
      - sls: elasticsearch.pkg
    - unless: test -x /usr/share/elasticsearch/plugins/{{ name }}
{% endfor %}

{%- else %}
# no plugins
{%- endif %}
