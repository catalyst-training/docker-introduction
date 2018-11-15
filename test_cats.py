import pytest


@pytest.fixture
def client():
    flaskr.app.config['TESTING'] = True
    client = flaskr.app.test_client()
    yield client


def test_cat_url_in_request(client):
    rv = client.get('/')
    assert b'anigif' in rv.data
