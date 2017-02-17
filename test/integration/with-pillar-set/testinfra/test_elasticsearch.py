import testinfra


def test_python_plugin_is_installed(File):
    assert File('/usr/share/elasticsearch/plugins/lang-python').is_directory

def test_service_is_running_and_enabled(Service):
    elasticsearch = Service('elasticsearch')
    assert elasticsearch.is_running
    assert elasticsearch.is_enabled
