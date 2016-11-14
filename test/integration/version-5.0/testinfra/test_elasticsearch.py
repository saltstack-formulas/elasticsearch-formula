import testinfra


def test_package_in_installed(Package):
    elasticsearch = Package('elasticsearch')
    assert elasticsearch.is_installed
    assert elasticsearch.version.startswith('5.0')

def test_service_is_running_and_enabled(Service):
    elasticsearch = Service('elasticsearch')
    assert elasticsearch.is_running
    assert elasticsearch.is_enabled
