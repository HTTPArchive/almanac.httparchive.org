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
pip install -r src/requirements.txt
```

3. Run the application:

```
python src/main.py
```

4. In your web browser, enter the following address: http://127.0.0.1:8080