import testinfra


def test_service_is_running_and_enabled(Service):
    elasticsearch = Service('elasticsearch')
    assert elasticsearch.is_running
    assert elasticsearch.is_enabled
