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
