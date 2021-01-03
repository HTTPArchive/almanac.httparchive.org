from server import app, talisman
import pytest


# Create test client without https redirect
# (normally taken care of by running in debug)
@pytest.fixture
def client():
    with app.test_client() as client:
        talisman.force_https = False
        yield client


# Add a function to test routes with optional location
def assert_route(client, path, status):
    response = client.get(path)
    assert response.status_code == status


def test_render_404_chapter(client):
    assert_route(client, '/en/2019/random', 404)


def test_render_404_year(client):
    assert_route(client, '/en/2018/', 404)


def test_render_404_static(client):
    assert_route(client, '/static/random', 404)


def test_render_404_static2(client):
    assert_route(client, '/static/random/', 404)


def test_render_404_accessibility_statement(client):
    assert_route(client, '/random/accessibility-statement', 404)
