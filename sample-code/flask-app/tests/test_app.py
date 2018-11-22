import pytest
import flask

from app.app import app

def test_img_result():
    with app.test_client() as c:
        rv = c.get('/')
        assert b'img.buzzfeed.com' in rv.data

def test_return_ok():
    with app.test_client() as c:
        rv = c.get('/')
        assert 200 == rv.status_code

def test_no_dogs():
    with app.test_client() as c:
        rv = c.get('/dogs')
        assert 200 == rv.status_code
