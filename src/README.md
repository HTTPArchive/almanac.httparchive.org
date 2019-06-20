## Run Locally

[Source](https://cloud.google.com/appengine/docs/flexible/python/quickstart)

1. If you don't have virtualenv, install it using pip.

```
sudo pip install virtualenv
```

2. Create an isolated Python environment, and install dependencies:

```
virtualenv env
source env/bin/activate
pip install -r requirements.txt
```

3. Run the application:

```
python main.py
```

4. In your web browser, enter the following address: http://127.0.0.1:8080


5. Run the tests:

If you want to run all the tests, use [pytest](https://docs.pytest.org/en/latest/):

```
pytest
```


If you want to have the tests continue running (for example, while writing new tests), use [pytest-watch](https://pypi.org/project/pytest-watch/):

```
ptw
```