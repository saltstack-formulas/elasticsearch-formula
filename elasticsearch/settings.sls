# Previously states directly looked up elasticsearch:major_version.
# Now giving elasticsearch:major_version higher precedence, but for those
# with major_version set and version not set, continue to honor the
# major_version setting. If the package is already installed, but the pillar
# data isn't set default to looking up major_version from the package
# manager.

{% from "elasticsearch/map.jinja" import elasticsearch_map with context %}

{% set version = salt['pillar.get']('elasticsearch:version') %}
{% if version %}
  {% set major_version = version[0] | int %}
{% else %}
  {% set pillar_major_version = salt['pillar.get']('elasticsearch:major_version') %}
  {% if pillar_major_version %}
    {% set major_version = pillar_major_version %}
  {% else %}
    {% set pkg_version = salt['pkg.version'](elasticsearch_map.pkg) %}
    {% if pkg_version %}
      {% set major_version = pkg_version[0] | int %}
    {% else %}
      {% set major_version = False %}
    {% endif %}
  {% endif %}
{% endif %}

{% set elasticsearch = {} %}
{% do elasticsearch.update( { 
                              'version': version,
                              'major_version': major_version,
                            } ) %}
