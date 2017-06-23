include:
  - elasticsearch.pkg

{%- if salt['pillar.get']('elasticsearch:systemd') %}
/etc/systemd/system/elasticsearch.service.d:
  file.directory:
    - user: root
    - group: root
    - mode: 0755
    - makedirs: True
    - require_in:
      - service: elasticsearch

/etc/systemd/system/elasticsearch.service.d/elasticsearch.conf:
  file.managed:
    - source: salt://elasticsearch/files/systemd.conf
    - user: root
    - group: root
    - mode: 0644
    - template: jinja
    - require:
      - sls: elasticsearch.pkg
    - watch_in:
      - service: elasticsearch_service
    - context:
        systemd: {{ salt['pillar.get']('elasticsearch:systemd') }}
  module.run:
    - name: service.systemctl_reload
    - onchanges:
      - file: /etc/systemd/system/elasticsearch.service.d/elasticsearch.conf
{%- endif %}
