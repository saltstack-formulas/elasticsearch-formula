elasticsearch:
  version: 5.6.3
  config:
    cluster.name: escaleinfra
    node.name: node1
    path.data: /srv/data
    path.logs: /srv/logs
    network.host: 0.0.0.0 
    http.port: 9200
  sysconfig:
    ES_STARTUP_SLEEP_TIME: 5
    MAX_OPEN_FILES: 65535
  curator:
    curator_pkgs:
      - python-elasticsearch-curator
      - cron
    timeout: 900
    logfile: /var/log/elasticsearch/curator.log
    logformat: json
    master_only: true
    actions:
      - action: delete_indices
        description: >-
          Delete indices older than 7 days (based on index name).
          Ignore the error if the filter does not result in an actionable
          list of indices (ignore_empty_list) and exit cleanly.
        options:
          ignore_empty_list: True
          continue_if_exception: False
          disable_action: False
        filters:
          - filtertype: pattern
            kind: regex
            value: '.*\-\d\d\d\d\.\d\d\.\d\d$'
          - filtertype: age
            source: name
            direction: older
            timestring: '%Y.%m.%d'
            unit: days
            unit_count: 7 
