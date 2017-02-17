import testinfra


def test_python_plugin_is_installed(File):
    assert File('/usr/share/elasticsearch/plugins/lang-python').is_directory

def test_package_in_installed(Package):
    elasticsearch = Package('elasticsearch')
    assert elasticsearch.is_installed
    assert elasticsearch.version.startswith('5')

def test_service_is_running_and_enabled(Service):
    elasticsearch = Service('elasticsearch')
    assert elasticsearch.is_running
    assert elasticsearch.is_enabled

def test_jvm_opts(File):
    assert File('/etc/elasticsearch/jvm.options').contains('# Test String')
